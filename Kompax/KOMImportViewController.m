//
//  KOMImportViewController.m
//  Kompax
//
//  Created by Bryan on 13-8-12.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMImportViewController.h"
#import "KOMSettingViewController.h"

@interface KOMImportViewController ()

@end

@implementation KOMImportViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//初始化状态
- (id)initWithState:(VCState)state isImported:(BOOL)imported {
    self = [super init];
    if (self) {
        self.state = state;
        self.isImported = imported;
        self.accStateName = (_state == EmailState) ? @"新浪通信达" : @"淘宝";
    }
    return self;
}

//导入界面
-(void)loadView {
    [super loadView];
    
    if (_state == NormalState) {
        [self loadNormalView];
    }   //载入账户界面
    else {
        if (self.isImported) {
            [self loadImportedView];
        }   //账户已导入
        else {
            [self loadNotImportedView];
        }   //账户未导入
    }
}

-(void)loadNormalView {
    UILabel *syn = [[UILabel alloc] initWithFrame:CGRectMake(71, 8, 65, 18)];
    [syn setText:@"同步数据"];
    [syn setBackgroundColor:[UIColor blackColor]];
    syn.textColor = [UIColor whiteColor];
    syn.textAlignment = NSTextAlignmentCenter;
    syn.font = [UIFont systemFontOfSize:15];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = CGRectMake(0, 0, 320, 30);
    [self.view addSubview:syn];
}

//渲染已导入界面
-(void)loadImportedView {
    
    self.view.frame = CGRectMake(0, 0, 320, 48);
    self.view.backgroundColor = [UIColor whiteColor];
    
    //“数据导入”按钮
    UILabel *syn = [[UILabel alloc] initWithFrame:CGRectMake(71, 8, 65, 20)];
    [syn setText:@"数据导入"];
    [syn setBackgroundColor:[UIColor blackColor]];
    syn.textColor = [UIColor whiteColor];
    syn.textAlignment = NSTextAlignmentCenter;
    syn.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:syn];
    
    //账号显示标签
    NSString *fullName =  [_accStateName stringByAppendingFormat:@"账号： %@",_account];
    UILabel *accLabel = [[UILabel alloc]initWithFrame:CGRectMake(74, 30, 200, 15)];
    [accLabel setText:fullName];
    [accLabel setBackgroundColor:[UIColor clearColor]];
    accLabel.textColor = [UIColor blackColor];
    accLabel.textAlignment = NSTextAlignmentLeft;
    accLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:accLabel];
    
    //修改按钮
    UIButton *modify = [[UIButton alloc] initWithFrame:CGRectMake(280, 30, 30, 15)];
    [modify setTitle:@"修改" forState:UIControlStateNormal];
    [modify setBackgroundColor:[UIColor clearColor]];
    modify.titleLabel.font = [UIFont systemFontOfSize:13];
    modify.titleLabel.textColor = [UIColor colorWithRed:152/255.0 green:156/255.0 blue:167/255.0 alpha:1.0];
    [modify setUserInteractionEnabled:YES];
    [modify addTarget:self action:@selector(modifyData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:modify];
}

//渲染未导入界面
-(void)loadNotImportedView {
    self.view.frame = CGRectMake(0, 0, 320, 145);
    self.view.backgroundColor = [UIColor colorWithRed:232/255.0 green:239/255.0 blue:233/255.0 alpha:1.0];
    
    NSString *str1 = [NSString stringWithFormat:@"绑定%@账号",_accStateName];
    
    //提示标签
    UILabel *hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(71, 8, 200, 15)];
    [hintLabel setText:str1];
    [hintLabel setBackgroundColor:[UIColor clearColor]];
    hintLabel.textColor = [UIColor blackColor];
    hintLabel.textAlignment = NSTextAlignmentLeft;
    hintLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:hintLabel];
    
    //提示账户输入标签
    UILabel *accLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 48, 160, 15)];
    [accLabel setText:@"账号"];
    [accLabel setBackgroundColor:[UIColor clearColor]];
    accLabel.textColor = [UIColor blackColor];
    accLabel.textAlignment = NSTextAlignmentLeft;
    accLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:accLabel];
    
    //提示密码输入标签
    UILabel *paswordLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 78, 60, 15)];
    [paswordLabel setText:@"密码"];
    [paswordLabel setBackgroundColor:[UIColor clearColor]];
    paswordLabel.textColor = [UIColor blackColor];
    paswordLabel.textAlignment = NSTextAlignmentLeft;
    paswordLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:paswordLabel];
    
    //账户输入框
    _accountText = [[UITextField alloc]initWithFrame:CGRectMake(118, 43, 140, 20)];
    _accountText.borderStyle = UITextBorderStyleLine;
    _accountText.font = [UIFont systemFontOfSize:15.0f];
    _accountText.delegate = self;
    _accountText.returnKeyType = UIReturnKeyDone;
    [_accountText addTarget:self action:@selector(bgTap) forControlEvents:UIControlEventEditingDidEndOnExit];
    _accountText.autocapitalizationType = UITextAutocapitalizationTypeNone;         //不启动自动首字母大写
    _accountText.autocorrectionType = UITextAutocorrectionTypeNo;                   //不启动自动更正
    
    //密码输入框
    _passwordText = [[UITextField alloc]initWithFrame:CGRectMake(118, 78, 140, 20)];
    _passwordText.borderStyle = UITextBorderStyleLine;
    _passwordText.delegate = self;
    _passwordText.font = [UIFont systemFontOfSize:15.0f];
    _passwordText.returnKeyType = UIReturnKeyDone;
    [_passwordText addTarget:self action:@selector(bgTap) forControlEvents:UIControlEventEditingDidEndOnExit];
     _passwordText.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _passwordText.autocorrectionType = UITextAutocorrectionTypeNo;
    
    NSLog(@"self.view: %@",self.view);
    [self.view addSubview:_accountText];
    [self.view addSubview:_passwordText];
    
    //确认按钮
    _confirm = [[UIButton alloc] initWithFrame:CGRectMake(118, 113, 70, 20)];
    [_confirm setUserInteractionEnabled:YES];
    [_confirm setTitle:@"确认绑定" forState:UIControlStateNormal];
    [_confirm setBackgroundColor:[UIColor colorWithRed:243/255.0 green:130/255.0 blue:46/255.0 alpha:1.0]];
    _confirm.titleLabel.textColor = [UIColor whiteColor];
    _confirm.titleLabel.textAlignment = NSTextAlignmentLeft;
    _confirm.titleLabel.font = [UIFont systemFontOfSize:15];
    [_confirm addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_confirm];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *closeKeyboard = [[UITapGestureRecognizer alloc]initWithTarget:self  action:@selector(bgTap)];
    [self.view addGestureRecognizer:closeKeyboard];
}

-(void)bgTap {
    [self.view endEditing:YES];
}

//确认，登录，网络请求
-(void)commit:(id)sender {
}

-(void)modifyData {
    KOMSettingViewController *father = (KOMSettingViewController *)self.father;
    UIFolderTableView *table = (UIFolderTableView *)father.tableView;
    
    
    for(UIView *view in [self.view subviews]) {
        [view removeFromSuperview];
    }
    
    [table performClose:nil];
    [self loadNotImportedView];
    [father expand:self atIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
}


#pragma mark - TextField Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    //发出通知，让tableview上滚，textField不被键盘挡住
    int offset = 0;
    if (_state == NetAccState) {
        offset += 50;
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TableViewScrollUp" object:[NSNumber numberWithInt:offset]];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    //发出通知，让tableview下滚，回复原状
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TableViewScrollDown" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
