//
//  MessageViewController.m
//  DSLC
//
//  Created by ios on 15/10/22.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MessageViewController.h"
#import "ChangeNumViewController.h"

@interface MessageViewController () <UITextFieldDelegate>

{
    UITextField *_textField;
    UIButton *buttonNext;
}

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    
    [self.navigationItem setTitle:@"身份验证"];
    
    [self contentShow];
}

- (void)contentShow
{
    UIView *viewWhite = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewWhite];
    
    UILabel *labelSecret = [CreatView creatWithLabelFrame:CGRectMake(10, 0, 60, 50) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"登录密码"];
    [viewWhite addSubview:labelSecret];
    
    _textField = [CreatView creatWithfFrame:CGRectMake(90, 10, viewWhite.frame.size.width - 80 - 20, 30) setPlaceholder:@"请输入登录密码" setTintColor:[UIColor grayColor]];
    [viewWhite addSubview:_textField];
    _textField.delegate = self;
    _textField.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [_textField addTarget:self action:@selector(textFiledEdit:) forControlEvents:UIControlEventEditingChanged];
    
    buttonNext = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 110, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"下一步"];
    [self.view addSubview:buttonNext];
    buttonNext.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [buttonNext addTarget:self action:@selector(buttonNext:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)textFiledEdit:(UITextField *)textField
{
    if ([textField.text length] > 0) {
        
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonNext setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

//下一步按钮
- (void)buttonNext:(UIButton *)button
{
    if ([_textField.text length] == 0) {
        
    } else {
        
        ChangeNumViewController *changeNumVC = [[ChangeNumViewController alloc] init];
        [self.navigationController pushViewController:changeNumVC animated:YES];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_textField resignFirstResponder];
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
