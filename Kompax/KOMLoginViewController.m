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

@interface KOMLoginViewController ()

@end

@implementation KOMLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[NSThread sleepForTimeInterval:1.0];
    //设置文字颜色
    UIColor *col = [UIColor colorWithRed:88.0/256 green:150.0/256 blue:192.0/256 alpha:1];
    self.mailField.layer.borderColor = col.CGColor;
    self.mailField.layer.borderWidth = 2;
    self.passwordField.layer.borderColor = col.CGColor;
    self.passwordField.layer.borderWidth = 2;
    
    //设置勾选框
    CGRect frame = CGRectMake(90, 185, 25, 25);
    SSCheckBoxViewStyle style = kSSCheckBoxViewStyleGlossy;
    BOOL checked = false;
    _cbv = [[SSCheckBoxView alloc] initWithFrame:frame
                                          style:style
                                        checked:checked];
    [self.view addSubview:_cbv];
    [_cbv setStateChangedTarget:self
                      selector:@selector(checkBoxViewChangedState:)];
    
    _way = [NSArray arrayWithObjects:@"支出",@"收入",@"借记", nil];
    _move = [NSArray arrayWithObjects:_goButton,_rememberText,_cbv,_passwordField,_passwordText, nil];      //从下到上，注意先后顺序
    moveInstance = 80;
    
    isOpened=NO;
    [_tb initTableViewDataSourceAndDelegate:^(UITableView *tableView,NSInteger section){
        return 3;
        
    } setCellForIndexPathBlock:^(UITableView *tableView,NSIndexPath *indexPath){
        EmailSelectionCell *cell=[tableView dequeueReusableCellWithIdentifier:@"EmailSelectionCell"];
        if (!cell) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"EmailSelectionCell" owner:self options:nil]objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        }
        [cell.lb setText:[NSString stringWithFormat:[NSString stringWithFormat:@"%@",[_way objectAtIndex:indexPath.row]],indexPath.row]];
        return cell;
    } setDidSelectRowBlock:^(UITableView *tableView,NSIndexPath *indexPath){
        EmailSelectionCell *cell=(EmailSelectionCell*)[tableView cellForRowAtIndexPath:indexPath];
        _mailField.text=cell.lb.text;
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
    NSLog(@"1");
    NSString *emailText = _mailField.text;
    NSString *passwordText = _passwordField.text;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;        //开启状态栏风火轮
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:emailText,@"email",passwordText,@"password", nil];
    
    KOMAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSMutableURLRequest *request = [delegate.client requestWithMethod:@"POST" path:@"Login/login" parameters:dict];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//        indicator.center
        
        NSLog(@"%@",JSON);
        NSString *msg = [JSON objectForKey:@"msg"];
        
        //登录成功,跳转到主界面
        if ([msg isEqualToString:@"Logged in successfully!"]) {
            
            
            
            
            
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        
        
        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"%@",error);
    }];
    [operation start];
}



@end
