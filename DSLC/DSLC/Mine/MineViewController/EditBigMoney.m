//
//  EditBigMoney.m
//  DSLC
//
//  Created by ios on 15/11/10.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "EditBigMoney.h"
#import "MendDealCell.h"
#import "ChooseOpenAnAccountBank.h"

@interface EditBigMoney () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    UITableView *_tabelView;
    UIButton *buttonOk;
    
    NSArray *nameArray;
    NSArray *textArray;
    
    UITextField *fileldName;
    UITextField *fieldBank;
    UITextField *fieldBankCard;
    UITextField *fieldPhoneNum;
    UITextField *fieldMoney;
    UITextField *fieldBusness;
    UITextField *fieldTime;
    
    UIImageView *imageViewR;
}

@end

@implementation EditBigMoney

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"大额充值申请"];
    
    [self contentShow];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(returnBankName:) name:@"bank" object:nil];
}

- (void)returnBankName:(NSNotification *)notice
{
    NSString *bankName = [notice object];
    fieldBank = (UITextField *)[self.view viewWithTag:601];
    fieldBank.text = bankName;
}

- (void)contentShow
{
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tabelView];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    _tabelView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 130)];
    _tabelView.backgroundColor = [UIColor huibai];
    [_tabelView registerNib:[UINib nibWithNibName:@"MendDealCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    nameArray = @[@"真实姓名", @"开户银行", @"银行卡号", @"手机号码", @"充值金额", @"商户", @"刷卡时间", @"上传POS单照片"];
    textArray = @[[DES3Util decrypt:self.schedule.realName], self.schedule.bankName, [DES3Util decrypt:self.schedule.account], [DES3Util decrypt:self.schedule.phone], [DES3Util decrypt:self.schedule.money], self.schedule.busName, self.schedule.posTime, self.schedule.posImg];
    
    buttonOk = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 60, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"确定"];
    [_tabelView.tableFooterView addSubview:buttonOk];
    buttonOk.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonOk setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
    [buttonOk setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    [buttonOk addTarget:self action:@selector(makeSureEditReturn:) forControlEvents:UIControlEventTouchUpInside];

    imageViewR = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 22, 17, 16, 16) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"jiantou"]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MendDealCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.labelLeft.text = [nameArray objectAtIndex:indexPath.row];
    cell.labelLeft.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.textField.text = [textArray objectAtIndex:indexPath.row];
    cell.textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    cell.textField.textColor = [UIColor zitihui];
    cell.textField.tintColor = [UIColor grayColor];
    cell.textField.delegate = self;
    cell.textField.tag = indexPath.row + 600;
    
    if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4) {
        
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    if (indexPath.row == 1) {
        
        cell.textField.enabled = NO;
        [cell addSubview:imageViewR];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        
        ChooseOpenAnAccountBank *choose = [[ChooseOpenAnAccountBank alloc] init];
        [self.navigationController pushViewController:choose animated:YES];
        
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 602) {
        
        if (range.location == 19) {
            
            return NO;
            
        } else {
            
            return YES;
        }
        
    } else if (textField.tag == 603) {
        
        if (range.location == 11) {
            
            return NO;
            
        } else {
            
            return YES;
        }
        
    } else {
        
        return YES;
    }
}

//确定按钮
- (void)makeSureEditReturn:(UIButton *)button
{
    [self getData];
}

#pragma mark 网络请求方法
#pragma mark --------------------------------
- (void)getData
{
    fileldName = (UITextField *)[self.view viewWithTag:600];
    fieldBank = (UITextField *)[self.view viewWithTag:601];
    fieldBankCard = (UITextField *)[self.view viewWithTag:602];
    fieldPhoneNum = (UITextField *)[self.view viewWithTag:603];
    fieldMoney = (UITextField *)[self.view viewWithTag:604];
    fieldBusness = (UITextField *)[self.view viewWithTag:605];
    fieldTime = (UITextField *)[self.view viewWithTag:606];

    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    NSDictionary *paremeter = @{@"id":self.schedule.Id, @"realName":fileldName.text, @"bankName":fieldBank.text, @"account":fieldBankCard.text, @"phone":fieldPhoneNum.text, @"money":fieldMoney.text, @"busName":fieldBusness.text, @"posTime":fieldTime.text, @"posImg":@"", @"token":[dic objectForKey:@"token"]};

    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/updateBigPutOnSerialNum" parameters:paremeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"%@", responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 603) {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            _tabelView.contentOffset = CGPointMake(0, 100);
            
        } completion:^(BOOL finished) {
            
        }];
    } else if (textField.tag == 604) {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            _tabelView.contentOffset = CGPointMake(0, 200);
            
        } completion:^(BOOL finished) {
            
        }];
    } else if (textField.tag == 605) {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            _tabelView.contentOffset = CGPointMake(0, 250);
            
        } completion:^(BOOL finished) {
            
        }];
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
