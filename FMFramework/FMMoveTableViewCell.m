//
//  FMMoveTableViewCell.m
//  FMFramework
//
//  Created by Florian Mielke.
//  Copyright 2012 Florian Mielke. All rights reserved.
//  


#import "FMMoveTableViewCell.h"

@implementation FMMoveTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.textLabel setFont:[UIFont boldSystemFontOfSize:11.3f]];
        self.textLabel.backgroundColor = [UIColor colorWithRed:236/255.0 green:241/255.0 blue:236/255.0 alpha:1.0];
        self.contentView.backgroundColor = [UIColor colorWithRed:236/255.0 green:241/255.0 blue:236/255.0 alpha:1.0];
        
        UILabel *coverUp = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 66, 2)];
        [coverUp setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:coverUp];
        
        UILabel *coverDown = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, 66, 2)];
        [coverDown setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:coverDown];
        
    }
    return self;
}


- (void)prepareForMove
{
	[[self textLabel] setText:@""];
	[[self detailTextLabel] setText:@""];
	[[self imageView] setImage:nil];
}



@end
