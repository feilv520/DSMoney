//
//  RealNameViewController.m
//  DSLC
//
//  Created by ios on 15/10/23.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "RealNameViewController.h"
#import "AddBankCell.h"
#import "AddBankViewController.h"

@interface RealNameViewController () <UITextFieldDelegate>

{
    UITextField *_textField1;
    UITextField *_textField2;
    UITextField *_textField3;
    UIButton *buttonNext;
    NSInteger countNum;
}

@end

@implementation RealNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    
    [self.navigationItem setTitle:@"实名认证"];
    
    [self contentShow];
    countNum = 0;
}

- (void)contentShow
{
    UIView *viewWhite = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 100) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewWhite];
    viewWhite.backgroundColor = [UIColor whiteColor];
    
    UILabel *realName = [CreatView creatWithLabelFrame:CGRectMake(10, 0, 60, 49.5) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"真实姓名"];
    [viewWhite addSubview:realName];
    
    UILabel *labelLine1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 49.5, WIDTH_CONTROLLER_DEFAULT - 20, 0.5)];
    [viewWhite addSubview:labelLine1];
    [self labelLineShow:labelLine1];
    
    UILabel *documentStyle = [CreatView creatWithLabelFrame:CGRectMake(10, 50, 60, 49.5) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"身份证号"];
    [viewWhite addSubview:documentStyle];
    
    UILabel *labelLine2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 99.5, WIDTH_CONTROLLER_DEFAULT - 20, 0.5)];
    [viewWhite addSubview:labelLine2];
    [self labelLineShow:labelLine2];
    
    _textField1 = [CreatView creatWithfFrame:CGRectMake(90, 10, WIDTH_CONTROLLER_DEFAULT - 100, 30) setPlaceholder:@"真实姓名" setTintColor:[UIColor grayColor]];
    [viewWhite addSubview:_textField1];
    _textField1.delegate = self;
    _textField1.textColor = [UIColor zitihui];
    _textField1.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [_textField1 addTarget:self action:@selector(textFieldCanEdit:) forControlEvents:UIControlEventEditingChanged];
    
    _textField2 = [CreatView creatWithfFrame:CGRectMake(90, 60, WIDTH_CONTROLLER_DEFAULT - 100, 30) setPlaceholder:@"请输入身份证号" setTintColor:[UIColor grayColor]];
    [viewWhite addSubview:_textField2];
    _textField2.textColor = [UIColor zitihui];
    _textField2.delegate = self;
    _textField2.tag = 133;
    _textField2.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [_textField2 addTarget:self action:@selector(textFieldCanEdit:) forControlEvents:UIControlEventEditingChanged];
    
    buttonNext = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 160, WIDTH_CONTROLLER_DEFAULT - 80, HEIGHT_CONTROLLER_DEFAULT * (40.0 / 667.0)) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"认证"];
    [self.view addSubview:buttonNext];
    buttonNext.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [buttonNext addTarget:self action:@selector(nextStepButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag == 133) {
        
        if (range.location == 18) {
            
            return NO;
            
        } else {
            
            return YES;
        }
        
    } else {
        
        return YES;
    }
}

- (void)textFieldCanEdit:(UITextField *)textField
{
    if ([_textField1.text length] > 0 && [_textField2.text length] == 18) {
        
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    }
}

//认证按钮
- (void)nextStepButton:(UIButton *)button
{
    [self.view endEditing:YES];
    
    if (_textField1.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入真实姓名"];
        
    } else if (_textField2.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入身份证号"];
        
    } else if (![NSString validateIDCardNumber:_textField2.text]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"身份证号格式不对"];
    } else {
//        NSArray *viewController = [self.navigationController viewControllers];
//        [self.navigationController popToViewController:[viewController objectAtIndex:1] animated:YES];
        [self submitLoadingWithView:self.view loadingFlag:0 height:HEIGHT_CONTROLLER_DEFAULT/2 - 50];
        [self authRrealName];
    }
}

- (void)labelLineShow:(UILabel *)label
{
    label.alpha = 0.2;
    label.backgroundColor = [UIColor grayColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark 实名认证
#pragma mark --------------------------------

- (void)authRrealName
{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parameter = @{@"userId":[dic objectForKey:@"id"],@"realName":_textField1.text,@"IDCardNum":_textField2.text};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/authRrealName" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:400]] || responseObject == nil) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
                [FileOfManage createWithFile:@"isLogin.plist"];
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            } else {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"beforeWithView" object:@"MCM"];
            [self.navigationController popToRootViewControllerAnimated:NO];
            return ;
        } else if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            NSLog(@"%@",responseObject);
            [self submitLoadingWithHidden:YES];
            
            if (self.realNamePan == YES) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:nil];
                [self.navigationController popViewControllerAnimated:YES];
                
            } else {
                
                AddBankViewController *addBank = [[AddBankViewController alloc] init];
                addBank.realNameStatus = self.realNamePan;
                [self.navigationController pushViewController:addBank animated:YES];
            }
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            
            NSMutableDictionary *usersDic = [[NSMutableDictionary alloc]initWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
            
            //设置属性值,没有的数据就新建，已有的数据就修改。
            [usersDic setObject:_textField1.text forKey:@"realName"];
            [usersDic setObject:_textField2.text forKey:@"cardNumber"];
            //写入文件
            [usersDic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"exchangeWithImageView" object:nil];
            
        } else {
            
            [self submitLoadingWithHidden:YES];
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
       
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
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
