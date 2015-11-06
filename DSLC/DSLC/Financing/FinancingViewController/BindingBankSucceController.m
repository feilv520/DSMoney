//
//  BindingBankSucceController.m
//  DSLC
//
//  Created by ios on 15/11/6.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "BindingBankSucceController.h"
#import "MendDealCell.h"

@interface BindingBankSucceController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    UITableView *_tableView;
    NSArray *nameArray;
    NSArray *textArray;
    UIButton *buttonMoney;
    
    UITextField *textField1;
    UITextField *textField2;
}

@end

@implementation BindingBankSucceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    [self.navigationItem setTitle:@"设置交易密码"];
    
    [self contentShow];
}

- (void)contentShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor huibai];
    [_tableView registerNib:[UINib nibWithNibName:@"MendDealCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    UIView *viewHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 80)];
    _tableView.tableHeaderView = viewHead;
    viewHead.backgroundColor = [UIColor huibai];
    
    UIView *viewFoot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 180)];
    _tableView.tableFooterView = viewFoot;
    viewFoot.backgroundColor = [UIColor huibai];
    
    nameArray = @[@"设置交易密码", @"确认交易密码"];
    textArray = @[@"请设置交易密码", @"请再次输入交易密码"];
    
    UIButton *button = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 25, WIDTH_CONTROLLER_DEFAULT, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] titleText:@"绑定银行卡成功"];
    [viewHead addSubview:button];
    button.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [button setImage:[UIImage imageNamed:@"iconfont_complete"] forState:UIControlStateNormal];
    
    buttonMoney = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 60, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"开始投资"];
    [viewFoot addSubview:buttonMoney];
    buttonMoney.titleLabel.font = [UIFont fontWithName:@"开始投资" size:15];
    [buttonMoney setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [buttonMoney setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [buttonMoney addTarget:self action:@selector(buttonBeginCashMoney:) forControlEvents:UIControlEventTouchUpInside];
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
    MendDealCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.labelLeft.text = [nameArray objectAtIndex:indexPath.row];
    cell.labelLeft.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.textField.placeholder = [textArray objectAtIndex:indexPath.row];
    cell.textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    cell.textField.tintColor = [UIColor grayColor];
    cell.textField.keyboardType = UIKeyboardTypeNumberPad;
    cell.textField.tag = indexPath.row + 700;
    cell.textField.delegate = self;
    [cell.textField addTarget:self action:@selector(bingdingFinishTextField:) forControlEvents:UIControlEventEditingChanged];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

//开始投资
- (void)buttonBeginCashMoney:(UIButton *)button
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location == 6) {
        
        return NO;
        
    } else {
        
        return YES;
    }
}

- (void)bingdingFinishTextField:(UITextField *)textField
{
    textField1 = (UITextField *)[self.view viewWithTag:700];
    textField2 = (UITextField *)[self.view viewWithTag:701];

    if (textField1.text.length > 0 && textField2.text.length > 0) {
        
        [buttonMoney setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [buttonMoney setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [buttonMoney setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonMoney setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    textField1 = (UITextField *)[self.view viewWithTag:700];
    textField2 = (UITextField *)[self.view viewWithTag:701];
    
    if (scrollView.contentOffset.y > 0) {
        
        [textField1 resignFirstResponder];
        [textField2 resignFirstResponder];
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
