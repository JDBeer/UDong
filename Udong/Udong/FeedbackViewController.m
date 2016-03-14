//
//  FeedbackViewController.m
//  Udong
//
//  Created by wildyao on 15/12/11.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "FeedbackViewController.h"
#import "SelfBubbleCell.h"
#import "OtherBubbleCell.h"
#import "FeedbackMessageModel.h"
#import "UIImageView+WebCache.h"

#define Identifier_SelfBubbleCell @"SelfBubbleCell"
#define Identifier_OtherBubbleCell @"OtherBubbleCell"
#define Identifier_MainTableViewCell @"MainTableViewCell"

@interface FeedbackViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNav];
    [self configView];
    
}

- (void)configNav
{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = kColorWhiteColor;
    self.navigationController.navigationBar.translucent = YES;
    [self configBackItem];
    self.view.backgroundColor = kColorWhiteColor;
    self.navigationItem.title = @"意见反馈";
}

- (void)configBackItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 20, 20)];
    [btn setBackgroundImage:ImageNamed(@"navbar_icon_back") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];

}

- (void)configView
{
    
    self.messageView = [[UIView alloc] initWithFrame:CGRectMake(0,self.view.height-44, SCREEN_WIDTH, 44)];
    self.messageView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
    self.messageView.autoresizesSubviews = NO;
    [self.view addSubview:self.messageView];
    
    self.pictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.pictureBtn.frame = CGRectMake(10, 10, 20, 20);
    [self.pictureBtn setBackgroundImage:ImageNamed(@"login_icon_telephone") forState:UIControlStateNormal];
    [self.messageView addSubview:self.pictureBtn];
    

    self.messageTf = [[UITextField alloc] initWithFrame:CGRectMake(self.pictureBtn.right+10, self.pictureBtn.top-5, self.view.width-100, 34)];
    self.messageTf.clearButtonMode = UITextFieldViewModeNever;
    self.messageTf.delegate = self;
    self.messageTf.enablesReturnKeyAutomatically = YES;
    self.messageTf.returnKeyType = UIReturnKeySend;

    [self.messageTf setBorderStyle:UITextBorderStyleRoundedRect];
    [self.messageView addSubview:self.messageTf];
    
    
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmBtn.frame = CGRectMake(self.messageTf.right+10, 0, 40, 20);
    self.confirmBtn.centerY = self.messageTf.centerY;
    [self.confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:kColorBtnColor forState:UIControlStateNormal];
    [self.confirmBtn addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    [self.messageView addSubview:self.confirmBtn];
    
    
    self.chatTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64-44) style:UITableViewStylePlain];
    self.chatTableView.rowHeight = UITableViewAutomaticDimension;
    self.chatTableView.delegate = self;
    self.chatTableView.dataSource = self;
    self.chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.chatTableView registerNib:[UINib nibWithNibName:@"SelfBubbleCell" bundle:nil] forCellReuseIdentifier:Identifier_SelfBubbleCell];
    [self.chatTableView registerNib:[UINib nibWithNibName:@"OtherBubbleCell" bundle:nil] forCellReuseIdentifier:Identifier_OtherBubbleCell];
    
    [self.chatTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Identifier_MainTableViewCell];
    [self.view addSubview:self.chatTableView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapForTableView:)];
    
    [self.chatTableView addGestureRecognizer:tap];
    
    if (self.InfoArray.count!=0) {
        [_chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_InfoArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.InfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedbackMessageModel *Infoobj = self.InfoArray[indexPath.row];
    
    NSString *idString = [NSString stringWithFormat:@"%@",Infoobj.idSting];
    
    if ([idString isEqualToString:@"1"]) {
        OtherBubbleCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier_OtherBubbleCell forIndexPath:indexPath];
        
        cell.OtherNamelabel.text = @"客服优优";
        cell.OtherChatLabel.text = Infoobj.content;
        NSString *msg = Infoobj.content;
        
        CGSize size = [msg sizeWithAttributes:@{NSFontAttributeName:FONT(15)}];
        
        cell.OtherChatLabel.numberOfLines = 0;
        
        if ( size.width+30>170) {
            size.width = 140;
        }
        
        cell.otherBgImageViewWidth.constant = size.width+30;
        cell.OtherLabelWidth.constant = size.width;
        
        cell.OtherHeadImageView.image = ImageNamed(@"abou_logo");
        
        return cell;
    }else{
        SelfBubbleCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier_SelfBubbleCell forIndexPath:indexPath];
        
        cell.SelfChatLabel.text = Infoobj.content;
        cell.SelfNameLabel.text = Infoobj.nickname;
        NSString *msg = Infoobj.content;
        
        CGSize size = [msg sizeWithAttributes:@{NSFontAttributeName:FONT(15)}];

        cell.SelfChatLabel.numberOfLines = 0;
        
        if ( size.width+30>170) {
            size.width = 140;
        }
        cell.backImageViewWidth.constant = size.width+30;
        cell.labelWidth.constant = size.width;
    
        
        [cell.SelfheadImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Picture_Url,Infoobj.head_img_url]] placeholderImage:ImageNamed(@"avatar_default")];
        
        return cell;
    
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   FeedbackMessageModel *Infoobj = self.InfoArray[indexPath.row];
    
    NSString *msg = Infoobj.content;
    
    float height = [msg boundingRectWithSize:CGSizeMake(120, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size.height;
    
    
    float cellHeight = height+20;
    
    if (cellHeight<60) {
        return 60;
    }
    
    return cellHeight;

}

- (void)tapForTableView:(UITapGestureRecognizer *)gesture
{
    [_messageView resignFirstResponder];
    
    [self.view endEditing:YES];
    
    [UIView animateWithDuration:0.25 animations:^{
        [UIView setAnimationCurve:7];
        _messageView.frame = CGRectMake(0, self.view.height-44, self.view.width, 44);
        _chatTableView.frame = CGRectMake(0, 64, self.view.width, self.view.height-44-64);
    }];
    
}


- (void)keyboardShow:(NSNotification *)Notification
{
    //    虽然在上面的通知里面没有传参数,但是会默认含有textField移动时的数据,通过uesrInfo接受即可
    NSDictionary *dictionary = Notification.userInfo;
    
    int curve = [[dictionary objectForKey:UIKeyboardAnimationCurveUserInfoKey]intValue];
    
    float duration = [[dictionary objectForKey:UIKeyboardAnimationDurationUserInfoKey]floatValue];
    
    CGRect endFrame = [[dictionary objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    
    [UIView animateWithDuration:duration animations:^{
        [UIView setAnimationCurve:curve];
    
        self.messageView.frame = CGRectMake(0, endFrame.origin.y-44, self.view.frame.size.width, 44);
        
        self.chatTableView.frame = CGRectMake(0, 64, self.view.frame.size.width,endFrame.origin.y-44-64);
        
        if (self.InfoArray.count!=0) {
            
            [_chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_InfoArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
        
        
    }];
}

- (void)sendMessage:(UIButton *)btn
{
    if (self.messageTf.text.length == 0) {
        return;
    }
    
    [APIServiceManager SendFeedbackMessageWithKey:[StorageManager getSecretKey] fromId:[StorageManager getUserId] useId:@"1" status:@"1" content:self.messageTf.text note:self.messageTf.text tofromId:[StorageManager getUserId] toUserId:@"1" code:@"100" completionBlock:^(id responObject) {
        if ([responObject[@"flag"] isEqualToString:@"100100"]) {
            
            if (self.InfoArray.count == 0) {
                NSMutableDictionary *addDic = [[NSMutableDictionary alloc] init];
                [addDic setObject:self.messageTf.text forKey:@"content"];
                [addDic setObject:@""forKey:@"create_time"];
                [addDic setObject:[StorageManager getUserId] forKey:@"from_user_id"];
                [addDic setObject:@"" forKey:@"head_img_url"];
                [addDic setObject:@"2" forKey:@"id"];
                [addDic setObject:@"" forKey:@"move_time"];
                [addDic setObject:@"" forKey:@"nick_name"];
                [addDic setObject:@"" forKey:@"note"];
                [addDic setObject:@"1" forKey:@"status"];
                [addDic setObject:@"1" forKey:@"to_user_id"];
                
                FeedbackMessageModel *obj = [FeedbackMessageModel objectWithDictionary:addDic];
                [self.InfoArray addObject:obj];
            }else{
                
                FeedbackMessageModel *Infoobj = self.InfoArray[0];
                
                //为新增加的意见赋值，并添加进model类
                NSMutableDictionary *addDic = [[NSMutableDictionary alloc] init];
                [addDic setObject:self.messageTf.text forKey:@"content"];
                [addDic setObject:Infoobj.create_time forKey:@"create_time"];
                [addDic setObject:[StorageManager getUserId] forKey:@"from_user_id"];
                [addDic setObject:Infoobj.head_img_url forKey:@"head_img_url"];
                [addDic setObject:@"2" forKey:@"id"];
                [addDic setObject:@"" forKey:@"move_time"];
                [addDic setObject:Infoobj.nickname forKey:@"nick_name"];
                [addDic setObject:Infoobj.note forKey:@"note"];
                [addDic setObject:Infoobj.status forKey:@"status"];
                [addDic setObject:@"1" forKey:@"to_user_id"];
                
                FeedbackMessageModel *obj = [FeedbackMessageModel objectWithDictionary:addDic];
                [self.InfoArray addObject:obj];
            }
            
//            [self.InfoArray removeAllObjects];
//
//                NSArray *chatArray = responObject[@"result"];
//            
//                for (NSDictionary *chatDic in chatArray)
//                {
//                        FeedbackMessageModel *obj = [FeedbackMessageModel objectWithDictionary:chatDic];
//                        [self.InfoArray addObject:obj];
//                }
            
            [self.chatTableView reloadData];
            
            [_chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_InfoArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
            self.messageTf.text = @"";
            
            }else{
                NSLog(@"%@",responObject[@"message"]);
            }

    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    

    
}

- (void)onBtnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self sendMessage:self.confirmBtn];
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
