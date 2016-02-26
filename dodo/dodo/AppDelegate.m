//
//  AppDelegate.m
//  dodo
//
//  Created by qingyun on 16/2/25.
//  Copyright © 2016年 iGhibli. All rights reserved.
//

#import "AppDelegate.h"
#import "NSString+Encryption.h"
#import "EaseMob.h"

@interface AppDelegate ()<EMChatManagerLoginDelegate, EMChatManagerBuddyDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    //registerSDKWithAppKey:注册的appKey。
    //apnsCertName:推送证书名(不需要加后缀)，默认@"istore_dev"。
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"ighibli#dodo" apnsCertName:nil];
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
      
    // Override point for customization after application launch.
    
    //先判断是否为自动登陆
    BOOL isAutoLogin = [[EaseMob sharedInstance].chatManager isAutoLoginEnabled];
    if (isAutoLogin) {
        //自动登录
        [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:[[NSString decryptUserNameAndPassWord] firstObject] password:[[NSString decryptUserNameAndPassWord] lastObject] completion:^(NSDictionary *loginInfo, EMError *error) {
            if (!error && loginInfo) {
                UIStoryboard *ContentSB = [UIStoryboard storyboardWithName:@"Content" bundle:nil];
                self.window.rootViewController = [ContentSB instantiateInitialViewController];
                NSLog(@"登陆成功");
            }
        } onQueue:nil];
    }else {
        //转到登录界面
        UIStoryboard *MainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.window.rootViewController = [MainSB instantiateInitialViewController];
    }
    return YES;
}

- (void)willAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{
    
}

// 好友申请回调
- (void)didReceiveBuddyRequest:(NSString *)username
                       message:(NSString *)message
{
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}

@end
