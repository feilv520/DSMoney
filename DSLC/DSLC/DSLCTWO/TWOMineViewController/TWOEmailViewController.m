//
//  TWOEmailViewController.m
//  DSLC
//
//  Created by ios on 16/5/17.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOEmailViewController.h"
#import "TWOBindingEmailOverViewController.h"

@interface TWOEmailViewController () <UITextFieldDelegate>

{
    UITextField *textFieldEmail;
    UIButton *butNextOne;
}

@end

@implementation TWOEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor qianhuise];
    [self.navigationItem setTitle:@"邮箱绑定"];
    
    [self contentShow];
}

- (void)contentShow
{
    UIView *viewBottom = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 56) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewBottom];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 56, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [self.view addSubview:viewLine];
    viewLine.alpha = 0.3;
    
    UIImageView *imageSign = [CreatView creatImageViewWithFrame:CGRectMake(21, 17, 22, 22) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"youxiang"]];
    [viewBottom addSubview:imageSign];
    
    textFieldEmail = [CreatView creatWithfFrame:CGRectMake(59, 10, WIDTH_CONTROLLER_DEFAULT - 59 - 21, 36) setPlaceholder:@"请输入要绑定邮箱账号" setTintColor:[UIColor grayColor]];
    [viewBottom addSubview:textFieldEmail];
    textFieldEmail.delegate = self;
    textFieldEmail.textColor = [UIColor ZiTiColor];
    textFieldEmail.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [textFieldEmail addTarget:self action:@selector(textFieldEmailButtonGray:) forControlEvents:UIControlEventEditingChanged];
    
    butNextOne = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, 56 + 16, WIDTH_CONTROLLER_DEFAULT - 20, 40) backgroundColor:[UIColor findZiTiColor] textColor:[UIColor whiteColor] titleText:@"下一步"];
    [self.view addSubview:butNextOne];
    butNextOne.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    butNextOne.layer.cornerRadius = 5;
    butNextOne.layer.masksToBounds = YES;
    butNextOne.enabled = YES;
    [butNextOne addTarget:self action:@selector(buttonNextClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)textFieldEmailButtonGray:(UITextField *)textField
{
    if (textField.text.length == 0) {
        butNextOne.backgroundColor = [UIColor findZiTiColor];
    } else {
        butNextOne.backgroundColor = [UIColor profitColor];
    }
}

//下一步按钮
- (void)buttonNextClicked:(UIButton *)button
{
    if (textFieldEmail.text.length == 0) {
        
    } else if (![NSString validateEmail:textFieldEmail.text]) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请输入正确的邮箱格式"];
    } else {
        butNextOne.enabled = NO;
        [self bindingEmailData];
        [textFieldEmail resignFirstResponder];
    }
}

#pragma data
- (void)bindingEmailData
{
    NSDictionary *parmeter = @{@"email":textFieldEmail.text, @"token":[self.flagDic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"mail/updateUserEmail" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"绑定邮箱aaaaaaaa%@", responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            TWOBindingEmailOverViewController *bindingEmailVC = [[TWOBindingEmailOverViewController alloc] init];
            [self.navigationController pushViewController:bindingEmailVC animated:YES];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:nil];
            
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:[responseObject objectForKey:@"resultMsg"]]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
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
