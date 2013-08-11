//
//  KOMIncomeCategoryTableViewController.h
//  Kompax
//
//  Created by Bryan on 13-8-1.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KOMIncomeCategoryDelegate <NSObject>

-(void)changeIncomeCategory:(NSString *)text;

@end

@interface KOMIncomeCategoryTableViewController : UITableViewController

@property(strong,nonatomic) NSMutableArray *data;
@property(assign,nonatomic) id<KOMIncomeCategoryDelegate> delegate;

@end
