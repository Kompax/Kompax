//
//  KOMRiskQuestionnaireViewController.h
//  Kompax
//
//  Created by Bryan on 13-8-18.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KOMRiskQuestionnaireViewController : UIViewController

@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) NSArray *questions;
@property (strong,nonatomic) NSMutableArray *questionScores;
@property (strong,nonatomic) NSMutableArray *selected;            //记录每题勾选的选项

@property (strong,nonatomic) NSMutableArray *checkboxArray;         //存储所有题目的勾选框

@property (strong,nonatomic) UIButton *eliminateButton;
@property (strong,nonatomic) UIButton *submitButton;

@end
