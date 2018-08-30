//
//  SleepCycleView.m
//  TimingAlarm
//
//  Created by Mac on 2018/8/21.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "SleepCycleView.h"

@interface SleepCycleView()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray *arrayData;
    NSString *stringRowData;
}
@end

@implementation SleepCycleView

+ (instancetype)alterView{
    return [[[NSBundle mainBundle] loadNibNamed:@"SleepCycleView" owner:self options:nil] lastObject];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        _topView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.85];
        arrayData = [[NSMutableArray alloc] initWithCapacity:0];
        [self showPickerData];
    }
    return self;
}


- (void)showPickerData{
    for (int i = 1; i < 31; i++) {
        [arrayData addObject:[NSString stringWithFormat:@"%d",i]];
    }
}

- (IBAction)cancelAction:(id)sender {
    
    if (self.blockPickerRow) {
        self.blockPickerRow(stringRowData);
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.top = 0;
        self.topView.backgroundColor = [UIColor clearColor];
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
    });
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return arrayData.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"%@分钟",arrayData[row]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    stringRowData = [NSString stringWithFormat:@"%@分钟",arrayData[row]];
}

// 设置PickerView分割线属性&字体属性
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    // 设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = kUIColorFromHex(0xcccccc);
        }
    }

    // 设置文字的属性
    UILabel *pickerLabel = [[UILabel alloc] init];
    pickerLabel.text = [NSString stringWithFormat:@"%@分钟",arrayData[row]];
    pickerLabel.textAlignment = NSTextAlignmentCenter;
    pickerLabel.textColor = kUIColorFromHex(0x666666);
    pickerLabel.font = [UIFont systemFontOfSize:23];

    return pickerLabel;
}

@end
