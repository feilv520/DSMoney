//
//  TWOProductSafeTestViewController.m
//  DSLC
//
//  Created by ios on 16/5/24.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOProductSafeTestViewController.h"
#import "TWOBeginTestViewController.h"

@interface TWOProductSafeTestViewController ()

{
    UIView *viewWhite;
    UIView *viewProduct;
    CGFloat viewProductW;
    CGFloat viewProductH;
    UILabel *labelTitle;
    UIView *viewXing;
    UIImageView *imageXing;
    NSArray *xingArray;
    
    UIView *viewUser;
    UILabel *labelUserTitle;
    UIView *viewUserXing;
    UIImageView *imageUserXing;
    NSArray *userXingArray;
}

@end

@implementation TWOProductSafeTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor qianhuise];
    [self.navigationItem setTitle:@"产品安全等级"];
    
    if (self.alreadyTest == YES) {
        //    调用已经测试的视图
        [self alreadyTestContentShow];
        [self navigationShow];
    } else {
        //    调用未测试的视图
        [self noTestContentShow];
    }
}

- (void)navigationShow
{
    self.imageReturn = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, 20, 20) backGroundColor:nil setImage:[UIImage imageNamed:@"750产品111"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.imageReturn];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(againReturnBack:)];
    [self.imageReturn addGestureRecognizer:tap];
}

//未测试的视图
- (void)noTestContentShow
{
    viewWhite = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 213.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewWhite];
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        viewWhite.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 233.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20));
    }
    
    UIView *viewLineDown = [CreatView creatViewWithFrame:CGRectMake(10, viewWhite.frame.size.height - 0.5, WIDTH_CONTROLLER_DEFAULT - 20, 0.5) backgroundColor:[UIColor grayColor]];
    [viewWhite addSubview:viewLineDown];
    viewLineDown.alpha = 0.3;
    
    UIView *viewMiddle = [CreatView creatViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2, 0, 0.5, viewWhite.frame.size.height) backgroundColor:[UIColor grayColor]];
    [viewWhite addSubview:viewMiddle];
    viewMiddle.alpha = 0.3;
    
    UIView *viewDown = [CreatView creatViewWithFrame:CGRectMake(0, viewWhite.frame.size.height, WIDTH_CONTROLLER_DEFAULT, 51.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewDown];
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        viewDown.frame = CGRectMake(0, viewWhite.frame.size.height, WIDTH_CONTROLLER_DEFAULT, 60.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20));
    }
    
    UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(10, 0, WIDTH_CONTROLLER_DEFAULT - 20, viewDown.frame.size.height) backgroundColor:[UIColor whiteColor] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"您还没有参加过安全测评,快去测测您的投资倾向吧!"];
    [viewDown addSubview:labelAlert];
    labelAlert.numberOfLines = 0;
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, viewWhite.frame.size.height + labelAlert.frame.size.height, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [self.view addSubview:viewLine];
    viewLine.alpha = 0.3;
    
    [self productContent];
    
//    未测试按钮
    UIButton *butBottom = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 + 34.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 28.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT/2 - 2*(34.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT), WIDTH_CONTROLLER_DEFAULT/2 - 2*(34.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT)) backgroundColor:[UIColor whiteColor] textColor:nil titleText:nil];
    [viewWhite addSubview:butBottom];
    butBottom.layer.cornerRadius = (WIDTH_CONTROLLER_DEFAULT/2 - (34.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT)*2)/2;
    butBottom.layer.masksToBounds = YES;
    butBottom.layer.borderColor = [[UIColor quanColor] CGColor];
    butBottom.layer.borderWidth = 2;
    butBottom.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [butBottom addTarget:self action:@selector(buttonGoToTest:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonUp = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, butBottom.frame.size.height/2 - 20, butBottom.frame.size.width, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor findZiTiColor] titleText:@"您还未测试"];
    [butBottom addSubview:buttonUp];
    buttonUp.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonUp addTarget:self action:@selector(buttonGoToTest:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonDown = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, butBottom.frame.size.height/2 + 5, butBottom.frame.size.width, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor orangecolor] titleText:@"去测试>"];
    [butBottom addSubview:buttonDown];
    buttonDown.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonDown addTarget:self action:@selector(buttonGoToTest:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *labelQingX = [CreatView creatWithLabelFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 + 5, 28.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + butBottom.frame.size.height + 20.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT/2 - 10, 20) backgroundColor:[UIColor whiteColor] textColor:[UIColor ZiTiColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"您的投资倾向"];
    [viewWhite addSubview:labelQingX];
}

