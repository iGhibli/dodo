//
//  NSString+Encryption.m
//  dodo
//
//  Created by qingyun on 16/2/25.
//  Copyright © 2016年 iGhibli. All rights reserved.
//

#import "NSString+Encryption.h"
#import "AESCrypt.h"

@implementation NSString (Encryption)

+ (void)encryptUserName:(NSString *)userName andPassWord:(NSString *)passWord
{
    NSString *privateKey = @"StayHungryStayFoolish";
    NSString *encryptedData = [AESCrypt encrypt:passWord password:privateKey];
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] setObject:encryptedData forKey:@"passWord"];
}

+ (NSArray *)decryptUserNameAndPassWord
{
    NSString *privateKey = @"StayHungryStayFoolish";
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString *passWord = [AESCrypt decrypt:[[NSUserDefaults standardUserDefaults] objectForKey:@"passWord"] password:privateKey];
    return @[userName, passWord];
}

@end
