//
//  KOMRepaymentViewController.h
//  Kompax
//
//  Created by Bryan on 13-8-6.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KOMRepaymentViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

//3种还款类别标签
@property (strong, nonatomic) IBOutlet UILabel *category_1;
@property (strong, nonatomic) IBOutlet UILabel *category_2;
@property (strong, nonatomic) IBOutlet UILabel *category_3;

//3种还款频率标签
@property (strong, nonatomic) IBOutlet UILabel *monthLabel;
@property (strong, nonatomic) IBOutlet UILabel *seasonLabel;
@property (strong, nonatomic) IBOutlet UILabel *yearLabel;


//输入框
@property (strong, nonatomic) IBOutlet UITextField *cashText;
@property (strong, nonatomic) IBOutlet UITextField *interestText;
@property (strong, nonatomic) IBOutlet UITextField *repayYearsText;
@property (strong, nonatomic) IBOutlet UITextField *firstBorrowTimeText;

//选中类别标签下面的横线
@property (strong,nonatomic) UILabel *bar;

//还款类别数组
@property (strong,nonatomic) NSArray *repaymentCategoryArray;

//还款频率数组
@property (strong,nonatomic) NSArray *frequencyArray;


@property(assign,nonatomic) unsigned int selectedCategory;  //选中的类别
@property(assign,nonatomic) unsigned int selectedFrequency; //选中的频率

//还款频率标签
@property (strong, nonatomic) IBOutlet UILabel *freLabel;
//初始借款时间标签
@property (strong, nonatomic) IBOutlet UILabel *firstLabel;

@end
