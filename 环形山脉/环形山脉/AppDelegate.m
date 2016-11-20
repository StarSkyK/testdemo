//
//  AppDelegate.m
//  环形山脉
//
//  Created by 凯伦 on 16/11/15.
//  Copyright © 2016年 凯伦. All rights reserved.
//

#import "AppDelegate.h"
#import "EMSDK.h"
#import "KLLoginViewController.h"
#import "KLRootNavigationController.h"
#import "KLchatViewController.h"
#import "KLMeViewController.h"
#import "KLcontactViewController.h"
@interface AppDelegate ()<EMClientDelegate>
@property (nonatomic, strong) KLRootNavigationController *loginNav;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window =[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    KLLoginViewController *loginVC =[[KLLoginViewController alloc]init];
    
    self.loginNav=[[KLRootNavigationController alloc] initWithRootViewController:loginVC];
    self.window.rootViewController=self.loginNav;
    [self.window makeKeyAndVisible];
    
    
    
    EMOptions *options =[EMOptions optionsWithAppkey:@"1174161115178311#testapp"];
    options.apnsCertName =@"";
   EMError *error = [[EMClient sharedClient] initializeSDKWithOptions:options];
    if (error==nil) {
    }
    
    if ([[EMClient sharedClient] isAutoLogin]) {
        [self loginSuccess];
    }
    
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
   }

- (void)applicationDidBecomeActive:(UIApplication *)application {
   }

- (void)applicationWillTerminate:(UIApplication *)application {
}

// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}



-(void)loginSuccess
{
    UITabBarController *kltabbarVc =[[UITabBarController alloc] init];
    
    KLchatViewController *chatVc =[[KLchatViewController alloc] init];
    KLRootNavigationController *chatNav =[[KLRootNavigationController alloc] initWithRootViewController:chatVc];
    chatVc.tabBarItem.image =[UIImage imageNamed:@"tabbar_mainframe"];
    chatVc.tabBarItem.selectedImage =[UIImage imageNamed:@"tabbar_mainframeHL"];
    chatVc.title =@"会话";
    
    KLcontactViewController *contactVc =[[KLcontactViewController alloc] init];
    KLRootNavigationController *contactNav =[[KLRootNavigationController alloc] initWithRootViewController:contactVc];
    contactVc.tabBarItem.image =[UIImage imageNamed:@"tabbar_contacts"];
    contactVc.tabBarItem.selectedImage =[UIImage imageNamed:@"tabbar_contactsHL"];
    contactVc.title =@"联系人列表";
    
    KLMeViewController *meVc=[[KLMeViewController alloc] init];
    KLRootNavigationController *meNav =[[KLRootNavigationController alloc] initWithRootViewController:meVc];
    meVc.tabBarItem.image=[UIImage imageNamed:@"tabbar_me"];
    meVc.tabBarItem.selectedImage =[UIImage imageNamed:@"tabbar_meHL"];
    meVc.title =@"我";

    
    [kltabbarVc setViewControllers:@[chatNav,contactNav,meNav]];
    
    self.window.rootViewController =kltabbarVc;

}


-(void)logoutSuccess
{
    self.window.rootViewController =self.loginNav;
    [[EMClient sharedClient].options setIsAutoLogin:NO];
}


-(void)autoLoginDidCompleteWithError:(EMError *)aError
{
    NSLog(@"自动登录成功");
}









@end
