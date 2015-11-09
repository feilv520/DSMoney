//
//  RealNameViewController.m
//  DSLC
//
//  Created by ios on 15/10/23.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "RealNameViewController.h"

@interface RealNameViewController ()

{
    UITextField *_textField1;
    UITextField *_textField2;
    UITextField *_textField3;
    UIButton *buttonNext;
}

@end

@implementation RealNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    
    [self.navigationItem setTitle:@"实名认证"];
    
    [self contentShow];
}

- (void)contentShow
{
    UIView *viewWhite = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 100) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewWhite];
    viewWhite.backgroundColor = [UIColor whiteColor];
    
    UILabel *realName = [CreatView creatWithLabelFrame:CGRectMake(10, 0, 60, 49.5) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"真实姓名"];
    [viewWhite addSubview:realName];
    
    UILabel *labelLine1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 49.5, WIDTH_CONTROLLER_DEFAULT - 20, 0.5)];
    [viewWhite addSubview:labelLine1];
    [self labelLineShow:labelLine1];
    
    UILabel *documentStyle = [CreatView creatWithLabelFrame:CGRectMake(10, 50, 60, 49.5) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"身份证号"];
    [viewWhite addSubview:documentStyle];
    
    UILabel *labelLine2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 99.5, WIDTH_CONTROLLER_DEFAULT - 20, 0.5)];
    [viewWhite addSubview:labelLine2];
    [self labelLineShow:labelLine2];
    
    _textField1 = [CreatView creatWithfFrame:CGRectMake(90, 10, WIDTH_CONTROLLER_DEFAULT - 100, 30) setPlaceholder:@"真实姓名" setTintColor:[UIColor grayColor]];
    [viewWhite addSubview:_textField1];
    _textField1.textColor = [UIColor zitihui];
    _textField1.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [_textField1 addTarget:self action:@selector(textFieldCanEdit:) forControlEvents:UIControlEventEditingChanged];
    
    _textField2 = [CreatView creatWithfFrame:CGRectMake(90, 60, WIDTH_CONTROLLER_DEFAULT - 100, 30) setPlaceholder:@"请输入身份证号" setTintColor:[UIColor grayColor]];
    [viewWhite addSubview:_textField2];
    _textField2.textColor = [UIColor zitihui];
    _textField2.keyboardType = UIKeyboardTypeNumberPad;
    _textField2.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [_textField2 addTarget:self action:@selector(textFieldCanEdit:) forControlEvents:UIControlEventEditingChanged];
    
    buttonNext = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, HEIGHT_CONTROLLER_DEFAULT * (150.0 / 667.0), WIDTH_CONTROLLER_DEFAULT - 80, HEIGHT_CONTROLLER_DEFAULT * (40.0 / 667.0)) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"认证"];
    [self.view addSubview:buttonNext];
    buttonNext.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [buttonNext addTarget:self action:@selector(nextStepButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)textFieldCanEdit:(UITextField *)textField
{
    if ([_textField1.text length] > 0 && [_textField2.text length] > 0) {
        
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
    if ([_textField1.text length] > 0 && [_textField2.text length] > 0 && [_textField3.text length] > 0) {
        
        NSLog(@"认证");
        
    } else {
        
        
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
