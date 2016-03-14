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

@protocol CKCalendarDelegate;

@interface CKCalendarView : UIView

enum {
    startSunday = 1,
    startMonday = 2,
};
typedef int startDay;

#define DidPressBackBtnSuccess @"DidPressBackBtnSuccess"
#define DidSelectedDateSuccess @"DidSelectedDateSuccess"

@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, weak) id<CKCalendarDelegate> delegate;
@property(nonatomic, strong) UIView *calendarContainer;
@property (nonatomic, strong)UIButton *backToNowbtn;
@property (nonatomic, strong)NSArray *rateArray;

- (id)initWithStartDay:(startDay)firstDay;
- (id)initWithStartDay:(startDay)firstDay frame:(CGRect)frame rateArray:(NSArray *)rateArray;

// Theming
- (void)setTitleFont:(UIFont *)font;
- (UIFont *)titleFont;

- (void)setTitleColor:(UIColor *)color;
- (UIColor *)titleColor;

- (void)setButtonColor:(UIColor *)color;

- (void)setInnerBorderColor:(UIColor *)color;

- (void)setDayOfWeekFont:(UIFont *)font;
- (UIFont *)dayOfWeekFont;

- (void)setDayOfWeekTextColor:(UIColor *)color;
- (UIColor *)dayOfWeekTextColor;

- (void)setDayOfWeekBottomColor:(UIColor *)bottomColor topColor:(UIColor *)topColor;

- (void)setDateFont:(UIFont *)font;
- (UIFont *)dateFont;

- (void)setDateTextColor:(UIColor *)color;
- (UIColor *)dateTextColor;

- (void)setDateBackgroundColor:(UIColor *)color;
- (UIColor *)dateBackgroundColor;

- (void)setDateBorderColor:(UIColor *)color;
- (UIColor *)dateBorderColor;

@property (nonatomic, strong) UIColor *selectedDateTextColor;
@property (nonatomic, strong) UIColor *selectedDateBackgroundColor;
@property (nonatomic, strong) UIColor *currentDateTextColor;
@property (nonatomic, strong) UIColor *currentDateBackgroundColor;
@property (nonatomic, assign) float width;
@property (nonatomic, strong) CAShapeLayer *arcLayer;
@property (nonatomic, strong) CAShapeLayer *layer1;

@end

@protocol CKCalendarDelegate <NSObject>

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date;

@end