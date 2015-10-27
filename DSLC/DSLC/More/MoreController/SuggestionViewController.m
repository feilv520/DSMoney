//
//  SuggestionViewController.m
//  DSLC
//
//  Created by ios on 15/10/26.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "SuggestionViewController.h"
#import "UIPlaceHolderTextView.h"

@interface SuggestionViewController () <UITextViewDelegate>

{
    UIPlaceHolderTextView *_textView;
    UIButton *butMakeSure;
    UILabel *labelStat;
}

@end

@implementation SuggestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    
    [self.navigationItem setTitle:@"意见反馈"];
    
    [self contentShow];
}

- (void)contentShow
{
    UIView *viewWhite = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 151) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewWhite];
    
    UILabel *labelLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 150.5, WIDTH_CONTROLLER_DEFAULT, 0.5)];
    [viewWhite addSubview:labelLine];
    labelLine.alpha = 0.2;
    labelLine.backgroundColor = [UIColor grayColor];
    
    labelStat = [CreatView creatWithLabelFrame:CGRectMake(viewWhite.frame.size.width - 65, viewWhite.frame.size.height - 20, 55, 15) backgroundColor:[UIColor whiteColor] textColor:nil textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:nil];
    [viewWhite addSubview:labelStat];
    NSMutableAttributedString *redStr = [[NSMutableAttributedString alloc] initWithString:@"0/500"];
    NSRange frontStr = NSMakeRange(0, [[redStr string] rangeOfString:@"/"].location);
    [redStr addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:frontStr];
    [labelStat setAttributedText:redStr];

    _textView = [[UIPlaceHolderTextView alloc] initWithFrame:CGRectMake(10, 10, viewWhite.frame.size.width - 20, viewWhite.frame.size.height - 20 - 15)];
    _textView.placeholder = @"亲,留下您对客户端的优化意见,产品咨询问题请直接咨询“我的理财师”或者拨打客服热线:400-525-698";
    _textView.tintColor = [UIColor grayColor];
    [viewWhite addSubview:_textView];
    _textView.delegate = self;
    _textView.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [_textView becomeFirstResponder];
    _textView.layer.cornerRadius = 3;
    _textView.layer.masksToBounds = YES;
    _textView.layer.borderWidth = 0.5;
    _textView.layer.borderColor = [[UIColor colorWithRed:232.0 / 255.0 green:232.0 / 255.0 blue:232.0 / 255.0 alpha:1.0] CGColor];
    
    butMakeSure = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 210, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"提交"];
    [self.view addSubview:butMakeSure];
    [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [butMakeSure addTarget:self action:@selector(buttonMakeSureSubmit:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 0 && textView.text.length <= 500) {
        
        [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
        NSInteger statistics = [textView.text length];
        NSString *sumStr = [NSString stringWithFormat:@"%ld", statistics];
        NSString *sumString = [NSString stringWithFormat:@"%@%@", sumStr, @"/500"];
        NSMutableAttributedString *redStr = [[NSMutableAttributedString alloc] initWithString:sumString];
        NSRange frontStr = NSMakeRange(0, [[redStr string] rangeOfString:@"/"].location);
        [redStr addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:frontStr];
        [labelStat setAttributedText:redStr];

        if ([textView.text isEqualToString:@""]) {
            
            NSLog(@"0");
            NSMutableAttributedString *redStr = [[NSMutableAttributedString alloc] initWithString:@"0/500"];
            NSRange frontStr = NSMakeRange(0, [[redStr string] rangeOfString:@"/"].location);
            [redStr addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:frontStr];
            [labelStat setAttributedText:redStr];

        }
        
    } else {

        [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

//规定不超过编辑字数范围500 如果输入超过500 就不能再输入
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location >= 500) {
        
        return NO;
        
    } else {
        
        return YES;
    }
    
}

//提交按钮
- (void)buttonMakeSureSubmit:(UIButton *)button
{
    if (_textView.text.length > 0 && _textView.text.length <= 500) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {
        
        
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_textView resignFirstResponder];
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
