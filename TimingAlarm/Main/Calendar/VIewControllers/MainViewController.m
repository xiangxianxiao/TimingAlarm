//
//  MainViewController.m
//  TimingAlarm
//
//  Created by Mac on 2018/8/13.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "MainViewController.h"
#import "MyCalendar.h"
#import "MyCollectionViewCell.h"
#import "AlarmViewController.h"
#import "CalendarDateView.h"

@interface MainViewController ()


@property (weak, nonatomic) IBOutlet UILabel *nowMouth; // 日历标题

@property (weak, nonatomic) IBOutlet UIView *weekView;// 周日到周六

@property (nonatomic,strong)IBOutlet MyCalendar * calendar;// 日历

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewConstHeight;// 日历高度

@property (weak, nonatomic) IBOutlet UILabel *selectDate;// 显示选中的label

@property (nonatomic, copy) NSString *selectDatePicker;
@property (nonatomic, strong) NSArray *weekArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //日历说白了就是一个CollectionView
    [self initCollectionView];

    [self initRecognizer];
    
    __weak typeof(self)weakSelf = self;
    _calendar.returnValueBlock = ^(NSString *strValue) {
        weakSelf.selectDate.text = [NSString stringWithFormat:@"公历：%@",strValue];
    };
    _calendar.returnTitleValueBlock = ^(NSString *strValue) {
        weakSelf.nowMouth.text = strValue;
    };
}

- (void)tapGestureRecognizer:(UITapGestureRecognizer *)tap{
    
    self.selectDatePicker = [NSString stringWithFormat:@"%ld-%ld-%ld",self.calendar.year,self.calendar.month,self.calendar.day];

    CalendarDateView *dateView = [CalendarDateView alterView];
    dateView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight + 400);
    dateView.stringDate = self.selectDatePicker;
    dateView.topView.backgroundColor = [UIColor clearColor];
    dateView.backgroundColor = [UIColor clearColor];
    [shareAppdelegate.window addSubview:dateView];
    
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        dateView.top = -400;
        dateView.topView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.85];
        dateView.blockSelectDate = ^(NSString *date) {
            
            weakSelf.selectDatePicker = date;
            
            NSLog(@"选中 %@",weakSelf.selectDatePicker);
            
            NSArray *arrDate = [date componentsSeparatedByString:@"-"];
            weakSelf.calendar.year = [arrDate[0] integerValue];
            weakSelf.calendar.month = [arrDate[1] integerValue];

            weakSelf.nowMouth.text = [NSString stringWithFormat:@"%ld年%ld月",weakSelf.calendar.year,weakSelf.calendar.month];

            [weakSelf.calendar refreshMonth:[arrDate[0] integerValue] AndMonth:[arrDate[1] integerValue] AndDay:[arrDate[2] integerValue]];
            [weakSelf.calendar selectDate:[NSString stringWithFormat:@"%@",date] showStatus:@"-1"];
        };
    }];
    
}

-(void)initCollectionView{
    
    [_calendar registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collectionCell"];
    [_calendar initDataSource];

    _weekArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    for (int i = 0; i < self.weekArray.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(((kScreenWidth-20)/7)*i+20, 0, (kScreenWidth-20)/7, 30)];
        label.text = self.weekArray[i];
        label.font = [UIFont fontWithName:@"Helvetica-Bold" size:(17)];
        if (i == 0 || i == self.weekArray.count - 1) {
            label.textColor = [UIColor redColor];
        }else{
            label.textColor = [UIColor whiteColor];
        }
        [self.weekView addSubview:label];
    }

    _nowMouth.text = [NSString stringWithFormat:@"%ld年%ld月",_calendar.year,_calendar.month];
    // 今天是今年的第多少周
    NSInteger week = [_calendar.calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitYear forDate:[NSDate date]];
    self.selectDate.text = [NSString stringWithFormat:@"公历：%ld年%ld月%ld日 第%ld周",(long)_calendar.year,_calendar.month,_calendar.day,week];
}

- (IBAction)NextClick:(UIButton *)sender {
    [_calendar NextbuttonClick];
    _nowMouth.text = [NSString stringWithFormat:@"%ld年%ld月",_calendar.year,_calendar.month];
    
    self.selectDatePicker = [NSString stringWithFormat:@"%ld-%ld-%ld",self.calendar.year,self.calendar.month,self.calendar.day];
    
    NSLog(@"下月 %@",self.selectDatePicker);
}

- (IBAction)LastClick:(UIButton *)sender {
    [_calendar LastMonthClick];
    _nowMouth.text = [NSString stringWithFormat:@"%ld年%ld月",_calendar.year,_calendar.month];
    
    self.selectDatePicker = [NSString stringWithFormat:@"%ld-%ld-%ld",self.calendar.year,self.calendar.month,self.calendar.day];
    
    NSLog(@"上月 %@",self.selectDatePicker);
}

// 返回今日
- (IBAction)toDayAction:(id)sender {
    [_calendar toDayClick];
    _nowMouth.text = [NSString stringWithFormat:@"%ld年%ld月",_calendar.year,_calendar.month];
    
    self.selectDatePicker = [NSString stringWithFormat:@"%ld-%ld-%ld",self.calendar.year,self.calendar.month,self.calendar.day];
    
    NSLog(@"今日 %@",self.selectDatePicker);
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    if(recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"swipe left");
        [self NextClick:nil];
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"swipe right");
        [self LastClick:nil];
    }
}

- (void)initRecognizer{
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizer:)];
    [self.nowMouth addGestureRecognizer:recognizer];
    
    UISwipeGestureRecognizer *recognizer2;
    recognizer2 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer2 setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.calendar addGestureRecognizer:recognizer2];
    
    recognizer2 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer2 setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.calendar addGestureRecognizer:recognizer2];
    
}



@end
