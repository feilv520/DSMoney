//
//  BindingBankCardLiftUpMoney.m
//  DSLC
//
//  Created by ios on 15/11/11.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "BindingBankCardLiftUpMoney.h"
#import "BindingOneCell.h"
#import "BindingTwoCell.h"
#import "LiftUpMoneyCheck.h"

@interface BindingBankCardLiftUpMoney () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tabelView;
    
    NSArray *nameArr;
    NSArray *contentArr;
    
    NSArray *name2arr;
    NSArray *content2Arr;
}

@end

@implementation BindingBankCardLiftUpMoney

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"绑定银行卡"];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) style:UITableViewStylePlain];
    [self.view addSubview:_tabelView];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    _tabelView.backgroundColor = [UIColor huibai];
    _tabelView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 130)];
    [_tabelView registerNib:[UINib nibWithNibName:@"BindingOneCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [_tabelView registerNib:[UINib nibWithNibName:@"BindingTwoCell" bundle:nil] forCellReuseIdentifier:@"reuse1"];
    
    nameArr = @[@"持卡人", @"银行卡号"];
    contentArr = @[@"吴磊", @"6227 **** **** 7896"];
    
    name2arr = @[@"开户行", @"开户省市"];
    content2Arr = @[@"选择开户银行", @"选择省市"];
    
    UIButton *buttonOK = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 60, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"确定"];
    [_tabelView.tableFooterView addSubview:buttonOK];
    buttonOK.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonOK setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
    [buttonOK setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    [buttonOK addTarget:self action:@selector(buttonOkMakeSure:) forControlEvents:UIControlEventTouchUpInside];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 0;
        
    } else {
        
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        BindingOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        
        cell.labelName.text = [nameArr objectAtIndex:indexPath.row];
        cell.labelName.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.labelContent.text = [contentArr objectAtIndex:indexPath.row];
        cell.labelContent.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        
        BindingTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse1"];
        
        cell.labelName.text = [name2arr objectAtIndex:indexPath.row];
        cell.labelName.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.labelContent.text = [content2Arr objectAtIndex:indexPath.row];
        cell.labelContent.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.labelContent.textColor = [UIColor zitihui];
        
        cell.iamegRight.image = [UIImage imageNamed:@"arrow"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
}

//确定按钮
- (void)buttonOkMakeSure:(UIButton *)button
{
    LiftUpMoneyCheck *liftUp = [[LiftUpMoneyCheck alloc] init];
    [self.navigationController pushViewController:liftUp animated:YES];
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
