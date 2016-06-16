//
//  TWOYaoYiYaoViewController.m
//  DSLC
//
//  Created by ios on 16/5/4.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOYaoYiYaoViewController.h"
#import "TWOActivityRulesViewController.h"
#import "TWOWinPrizeRecordViewController.h"

@interface TWOYaoYiYaoViewController ()

{
    UIButton *butShare;
    UIImageView *imageBack;
    UIButton *butShuZi;
    
    UIButton *butBlack;
    UIView *viewBottom;
    UIImageView *imageYellow;
    CABasicAnimation *momAnimation;
    UIImageView *imageHandYao;
}

@end

@implementation TWOYaoYiYaoViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];    
    butShare.hidden = NO;
}

-(void)viewDidAppear:(BOOL)animated
{
    [self canBecomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"摇一摇"];
    
    [self commonHaveShow];
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)haveNoChanceShow
{
//    显示还有几次摇一摇机会
    UILabel *labelChance = [CreatView creatWithLabelFrame:CGRectMake(0, 10, imageYellow.frame.size.width, 23) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:19] text:nil];
    [imageYellow addSubview:labelChance];
    NSMutableAttributedString *zeroString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"您还有%@次机会", @"0"]];
    NSRange zeroRange = NSMakeRange(3, 1);
    [zeroString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:zeroRange];
    [labelChance setAttributedText:zeroString];
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        labelChance.frame = CGRectMake(0, 4, imageYellow.frame.size.width, 23);
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 568) {
        labelChance.frame = CGRectMake(0, 6, imageYellow.frame.size.width, 23);
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 736) {
        labelChance.frame = CGRectMake(0, 12, imageYellow.frame.size.width, 23);
    }
}

- (void)haveChanceContentShow
{
//    显示还有几次摇一摇机会
    UILabel *labelChance = [CreatView creatWithLabelFrame:CGRectMake(0, 10, imageYellow.frame.size.width, 23) backgroundColor:[UIColor clearColor] textColor:[UIColor orangecolor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:22] text:nil];
    [imageYellow addSubview:labelChance];
    NSMutableAttributedString *shuZiString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"您还有%@次机会", @"2"]];
    NSRange leftRange = NSMakeRange(0, 3);
    [shuZiString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:19] range:leftRange];
    [shuZiString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:leftRange];
    NSRange rightRange = NSMakeRange([[shuZiString string] length] - 3, 3);
    [shuZiString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:19] range:rightRange];
    [shuZiString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:rightRange];
    [labelChance setAttributedText:shuZiString];
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        labelChance.frame = CGRectMake(0, 4, imageYellow.frame.size.width, 23);
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 568) {
        labelChance.frame = CGRectMake(0, 6, imageYellow.frame.size.width, 23);
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 736) {
        labelChance.frame = CGRectMake(0, 12, imageYellow.frame.size.width, 23);
    }
}

//公共的部分
- (void)commonHaveShow
{
    imageBack = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"yao"]];
    [self.view addSubview:imageBack];
    imageBack.userInteractionEnabled = YES;
    
//    分享按钮
    butShare = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 10 - 25, 10, 25, 25) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [self.navigationController.navigationBar addSubview:butShare];
    [butShare setBackgroundImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
    [butShare setBackgroundImage:[UIImage imageNamed:@"icon_shareq"] forState:UIControlStateHighlighted];
    [butShare addTarget:self action:@selector(buttonShareYaoYiYao:) forControlEvents:UIControlEventTouchUpInside];
    
//    摇动的图片
    imageHandYao = [CreatView creatImageViewWithFrame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - 162.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT)/2, 186.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 162.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 219.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"yaoyiyao"]];
    [imageBack addSubview:imageHandYao];
    
//    显示还有几次摇动机会的背景图
    imageYellow = [CreatView creatImageViewWithFrame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - 305.5 / 375.0 * WIDTH_CONTROLLER_DEFAULT)/2, 380.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 305.5 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 71.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"yellow"]];
    [imageBack addSubview:imageYellow];
    
//    下面蓝色按钮宽度
    CGFloat butWidth = (WIDTH_CONTROLLER_DEFAULT - 27)/2;
    
