//
//  KOMRepaymentViewController.m
//  Kompax
//
//  Created by Bryan on 13-8-6.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMRepaymentViewController.h"
#import "KOMDebitViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface KOMRepaymentViewController ()

@end

@implementation KOMRepaymentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _scrollView.contentSize = CGSizeMake(320, 960);
    _scrollView.scrollEnabled = NO; //无法滚动
    
    KOMDebitViewController *father = (KOMDebitViewController *)self.parentViewController;
    _selectedCategory = father.category;
    _bar.frame =  CGRectMake(27+(_selectedCategory-1)*95, 80, 78, 2);
    
    //初始化选中类别标签和下面的横线
    UIColor *selectedColor = [UIColor colorWithRed:124/255.0 green:165/255.0 blue:189/255.0 alpha:1.0];
    UIColor *unSelectedColor = [UIColor blackColor];
    
    for(int i = 0;i<3;i++) {
        UILabel *temp = [_repaymentCategoryArray objectAtIndex:i];
        if (i == _selectedCategory -1 ) {
            temp.textColor = selectedColor;
        }
        else {
            temp.textColor = unSelectedColor;
        }
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pageSwipeUnable" object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //添加点击背景取消第一反应
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgTap)];
    [_scrollView addGestureRecognizer:tap];
    
    //向左滑直接返回借记界面
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(goBack)];
    [leftSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [_scrollView addGestureRecognizer:leftSwipe];
    
    //向右滑直接确定返回借记界面
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(confirm)];
    [rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [_scrollView addGestureRecognizer:rightSwipe];
    
    //将3种还款类别放入还款数组中
    _repaymentCategoryArray = [NSArray arrayWithObjects:_category_1,_category_2,_category_3, nil];
    
    //将3种还款频率放入频率数组中
    _frequencyArray = [NSArray arrayWithObjects:_monthLabel,_seasonLabel,_yearLabel, nil];
    
    
    _category_1.tag = 1;
    _category_2.tag = 2;
    _category_3.tag = 3;
    
    _monthLabel.tag = 101;
    _seasonLabel.tag = 102;
    _yearLabel.tag = 103;
    
    //向3种还款类别标签添加点击手势
    for(int i = 0;i<3;i++) {
        UILabel *tempLabel = [_repaymentCategoryArray objectAtIndex:i];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeCategory:)];
        [tempLabel addGestureRecognizer:tap];
        [tempLabel setUserInteractionEnabled: YES];
    }
    
    //向3种还款频率标签添加点击手势
    for(int i = 0;i<3;i++) {
        UILabel *tempLabel = [_frequencyArray objectAtIndex:i];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeFrequency:)];
        [tempLabel addGestureRecognizer:tap];
        [tempLabel setUserInteractionEnabled: YES];
    }
    _selectedCategory = 1;  //选中第一类别
    _selectedFrequency = 1; //选中第一频率
    
    //初始化bar
    UIColor *selectedColor = [UIColor colorWithRed:124/255.0 green:165/255.0 blue:189/255.0 alpha:1.0];
    _bar = [[UILabel alloc]initWithFrame:CGRectMake(27+(_selectedCategory-1)*95, 80, 78, 2)];
    _bar.backgroundColor  = selectedColor;
    [self.view addSubview:_bar];
    
    //初始化选中频率标签
    _monthLabel.textColor = [UIColor blackColor];
 
}

- (void)bgTap {
    [_scrollView endEditing:YES];
    
    if([self.parentViewController respondsToSelector:@selector(bgTap:)]) {
        KOMDebitViewController *father = (KOMDebitViewController *)self.parentViewController;
        [father bgTap:self];
    }
}

//更换还款类别函数
-(void)changeCategory:(id)tap {
    
    //当前点击标签的tag值
    int currentTag = [tap view].tag;
    _selectedCategory = currentTag;
    
    for(int i = 1;i<=3;i++) {
        if (i == currentTag) {
            
            UIColor *selectedColor = [UIColor colorWithRed:133/255.0 green:174/255.0 blue:197/255.0 alpha:1.0];
            UILabel *selected = (UILabel *)[self.view viewWithTag:currentTag];
            selected.textColor = selectedColor;
            
            [UIView beginAnimations:@"ani" context:nil];
            _bar.frame = CGRectMake(27+(i-1)*95, 80, 78, 2);
            [UIView commitAnimations];
            
        }   //当前标签，设置选中
        else {
            UIColor *unSelectedColor = [UIColor blackColor];
            UILabel *unSelected = (UILabel *)[self.view viewWithTag:i];
            unSelected.textColor = unSelectedColor;
        }   //非当前标签，设置未选中
    }
    
    //设置还款频率是否显示
    if (currentTag != 1) {
        [UIView beginAnimations:@"move" context:nil];
        [_freLabel setHidden:YES];
        for ( UILabel *label in _frequencyArray ) {
            [label setHidden:YES];
        }
        
        _firstLabel.frame = CGRectMake(19, 172, 104, 19);
        _firstBorrowTimeText.frame = CGRectMake(125, 172, 143, 19);
        [UIView commitAnimations];
    }
    else {
        [UIView beginAnimations:@"moveBack"context:nil];
        [_freLabel setHidden:NO];
        for ( UILabel *label in _frequencyArray ) {
            [label setHidden:NO];
        }
    
        _firstLabel.frame = CGRectMake(19, 207, 104, 19);
        _firstBorrowTimeText.frame = CGRectMake(125, 207, 143, 19);
        [UIView commitAnimations];
    }

}

//更换还款频率函数
-(void)changeFrequency:(id)tap{
    
    int currentTag = [tap view].tag;
    _selectedFrequency = currentTag - 100;
    
    for(int i = 101;i<=103;i++) {
        if (i == currentTag) {
            UIColor *selectedColor = [UIColor blackColor];
            
            UILabel *selected = (UILabel *)[self.view viewWithTag:currentTag];
            selected.textColor = selectedColor;
            
        }   //当前标签，设置选中
        else {
            UIColor *unSelectedColor = [UIColor colorWithRed:167/255.0 green:171/255.0 blue:171/255.0 alpha:1.0];

            UILabel *unSelected = (UILabel *)[self.view viewWithTag:i];
            unSelected.textColor = unSelectedColor;
        }   //非当前标签，设置未选中
    }

}

//确定并返回主界面
-(void)confirm {
    
    //将还款界面的金额传至外界面
    KOMDebitViewController *father = (KOMDebitViewController *)self.parentViewController;
    father.category = _selectedCategory;
    
    //判断用户输入是否为空
    if (_cashText.text.length != 0) {
        father.cash.text = _cashText.text;
    }
    
    //将还款界面的类别传至外界面
    UILabel *selected = (UILabel *)[self.view viewWithTag:_selectedCategory];
    father.categoryLabel.text = selected.text;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pageSwipeAble" object:nil];
    [self.view removeFromSuperview];
}


//返回借记主界面
-(void)goBack {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pageSwipeAble" object:nil];
    [self.view removeFromSuperview];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
