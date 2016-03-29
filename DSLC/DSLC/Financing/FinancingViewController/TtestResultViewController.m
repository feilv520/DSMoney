//
//  TtestResultViewController.m
//  DSLC
//
//  Created by ios on 16/3/28.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TtestResultViewController.h"

@interface TtestResultViewController ()

@end

@implementation TtestResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor qianhuise];
    [self.navigationItem setTitle:@"风险测试结果"];
    
    [self contentShow];
}

- (void)contentShow
{
    UIView *viewBottom = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 260) backgroundColor:[UIColor shurukuangColor]];
    [self.view addSubview:viewBottom];
    
    CGFloat height = viewBottom.frame.size.height;
    
    UILabel *labelResult = [CreatView creatWithLabelFrame:CGRectMake(10, 0, WIDTH_CONTROLLER_DEFAULT, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"风险测试结果"];
    [viewBottom addSubview:labelResult];
    
    UIView *viewWhite = [CreatView creatViewWithFrame:CGRectMake(0, 40, WIDTH_CONTROLLER_DEFAULT, height - 40) backgroundColor:[UIColor whiteColor]];
    [viewBottom addSubview:viewWhite];
    
    UILabel *labelStyle = [CreatView creatWithLabelFrame:CGRectMake(0, 20, WIDTH_CONTROLLER_DEFAULT, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:@"您的风险偏好类型为"];
    [viewWhite addSubview:labelStyle];
    
    UILabel *labelresult = [CreatView creatWithLabelFrame:CGRectMake(0, 50, WIDTH_CONTROLLER_DEFAULT, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor jinse] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:20] text:nil];
    [viewWhite addSubview:labelresult];
    
    UILabel *labelHaHa = [CreatView creatWithLabelFrame:CGRectMake(0, 80, WIDTH_CONTROLLER_DEFAULT, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:nil];
    [viewWhite addSubview:labelHaHa];
    
    UILabel *labelGood = [CreatView creatWithLabelFrame:CGRectMake(0, 120, WIDTH_CONTROLLER_DEFAULT, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:nil];
    [viewWhite addSubview:labelGood];
    labelGood.numberOfLines = 2;
    
    UILabel *labelLast = [CreatView creatWithLabelFrame:CGRectMake(0, 160, WIDTH_CONTROLLER_DEFAULT, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:nil];
    [viewWhite addSubview:labelLast];
    labelLast.numberOfLines = 2;
    
    if (self.score <= 9) {
        labelresult.text = @"保守型—低风险";
        labelHaHa.text = @"很赞，理财投资就应该像您一样小心谨慎";
        labelGood.text = @"刚好我们超低风险的产品适合您。";
        labelLast.text = @"大圣理财5.5%-15%年化收益让您赚钱超安心!";
        
    } else if (self.score >= 10 && self.score <= 17) {
        
        labelresult.text = @"稳健型—中低风险";
        labelHaHa.text = @"看来，您比较能把握分寸，进退有度呢";
        labelGood.text = @"我们低风险、高收益的产品应该能合您的心意。";
        labelLast.text = @"大圣理财5.5%-15%年化收益绝对是您的不二选择!";
        
    } else if (self.score >= 18 && self.score <= 30) {
        
        labelresult.text = @"平衡型—中风险";
        labelHaHa.text = @"看来您对收益的要求比较高，高收益意味着相对高的风险";
        labelGood.text = @"我们低风险高收益的产品更合您的心意。";
        labelLast.text = @"大圣理财5.5%-15%年化收益安心赚钱妥妥的!";
        
    } else if (self.score >= 31 && self.score <= 43) {
        
        labelresult.text = @"成长型——中高风险";
        labelHaHa.text = @"您是具备相当冒险精神的成长型投资者!";
        labelGood.text = @"激进的投资风格在为您带来超高收益的同时\n也让您面临着较高的风险。";
        labelLast.text = @"让我们谨慎一些, 请再次确认下您的风险承担类型吧~";
        
    } else {
        
        labelresult.text = @"进取型——高风险";
        labelHaHa.text = @"so crazy！您是个理财界的冒险家";
        labelGood.text = @"高风险高回报是您的追求。";
        labelLast.text = @"虽然人生玩的就是心跳,但是多一些谨慎也是极好的，\n让我们再次确认下您的风险承担类型吧~";
    }
    
    UIButton *buttonGoLook = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 320, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"去看看"];
    [self.view addSubview:buttonGoLook];
    buttonGoLook.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonGoLook setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
    [buttonGoLook setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    [buttonGoLook addTarget:self action:@selector(goToLookButton:) forControlEvents:UIControlEventTouchUpInside];
}

//去看看按钮
- (void)goToLookButton:(UIButton *)button
{
    NSArray *viewControllerArr = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[viewControllerArr objectAtIndex:1] animated:YES];
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
