//
//  KOMCreditorViewController.h
//  Kompax
//
//  Created by Bryan on 13-8-2.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KOMCreditorTableViewDelegate <NSObject>

-(void)changeCreditor:(NSString *)text;

@end

@interface KOMCreditorTableViewController : UITableViewController

@property (strong,nonatomic) NSMutableArray *data;
@property (assign,nonatomic) id<KOMCreditorTableViewDelegate> delegate;

@end
