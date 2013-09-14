//
//  KOMFirstGoalViewController.h
//  Kompax
//
//  Created by Bryan on 13-9-12.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMMoveTableView.h"
#import "KOMHouseGoalViewController.h"
#import "KOMCarGoalViewController.h"
#import "KOMInsuranceGoalViewController.h"
#import "KOMRetireGoalViewController.h"
#import "KOMEducateViewController.h"

typedef enum {
    kHouse = 0,
    kCar,
    kInsurance,
    kRetire,
    kEducate
} selectedMode;


@interface KOMFirstGoalViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet FMMoveTableView *tableView;
@property (strong,nonatomic) NSMutableArray *goals;

@property (strong,nonatomic) KOMHouseGoalViewController *houseVC;
@property (strong,nonatomic) KOMCarGoalViewController *carVC;
@property (strong,nonatomic) KOMInsuranceGoalViewController *insuranceVC;
@property (strong,nonatomic) KOMRetireGoalViewController* retireVC;
@property (strong,nonatomic) KOMEducateViewController *educateVC;

@property (assign,nonatomic) selectedMode mode;  //当前选中的模式





@end