//已经测试的视图
- (void)alreadyTestContentShow
{
    viewWhite = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 214.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewWhite];
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        viewWhite.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 234.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20));
    }
    
    UIView *viewMiddle = [CreatView creatViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2, 0, 0.5, viewWhite.frame.size.height) backgroundColor:[UIColor grayColor]];
    [viewWhite addSubview:viewMiddle];
    viewMiddle.alpha = 0.3;
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(10, viewWhite.frame.size.height - 0.5, WIDTH_CONTROLLER_DEFAULT - 20, 0.5) backgroundColor:[UIColor grayColor]];
    [viewWhite addSubview:viewLine];
    viewLine.alpha = 0.3;
    
//    放提示的视图view
    UIView *viewAlert = [CreatView creatViewWithFrame:CGRectMake(0, viewWhite.frame.size.height, WIDTH_CONTROLLER_DEFAULT, 101.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewAlert];
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        viewAlert.frame = CGRectMake(0, viewWhite.frame.size.height, WIDTH_CONTROLLER_DEFAULT, 131.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20));
    }
    
    UILabel *labelResult = [CreatView creatWithLabelFrame:CGRectMake(10, 19.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT - 20, 16) backgroundColor:[UIColor clearColor] textColor:[UIColor ZiTiColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"匹配结果:"];
    [viewAlert addSubview:labelResult];
    
    UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(10, 19.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 16 + 10.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT - 20, viewAlert.frame.size.height - (19.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 16 + 10.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) - 10) backgroundColor:[UIColor clearColor] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"您的投资倾向与本产品安全等级相吻合,可以购买此款产品"];
    [viewAlert addSubview:labelAlert];
    labelAlert.numberOfLines = 0;
    
    UIView *viewLineDown = [CreatView creatViewWithFrame:CGRectMake(0, viewAlert.frame.size.height - 0.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [viewAlert addSubview:viewLineDown];
    viewLineDown.alpha = 0.3;
    
//    调用产品等级的视图
    [self productContent];
    
//    用户投资倾向的测试视图
    viewUser = [CreatView creatViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 + 34.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 28.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT/2 - 2*(34.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT), WIDTH_CONTROLLER_DEFAULT/2 - 2*(34.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT)) backgroundColor:[UIColor whiteColor]];
    [viewWhite addSubview:viewUser];
    viewUser.layer.cornerRadius = (WIDTH_CONTROLLER_DEFAULT/2 - (34.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT)*2)/2;
    viewUser.layer.masksToBounds = YES;
    viewUser.layer.borderColor = [[UIColor profitColor] CGColor];
    viewUser.layer.borderWidth = 2;
    
//    用户测试的类型显示
    labelUserTitle = [CreatView creatWithLabelFrame:CGRectMake(0, viewUser.frame.size.height/2 - 20, viewUser.frame.size.width, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor profitColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:nil];
    [viewUser addSubview:labelUserTitle];
    
//    放星星的view
    viewUserXing = [CreatView creatViewWithFrame:CGRectMake(viewUser.frame.size.width/2 - 41, viewUser.frame.size.height/2 + 5, 82, 14) backgroundColor:[UIColor clearColor]];
    [viewUser addSubview:viewUserXing];
    
//    需要判断用户测评属于什么类型 调用不同的方法******************
    if (self.score < 9 || self.score == 9) {
        [self userOneXing];
    } else if (self.score >= 10 && self.score <= 17) {
        [self userTwoXing];
    } else if (self.score >= 18 && self.score <= 30) {
        [self userThreeXing];
    } else if (self.score >= 31 && self.score <= 43) {
        [self userFourXing];
    } else {
        [self userFiveXing];
    }
    
    UILabel *labelQingX = [CreatView creatWithLabelFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 + 5, 28.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + viewProduct.frame.size.height + 20.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT/2 - 10, 20) backgroundColor:[UIColor whiteColor] textColor:[UIColor ZiTiColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"您的投资倾向"];
    [viewWhite addSubview:labelQingX];
    
//    重新测试按钮
    UIButton *butTestAgain = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 70 - 10, viewWhite.frame.size.height + 10 + viewAlert.frame.size.height, 70, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor orangecolor] titleText:@"重新测试>"];
    [self.view addSubview:butTestAgain];
    butTestAgain.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [butTestAgain addTarget:self action:@selector(againTestButton:) forControlEvents:UIControlEventTouchUpInside];
}

