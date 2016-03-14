//
// Copyright (c) 2012 Jason Kozemczak
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
// documentation files (the "Software"), to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
// and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
// THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
// ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//


#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import "CKCalendarView.h"

#define BUTTON_MARGIN SCREEN_WIDTH/3.5
#define CALENDAR_MARGIN 5
#define TOP_HEIGHT 44
#define DAYS_HEADER_HEIGHT 22
#define DEFAULT_CELL_WIDTH 43
#define CELL_BORDER_WIDTH 1

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@class CALayer;
@class CAGradientLayer;

@interface GradientView : UIView

@property(nonatomic, strong, readonly) CAGradientLayer *gradientLayer;
- (void)setColors:(NSArray *)colors;

@end

@implementation GradientView

- (id)init {
    return [self initWithFrame:CGRectZero];
}

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (CAGradientLayer *)gradientLayer {
    return (CAGradientLayer *)self.layer;
}

- (void)setColors:(NSArray *)colors {
    NSMutableArray *cgColors = [NSMutableArray array];
    for (UIColor *color in colors) {
        [cgColors addObject:(__bridge id)color.CGColor];
    }
    self.gradientLayer.colors = cgColors;
}

@end


@interface DateButton : UIButton

@property (nonatomic, strong) NSDate *date;

@end

@implementation DateButton

@synthesize date = _date;

- (void)setDate:(NSDate *)aDate {
    _date = aDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"d";
    [self setTitle:[dateFormatter stringFromDate:_date] forState:UIControlStateNormal];
}

@end


@interface CKCalendarView ()

@property(nonatomic, strong) UIView *highlight;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIButton *prevButton;
@property(nonatomic, strong) UIButton *nextButton;
@property(nonatomic, strong) GradientView *daysHeader;
@property(nonatomic, strong) NSArray *dayOfWeekLabels;
@property(nonatomic, strong) NSMutableArray *dateButtons;

@property (nonatomic) startDay calendarStartDay;
@property (nonatomic, strong) NSDate *monthShowing;
@property (nonatomic, strong) NSCalendar *calendar;
@property(nonatomic, assign) CGFloat cellWidth;


@end

@implementation CKCalendarView

@synthesize highlight = _highlight;
@synthesize titleLabel = _titleLabel;
@synthesize prevButton = _prevButton;
@synthesize nextButton = _nextButton;
@synthesize calendarContainer = _calendarContainer;
@synthesize daysHeader = _daysHeader;
@synthesize dayOfWeekLabels = _dayOfWeekLabels;
@synthesize dateButtons = _dateButtons;

@synthesize monthShowing = _monthShowing;
@synthesize calendar = _calendar;

@synthesize selectedDate = _selectedDate;
@synthesize delegate = _delegate;

@synthesize selectedDateTextColor = _selectedDateTextColor;
@synthesize selectedDateBackgroundColor = _selectedDateBackgroundColor;
@synthesize currentDateTextColor = _currentDateTextColor;
@synthesize currentDateBackgroundColor = _currentDateBackgroundColor;
@synthesize cellWidth = _cellWidth;

@synthesize calendarStartDay;

- (id)init {
    return [self initWithStartDay:startSunday];
}

- (id)initWithStartDay:(startDay)firstDay {
    self.calendarStartDay = firstDay;
    return [self initWithFrame:CGRectMake(0, 0, 320, 320)];
}

