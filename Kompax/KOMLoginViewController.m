//
//  KOMViewController.m
//  Kompax
//
//  Created by Bryan on 13-7-17.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "KOMAppDelegate.h"

#import "KOMLoginViewController.h"

#import "KOMTabBarViewController.h"
#import "EmailSelectionCell.h"
#import "SelectionCell.h"

#import "NSMutableDictionary+MutableDeepCopy.h"
#import "SSCheckBoxView.h"
#import "XYAlertViewHeader.h"
#import "KOMConstants.h"


@interface KOMLoginViewController ()

@end

@implementation KOMLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //显示上一次登录用户名
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _mailField.text = [defaults objectForKey:LAST_ACCOUNT];
    
    //读取历史用户列表
    NSFileManager *fileManager = [NSFileManager defaultManager];            //文件管理者
    
    KOMAppDelegate *delegate = [[UIApplication sharedApplication]delegate];
    
    if ([fileManager fileExistsAtPath:delegate.accountListFilePath]) {
        //总数据
        _allAccountInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:delegate.accountListFilePath];
      
    }
    _passwordField.text = [_allAccountInfo objectForKey:_mailField.text];
    
/*    注意不可以直接写，_allAccountInfo = [defaults objectForKey:ACCOUNT_INFO];                 
 *  否则会出现-[__NSCFDictionary SetObject:forKey:]: Mutating Method Sent To Immutable Object 错误
 *  解决方法见http://qqy620.diandian.com/post/2012-10-15/40039809949
 */
    
    
    //按需要初始化allAccountInfo
    if([_allAccountInfo count]==0) {
        _allAccountInfo = [[NSMutableDictionary alloc]initWithCapacity:1];
    }
    _accountInfo = [_allAccountInfo mutableDeepCopy];                       //搜索出来的分数据
    
    NSArray *keys = [_accountInfo allKeys];
    
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
    
    //设置注册按钮跳转
    [_toRegister addTarget:self action:@selector(jumpToRegister) forControlEvents:UIControlEventTouchUpInside];
    
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
    [_tb.layer setBorderColor:[UIColor colorWithRed:90.0/256 green:151.0/256 blue:193.0/256 alpha:1.0].CGColor];
    [_tb.layer setBorderWidth:2];
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
        if ([msg isEqualToString:SUCCESS])  {
            
            //检测是否需要记住密码，把用户和密码信息存入userdedaults中
            [_allAccountInfo removeObjectForKey:emailText];        
            if (_cbv.checked) {
                [_allAccountInfo setObject:passwordText forKey:emailText];
            }
            else {
                [_allAccountInfo setObject:@"" forKey:emailText];
            }
            
            [NSKeyedArchiver archiveRootObject:_allAccountInfo toFile:delegate.accountListFilePath];

            
            //NSUserDefaults对象归档
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:emailText forKey:LAST_ACCOUNT];
            [defaults synchronize];
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [loading dismiss];
            
            KOMTabBarViewController *mainTabbar = [self.storyboard instantiateViewControllerWithIdentifier:@"Tabbar"];
            
            mainTabbar.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            
            //进入主界面
            [self presentViewController:mainTabbar animated:YES completion:^{
            }];
        }
        else if ([msg isEqualToString:PASSWORD_WRONG]) {
            XYShowAlert(@"账户或密码输入错误！");
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [loading dismiss];
            return ;
        }
        else if ([msg isEqualToString:ALREADY_LOGGIN]) {
            XYShowAlert(@"该用户已经登录！");
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [loading dismiss];
            return;
        }

    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        XYShowAlert(@"当前网络出现故障，请稍后再试!");
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [loading dismiss];
        NSLog(@"%@",error);
        return;
    }];
    [operation start];
}

//跳转到注册页面
-(void)jumpToRegister {
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.7f];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setRemovedOnCompletion:YES];
    
    _registerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Register"];
    _registerVC.view.frame = CGRectMake(0, 0, 320, 480);
    [self addChildViewController:_registerVC];
    [_registerVC.view.layer addAnimation:animation forKey:@"animation"];
    [self.view addSubview:_registerVC.view];
}

//判断邮箱是否合法函数
- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

@end
