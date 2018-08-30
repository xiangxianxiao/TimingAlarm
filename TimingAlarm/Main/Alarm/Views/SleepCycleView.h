//
//  SleepCycleView.h
//  TimingAlarm
//
//  Created by Mac on 2018/8/21.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BlockPickerDataRow)(NSString *rowData);

@interface SleepCycleView : UIView

@property (nonatomic, copy) BlockPickerDataRow blockPickerRow;

+ (instancetype)alterView;

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIView *buttonView;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerData;


@end
