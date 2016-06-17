//
//  TWOMendLoginViewController.m
//  DSLC
//
//  Created by ios on 16/5/17.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOMendLoginViewController.h"
#import "TWOImputPhoneNumCell.h"
#import "TWOChangeLoginFinishViewController.h"

@interface TWOMendLoginViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    UITextField *textFieldSecret;
}

@end

@implementation TWOMendLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"修改登录密码"];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor qianhuise];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 90)];
//    _tableView.tableFooterView.backgroundColor = [UIColor magentaColor];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOImputPhoneNumCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [_tableView.tableFooterView addSubview:viewLine];
    viewLine.alpha = 0.5;
    
    UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(20, 5, WIDTH_CONTROLLER_DEFAULT - 40, 40) backgroundColor:[UIColor qianhuise] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:@"登录密码由6-20位数字和字母组成,以字母开头"];
    [_tableView.tableFooterView addSubview:labelAlert];
    
    UIButton *butMakeSure = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, 50, WIDTH_CONTROLLER_DEFAULT - 20, 40) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"确定"];
    [_tableView.tableFooterView addSubview:butMakeSure];
    butMakeSure.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    butMakeSure.layer.cornerRadius = 5;
    butMakeSure.layer.masksToBounds = YES;
    [butMakeSure addTarget:self action:@selector(afterFinishingButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOImputPhoneNumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.imagePic.image = [UIImage imageNamed:@"yanzhenma"];
    NSArray *contentArr = @[@"请输入当前登录密码", @"请输入新登录密码"];
    cell.buttonEye.hidden = YES;
    
    cell.textFieldPhone.placeholder = [contentArr objectAtIndex:indexPath.row];
    cell.textFieldPhone.textColor = [UIColor ZiTiColor];
    cell.textFieldPhone.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    cell.textFieldPhone.tintColor = [UIColor grayColor];
    cell.textFieldPhone.clearsOnBeginEditing = YES;
    cell.textFieldPhone.tag = 999;
    
    if (indexPath.row == 1) {
        cell.buttonEye.hidden = NO;
        [cell.buttonEye setBackgroundImage:[UIImage imageNamed:@"secretEye"] forState:UIControlStateNormal];
        [cell.buttonEye setBackgroundImage:[UIImage imageNamed:@"secretEye"] forState:UIControlStateHighlighted];
        cell.buttonEye.tag = 777;
        [cell.buttonEye addTarget:self action:@selector(openEyesOrCloseEyesButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

//闭眼或睁眼按钮
- (void)openEyesOrCloseEyesButton:(UIButton *)button
{
    textFieldSecret = (UITextField *)[self.view viewWithTag:999];
    
    if (button.tag == 777) {
        
        textFieldSecret.secureTextEntry = YES;
        [button setBackgroundImage:[UIImage imageNamed:@"setbiyan"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"setbiyan"] forState:UIControlStateHighlighted];
        button.tag = 888;
        
    } else {

        textFieldSecret.secureTextEntry = NO;
        [button setBackgroundImage:[UIImage imageNamed:@"secretEye"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"secretEye"] forState:UIControlStateHighlighted];
        button.tag = 777;
    }
}

//确定按钮
- (void)afterFinishingButton:(UIButton *)button
{
    [self.view endEditing:YES];
    TWOChangeLoginFinishViewController *changeFinish = [[TWOChangeLoginFinishViewController alloc] init];
    changeFinish.state = NO;
    [self.navigationController pushViewController:changeFinish animated:YES];
}

#pragma mark data-----------
- (void)mendData
{
//    NSDictionary *paemeter = @{@"newPwd":}
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
