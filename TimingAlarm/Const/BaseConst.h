//
//  BaseConst.h
//  TimingAlarm
//
//  Created by Mac on 2018/8/10.
//  Copyright © 2018年 Mac. All rights reserved.
//


#ifdef DEBUG
#define LRString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define NSLog(...) printf("%s 第%d行: %s\n\n",[LRString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif

#define isEmpty(x)  [MyDateSecurity isNilOrEmpty:x]
#define getNoneNil(object)  [MyDateSecurity getNoneNilString:object]


#define kMyUserDefult [NSUserDefaults standardUserDefaults] //保存本地

#define shareAppdelegate [UIApplication sharedApplication].delegate

//系统版本号
#define iOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]
//app version 版本号
#define kAppVersionShort [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//app Bundle 版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]


#define kis_IPHONE_X ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )812 ) < DBL_EPSILON )

//屏幕高度、宽度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

//navigationBar的高度
#define kScreenNavHeight MainScreenHeight - 64
#define kScreenTabHeight MainScreenNavHeight - 50



// ios11 导航栏、tabbar高度
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height //状态栏高度
#define kNavBarHeight 44.0
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49) //底部tabbar高度
#define kTopHeight (kStatusBarHeight + kNavBarHeight) //整个导航栏高度

// get color
#define kGetColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define kUIColorFromHex(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0]




