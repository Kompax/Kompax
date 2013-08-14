//
//  KOMSettingViewController.h
//  Kompax
//
//  Created by Bryan on 13-7-23.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFolderTableView.h"
#import "KOMImportViewController.h"

@interface KOMSettingViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) IBOutlet UIFolderTableView *tableView;

@property (assign,nonatomic) BOOL emailIsImported;          //收信箱数据是否已经导入
@property (assign,nonatomic) BOOL netAccIsImported;         //网络账号数据是否已经导入

@property (copy ,nonatomic) NSString *email_account;        //收信箱数据账户
@property (copy,nonatomic ) NSString *email_password;       //收信箱数据密码
@property (strong,nonatomic) NSDate *email_date;            //收信箱账户登录时间

@property (copy ,nonatomic) NSString *net_account;          //网络账户
@property (copy,nonatomic ) NSString *net_password;         //网络账户密码
@property (strong,nonatomic) NSDate *net_date;              //网络账户登录时间

@property (strong,nonatomic) KOMImportViewController *subVC0; //0号子界面
@property (strong,nonatomic) KOMImportViewController *subVC2; //2号子界面
@property (strong,nonatomic) KOMImportViewController *subVC3; //3号子界面

-(void)expand:(UIViewController *)subVC atIndexPath:indexPath;

@end
