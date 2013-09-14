//
//  KOMPlanningViewController.h
//  Kompax
//
//  Created by Bryan on 13-7-23.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFolderTableView.h"
#import "KOMRiskQuestionnaireViewController.h"
#import "KOMGoalSettingViewController.h"

@interface KOMPlanningViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong,nonatomic) NSArray *items;
@property (strong,nonatomic) IBOutlet UIFolderTableView *tableView;
@property (strong,nonatomic) KOMRiskQuestionnaireViewController *questionView;
@property (strong,nonatomic) KOMGoalSettingViewController *goalView;

@end
