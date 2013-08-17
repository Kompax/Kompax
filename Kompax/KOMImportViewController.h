//
//  KOMImportViewController.h
//  Kompax
//
//  Created by Bryan on 13-8-12.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    EmailState = 0,
    NetAccState
} VCState;

@interface KOMImportViewController : UIViewController<UITextFieldDelegate>

@property (strong,nonatomic) UIScrollView *scrollView;

@property (assign,nonatomic) VCState state;
@property (copy,nonatomic) NSString *emailAccount;       //邮箱账户账号
@property (copy,nonatomic) NSString *netAccount;         //网络账户账号

@property (copy,nonatomic) NSString *password;      //密码
@property (assign,nonatomic) BOOL isImported;       //账号是否已经导入

@property (copy,nonatomic) NSString *accStateName;  //账户类别（淘宝，通信达......）

//账户，密码输入框，确认按钮
@property (strong,nonatomic) UITextField *accountText;
@property (strong,nonatomic) UITextField *passwordText;
@property (strong,nonatomic) UIButton *confirm;

@property(strong,nonatomic) NSDate *emailDate;           //邮箱账户登录时间
@property (strong,nonatomic) NSDate *netDate;            //网络账户登录时间

//父视图
@property (strong,nonatomic) UIViewController *father;

//设置子视图类别函数
- (id)initWithState:(VCState)state isImported:(BOOL)imported ;


//界面标签
@property(strong,nonatomic) UILabel *syn;           //“数据导入按钮”
@property(strong,nonatomic) UILabel *accLabel;      //账号显示标签
@property(strong,nonatomic) UILabel *timeLabel;     //登录时间显示标签
@property(strong,nonatomic) UIButton *modify;       //修改按钮

@end
