//
//  KOMViewController.m
//  Kompax
//
//  Created by Bryan on 13-7-17.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMLoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SSCheckBoxView.h"
#import "EmailSelectionCell.h"
#import "SelectionCell.h"
#import "KOMAppDelegate.h"
#import "XYAlertViewHeader.h"
#import "KOMTabBarViewController.h"
#import "NSMutableDictionary+MutableDeepCopy.h"

#define ACCOUNT_INFO    @"accountInfo"
#define EMAIL           @"email"
#define PASSWORD        @"password"
#define FILENAME        @"currentEmail.arc"

@interface KOMLoginViewController ()

@end

@implementation KOMLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //从磁盘中读取历史用户信息
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _allAccountInfo = [defaults objectForKey:ACCOUNT_INFO];                 //总数据
    
    //按需要初始化allAccountInfo
    if([_allAccountInfo count]==0) {
        _allAccountInfo = [[NSMutableDictionary alloc]initWithCapacity:1];
    }
    _accountInfo = [_allAccountInfo mutableDeepCopy];                       //搜索出来的分数据
    
    NSArray *keys = [_accountInfo allKeys];
    
    //获取归档文件地址
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    _archivingFilePath = [documentsDirectory stringByAppendingPathComponent:FILENAME];
    NSFileManager *fileManager = [NSFileManager defaultManager];            //文件管理者
    
    if ([fileManager fileExistsAtPath:_archivingFilePath]) {
        NSString *currentEmail = [NSKeyedUnarchiver unarchiveObjectWithFile:_archivingFilePath];
        _mailField.text = currentEmail;
    }
    
    _passwordField.text = [_allAccountInfo objectForKey:_mailField.text];
    
    BOOL checked = false;
    
    if (_passwordField.text.length > 0) {
        checked = YES;
    }
    
    //设置文字颜色
    UIColor *col = [UIColor colorWithRed:88.0/256 green:150.0/256 blue:192.0/256 alpha:1];
    self.mailField.layer.borderColor = col.CGColor;
    self.mailField.layer.borderWidth = 2;
    self.passwordField.layer.borderColor = col.CGColor;
    self.passwordField.layer.borderWidth = 2;
    
    //设置勾选框
    CGRect frame = CGRectMake(90, 185, 25, 25);
    SSCheckBoxViewStyle style = kSSCheckBoxViewStyleGlossy;
    _cbv = [[SSCheckBoxView alloc] initWithFrame:frame
                                          style:style
                                        checked:checked];
    [self.view addSubview:_cbv];
    [_cbv setStateChangedTarget:self
                      selector:@selector(checkBoxViewChangedState:)];

    _move = [NSArray arrayWithObjects:_goButton,_rememberText,_cbv,_passwordField,_passwordText, nil];      //从下到上，注意先后顺序
    moveInstance = MIN(30*[_allAccountInfo count],30*4);        //最多同时显示4个账号名
    
    isOpened=NO;
    [_tb initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section){
        int number = [_accountInfo count];
        return number;
        
    } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath){
        EmailSelectionCell *cell=[tableView dequeueReusableCellWithIdentifier:@"EmailSelectionCell"];
        if (!cell) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"EmailSelectionCell" owner:self options:nil]objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        }
        
        [cell.lb setText:[NSString stringWithFormat:[NSString stringWithFormat:@"%@",[keys objectAtIndex:indexPath.row]],indexPath.row]];
        return cell;
    } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath){
        EmailSelectionCell *cell=(EmailSelectionCell*)[tableView cellForRowAtIndexPath:indexPath];
        
        _mailField.text=cell.lb.text;
        _passwordField.text = [_accountInfo objectForKey:cell.lb.text];
        
        if (_passwordField.text.length == 0)  _cbv.checked = false;
        else                                  _cbv.checked = true;
        
        [_openButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }];
    
    //下拉菜单外观
    [_tb setBackgroundColor:[UIColor whiteColor]];
    [_tb setAlpha:1];
    //_tb.separatorStyle = NO;        //设置tableviewcell之间没有横线
    [_tb.layer setBorderColor:[UIColor colorWithRed:90.0/256 green:151.0/256 blue:193.0/256 alpha:1.0].CGColor];
    [_tb.layer setBorderWidth:2];
    
}

