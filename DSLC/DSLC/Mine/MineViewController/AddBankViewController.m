//
//  AddBankViewController.m
//  DSLC
//
//  Created by ios on 15/10/16.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "AddBankViewController.h"
#import "UIColor+AddColor.h"
#import "CreatView.h"
#import "define.h"
#import "AddBankCell.h"
#import "VerifyViewController.h"
#import "MendDeal2Cell.h"

@interface AddBankViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    UITableView *_tableView;
    NSArray *titleArr;
    NSArray *textFieldArr;
    UIImageView *imageViewRight;
    UIImageView *imageRight;
    UILabel *labelChoose;
    UIButton *buttonGet;
    UIButton *buttonNext;
    
    UITextField *textFieldZero;
    UITextField *textFieldTwo;
    UITextField *textFieldFour;
    UITextField *textFieldFive;
}

@end

@implementation AddBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    
    [self.navigationItem setTitle:@"绑定银行卡"];
    [self showViewControllerContent];
}

//视图内容
- (void)showViewControllerContent
{
    titleArr = @[@"持卡人", @"开户银行", @"银行卡号", @"开户城市", @"手机号", @"验证码"];
    textFieldArr = @[@"黄冬明", @"请选择开户银行", @"请输入本人银行卡号", @"请选择开户城市", @"请输入预留在银行的手机号", @"请输入短信验证码"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT * (90.0 / 667.0))];
    _tableView.tableFooterView = view;
    _tableView.backgroundColor = [UIColor huibai];
    
    [_tableView registerNib:[UINib nibWithNibName:@"AddBankCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    imageViewRight = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 23, 17, 16, 16) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"arrow"]];
    imageRight = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 23, 17, 16, 16) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"arrow"]];
    
    buttonNext = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - WIDTH_CONTROLLER_DEFAULT * (271.0 / 375.0))/2, HEIGHT_CONTROLLER_DEFAULT * (47.0 / 667.0), WIDTH_CONTROLLER_DEFAULT * (271.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (43.0 / 667.0)) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"确定"];
    [view addSubview:buttonNext];
    [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [buttonNext addTarget:self action:@selector(nextButton:) forControlEvents:UIControlEventTouchUpInside];
    
    buttonGet = [UIButton buttonWithType:UIButtonTypeCustom];
}

//下一步按钮
- (void)nextButton:(UIButton *)button
{
    textFieldZero = (UITextField *)[self.view viewWithTag:400];
    textFieldTwo = (UITextField *)[self.view viewWithTag:402];
    textFieldFour = (UITextField *)[self.view viewWithTag:404];
    textFieldFive = (UITextField *)[self.view viewWithTag:405];
    
    if (textFieldZero.text.length > 0 && textFieldTwo.text.length == 19 && textFieldFour.text.length == 11 && textFieldFive.text.length == 6) {
        
        NSArray *viewController = [self.navigationController viewControllers];
        [self.navigationController popToViewController:[viewController objectAtIndex:1] animated:YES];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 402) {

        if (range.location == 19) {
            
            return NO;
            
        } else {
            
            return YES;
        }
        
    } else if (textField.tag == 404) {
        
        if (range.location == 11) {
            
            return NO;
            
        } else {
            
            return YES;
        }
        
    } else if (textField.tag == 405) {
        
        if (range.location == 6) {
            
            return NO;
            
        } else {
            
            return YES;
        }
    } else {
        
        return YES;
    }
}

- (void)textFieldPress:(UITextField *)textField
{
    textFieldZero = (UITextField *)[self.view viewWithTag:400];
    textFieldTwo = (UITextField *)[self.view viewWithTag:402];
    textFieldFour = (UITextField *)[self.view viewWithTag:404];
    textFieldFive = (UITextField *)[self.view viewWithTag:405];
    
    if (textFieldZero.text.length > 0 && textFieldTwo.text.length == 19 && textFieldFour.text.length == 11 && textFieldFive.text.length == 6) {
        
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddBankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        
    cell.labelTitle.text = [titleArr objectAtIndex:indexPath.row];
    cell.labelTitle.font = [UIFont systemFontOfSize:15];
        
    cell.textField.placeholder = [textFieldArr objectAtIndex:indexPath.row];
    cell.textField.font = [UIFont systemFontOfSize:14];
    cell.textField.tintColor = [UIColor yuanColor];
    cell.textField.delegate = self;
    cell.textField.textColor = [UIColor zitihui];
    cell.textField.tag = indexPath.row + 400;
    [cell.textField addTarget:self action:@selector(textFieldPress:) forControlEvents:UIControlEventEditingChanged];
    
    if (indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 5) {
            
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
        
    if (indexPath.row == 3) {
            
        [cell addSubview:imageViewRight];
        cell.textField.enabled = NO;
    }
    
    if (indexPath.row == 1) {
        
        [cell addSubview:imageRight];
        cell.textField.enabled = NO;
    }
    
    if (indexPath.row == 5) {
        
        [cell addSubview:buttonGet];
        buttonGet.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT - 10 - 80, 10, 80, 30);
        [buttonGet setTitle:@"获取验证码" forState:UIControlStateNormal];
        [buttonGet setTitleColor:[UIColor daohanglan] forState:UIControlStateNormal];
        buttonGet.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        buttonGet.layer.cornerRadius = 3;
        buttonGet.layer.masksToBounds = YES;
        buttonGet.layer.borderColor = [[UIColor daohanglan] CGColor];
        buttonGet.layer.borderWidth = 0.5;
        [buttonGet addTarget:self action:@selector(buttonPressOK:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > 0) {
        
        [self.view endEditing:YES];
    }
}

- (void)buttonPressOK:(UIButton *)button
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