//    活动规则蓝色底
    UIButton *butYaoLeft = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(9, imageBack.frame.size.height - 29.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) - 45, butWidth, 45) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [imageBack addSubview:butYaoLeft];
    [butYaoLeft setBackgroundImage:[UIImage imageNamed:@"blueYao"] forState:UIControlStateNormal];
    [butYaoLeft setBackgroundImage:[UIImage imageNamed:@"blueYao"] forState:UIControlStateHighlighted];
    [butYaoLeft addTarget:self action:@selector(buttonActivityRules:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *butActivity = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(5, 3, butYaoLeft.frame.size.width - 10, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor ] titleText:@"活动规则"];
    [butYaoLeft addSubview:butActivity];
    butActivity.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:17];
    [butActivity addTarget:self action:@selector(buttonActivityRules:) forControlEvents:UIControlEventTouchUpInside];
    
//    中奖纪录蓝色底
    UIButton *butYaoRight = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(9 + butWidth + 9, imageBack.frame.size.height - 29.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) - 45, butWidth, 45) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [imageBack addSubview:butYaoRight];
    [butYaoRight setBackgroundImage:[UIImage imageNamed:@"blueYao"] forState:UIControlStateNormal];
    [butYaoRight setBackgroundImage:[UIImage imageNamed:@"blueYao"] forState:UIControlStateHighlighted];
    [butYaoRight addTarget:self action:@selector(winAPrizeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *butWinPrize = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(butWidth/2 - 34, 3, 68, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"中奖纪录"];
    [butYaoRight addSubview:butWinPrize];
    butWinPrize.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:17];
    [butWinPrize addTarget:self action:@selector(winAPrizeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    中奖纪录的数字
    butShuZi = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(butWinPrize.frame.size.width - 5, 0, 16, 16) backgroundColor:[UIColor orangecolor] textColor:[UIColor whiteColor] titleText:@"11"];
    [butWinPrize addSubview:butShuZi];
    butShuZi.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:10];
    butShuZi.layer.cornerRadius = 8;
    butShuZi.layer.masksToBounds = YES;
    [butShuZi addTarget:self action:@selector(winAPrizeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        butYaoLeft.frame = CGRectMake(9, imageBack.frame.size.height - 20.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) - 45, butWidth, 45);
        butYaoRight.frame = CGRectMake(9 + butWidth + 9, imageBack.frame.size.height - 20.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) - 45, butWidth, 45);
    }
    
    [self haveChanceContentShow];
//    [self haveNoChanceShow];
}

- (void)tanKuangeShow
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    butBlack = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
    [app.tabBarVC.view addSubview:butBlack];
    butBlack.alpha = 0.4;
    [butBlack addTarget:self action:@selector(yaoBlackDisappearButton:) forControlEvents:UIControlEventTouchUpInside];
    
    viewBottom = [CreatView creatViewWithFrame:CGRectMake(35, HEIGHT_CONTROLLER_DEFAULT/2 - 150, WIDTH_CONTROLLER_DEFAULT - 70, 240) backgroundColor:[UIColor whiteColor]];
    [app.tabBarVC.view addSubview:viewBottom];
    viewBottom.layer.cornerRadius = 5;
    viewBottom.layer.masksToBounds = YES;
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [viewBottom.layer addAnimation:animation forKey:nil];
    
//    [self haveNoWinPrize];
    [self winPrizeShow];
}

//没有中奖的弹框
- (void)haveNoWinPrize
{
//    没有中奖图片
    UIImageView *imageNoWin = [CreatView creatImageViewWithFrame:CGRectMake(viewBottom.frame.size.width/2 - 45, 15, 90, 110) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"nowin"]];
    [viewBottom addSubview:imageNoWin];
    
    UILabel *labelNoChance = [CreatView creatWithLabelFrame:CGRectMake(0, 15 + 110 + 10, viewBottom.frame.size.width, 17) backgroundColor:[UIColor clearColor] textColor:[UIColor ZiTiColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:17] text:@"您的每日一摇次数已用完!"];
    [viewBottom addSubview:labelNoChance];
    
    UILabel *labelZero = [CreatView creatWithLabelFrame:CGRectMake(0, 15 + 110 + 10 + 17 + 10, viewBottom.frame.size.width, 15) backgroundColor:[UIColor whiteColor] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:nil];
    [viewBottom addSubview:labelZero];
    NSMutableAttributedString *numString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"您还有%@次机会", @"0"]];
    NSRange numRange = NSMakeRange(3, 1);
    [numString addAttribute:NSForegroundColorAttributeName value:[UIColor orangecolor] range:numRange];
    [labelZero setAttributedText:numString];
    
