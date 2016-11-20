//
//  KLRootNavigationController.m
//  环形山脉
//
//  Created by 凯伦 on 16/11/15.
//  Copyright © 2016年 凯伦. All rights reserved.
//

#import "KLRootNavigationController.h"

@interface KLRootNavigationController ()

@end

@implementation KLRootNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"topbarbg_ios7"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
