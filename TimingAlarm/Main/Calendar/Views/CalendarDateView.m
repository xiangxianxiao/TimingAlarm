//
//  CalendarDateView.m
//  TimingAlarm
//
//  Created by Mac on 2018/8/20.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CalendarDateView.h"

@interface CalendarDateView()

@end

@implementation CalendarDateView


+ (instancetype)alterView{
    return [[[NSBundle mainBundle] loadNibNamed:@"CalendarDateView" owner:self options:nil] lastObject];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        _topView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.85];
    }
    return self;
}

- (void)setStringDate:(NSString *)stringDate{
    _stringDate = stringDate;
    [self initPicker];
}

- (void)initPicker{

    self.datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"];//设置为中文
    self.datePicker.datePickerMode = UIDatePickerModeDate;//模式选择
    
    if ([MyDateSecurity isNilOrEmpty:self.stringDate]) {
        [self.datePicker setDate:[NSDate date]];
    }else{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];//解决8小时时间差问题
        NSDate *birthdayDate = [dateFormatter dateFromString:self.stringDate];
        [self.datePicker setDate:birthdayDate];
    }
}

- (IBAction)cancelAction:(id)sender {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";//设置时间格式
    NSString *dateStr = [formatter  stringFromDate:self.datePicker.date];
    if (self.blockSelectDate) {
        self.blockSelectDate(dateStr);
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.top = 0;
        self.topView.backgroundColor = [UIColor clearColor];
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
    });
}



@end
