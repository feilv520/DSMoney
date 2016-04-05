//
//  TBuyViewController.m
//  DSLC
//
//  Created by ios on 16/3/29.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TBuyViewController.h"
#import "FDetailViewController.h"

@interface TBuyViewController () <UITextFieldDelegate>

{
    UITextField *_textField;
    UIButton *butMakeSure;
    UIButton *buttBlack;
    UIImageView *imageViewTan;
    UIView *viewWhite;
    UIButton *buttonBuy;
    UILabel *labelNum;
    NSInteger countIns;
}

@end

@implementation TBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor qianhuise];
    [self.navigationItem setTitle:@"购买权兑换"];
    
    countIns = 0;
    
    [self contentShow];
    [self getmonkeyNumber];
}

- (void)contentShow
{
    UIView *viewBottom = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 105) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewBottom];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 104.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [viewBottom addSubview:viewLine];
    viewLine.alpha = 0.3;
    
    UILabel *labelExchange = [CreatView creatWithLabelFrame:CGRectMake(10, 0, WIDTH_CONTROLLER_DEFAULT - 20, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"兑换数量"];
    [viewBottom addSubview:labelExchange];
    
    _textField = [CreatView creatWithfFrame:CGRectMake(10, 40, WIDTH_CONTROLLER_DEFAULT - 20, 50) setPlaceholder:@"请输入100的整数倍" setTintColor:[UIColor grayColor]];
    [viewBottom addSubview:_textField];
    _textField.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    _textField.backgroundColor = [UIColor shurukuangColor];
    _textField.delegate = self;
    _textField.layer.cornerRadius = 5;
    _textField.layer.masksToBounds = YES;
    _textField.layer.borderColor = [[UIColor shurukuangBian] CGColor];
    _textField.layer.borderWidth = 1;
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 50)];
    _textField.leftViewMode = UITextFieldViewModeAlways;
    [_textField addTarget:self action:@selector(textFieldEditMonkey:) forControlEvents:UIControlEventEditingChanged];
    
    UILabel *labelYuan = [CreatView creatWithLabelFrame:CGRectMake(_textField.frame.size.width - 25, 10, 15, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:@"元"];
    [_textField addSubview:labelYuan];
    
    UIView *viewDown = [CreatView creatViewWithFrame:CGRectMake(0, 115, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewDown];

    UIView *viewLine1 = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [viewDown addSubview:viewLine1];
    viewLine1.alpha = 0.3;
    
    UIView *viewLine2 = [CreatView creatViewWithFrame:CGRectMake(0, 49.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [viewDown addSubview:viewLine2];
    viewLine2.alpha = 0.3;
    
    UILabel *labelMonkey = [CreatView creatWithLabelFrame:CGRectMake(10, 10, 70, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"可用猴币"];
    [viewDown addSubview:labelMonkey];
    
//    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    labelNum = [CreatView creatWithLabelFrame:CGRectMake(80, 10, WIDTH_CONTROLLER_DEFAULT - 170, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor daohanglan] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:nil];
    [viewDown addSubview:labelNum];
    
    UIButton *buttonMoney = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 85, 10, 60, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor chongzhiColor] titleText:@"去赚猴币"];
    [viewDown addSubview:buttonMoney];
    buttonMoney.tag = 1;
    buttonMoney.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonMoney addTarget:self action:@selector(buttonGoGetMoney:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageRight = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 23, 17, 16, 16) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"arrow"]];
    [viewDown addSubview:imageRight];
    
    butMakeSure = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 225, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"确认兑换"];
    [self.view addSubview:butMakeSure];
    butMakeSure.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [butMakeSure addTarget:self action:@selector(buttonMakeSureExchange:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)textFieldEditMonkey:(UITextField *)textField
{
    if (textField.text.length == 0 || textField.text.integerValue % 100 != 0) {
        
        [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];

    } else if (textField.text.integerValue == 0) {
        
        [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
        
    } else {
        
        [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    }
}

//去赚钱
- (void)buttonGoGetMoney:(UIButton *)button
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.view endEditing:YES];
    [app.tabBarVC.tabScrollView setContentOffset:CGPointMake(button.tag * WIDTH_CONTROLLER_DEFAULT, 0) animated:NO];
    
    for (UIButton *tempButton in app.tabBarVC.tabButtonArray) {
        
        if (button.tag != tempButton.tag) {
            NSLog(@"%ld",(long)tempButton.tag);
            [tempButton setSelected:NO];
        }
        if (tempButton.tag == 1) {
            [tempButton setSelected:YES];
        }
    }
    
    popVC;
    
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:NO];
    [app.tabBarVC setLabelLineHidden:NO];
}

