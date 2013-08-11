//
//  KOMMemberTableViewController.h
//  Kompax
//
//  Created by Bryan on 13-7-29.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KOMMemberTableViewDelegate <NSObject>

-(void)changeMember:(NSString *)text;

@end

@interface KOMMemberTableViewController : UITableViewController

@property (strong,nonatomic) NSMutableArray *data;
@property (assign,nonatomic) id<KOMMemberTableViewDelegate> delegate;

@end
