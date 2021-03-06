//
//  SetDealSecret.m
//  DSLC
//
//  Created by ios on 15/11/6.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "SetDealSecret.h"
#import "MendDealCell.h"
#import "MendDealViewController.h"

@interface SetDealSecret () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    UITableView *_tabelView;
    NSArray *nameArray;
    NSArray *textArray;
    
    UITextField *textField1;
    UITextField *textField2;
    
    UIButton *buttonMoney;
}

@end

@implementation SetDealSecret

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    [self.navigationItem setTitle:@"设置交易密码"];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"修改" style:UIBarButtonItemStylePlain target:self action:@selector(findDealSecret:)];
//    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:14], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    [self tableViewShow];
}

//- (void)findDealSecret:(UIBarButtonItem *)bar
//{
//    MendDealViewController *dealVC = [[MendDealViewController alloc] init];
//    [self.navigationController pushViewController:dealVC animated:YES];
//}

- (void)tableViewShow
{
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 100) style:UITableViewStylePlain];
    [self.view addSubview:_tabelView];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    _tabelView.scrollEnabled = NO;
    _tabelView.backgroundColor = [UIColor huibai];
    [_tabelView registerNib:[UINib nibWithNibName:@"MendDealCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    nameArray = @[@"设置交易密码", @"确认交易密码"];
    textArray = @[@"请设置交易密码", @"请再次输入交易密码"];
    
    buttonMoney = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 160, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"确定"];
    [self.view addSubview:buttonMoney];
    buttonMoney.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonMoney setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [buttonMoney setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [buttonMoney addTarget:self action:@selector(buttonsetDealSecret:) forControlEvents:UIControlEventTouchUpInside];
}

//确定
- (void)buttonsetDealSecret:(UIButton *)button
{
    textField1 = (UITextField *)[self.view viewWithTag:700];
    textField2 = (UITextField *)[self.view viewWithTag:701];
    
    if (textField1.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请设置交易密码"];
        
    } else if (![NSString validatePassword:textField1.text]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"6~20位含字母和数字,以字母开头"];
        
    } else if (textField2.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入确认交易密码"];
        
    } else if (textField2.text.length < 6) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"两次密码输入不一致"];
        
    } else if (![textField1.text isEqualToString:textField2.text]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"两次密码输入不一致"];
        
    } else {
        [self findPwd];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MendDealCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.labelLeft.text = [nameArray objectAtIndex:indexPath.row];
    cell.labelLeft.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.textField.secureTextEntry = YES;
    cell.textField.placeholder = [textArray objectAtIndex:indexPath.row];
    cell.textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    cell.textField.tintColor = [UIColor grayColor];
    cell.textField.tag = indexPath.row + 700;
    cell.textField.delegate = self;
    [cell.textField addTarget:self action:@selector(bingdingFinishTextField:) forControlEvents:UIControlEventEditingChanged];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location <= 19) {
        
        return YES;
        
    } else {
        
        return NO;
    }
}

- (void)bingdingFinishTextField:(UITextField *)textField
{
    textField1 = (UITextField *)[self.view viewWithTag:700];
    textField2 = (UITextField *)[self.view viewWithTag:701];
    
    if (textField1.text.length < 6) {
        
        [buttonMoney setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonMoney setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];

    } else if (textField2.text.length < 6) {
        
        [buttonMoney setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonMoney setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    } else if (![textField1.text isEqualToString:textField2.text]) {
        
        [buttonMoney setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonMoney setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    } else {
        
        [buttonMoney setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [buttonMoney setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)findPwd{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    textField1 = (UITextField *)[self.view viewWithTag:700];
    
    NSDictionary *parameters = @{@"payPwd":textField1.text,@"userId":[dic objectForKey:@"id"]};
    
    NSLog(@"%@",parameters);
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/setPayPwd" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            NSMutableDictionary *usersDic = [[NSMutableDictionary alloc]initWithContentsOfFile:[FileOfManage PathOfFile:@"NewProduct.plist"]];
            
            //设置属性值,没有的数据就新建，已有的数据就修改。
            [usersDic setObject:[DES3Util encrypt:textField2.text] forKey:@"dealSecret"];
            //写入文件
            [usersDic writeToFile:[FileOfManage PathOfFile:@"NewProduct.plist"] atomically:YES];
            
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"setDeal" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenWithCell" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getData" object:nil];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

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
