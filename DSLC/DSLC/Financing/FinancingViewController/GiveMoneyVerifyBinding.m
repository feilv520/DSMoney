//
//  GiveMoneyVerifyBinding.m
//  DSLC
//
//  Created by ios on 15/11/6.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "GiveMoneyVerifyBinding.h"
#import "MendDeal2Cell.h"
#import "GiveMoneyFinish.h"

@interface GiveMoneyVerifyBinding () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    UITableView *_tableView;
    UITextField *_textField;
    UIButton *butGive;
}

@end

@implementation GiveMoneyVerifyBinding

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    [self.navigationItem setTitle:@"付款验证"];
    
    [self contentShow];
}

- (void)contentShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 130) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    
    UIView *viewHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 80)];
    _tableView.tableHeaderView = viewHead;
    viewHead.backgroundColor = [UIColor whiteColor];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MendDeal2Cell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    butGive = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 190, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"充值"];
    [self.view addSubview:butGive];
    butGive.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butGive setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [butGive setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [butGive addTarget:self action:@selector(giveMoney:) forControlEvents:UIControlEventTouchUpInside];
    
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
    MendDeal2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.labelLeft.text = @"验证码";
    cell.labelLeft.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.textField.placeholder = @"请输入验证码";
    cell.textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    cell.textField.tintColor = [UIColor grayColor];
    cell.textField.keyboardType = UIKeyboardTypeNumberPad;
    cell.textField.tag = 308;
    cell.textField.delegate = self;
    [cell.textField addTarget:self action:@selector(bindingBankTextField:) forControlEvents:UIControlEventEditingChanged];
    
    [cell.buttonGet setTitle:@"获取验证码" forState:UIControlStateNormal];
    [cell.buttonGet setTitleColor:[UIColor daohanglan] forState:UIControlStateNormal];
    cell.buttonGet.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    cell.buttonGet.layer.cornerRadius = 3;
    cell.buttonGet.layer.masksToBounds = YES;
    cell.buttonGet.layer.borderColor = [[UIColor daohanglan] CGColor];
    cell.buttonGet.layer.borderWidth = 0.5;
    [cell.buttonGet addTarget:self action:@selector(getCode:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//充值按钮
- (void)giveMoney:(UIButton *)button
{
    GiveMoneyFinish *giveMoney = [[GiveMoneyFinish alloc] init];
    [self.navigationController pushViewController:giveMoney animated:YES];
}

- (void)bindingBankTextField:(UITextField *)textField
{
    if (textField.text.length > 0) {
        
        [butGive setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [butGive setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [butGive setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butGive setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location == 6) {
        
        return NO;
        
    } else {
        
        return YES;
    }
}

- (void)getCode:(UIButton *)button
{
    NSLog(@"1111111");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
