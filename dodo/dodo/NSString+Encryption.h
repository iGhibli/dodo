//
//  NSString+Encryption.h
//  dodo
//
//  Created by qingyun on 16/2/25.
//  Copyright © 2016年 iGhibli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encryption)

+ (void)encryptUserName:(NSString *)userName andPassWord:(NSString *)passWord;
+ (NSArray *)decryptUserNameAndPassWord;

@end
