//
//  KOMRiskQuestionnaireViewController.m
//  Kompax
//
//  Created by Bryan on 13-8-18.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMRiskQuestionnaireViewController.h"
#import "SSCheckBoxView.h"
#import "XYAlertViewHeader.h"
#import "KOMRiskResultViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface KOMRiskQuestionnaireViewController ()

@end

@implementation KOMRiskQuestionnaireViewController

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
    self.view.frame = CGRectMake(0, 0, 320, 310);
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _scrollView.contentSize = CGSizeMake(320, 480*4+100);
    _scrollView.scrollEnabled = YES;
}

//获取各题目信息
-(NSArray *)questions {
    
    if (_questions == nil) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"RiskQuestionnaire" withExtension:@"plist"];
        _questions = [NSArray arrayWithContentsOfURL:url];
    }
    return _questions;
}

//获取各题对应各选项分数
-(NSArray *)questionScores {
    
    if (_questionScores == nil) {
        //问题总数
        int numberOfQuestions = [self.questions count];
        _questionScores = [NSMutableArray arrayWithCapacity:numberOfQuestions];
        
        for(int i = 0;i < numberOfQuestions ; i++) {
            NSDictionary *each = [self.questions objectAtIndex:i];
            int num = [[each objectForKey:@"itemNum"] intValue];
            
            //储存每个问题对应选项的分数
            NSMutableArray *eachArray = [NSMutableArray arrayWithCapacity:num];
            
            for(int j = 0;j < num;j++) {
                NSString *key = [NSString stringWithFormat:@"item%c",j+65];
                NSDictionary *innerDict = [each objectForKey:key];
                [eachArray addObject:[innerDict objectForKey:@"score"]];
            }
            [_questionScores addObject:eachArray];
        }
    }
    return _questionScores;
}

-(void)loadQuestions:(UIScrollView *)scrollView {
    
    int count = [self.questions count];
    
    int offset = 10;    //初始偏移为10
    
    _checkboxArray = [[NSMutableArray alloc] initWithCapacity:count];
    _selected = [[NSMutableArray alloc] initWithCapacity:count];
    
    
    for(int i = 0;i<count;i++) {
        
        //设置选中勾选框初始化选项都是0
        NSNumber *tempNumber = [[NSNumber alloc] initWithInt:0];
        [_selected addObject:tempNumber];
        
        NSDictionary *each = [_questions objectAtIndex:i];
        
        //加载问题
        NSString *subQuestion = [each objectForKey:@"question"];
        NSString *question = [NSString stringWithFormat:@"%d. %@",i+1,subQuestion];
        UILabel *quesLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, offset, 260, 40)];
        offset += 42;
        quesLabel.lineBreakMode = NSLineBreakByCharWrapping;
        quesLabel.numberOfLines = 0;
        [quesLabel setText:question];
        [quesLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [scrollView addSubview:quesLabel];
        
        int num = [[each objectForKey:@"itemNum"]intValue];
      
        //设置每道题的勾选框
        NSMutableArray *eachCheckboxArray = [[NSMutableArray alloc] initWithCapacity:num];
        
        for(int j = 0;j<num;j++) {
            NSString *eachLabelKey = [NSString stringWithFormat:@"item%c",j+65];
            NSDictionary *selectionDict = [each objectForKey:eachLabelKey];
            NSString *selection =[NSString stringWithFormat:@"%c. %@",j+65,[selectionDict objectForKey:@"selection"]];
            
            //加载问题
            UILabel *selLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, offset, 210, 30)];
            selLabel.lineBreakMode = NSLineBreakByCharWrapping;
            selLabel.numberOfLines = 0;
            [selLabel setText:selection];
            [selLabel setFont:[UIFont systemFontOfSize:13]];
            [scrollView addSubview:selLabel];
            
            //加载勾选框
            SSCheckBoxViewStyle style = kSSCheckBoxViewStyleGlossy;
            CGRect frame = CGRectMake(40, offset-2.5, 30, 30);
            SSCheckBoxView *tempCheck = [[SSCheckBoxView alloc] initWithFrame:frame style:style checked:NO];
            
            tempCheck.tag = i * 100 + j + 1;          //设定tempCheck的tag值，方便跟踪
            [tempCheck addTarget:self action:@selector(changeCheckState:) forControlEvents:UIControlEventTouchUpInside];

            [eachCheckboxArray addObject:tempCheck];
            [scrollView addSubview:tempCheck];

            offset += 40;
        }
        
        [_checkboxArray addObject:eachCheckboxArray];
    }
    
    
    _submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_submitButton setFrame:CGRectMake(50, offset+40, 90, 40)];
    [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [_submitButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:_submitButton];
    
    _eliminateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_eliminateButton setFrame:CGRectMake(180, offset+40, 90, 40)];
    [_eliminateButton setTitle:@"清空" forState:UIControlStateNormal];
    [_eliminateButton addTarget:self action:@selector(eliminate) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:_eliminateButton];
}

