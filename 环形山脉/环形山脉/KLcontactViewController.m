//
//  KLcontactViewController.m
//  环形山脉
//
//  Created by 凯伦 on 16/11/17.
//  Copyright © 2016年 凯伦. All rights reserved.
//

#import "KLcontactViewController.h"

@interface KLcontactViewController ()<UITableViewDelegate,UITableViewDataSource,EMContactManagerDelegate>
@property (nonatomic, strong) NSArray *friendlist;
@property (nonatomic, strong) UITableView *testTable;
@end

@implementation KLcontactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBtn];
    [self newTableView];
}


-(void)setNavBtn
{
    KLcustomBtn *rightBtn =[KLcustomBtn createCustomBtn];
    rightBtn.frame=CGRectMake(self.view.frame.size.width-50, 0, 28, 30);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"contacts_add_friend"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    rightBtn.block =^(KLcustomBtn *btn){
        UIAlertController *addFriend =[UIAlertController alertControllerWithTitle:@"添加好友" message:@"请输入你想添加的好友信息" preferredStyle:UIAlertControllerStyleAlert];
        
        [addFriend addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder=@"请在这里输入你的好友账号";
        }];
        [addFriend addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder=@"附加信息";
        }];
        
        UITextField *username = [addFriend.textFields firstObject];
        UITextField *infom = [addFriend.textFields lastObject];
        
        
        
        UIAlertAction *comit =[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[EMClient sharedClient].contactManager addContact:username.text message:infom.text completion:^(NSString *aUsername, EMError *aError) {
                if (username.text.length==0) {
                    [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请输入用户名"];
                    return;
                }
                if (aError==nil) {
                    NSLog(@"成功申请");
                }
                
            }];
        }];
        UIAlertAction *cancel =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        [addFriend addAction:cancel];
        [addFriend addAction:comit];
        [self presentViewController:addFriend animated:YES completion:nil];
    };
    
 
}
/*
 * test tablevie;
 */

-(NSArray *)friendlist
{
    if (_friendlist ==nil) {
        _friendlist =[[EMClient sharedClient].contactManager getContactsFromServerWithError:nil];
        
    }
    return _friendlist;
}


-(void)newTableView
{
    self.testTable =[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.testTable];
    self.testTable.delegate=self;
    self.testTable.dataSource =self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.friendlist.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"name";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //如果没有，则创建
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    
    cell.textLabel.text =self.friendlist[indexPath.row];
    cell.imageView.image =[UIImage imageNamed:@"chatListCellHead"];
    return cell;
}


@end
