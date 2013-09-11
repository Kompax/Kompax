//
//  KOMRiskResultViewController.h
//  Kompax
//
//  Created by Bryan on 13-9-11.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KOMRiskResultViewController : UIViewController

@property (strong,nonatomic) UIScrollView *scrollView;

@property (assign,nonatomic) int risk;          //风险系数结果
@property (strong,nonatomic) NSArray *ability;  //风险承受能力与容忍态度级别
@property (strong,nonatomic) NSArray *analysisArray;    //风险者描述内容
@property (strong,nonatomic) NSArray *colors;           //风险标签背景颜色

@end
