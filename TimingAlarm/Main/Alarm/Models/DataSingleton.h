//
//  DataSingleton.h
//  TimingAlarm
//
//  Created by Mac on 2018/8/24.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModel.h"

@interface DataSingleton : NSObject

+ (instancetype)sharedInstance;
//数据array
@property(nonatomic,strong)NSArray *dataArray;


/**
 *  添加数据
 *
 *  @param clockModel 添加的数据
 */
-(void)insertClockListData:(DataModel *)clockModel;

/**
 *  删除数据
 *
 *  @param row 删除第几行
 */
-(void)removeClockListData:(NSInteger)row;

/**
 *  更新数据
 *
 *  @param row        更新第几行
 *  @param clockModel 更新的数据
 */
-(void)updateClockListDataWithRow:(NSInteger)index andModel:(DataModel *)clockModel;

//更新clockData
-(void)updateClockDataArray;


@end