- (id)initWithStartDay:(startDay)firstDay frame:(CGRect)frame rateArray:(NSArray *)rateArray{
    self.calendarStartDay = firstDay;
    self.rateArray = rateArray;
    return [self initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        [self.calendar setLocale:[NSLocale currentLocale]]; 
        [self.calendar setFirstWeekday:self.calendarStartDay];
        self.cellWidth = DEFAULT_CELL_WIDTH;
        
//        self.layer.cornerRadius = 6.0f;
        self.layer.shadowOffset = CGSizeMake(2, 2);
        self.layer.shadowRadius = 2.0f;
        self.layer.shadowOpacity = 0.4f;
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.layer.borderWidth = 1.0f;

        UIView *highlight = [[UIView alloc] initWithFrame:CGRectZero];
        highlight.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
        highlight.layer.cornerRadius = 6.0f;
        [self addSubview:highlight];
        self.highlight = highlight;

        // SET UP THE HEADER
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.textAlignment = UITextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;

        UIButton *prevButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [prevButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
        prevButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
        [prevButton addTarget:self action:@selector(moveCalendarToPreviousMonth) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:prevButton];
        self.prevButton = prevButton;

        UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [nextButton setImage:[UIImage imageNamed:@"icon_next"] forState:UIControlStateNormal];
        nextButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
        [nextButton addTarget:self action:@selector(moveCalendarToNextMonth) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:nextButton];
        self.nextButton = nextButton;

        // THE CALENDAR ITSELF
        UIView *calendarContainer = [[UIView alloc] initWithFrame:CGRectZero];
        calendarContainer.layer.borderWidth = 1.0f;
        calendarContainer.layer.borderColor = [UIColor whiteColor].CGColor;
        calendarContainer.backgroundColor = [UIColor blackColor]
        ;
        calendarContainer.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        calendarContainer.layer.cornerRadius = 4.0f;
        calendarContainer.clipsToBounds = YES;
        [self addSubview:calendarContainer];
        self.calendarContainer = calendarContainer;

        GradientView *daysHeader = [[GradientView alloc] initWithFrame:CGRectZero];
        daysHeader.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        [self.calendarContainer addSubview:daysHeader];
        self.daysHeader = daysHeader;

        NSMutableArray *labels = [NSMutableArray array];
        for (NSString *day in [self getDaysOfTheWeek]) {
            UILabel *dayOfWeekLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            dayOfWeekLabel.text = [day uppercaseString];
            dayOfWeekLabel.textAlignment = UITextAlignmentCenter;
            dayOfWeekLabel.backgroundColor = [UIColor whiteColor];
            dayOfWeekLabel.shadowColor = [UIColor whiteColor];
            dayOfWeekLabel.shadowOffset = CGSizeMake(0, 1);
            dayOfWeekLabel.textColor = kColorContentColor;
            [labels addObject:dayOfWeekLabel];
            [self.calendarContainer addSubview:dayOfWeekLabel];
        }
        self.dayOfWeekLabels = labels;

        // at most we'll need 42 buttons, so let's just bite the bullet and make them now...
        NSMutableArray *dateButtons = [NSMutableArray array];
        dateButtons = [NSMutableArray array];
        for (int i = 0; i < 31; i++) {
            DateButton *dateButton = [DateButton buttonWithType:UIButtonTypeCustom];
            dateButton.layer.cornerRadius = dateButton.width/2;
            dateButton.layer.masksToBounds = YES;
            
            [dateButton setTitle:[NSString stringWithFormat:@"%d", i] forState:UIControlStateNormal];
            [dateButton addTarget:self action:@selector(dateButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [dateButtons addObject:dateButton];
        }
        self.dateButtons = dateButtons;

        // initialize the thing
        self.monthShowing = [NSDate date];
        [self setDefaultStyle];
        
        self.backToNowbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.backToNowbtn.frame = CGRectZero;
        [self.backToNowbtn setTitle:@"回到今天" forState:UIControlStateNormal];
        [self.backToNowbtn setTitleColor:UIColorFromHex(0xFF7E00) forState:UIControlStateNormal];
        [self.backToNowbtn addTarget:self action:@selector(backToNow:) forControlEvents:UIControlEventTouchUpInside];
        [self.backToNowbtn setBackgroundColor:UIColorFromHex(0xF0F0F0)];
        [self addSubview:self.backToNowbtn];
        
        self.backToNowbtn = self.backToNowbtn;
        
    }

    [self layoutSubviews]; // TODO: this is a hack to get the first month to show properly
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    NSArray *layerArray = self.calendarContainer.layer.sublayers;
    for (int i=0; i<layerArray.count; i++) {
        id layer = layerArray[i];
        if ([layer isKindOfClass:[CAShapeLayer class]]) {
            [layer removeFromSuperlayer];
        }
    }
    
    CGFloat containerWidth = self.bounds.size.width - (CALENDAR_MARGIN * 2);
    self.cellWidth = (containerWidth / 7.0) - 10;

    CGFloat containerHeight = ([self numberOfWeeksInMonthContainingDate:self.monthShowing] * (self.cellWidth +10) + DAYS_HEADER_HEIGHT);
    

    CGRect newFrame = self.frame;
    newFrame.size.height = containerHeight + CALENDAR_MARGIN + TOP_HEIGHT;
    self.frame = newFrame;

    self.highlight.frame = CGRectMake(1, 1, self.bounds.size.width - 2, 1);

    self.titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width, TOP_HEIGHT);
    self.prevButton.frame = CGRectMake(BUTTON_MARGIN, 4, 48, 38);
    
    self.nextButton.frame = CGRectMake(self.bounds.size.width - 48 - BUTTON_MARGIN, 4, 48, 38);
    
    self.backToNowbtn.frame = CGRectMake(0, containerHeight+ CALENDAR_MARGIN + TOP_HEIGHT, self.size.width, 60);

    self.calendarContainer.frame = CGRectMake(CALENDAR_MARGIN, CGRectGetMaxY(self.titleLabel.frame), containerWidth, containerHeight);
    self.daysHeader.frame = CGRectMake(0, 0, self.calendarContainer.frame.size.width, DAYS_HEADER_HEIGHT);
    self.calendarContainer.backgroundColor = kColorWhiteColor;
    
//  移除btn，显示新的月份
    
    for (DateButton *dateButton in self.dateButtons) {
        [dateButton removeFromSuperview];
        
//  点击下个月或上个月的btn时，要把当月的日期button都移除掉，并且把button的layer从父layer中移除掉，不然会造成当月button的layer显示在下个月的界面上
        NSArray *layerArray1 = self.calendarContainer.layer.sublayers;
        for (int i=0; i<layerArray1.count; i++)
        {
            id layer = layerArray1[i];
            if ([layer isKindOfClass:[CAShapeLayer class]])
            {
                [layer removeFromSuperlayer];
            }
        }
    }
    
    NSDate *date = [self firstDayOfMonthContainingDate:self.monthShowing];
    uint dateButtonPosition = 0;
    
    while ([self dateIsInMonthShowing:date]) {
        
        DateButton *dateButton = [self.dateButtons objectAtIndex:dateButtonPosition];

        dateButton.date = date;
        
        dateButton.frame = [self calculateDayCellFrame:date];
        dateButton.layer.cornerRadius = dateButton.width/2;
        dateButton.layer.masksToBounds = YES;
        self.width = dateButton.width;
       
        
//   判断今天的日期和选中的日期，进行比较
        
        NSInteger aa = [date timeIntervalSince1970];
        NSDate *nowDate = [NSDate date];
        NSInteger bb = [nowDate timeIntervalSince1970];
        
        if (aa>bb) {
            dateButton.userInteractionEnabled = NO;
            dateButton.alpha = 0.2;
            [dateButton setTitleColor:[self dateTextColor] forState:UIControlStateNormal];
            
        }else{
    
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path addArcWithCenter:CGPointMake(dateButton.size.width/2, dateButton.size.width/2) radius:dateButton.size.width/2 startAngle:-M_PI/2 endAngle:3*M_PI/2 clockwise:YES];
            _layer1 = [CAShapeLayer layer];
            _layer1 .frame = dateButton.frame;
            _layer1 .path = path.CGPath;
            _layer1 .fillColor = [UIColor clearColor].CGColor;
            _layer1 .strokeColor = UIColorFromHex(0xEFEFEF).CGColor;
            _layer1 .lineWidth = 2;
            [self.calendarContainer.layer addSublayer:_layer1];
            
            
            if ([self dateIsToday:dateButton.date]) {
                dateButton.backgroundColor = self.dateBackgroundColor;
                
                [dateButton setTitleColor:UIColorFromHex(0xFFb200) forState:UIControlStateNormal];
                dateButton.userInteractionEnabled = YES;
                dateButton.alpha = 1;
                
            } else {
                dateButton.backgroundColor = [self dateBackgroundColor];
                [dateButton setTitleColor:[self dateTextColor] forState:UIControlStateNormal];
                dateButton.userInteractionEnabled = YES;
                dateButton.alpha = 1;
            }
        }
        
        [self.calendarContainer addSubview:dateButton];
        
        if (dateButton.userInteractionEnabled == YES) {
            
            NSDate *date = [dateButton.date dateByAddingTimeInterval:8*3600];
            NSString *string = [NSString stringWithFormat:@"%@",date];
            NSString *subString = [string substringWithRange:NSMakeRange(0, 10)];
            
            for (NSDictionary *dic in self.rateArray) {
                NSString *ArrayDateString = [NSString stringWithFormat:@"%@",dic[@"date"]];
                float rate = [dic[@"rate"] floatValue];
                float ratepai ;
                if (rate==0) {
                    
                   ratepai = (-M_PI/2)-2*M_PI;
                }else{
                   ratepai = 2*M_PI*rate-M_PI/2;
                }
                
                if ([subString isEqualToString:ArrayDateString]) {
                
                    UIBezierPath *path = [UIBezierPath bezierPath];
                    [path addArcWithCenter:CGPointMake(dateButton.size.width/2, dateButton.size.width/2) radius:dateButton.size.width/2 startAngle:-M_PI/2 endAngle:ratepai clockwise:YES];
                    _arcLayer = [CAShapeLayer layer];
                    _arcLayer.frame = dateButton.frame;
                    _arcLayer.path = path.CGPath;
                    _arcLayer.fillColor = [UIColor clearColor].CGColor;
                    _arcLayer.strokeColor = [UIColor orangeColor].CGColor;
                    _arcLayer.lineWidth = 2;
                    
                    [self.calendarContainer.layer addSublayer:_arcLayer];
                }
            }
        }

        date = [self nextDay:date];
        
        dateButtonPosition++;
    }
    
    CGRect lastDayFrame = CGRectZero;
    for (UILabel *dayLabel in self.dayOfWeekLabels) {
        dayLabel.frame = CGRectMake(CGRectGetMaxX(lastDayFrame) + 8.5, lastDayFrame.origin.y, self.width, self.daysHeader.frame.size.height);
        lastDayFrame = dayLabel.frame;
    }
    
}

- (void)setMonthShowing:(NSDate *)aMonthShowing {
    _monthShowing = aMonthShowing;

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM月";
    self.titleLabel.text = [dateFormatter stringFromDate:aMonthShowing];
    [self setNeedsLayout];
}

- (void)setDefaultStyle {
    self.backgroundColor = kColorWhiteColor;

    [self setTitleColor:UIColorFromHex(0x4E4E4E)];
    [self setTitleFont:[UIFont boldSystemFontOfSize:18.0]];

    [self setDayOfWeekFont:[UIFont boldSystemFontOfSize:12.0]];
    [self setDayOfWeekTextColor:kColorGrayColor];
    [self setDayOfWeekBottomColor:kColorWhiteColor topColor:[UIColor whiteColor]];

    [self setDateFont:[UIFont boldSystemFontOfSize:16.0f]];
    [self setDateTextColor:UIColorFromRGB(0x808080)];
    [self setDateBackgroundColor:kColorWhiteColor];
    [self setDateBorderColor:UIColorFromRGB(0xDAE1E6)];

    [self setSelectedDateTextColor:UIColorFromRGB(0xF2F2F2)];
    [self setSelectedDateBackgroundColor:UIColorFromRGB(0x88B6DB)];

    [self setCurrentDateTextColor:UIColorFromRGB(0xF2F2F2)];
    [self setCurrentDateBackgroundColor:[UIColor lightGrayColor]];
}

- (CGRect)calculateDayCellFrame:(NSDate *)date {
    int row = [self weekNumberInMonthForDate:date] - 1;
    int placeInWeek = (([self dayOfWeekForDate:date] - 1) - self.calendar.firstWeekday + 8) % 7;
    
    return CGRectMake(placeInWeek * (self.cellWidth + 10)+3, (row * (self.cellWidth + 10)) + CGRectGetMaxY(self.daysHeader.frame) + CELL_BORDER_WIDTH, self.cellWidth, self.cellWidth);
}

- (void)moveCalendarToNextMonth {
    
    NSDateComponents* comps = [[NSDateComponents alloc]init];
    [comps setMonth:1];
    self.monthShowing = [self.calendar dateByAddingComponents:comps toDate:self.monthShowing options:0];
}

- (void)moveCalendarToPreviousMonth {
   
    self.monthShowing = [[self firstDayOfMonthContainingDate:self.monthShowing] dateByAddingTimeInterval:-100000];
}

- (void)dateButtonPressed:(id)sender {
    DateButton *dateButton = sender;
    self.selectedDate = dateButton.date;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DidSelectedDateSuccess object:self.selectedDate];
    
    [self.delegate calendar:self didSelectDate:self.selectedDate];
    [self setNeedsLayout];
}

