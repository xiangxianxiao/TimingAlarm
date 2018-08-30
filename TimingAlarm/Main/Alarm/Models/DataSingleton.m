//
//  DataSingleton.m
//  TimingAlarm
//
//  Created by Mac on 2018/8/24.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "DataSingleton.h"

@interface DataSingleton()

@property(nonatomic,copy)NSString *plistPath;

@end

@implementation DataSingleton

+ (instancetype)sharedInstance{
    static DataSingleton * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.plistPath = [self getFilePath];
        self.dataArray = [self getClockListData];
        
    }
    return self;
}

- (NSString *)getFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *chchePath = [paths objectAtIndex:0];
    NSString *plistPath = [chchePath stringByAppendingPathComponent:@"ClockList.plist"];
    return plistPath;
}

- (NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSArray alloc] init];
    }
    return _dataArray;
}

//获取数据并转换成model返回
-(NSArray *)getClockListData{
    //如果不存在这个文件，返回一个空的数组即可
    if (![[NSFileManager defaultManager] fileExistsAtPath:self.plistPath]){
        return [NSArray array];
    }else{
        
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:self.plistPath];
        
        NSArray *dataArr = dict[@"data"];
        //如果dataArr不为空说明数据存在，那么处理数据，如果不存在，则返回空的数组
        if (dataArr.count != 0) {
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dic in dataArr) {
                DataModel *clockModel = [[DataModel alloc]init];
                [clockModel setValuesForKeysWithDictionary:dic];
                [array addObject:clockModel];
            }
            return [array copy];
        }else{
            return [NSArray array];
        }
    }
}

//添加数据
-(void)insertClockListData:(DataModel *)clockModel{
    NSDictionary *plistDic = [[NSDictionary alloc] initWithContentsOfFile:self.plistPath];
    //如果为空说明没有plist文件，这里要先创建文件
    if (plistDic == nil){
        plistDic = [[NSDictionary alloc] initWithObjects:@[[NSMutableArray array]] forKeys:@[@"data"]];
    }
    
    [[plistDic objectForKey:@"data"] insertObject:[self setValueWithMdoel:clockModel] atIndex:self.dataArray.count];
    
    NSError *error = nil;
    NSData *plistData = [NSPropertyListSerialization dataWithPropertyList:plistDic format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
    NSLog(@"%@",error);
    if(plistData){
        [plistData writeToFile:self.plistPath atomically:YES];
        NSLog(@"Data saved sucessfully");
        self.dataArray = [self getClockListData];
        
        [self updateClockDataArray];
    }
    else{
        NSLog(@"Data not saved");
    }
}
//删除数据
-(void)removeClockListData:(NSInteger)row{
    NSDictionary *plistDic = [[NSDictionary alloc] initWithContentsOfFile:self.plistPath];
    
    [[plistDic objectForKey:@"data"] removeObjectAtIndex:row];
    
    NSError *error = nil;
    NSData *plistData = [NSPropertyListSerialization dataWithPropertyList:plistDic format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
    NSLog(@"%@",error);
    if(plistData){
        [plistData writeToFile:self.plistPath atomically:YES];
        NSLog(@"Data saved sucessfully");
        self.dataArray = [self getClockListData];
        
        [self updateClockDataArray];
    }
    else{
        NSLog(@"Data not saved");
    }
}
//更新数据
-(void)updateClockListDataWithRow:(NSInteger)index andModel:(DataModel *)clockModel{
    
    NSDictionary *plistDic = [[NSDictionary alloc] initWithContentsOfFile:self.plistPath];
    
    [[plistDic objectForKey:@"data"] removeObjectAtIndex:index];
    
    [[plistDic objectForKey:@"data"] insertObject:[self setValueWithMdoel:clockModel] atIndex:index];
    
    NSError *error = nil;
    NSData *plistData = [NSPropertyListSerialization dataWithPropertyList:plistDic format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
    NSLog(@"%@",error);
    if(plistData){
        [plistData writeToFile:self.plistPath atomically:YES];
        NSLog(@"Data saved sucessfully");
        self.dataArray = [self getClockListData];
        
        [self updateClockDataArray];
    }
    else{
        NSLog(@"Data not saved");
    }
}

//model转Dic处理
-(NSMutableDictionary *)setValueWithMdoel:(DataModel *)clockModel{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:clockModel.dataTime forKey:@"dataTime"];
    [dic setObject:clockModel.dataName forKey:@"dataName"];
    [dic setObject:clockModel.dataCycle forKey:@"dataCycle"];
    [dic setObject:clockModel.dataSleep forKey:@"dataSleep"];
    [dic setObject:clockModel.dataMusic forKey:@"dataMusic"];
    [dic setObject:clockModel.dataSwitch forKey:@"dataSwitch"];
    return dic;
}

-(void)updateClockDataArray{
    NSDate * date  = [NSDate date];
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 指定日历的算法 NSCalendarIdentifierGregorian,NSGregorianCalendar
    // NSDateComponent 可以获得日期的详细信息，即日期的组成
    NSDateComponents *comps = [calendar components: NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    
    NSMutableArray *modelArray = [NSMutableArray array];
    for (int i = 0;i < self.dataArray.count; i++) {
        DataModel *model = self.dataArray[i];
        
    }
//    [ClockSingleton sharedInstance].dataArray = [modelArray copy];
}


@end
