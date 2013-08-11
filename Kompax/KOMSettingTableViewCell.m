//
//  KOMSettingTableViewCell.m
//  Kompax
//
//  Created by Bryan on 13-8-12.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMSettingTableViewCell.h"

@implementation KOMSettingTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.logo = [[UIImageView alloc] initWithFrame:CGRectMake(35, 20, 21, 23)];
        self.logo.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.logo];
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(70, 20, 128, 20)] ;
        self.title.font = [UIFont boldSystemFontOfSize:16.0f];
        self.title.textColor = [UIColor colorWithRed:97/255.0 green:151/255.0 blue:191/255.0 alpha:1.0];
        self.title.backgroundColor = [UIColor clearColor];
        self.title.opaque = NO;
        [self.contentView addSubview:self.title];
        
        
        self.other = [[UILabel alloc] initWithFrame:CGRectMake(200, 20, 100, 20)] ;
        [self.contentView addSubview:self.other];
        
        UILabel *sLine1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 48, 320, 1)];
        sLine1.backgroundColor = [UIColor colorWithRed:97/255.0
                                                 green:151/255.0
                                                  blue:191/255.0
                                                 alpha:1.0];
        UILabel *sLine2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 49, 320, 1)];
        sLine1.backgroundColor = [UIColor colorWithRed:97/255.0
                                                 green:151/255.0
                                                  blue:191/255.0
                                                 alpha:1.0];
        [self.contentView addSubview:sLine1];
        [self.contentView addSubview:sLine2];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
