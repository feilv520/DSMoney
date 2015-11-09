//
//  InviteNameViewController.m
//  DSLC
//
//  Created by ios on 15/11/9.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "InviteNameViewController.h"

@interface InviteNameViewController () <UITextFieldDelegate>

{
    UITextField *_textName;
    UITextField *_textPhoneNum;
    UIButton *butInvite;
    
    UIButton *buttBlack;
    UIView *viewWhite;
}

@end

@implementation InviteNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    [self.navigationItem setTitle:@"邀请新朋友"];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    UIView *viewShow = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewShow];
    
    UILabel *labelName = [CreatView creatWithLabelFrame:CGRectMake(10, 10, 60, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"姓名"];
    [viewShow addSubview:labelName];
    
    _textName = [CreatView creatWithfFrame:CGRectMake(80, 10, WIDTH_CONTROLLER_DEFAULT - 90, 30) setPlaceholder:@"请输入姓名" setTintColor:[UIColor grayColor]];
    [viewShow addSubview:_textName];
    _textName.textColor = [UIColor zitihui];
    _textName.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [_textName addTarget:self action:@selector(inviteTextField:) forControlEvents:UIControlEventEditingChanged];
    
    UILabel *labelLine1 = [CreatView creatWithLabelFrame:CGRectMake(0, 49.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentLeft textFont:nil text:nil];
    [viewShow addSubview:labelLine1];
    labelLine1.alpha = 0.3;
    
    UIView *viewDown = [CreatView creatViewWithFrame:CGRectMake(0, 60, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewDown];
    
    UILabel *labelPhone = [CreatView creatWithLabelFrame:CGRectMake(10, 10, 60, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"手机号"];
    [viewDown addSubview:labelPhone];
    
    _textPhoneNum = [CreatView creatWithfFrame:CGRectMake(80, 10, WIDTH_CONTROLLER_DEFAULT - 90, 30) setPlaceholder:@"请输入手机号" setTintColor:[UIColor grayColor]];
    [viewDown addSubview:_textPhoneNum];
    _textPhoneNum.delegate = self;
    _textPhoneNum.keyboardType = UIKeyboardTypeNumberPad;
    _textPhoneNum.textColor = [UIColor zitihui];
    _textPhoneNum.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [_textPhoneNum addTarget:self action:@selector(inviteTextField:) forControlEvents:UIControlEventEditingChanged];
    
    UILabel *labelLine2 = [CreatView creatWithLabelFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentLeft textFont:nil text:nil];
    [viewDown addSubview:labelLine2];
    labelLine2.alpha = 0.3;
    
    UILabel *labelLine3 = [CreatView creatWithLabelFrame:CGRectMake(0, 49.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentLeft textFont:nil text:nil];
    [viewDown addSubview:labelLine3];
    labelLine3.alpha = 0.3;
    
    butInvite = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 170, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"邀请"];
    [self.view addSubview:butInvite];
    butInvite.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butInvite setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [butInvite setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [butInvite addTarget:self action:@selector(buttonInviteGoodFriend:) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location == 11) {
        
        return NO;
        
    } else {
        
        return YES;
    }
}

- (void)inviteTextField:(UITextField *)textField
{
    if (_textName.text.length > 0 && _textPhoneNum.text.length == 11) {
        
        [butInvite setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [butInvite setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [butInvite setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butInvite setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

//邀请按钮
- (void)buttonInviteGoodFriend:(UIButton *)button
{
    if (_textName.text.length > 0 && _textPhoneNum.text.length == 11) {
        
        [self.view endEditing:YES];
        
        buttBlack = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [app.tabBarVC.view addSubview:buttBlack];
        buttBlack.alpha = 0.3;
        [buttBlack addTarget:self action:@selector(buttonBlackMakeDisappear:) forControlEvents:UIControlEventTouchUpInside];
        
        viewWhite = [CreatView creatViewWithFrame:CGRectMake(40, (HEIGHT_CONTROLLER_DEFAULT - 40)/2 - 90, WIDTH_CONTROLLER_DEFAULT - 80, 180) backgroundColor:[UIColor whiteColor]];
        [app.tabBarVC.view addSubview:viewWhite];
        viewWhite.layer.cornerRadius = 5;
        viewWhite.layer.masksToBounds = YES;
        
        CGFloat viewWidth = viewWhite.frame.size.width;
        
        UILabel *labelInvite = [CreatView creatWithLabelFrame:CGRectMake(0, 10, viewWidth, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"提示"];
        [viewWhite addSubview:labelInvite];
        
        UILabel *labelLine = [[UILabel alloc] initWithFrame:CGRectMake(5, 49.5, viewWidth - 10, 0.5)];
        [viewWhite addSubview:labelLine];
        labelLine.backgroundColor = [UIColor grayColor];
        labelLine.alpha = 0.3;
        
        UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(0, 50, viewWidth, 50) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:17] text:@"邀请成功!系统已为您发送邀请短信"];
        [viewWhite addSubview:labelAlert];
        
        UIButton *buttGood = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(20, 110, viewWidth - 40, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"好的"];
        [viewWhite addSubview:buttGood];
        buttGood.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        [buttGood setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [buttGood setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        [buttGood addTarget:self action:@selector(buttonBlackMakeDisappear:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)buttonBlackMakeDisappear:(UIButton *)button
{
    [buttBlack removeFromSuperview];
    [viewWhite removeFromSuperview];
    
    buttBlack = nil;
    viewWhite = nil;
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
