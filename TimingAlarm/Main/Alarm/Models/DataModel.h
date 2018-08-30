//
//  DataModel.h
//  TimingAlarm
//
//  Created by Mac on 2018/8/24.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

// 时间
@property (nonatomic, copy) NSString *dataTime;

// 标题
@property (nonatomic, copy) NSString *dataName;

// 周期 每天 
@property (nonatomic, copy) NSString *dataCycle;

// 间隔几分钟响一次
@property (nonatomic, copy) NSString *dataSleep;

// 音乐
@property (nonatomic, copy) NSString *dataMusic;

// 开关
@property (nonatomic, copy) NSString *dataSwitch;


@end
