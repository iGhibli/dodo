//
//  Contacts.m
//  dodo
//
//  Created by qingyun on 16/2/25.
//  Copyright © 2016年 iGhibli. All rights reserved.
//

#import "ContactsVC.h"
#import "EaseMob.h"

@interface ContactsVC ()
@property (nonatomic, strong) NSString *addContactID;
@end

@implementation ContactsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
#pragma mark - 获取好友列表
    [[EaseMob sharedInstance].chatManager asyncFetchBuddyListWithCompletion:^(NSArray *buddyList, EMError *error) {
        if (!error) {
            NSLog(@"获取成功 -- %@",buddyList);
            
        }
    } onQueue:nil];
}

- (IBAction)addContactAction:(UIBarButtonItem *)sender {
    [self addContact];
}

- (void)addContact
{
//    self.addContactID = nil;
    UIAlertController *alrtC = [UIAlertController alertControllerWithTitle:@"添加好友" message:@"请在输入框中填写要添加好友的ID！" preferredStyle:UIAlertControllerStyleAlert];
    [alrtC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {

        textField.textAlignment = NSTextAlignmentCenter;
        [textField addTarget:self action:@selector(textFieldValueChange:) forControlEvents:UIControlEventValueChanged];
    }];
    UIAlertAction *determineAction = [UIAlertAction actionWithTitle:@"添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
#pragma mark - 添加好友申请
        if (self.addContactID.length != 0) {
            EMError *error;
            BOOL isSuccess = [[EaseMob sharedInstance].chatManager addBuddy:self.addContactID message:@"我想加您为好友" error:&error];
            if (isSuccess && !error) {
                NSLog(@"添加成功");
            }
        }else {
            UIAlertController *popAC = [UIAlertController alertControllerWithTitle:@"失败" message:@"好友用户名不能为空！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
            [popAC addAction:action];
            [self presentViewController:popAC animated:YES completion:nil];
        }
        
    }];
    UIAlertAction *cancelAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }];
    [alrtC addAction:determineAction];
    [alrtC addAction:cancelAction];
    [self presentViewController:alrtC animated:YES completion:nil];
}

- (void)textFieldValueChange:(UITextField *)tf
{
    self.addContactID = tf.text;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
