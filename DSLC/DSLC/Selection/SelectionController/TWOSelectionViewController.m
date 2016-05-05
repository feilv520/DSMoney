//
//  TWOSelectionViewController.m
//  DSLC
//
//  Created by ios on 16/5/4.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOSelectionViewController.h"
#import "UIColor+AddColor.h"
#import "NewInviteViewController.h"
#import "TWOYaoYiYaoViewController.h"
#import "define.h"
#import "CreatView.h"

@interface TWOSelectionViewController ()

{
    UIButton *buttonClick;
}

@end

@implementation TWOSelectionViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor qianhuise];
    [self contentShow];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLoginView) name:@"showLoginView" object:nil];
}

- (void)contentShow
{
//    轮播banner的位置
    UIView *viewBanner = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 180.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    [self.view addSubview:viewBanner];
    viewBanner.backgroundColor = [UIColor qianhuise];
    
    UIImageView *imageBanner = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, viewBanner.frame.size.height) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"首页banner"]];
    [viewBanner addSubview:imageBanner];
    
//    公告位置
    UIView *viewNotice = [[UIView alloc] initWithFrame:CGRectMake(0, viewBanner.frame.size.height, WIDTH_CONTROLLER_DEFAULT, 32.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    [self.view addSubview:viewNotice];
    viewNotice.backgroundColor = [UIColor whiteColor];
    
//    公告图标
    UIImageView *imageNotice = [CreatView creatImageViewWithFrame:CGRectMake(6, 6, viewNotice.frame.size.height - 12, viewNotice.frame.size.height - 12) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"公告"]];
    [viewNotice addSubview:imageNotice];
    
//    公告view分界线
    UIView *viewLineNotice = [[UIView alloc] initWithFrame:CGRectMake(0, viewNotice.frame.size.height - 0.5, WIDTH_CONTROLLER_DEFAULT, 0.5)];
    [viewNotice addSubview:viewLineNotice];
    viewLineNotice.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    NSArray *imageArr = @[@"每日一摇", @"邀请好友"];
    
    for (int i = 0; i < 2; i++) {
        buttonClick = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:buttonClick];
        buttonClick.frame = CGRectMake(9 + (WIDTH_CONTROLLER_DEFAULT - 27)/2.0 * i + 9 * i, viewBanner.frame.size.height + viewNotice.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), (WIDTH_CONTROLLER_DEFAULT - 27)/2.0, 73.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20));
        buttonClick.backgroundColor = [UIColor qianhuise];
        buttonClick.tag = 1000 + i;
        [buttonClick setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [imageArr objectAtIndex:i]]] forState:UIControlStateNormal];
        [buttonClick addTarget:self action:@selector(buttonClickedChoose:) forControlEvents:UIControlEventTouchUpInside];
    }
    
