//
//  KLLoginViewController.m
//  环形山脉
//
//  Created by 凯伦 on 16/11/15.
//  Copyright © 2016年 凯伦. All rights reserved.
//

#import "KLLoginViewController.h"
#import "KLcustomBtn.h"
#import "AppDelegate.h"
@interface KLLoginViewController ()<EMChatManagerDelegate>
@end

@implementation KLLoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"登录";
    [self setUIFrames];

}

-(void)setUIFrames
{
    self.contentView.backgroundColor =[UIColor whiteColor];
    //用户名
    UILabel *userlable =[[UILabel alloc]initWithFrame:CGRectMake(40, 50, 60, 44)];
    userlable.text=@"用户名";
    userlable.textColor =[UIColor blackColor];
    userlable.font=[UIFont systemFontOfSize:20];
    [self.contentView addSubview:userlable];
    
    //用户名textfield
    UITextField *userName =[[UITextField alloc] initWithFrame:CGRectMake(userlable.right+20, 55, 200, 30)];
    [userName setBorderStyle:UITextBorderStyleRoundedRect];
    [userName setPlaceholder:@"请在这里输入用户名"];
    [self.contentView addSubview:userName];
    
    //密码
    UILabel *pwdlable =[[UILabel alloc]initWithFrame:CGRectMake(40, userlable.bottom+20, 60, 44)];
    pwdlable.text=@"密码";
    pwdlable.textColor =[UIColor blackColor];
    pwdlable.font=[UIFont systemFontOfSize:20];
    [self.contentView addSubview:pwdlable];
    
    //用户密码
    UITextField *userPwd =[[UITextField alloc] initWithFrame:CGRectMake(pwdlable.right+20, userName.bottom+40, 200, 30)];
    [userPwd setSecureTextEntry:YES];
    [userPwd setBorderStyle:UITextBorderStyleRoundedRect];
     [userPwd setPlaceholder:@"请在这里输入密码"];
    [self.contentView addSubview:userPwd];
    
    
    //登录注册按钮
    KLcustomBtn *loginBtn =[KLcustomBtn createCustomBtn];
    loginBtn.frame =CGRectMake(20, userPwd.bottom+40, self.view.frame.size.width/2-40, 44);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:loginBtn];
    
    KLcustomBtn *registBtn =[KLcustomBtn createCustomBtn];
    registBtn.frame =CGRectMake(loginBtn.right+40, userPwd.bottom+40, self.view.frame.size.width/2-40, 44);
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:registBtn];
    
    //点击事件
    registBtn.block =^(KLcustomBtn *btn){
        
        if(userName.text.length ==0)
        {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"用户名不能为空"];
          
            return ;
        }
        
        if (userPwd.text.length ==0) {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"密码不能为空"];

            return;
        }
        
        
        NSOperationQueue *quque =[[NSOperationQueue alloc] init];
        quque.maxConcurrentOperationCount=5;
        [quque addOperationWithBlock:^{
            [[EMClient sharedClient] registerWithUsername:userName.text password:userPwd.text completion:^(NSString *aUsername, EMError *aError) {
                if (aError==nil) {
                    [[TKAlertCenter defaultCenter] postAlertWithMessage:@"注册成功"];
                }
            }];

            }];
    
        };
    
        //登录
        loginBtn.block =^(KLcustomBtn *btn){
                [[EMClient sharedClient] loginWithUsername:userName.text password:userPwd.text completion:^(NSString *aUsername, EMError *aError) {
                if (aError ==nil) {
                    [[TKAlertCenter defaultCenter] postAlertWithMessage:@"登录成功"];
                    [[EMClient sharedClient].options setIsAutoLogin:YES];
                    [self.app loginSuccess];
                    
                }else
                {
                    [[TKAlertCenter defaultCenter] postAlertWithMessage:@"登录失败"];
                }
            }];
        };
    //代理设置
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
}


@end
