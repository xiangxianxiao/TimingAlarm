//
//  MyCalendar.h
//  TimingAlarm
//
//  Created by Mac on 2018/8/13.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReturnValueBlock) (NSString *strValue);
typedef void (^ReturnTitleValueBlock) (NSString *strValue);

@interface MyCalendar : UICollectionView

/**
 *  声明一个ReturnValueBlock属性，这个Block是获取传值的界面传进来的
 */
@property(nonatomic, copy) ReturnValueBlock returnValueBlock; //  底部显示选中 name
@property(nonatomic, copy) ReturnTitleValueBlock returnTitleValueBlock; // title name

@property (nonatomic, assign)NSInteger year;
@property (nonatomic, assign)NSInteger month;
@property (nonatomic, assign)NSInteger day;
@property (nonatomic,strong)NSCalendar *calendar;

-(void)LastMonthClick;
-(void)NextbuttonClick;
- (void)toDayClick;

- (void)initDataSource; // 初始化

// 刷新月份
- (void)refreshMonth:(NSInteger)year AndMonth:(NSInteger)month AndDay:(NSInteger)day;
- (void)selectDate:(NSString *)dayDate showStatus:(NSString *)status;
- (NSDateFormatter *)showDateFormatter;

@end