//    最高收益的view
    UIView *viewBottom = [[UIView alloc] initWithFrame:CGRectMake(9, viewBanner.frame.size.height + viewNotice.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + buttonClick.frame.size.height, WIDTH_CONTROLLER_DEFAULT - 18, 308.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    [self.view addSubview:viewBottom];
    viewBottom.backgroundColor = [UIColor whiteColor];
    viewBottom.layer.cornerRadius = 5;
    viewBottom.layer.masksToBounds = YES;
    viewBottom.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
    viewBottom.layer.borderWidth = 1;
    
    CGFloat viewWidth = viewBottom.frame.size.width;
    
    UIImageView *imageHotSell = [CreatView creatImageViewWithFrame:CGRectMake(viewWidth - 50, 0, 50, 50) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"热卖"]];
    [viewBottom addSubview:imageHotSell];
    
    UILabel *labelName = [CreatView creatWithLabelFrame:CGRectMake(14, 14, viewWidth - 50 - 14, 25) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackZiTi] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"美猴王001期"];
    [viewBottom addSubview:labelName];
    
    UIButton *buttonLeft = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(19, 101, 30, 30) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [viewBottom addSubview:buttonLeft];
    [buttonLeft setBackgroundImage:[UIImage imageNamed:@"首页左箭头"] forState:UIControlStateNormal];
    [buttonLeft setBackgroundImage:[UIImage imageNamed:@"首页左箭头"] forState:UIControlStateHighlighted];
    [buttonLeft addTarget:self action:@selector(buttonLeftClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonRight = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(viewWidth - 19 - 30, 101, 30, 30) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [viewBottom addSubview:buttonRight];
    [buttonRight setBackgroundImage:[UIImage imageNamed:@"首页右箭头"] forState:UIControlStateNormal];
    [buttonRight setBackgroundImage:[UIImage imageNamed:@"首页右箭头"] forState:UIControlStateHighlighted];
    [buttonRight addTarget:self action:@selector(buttonRightClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageProfit = [CreatView creatImageViewWithFrame:CGRectMake(97.5, 47, viewWidth - 97.5 * 2, viewWidth - 97.5 * 2 - 25) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"产品圈圈"]];
    [viewBottom addSubview:imageProfit];
    
    UILabel *labelProfit = [CreatView creatWithLabelFrame:CGRectMake(12, imageProfit.frame.size.height/2 - 20, imageProfit.frame.size.width - 24, 50) backgroundColor:[UIColor clearColor] textColor:[UIColor profitColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:22] text:nil];
    [imageProfit addSubview:labelProfit];
    NSMutableAttributedString *profitString = [[NSMutableAttributedString alloc] initWithString:@"11.50%"];
    NSRange leftRange = NSMakeRange(0, [[profitString string] rangeOfString:@"%"].location);
    [profitString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:40] range:leftRange];
    [labelProfit setAttributedText:profitString];
    
    UILabel *labelYuQi = [CreatView creatWithLabelFrame:CGRectMake(0, imageProfit.frame.size.height - 10, imageProfit.frame.size.width, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"预期年化收益率"];
    [imageProfit addSubview:labelYuQi];
    
    CGFloat labelWidth = viewBottom.frame.size.width/3;
    NSArray *shuZiArr = @[@"3天", @"24.3万元", @"1,000元"];
    NSArray *wenZiArr = @[@"理财期限", @"剩余可投", @"起投资金"];
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *labelShuZi = [CreatView creatWithLabelFrame:CGRectMake(labelWidth * i, 47 + imageProfit.frame.size.height + 18, labelWidth, 22) backgroundColor:[UIColor whiteColor] textColor:[UIColor ZiTiColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:[shuZiArr objectAtIndex:i]];
        [viewBottom addSubview:labelShuZi];
        
        if (i == 0) {
            
            NSMutableAttributedString *leftStriing = [[NSMutableAttributedString alloc] initWithString:[shuZiArr objectAtIndex:0]];
            NSRange leftRange = NSMakeRange(0, [[leftStriing string] rangeOfString:@"天"].location);
            [leftStriing addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:leftRange];
            [labelShuZi setAttributedText:leftStriing];
            
        } else if (i == 1) {
            
            NSMutableAttributedString *leftStriing = [[NSMutableAttributedString alloc] initWithString:[shuZiArr objectAtIndex:1]];
            NSRange leftRange = NSMakeRange(0, [[leftStriing string] rangeOfString:@"万"].location);
            [leftStriing addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:leftRange];
            [labelShuZi setAttributedText:leftStriing];
            
        } else {
            
            NSMutableAttributedString *leftStriing = [[NSMutableAttributedString alloc] initWithString:[shuZiArr objectAtIndex:2]];
            NSRange leftRange = NSMakeRange(0, [[leftStriing string] rangeOfString:@"元"].location);
            [leftStriing addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:leftRange];
            [labelShuZi setAttributedText:leftStriing];
        }
        
        UILabel *labelWenZi = [CreatView creatWithLabelFrame:CGRectMake(labelWidth * i, 47 + imageProfit.frame.size.height + 18 + 22 + 9, labelWidth, 12) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:[wenZiArr objectAtIndex:i]];
        [viewBottom addSubview:labelWenZi];
    }
    
    UIButton *buttonQiang = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(9, 47 + imageProfit.frame.size.height + 18 + 22 + 32, viewWidth - 18, 40) backgroundColor:[UIColor whiteColor] textColor:nil titleText:nil];
    [viewBottom addSubview:buttonQiang];
    [buttonQiang setBackgroundImage:[UIImage imageNamed:@"立即抢购"] forState:UIControlStateNormal];
    [buttonQiang setBackgroundImage:[UIImage imageNamed:@"立即抢购"] forState:UIControlStateHighlighted];
    [buttonQiang addTarget:self action:@selector(rightQiangGou:) forControlEvents:UIControlEventTouchUpInside];
}

//每日一摇和邀请好友点击方法
- (void)buttonClickedChoose:(UIButton *)button
{
    if (button.tag == 1000) {
        TWOYaoYiYaoViewController *yaoyiyaoVC = [[TWOYaoYiYaoViewController alloc] init];
        [self.navigationController pushViewController:yaoyiyaoVC animated:YES];
    } else {
        NewInviteViewController *inviteVc = [[NewInviteViewController alloc] init];
        [self.navigationController pushViewController:inviteVc animated:YES];
    }
}

//左按钮点击方法
- (void)buttonLeftClicked:(UIButton *)button
{
    NSLog(@"zuo");
}

//有按钮点击方法
- (void)buttonRightClicked:(UIButton *)button
{
    NSLog(@"you");
}

//立即抢购按钮
- (void)rightQiangGou:(UIButton *)button
{
    NSLog(@"qiang");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)showLoginView
{
    [self ifLoginView];
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
