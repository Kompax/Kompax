//
//  KOMSettingViewController.m
//  Kompax
//
//  Created by Bryan on 13-7-23.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMSettingViewController.h"
#import "KOMSettingTableViewCell.h"

@interface KOMSettingViewController ()

@end

@implementation KOMSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(NSArray *)items
{
    if (_items == nil){
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"SettingItem" withExtension:@"plist"];
        _items = [NSArray arrayWithContentsOfURL:url];
        
    }
    return _items;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    _tableView.scrollEnabled = NO;
    _emailIsImported = NO;
    _netAccIsImported = NO;
    
    //添加通知观察者，观察是否需要将tableview上滚，以免子界面textField被键盘挡住
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(scrollUp:) name:@"TableViewScrollUp" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(scrollDown) name:@"TableViewScrollDown" object:nil];
}

//tableview上滚
-(void)scrollUp:(NSNotification *)notification {
    NSNumber *number = (NSNumber *)notification.object;
    int offset = [number intValue];
    [_tableView setContentOffset:CGPointMake(0, 110+offset) animated:YES];
}

//tableview下滚
-(void)scrollDown {
    
    //恢复原状
    [_tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"item_cell";
    
    KOMSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[KOMSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
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
    if(indexPath.row == 1 || indexPath.row == 4) return ;
    
    //账号界面
    if (indexPath.row == 0)  _subVC = [[KOMImportViewController alloc] initWithState:NormalState isImported:NO];
        
    else if (indexPath.row == 2) {
        _subVC = [[KOMImportViewController alloc] initWithState:EmailState isImported:_emailIsImported];
        
        if (_emailIsImported ) {
            //已经导入的，传递密码
            _subVC.account  = _email_account;
            _subVC.password = _email_password;
        }
    }   //收信箱数据导入
    else if (indexPath.row == 3) {
        _subVC = [[KOMImportViewController alloc] initWithState:NetAccState isImported:_netAccIsImported];
        
        if (_netAccIsImported) {
            _subVC.account = _net_account;
            _subVC.password = _net_password;
        }
    }   //网络账户数据导入
    
    _subVC.father = self;
    
    //展开子视图
    [_tableView openFolderAtIndexPath:indexPath WithContentView:_subVC.view
                            openBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                
                            }
                           closeBlock:^(UIView *subClassView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction){
                                                     [_tableView becomeFirstResponder];}
                      completionBlock:^{
                          
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
