//
//  KOMImportViewController.h
//  Kompax
//
//  Created by Bryan on 13-8-12.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    NormalState = 0,
    EmailState,
    NetAccState
} VCState;

@interface KOMImportViewController : UIViewController<UITextFieldDelegate>

@property (assign,nonatomic) VCState state;
@property (copy,nonatomic) NSString *account;       //账号
@property (copy,nonatomic) NSString *password;      //密码
@property (assign,nonatomic) BOOL isImported;       //账号是否已经导入

@property (copy,nonatomic) NSString *accStateName;  //账户类别（淘宝，通信达......）

//账户，密码输入框，确认按钮
@property (strong,nonatomic) UITextField *accountText;
@property (strong,nonatomic) UITextField *passwordText;
@property (strong,nonatomic) UIButton *confirm;

//父视图
@property (strong,nonatomic) UIViewController *father;

//自定义构造函数
- (id)initWithState:(VCState)state isImported:(BOOL)imported ;

@end
