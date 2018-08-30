//
//  MyTabbar.m
//  TimingAlarm
//
//  Created by Mac on 2018/8/23.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "MyTabBar.h"

#define AddButtonMargin 10

@interface MyTabBar()

@end

@implementation MyTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // 创建中间 按钮
        UIButton *addBtn = [[UIButton alloc] init];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"addImage"] forState:UIControlStateNormal];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"addImage"] forState:UIControlStateHighlighted];
        [addBtn addTarget:self action:@selector(addBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addBtn];
        self.addButton = addBtn;
        
//        self.backgroundImage = [UIImage new];
//        self.shadowImage = [UIImage new];
//
//        self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
//        self.layer.shadowOffset = CGSizeMake(0, -5);
//        self.layer.shadowOpacity = 0.3;
    }
    return self;
}

// 响应中间 “+” 按钮点击事件
- (void)addBtnDidClick{
    if ([self.myTabBarDelegate respondsToSelector:@selector(addButtonClick:)]) {
        [self.myTabBarDelegate addButtonClick:self];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    // 去掉tabbar 上部的横线
    for (UIView *view in self.subviews) {
        if ([UIView isKindOfClass:[UIImageView class]] && view.bounds.size.height <= 1) {
            // 横线的高度为0.5
            UIImageView *line = (UIImageView *)view;
            line.hidden = YES;
        }
    }
    // 设置 “+” 按钮的位置
    self.addButton.centerX = self.center.x;
    self.addButton.centerY = self.height * 0.5 - 1.5 * AddButtonMargin;
    self.addButton.size = CGSizeMake(self.addButton.currentBackgroundImage.size.width, self.addButton.currentBackgroundImage.size.height);
    
    //创建并设置“+” 按钮下方的文本为添加
    UILabel *addLbl = [[UILabel alloc] init];
    addLbl.font = [UIFont systemFontOfSize:10];
    addLbl.textColor = [UIColor blackColor];
    [addLbl sizeToFit];
    
    //设置label位置
    addLbl.centerX = self.addButton.centerX;
    addLbl.centerY = CGRectGetMaxY(self.addButton.frame) + 0.5 * AddButtonMargin + 2;
    [self addSubview:addLbl];
    
    self.addLabel = addLbl;
    
    
    int btnIndex = 0;
    //系统自带的按钮类型是UITabBarButton，找出这些类型的按钮，然后重新排布位置，空出中间的位置
    Class class = NSClassFromString(@"UITabBarButton");
    for (UIView *btn in self.subviews) { // 遍历TabBar的子控件
        if ([btn isKindOfClass:class]) { // 如果是系统的UITabBarButton, 那么就调整子控件位置，空出中间位置
            
            //每一个按钮的宽度等于TabBar的三分之一
            btn.width = self.width / self.maxNumber;
            btn.x = btn.width * btnIndex;
            btnIndex++;
            
            if (btnIndex == 1) {
                btnIndex++;
            }
        }
    }
    // 将“+” 按钮放到视图层次最前面
    [self bringSubviewToFront:self.addButton];
}

#pragma mark 重写hitTest 方法，去监听“+” 按钮和添加标签的点击，目的是为了让凸出的部分点击有反应
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    // 这一个判断是关键，不判断的话push到其他页面，点击“+”按钮的位置也是会有反应的，这样就不好了
    
//    self.isHidden = NO 说明当前页面是有TabBar的，那么肯定实在根控制器页面
    /**
     在根控制器页面，那么我们就需要判断手指点击的位置是否在“+”按钮或者 添加标签上
     是的话，让+按钮自己处理点击事件，不是的话让系统处理点击事件就可以了。
     */
    
    if (self.isHidden == NO) { // 默认是检查当前视图
        
        // 将当前TabBar的触摸点转换坐标系，转换到+按钮的身上，生成一个新的点，
        CGPoint newA = [self convertPoint:point toView:self.addButton];
        
        //将当前TabBar的触摸点转换到坐标系，转换到添加标签的身上，生成一个新的点，
        CGPoint newL = [self convertPoint:point toView:self.addLabel];
        
        //判断如果这个新的点是在+ 按钮身上，那么处理点击事件最合适的View 就是“+” 按钮
        if ([self.addButton pointInside:newA withEvent:event]) {
            return self.addButton;
            
        }else if ([self.addLabel pointInside:newL withEvent:event]){
            return self.addButton;
            
        }else{ //如果点不在 + 按钮身上，直接让系统处理就可以了
            return [super hitTest:point withEvent:event];
        }
        
    }else{
        
//        TabBar 隐藏了，那么说明已经Push 到其他页面了这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}






@end
