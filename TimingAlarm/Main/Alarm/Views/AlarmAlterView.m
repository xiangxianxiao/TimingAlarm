//
//  AlarmAlterView.m
//  TimingAlarm
//
//  Created by Mac on 2018/8/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "AlarmAlterView.h"

@interface AlarmAlterView()
{
    BOOL workingDays;
}
@property (nonatomic, strong) NSMutableArray *arraySelectWorking;

@end

@implementation AlarmAlterView

+ (instancetype)alterView{
    return [[[NSBundle mainBundle] loadNibNamed:@"AlarmAlterView" owner:self options:nil] lastObject];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        workingDays = YES;
        _arrayData = [[NSMutableArray alloc] initWithCapacity:0];
        _arraySelectWorking = [[NSMutableArray alloc] initWithCapacity:0];
        _topView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.85];
    }
    return self;
}

- (void)setArrayData:(NSMutableArray *)arrayData{
    _arrayData = arrayData;
    if (arrayData.count > 0) {
        for (int i = 0; i < arrayData.count; i++) {
            NSString *strTag = [NSString stringWithFormat:@"%@",arrayData[i]];
            UIButton *btn = (UIButton *)[self viewWithTag:[strTag integerValue]];
            [self showBtnView:btn];
        }
    }
}

- (IBAction)cancelAction:(id)sender {
    
    NSString *stringSubtitle = @"";
    for (int i = 0; i < self.arraySelectWorking.count; i++) {
       stringSubtitle = [NSString stringWithFormat:@"%@ %@",stringSubtitle,self.arraySelectWorking[i]];
    }
    self.blockAlarm(stringSubtitle, _arrayData);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.top = 0;
        self.topView.backgroundColor = [UIColor clearColor];
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
    });
}

- (IBAction)selectBtnAction:(id)sender {
    
    UIButton *btn = sender;
    NSInteger tagStatus = btn.tag - 1000;
    [self showBtnView:btn];
    
    if (tagStatus == 0 || tagStatus == 8 || tagStatus == 9) {
        workingDays = NO;
        if (tagStatus == 9) {
            [self.arrayData removeAllObjects];
        }else{
            [self.arrayData removeAllObjects];
        }
        for (int i = 0; i < 10; i++) {
            UIButton * btn = (UIButton *)[self viewWithTag:1000 + i];
            if (tagStatus == 9) { // 每日
                if (i != 0 & i != 8) {
                    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [btn setBackgroundColor:kUIColorFromHex(0x333333)];
                    btn.selected = YES;
                    
                    [self.arrayData addObject:[NSString stringWithFormat:@"%ld",(long)btn.tag]];

                }else{
                    [btn setBackgroundColor:[UIColor whiteColor]];
                    [btn setTitleColor:kUIColorFromHex(0x333333) forState:UIControlStateNormal];
                    btn.selected = NO;
                }
            }else{ // 法定工作日 与 只响一次
                if (i == tagStatus) { // 0 8
                    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [btn setBackgroundColor:kUIColorFromHex(0x333333)];
                    btn.selected = YES;

                    [self.arrayData addObject:[NSString stringWithFormat:@"%ld",(long)btn.tag]];

                }else{
                    [btn setBackgroundColor:[UIColor whiteColor]];
                    [btn setTitleColor:kUIColorFromHex(0x333333) forState:UIControlStateNormal];
                    btn.selected = NO;
                }
            }
        }
    }else{ // 周一到周日
        if (workingDays == NO) {
            [self.arrayData removeObjectAtIndex:0];
            workingDays = YES;
        }
        for (int i = 0; i < 10; i++) {
            UIButton *btn = (UIButton *)[self viewWithTag:1000 + i];
            if (i == 0 || i == 8 || i == 9) {
                [btn setBackgroundColor:[UIColor whiteColor]];
                [btn setTitleColor:kUIColorFromHex(0x333333) forState:UIControlStateNormal];
                btn.selected = NO;
            }else if(i == tagStatus){
                if ([self.arrayData containsObject:[NSString stringWithFormat:@"%ld",(long)btn.tag]]) {
                    [self.arrayData removeObject:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
                }else{
                    [self.arrayData addObject:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
                }
            }
        }
    }
    [self.arrayData sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 integerValue] > [obj2 integerValue];
    }];
    [self returnAlarmTitle:self.arrayData];
}

// tag1000 转换为 title
- (void)returnAlarmTitle:(NSMutableArray *)array{
    [self.arraySelectWorking removeAllObjects];
    for (int j = 0; j < array.count; j++) {
        for (int i = 0; i < 10; i++) {
            UIButton *btn = (UIButton *)[self viewWithTag:1000 + i];
            if ([array[j] integerValue] == btn.tag) {
                [self.arraySelectWorking addObject:btn.titleLabel.text];
            }
        }
    }
}

- (void)showBtnView:(UIButton *)btn{
    if (btn.selected == NO) {
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundColor:kUIColorFromHex(0x333333)];
        btn.selected = YES;
    }else{
        [btn setBackgroundColor:kUIColorFromHex(0xffffff)];
        [btn setTitleColor:kUIColorFromHex(0x333333) forState:UIControlStateNormal];
        btn.selected = NO;
    }
}


@end
