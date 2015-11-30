//
//  GetMoneyViewController.m
//  DSLC
//
//  Created by 马成铭 on 15/10/21.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "GetMoneyViewController.h"
#import "UIColor+AddColor.h"
#import "define.h"
#import "GetMoneyTableViewCell.h"
#import "GetMoneyNumberTableViewCell.h"
#import "GetMoneyTipTableViewCell.h"
#import "AppDelegate.h"
#import "CreatView.h"
#import "SelectionOfSafe.h"
#import "GetMoneyVerifyViewController.h"

@interface GetMoneyViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    NSString *moneyString;
    UIButton *payButton;
    UITextField *_textField;
}

@property (nonatomic, strong) UITableView *mainTableView;


@end

@implementation GetMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor huibai];
    
    [self showTableView];
    
    [self.navigationItem setTitle:@"提现"];
}

// 创建TableView
- (void)showTableView{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 74) style:UITableViewStylePlain];
    
    self.mainTableView.backgroundColor = Color_Gray;
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    [self.mainTableView setSeparatorColor:Color_Gray];
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"GetMoneyTableViewCell" bundle:nil] forCellReuseIdentifier:@"getMoney"];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"GetMoneyNumberTableViewCell" bundle:nil] forCellReuseIdentifier:@"getMoneyN"];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"GetMoneyTipTableViewCell" bundle:nil] forCellReuseIdentifier:@"getMoneyT"];
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 260)];
    
    footView.backgroundColor = Color_Clear;
    
    payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    payButton.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * (51 / 375.0), 40, WIDTH_CONTROLLER_DEFAULT * (271.0 / 375.0), 43);
    
    [payButton setBackgroundImage:[UIImage imageNamed:@"shouyeqiepian_17"] forState:UIControlStateNormal];
    [payButton setTitle:@"下一步" forState:UIControlStateNormal];
    
    [payButton addTarget:self action:@selector(nextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:payButton];
    
    NSBundle *rootBundle = [NSBundle mainBundle];
    
    SelectionOfSafe *selectionSafeView = (SelectionOfSafe *)[[rootBundle loadNibNamed:@"SelectionOfSafe" owner:nil options:nil] lastObject];
    
    CGFloat button_X = WIDTH_CONTROLLER_DEFAULT * (180.0 / 375.0);
    CGFloat margin_left = ((WIDTH_CONTROLLER_DEFAULT - button_X) / 2 / 375.0) * WIDTH_CONTROLLER_DEFAULT;
    
    selectionSafeView.frame = CGRectMake(margin_left, 90, button_X, 17);
    
    [footView addSubview:selectionSafeView];
    
    self.mainTableView.tableFooterView = footView;
    
    [self.view addSubview:self.mainTableView];
    
}

#pragma mark tableView delegate and dataSource
#pragma mark --------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {

        return nil;
    } else {
        return nil;
    }
}

- (void)nextButtonAction:(UIButton *)btn
{
    _textField = (UITextField *)[self.view viewWithTag:6721];
    
    if (_textField.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入提现金额"];
        
    } else if ([_textField.text isEqualToString:@"0"]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"提现金额不能为0"];
        
    } else {
        GetMoneyVerifyViewController *verify = [[GetMoneyVerifyViewController alloc] init];
        verify.moneyString = moneyString;
        [self.navigationController pushViewController:verify animated:YES];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 45;
    } else {
        if (WIDTH_CONTROLLER_DEFAULT == 320) {
            return 365;
        } else {
            return 345;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    } else {
        return 0.5;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            GetMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"getMoney"];
            return cell;
        } else {
            GetMoneyNumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"getMoneyN"];
            [cell.textfield addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
            cell.textfield.delegate = self;
            cell.textfield.tag = 6721;
            return cell;
        }
    } else {
        GetMoneyTipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"getMoneyT"];
        return cell;
    }
}

- (void)textFieldWithText:(UITextField *)textField
{
    moneyString = textField.text;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _textField = (UITextField *)[self.view viewWithTag:6721];
    
    if (_textField.text.length == 0) {
        
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入提现金额"];
    }
    return YES;
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
