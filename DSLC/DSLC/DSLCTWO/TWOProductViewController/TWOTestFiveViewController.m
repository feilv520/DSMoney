//
//  TWOTestFiveViewController.m
//  DSLC
//
//  Created by ios on 16/5/24.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOTestFiveViewController.h"
#import "TWOProductSafeTestViewController.h"

@interface TWOTestFiveViewController ()

{
    UIButton *buttonOne;
    UIButton *buttonTwo;
    UIButton *buttonThree;
    UIButton *buttonFour;
    UIButton *buttonFive;
    UIImageView *imageChoose;
    UIButton *butSubmit;
    CGFloat submitScore;
    BOOL flagClick;
    NSString *styleState;
}

@end

@implementation TWOTestFiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"安全测评"];
    flagClick = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scoreValue:) name:@"scoreTest" object:nil];
    
    [self contentShow];
}

- (void)scoreValue:(NSNotification *)nsnotice
{
    styleState = [nsnotice object];
    NSLog(@"mmmmmmmm%@", [nsnotice object]);
}

- (void)contentShow
{
    UIImageView *imageGround = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"background"]];
    [self.view addSubview:imageGround];
    imageGround.userInteractionEnabled = YES;
    
    UILabel *labelQuestion = [CreatView creatWithLabelFrame:CGRectMake(0, 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:17] text:@"以下哪种情况您无法接受？"];
    [imageGround addSubview:labelQuestion];
    
    CGFloat heightTop = 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20);
    CGFloat heightH = 35.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20);
    CGFloat jianju = 19.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20);
    
    NSArray *titleArray = @[@"本金无损失收益未达预期", @"轻微本金损失", @"本金10%以内的损失", @"本金20%-50%的损失", @"本金50%以上损失"];
    for (int a = 0; a < 5; a++) {
        UIButton *buttonAsk = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(30.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, heightTop + 30 + heightH + jianju * a + 55.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) * a, WIDTH_CONTROLLER_DEFAULT - 30.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT * 2, 55.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:[titleArray objectAtIndex:a]];
        [imageGround addSubview:buttonAsk];
        buttonAsk.layer.cornerRadius = 3;
        buttonAsk.layer.masksToBounds = YES;
        buttonAsk.layer.borderColor = [[UIColor whiteColor] CGColor];
        buttonAsk.layer.borderWidth = 1;
        buttonAsk.tag = 1000 + a;
        [buttonAsk addTarget:self action:@selector(buttonChooseAnswer:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    imageChoose = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 30.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT * 2 - 32 - 10, (55.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) - 32)/2, 32, 32) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"bluegou"]];
    
    butSubmit = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(33.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, heightTop + 30 + heightH + 55.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) * 5 + jianju * 4 + 35.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT - 33.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT * 2, 44.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor clearColor] textColor:[UIColor profitColor] titleText:@"提交"];
    [imageGround addSubview:butSubmit];
    butSubmit.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    butSubmit.layer.cornerRadius = 20;
    butSubmit.layer.masksToBounds = YES;
    butSubmit.layer.borderColor = [[UIColor profitColor] CGColor];
    butSubmit.layer.borderWidth = 1;
    [butSubmit addTarget:self action:@selector(buttonSubmitTest:) forControlEvents:UIControlEventTouchUpInside];
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        butSubmit.layer.cornerRadius = 15;
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 568) {
        imageChoose.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT - 25.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT * 2 - 32 - 10, (55.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) - 32)/2, 32, 32);
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 736) {
        butSubmit.layer.cornerRadius = 25;
    }
}