#pragma mark - Theming getters/setters

- (void)setTitleFont:(UIFont *)font {
    self.titleLabel.font = font;
}
- (UIFont *)titleFont {
    return self.titleLabel.font;
}

- (void)setTitleColor:(UIColor *)color {
    self.titleLabel.textColor = color;
}
- (UIColor *)titleColor {
    return self.titleLabel.textColor;
}

- (void)setButtonColor:(UIColor *)color {
    [self.prevButton setImage:[CKCalendarView imageNamed:@"navbar_icon_back" withColor:color] forState:UIControlStateNormal];
    [self.nextButton setImage:[CKCalendarView imageNamed:@"icon_more" withColor:color] forState:UIControlStateNormal];
}

- (void)setInnerBorderColor:(UIColor *)color {
    self.calendarContainer.layer.borderColor = color.CGColor;
}

- (void)setDayOfWeekFont:(UIFont *)font {
    for (UILabel *label in self.dayOfWeekLabels) {
        label.font = font;
    }
}
- (UIFont *)dayOfWeekFont {
    return (self.dayOfWeekLabels.count > 0) ? ((UILabel *)[self.dayOfWeekLabels lastObject]).font : nil;
}

- (void)setDayOfWeekTextColor:(UIColor *)color {
    for (UILabel *label in self.dayOfWeekLabels) {
        label.textColor = color;
    }
}
- (UIColor *)dayOfWeekTextColor {
    return (self.dayOfWeekLabels.count > 0) ? ((UILabel *)[self.dayOfWeekLabels lastObject]).textColor : nil;
}

