//
//  TWOAgreeFeedbackViewController.m
//  DSLC
//
//  Created by ios on 16/5/18.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOAgreeFeedbackViewController.h"
#import "UIPlaceHolderTextView.h"

@interface TWOAgreeFeedbackViewController () <UITextViewDelegate>

{
    UIPlaceHolderTextView *_textView;
    UIButton *butMakeSure;
    UILabel *labelStat;
}

@end

@implementation TWOAgreeFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"意见反馈"];
    
    [self contentShow];
}

- (void)contentShow
{
    _textView = [[UIPlaceHolderTextView alloc] initWithFrame:CGRectMake(9, 9, WIDTH_CONTROLLER_DEFAULT - 18, 152.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    _textView.placeholder = @"亲,留下您对客户端的优化意见,产品咨询问题请直接咨询【我的理财师】或者拨打客服热线:400-816-2283.";
    _textView.tintColor = [UIColor grayColor];
    [self.view addSubview:_textView];
    _textView.delegate = self;
    _textView.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [_textView becomeFirstResponder];
    _textView.layer.cornerRadius = 5;
    _textView.layer.masksToBounds = YES;
    _textView.layer.borderWidth = 0.5;
    _textView.layer.borderColor = [[UIColor profitColor] CGColor];
    
    labelStat = [CreatView creatWithLabelFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 65, 9 + _textView.frame.size.height + 11, 55, 15) backgroundColor:[UIColor whiteColor] textColor:nil textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:nil];
    [self.view addSubview:labelStat];
    NSMutableAttributedString *redStr = [[NSMutableAttributedString alloc] initWithString:@"0/200"];
    NSRange frontStr = NSMakeRange(0, [[redStr string] rangeOfString:@"/"].location);
    [redStr addAttribute:NSForegroundColorAttributeName value:[UIColor profitColor] range:frontStr];
    [labelStat setAttributedText:redStr];
    
    butMakeSure = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 9 + _textView.frame.size.height + 11 + labelStat.frame.size.height + 11, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor findZiTiColor] textColor:[UIColor whiteColor] titleText:@"提交"];
    [self.view addSubview:butMakeSure];
    butMakeSure.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    butMakeSure.layer.cornerRadius = 5;
    butMakeSure.layer.masksToBounds = YES;
    [butMakeSure addTarget:self action:@selector(buttonClickedMakeSureSubmit:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger statistics = [textView.text length];
    NSString *sumStr = [NSString stringWithFormat:@"%ld", (long)statistics];
    
    if (statistics >= 200) {
        NSString *sumString = [NSString stringWithFormat:@"%@%@", @"200", @"/200"];
        NSMutableAttributedString *redStr = [[NSMutableAttributedString alloc] initWithString:sumString];
        NSRange frontStr = NSMakeRange(0, [[redStr string] rangeOfString:@"/"].location);
        [redStr addAttribute:NSForegroundColorAttributeName value:[UIColor profitColor] range:frontStr];
        [labelStat setAttributedText:redStr];
        
    } else {
        
        NSString *sumString = [NSString stringWithFormat:@"%@%@", sumStr, @"/200"];
        NSMutableAttributedString *redStr = [[NSMutableAttributedString alloc] initWithString:sumString];
        NSRange frontStr = NSMakeRange(0, [[redStr string] rangeOfString:@"/"].location);
        [redStr addAttribute:NSForegroundColorAttributeName value:[UIColor profitColor] range:frontStr];
        [labelStat setAttributedText:redStr];
    }
    
    if ([textView.text isEqualToString:@""]) {
        
        NSLog(@"0");
        NSMutableAttributedString *redStr = [[NSMutableAttributedString alloc] initWithString:@"0/200"];
        NSRange frontStr = NSMakeRange(0, [[redStr string] rangeOfString:@"/"].location);
        [redStr addAttribute:NSForegroundColorAttributeName value:[UIColor profitColor] range:frontStr];
        [labelStat setAttributedText:redStr];
    }
    
    if (textView.text.length > 0 && textView.text.length <= 200) {
        
    } else if (textView.text.length > 200) {
        textView.text = [textView.text substringToIndex:200];
        
    } else {
        
    }
}

//按钮置灰
- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if (_textView.text.length == 0) {
        butMakeSure.backgroundColor = [UIColor findZiTiColor];
    } else {
        butMakeSure.backgroundColor = [UIColor profitColor];
    }
}

//规定不超过编辑字数范围200 如果输入超过200 就不能再输入
-(BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location < 200) {
        
        return YES;
        
    } else {
        
        return NO;
    }
}

//提交按钮
- (void)buttonClickedMakeSureSubmit:(UIButton *)button
{
    if (_textView.text.length == 0) {

    } else {
        [self getSuggestionData];
        [_textView resignFirstResponder];
    }
}

//数据
- (void)getSuggestionData
{
//    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
//    
//    if ([dic objectForKey:@"token"] == nil) {
//        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"为了你的问题能更好的解决,请登录后再提交反馈"];
//        return;
//    }
    
    NSDictionary *parameter = @{@"content":_textView.text, @"token":[self.flagDic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"feedback" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"意见反馈======%@", responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
        } else if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:400]]) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
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
