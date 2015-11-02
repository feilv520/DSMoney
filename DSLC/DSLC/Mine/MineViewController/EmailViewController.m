//
//  EmailViewController.m
//  DSLC
//
//  Created by ios on 15/11/2.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "EmailViewController.h"
#import "LastEmailViewController.h"
#import "EmailCell.h"

@interface EmailViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

{
    UIButton *buttonNext;
    UITextField *_textField;
    
    UIButton *butRemember;
    UIView *viewBig;
    
    UITableView *_tableView;
    NSArray *contentArr;
}

@end

@implementation EmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"绑定邮箱"];
    
    [self contentShow];
    [self rememberContent];
}

- (void)contentShow
{
    UIView *viewBottom = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewBottom];
    
    UILabel *labelLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 49.5, WIDTH_CONTROLLER_DEFAULT, 0.5)];
    [viewBottom addSubview:labelLine];
    labelLine.backgroundColor = [UIColor grayColor];
    labelLine.alpha = 0.2;
    
    UILabel *labelEmail = [CreatView creatWithLabelFrame:CGRectMake(10, 10, 60, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"邮箱地址"];
    [viewBottom addSubview:labelEmail];
    
    _textField = [CreatView creatWithfFrame:CGRectMake(90, 11, WIDTH_CONTROLLER_DEFAULT - 100, 30) setPlaceholder:@"请输入邮箱地址" setTintColor:[UIColor grayColor]];
    [viewBottom addSubview:_textField];
    _textField.delegate = self;
    _textField.textColor = [UIColor zitihui];
    _textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [_textField addTarget:self action:@selector(textEditEmail:) forControlEvents:UIControlEventEditingChanged];
    
    buttonNext = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 110, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"发送验证邮箱"];
    [self.view addSubview:buttonNext];
    buttonNext.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [buttonNext addTarget:self action:@selector(sendEmail:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)textEditEmail:(UITextField *)textField
{
    if (textField.text.length > 0) {
        
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

- (void)rememberContent
{
    butRemember = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, 190, WIDTH_CONTROLLER_DEFAULT - 20, 25) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] titleText:@"邮件发送成功,请您登录邮箱激活"];
    [butRemember setImage:[UIImage imageNamed:@"iconfont_complete"] forState:UIControlStateNormal];
    butRemember.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    
    viewBig = [CreatView creatViewWithFrame:CGRectMake(40, 225, WIDTH_CONTROLLER_DEFAULT - 80, 156) backgroundColor:[UIColor shurukuangColor]];
    viewBig.layer.cornerRadius = 5;
    viewBig.layer.masksToBounds = YES;
    viewBig.layer.borderColor = [[UIColor shurukuangBian] CGColor];
    viewBig.layer.borderWidth = 0.5;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 5, viewBig.frame.size.width, 156 - 12) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"EmailCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    contentArr = @[@"温馨提示", @"没有收到邮件?", @"1.验证邮件可能在垃圾邮件中,", @"请仔细查找。", @"2.如果超过10分钟仍未收到验证邮件,", @"请重新进行邮箱认证。"];
}

//发送邮件按钮
- (void)sendEmail:(UIButton *)button
{
    if (_textField.text.length > 0) {
        
        [_textField resignFirstResponder];
        
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
        [buttonNext setTitle:@"重新发送(50s)" forState:UIControlStateNormal];
        _textField.enabled = NO;
        
        [self.view addSubview:butRemember];
        [self.view addSubview:viewBig];
        [viewBig addSubview:_tableView];
        
    } else {
        
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 146/6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EmailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.labelContent.text = [contentArr objectAtIndex:indexPath.row];
    cell.labelContent.font = [UIFont systemFontOfSize:13];
    cell.labelContent.textAlignment = NSTextAlignmentCenter;
    cell.labelContent.textColor = [UIColor zitihui];
    
    cell.backgroundColor = [UIColor shurukuangColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