- (void)setDayOfWeekBottomColor:(UIColor *)bottomColor topColor:(UIColor *)topColor {
    [self.daysHeader setColors:[NSArray arrayWithObjects:topColor, bottomColor, nil]];
}

- (void)setDateFont:(UIFont *)font {
    for (DateButton *dateButton in self.dateButtons) {
        dateButton.titleLabel.font = font;
    }
}
- (UIFont *)dateFont {
    return (self.dateButtons.count > 0) ? ((DateButton *)[self.dateButtons lastObject]).titleLabel.font : nil;
}

- (void)setDateTextColor:(UIColor *)color {
    for (DateButton *dateButton in self.dateButtons) {
        [dateButton setTitleColor:color forState:UIControlStateNormal];
    }
}
- (UIColor *)dateTextColor {
    return (self.dateButtons.count > 0) ? [((DateButton *)[self.dateButtons lastObject]) titleColorForState:UIControlStateNormal] : nil;
}

- (void)setDateBackgroundColor:(UIColor *)color {
    for (DateButton *dateButton in self.dateButtons) {
        dateButton.backgroundColor = color;
    }
}
- (UIColor *)dateBackgroundColor {
    return (self.dateButtons.count > 0) ? ((DateButton *)[self.dateButtons lastObject]).backgroundColor : nil;
}

