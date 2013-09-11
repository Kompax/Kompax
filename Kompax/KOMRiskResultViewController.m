//
//  KOMRiskResultViewController.m
//  Kompax
//
//  Created by Bryan on 13-9-11.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMRiskResultViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface KOMRiskResultViewController ()

@end

@implementation KOMRiskResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _scrollView.contentSize = CGSizeMake(320, 480);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.frame = CGRectMake(0, 0, 320, 480);
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 310)];
    [self.view addSubview:_scrollView];
    
    //初始化type和ability数组
    _ability = @[@"高",@"中高",@"中",@"中低",@"低",@"极低"];
    _colors = [NSArray arrayWithObjects:
               [UIColor colorWithRed:197/255.0 green:210/255.0 blue:216/255.0 alpha:1.0],
               [UIColor colorWithRed:167/255.0 green:186/255.0 blue:199/255.0 alpha:1.0],
               [UIColor colorWithRed:125/255.0 green:153/255.0 blue:169/255.0 alpha:1.0],
               [UIColor colorWithRed:67/255.0 green:103/255.0 blue:125/255.0 alpha:1.0],
               [UIColor colorWithRed:4/255.0 green:33/255.0 blue:46/255.0 alpha:1.0], nil];
    
    NSString *firstString = @"通过对您的风险属性进行评估，得到您的风险属性为：";
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"RiskAnalysis" withExtension:@"plist"];
    _analysisArray = [NSArray arrayWithContentsOfURL:url];
    
    NSDictionary *selectedRiskLevel = [_analysisArray objectAtIndex:_risk];
    
    NSString *type = [selectedRiskLevel objectForKey:@"type"];
    NSString *description = [selectedRiskLevel objectForKey:@"description"];
    NSNumber *bearLevel = [selectedRiskLevel objectForKey:@"bear"];
    NSNumber *tolerateLevel = [selectedRiskLevel objectForKey:@"tolerate"];
    
    NSString *bearString = [_ability objectAtIndex:[bearLevel intValue]];
    NSString *tolerateString = [_ability objectAtIndex:[tolerateLevel intValue]];
    UIColor *currentColor = [_colors objectAtIndex:_risk];
    
    //加载界面
    UILabel *firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(34, 4, 252, 40)];
    [firstLabel setText:firstString];
    [firstLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [firstLabel setTextColor:[UIColor blackColor]];
    firstLabel.lineBreakMode = NSLineBreakByCharWrapping;
    firstLabel.numberOfLines = 0;
    [_scrollView addSubview:firstLabel];
    
    UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(34, 48, 60, 25)];
    [typeLabel setText:type];
    typeLabel.textAlignment = NSTextAlignmentCenter;
    [typeLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
    [typeLabel setTextColor:[UIColor whiteColor]];
    [typeLabel setBackgroundColor:currentColor];
    [_scrollView addSubview:typeLabel];
    
    int colorOffset = 0;
    for(int i = 0;i<5;i++) {
        UILabel *tempColorLabel = [[UILabel alloc]initWithFrame:CGRectMake(34, 120+colorOffset, 60, 20)];
        [tempColorLabel setBackgroundColor:[_colors objectAtIndex:i]];
        [_scrollView addSubview:tempColorLabel];
        colorOffset += 50;
    }
    
    int stringOffset = 0;
    for(int i = 0;i<5;i++) {
        UILabel *tempTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(44, 144+stringOffset, 45, 18)];
        [tempTypeLabel setText:[[_analysisArray objectAtIndex:i] objectForKey:@"type"]];
        [tempTypeLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
        [_scrollView addSubview:tempTypeLabel];
        stringOffset += 50;
    }
    
    //确定横线的纵坐标
    int currentOffset = 144 + _risk * 50 + 7;
    
    UILabel *h1 = [[UILabel alloc] initWithFrame:CGRectMake(91, currentOffset, 25, 2)];
    [h1 setBackgroundColor:[UIColor blackColor]];
    [_scrollView addSubview:h1];
    
    UILabel *v1 = [[UILabel alloc] initWithFrame:CGRectMake(116, 110, 2, 270)];
    [v1 setBackgroundColor:[UIColor blackColor]];
    [_scrollView addSubview:v1];
    
    UILabel *h2 = [[UILabel alloc] initWithFrame:CGRectMake(118, 110, 10, 2)];
    [h2 setBackgroundColor:[UIColor blackColor]];
    [_scrollView addSubview:h2];
    
    UILabel *h3 = [[UILabel alloc] initWithFrame:CGRectMake(118, 320, 10, 2)];
    [h3 setBackgroundColor:[UIColor blackColor]];
    [_scrollView addSubview:h3];
    
    UILabel *h4 = [[UILabel alloc] initWithFrame:CGRectMake(118, 378, 10, 2)];
    [h4 setBackgroundColor:[UIColor blackColor]];
    [_scrollView addSubview:h4];
    
    NSString *secondString = [NSString stringWithFormat:@"您属于%@投资者：",type];
    UILabel *secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 103, 180, 18)];
    [secondLabel setText:secondString];
    [secondLabel setTextColor:[UIColor colorWithRed:137/255.0 green:175/255.0 blue:195/255.0 alpha:1.0]];
    [secondLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [_scrollView addSubview:secondLabel];
    
    float fontSize = 13.0f;
    if (_risk == 2) fontSize = 11.5f;
    UILabel *mainContent = [[UILabel alloc]initWithFrame:CGRectMake(127, 120, 170, 200)];
    [mainContent setText:description];
    mainContent.numberOfLines = 0;
    [mainContent setTextColor:[UIColor blackColor]];
    [mainContent setFont:[UIFont boldSystemFontOfSize:fontSize]];
    [_scrollView addSubview:mainContent];
    
    UILabel *bearLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(127, 312, 120, 18)];
    [bearLabel1 setText:@"风险承受能力："];
    [bearLabel1 setTextColor:[UIColor colorWithRed:137/255.0 green:175/255.0 blue:195/255.0 alpha:1.0]];
    [bearLabel1 setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [_scrollView addSubview:bearLabel1];
    
    UILabel *tolerateLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(127, 370, 120, 18)];
    [tolerateLabel1 setText:@"风险容忍态度："];
    [tolerateLabel1 setTextColor:[UIColor colorWithRed:137/255.0 green:175/255.0 blue:195/255.0 alpha:1.0]];
    [tolerateLabel1 setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [_scrollView addSubview:tolerateLabel1];
    
    UILabel *bearLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(239, 310, 120, 22)];
    [bearLabel2 setText:bearString];
    [bearLabel2 setTextColor:[UIColor blackColor]];
    [bearLabel2 setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [_scrollView addSubview:bearLabel2];
    
    UILabel *tolerateLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(239, 368, 120, 22)];
    [tolerateLabel2 setText:tolerateString];
    [tolerateLabel2 setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [tolerateLabel2 setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [_scrollView addSubview:tolerateLabel2];
    
    //返回按钮
    UIButton *back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    back.frame = CGRectMake(120, 420, 80, 40);
    [back setTitle:@"重新测试" forState:UIControlStateNormal];
    [back addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:back];
}

//返回测试界面
-(void)goBack {
    [self.view removeFromSuperview];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backUp" object:nil];       //让测试页面回到最顶
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
