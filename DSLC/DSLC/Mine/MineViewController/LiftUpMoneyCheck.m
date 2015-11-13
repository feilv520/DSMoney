//
//  LiftUpMoneyCheck.m
//  DSLC
//
//  Created by ios on 15/11/11.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "LiftUpMoneyCheck.h"
#import "MendDeal2Cell.h"
#import "LiftUpMoneyFinish.h"

@interface LiftUpMoneyCheck () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    UITableView *_tableView;
    NSArray *labelArr;
    NSArray *textFieldArr;
    NSArray *buttonArr;
    UIButton *buttonOK;
    
    UITextField *textField1;
    UITextField *textField2;
}

@end

@implementation LiftUpMoneyCheck

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"提现验证"];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor huibai];
    UIView *viewHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 80)];
    _tableView.tableHeaderView = viewHead;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 100)];
    viewHead.backgroundColor = [UIColor whiteColor];
    [_tableView registerNib:[UINib nibWithNibName:@"MendDeal2Cell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    UILabel *labelPhone = [CreatView creatWithLabelFrame:CGRectMake(15, 20, WIDTH_CONTROLLER_DEFAULT - 30, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:nil];
    [viewHead addSubview:labelPhone];
    NSMutableAttributedString *phoneStr = [[NSMutableAttributedString alloc] initWithString:@"本次交易需要短信确认,校验码已发送至您的手机\n150****0686"];
    NSRange range = NSMakeRange([[phoneStr string] length] - 11, 11);
    [phoneStr addAttribute:NSForegroundColorAttributeName value:[UIColor chongzhiColor] range:range];
    [labelPhone setAttributedText:phoneStr];
    labelPhone.numberOfLines = 2;
    
    UILabel *labelLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 79.5, WIDTH_CONTROLLER_DEFAULT - 20, 0.5)];
    [viewHead addSubview:labelLine];
    labelLine.backgroundColor = [UIColor grayColor];
    labelLine.alpha = 0.5;
    
    labelArr = @[@[@"验证码"], @[@"交易密码"]];
    textFieldArr = @[@[@"请输入验证码"], @[@"请输入交易密码"]];
    buttonArr = @[@[@"获取验证码"], @[@"忘记密码?"]];
    
    buttonOK = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 60, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"确定"];
    [_tableView.tableFooterView addSubview:buttonOK];
    buttonOK.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonOK setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [buttonOK setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [buttonOK addTarget:self action:@selector(buttonMkeSureLiftUp:) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location == 6) {
        
        return NO;
        
    } else {
        
        return YES;
    }
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
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MendDeal2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.labelLeft.text = [[labelArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.labelLeft.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.textField.placeholder = [[textFieldArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    cell.textField.tintColor = [UIColor grayColor];
    cell.textField.delegate = self;
    cell.textField.keyboardType = UIKeyboardTypeNumberPad;
    [cell.textField addTarget:self action:@selector(textFieldPleaseShuRu:) forControlEvents:UIControlEventEditingChanged];
    
    if (indexPath.section == 0) {
        
        cell.textField.tag = 777;
        
    } else {
        
        cell.textField.tag = 888;
    }
    
    [cell.buttonGet setTitle:[[buttonArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    cell.buttonGet.titleLabel.font = [UIFont systemFontOfSize:14];
    
    if (indexPath.section == 0) {
        
        cell.buttonGet.layer.cornerRadius = 5;
        cell.buttonGet.layer.masksToBounds = YES;
        cell.buttonGet.layer.borderColor = [[UIColor daohanglan] CGColor];
        cell.buttonGet.layer.borderWidth = 0.5;
        [cell.buttonGet setTitleColor:[UIColor daohanglan] forState:UIControlStateNormal];
        
    } else {
        
        [cell.buttonGet setTitleColor:[UIColor chongzhiColor] forState:UIControlStateNormal];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)textFieldPleaseShuRu:(UITextField *)textField
{
    textField1 = (UITextField *)[self.view viewWithTag:777];
    textField2 = (UITextField *)[self.view viewWithTag:888];
    
    if (textField1.text.length == 6 && textField2.text.length == 6) {
        
        [buttonOK setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [buttonOK setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [buttonOK setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonOK setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

//确定按钮
- (void)buttonMkeSureLiftUp:(UIButton *)button
{
    textField1 = (UITextField *)[self.view viewWithTag:777];
    textField2 = (UITextField *)[self.view viewWithTag:888];
    
    if (textField1.text.length == 6 && textField2.text.length == 6) {
        
        LiftUpMoneyFinish *finish = [[LiftUpMoneyFinish alloc] init];
        [self.navigationController pushViewController:finish animated:YES];
        
    } else {
        
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > 0) {
        
        [self.view endEditing:YES];
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
