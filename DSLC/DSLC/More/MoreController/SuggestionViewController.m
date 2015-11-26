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
    
    UIButton *buttonBlack;
    UIView *viewMakeSure;
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
        NSString *sumStr = [NSString stringWithFormat:@"%ld", (long)statistics];
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
    if (_textView.text.length == 0) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"请留下宝贵意见"];
        
    } else {
        [self getSuggestionData];
        
//        buttonBlack = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
//        AppDelegate *app = [[UIApplication sharedApplication] delegate];
//        [app.tabBarVC.view addSubview:buttonBlack];
//        buttonBlack.alpha = 0.3;
//        [buttonBlack addTarget:self action:@selector(suggestionButtonDisappear:) forControlEvents:UIControlEventTouchUpInside];
//        
//        viewMakeSure = [CreatView creatViewWithFrame:CGRectMake(40, HEIGHT_CONTROLLER_DEFAULT/2 - 100, WIDTH_CONTROLLER_DEFAULT - 80, HEIGHT_CONTROLLER_DEFAULT/4 - 20) backgroundColor:[UIColor whiteColor]];
//        [app.tabBarVC.view addSubview:viewMakeSure];
//        viewMakeSure.layer.cornerRadius = 3;
//        viewMakeSure.layer.masksToBounds = YES;
//        
//        [_textView resignFirstResponder];
//        
//        CGFloat viewWidth = viewMakeSure.frame.size.width;
//        CGFloat viewHeight = viewMakeSure.frame.size.height;
//        
//        UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(0, 20, viewWidth, (viewHeight - 20)/2) backgroundColor:[UIColor whiteColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
//        [viewMakeSure addSubview:labelAlert];
//        labelAlert.numberOfLines = 2;
//        
//        NSMutableAttributedString *alertStr = [[NSMutableAttributedString alloc] initWithString:@"反馈已发送!\n感谢您的宝贵意见"];
//        [alertStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:18] range:[@"反馈已发送!\n感谢您的宝贵意见" rangeOfString:@"反馈已发送!"]];
//        [alertStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:[@"反馈已发送!\n感谢您的宝贵意见" rangeOfString:@"感谢您的宝贵意见"]];
//        [labelAlert setAttributedText:alertStr];
//        
//        UIButton *buttonDing = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(20, (viewHeight - 20)/2 + 20, viewWidth - 40, HEIGHT_CONTROLLER_DEFAULT * (40.0 / 667.0)) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"好的"];
//        [viewMakeSure addSubview:buttonDing];
//        buttonDing.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
//        [buttonDing setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
//        [buttonDing setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
//        [buttonDing addTarget:self action:@selector(suggestionButtonDisappear:) forControlEvents:UIControlEventTouchUpInside];
//        
//        UIButton *butCancle = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(viewWidth - 25, 5, 20, 20) backgroundColor:[UIColor whiteColor] textColor:nil titleText:nil];
//        [viewMakeSure addSubview:butCancle];
//        [butCancle setBackgroundImage:[UIImage imageNamed:@"cuo"] forState:UIControlStateNormal];
//        [butCancle setBackgroundImage:[UIImage imageNamed:@"cuo"] forState:UIControlStateHighlighted];
//        [butCancle addTarget:self action:@selector(suggestionButtonDisappear:) forControlEvents:UIControlEventTouchUpInside];
    }
}

//数据
- (void)getSuggestionData
{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    NSDictionary *parameter = @{@"content":_textView.text, @"token":[dic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/feedback" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"======%@", responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//点击黑色遮罩 弹框消失
- (void)suggestionButtonDisappear:(UIButton *)button
{
    [buttonBlack removeFromSuperview];
    [viewMakeSure removeFromSuperview];
    
    buttonBlack = nil;
    viewMakeSure = nil;
    
    
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
