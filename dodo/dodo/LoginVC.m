//
//  LoginVC.m
//  dodo
//
//  Created by qingyun on 16/2/25.
//  Copyright © 2016年 iGhibli. All rights reserved.
//

#import "LoginVC.h"
#import "EaseMob.h"
#import "NSString+Encryption.h"

@interface LoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)loginAction:(UIButton *)sender {
    if (self.userNameTF.text.length == 0 || self.passWordTF.text.length == 0) {
        NSLog(@"账号和密码都不能为空！");
    }else {
        //先判断是否为自动登陆
        BOOL isAutoLogin = [[EaseMob sharedInstance].chatManager isAutoLoginEnabled];
        if (!isAutoLogin) {
            [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:self.userNameTF.text password:self.passWordTF.text completion:^(NSDictionary *loginInfo, EMError *error) {
                if (!error && loginInfo) {
                    UIStoryboard *ContentSB = [UIStoryboard storyboardWithName:@"Content" bundle:nil];
                    [self presentViewController:[ContentSB instantiateInitialViewController] animated:YES completion:nil];
                    [NSString encryptUserName:self.userNameTF.text andPassWord:self.passWordTF.text];
                    NSLog(@"登陆成功");
                }
            } onQueue:nil];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
