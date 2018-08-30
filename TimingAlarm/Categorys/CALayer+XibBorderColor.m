//
//  CALayer+XibBorderColor.m
//  TimingAlarm
//
//  Created by Mac on 2018/8/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

// 设置xib BorderColor
#import "CALayer+XibBorderColor.h"

@implementation CALayer (XibBorderColor)

- (void)setBorderColorWithUIColor:(UIColor *)color{
    self.borderColor = color.CGColor;
}

@end
