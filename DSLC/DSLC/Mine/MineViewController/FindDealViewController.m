//
//  FindDealViewController.m
//  DSLC
//
//  Created by ios on 15/11/2.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "FindDealViewController.h"
#import "MendDealCell.h"
#import "MendDeal2Cell.h"

@interface FindDealViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSArray *leftArray;
    NSArray *textArray;
    UILabel *labelPhone;
    UIButton *butReally;
    
    UITextField *textField1;
    UITextField *textField2;
    UITextField *textField3;
}

@end

@implementation FindDealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"找回交易密码"];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 200) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    [_tableView registerNib:[UINib nibWithNibName:@"MendDealCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [_tableView registerNib:[UINib nibWithNibName:@"MendDeal2Cell" bundle:nil] forCellReuseIdentifier:@"reuse1"];
    
    leftArray = @[@"绑定手机号", @"", @"设置新交易密码", @"确认新交易密码"];
    textArray = @[@"", @"", @"请输入新交易密码", @"请再次输入新交易密码"];
    
    labelPhone = [CreatView creatWithLabelFrame:CGRectMake(130, 10, WIDTH_CONTROLLER_DEFAULT - 140, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"15908271390"];
    
    butReally = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 260, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"确定"];
    [self.view addSubview:butReally];
    butReally.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butReally setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [butReally setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [butReally addTarget:self action:@selector(findSecretMakeSure:) forControlEvents:UIControlEventTouchUpInside];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        
        MendDeal2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse1"];
        
        [cell.buttonGet setTitle:@"获取验证码" forState:UIControlStateNormal];
        [cell.buttonGet setTitleColor:[UIColor daohanglan] forState:UIControlStateNormal];
        cell.buttonGet.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.buttonGet.layer.cornerRadius = 3;
        cell.buttonGet.layer.masksToBounds = YES;
        cell.buttonGet.layer.borderWidth = 0.5;
        cell.buttonGet.layer.borderColor = [[UIColor daohanglan] CGColor];
        [cell.buttonGet addTarget:self action:@selector(getNumButton:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.labelLeft.text = @"验证码";
        cell.labelLeft.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.textField.placeholder = @"请输入验证码";
        cell.textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.textField.tintColor = [UIColor grayColor];
        cell.textField.tag = 701;
        [cell.textField addTarget:self action:@selector(findSecretTextFieldEdit:) forControlEvents:UIControlEventEditingChanged];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        
        MendDealCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        
        if (indexPath.row == 0) {
            
            cell.textField.hidden = YES;
            [cell addSubview:labelPhone];
            
        }
        
        cell.labelLeft.text = [leftArray objectAtIndex:indexPath.row];
        cell.labelLeft.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        
        cell.textField.placeholder = [textArray objectAtIndex:indexPath.row];
        cell.textField.tintColor = [UIColor grayColor];
        cell.textField.tag = indexPath.row + 700;
        [cell.textField addTarget:self action:@selector(findSecretTextFieldEdit:) forControlEvents:UIControlEventEditingChanged];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

- (void)findSecretTextFieldEdit:(UITextField *)textField
{
    textField1 = (UITextField *)[self.view viewWithTag:701];
    textField2 = (UITextField *)[self.view viewWithTag:702];
    textField3 = (UITextField *)[self.view viewWithTag:703];
    
    if (textField1.text.length > 0 && textField2.text.length > 0 && textField3.text.length > 0) {
        
        [butReally setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [butReally setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [butReally setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butReally setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

//确定按钮
- (void)findSecretMakeSure:(UIButton *)button
{
    textField1 = (UITextField *)[self.view viewWithTag:701];
    textField2 = (UITextField *)[self.view viewWithTag:702];
    textField3 = (UITextField *)[self.view viewWithTag:703];
    
    if (textField1.text.length > 0 && textField2.text.length > 0 && textField3.text.length > 0) {
        
        NSLog(@"对了");
        
    } else {
        
    }

}

//获取验证码
- (void)getNumButton:(UIButton *)button
{
    NSLog(@"获取验证码");
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