//勾选框状态改变处理函数
- (void) checkBoxViewChangedState:(SSCheckBoxView *)cbv
{
    if(cbv.checked)
    NSLog(@"1");
    else
        NSLog(@"0");
}

- (IBAction)changeOpenStatus:(id)sender {
    
    if (isOpened) {
        //0.3秒关闭时间
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *closeImage=[UIImage imageNamed:@"arrows-blue-down.png"];
            [_openButton setImage:closeImage forState:UIControlStateNormal];
            CGRect frame=_tb.frame;
            frame.size.height=0;
            [_tb setFrame:frame];
            
            //移动下拉菜单下面的控件
            for(UIView *i in _move) {
                CGRect frame = i.frame;
                double newY = frame.origin.y;
                newY -= moveInstance;
                CGRect newFrame = CGRectMake(frame.origin.x, newY, frame.size.width, frame.size.height);
                i.frame = newFrame;
            }
            
        } completion:^(BOOL finished){
            
            isOpened=NO;
        }];
    }
    else{
        //0.3秒展开时间
        [UIView animateWithDuration:0.3 animations:^{
            //更改下拉按钮图标
            UIImage *openImage=[UIImage imageNamed:@"arrows.png"];
            [_openButton setImage:openImage forState:UIControlStateNormal];
            
            //设置下拉列表高度
            CGRect frame=_tb.frame;
            frame.size.height=moveInstance;
            [_tb setFrame:frame];
            
            //移动下拉菜单下面的控件
            for(UIView *i in _move) {
                CGRect frame = i.frame;
                double newY = frame.origin.y;
                newY += moveInstance;
                CGRect newFrame = CGRectMake(frame.origin.x, newY, frame.size.width, frame.size.height);
                i.frame = newFrame;
            }
            
        } completion:^(BOOL finished){
            
            isOpened=YES;
        }];
    }
}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
    
    if (isOpened) {
        [self changeOpenStatus:_openButton];
    }
}

- (IBAction)textFieldDoneEditing:(id)sender {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)login:(id)sender {

    NSString *emailText = _mailField.text;
    NSString *passwordText = _passwordField.text;
    
    //判断邮箱或密码是否为空
    if(emailText.length == 0 || passwordText.length == 0) {
        XYShowAlert(@"账号或密码不能为空!");
        return;
    }
    //判断邮箱是否合法
    if (![self validateEmail:emailText]) {
        XYShowAlert(@"邮箱输入不合法！");
        return ;
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;        //开启状态栏风火轮
    
    XYLoadingView *loading = [[XYLoadingView alloc] initWithMessaege:@"正在登录..."];
    [loading show];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:emailText,@"email",passwordText,@"password", nil];
    
    KOMAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSMutableURLRequest *request = [delegate.client requestWithMethod:@"POST" path:@"Login/login" parameters:dict];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSLog(@"%@",JSON);
        NSString *msg = [JSON objectForKey:@"msg"];
        
        //登录成功,跳转到主界面
        if ([msg isEqualToString:@"Succeeded!"])  {
            
            //检测是否需要记住密码，把用户和密码信息存入userdedaults中
            [_allAccountInfo removeObjectForKey:emailText];        
            if (_cbv.checked) {
                [_allAccountInfo setObject:passwordText forKey:emailText];
            }
            else {
                [_allAccountInfo setObject:@"" forKey:emailText];
            }
            
            [NSKeyedArchiver archiveRootObject:emailText toFile:_archivingFilePath];
            
            //allAccountInfo对象归档
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:_allAccountInfo forKey:ACCOUNT_INFO];
            [defaults synchronize];
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [loading dismiss];
            
            KOMTabBarViewController *mainTabbar = [self.storyboard instantiateViewControllerWithIdentifier:@"Tabbar"];
            
            mainTabbar.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            
            //进入主界面
            [self presentViewController:mainTabbar animated:YES completion:^{
            }];
        }
        else if ([msg isEqualToString:@"Email or password is wrong!"]) {
            XYShowAlert(@"账户或密码输入错误！");
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [loading dismiss];
            return ;
        }
        else if ([msg isEqualToString:@"This user has already logged in!"]) {
            XYShowAlert(@"该用户已经登录！");
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [loading dismiss];
            return;
        }

    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"%@",error);
    }];
    [operation start];
}

//判断邮箱是否合法函数
- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

@end
