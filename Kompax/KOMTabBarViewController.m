//
//  KOMTabBarViewController.m
//  Kompax
//
//  Created by Bryan on 13-7-23.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMTabBarViewController.h"
#import "KOMPlanningViewController.h"
#import "KOMStatisticViewController.h"
#import "KOMSettingViewController.h"
#import "KOMUserViewController.h"
#import "KOMPagingSwipeViewController.h"
#import "KOMMainPageViewController.h"

@interface KOMTabBarViewController ()

@end

@implementation KOMTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.tabBar setHidden:NO];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tabBar setUserInteractionEnabled:YES];
    //设置开始页面是主页
       
     _buttonArray = [[NSMutableArray alloc]initWithCapacity:5]; //初始化buttonArray
    [self loadTabbar];                                          //调用loadtabbar函数
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    KOMPlanningViewController *planVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Planning"];
    KOMStatisticViewController *staVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Statistic"];
    KOMPagingSwipeViewController *pageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PageSwipe"];
    KOMUserViewController *userVC = [self.storyboard instantiateViewControllerWithIdentifier:@"User"];
    KOMSettingViewController *setVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Setting"];
    
    NSArray *viewControllers = @[planVC,staVC,pageVC,userVC,setVC];
    [self setViewControllers:viewControllers];
    self.selectedIndex = 2;  
}

//载入自定义tabbar
-(void)loadTabbar{
    UIImageView *tabbarBG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"back.png"]];
    tabbarBG.frame = CGRectMake(0, 431, 320, 49);
    [tabbarBG setUserInteractionEnabled:YES];
    [self.view addSubview:tabbarBG];
    
    //定义选中背景
    _selectView = [[UIImageView alloc]initWithFrame:CGRectMake(0+2*64, 0, 64, 49)];
    _selectView.image = [UIImage imageNamed:@"box"];
    
    [tabbarBG addSubview:_selectView];
    
    //设置5个tabbar按钮
    float coX = 0;
    for (int index=0; index<5;index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame  = CGRectMake(0+coX, 0, 64, 49);
        button.tag = index;
        
        //初始化的时候中间按钮为蓝色背景
        NSString *buttonName ;
        if (index==2)
            buttonName = [NSString stringWithFormat:@"%d'",index+1];
        else
            buttonName = [NSString stringWithFormat:@"%d",index+1];
        
        [button setImage:[UIImage imageNamed:buttonName] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
        
        [tabbarBG addSubview:button];
        [_buttonArray addObject:button];
        coX += 64;                  //button横坐标递增
    }
}

//tabbar按钮按下时按钮与box的转换
- (void)change:(UIButton *)button {
    //设置选中框动态移动
    self.selectedIndex = button.tag;
    
    [UIView beginAnimations:nil context:NULL];
    _selectView.frame = CGRectMake(0+ button.tag * 64, 0, 64, 49);
     [UIView commitAnimations];
    
    //检测5个button状态，选中的为蓝色，没选中的为黑色
    for(int index = 0;index<5;index++) {
        UIButton *tempButton = [_buttonArray objectAtIndex:index];
        if (index != button.tag) {
            [tempButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",index+1]] forState:UIControlStateNormal];
        }
        else {
           [tempButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d'",index+1]] forState:UIControlStateNormal];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
