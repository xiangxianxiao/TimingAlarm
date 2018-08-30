//
//  CalendarDateView.h
//  TimingAlarm
//
//  Created by Mac on 2018/8/20.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BlockSelectDate)(NSString *date);

@interface CalendarDateView : UIView

@property (nonatomic,copy) BlockSelectDate blockSelectDate;

+ (instancetype)alterView;

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIView *buttonView;


@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (nonatomic, copy) NSString *stringDate;

@end