//产品等级显示
- (void)productContent
{
//    产品等级显示的视图
    viewProduct = [CreatView creatViewWithFrame:CGRectMake(34.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 28.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT/2 - 2*(34.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT), WIDTH_CONTROLLER_DEFAULT/2 - 2*(34.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT)) backgroundColor:[UIColor whiteColor]];
    [viewWhite addSubview:viewProduct];
    viewProduct.layer.cornerRadius = (WIDTH_CONTROLLER_DEFAULT/2 - (34.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT)*2)/2;
    viewProduct.layer.masksToBounds = YES;
    viewProduct.layer.borderColor = [[UIColor profitColor] CGColor];
    viewProduct.layer.borderWidth = 2;
    
//    viewProduct的宽度
    viewProductW = viewProduct.frame.size.width;
//    viewProduct的高度
    viewProductH = viewProduct.frame.size.height;
    
    labelTitle = [CreatView creatWithLabelFrame:CGRectMake(0, viewProductH/2 - 20, viewProductW, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor profitColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:nil];
    [viewProduct addSubview:labelTitle];
    
//    放星星的view
    viewXing = [CreatView creatViewWithFrame:CGRectMake(viewProductW/2 - 41, viewProductH/2 + 5, 82, 14) backgroundColor:[UIColor whiteColor]];
    [viewProduct addSubview:viewXing];
    
//    需要判断产品属于什么安全等级类型 调用不同的方法^^^^^^^^^^^^^^^^
    [self oneXing];
    
    UILabel *labelProQingX = [CreatView creatWithLabelFrame:CGRectMake(5, 28.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + viewProduct.frame.size.height + 20.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT/2 - 10, 20) backgroundColor:[UIColor whiteColor] textColor:[UIColor ZiTiColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"产品安全等级"];
    [viewWhite addSubview:labelProQingX];
}

//谨慎型
- (void)fiveXing
{
    labelTitle.text = @"谨慎型";
    
    xingArray = @[@"xing", @"xing", @"xing", @"xing", @"xing"];
    for (int u = 0; u < 5; u++) {
        imageXing = [CreatView creatImageViewWithFrame:CGRectMake(3 * u + 14 * u, 0, 14, 14) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:[xingArray objectAtIndex:u]]];
        [viewXing addSubview:imageXing];
    }
}

//稳健型
- (void)fourXing
{
    labelTitle.text = @"稳健型";
    
    xingArray = @[@"xing", @"xing", @"xing", @"xing", @"xingkong"];
    for (int u = 0; u < 5; u++) {
        imageXing = [CreatView creatImageViewWithFrame:CGRectMake(3 * u + 14 * u, 0, 14, 14) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:[xingArray objectAtIndex:u]]];
        [viewXing addSubview:imageXing];
    }
}

//平衡型
- (void)threeXing
{
    labelTitle.text = @"平衡型";
    
    xingArray = @[@"xing", @"xing", @"xing", @"xingkong", @"xingkong"];
    for (int u = 0; u < 5; u++) {
        imageXing = [CreatView creatImageViewWithFrame:CGRectMake(3 * u + 14 * u, 0, 14, 14) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:[xingArray objectAtIndex:u]]];
        [viewXing addSubview:imageXing];
    }
}

