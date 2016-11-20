//
//  KLcustomBtn.m
//  环形山脉
//
//  Created by 凯伦 on 16/11/15.
//  Copyright © 2016年 凯伦. All rights reserved.
//

#import "KLcustomBtn.h"

@implementation KLcustomBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        [self addTarget:self action:@selector(clickOn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)clickOn:(KLcustomBtn *)btn
{
    if (_block!=nil) {
        _block(btn);
    }
}

+(instancetype)createCustomBtn
{
    return [KLcustomBtn buttonWithType:UIButtonTypeCustom];
}

@end
