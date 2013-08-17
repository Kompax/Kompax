//
//  KOMSettingForUserViewController.m
//  Kompax
//
//  Created by Bryan on 13-8-16.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMSettingForUserViewController.h"
#import "KOMSettingAccountListTableViewController.h"
#import "KOMAppDelegate.h"
#import "KOMConstants.h"
#import "XYAlertViewHeader.h"

@interface KOMSettingForUserViewController ()

@end

@implementation KOMSettingForUserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView {
    [super loadView];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *currentAccountName = [defaults objectForKey:LAST_ACCOUNT];
    
    //初始化“账户”子界面
    self.view.frame = CGRectMake(0, 0, 320, 60);
    self.view.backgroundColor = [UIColor whiteColor];
    
    //“同步数据”按钮
    _syn = [[UILabel alloc]initWithFrame:CGRectMake(31, 40, 75, 20)];
    [_syn setBackgroundColor:[UIColor blackColor]];
    [_syn setTextColor:[UIColor whiteColor]];
    [_syn setTextAlignment:NSTextAlignmentCenter];
    [_syn setFont:[UIFont boldSystemFontOfSize:15]];
    [_syn setText:@"同步数据"];
    [self.view addSubview:_syn];
    
    //“账户管理”按钮
    _management = [[UILabel alloc]initWithFrame:CGRectMake(122.5, 40, 75, 20)];
    [_management setBackgroundColor:[UIColor blackColor]];
    [_management setTextColor:[UIColor whiteColor]];
    [_management setTextAlignment:NSTextAlignmentCenter];
    [_management setFont:[UIFont boldSystemFontOfSize:15]];
    [_management setText:@"账户管理"];
    [self.view addSubview:_management];
    
    //“退出账户”按钮
    _exit = [[UILabel alloc]initWithFrame:CGRectMake(214, 40, 75, 20)];
    [_exit setBackgroundColor:[UIColor blackColor]];
    [_exit setTextColor:[UIColor whiteColor]];
    [_exit setTextAlignment:NSTextAlignmentCenter];
    [_exit setFont:[UIFont boldSystemFontOfSize:15]];
    [_exit setText:@"退出账户"];
    [self.view addSubview:_exit];
    
    //当前账号
    UILabel *currentAccountLabel = [[UILabel alloc]initWithFrame:CGRectMake(31, 10, 75, 20)];
    [currentAccountLabel setTextColor:[UIColor blackColor]];
    [currentAccountLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [currentAccountLabel setText:@"当前账户："];
    [self.view addSubview:currentAccountLabel];
    
    UILabel *currentAccount = [[UILabel alloc]initWithFrame:CGRectMake(111,10,150,20)];
    [currentAccount setTextColor:[UIColor blackColor]];
    [currentAccount setFont:[UIFont boldSystemFontOfSize:15]];
    [currentAccount setText:[NSString stringWithFormat:@"%@",currentAccountName]];
    [self.view addSubview:currentAccount];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置三个按钮可交互
    [_management setUserInteractionEnabled: YES];
    [_syn setUserInteractionEnabled:YES];
    [_exit setUserInteractionEnabled: YES];
    
    UITapGestureRecognizer *tapForExit = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showLogout)];
    [_exit addGestureRecognizer:tapForExit];
    
    UITapGestureRecognizer *tapForManage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(accountManagement)];
    [_management addGestureRecognizer:tapForManage];
    
    UITapGestureRecognizer *tapForSyn = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(synchronizeData)];
    [_syn addGestureRecognizer:tapForSyn];
}

//显示登出函数
-(void)showLogout {
    
    XYAlertView *alertView = [XYAlertView alertViewWithTitle:nil
                                                     message:@"确定要登出吗？"
                                                     buttons:[NSArray arrayWithObjects:@"确定", @"取消", nil]
                                                afterDismiss:^(int buttonIndex) {
                                                    if (buttonIndex == 0)   [self logout];    //调用save函数
                                                }];
    //设置第二个按钮为灰色按钮
    [alertView setButtonStyle:XYButtonStyleGray atIndex:1];
    [alertView show];
}

-(void)accountManagement {
    
    KOMSettingAccountListTableViewController *accountList = [[KOMSettingAccountListTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:accountList];
    accountList.title = @"已登录账号";
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self.parentViewController presentViewController:nav animated:YES completion:^{
        nil;
    }];
}

//同步数据
-(void)synchronizeData {
    
}


//登出函数
-(void)logout {
   
    KOMAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *currentAccount = [defaults objectForKey:LAST_ACCOUNT];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:currentAccount,@"email", nil];
    
    NSMutableURLRequest *request = [delegate.client requestWithMethod:@"POST" path:@"Login/logout" parameters:dict];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSString *msg = [JSON objectForKey:@"msg"];
        
        if ([msg isEqualToString:@"Logged out!"]) {
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"mainstoryboard" bundle:nil];
            _login = [storyboard instantiateViewControllerWithIdentifier:@"Login"];
            _login.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self.parentViewController presentViewController:_login animated:YES completion:^{
                
            }];
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"%@",error);
    }];
    [operation start];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
