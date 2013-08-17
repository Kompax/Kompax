//
//  KOMSettingForUserViewController.h
//  Kompax
//
//  Created by Bryan on 13-8-16.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KOMLoginViewController.h"

@interface KOMSettingForUserViewController : UIViewController

@property (strong,nonatomic) UILabel *management;       //“账户管理”按钮
@property (strong,nonatomic) UILabel *syn;       //“账户管理”按钮
@property (strong,nonatomic) UILabel *exit;       //“账户管理”按钮

@property(strong,nonatomic) KOMLoginViewController *login;      //跳转到的登录界面

@end
