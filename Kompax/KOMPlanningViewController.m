//
//  KOMPlanningViewController.m
//  Kompax
//
//  Created by Bryan on 13-7-23.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMPlanningViewController.h"
#import "KOMFolderTableViewCell.h"
#import "KOMRiskQuestionnaireViewController.h"

@interface KOMPlanningViewController ()

@end

@implementation KOMPlanningViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSArray *)items
{
    if (_items == nil){
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"PlanningItem" withExtension:@"plist"];
        _items = [NSArray arrayWithContentsOfURL:url];
    }
    return _items;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _goalView = [self.storyboard instantiateViewControllerWithIdentifier:@"GoalView"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _questionView = [[KOMRiskQuestionnaireViewController alloc] init];
    _goalView = [self.storyboard instantiateViewControllerWithIdentifier:@"GoalView"];
    
	// Do any additional setup after loading the view.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"item_cell";
    
    KOMFolderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[KOMFolderTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                             reuseIdentifier:CellIdentifier] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *temp = [self.items objectAtIndex:indexPath.row];
    cell.logo.image = [UIImage imageNamed:[[temp objectForKey:@"imageName"] stringByAppendingString:@".png"]];
    cell.title.text = [temp objectForKey:@"title"];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    
    UIViewController *showVC = nil;
    
    if (row == 0) {
        showVC = _questionView;
        _tableView.scrollEnabled = NO;  //打开问卷时使得tableview无法滚动
    }
    else if (row == 1) {
        _goalView.view.frame = CGRectMake(0, 0, 320, 330);
        showVC = _goalView;
         _tableView.scrollEnabled = NO;
    }
    else {
        return;
    }
    
    //展开子视图
    [_tableView openFolderAtIndexPath:indexPath WithContentView:showVC.view
                            openBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                
                            }
                           closeBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                           }
                      completionBlock:^{
                            _tableView.scrollEnabled = YES; //tableview恢复滚动
                      }];
}

-(void)expand:(UIViewController *)subVC atIndexPath:indexPath {
    [_tableView openFolderAtIndexPath:indexPath WithContentView:subVC.view
                            openBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                
                            }
                           closeBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                               [_tableView becomeFirstResponder];}
                      completionBlock:^{
                          
                      }];
    
}

-(CGFloat)tableView:(UIFolderTableView *)tableView xForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
