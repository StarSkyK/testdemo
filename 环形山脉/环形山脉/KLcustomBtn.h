//
//  KLcustomBtn.h
//  环形山脉
//
//  Created by 凯伦 on 16/11/15.
//  Copyright © 2016年 凯伦. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KLcustomBtn;

typedef void (^KLcustomBtnClickOn)(KLcustomBtn *);

@interface KLcustomBtn : UIButton

@property (nonatomic, strong) KLcustomBtnClickOn block;


+(instancetype)createCustomBtn;
@end
