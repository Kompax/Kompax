//
//  KOMRegisterViewController.m
//  Kompax
//
//  Created by Bryan on 13-7-19.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "KOMAppDelegate.h"

#import "KOMRegisterViewController.h"
#import "KOMTabBarViewController.h"

#import "AFNetworking.h"
#import "XYAlertViewHeader.h"

@implementation KOMRegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *col = [UIColor colorWithRed:88.0/256 green:150.0/256 blue:192.0/256 alpha:1];
    	
    self.mailText.layer.borderColor = col.CGColor;
    self.mailText.layer.borderWidth = 2.0f;
    self.passwordText.layer.borderColor = col.CGColor;
    self.passwordText.layer.borderWidth = 2.0f;
    self.againText.layer.borderColor = col.CGColor;
    self.againText.layer.borderWidth = 2.0f;
  
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipe];
}

//确定按钮
- (IBAction)confirm:(id)sender {
    
    NSString *emailText = _mailText.text;
    NSString *passwordText = _passwordText.text;
    NSString *passwordAgainText = _againText.text;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;    //打开状态栏风火轮
    XYLoadingView *loading = [[XYLoadingView alloc]initWithMessaege:@"正在注册..."];
    [loading show];
    
    if(emailText.length * passwordText.length * passwordAgainText.length == 0) {
        XYShowAlert(@"账号或密码输入不能为空！");
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [loading dismiss];
        return;
    }
    if (![passwordText isEqualToString:passwordAgainText]) {
        XYShowAlert(@"两次密码输入不正确！");
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [loading dismiss];
        return;
    }
    if (![self validateEmail:emailText]) {
        XYShowAlert(@"邮箱输入不合法!");
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [loading dismiss];
        return;
    }
    if(passwordText.length < 8 || passwordText.length > 20) {
        XYShowAlert(@"密码长度必须为8至20位!");
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [loading dismiss];
        return;
    }
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:emailText,@"email",passwordText,@"password", nil];
    
    KOMAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSMutableURLRequest *request = [delegate.client requestWithMethod:@"POST" path:@"Register/register" parameters:dict];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSLog(@"%@",JSON);
        NSString *msg = [JSON objectForKey:@"msg"];
        
        //注册成功
        if ([msg isEqualToString:@"Registered successfully!"]) {
            XYShowAlert(@"注册成功！");
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [loading dismiss];
            
            KOMTabBarViewController *mainTabbar = [self.storyboard instantiateViewControllerWithIdentifier:@"Tabbar"];
            
            mainTabbar.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            
            //进入主界面
            [self presentViewController:mainTabbar animated:YES completion:^{
            }];

        }
        else if ([msg isEqualToString:@"Register failed!"]) {
            XYShowAlert(@"注册失败！");
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [loading dismiss];
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

-(void)back {
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.7f];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setType:kCATransitionReveal];
    [animation setSubtype:kCATransitionFromRight];
    [self.parentViewController.view.layer addAnimation:animation forKey:@"backAni"];
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}


//判断邮箱是否合法函数
- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}


- (IBAction)textFieldDoneEditing:(id)sender {
    [self.view endEditing:YES];
}
@end
