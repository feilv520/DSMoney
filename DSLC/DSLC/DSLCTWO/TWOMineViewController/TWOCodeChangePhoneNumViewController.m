//
//  TWOCodeChangePhoneNumViewController.m
//  DSLC
//
//  Created by ios on 16/5/16.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOCodeChangePhoneNumViewController.h"
#import "TWOImputNewPhoneNumViewController.h"

@interface TWOCodeChangePhoneNumViewController () <UITextFieldDelegate>

{
    UITextField *textFieldCode;
}

@end

@implementation TWOCodeChangePhoneNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor qianhuise];
    [self.navigationItem setTitle:@"更换绑定手机号"];
    
    [self contentShow];
}

- (void)contentShow
{
    UIView *viewBottom = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 56) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewBottom];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, viewBottom.frame.size.height, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [self.view addSubview:viewLine];
    viewLine.alpha = 0.3;
    
    UIImageView *imageSuo = [CreatView creatImageViewWithFrame:CGRectMake(22, 18, 20, 20) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"yanzhenma"]];
    [viewBottom addSubview:imageSuo];
    
    textFieldCode = [CreatView creatWithfFrame:CGRectMake(59, 13, WIDTH_CONTROLLER_DEFAULT - 42 - 30 , 30) setPlaceholder:@"请输入登录密码" setTintColor:[UIColor grayColor]];
    [viewBottom addSubview:textFieldCode];
    textFieldCode.delegate = self;
    textFieldCode.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    textFieldCode.textColor = [UIColor findZiTiColor];
    [textFieldCode addTarget:self action:@selector(textFieldValueChange:) forControlEvents:UIControlEventEditingChanged];
    
    UIButton *butNext = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, 56 + 15, WIDTH_CONTROLLER_DEFAULT - 20, 40) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"下一步"];
    [self.view addSubview:butNext];
    butNext.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    butNext.layer.cornerRadius = 5;
    butNext.layer.masksToBounds = YES;
    [butNext addTarget:self action:@selector(nextOneStepButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)textFieldValueChange:(UITextField *)textField
{
    
}

//下一步按钮
- (void)nextOneStepButton:(UIButton *)button
{
    if (textFieldCode.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入登录密码"];
    } else {
        [self.view endEditing:YES];
        TWOImputNewPhoneNumViewController *imputNumVC = [[TWOImputNewPhoneNumViewController alloc] init];
        [self.navigationController pushViewController:imputNumVC animated:YES];
    }
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
