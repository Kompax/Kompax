//
//  KOMCategoryViewController.h
//  Kompax
//
//  Created by Bryan on 13-7-30.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KOMCategoryTableViewDelegate <NSObject>

-(void)changeCategory:(NSString *)text;

@end

@interface KOMCategoryTableViewController : UITableViewController


@property (assign,nonatomic) id<KOMCategoryTableViewDelegate> delegate;

@property (strong,nonatomic) NSMutableDictionary *data;
@property (strong,nonatomic) NSArray *section;

@end
