//
//  KOMGoalSettingViewController.m
//  Kompax
//
//  Created by Bryan on 13-9-12.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMGoalSettingViewController.h"

@interface KOMGoalSettingViewController ()

@end

@implementation KOMGoalSettingViewController

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
    _firstVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstGoal"];
    _firstVC.view.frame = CGRectMake(0, 0, 320, 480);
    
    _feasibilityVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Feasibility"];
    _feasibilityVC.view.frame = CGRectMake(0, 0, 320, 480);
    
    _suggestVC = [[UIViewController alloc]init];
    _suggestVC.view.frame = CGRectMake(0, 0, 320, 480);
    _suggestVC.view.backgroundColor = [UIColor whiteColor];
    
    //"暂无建议"
    UILabel *noSuggestLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 100, 260, 30)];
    [noSuggestLabel setText:@"该功能目前暂未实现"];
    [noSuggestLabel setTextAlignment:NSTextAlignmentCenter];
    [_suggestVC.view addSubview:noSuggestLabel];
    
    _state = 1; //初始化展示第一界面
    
    [_firstLabel setTextColor:[UIColor colorWithRed:138/255.0 green:174/255.0 blue:195/255.0 alpha:1.0]];
    
    [_displayView addSubview:_suggestVC.view];
    [_displayView addSubview:_feasibilityVC.view];
    [_displayView addSubview:_firstVC.view];
    
    [self addChildViewController:_suggestVC];
    [self addChildViewController:_feasibilityVC];
    [self addChildViewController:_firstVC];
    
    for(int i = 1;i<=3 ;i++) {
        UILabel *tempLabel = (UILabel *)[self.view viewWithTag:i+50];
        [tempLabel setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeView:)];
        [tempLabel addGestureRecognizer:tap];
    }
}

-(void)changeView:(id)sender {
    int tag = ((UITapGestureRecognizer *)sender).view.tag - 50;
    _state = tag;
    
    switch (tag) {
        case 1:
        {
            [_displayView bringSubviewToFront:_firstVC.view];
            break;
        }
        case 2:
        {
            [_displayView bringSubviewToFront:_feasibilityVC.view];
            break;
        }
        case 3:
        {
            [_displayView bringSubviewToFront:_suggestVC.view];
            break;
        }
        default:
            break;
    }
    
    //更改标签选中颜色
    for(int i = 1;i<=3;i++) {
        UILabel *tempLabel = (UILabel *)[self.view viewWithTag:i+50];
        if (i == tag) {
            [tempLabel setTextColor:[UIColor colorWithRed:138/255.0 green:174/255.0 blue:195/255.0 alpha:1.0]];
        }
        else {
            [tempLabel setTextColor:[UIColor blackColor]];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
