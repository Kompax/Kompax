//
//  KOMCategoryViewController.m
//  Kompax
//
//  Created by Bryan on 13-7-30.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMCategoryTableViewController.h"

@interface KOMCategoryTableViewController ()

@end

@implementation KOMCategoryTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"成员";
    //设置navigationbar上面的返回按钮
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(backUp:)];
    self.navigationItem.leftBarButtonItem = back;
    
    NSArray *diet = @[@"早餐",@"午餐",@"晚餐",@"宵夜"];
    NSArray *trans = @[@"公交",@"打的",@"地铁",@"加油"];
    NSArray *shopping = @[@"日用百货",@"衣服鞋帽",@"数码产品"];
    
    _data = [NSMutableDictionary dictionaryWithObjectsAndKeys:diet,@"餐饮",trans,@"交通",shopping,@"购物", nil];
    _section = [_data allKeys];
}


- (void)backUp:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_section count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [_section objectAtIndex:section];
    return [[_data objectForKey:key] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    NSString *key = [_section objectAtIndex:section];
    cell.textLabel.text = [[_data objectForKey:key]objectAtIndex:row];
    
    return cell;
}

//设置每个section的名字
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_section objectAtIndex:section];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    NSString *sectionString = [_section objectAtIndex:section];
    NSString *rowString = [[_data objectForKey:sectionString]objectAtIndex:row];
    NSString *whole = [NSString stringWithFormat:@"%@ > %@",sectionString,rowString];
    
    [self.delegate changeCategory:whole];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}

@end