- (void)buttonChooseAnswer:(UIButton *)button
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"注册通知中心" object:nil];
    flagClick = YES;
    
    buttonOne = (UIButton *)[self.view viewWithTag:1000];
    buttonTwo = (UIButton *)[self.view viewWithTag:1001];
    buttonThree = (UIButton *)[self.view viewWithTag:1002];
    buttonFour = (UIButton *)[self.view viewWithTag:1003];
    buttonFive = (UIButton *)[self.view viewWithTag:1004];
    
    if (button.tag == 1000) {
        
        [imageChoose removeFromSuperview];
        
        [self buttonNoChoose:buttonTwo];
        [self buttonNoChoose:buttonThree];
        [self buttonNoChoose:buttonFour];
        [self buttonNoChoose:buttonFive];
        
        [self buttonAlreadyChoose:button];
        [button addSubview:imageChoose];
        submitScore = self.scoreFour - 5;
        
    } else if (button.tag == 1001) {
        
        [imageChoose removeFromSuperview];
        [self buttonNoChoose:buttonOne];
        [self buttonNoChoose:buttonThree];
        [self buttonNoChoose:buttonFour];
        [self buttonNoChoose:buttonFive];
        
        [self buttonAlreadyChoose:button];
        [button addSubview:imageChoose];
        submitScore = self.scoreFour + 5;
        
    } else if (button.tag == 1002) {
        
        [imageChoose removeFromSuperview];
        [self buttonNoChoose:buttonOne];
        [self buttonNoChoose:buttonTwo];
        [self buttonNoChoose:buttonFour];
        [self buttonNoChoose:buttonFive];
        
        [self buttonAlreadyChoose:button];
        [button addSubview:imageChoose];
        submitScore = self.scoreFour + 10;
        
    } else if (button.tag == 1003) {
        
        [imageChoose removeFromSuperview];
        [self buttonNoChoose:buttonOne];
        [self buttonNoChoose:buttonTwo];
        [self buttonNoChoose:buttonThree];
        [self buttonNoChoose:buttonFive];
        
        [self buttonAlreadyChoose:button];
        [button addSubview:imageChoose];
        submitScore = self.scoreFour + 15;
        
    } else {
        
        [imageChoose removeFromSuperview];
        [self buttonNoChoose:buttonOne];
        [self buttonNoChoose:buttonTwo];
        [self buttonNoChoose:buttonThree];
        [self buttonNoChoose:buttonFour];
        
        [self buttonAlreadyChoose:button];
        [button addSubview:imageChoose];
        submitScore = self.scoreFour + 20;
    }
}

//提交按钮
- (void)buttonSubmitTest:(UIButton *)button
{
    if (flagClick) {
        [self saveInvestTestResult];
        NSLog(@"kkkkkkkk%f", submitScore);
    } else {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请选择本题答案"];
    }
}

#pragma mark submit 测评----------------------------------------------------
- (void)saveInvestTestResult
{
    NSString *tokenString = [self.flagDic objectForKey:@"token"];
    
    NSDictionary *parameter = @{@"investTestResult":[NSString stringWithFormat:@"%lf",submitScore],@"token":tokenString};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"user/saveInvestTestResult" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"提交产品测评ppppppppppppppp%@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            TWOProductSafeTestViewController *safeTestVC = [[TWOProductSafeTestViewController alloc] init];
            safeTestVC.alreadyTest = YES;
            safeTestVC.score = submitScore;
            safeTestVC.securityLevel = styleState;
            NSLog(@"vvvvvvvv%@", styleState);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"safeTest" object:[NSString stringWithFormat:@"%f", submitScore]];
            pushVC(safeTestVC);
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

//封装没有选择的button颜色
- (void)buttonNoChoose:(UIButton *)button
{
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.borderColor = [[UIColor whiteColor] CGColor];
}

//选中的button的样式
- (void)buttonAlreadyChoose:(UIButton *)button
{
    [button setTitleColor:[UIColor profitColor] forState:UIControlStateNormal];
    button.layer.borderColor = [[UIColor profitColor] CGColor];
}

- (void)saveInvestTestResult{
    
    NSString *tokenString = [self.flagDic objectForKey:@"token"];
    
    NSDictionary *parameter = @{@"investTestResult":[NSString stringWithFormat:@"%lf",submitScore],@"token":tokenString};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"user/saveInvestTestResult" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"提交产品测评ppppppppppppppp%@",responseObject);
        
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
