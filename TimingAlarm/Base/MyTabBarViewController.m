//
//  MyTabBarViewController.m
//  TimingAlarm
//
//  Created by Mac on 2018/8/23.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "MyTabBarViewController.h"
#import "MyTabBar.h"
#import "AlarmViewController.h"
#import "MainViewController.h"
#import "ShowAlarmViewController.h"

@interface MyTabBarViewController ()<MyTabBarDelegate>

@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //创建自定义TabBar
    MyTabBar *tabBar = [[MyTabBar alloc] init];
    tabBar.myTabBarDelegate = self;
    tabBar.maxNumber = 3;
    //利用KVC替换默认的TabBar
    [self setValue:tabBar forKey:@"tabBar"];
    
    self.selectedIndex = 0;
    
    MainViewController *mainView = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    [self addChildController:mainView title:@"日历" imageName:@"calendar" selectedImageName:@"calendarSel" navVc:[UINavigationController class]];

    ShowAlarmViewController *alarmView = [[ShowAlarmViewController alloc] initWithNibName:@"ShowAlarmViewController" bundle:nil];
    [self addChildController:alarmView title:@"闹钟" imageName:@"alarm" selectedImageName:@"alarmSel" navVc:[UINavigationController class]];
    
}

- (void)addChildController:(UIViewController*)childController title:(NSString*)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName navVc:(Class)navVc
{
    childController.title = title;
    childController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置一下选中tabbar文字颜色
    
    [childController.tabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName : kUIColorFromHex(0x2A9E86) }forState:UIControlStateSelected];
    childController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
    [self addChildViewController:childController];
}

#pragma mark - MyTabBarDelegate 方法
-(void)addButtonClick:(MyTabBar *)tabBar
{
    //测试中间“+”按钮是否可以点击并处理事件
    AlarmViewController *alarmView = [[AlarmViewController alloc] initWithNibName:@"AlarmViewController" bundle:nil];
    [self presentViewController:alarmView animated:YES completion:nil];;
}

@end