//更改checkbox选项
-(void)changeCheckState:(SSCheckBoxView *)sender {
    
    int questionNum = sender.tag / 100 ;
    int currentSelectionNum = sender.tag % 100 ;
    
    NSMutableArray *tempArray = [_checkboxArray objectAtIndex:questionNum];
    int totalCheck = [tempArray count];
    
    for(int i = 0;i<totalCheck;i++) {
        SSCheckBoxView *temp = [tempArray objectAtIndex:i];
        if (i+1 == currentSelectionNum) {
            temp.checked = YES;
        }
        else {
            temp.checked = NO;
        }
    }
    
    NSNumber *selectedNumber = [[NSNumber alloc]initWithInt:currentSelectionNum];
    [_selected setObject:selectedNumber atIndexedSubscript:questionNum];
    
}

//提交操作
-(void)submit {
    
    int count = [self.questions count];
    int total = 0;  //总分
    
    //检测是否已填写所有题目
    for (int i = 0; i<count; i++) {
        NSNumber *tempNum = [_selected objectAtIndex:i];
        int tempInt = [tempNum intValue];
        if (tempInt == 0) {
            XYShowAlert(@"请完成所有题目后再提交！");
            return;
        }
        total += tempInt;
    }
    
    KOMRiskResultViewController *resultVC = [[KOMRiskResultViewController alloc]init];
    
    //计算风险级别
    if (total >= 9 && total < 13)               resultVC.risk = 0;
    else if (total >= 13 && total < 19)         resultVC.risk = 1;
    else if (total >= 19 && total < 28)         resultVC.risk = 2;
    else if (total >= 28 && total < 31)         resultVC.risk = 3;
    else                                        resultVC.risk = 4;

    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = UIViewAnimationCurveEaseInOut;
    transition.type = kCATransitionFade;
    transition.subtype = kCAGravityTopRight;
    [[self.view layer] addAnimation:transition forKey:@"transision"];
    
    [self.view addSubview:resultVC.view];
    [self addChildViewController:resultVC];
}



//清除之前的选择
-(void)eliminate {
    
    int totalCount = [_checkboxArray count];
    
    for(int i = 0;i<totalCount;i++) {
        
        NSMutableArray *eachArray = [_checkboxArray objectAtIndex:i];
        int tempCount = [eachArray count];
        
        for(int j = 0;j<tempCount;j++ ) {
            SSCheckBoxView *tempCheckbox = [eachArray objectAtIndex:j];
            tempCheckbox.checked = NO;
        }
        
        NSNumber *zero = [[NSNumber alloc]initWithInt:0];
        [_selected setObject:zero atIndexedSubscript:i];            //已选项置0
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 310)];
    [self loadQuestions:_scrollView];
    [self.view addSubview:_scrollView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backUp) name:@"backUp" object:nil ];  //让测试页面回到最顶
}

//让测试页面回到最顶
-(void)backUp {
    _scrollView.contentOffset = CGPointMake(0, 0);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