//进取型
- (void)twoXing
{
    labelTitle.text = @"进取型";
    
    xingArray = @[@"xing", @"xing", @"xingkong", @"xingkong", @"xingkong"];
    for (int u = 0; u < 5; u++) {
        imageXing = [CreatView creatImageViewWithFrame:CGRectMake(3 * u + 14 * u, 0, 14, 14) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:[xingArray objectAtIndex:u]]];
        [viewXing addSubview:imageXing];
    }
}

//激进型
- (void)oneXing
{
    labelTitle.text = @"激进型";
    
    xingArray = @[@"xing", @"xingkong", @"xingkong", @"xingkong", @"xingkong"];
    for (int u = 0; u < 5; u++) {
        imageXing = [CreatView creatImageViewWithFrame:CGRectMake(3 * u + 14 * u, 0, 14, 14) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:[xingArray objectAtIndex:u]]];
        [viewXing addSubview:imageXing];
    }
}

//进取型
- (void)userFiveXing
{
    labelUserTitle.text = @"进取型";
    
    userXingArray = @[@"xing", @"xing", @"xing", @"xing", @"xing"];
    for (int w = 0; w < 5; w++) {
        imageUserXing = [CreatView creatImageViewWithFrame:CGRectMake(3 * w + 14 * w, 0, 14, 14) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:[userXingArray objectAtIndex:w]]];
        [viewUserXing addSubview:imageUserXing];
    }
}

//成长型
- (void)userFourXing
{
    labelUserTitle.text = @"成长型";
    
    userXingArray = @[@"xing", @"xing", @"xing", @"xing", @"xingkong"];
    for (int w = 0; w < 5; w++) {
        imageUserXing = [CreatView creatImageViewWithFrame:CGRectMake(3 * w + 14 * w, 0, 14, 14) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:[userXingArray objectAtIndex:w]]];
        [viewUserXing addSubview:imageUserXing];
    }
}

//平衡型
- (void)userThreeXing
{
    labelUserTitle.text = @"平衡型";
    
    userXingArray = @[@"xing", @"xing", @"xing", @"xingkong", @"xingkong"];
    for (int w = 0; w < 5; w++) {
        imageUserXing = [CreatView creatImageViewWithFrame:CGRectMake(3 * w + 14 * w, 0, 14, 14) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:[userXingArray objectAtIndex:w]]];
        [viewUserXing addSubview:imageUserXing];
    }
}

//稳健型
- (void)userTwoXing
{
    labelUserTitle.text = @"稳健型";
    
    userXingArray = @[@"xing", @"xing", @"xingkong", @"xingkong", @"xingkong"];
    for (int w = 0; w < 5; w++) {
        imageUserXing = [CreatView creatImageViewWithFrame:CGRectMake(3 * w + 14 * w, 0, 14, 14) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:[userXingArray objectAtIndex:w]]];
        [viewUserXing addSubview:imageUserXing];
    }
}

//保守型
- (void)userOneXing
{
    labelUserTitle.text = @"保守型";
    
    userXingArray = @[@"xing", @"xingkong", @"xingkong", @"xingkong", @"xingkong"];
    for (int w = 0; w < 5; w++) {
        imageUserXing = [CreatView creatImageViewWithFrame:CGRectMake(3 * w + 14 * w, 0, 14, 14) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:[userXingArray objectAtIndex:w]]];
        [viewUserXing addSubview:imageUserXing];
    }
}

//还未测试去测试按钮方法
- (void)buttonGoToTest:(UIButton *)button
{
    TWOBeginTestViewController *beginTestVC = [[TWOBeginTestViewController alloc] init];
    pushVC(beginTestVC);
}

//重新测试按钮
- (void)againTestButton:(UIButton *)button
{
    TWOBeginTestViewController *beginTestVC = [[TWOBeginTestViewController alloc] init];
    pushVC(beginTestVC);
}

- (void)againReturnBack:(UITapGestureRecognizer *)tap
{
    NSArray *viewControllers = [self.navigationController viewControllers];
    [self.navigationController popToViewController:[viewControllers objectAtIndex:1] animated:YES];
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
