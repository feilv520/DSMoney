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
#import "TWOFindViewController.h"

@interface TWOSelectionViewController ()

{
    UIButton *buttonClick;
    UIScrollView *scrollView;
    UIView *viewBottom;
    UIButton *buttonHei;
    UILabel *labelMonkey;
    UIImageView *imageSign;
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
    [self signFinish];
    [self contentShow];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLoginView) name:@"showLoginView" object:nil];
}

//签到成功
- (void)signFinish
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    buttonHei = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, self.view.frame.size.height) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
    [app.tabBarVC.view addSubview:buttonHei];
    buttonHei.alpha = 0.6;
    [buttonHei addTarget:self action:@selector(clickedBlackDisappear:) forControlEvents:UIControlEventTouchUpInside];
    
    labelMonkey = [CreatView creatWithLabelFrame:CGRectMake(0, 194.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:27] text:[NSString stringWithFormat:@"%@猴币", @"+66"]];
    [app.tabBarVC.view addSubview:labelMonkey];
    
    imageSign = [CreatView creatImageViewWithFrame:CGRectMake(40, 194.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 30, WIDTH_CONTROLLER_DEFAULT - 80, 230) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"doSign"]];
    [app.tabBarVC.view addSubview:imageSign];
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
        [buttonClick setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [imageArr objectAtIndex:i]]] forState:UIControlStateHighlighted];
        [buttonClick addTarget:self action:@selector(buttonClickedChoose:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, viewBanner.frame.size.height + viewNotice.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + buttonClick.frame.size.height, WIDTH_CONTROLLER_DEFAULT, 308.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    [self.view addSubview:scrollView];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(WIDTH_CONTROLLER_DEFAULT * 3, 0);
    
    NSArray *nameArr = @[@"美猴王001期", @"丁颖", @"马成精"];
    NSArray *profitArr = @[@"11.5", @"13.9", @"5.2"];
    NSArray *dayArr = @[@"3", @"6", @"5"];
    NSArray *moneyArr = @[@"24.3", @"78.2", @"89.3"];
    NSArray *qitouArr = @[@"1,000", @"6,000", @"8,000"];
    
    for (int i = 0; i < 3; i++) {
        
        [self contentMostProfitWithWidth:i name:[nameArr objectAtIndex:i] profit:[profitArr objectAtIndex:i] day:[dayArr objectAtIndex:i] shengyu:[moneyArr objectAtIndex:i] qitouMoney:[qitouArr objectAtIndex:i]];
    }
}

- (void)contentMostProfitWithWidth:(CGFloat)width name:(NSString *)productName profit:(NSString *)profit day:(NSString *)dayNum shengyu:(NSString *)shengMoney qitouMoney:(NSString *)qitouMoney
{
//    最高收益的view
    viewBottom = [[UIView alloc] initWithFrame:CGRectMake(9 + WIDTH_CONTROLLER_DEFAULT * width, 0, WIDTH_CONTROLLER_DEFAULT - 18, scrollView.frame.size.height)];
    [scrollView addSubview:viewBottom];
    viewBottom.backgroundColor = [UIColor whiteColor];
    viewBottom.layer.cornerRadius = 5;
    viewBottom.layer.masksToBounds = YES;
    viewBottom.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
    viewBottom.layer.borderWidth = 1;
    
    CGFloat viewWidth = viewBottom.frame.size.width;
    
    UIImageView *imageHotSell = [CreatView creatImageViewWithFrame:CGRectMake(viewWidth - 50, 0, 50, 50) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"热卖"]];
    [viewBottom addSubview:imageHotSell];
    
    UILabel *labelName = [CreatView creatWithLabelFrame:CGRectMake(14, 14, viewWidth - 50 - 14, 25) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackZiTi] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:productName];
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
    NSMutableAttributedString *profitString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%", profit]];
    NSRange leftRange = NSMakeRange(0, [[profitString string] rangeOfString:@"%"].location);
    [profitString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:40] range:leftRange];
    [labelProfit setAttributedText:profitString];
    
    UILabel *labelYuQi = [CreatView creatWithLabelFrame:CGRectMake(0, imageProfit.frame.size.height - 10, imageProfit.frame.size.width, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"预期年化收益率"];
    [imageProfit addSubview:labelYuQi];
    
//    NSArray *shuZiArr = @[@"3", @"24.3", @"1,000"];
    CGFloat labelWidth = (WIDTH_CONTROLLER_DEFAULT - 18)/3;
//    理财期限的天数
    UILabel *labelShuZi = [CreatView creatWithLabelFrame:CGRectMake(0, 47 + imageProfit.frame.size.height + 18, labelWidth, 22) backgroundColor:[UIColor clearColor] textColor:[UIColor ZiTiColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:nil];
    [viewBottom addSubview:labelShuZi];
    NSMutableAttributedString *leftStriing = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@天", @"3"]];
    NSRange leftrange = NSMakeRange(0, [[leftStriing string] rangeOfString:@"天"].location);
    [leftStriing addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:leftrange];
    [labelShuZi setAttributedText:leftStriing];
    
//    剩余可投的钱数
    UILabel *labelShengYuM = [CreatView creatWithLabelFrame:CGRectMake(labelWidth, 47 + imageProfit.frame.size.height + 18, labelWidth, 22) backgroundColor:[UIColor clearColor] textColor:[UIColor ZiTiColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:nil];
    [viewBottom addSubview:labelShengYuM];
    NSMutableAttributedString *moneyStriing = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@万元", @"24.3"]];
    NSRange money = NSMakeRange(0, [[moneyStriing string] rangeOfString:@"万"].location);
    [moneyStriing addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:money];
    [labelShengYuM setAttributedText:moneyStriing];
    
//    起投资金的钱数
    UILabel *labelQiTouM = [CreatView creatWithLabelFrame:CGRectMake(labelWidth * 2, 47 + imageProfit.frame.size.height + 18, labelWidth, 22) backgroundColor:[UIColor clearColor] textColor:[UIColor ZiTiColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:nil];
    [viewBottom addSubview:labelQiTouM];
    NSMutableAttributedString *qiTouStriing = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", @"1000"]];
    NSRange qiTouMoney = NSMakeRange(0, [[qiTouStriing string] rangeOfString:@"元"].location);
    [qiTouStriing addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:qiTouMoney];
    [labelQiTouM setAttributedText:qiTouStriing];
    
    NSArray *wenZiArr = @[@"理财期限", @"剩余可投", @"起投资金"];
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *labelWenZi = [CreatView creatWithLabelFrame:CGRectMake(labelWidth * i, 47 + imageProfit.frame.size.height + 18 + 22 + 9, labelWidth, 12) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:[wenZiArr objectAtIndex:i]];
        [viewBottom addSubview:labelWenZi];
    }
    
    UIButton *buttonQiang = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(9, 47 + imageProfit.frame.size.height + 18 + 22 + 32, viewWidth - 18, 40) backgroundColor:[UIColor whiteColor] textColor:nil titleText:nil];
    [viewBottom addSubview:buttonQiang];
    [buttonQiang setBackgroundImage:[UIImage imageNamed:@"立即抢购"] forState:UIControlStateNormal];
    [buttonQiang setBackgroundImage:[UIImage imageNamed:@"立即抢购"] forState:UIControlStateHighlighted];
    [buttonQiang addTarget:self action:@selector(rightQiangGou:) forControlEvents:UIControlEventTouchUpInside];
}

//黑色遮罩层消失
- (void)clickedBlackDisappear:(UIButton *)button
{
    [buttonHei removeFromSuperview];
    [labelMonkey removeFromSuperview];
    [imageSign removeFromSuperview];
    
    buttonHei = nil;
    labelMonkey = nil;
    imageSign = nil;
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
    if (viewBottom.frame.origin.x == 9) {
        
    } else {
        
        
    }
}

//有按钮点击方法
- (void)buttonRightClicked:(UIButton *)button
{
    NSLog(@"you");
    if (viewBottom.frame.origin.x == 9) {
        
    } else {
        
        
    }
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        NSLog(@"666666666");
        for (int i = 0; i < 3; i++) {
            scrollView.contentSize = CGSizeMake(WIDTH_CONTROLLER_DEFAULT * i, 0);
        }
        
    } completion:^(BOOL finished) {
        
    }];
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
