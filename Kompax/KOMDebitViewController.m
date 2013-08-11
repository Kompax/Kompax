//
//  KOMDebitViewController.m
//  Kompax
//
//  Created by Bryan on 13-7-27.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "KOMDebitViewController.h"
#import "KOMAccountingViewController.h"
#import "KOMNavViewController.h"
#import "KOMConstants.h"
#import "XYAlertViewHeader.h"



static NSString *GLOBAL_TIMEFORMAT = @"yyyy-MM-dd HH:mm:ss";

@interface KOMDebitViewController ()

@end

@implementation KOMDebitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化时间
    NSTimeZone* localzone = [NSTimeZone localTimeZone];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:GLOBAL_TIMEFORMAT];
    [formatter setTimeZone:localzone];
    _timeLabel.text = [formatter stringFromDate:[NSDate date]];
    
    _category = 1;
    _categoryLabel.text = @"等额分期偿还";
    
    _accountLabel.text = @"现金"; //初始化账户
    _creditorLabel.text = @"阿翔";  //初始化成员
    
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showComfirm)];
    [swipeRecognizer setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:swipeRecognizer];   //给self.view添加一个手势监测；
    
    //手动设置cash栏
    _cash.text = @"0.00";        //初始化现金
    _cash.font = [UIFont fontWithName:@"Helvetica" size:40];
    _cash.textColor = [UIColor colorWithRed:239/255.0 green:100/255.0 blue:79/255.0 alpha:1.0];
    _cash.textAlignment = NSTextAlignmentRight;
    
    
    //初始化类别选择界面
    _repayVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Repayment"];
    _repayVC.view.frame = CGRectMake(0, 0, 320, 480);
    [self addChildViewController:_repayVC];  
}

//弹出确认保存警告框
-(void)showComfirm {
    [self.view endEditing:YES];
    //询问是否保存
    XYAlertView *alertView = [XYAlertView alertViewWithTitle:nil
                                                     message:@"确认保存该条记录吗？"
                                                     buttons:[NSArray arrayWithObjects:@"保存", @"不保存", nil]
                                                afterDismiss:^(int buttonIndex) {
                                                    if (buttonIndex == 0)   [self save];    //调用save函数
                                                }];
    //设置第二个按钮为灰色按钮
    [alertView setButtonStyle:XYButtonStyleGray atIndex:1];
    [alertView show];
}

//保存当前数据
-(void)save {
    //提示保存成功
    XYAlertView *alertView = [XYAlertView alertViewWithTitle:nil
                                                     message:@"保存成功！"
                                                     buttons:[NSArray arrayWithObjects:@"好的", nil]
                                                afterDismiss:^(int buttonIndex) {
                                                }];
    [alertView show];
}

//重新生成新的支出记录页面
-(void)resetView {
    NSLog(@"reset!");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //设置标签可点击
    [self.accountLabel setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapForAcc = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentAcc)];
    UITapGestureRecognizer *tapForTime = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentTimePicker)];
    UITapGestureRecognizer *tapForCreditor = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentCreditor)];
    UITapGestureRecognizer *tapForCategory = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentCategory)];
    
    [self.accountLabel addGestureRecognizer:tapForAcc];
    [self.timeLabel addGestureRecognizer:tapForTime];
    [self.creditorLabel addGestureRecognizer:tapForCreditor];
    [self.categoryLabel addGestureRecognizer:tapForCategory];
    
}
//点击子视图空白处能够隐藏键盘
- (IBAction)bgTap:(id)sender {
    
    if ([self.parentViewController respondsToSelector:@selector(backgroundTap:)])
    {
        KOMAccountingViewController *acc =
        (KOMAccountingViewController *)self.parentViewController ;
        [acc backgroundTap:self];
    }
}




//显示账户选项
-(void)presentAcc {
    
    //切换页面时先去掉cash输入框的第一反应资格
    [self.cash resignFirstResponder];
    
    KOMNavViewController * nav = [self.storyboard instantiateViewControllerWithIdentifier:@"AccNav"];
    
    KOMAccountTableViewController *tableVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AccTable"];
    [nav pushViewController:tableVC animated:NO];
    
    //设置代理
    tableVC.delegate = self;
    
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:nav animated:YES completion:nil];
}

//显示time picker
-(void)presentTimePicker {
    
    //切换页面时先去掉cash输入框的第一反应资格
    [self.cash resignFirstResponder];
    
    KOMNavViewController * nav = [self.storyboard instantiateViewControllerWithIdentifier:@"AccNav"];
    KOMTimePickerViewController *timeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TimePicker"];
    [nav pushViewController:timeVC animated:NO];
    
    timeVC.delegate = self;
    
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)presentCreditor {
    
    //切换页面时先去掉cash输入框的第一反应资格
    [self.cash resignFirstResponder];
    
    KOMNavViewController * nav = [self.storyboard instantiateViewControllerWithIdentifier:@"AccNav"];
    KOMCreditorTableViewController *creditorVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CreditorTable"];
    [nav pushViewController:creditorVC animated:NO];
    
    creditorVC.delegate = self;
    
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:nav animated:YES completion:nil];
}

//显示还款类别界面
-(void)presentCategory {
    
    //切换页面时先去掉cash输入框的第一反应资格
    [self.cash resignFirstResponder];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = UIViewAnimationCurveEaseInOut;
    transition.type = kCATransitionFade;
    transition.subtype = kCAGravityTopRight;
    [[self.view layer] addAnimation:transition forKey:@"transision"];
    [self.view addSubview:_repayVC.view];
    
    //当前金额不为0时，直接传入还款界面中
    if ([_cash.text doubleValue] != 0) {
        _repayVC.cashText.text = _cash.text;
    }
}


#pragma mark - KOMAccountTableViewController delegate
-(void)changeAccount:(NSString *)text {
    self.accountLabel.text = text;
}

#pragma  mark - KOMTimePickerViewController delegate
-(void)changeTimeText:(NSString *)text {
    self.timeLabel.text = text;
}

#pragma  mark - KOMCreditorTableViewController delegate
-(void)changeCreditor:(NSString *)text {
    self.creditorLabel.text = text;
}

#pragma mark - KOMCategoryTableViewController delegate
-(void)changeCategory:(NSString *)text {
    self.categoryLabel.text = text;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
