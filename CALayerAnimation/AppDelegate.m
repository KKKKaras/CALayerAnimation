//
//  AppDelegate.m
//  test
//
//  Created by invoker on 15/3/11.
//  Copyright (c) 2015年 invoker. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "CALayeranimation.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    CALayeranimation *testLoacl = [[CALayeranimation alloc]init];
    self.window.rootViewController=testLoacl;
    [self.window makeKeyAndVisible];
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)])
    {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    
    
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {
        NSDate *now=[NSDate new];
        notification.fireDate=[now dateByAddingTimeInterval:10];//10秒后通知
        notification.repeatInterval=1;//循环次数，kCFCalendarUnitWeekday一周一次
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.applicationIconBadgeNumber=1; //应用的红色数字
        notification.soundName= UILocalNotificationDefaultSoundName;//声音，可以换成alarm.soundName = @"myMusic.caf"
        //去掉下面2行就不会弹出提示框
        notification.alertBody=@"通知内容";//提示信息 弹出提示框
        notification.alertAction = @"打开";  //提示框按钮
        //notification.hasAction = NO; //是否显示额外的按钮，为no时alertAction消失
        
        // NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
        //notification.userInfo = infoDict; //添加额外的信息
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }

    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //从桌面回到程序后
     application.applicationIconBadgeNumber = 0;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    //点击提示框的打开
    application.applicationIconBadgeNumber = 0;
    NSLog(@"你点击了提示框");
    
}

@end
