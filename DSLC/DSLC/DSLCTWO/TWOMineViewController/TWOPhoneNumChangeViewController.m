//
//  TWOPhoneNumChangeViewController.m
//  DSLC
//
//  Created by ios on 16/5/16.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOPhoneNumChangeViewController.h"
#import "TWOPhoneNumCell.h"
#import "TWOGetCodeCell.h"
#import "TWOImputNewPhoneNumViewController.h"

@interface TWOPhoneNumChangeViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    UITableView *_tableView;
    UITextField *_textField;
    UIButton *butNext;
}

@end

@implementation TWOPhoneNumChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor qianhuise];
    [self.navigationItem setTitle:@"更换绑定手机号"];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 55)];
    _tableView.tableFooterView.backgroundColor = [UIColor qianhuise];
    _tableView.backgroundColor = [UIColor qianhuise];
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_tableView registerNib:[UINib nibWithNibName:@"TWOPhoneNumCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOGetCodeCell" bundle:nil] forCellReuseIdentifier:@"reuseCode"];
    
    butNext = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, 15, WIDTH_CONTROLLER_DEFAULT - 20, 40) backgroundColor:[UIColor profitColor] textColor:[UIColor qianhuise] titleText:@"下一步"];
    [_tableView.tableFooterView addSubview:butNext];
    butNext.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    butNext.layer.cornerRadius = 5;
    butNext.layer.masksToBounds = YES;
    [butNext addTarget:self action:@selector(buttonNextOneStep:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [_tableView.tableFooterView addSubview:viewLine];
    viewLine.alpha = 0.3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        TWOPhoneNumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        
        cell.imagePhone.image = [UIImage imageNamed:@"手机"];
        cell.labelPhone.text = @"189****7656";
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        TWOGetCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseCode"];
        
        cell.imageLeft.image = [UIImage imageNamed:@"yanzhenma"];
        cell.textFieldCode.placeholder = @"请输入短信验证码";
        cell.textFieldCode.tintColor = [UIColor grayColor];
        cell.textFieldCode.textColor = [UIColor findZiTiColor];
        cell.textFieldCode.delegate = self;
        cell.textFieldCode.tag = 333;
        cell.textFieldCode.keyboardType = UIKeyboardTypeNumberPad;
        [cell.textFieldCode addTarget:self action:@selector(textFieldValueChangeLight:) forControlEvents:UIControlEventEditingChanged];
        
        cell.butGetCode.layer.cornerRadius = 6;
        cell.butGetCode.layer.masksToBounds = YES;
        cell.butGetCode.layer.borderColor = [[UIColor profitColor] CGColor];
        cell.butGetCode.layer.borderWidth = 1;
        [cell.butGetCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [cell.butGetCode addTarget:self action:@selector(getCodeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)textFieldValueChangeLight:(UITextField *)textField
{
    _textField = (UITextField *)[self.view viewWithTag:333];
    if (_textField.text.length > 0) {
        
    } else {
        
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location > 5) {
        return NO;
    } else {
        return YES;
    }
}

//获取验证码按钮
- (void)getCodeButtonClicked:(UIButton *)button
{
    NSLog(@"code");
}

//下一步按钮
- (void)buttonNextOneStep:(UIButton *)button
{
    _textField = (UITextField *)[self.view viewWithTag:333];
    
    if (_textField.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入验证码"];
    } else if (_textField.text.length < 5) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入六位验证码"];
    } else {
        [self.view endEditing:YES];
        TWOImputNewPhoneNumViewController *imputNumVC = [[TWOImputNewPhoneNumViewController alloc] init];
        pushVC(imputNumVC);
    }
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