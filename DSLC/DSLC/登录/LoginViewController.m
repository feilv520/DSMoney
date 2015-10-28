//
//  LoginViewController.m
//  DSLC
//
//  Created by ios on 15/10/27.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginCell.h"
#import "MineViewController.h"
#import "UIColor+AddColor.h"
#import "define.h"
#import "CreatView.h"
#import "RegisterViewController.h"
#import "ForgetSecretViewController.h"

@interface LoginViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSArray *titleArr;
    NSArray *ImageArr;
    NSArray *placeholderArr;
    UIButton *butLogin;
    UITextField *textField1;
    UITextField *textField2;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor qianhuise];
    
    [self tableviewShow];
    [self navigationControllerShow];
}

- (void)navigationControllerShow
{
    [self.navigationItem setTitle:@"登录大圣理财"];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor daohanglan];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
//    注册按钮修改颜色 大小
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItem:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:16], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
}

//注册按钮点击事件
- (void)leftBarButtonItem:(UIBarButtonItem *)bar
{
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)tableviewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 100) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    _tableView.tableFooterView = [UIView new];
    [_tableView registerNib:[UINib nibWithNibName:@"LoginCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    titleArr = @[@"手机号", @"密码"];
    ImageArr = @[@"iconfont-phone", @"iconfont-mima"];
    placeholderArr = @[@"请输入手机号", @"请输入密码"];
    
    [self bottomContent];
}

- (void)bottomContent
{
    UIButton *butForget = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 67, 105, 60, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor chongzhiColor] titleText:@"忘记密码?"];
    [self.view addSubview:butForget];
    butForget.titleLabel.font = [UIFont systemFontOfSize:12];
    [butForget addTarget:self action:@selector(forgetSecretButton:) forControlEvents:UIControlEventTouchUpInside];
    
    butLogin = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 160, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor qianhuise] textColor:[UIColor whiteColor] titleText:@"登录"];
    [self.view addSubview:butLogin];
    [butLogin setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [butLogin setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [butLogin addTarget:self action:@selector(loginButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoginCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell == nil) {
        
        cell = [[LoginCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
    }
    
    cell.labelPhoneNum.text = [titleArr objectAtIndex:indexPath.row];
    cell.labelPhoneNum.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.textField.placeholder = [placeholderArr objectAtIndex:indexPath.row];
    cell.textField.font = [UIFont fontWithName:@"placeholder" size:14];
    cell.textField.tintColor = [UIColor grayColor];
    cell.textField.keyboardType = UIKeyboardTypeNumberPad;
    cell.textField.tag = 1000 + indexPath.row;
    [cell.textField addTarget:self action:@selector(editContent:) forControlEvents:UIControlEventEditingChanged];
    
    cell.imageLeft.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [ImageArr objectAtIndex:indexPath.row]]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)editContent:(UITextField *)textField
{
    textField1 = (UITextField *)[self.view viewWithTag:1000];
    textField2 = (UITextField *)[self.view viewWithTag:1001];
    
    if (textField1.text.length > 0 && textField2.text.length > 0) {
        
        [butLogin setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [butLogin setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [butLogin setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butLogin setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

//登录按钮
- (void)loginButton:(UIButton *)button
{
    textField1 = (UITextField *)[self.view viewWithTag:1000];
    textField2 = (UITextField *)[self.view viewWithTag:1001];
    
    if (textField1.text.length > 0 && textField2.text.length > 0) {
        
        NSLog(@"登录");
        
    } else {
        
        
    }
    
}

//忘记密码
- (void)forgetSecretButton:(UIButton *)button
{
    ForgetSecretViewController *forgetSecretVC = [[ForgetSecretViewController alloc] init];
    [self.navigationController pushViewController:forgetSecretVC animated:YES];
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
