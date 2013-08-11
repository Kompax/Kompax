//
//  KOMCostViewController.m
//  Kompax
//
//  Created by Bryan on 13-7-27.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "KOMCostViewController.h"
#import "KOMAccountingViewController.h"
#import "KOMNavViewController.h"
#import "KOMBarDraw.h"
#import "KOMConstants.h"
#import "XYAlertViewHeader.h"

static NSString *GLOBAL_TIMEFORMAT = @"yyyy-MM-dd HH:mm:ss";

@interface KOMCostViewController ()

@end

@implementation KOMCostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
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
    
    _categoryLabel.text = @"餐饮 > 早餐";
    _accountLabel.text = @"现金"; //初始化账户
    _memberLabel.text = @"自己";  //初始化成员
    
    planedCost = 700.0f;
    didCost = 200.0f;
    
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showComfirm)];
    [swipeRecognizer setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:swipeRecognizer];   //给self.view添加一个手势监测；
    
    //手动设置cash栏
    _cash.text = @"0.00";        //初始化现金
    _cash.font = [UIFont fontWithName:@"Helvetica" size:40];
    _cash.textColor = [UIColor colorWithRed:239/255.0 green:100/255.0 blue:79/255.0 alpha:1.0];
    _cash.textAlignment = NSTextAlignmentRight;
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
    UITapGestureRecognizer *tapForMember = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentMember)];
    UITapGestureRecognizer *tapForCategory = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presentCategory)];
    
    [self.accountLabel addGestureRecognizer:tapForAcc];
    [self.timeLabel addGestureRecognizer:tapForTime];
    [self.memberLabel addGestureRecognizer:tapForMember];
    [self.categoryLabel addGestureRecognizer:tapForCategory];
    
    [self calculateAndDraw];
}

//计算当前支出与计划支出大小关系并且画图
-(void)calculateAndDraw {

    KOMBarDraw *draw = (KOMBarDraw *)self.view;
    
    double current = [_cash.text doubleValue];
    
    draw.mode = kCostMode;      //当前画图为支出画图模式
    
    if (didCost + current <= planedCost) {
        
        draw.drawingMode = kNotOverspent;
        draw.larger = planedCost;
        draw.smaller = didCost + current;
        
    }   //未超支
    else {
        draw.drawingMode = kOverspent;
        draw.smaller = planedCost;
        draw.larger = didCost + current;
    }   //已超支
    
    //画图
    [draw setNeedsDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击子视图空白处能够隐藏键盘
- (IBAction)bgTap:(id)sender {
    
    [self calculateAndDraw];
    
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

-(void)presentMember {
    
    //切换页面时先去掉cash输入框的第一反应资格
    [self.cash resignFirstResponder];
    
    KOMNavViewController * nav = [self.storyboard instantiateViewControllerWithIdentifier:@"AccNav"];
    KOMMemberTableViewController *memberVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MemberTable"];
    [nav pushViewController:memberVC animated:NO];
    
    memberVC.delegate = self;
    
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)presentCategory {
    
    //切换页面时先去掉cash输入框的第一反应资格
    [self.cash resignFirstResponder];
    
    KOMNavViewController * nav = [self.storyboard instantiateViewControllerWithIdentifier:@"AccNav"];
    KOMCategoryTableViewController *categoryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Category"];
    [nav pushViewController:categoryVC animated:NO];
    
    categoryVC.delegate = self;
    
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:nav animated:YES completion:nil];
}


#pragma mark - KOMAccountTableViewController delegate
-(void)changeAccount:(NSString *)text {
    self.accountLabel.text = text;
}

#pragma  mark - KOMTimePickerViewController delegate
-(void)changeTimeText:(NSString *)text {
    self.timeLabel.text = text;
}

#pragma  mark - KOMMemberTableViewController delegate
-(void)changeMember:(NSString *)text {
    self.memberLabel.text = text;
}

#pragma mark - KOMCategoryTableViewController delegate
-(void)changeCategory:(NSString *)text {
    self.categoryLabel.text = text;
}


@end
