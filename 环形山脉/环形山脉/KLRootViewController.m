//
//  KLRootViewController.m
//  环形山脉
//
//  Created by 凯伦 on 16/11/15.
//  Copyright © 2016年 凯伦. All rights reserved.
//

#import "KLRootViewController.h"
@interface KLRootViewController ()
@end

@implementation KLRootViewController



-(KLContentView *)contentView
{
    if (_contentView==nil) {
        _contentView =[[KLContentView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _contentView.backgroundColor =[UIColor whiteColor];

    }
    return _contentView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.contentView];
    self.app =[UIApplication sharedApplication].delegate;
    
}




@end
