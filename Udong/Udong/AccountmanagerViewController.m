//
//  AccountmanagerViewController.m
//  Udong
//
//  Created by wildyao on 15/11/30.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "AccountmanagerViewController.h"
#import "MobileBlindViewController.h"
#import "BlindVertifyViewController.h"
#import "HeadImageCell.h"
#import "HeadLabelCell.h"
#import "EditNameView.h"
#import "GTMBase64.h"
#define Identifier_accountMangerHeadCell @"accountMangerHeadCell"
#define Identifier_accountMangerLabelCell @"accountMangerLabelCell"

@interface AccountmanagerViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIAlertViewDelegate,UIActionSheetDelegate>
{
    NSInteger currentselectedRow;
    NSInteger currentselectedRowInComponentOne;
}

@end

@implementation AccountmanagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNav];
    [self configView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self conFigData];

}

- (void)configView
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidchangeNickNameSuccess:) name:DidFinishedChangeNickNameNotification object:nil];
    
    
    self.view.backgroundColor = kColorWhiteColor;

    self.AccountTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250) style:UITableViewStylePlain];
    self.AccountTableView.delegate = self;
    self.AccountTableView.dataSource = self;
    self.AccountTableView.rowHeight = 44;
    self.AccountTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.AccountTableView registerNib:[UINib nibWithNibName:@"HeadImageCell" bundle:nil] forCellReuseIdentifier:Identifier_accountMangerHeadCell];
    [self.AccountTableView registerNib:[UINib nibWithNibName:@"HeadLabelCell" bundle:nil] forCellReuseIdentifier:Identifier_accountMangerLabelCell];
    [self.view addSubview:self.AccountTableView];
    

}

- (void)conFigData
{
    
    [APIServiceManager GetAccountMessageWithKey:[StorageManager getSecretKey] idString:[StorageManager getUserId] status:@"1" completionBlock:^(id responObject) {
    
        self.detailArray = [[NSMutableArray alloc]init];
        id aa = responObject[@"result"][@"url"];
        id bb = responObject[@"result"][@"nick_name"];
        id cc = responObject[@"result"][@"province_city"];
        id dd = responObject[@"result"][@"mobile"];
        if ([aa class]==[NSNull class]) {
            UIImage *defaultImage = ImageNamed(@"avatar_gender_boy");
            [self.detailArray addObject:defaultImage];
        }else{
            NSString *urlString = responObject[@"result"][@"url"];
            UIImage *Image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Picture_Url,urlString]]]];
            if (Image == nil) {
                Image = ImageNamed(@"avatar_gender_boy");
            }
            [self.detailArray addObject:Image];
        }

        if ([bb class]==[NSNull class]) {
            NSString *nullString = @"游客";
            [self.detailArray addObject:nullString];
        }else
        {
            [self.detailArray addObject:responObject[@"result"][@"nick_name"]];
        }
        
        if ([cc class]==[NSNull class]) {
            NSString *nullString = @"请选择";
            [self.detailArray addObject:nullString];
        }else
        {
            [self.detailArray addObject:responObject[@"result"][@"province_city"]];
        }
        
        if ([dd class]==[NSNull class]) {
            NSString *nullString = @"未绑定";
            [self.detailArray addObject:nullString];
        }else
        {
            [self.detailArray addObject:responObject[@"result"][@"mobile"]];
        }
        
        self.labelArray = [[NSMutableArray alloc] initWithObjects:@"头像",@"昵称",@"所在地",@"绑定手机", nil];
        
        [self.AccountTableView reloadData];
        
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
}

