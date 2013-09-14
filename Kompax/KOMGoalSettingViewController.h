//
//  KOMGoalSettingViewController.h
//  Kompax
//
//  Created by Bryan on 13-9-12.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KOMFirstGoalViewController.h"
#import "KOMFeasibilityAnaViewController.h"

@interface KOMGoalSettingViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *firstLabel;
@property (strong, nonatomic) IBOutlet UILabel *secondLabel;
@property (strong, nonatomic) IBOutlet UILabel *thirdLabel;

@property (strong, nonatomic) IBOutlet UIControl *displayView;

@property (assign,nonatomic) int state;     //记录当前displayView是在展示哪个子界面

@property (strong,nonatomic) KOMFirstGoalViewController *firstVC;
@property (strong,nonatomic) KOMFeasibilityAnaViewController *feasibilityVC;
@property (strong,nonatomic) UIViewController *suggestVC;

@end
