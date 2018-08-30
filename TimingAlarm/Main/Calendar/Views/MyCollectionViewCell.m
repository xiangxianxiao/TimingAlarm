//
//  MyCollectionViewCell.m
//  TimingAlarm
//
//  Created by Mac on 2018/8/13.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "MyCollectionViewCell.h"

@interface MyCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *cellLabel;

@end

@implementation MyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - 外部配置

- (void)setCalendarTitle:(NSString *)calendarTitle
{
    self.cellLabel.text = calendarTitle;
    _calendarTitle = calendarTitle;
}

- (void)setCalendarTitleColor:(UIColor *)calendarTitleColor
{
    _calendarTitleColor = calendarTitleColor;
    self.cellLabel.textColor = calendarTitleColor;
}


@end
