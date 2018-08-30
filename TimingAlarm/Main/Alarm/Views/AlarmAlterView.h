//
//  AlarmAlterView.h
//  TimingAlarm
//
//  Created by Mac on 2018/8/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BlockAlarm)(NSString *string, NSMutableArray *array);

@interface AlarmAlterView : UIView

@property (nonatomic, copy) BlockAlarm blockAlarm;

+ (instancetype)alterView;

@property (nonatomic, strong) NSMutableArray *arrayData;

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIView *buttonView;


@end
