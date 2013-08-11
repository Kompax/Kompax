//
//  KOMDebitorTableViewController.h
//  Kompax
//
//  Created by Bryan on 13-8-2.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KOMDebitorTableViewDelegate <NSObject>

-(void)changeDebitor:(NSString *)text;

@end

@interface KOMDebitorTableViewController : UITableViewController

@property (strong,nonatomic) NSMutableArray *data;
@property (assign,nonatomic) id<KOMDebitorTableViewDelegate> delegate;



@end
