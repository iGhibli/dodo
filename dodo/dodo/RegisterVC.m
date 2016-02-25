//
//  RegisterVC.m
//  dodo
//
//  Created by qingyun on 16/2/25.
//  Copyright © 2016年 iGhibli. All rights reserved.
//

#import "RegisterVC.h"
#import "EaseMob.h"

@interface RegisterVC ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)registerAction:(UIButton *)sender {
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:self.userNameTF.text password:self.passWordTF.text withCompletion:^(NSString *username, NSString *password, EMError *error) {
        
        if (!error) {
            [self dismissViewControllerAnimated:YES completion:nil];
            NSLog(@"注册成功");
        }
    } onQueue:nil];
}

- (IBAction)cancelAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