//    确定按钮
    UIButton *buttonOK = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(16, 15 + 110 + 10 + 17 + 10 + 15 + 13, viewBottom.frame.size.width - 32, 38) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"确定"];
    [viewBottom addSubview:buttonOK];
    buttonOK.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonOK.layer.cornerRadius = 5;
    buttonOK.layer.masksToBounds = YES;
    [buttonOK addTarget:self action:@selector(yaoBlackDisappearButton:) forControlEvents:UIControlEventTouchUpInside];
}

//中奖了弹框
- (void)winPrizeShow
{
    UIImageView *imagePrize = [CreatView creatImageViewWithFrame:CGRectMake(viewBottom.frame.size.width/2 - 75  , 0, 150, viewBottom.frame.size.height - 50) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"winPrize"]];
    [viewBottom addSubview:imagePrize];
    imagePrize.userInteractionEnabled = YES;
    
    UILabel *labelPrize = [CreatView creatWithLabelFrame:CGRectMake(0, 20, viewBottom.frame.size.width, 45) backgroundColor:[UIColor clearColor] textColor:[UIColor orangecolor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:24] text:nil];
    [viewBottom addSubview:labelPrize];
    NSMutableAttributedString *prizeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%加息券", @"2"]];
    NSRange prizeRange = NSMakeRange(0, [[prizeString string]rangeOfString:@"%"].location);
    [prizeString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:44] range:prizeRange];
    [labelPrize setAttributedText:prizeString];
    
    UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(0, 20 + 45 + 15, viewBottom.frame.size.width, 15) backgroundColor:[UIColor clearColor] textColor:[UIColor ZiTiColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"大力出奇迹,恭喜您摇中"];
    [viewBottom addSubview:labelAlert];
    
    UIButton *butOK = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(16, viewBottom.frame.size.height - 53, viewBottom.frame.size.width - 32, 38) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"确定"];
    [viewBottom addSubview:butOK];
    butOK.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    butOK.layer.cornerRadius = 5;
    butOK.layer.masksToBounds = YES;
    [butOK addTarget:self action:@selector(yaoBlackDisappearButton:) forControlEvents:UIControlEventTouchUpInside];
}

//活动规则
- (void)buttonActivityRules:(UIButton *)button
{
    TWOActivityRulesViewController *activityRules = [[TWOActivityRulesViewController alloc] init];
    pushVC(activityRules);
}

//中奖纪录按钮
- (void)winAPrizeButtonClicked:(UIButton *)button
{
    butShuZi.hidden = YES;
    TWOWinPrizeRecordViewController *winPrizeRecored = [[TWOWinPrizeRecordViewController alloc] init];
    pushVC(winPrizeRecored);
}

//黑色遮罩层消失
- (void)yaoBlackDisappearButton:(UIButton *)button
{
    [butBlack removeFromSuperview];
    [viewBottom removeFromSuperview];
    butBlack = nil;
    viewBottom = nil;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
//    开始摇动
    NSLog(@"开始摇动");
    
    momAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    改变摇动的幅度
    momAnimation.fromValue = [NSNumber numberWithFloat:-0.5];
    momAnimation.toValue = [NSNumber numberWithFloat:0.5];
//    改变摇动的速度
    momAnimation.duration = 0.5;
//    控制摇摆的时间
    momAnimation.repeatDuration = 1.7;
    momAnimation.autoreverses = YES;
    momAnimation.delegate = self;
    [imageHandYao.layer addAnimation:momAnimation forKey:@"animateLayer"];
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
//    取消摇动
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
//    摇动结束
    if (motion != UIEventSubtypeMotionShake) {
        NSLog(@"其他事件");
    } else {
        NSLog(@"摇一摇结束");
        [self tanKuangeShow];
    }
}

//分享按钮
- (void)buttonShareYaoYiYao:(UIButton *)button
{
    NSLog(@"share");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    butShare.hidden = YES;
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
