//
//  KOMImportViewController.m
//  Kompax
//
//  Created by Bryan on 13-8-12.
//  Copyright (c) 2013年 Bryan. All rights reserved.
//

#import "KOMImportViewController.h"
#import "KOMSettingViewController.h"

static NSString *GLOBAL_TIMEFORMAT = @"yyyy-MM-dd HH:mm:ss";

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
    
    //设置子视图和滚动视图大小
    self.view.frame = CGRectMake(0, 0, 320, 145);
    _scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    _scrollView.backgroundColor = [UIColor colorWithRed:232/255.0 green:239/255.0 blue:233/255.0 alpha:1.0];
    [self.view addSubview:_scrollView];
    
    //初始化各Label初始属性
    _accLabel= [[UILabel alloc]initWithFrame:CGRectMake(54+320, 56, 300, 26)];
    [_accLabel setBackgroundColor:[UIColor clearColor]];
    _accLabel.textColor = [UIColor blackColor];
    _accLabel.textAlignment = NSTextAlignmentLeft;
    _accLabel.font = [UIFont boldSystemFontOfSize:17];
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(54+320, 95, 300, 26)];
    [_timeLabel setBackgroundColor:[UIColor clearColor]];
    _timeLabel.textColor = [UIColor blackColor];
    _timeLabel.textAlignment = NSTextAlignmentLeft;
    _timeLabel.font = [UIFont boldSystemFontOfSize:17];
    
    _modify = [[UIButton alloc] initWithFrame:CGRectMake(270+320, 15, 40, 24)];
    [_modify setBackgroundColor:[UIColor clearColor]];
    _modify.titleLabel.font = [UIFont systemFontOfSize:17];
    [_modify setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]; //只能这样修改按钮字体颜色
    [_modify setUserInteractionEnabled:YES];
    [_modify addTarget:self action:@selector(modifyData) forControlEvents:UIControlEventTouchUpInside];
    [_modify setTitle:@"修改" forState:UIControlStateNormal]; 

    [self.scrollView addSubview:_modify];
    [self.scrollView addSubview:_timeLabel];
    [self.scrollView addSubview:_accLabel];
    
    if (self.isImported) {
        [_scrollView setContentOffset:CGPointMake(320,0) animated:NO];
        [self loadImportedView];
    }   //账户已导入
    else {
        [self loadNotImportedView];
    }   //账户未导入
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _scrollView.scrollEnabled = NO;
    _scrollView.contentSize = CGSizeMake(640, 48);
}

//渲染已导入界面
-(void)loadImportedView {
    
    //“数据导入”按钮
    _syn = [[UILabel alloc] initWithFrame:CGRectMake(51+320, 12, 85, 26)];
    [_syn setText:@"数据导入"];
    [_syn setBackgroundColor:[UIColor blackColor]];
    _syn.textColor = [UIColor whiteColor];
    _syn.textAlignment = NSTextAlignmentCenter;
    _syn.font = [UIFont boldSystemFontOfSize:18];
    [self.scrollView addSubview:_syn];
    
    //账号显示标签
    NSString *fullName = nil;
    
    if (self.state == EmailState) {
        fullName =  [_accStateName stringByAppendingFormat:@"账号： %@",_emailAccount];
    }
    else
    {
        fullName =  [_accStateName stringByAppendingFormat:@"账号： %@",_netAccount];
    }
     
    [_accLabel setText:fullName];
    
    //初始化formatter，一定要设置显示模式，否则无法显示
    NSTimeZone* localzone = [NSTimeZone localTimeZone];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:GLOBAL_TIMEFORMAT];
    [formatter setTimeZone:localzone];
    
    //登录时间显示标签
    NSString *fullTime =  nil;
    if (self.state == EmailState) {
        fullTime =  [NSString stringWithFormat:@"登录时间： %@",[formatter stringFromDate:self.emailDate]];
    }
    else
    {
        fullTime =  [NSString stringWithFormat:@"登录时间： %@",[formatter stringFromDate:self.netDate]];
    }
    
    [_timeLabel setText:fullTime];
  
}

//渲染未导入界面
-(void)loadNotImportedView {
    
    NSString *str1 = [NSString stringWithFormat:@"绑定%@账号",_accStateName];
    
    //提示标签
    UILabel *hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(71, 8, 200, 15)];
    [hintLabel setText:str1];
    [hintLabel setBackgroundColor:[UIColor clearColor]];
    hintLabel.textColor = [UIColor blackColor];
    hintLabel.textAlignment = NSTextAlignmentLeft;
    hintLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.scrollView addSubview:hintLabel];
    
    //提示账户输入标签
    UILabel *accLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 48, 160, 15)];
    [accLabel setText:@"账号"];
    [accLabel setBackgroundColor:[UIColor clearColor]];
    accLabel.textColor = [UIColor blackColor];
    accLabel.textAlignment = NSTextAlignmentLeft;
    accLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.scrollView addSubview:accLabel];
    
    //提示密码输入标签
    UILabel *paswordLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 78, 60, 15)];
    [paswordLabel setText:@"密码"];
    [paswordLabel setBackgroundColor:[UIColor clearColor]];
    paswordLabel.textColor = [UIColor blackColor];
    paswordLabel.textAlignment = NSTextAlignmentLeft;
    paswordLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.scrollView addSubview:paswordLabel];
    
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
    
    [self.scrollView addSubview:_accountText];
    [self.scrollView addSubview:_passwordText];
    
    //确认按钮
    _confirm = [[UIButton alloc] initWithFrame:CGRectMake(118, 113, 70, 20)];
    [_confirm setUserInteractionEnabled:YES];
    [_confirm setTitle:@"确认绑定" forState:UIControlStateNormal];
    [_confirm setBackgroundColor:[UIColor colorWithRed:243/255.0 green:130/255.0 blue:46/255.0 alpha:1.0]];
    _confirm.titleLabel.textColor = [UIColor whiteColor];
    _confirm.titleLabel.textAlignment = NSTextAlignmentLeft;
    _confirm.titleLabel.font = [UIFont systemFontOfSize:15];
    [_confirm addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:_confirm];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *closeKeyboard = [[UITapGestureRecognizer alloc]initWithTarget:self  action:@selector(bgTap)];
    [self.scrollView addGestureRecognizer:closeKeyboard];
}

-(void)bgTap {
    [self.scrollView endEditing:YES];
}

//确认，登录，网络请求
-(void)commit:(id)sender {
     [_scrollView setContentOffset:CGPointMake(320, 0) animated:YES];
    
    if (_state == EmailState)  {
        
        self.emailAccount =_accountText.text;
        self.emailDate = [NSDate date];
        self.isImported = YES;
        [self loadImportedView];
        
        //父视图控制器传递参数
        KOMSettingViewController *father = (KOMSettingViewController *)self.father;
        father.emailIsImported = YES;
        father.email_account = self.emailAccount;
    }
    else
    {
        self.netAccount =_accountText.text;
        self.netDate = [NSDate date];
        self.isImported = YES;
        [self loadImportedView];
        
        //父视图控制器传递参数
        KOMSettingViewController *father = (KOMSettingViewController *)self.father;
        father.netAccIsImported = YES;
        father.net_account = self.netAccount;
    }
}

-(void)modifyData {
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
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
