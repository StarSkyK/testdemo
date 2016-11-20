//
//  KLchatViewController.m
//  环形山脉
//
//  Created by 凯伦 on 16/11/17.
//  Copyright © 2016年 凯伦. All rights reserved.
//

#import "KLchatViewController.h"

@interface KLchatViewController ()<EMClientDelegate,EMContactManagerDelegate>

@end

@implementation KLchatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];

}

-(void)connectionStateDidChange:(EMConnectionState)aConnectionState
{
    NSLog(@"aConnectionState---------------------------%d",aConnectionState);
}

-(void)friendRequestDidReceiveFromUser:(NSString *)aUsername message:(NSString *)aMessage
{
    UIAlertController *addFriendInfo =[UIAlertController alertControllerWithTitle:@"好友请求" message:aMessage preferredStyle:UIAlertControllerStyleActionSheet];
    
  
    UIAlertAction *agree =[UIAlertAction actionWithTitle:@"同意" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:aUsername];
        if (!error) {
            NSLog(@"发送同意成功");
        }
    }];
    
    UIAlertAction *refuse=[UIAlertAction actionWithTitle:@"拒绝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       [[EMClient sharedClient].contactManager declineFriendRequestFromUser:aUsername completion:^(NSString *aUsername, EMError *aError) {
           [[TKAlertCenter defaultCenter] postAlertWithMessage:@"已经拒绝"];
       }];
    }];
    
    [addFriendInfo addAction:agree];
    [addFriendInfo addAction:refuse];
    
    [self presentViewController:addFriendInfo animated:YES completion:nil];
    
}

-(void)friendRequestDidDeclineByUser:(NSString *)aUsername
{
    [[TKAlertCenter defaultCenter] postAlertWithMessage:@"你的请求被拒绝了"];
}

-(void)friendshipDidAddByUser:(NSString *)aUsername
{
    [[TKAlertCenter defaultCenter] postAlertWithMessage:@"添加好友成功"];
    
}



@end