- (void)configNav
{
    self.navigationController.navigationBar.shadowImage = nil;
    
    self.navigationItem.title = @"帐号管理";
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSFontAttributeName : FONT(18),
                                                                    
                                                                    UITextAttributeTextColor : kColorBlackColor,
                                                                    UITextAttributeTextShadowColor : kColorClearColor,
                                                                    };

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 20, 20)];
    [btn setBackgroundImage:ImageNamed(@"navbar_icon_back") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

#pragma mark - UITableView DataSource And Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 50;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        HeadImageCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier_accountMangerHeadCell forIndexPath:indexPath];
        cell.headLabel.textColor = kColorCellTextColor;
        cell.headLabel.text = self.labelArray[indexPath.row];
        cell.headimage.image = self.detailArray[indexPath.row];
        return cell;
    }else
    {
        HeadLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier_accountMangerLabelCell forIndexPath:indexPath];
        cell.titleLabel.textColor = kColorCellTextColor;
        cell.detailLabel.textColor = kColorCellTextColor;
        cell.titleLabel.text = self.labelArray[indexPath.row];
        cell.detailLabel.text = self.detailArray[indexPath.row];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"用户相册", nil];
        [actionSheet showInView:self.view];
        
    }
    
    if (indexPath.row == 1) {
        
        EditNameView *view = [[EditNameView alloc] initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT) andContainerView:[[UIView alloc] init]];
        [view show];
        [self.view addSubview:view];
        
        [self conFigData];

    }
    
    if (indexPath.row == 2) {
        
        id filepathProvince = [[NSBundle mainBundle] pathForResource:@"province" ofType:@"txt"];
        NSString *homeDir = NSHomeDirectory();
        NSString *strProvince = [[NSString alloc] initWithContentsOfFile:filepathProvince encoding:NSUTF8StringEncoding error:nil];
        NSData *dataProvince = [strProvince dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dicProvince = [NSJSONSerialization JSONObjectWithData:dataProvince options:NSJSONReadingMutableContainers error:nil];
        self.provinceArray = [[NSArray alloc] init];
        self.provinceArray = dicProvince[@"province"];
        
        
        id filepathCity = [[NSBundle mainBundle] pathForResource:@"city(1)" ofType:@"txt"];
        NSString *strcity = [[NSString alloc] initWithContentsOfFile:filepathCity encoding:NSUTF8StringEncoding error:nil];
        NSData *dataCity = [strcity dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dicCity = [NSJSONSerialization JSONObjectWithData:dataCity options:NSJSONReadingMutableContainers error:nil];
        self.cityDictionary = [[NSDictionary alloc] init];
        self.cityDictionary = dicCity;
        
        
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.contentView.backgroundColor = kColorBlackColor;
        self.contentView.alpha = 0.6;
        
        self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.height-150, SCREEN_WIDTH, 150)];
        self.pickView.backgroundColor = kColorWhiteColor;
        self.pickView.delegate = self;
        self.pickView.dataSource = self;
        [self.contentView addSubview:self.pickView];
        
        self.pickViewView = [[UIView alloc] initWithFrame:CGRectMake(0, self.pickView.top-40, SCREEN_WIDTH, 40)];
        self.pickViewView.backgroundColor = kColorWhiteColor;
        
        UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        detailBtn.frame = CGRectMake(20,0, 40, 40);
        [detailBtn setTitle:@"取消" forState:UIControlStateNormal];
        [detailBtn setTitleColor:kColorBtnColor forState:UIControlStateNormal];
        [detailBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.pickViewView addSubview:detailBtn];
        
        UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        confirmBtn.frame = CGRectMake(SCREEN_WIDTH-60, 0, 40, 40);
        [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [confirmBtn setTitleColor:kColorBtnColor forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(changeProvinceAndCity:) forControlEvents:UIControlEventTouchUpInside];
        [self.pickViewView addSubview:confirmBtn];
        
        [self.contentView addSubview:self.pickViewView];
        
        [self.view addSubview:self.contentView];

    }
    
    if (indexPath.row == 3) {
        
        if ([self.detailArray[3] isEqualToString:@"未绑定"]) {
            BlindVertifyViewController *BlindVC = [[BlindVertifyViewController alloc] init];
            [self.navigationController pushViewController:BlindVC animated:YES];
        }else{
            MobileBlindViewController *MobileBVC = [[MobileBlindViewController alloc] init];
            MobileBVC.phoneString = self.detailArray[3];
            [self.navigationController pushViewController:MobileBVC animated:YES];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
}

#pragma mark - UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if (buttonIndex == 0) {
        // 拍照
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamera) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"该设备没有安装摄像头"preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
            
            [self presentViewController:alertController animated:true completion:nil];
            return;
        }
        sourceType = UIImagePickerControllerSourceTypeCamera;
        
    } else if (buttonIndex == 1) {
        // 用户相册
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            UIImagePickerController *pickController = [[UIImagePickerController alloc]init];
            
            pickController.delegate = self;
            pickController.allowsEditing = YES;
            [self presentViewController:pickController animated:YES
                             completion:nil];
            
        }
    } else if (buttonIndex == 2) {
        // 取消
        return;
    }
    
    [self getMediaFromSource:sourceType];

}

