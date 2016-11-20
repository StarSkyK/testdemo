//
//  KLMeViewController.m
//  环形山脉
//
//  Created by 凯伦 on 16/11/17.
//  Copyright © 2016年 凯伦. All rights reserved.
//

#import "KLMeViewController.h"
#import "KLcustomBtn.h"
#import "AppDelegate.h"
@interface KLMeViewController ()
@property (nonatomic, weak) KLcustomBtn *logoutBtn;
@property (nonatomic, strong)  NSOperationQueue *quque;
@end

@implementation KLMeViewController

-(KLcustomBtn *)logoutBtn
{
    if (_logoutBtn ==nil) {
        _logoutBtn =[KLcustomBtn createCustomBtn];
    }
    return _logoutBtn;
}

-(NSOperationQueue *)quque
{
    if (_quque ==nil) {
        _quque =[[NSOperationQueue alloc] init];
    }
    return _quque;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBtnFrame];
    [self.view addSubview:self.logoutBtn];

}

-(void)setBtnFrame
{
    self.logoutBtn.frame =CGRectMake(0, 100, 414, 30);
    [self.logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.logoutBtn setBackgroundColor:[UIColor redColor]];
    self.logoutBtn.block = ^(KLcustomBtn *btn){
        [self.app logoutSuccess];
        [self.quque addOperationWithBlock:^{
            [[EMClient sharedClient] logout:YES completion:^(EMError *aError) {
              
                [[TKAlertCenter defaultCenter] postAlertWithMessage:@"成功退出账号"];
            }];
        }];
       
    };
    
}


@end