- (void)setDateBorderColor:(UIColor *)color {
    self.calendarContainer.backgroundColor = color;
}
- (UIColor *)dateBorderColor {
    return self.calendarContainer.backgroundColor;
}

#pragma mark - Calendar helpers

- (NSDate *)firstDayOfMonthContainingDate:(NSDate *)date {
    NSDateComponents *comps = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    [comps setDay:1];
    return [self.calendar dateFromComponents:comps];
}

- (NSArray *)getDaysOfTheWeek {
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // adjust array depending on which weekday should be first
    NSArray *weekdays = [NSArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];
    
//    NSUInteger firstWeekdayIndex = [self.calendar firstWeekday] -1;
//    if (firstWeekdayIndex > 0)
//    {
//        weekdays = [[weekdays subarrayWithRange:NSMakeRange(firstWeekdayIndex, 7-firstWeekdayIndex)]
//                    arrayByAddingObjectsFromArray:[weekdays subarrayWithRange:NSMakeRange(0,firstWeekdayIndex)]];
//    }
    return weekdays;
}

- (int)dayOfWeekForDate:(NSDate *)date {
    NSDateComponents *comps = [self.calendar components:NSWeekdayCalendarUnit fromDate:date];
    return comps.weekday;
}

- (BOOL)dateIsToday:(NSDate *)date {
    NSDateComponents *otherDay = [self.calendar components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    NSDateComponents *today = [self.calendar components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    return ([today day] == [otherDay day] &&
            [today month] == [otherDay month] &&
            [today year] == [otherDay year] &&
            [today era] == [otherDay era]);
}

- (int)weekNumberInMonthForDate:(NSDate *)date {
    NSDateComponents *comps = [self.calendar components:(NSWeekOfMonthCalendarUnit) fromDate:date];
    return comps.weekOfMonth;
}

- (int)numberOfWeeksInMonthContainingDate:(NSDate *)date {
    return [self.calendar rangeOfUnit:NSWeekCalendarUnit inUnit:NSMonthCalendarUnit forDate:date].length;
}

- (BOOL)dateIsInMonthShowing:(NSDate *)date {
    NSDateComponents *comps1 = [self.calendar components:(NSMonthCalendarUnit) fromDate:self.monthShowing];
    NSDateComponents *comps2 = [self.calendar components:(NSMonthCalendarUnit) fromDate:date];
    return comps1.month == comps2.month;
}

- (NSDate *)nextDay:(NSDate *)date {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    return [self.calendar dateByAddingComponents:comps toDate:date options:0];
}

+ (UIImage *)imageNamed:(NSString *)name withColor:(UIColor *)color {
    UIImage *img = [UIImage imageNamed:name];

    UIGraphicsBeginImageContext(img.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color setFill];

    CGContextTranslateCTM(context, 0, img.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);

    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGContextDrawImage(context, rect, img.CGImage);

    CGContextClipToMask(context, rect, img.CGImage);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);

    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return coloredImg;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        CGPoint tempoint = [self.backToNowbtn convertPoint:point fromView:self];
        if (CGRectContainsPoint(self.backToNowbtn.bounds, tempoint))
        {
            view = self.backToNowbtn;
        }
    }
    return view;
}

- (void)backToNow:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:DidPressBackBtnSuccess object:nil];
}

@end