- (void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType] && [mediaTypes count] > 0) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
//        picker.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
        [self presentViewController:picker animated:YES completion:nil];
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error accessing media" message:@"Device doesn't support that media source" delegate:nil cancelButtonTitle:@"Drat!" otherButtonTitles:nil, nil];
        [alert show];
    }
}

#pragma mark - UIPickView Datasource And Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.provinceArray.count;
        
    }
        currentselectedRow = [pickerView selectedRowInComponent:0];
        NSDictionary *dicc = self.provinceArray[currentselectedRow];
        NSString *IDString = dicc[@"id"];
        self.selectedCityArray = self.cityDictionary[[NSString stringWithFormat:@"%@",IDString]];
        return self.selectedCityArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        NSDictionary *dic = self.provinceArray[row];
        NSString *str = dic[@"u_name"];
        return str;
    }

        NSDictionary *diccc = self.selectedCityArray[row];
        NSString *titleString = diccc[@"u_name"];
        return titleString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component==0)
    {
    [pickerView reloadComponent:1];
    [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    
}

#pragma mark - imagePicker

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    NSData *data = [self resetSizeOfImageData:image maxSize:10];
    
    NSString *sting = [GTMBase64 stringByEncodingData:data];

    [APIServiceManager SendHeadImageWithKey:[StorageManager getSecretKey] pictureName:@"0" pictureDescription:@"ios" pictureLink:@"0" status:@"1" pictureCreateBy:@"0" userId:[StorageManager getUserId]  pictureUpdateBy:@"0" file:sting completionBlock:^(id responObject) {
        
        if ([responObject[@"flag"] isEqualToString:@"100100"]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:didChangeHeadImageSuccess object:responObject[@"httpUrl"]];
            
            [picker dismissViewControllerAnimated:YES completion:nil];
        }
        
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize
{
    //先调整分辨率
    CGSize newSize = CGSizeMake(source_image.size.width, source_image.size.height);
    
    CGFloat tempHeight = newSize.height / 1024;
    CGFloat tempWidth = newSize.width / 1024;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(source_image.size.width / tempWidth, source_image.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(source_image.size.width / tempHeight, source_image.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [source_image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    NSUInteger sizeOrigin = [imageData length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    if (sizeOriginKB > maxSize) {
        NSData *finallImageData = UIImageJPEGRepresentation(newImage,0.50);
        return finallImageData;
    }
    
    return imageData;
   
}

#pragma mark - DidFinishedChangeNickNameNotification,修改昵称成功

- (void)DidchangeNickNameSuccess:(NSNotification *)notification
{
    [self conFigData];
}

- (void)onBtnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (void)cancelBtn:(UIButton *)btn
{
    self.contentView.hidden = YES;
}

- (void)changeProvinceAndCity:(UIButton *)btn
{
    currentselectedRow = [self.pickView selectedRowInComponent:0];
    currentselectedRowInComponentOne = [self.pickView selectedRowInComponent:1];
    NSString *provinceId = self.provinceArray[currentselectedRow][@"id"];
    NSString *provinceName = self.provinceArray[currentselectedRow][@"u_name"];
    NSArray *selectedCityArray = self.cityDictionary[[NSString stringWithFormat:@"%@",provinceId]];
    
    if (selectedCityArray.count == 0) {
         self.cityId = @"0";
         self.cityName = @"0";
    }else{
        self.cityId = selectedCityArray[currentselectedRowInComponentOne][@"id"];
        self.cityName = selectedCityArray[currentselectedRowInComponentOne][@"u_name"];
    }
    
    NSLog(@"%@",[StorageManager getAccountNumber]);
    
    [APIServiceManager ModifiyAccountLocationWithKey:[StorageManager getSecretKey] phoneNumber:[StorageManager getAccountNumber] status:@"1" nickName:@"0" idString:[StorageManager getUserId] ProvinceId:provinceId ProvinceName:provinceName cityId:self.cityId cityName:self.cityName headImageUrl:@"0" create:@"0" update:@"0" note:@"0" completionBlock:^(id responObject) {
        if ([responObject[@"flag"] isEqualToString:@"100100"]) {
            self.contentView.hidden = YES;
            [self conFigData];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
