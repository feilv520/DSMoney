//
//  SuggestionViewController.m
//  DSLC
//
//  Created by ios on 15/10/26.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "SuggestionViewController.h"

@interface SuggestionViewController () <UITextViewDelegate>

{
    UITextView *_textView;
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
    
    UIButton *butMakeSure = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 210, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"提交"];
    [self.view addSubview:butMakeSure];
    [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    [butMakeSure addTarget:self action:@selector(buttonMakeSureSubmit:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *labelStat = [CreatView creatWithLabelFrame:CGRectMake(viewWhite.frame.size.width - 65, viewWhite.frame.size.height - 20, 55, 15) backgroundColor:[UIColor whiteColor] textColor:nil textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"138/500"];
    [viewWhite addSubview:labelStat];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, viewWhite.frame.size.width - 20, viewWhite.frame.size.height - 20 - 15)];
    [viewWhite addSubview:_textView];
    _textView.delegate = self;
    _textView.layer.cornerRadius = 3;
    _textView.layer.masksToBounds = YES;
    _textView.layer.borderWidth = 0.5;
    _textView.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
    
}

//提交按钮
- (void)buttonMakeSureSubmit:(UIButton *)button
{
    NSLog(@"提交");
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
