//
//  KLRootViewController.h
//  环形山脉
//
//  Created by 凯伦 on 16/11/15.
//  Copyright © 2016年 凯伦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLContentView.h"
#import "AppDelegate.h"
@interface KLRootViewController : UIViewController
@property (nonatomic, strong) KLContentView *contentView;
@property (nonatomic, weak) AppDelegate *app;

@end