//确认兑换按钮
- (void)buttonMakeSureExchange:(UIButton *)button
{
    
    if (_textField.text.length == 0 || _textField.text.integerValue % 100 != 0) {
        
    } else if (_textField.text.integerValue == 0) {
        
    } else {
        
        countIns ++;
        if (countIns == 1) {
            [self submitLoadingWithView:self.view loadingFlag:NO height:0];
            
        } else {
            [self submitLoadingWithHidden:NO];
        }
        
        [self getDataList];
    }
}

- (void)tanKaungShow
{
    [self.view endEditing:YES];
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    buttBlack = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
    [app.tabBarVC.view addSubview:buttBlack];
    buttBlack.alpha = 0.3;
    [buttBlack addTarget:self action:@selector(blackButtonDisappear:) forControlEvents:UIControlEventTouchUpInside];
    
    viewWhite = [CreatView creatViewWithFrame:CGRectMake(40, (HEIGHT_CONTROLLER_DEFAULT - 24 - 60)/2 - 130, WIDTH_CONTROLLER_DEFAULT - 80, 260) backgroundColor:[UIColor whiteColor]];
    [app.tabBarVC.view addSubview:viewWhite];
    viewWhite.layer.cornerRadius = 5;
    viewWhite.layer.masksToBounds = YES;
    
    imageViewTan = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, viewWhite.frame.size.width, viewWhite.frame.size.height) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"矢量智能对象"]];
    [viewWhite addSubview:imageViewTan];
    imageViewTan.userInteractionEnabled = YES;
    
    buttonBuy = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(20, viewWhite.frame.size.height - 60, viewWhite.frame.size.width - 40, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"去购买"];
    [imageViewTan addSubview:buttonBuy];
    buttonBuy.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [buttonBuy setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
    [buttonBuy setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    [buttonBuy addTarget:self action:@selector(buttonGoToBuy:) forControlEvents:UIControlEventTouchUpInside];
}

//去购买按钮
- (void)buttonGoToBuy:(UIButton *)button
{
    NSLog(@"mai");
    NSDictionary *parameter = @{@"token":[self.flagDic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/product/getJDYOnSaleId" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"<<<<<<<<<<<<<<<<<%@", responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            NSLog(@"????????????%@", [responseObject objectForKey:@"productId"]);
            FDetailViewController *fdetailVC = [[FDetailViewController alloc] init];
            fdetailVC.idString = [responseObject objectForKey:@"productId"];
            fdetailVC.estimate = YES;
            [self.navigationController pushViewController:fdetailVC animated:YES];
            
        } else {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//获取猴币可用数量
- (void)getmonkeyNumber
{
    NSDictionary *parameter = @{@"token":[self.flagDic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/getUserMonkeyNumber" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"//////////%@", responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            labelNum.text = [NSString stringWithFormat:@"%@个", [responseObject objectForKey:@"uMonkeyNum"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//确认兑换接口
- (void)getDataList
{
    NSDictionary *parameter = @{@"token":[self.flagDic objectForKey:@"token"], @"uMonkeyNum":_textField.text};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/cashBuyJDYPower" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"兑换>>>>>>>>:%@", responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            [self submitLoadingWithHidden:YES];
            [self getmonkeyNumber];
            [self tanKaungShow];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"exchangeWithImageView" object:nil];
            
        } else {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//去掉黑色遮罩层
- (void)blackButtonDisappear:(UIButton *)button
{
    [buttBlack removeFromSuperview];
    [viewWhite removeFromSuperview];
    
    buttBlack = nil;
    viewWhite = nil;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location > 7) {
        return NO;
    } else {
        return YES;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [buttBlack removeFromSuperview];
    [viewWhite removeFromSuperview];
    
    buttBlack = nil;
    viewWhite = nil;
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
