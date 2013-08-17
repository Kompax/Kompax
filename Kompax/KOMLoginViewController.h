//
//  KOMViewController.h
//  Kompax
//
//  Created by Bryan on 13-7-17.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+DataSourceBlocks.h"
#import "TableViewWithBlock.h"
#import "SSCheckBoxView.h"
#import "KOMRegisterViewController.h"

@class TableViewWithBlock;
@interface KOMLoginViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    BOOL isOpened;
    double moveInstance;
}

//基础控件
@property (strong, nonatomic) IBOutlet UITextField *mailField;      //邮箱输入框
@property (strong, nonatomic) IBOutlet UITextField *passwordField;  //密码输入框
@property (strong,nonatomic ) SSCheckBoxView *cbv;                  //勾选框
@property (retain, nonatomic) IBOutlet UIButton *openButton;        //打开下拉菜单按钮
@property (retain, nonatomic) IBOutlet TableViewWithBlock *tb;      //下拉菜单

//下拉菜单出现时部分控件移动
@property (strong, nonatomic) IBOutlet UILabel *passwordText;
@property (strong, nonatomic) IBOutlet UILabel *rememberText;
@property (strong, nonatomic) IBOutlet UIButton *goButton;

@property (strong,nonatomic)   NSArray *way;    //存储下拉菜单内容
@property(strong,nonatomic) NSArray *move;  //存储动态控件

@property(strong,nonatomic) NSMutableDictionary *allAccountInfo;      //已在本地存储的所有用户名与密码信息
@property(strong,nonatomic) NSMutableDictionary *accountInfo;         //根据当前输入框输入情况显示用户名

@property (strong, nonatomic) IBOutlet UIButton *toRegister;

@property(strong,nonatomic) KOMRegisterViewController *registerVC;     //登录界面视图控制器

- (IBAction)login:(id)sender;

@end
