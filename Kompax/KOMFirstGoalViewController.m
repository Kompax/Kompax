//
//  KOMFirstGoalViewController.m
//  Kompax
//
//  Created by Bryan on 13-9-12.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMFirstGoalViewController.h"
#import "FMMoveTableViewCell.h"


@interface KOMFirstGoalViewController ()

@end

@implementation KOMFirstGoalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _scrollView.contentSize = CGSizeMake(150, 400);
   // [_scrollView setScrollEnabled:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView.separatorStyle = NO;
    _goals = [NSMutableArray arrayWithObjects:@"房贷目标",@"车贷目标",@"保险计划",@"退休计划",@"教育基金", nil];
    
    //设置第一项为默认选中
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];
    [_tableView setScrollEnabled:NO];
    
    _mode = kHouse;         //初始状态默认选中房贷计划
    
    _houseVC = [[KOMHouseGoalViewController alloc]init];
    _carVC = [[KOMCarGoalViewController alloc]init];
    _insuranceVC = [[KOMInsuranceGoalViewController alloc]init];
    _retireVC = [[KOMRetireGoalViewController alloc]init];
    _educateVC = [[KOMEducateViewController alloc]init];
    
    [_scrollView addSubview:_educateVC.view];
    [_scrollView addSubview:_retireVC.view];
    [_scrollView addSubview:_insuranceVC.view];
    [_scrollView addSubview:_carVC.view];
    [_scrollView addSubview:_houseVC.view];
    
    [self addChildViewController:_educateVC];
    [self addChildViewController:_retireVC];
    [self addChildViewController:_insuranceVC];
    [self addChildViewController:_carVC];
    [self addChildViewController:_houseVC];
    
//    UITapGestureRecognizer *background = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundTap)];
//    [self.view addGestureRecognizer:background];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backgroundTap {
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark Controller life cycle

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_goals count];
}


- (UITableViewCell *)tableView:(FMMoveTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"MoveCell";
	FMMoveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	
	/******************************** NOTE ********************************
	 * Implement this check in your table view data source to ensure that the moving
	 * row's content is reseted
	 **********************************************************************/
    
    if (cell == nil) {
        cell = [[FMMoveTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        //设置cell选中后的背景图
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"planning-item"]];
        
    }
    
	if ([tableView indexPathIsMovingIndexPath:indexPath])
	{
		[cell prepareForMove];
	}
	else
	{
		
		[cell.textLabel setText:[_goals objectAtIndex:[indexPath row]]];
		[cell setShouldIndentWhileEditing:NO];
		[cell setShowsReorderControl:NO];
	}
	
	return cell;
}

#pragma mark -
#pragma mark Table view data source

- (void)moveTableView:(FMMoveTableView *)tableView moveRowFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
	NSString *move = [self.goals objectAtIndex:[fromIndexPath row]];
	[self.goals removeObjectAtIndex:[fromIndexPath row]];
	[self.goals insertObject:move atIndex:[toIndexPath row]];
}


- (NSIndexPath *)moveTableView:(FMMoveTableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
	if ([sourceIndexPath section] != [proposedDestinationIndexPath section]) {
		proposedDestinationIndexPath = sourceIndexPath;
	}
	
	return proposedDestinationIndexPath;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 32;
}

#pragma mark -
#pragma mark Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int row = [indexPath row];
    
    NSString *selecterString = [_goals objectAtIndex:row];
    
    if ([selecterString isEqualToString:@"房贷目标"]) {
        _mode = kHouse;
        [_scrollView bringSubviewToFront:_houseVC.view];
         _scrollView.contentSize = CGSizeMake(150, 400);
    }
    else if ([selecterString isEqualToString:@"车贷目标"]) {
        _mode = kCar;
        [_scrollView bringSubviewToFront:_carVC.view];
        _scrollView.contentSize = CGSizeMake(150, 350);
    }
    else if ([selecterString isEqualToString:@"保险计划"]) {
        _mode = kInsurance;
        [_scrollView bringSubviewToFront:_insuranceVC.view];
        _scrollView.contentSize = CGSizeMake(150, 400);
    }
    else if ([selecterString isEqualToString:@"退休计划"]) {
        _mode = kRetire;
        [_scrollView bringSubviewToFront:_retireVC.view];
        _scrollView.contentSize = CGSizeMake(150, 350);
    }
    else if ([selecterString isEqualToString:@"教育基金"]) {
        _mode = kEducate;
        [_scrollView bringSubviewToFront:_educateVC.view];
        _scrollView.contentSize = CGSizeMake(150, 400);
    }

    //scrollView恢复原始位置
    _scrollView.contentOffset = CGPointMake(0, 0);
}




@end
