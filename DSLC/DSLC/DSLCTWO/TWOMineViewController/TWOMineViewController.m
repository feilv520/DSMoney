//
//  TWOMineViewController.m
//  DSLC
//
//  Created by ios on 16/5/5.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOMineViewController.h"
#import "define.h"
#import "TWOMineCell.h"
#import "TWOAddIncomeViewController.h"
#import "TWOMyMoneyViewController.h"
#import "TWOMyTidyMoneyViewController.h"
#import "TWOMyPrerogativeMoneyViewController.h"
#import "TWOMessageCenterViewController.h"

@interface TWOMineViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

{
    UITableView *_tableView;
    NSArray *titleArray;
    NSArray *imageArray;
    NSArray *contentArr;
    UIImageView *imageBackGround;
    CGFloat height;
    UIButton *butWenZi;
}

@end

@implementation TWOMineViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self tabelViewShow];
}

- (void)tabelViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 53) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 330.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    _tableView.tableHeaderView.backgroundColor = [UIColor whiteColor];
    [self tableViewHeadShow];
                                                                          
    [_tableView registerNib:[UINib nibWithNibName:@"TWOMineCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    titleArray = @[@[@"我的理财", @"我的特权本金"], @[@"红包卡券", @"我的猴币", @"我的邀请"]];
    imageArray = @[@[@"我的理财", @"tequanbenjin"], @[@"红包卡券", @"我的猴币", @"myInvite"]];
    contentArr = @[@[@"13600元在投", @"300000元"], @[@"2张", @"3000.00猴币", @"邀请好友送星巴克券"]];
}

//tableView头部
- (void)tableViewHeadShow
{
    imageBackGround = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, _tableView.tableHeaderView.frame.size.height) backGroundColor:[UIColor greenColor] setImage:[UIImage imageNamed:@"我的背景图"]];
    [_tableView.tableHeaderView addSubview:imageBackGround];
    imageBackGround.userInteractionEnabled = YES;
    height = imageBackGround.frame.size.height;
//    让子类自动布局
    imageBackGround.autoresizesSubviews = YES;
    
//    信封按钮
    UIButton *buttEmail = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(14, 30, 23, 23) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [imageBackGround addSubview:buttEmail];
    [buttEmail setBackgroundImage:[UIImage imageNamed:@"email"] forState:UIControlStateNormal];
    [buttEmail setBackgroundImage:[UIImage imageNamed:@"email"] forState:UIControlStateHighlighted];
    buttEmail.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [buttEmail addTarget:self action:@selector(buttonEmailClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    设置按钮
    UIButton *buttonSet = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 23 - 14, 30, 23, 23) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [_tableView.tableHeaderView addSubview:buttonSet];
    [buttonSet setBackgroundImage:[UIImage imageNamed:@"myset"] forState:UIControlStateNormal];
    [buttonSet setBackgroundImage:[UIImage imageNamed:@"myset"] forState:UIControlStateHighlighted];
    buttonSet.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [buttonSet addTarget:self action:@selector(buttonSetClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    任务中心
    UIView *viewAlpha = [CreatView creatViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 71, buttonSet.frame.size.height + 23 + 18.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 71 + 20, 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor colorWithRed:33.0 / 225.0 green:125.0 / 225.0 blue:226.0 / 225.0 alpha:1.0]];
    [imageBackGround addSubview:viewAlpha];
    viewAlpha.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    viewAlpha.layer.cornerRadius = 15;
    viewAlpha.layer.masksToBounds = YES;
    
    UIButton *butTask = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(71/2 - 16, 0, 30, 30) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [viewAlpha addSubview:butTask];
    [butTask setBackgroundImage:[UIImage imageNamed:@"renwuzhongxinicon"] forState:UIControlStateNormal];
    [butTask setBackgroundImage:[UIImage imageNamed:@"renwuzhongxinicon"] forState:UIControlStateHighlighted];
    
    UIButton *butTastWen = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 30, 71, 12) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"任务中心"];
    [viewAlpha addSubview:butTastWen];
    butTastWen.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    
//    任务中心数字显示
    UILabel *labelTestShu = [CreatView creatWithLabelFrame:CGRectMake(butTask.frame.size.width - 3, 3, 13, 13) backgroundColor:[UIColor orangeColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:9] text:@"38"];
    [butTask addSubview:labelTestShu];
    labelTestShu.layer.cornerRadius = 13 / 2;
    labelTestShu.layer.masksToBounds = YES;
    
//    充值提现上面的横线
    UIView *viewLineH = [CreatView creatViewWithFrame:CGRectMake(0, imageBackGround.frame.size.height - 50.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor whiteColor]];
    [imageBackGround addSubview:viewLineH];
    viewLineH.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
//    充值按钮
    UIButton *butFullMoney = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, imageBackGround.frame.size.height - 49.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT/2, 49.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"充值"];
    [imageBackGround addSubview:butFullMoney];
    butFullMoney.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:16];
    [butFullMoney setImage:[UIImage imageNamed:@"充值"] forState:UIControlStateNormal];
    butFullMoney.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [butFullMoney addTarget:self action:@selector(buttonFullMoney:) forControlEvents:UIControlEventTouchUpInside];
    
//    充值与提现之间的竖线
    UIView *viewLineS = [CreatView creatViewWithFrame:CGRectMake(butFullMoney.frame.size.width - 0.5, 0, 0.5, butFullMoney.frame.size.height) backgroundColor:[UIColor whiteColor]];
    [butFullMoney addSubview:viewLineS];
    
//    提现按钮
    UIButton *butFillMoney = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(butFullMoney.frame.size.width, imageBackGround.frame.size.height - 49.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT/2, butFullMoney.frame.size.height) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"提现"];
    [imageBackGround addSubview:butFillMoney];
    butFillMoney.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:16];
    [butFillMoney setImage:[UIImage imageNamed:@"提现"] forState:UIControlStateNormal];
    butFillMoney.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [butFillMoney addTarget:self action:@selector(buttonFillMoney:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *butHeadImage = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(150.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 45.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT - ((150.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT) * 2), WIDTH_CONTROLLER_DEFAULT - ((150.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT) * 2)) backgroundColor:[UIColor greenColor] textColor:nil titleText:nil];
    [imageBackGround addSubview:butHeadImage];
    [butHeadImage setBackgroundImage:[UIImage imageNamed:@"我的头像"] forState:UIControlStateNormal];
    [butHeadImage setBackgroundImage:[UIImage imageNamed:@"我的头像"] forState:UIControlStateHighlighted];
    butHeadImage.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    butHeadImage.layer.cornerRadius = (WIDTH_CONTROLLER_DEFAULT - ((150.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT) * 2))/2;
    butHeadImage.layer.masksToBounds = YES;
    [butHeadImage addTarget:self action:@selector(buttonChangeHeadImage:) forControlEvents:UIControlEventTouchUpInside];
    
//    总资产底层view
    UIView *viewMoney = [CreatView creatViewWithFrame:CGRectMake(0, 142.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 30.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor clearColor]];
    [imageBackGround addSubview:viewMoney];
    viewMoney.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
//    总资产钱数
    UILabel *labelMoney = [[UILabel alloc] init];
    labelMoney.backgroundColor = [UIColor clearColor];
    labelMoney.textAlignment = NSTextAlignmentRight;
    [viewMoney addSubview:labelMoney];
    labelMoney.textColor = [UIColor whiteColor];
    
    NSMutableAttributedString *moneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", @"2,273,457.00"]];
    NSRange leftRange = NSMakeRange(0, [[moneyString string] rangeOfString:@"元"].location);
    [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:28] range:leftRange];
    NSRange rightRange = NSMakeRange([[moneyString string] length] - 1, 1);
    [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:12] range:rightRange];
    [labelMoney setAttributedText:moneyString];
    
    CGRect moneyWidth = [labelMoney.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT, viewMoney.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:28]} context:nil];
    labelMoney.frame = CGRectMake((WIDTH_CONTROLLER_DEFAULT - moneyWidth.size.width) * 0.5, 0, moneyWidth.size.width, viewMoney.frame.size.height);
    
//    睁眼闭眼按钮
    UIButton *buttonEye = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - moneyWidth.size.width) * 0.5 + moneyWidth.size.width, viewMoney.frame.size.height - 15, 20, 20) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [viewMoney addSubview:buttonEye];
    [buttonEye setBackgroundImage:[UIImage imageNamed:@"openEye"] forState:UIControlStateNormal];
    [buttonEye setBackgroundImage:[UIImage imageNamed:@"openEye"] forState:UIControlStateHighlighted];
    
//    总资产按钮
    UIButton *buttonZZC = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 25, 142.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + viewMoney.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 50, 14) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"总资产"];
    [imageBackGround addSubview:buttonZZC];
    buttonZZC.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    buttonZZC.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [buttonZZC addTarget:self action:@selector(checkMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
    
//    总资产右下角黄色三角按钮
    UIButton *butYellowJiao = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 25 + 52, 142.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + viewMoney.frame.size.height + 15.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 12, 12) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [imageBackGround addSubview:butYellowJiao];
    butYellowJiao.tag = 665;
    [butYellowJiao setBackgroundImage:[UIImage imageNamed:@"yellowSanJiao"] forState:UIControlStateNormal];
    [butYellowJiao setBackgroundImage:[UIImage imageNamed:@"yellowSanJiao"] forState:UIControlStateHighlighted];
    butYellowJiao.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [butYellowJiao addTarget:self action:@selector(checkMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
    
//    可用余额钱数
    UIButton *butMoneyYu = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 142.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + viewMoney.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 14 + 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT/2, 16) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:nil];
    [imageBackGround addSubview:butMoneyYu];
    butMoneyYu.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    butMoneyYu.tag = 666;
    
    NSMutableAttributedString *butMoneyStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", @"230,373.41"]];
    NSRange shuRange = NSMakeRange(0, [[butMoneyStr string] rangeOfString:@"元"].location);
    [butMoneyStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:16] range:shuRange];
    [butMoneyStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:shuRange];
    NSRange yuanRange = NSMakeRange([[butMoneyStr string] length] - 1, 1);
    [butMoneyStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:yuanRange];
    [butMoneyStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:yuanRange];
    [butMoneyYu setAttributedTitle:butMoneyStr forState:UIControlStateNormal];
    [butMoneyYu addTarget:self action:@selector(checkMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
    
//    累计收益钱数
    UIButton *butAddMoney = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2, 142.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + viewMoney.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 14 + 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT/2, 16) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [imageBackGround addSubview:butAddMoney];
    butAddMoney.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    butAddMoney.tag = 667;
    
    NSMutableAttributedString *butAddStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", @"119,324.56"]];
    NSRange frontRange = NSMakeRange(0, [[butAddStr string] rangeOfString:@"元"].location);
    [butAddStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:16] range:frontRange];
    [butAddStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:frontRange];
    NSRange afterRange = NSMakeRange([[butAddStr string] length] - 1, 1);
    [butAddStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:afterRange];
    [butAddStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:afterRange];
    [butAddMoney setAttributedTitle:butAddStr forState:UIControlStateNormal];
    [butAddMoney addTarget:self action:@selector(checkMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
    
//    可用剩余&累计收益 文字
    NSArray *titArray = @[@"可用余额", @"累计收益"];
    for (int i = 0; i < 2; i++) {
        butWenZi = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT / 2 * i, 142.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + viewMoney.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 14 + 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 16 + 8.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT/2, 12) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:[titArray objectAtIndex:i]];
        [imageBackGround addSubview:butWenZi];
        butWenZi.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        butWenZi.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        butWenZi.tag = 666 + i;
        [butWenZi addTarget:self action:@selector(checkMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
//    可用余额三角按钮
    UIButton *butLeftJiao = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(119.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 142.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + viewMoney.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 14 + 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 16 + 8.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 10, 12, 12) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [imageBackGround addSubview:butLeftJiao];
    butLeftJiao.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [butLeftJiao setBackgroundImage:[UIImage imageNamed:@"baisanjiao"] forState:UIControlStateNormal];
    [butLeftJiao setBackgroundImage:[UIImage imageNamed:@"baisanjiao"] forState:UIControlStateHighlighted];
    butLeftJiao.tag = 666;
    [butLeftJiao addTarget:self action:@selector(checkMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
    
//    累计收益三角按钮
    UIButton *butRightJiao = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 + 119.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 142.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + viewMoney.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 14 + 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 16 + 8.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 10, 12, 12) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [imageBackGround addSubview:butRightJiao];
    butRightJiao.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [butRightJiao setBackgroundImage:[UIImage imageNamed:@"baisanjiao"] forState:UIControlStateNormal];
    [butRightJiao setBackgroundImage:[UIImage imageNamed:@"baisanjiao"] forState:UIControlStateHighlighted];
    butRightJiao.tag = 667;
    [butRightJiao addTarget:self action:@selector(checkMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    } else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOMineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.imagePic.image = [UIImage imageNamed:[[imageArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    cell.imageRight.image = [UIImage imageNamed:@"clickRightjiantou"];
    
    cell.labelName.text = [[titleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.labelName.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    cell.labelName.textColor = [UIColor ZiTiColor];
    
    cell.labelContent.text = [[contentArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.labelContent.textColor = [UIColor zitihui];
    cell.labelContent.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    
//    if (indexPath.section == 0) {
//        if (indexPath.row == 1) {
//            cell.imageRedDian.image = [UIImage imageNamed:@"Reddian"];
//        }
//    } else {
//        if (indexPath.row == 1) {
//            cell.imageRedDian.image = [UIImage imageNamed:@"Reddian"];
//        }
//    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 53.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            TWOMyTidyMoneyViewController *tidyMoneyVC = [[TWOMyTidyMoneyViewController alloc] init];
            [self.navigationController pushViewController:tidyMoneyVC animated:YES];
            
        } else {
            TWOMyPrerogativeMoneyViewController *myPrerogativeMoneyVC = [[TWOMyPrerogativeMoneyViewController alloc] init];
            [self.navigationController pushViewController:myPrerogativeMoneyVC animated:YES];
        }
    }
}

//充值按钮
- (void)buttonFullMoney:(UIButton *)button
{
    NSLog(@"chong");
}

//提现按钮
- (void)buttonFillMoney:(UIButton *)button
{
    NSLog(@"tixian");
}

//点击头像按钮
- (void)buttonChangeHeadImage:(UIButton *)button
{
    NSLog(@"dainjitouxiang");
}

//信封按钮
- (void)buttonEmailClicked:(UIButton *)button
{
    TWOMessageCenterViewController *messageCenterVC = [[TWOMessageCenterViewController alloc] init];
    pushVC(messageCenterVC);
}

//设置按钮
- (void)buttonSetClicked:(UIButton *)button
{
    NSLog(@"set");
}

//总资产&可用余额&累计收益查看
- (void)checkMoneyButton:(UIButton *)button
{
    if (button.tag == 665) {
        
        TWOMyMoneyViewController *myMoneyVC = [[TWOMyMoneyViewController alloc] init];
        [self.navigationController pushViewController:myMoneyVC animated:YES];
        
    } else if (button.tag == 666) {
        NSLog(@"可用余额");
    } else {
        
        TWOAddIncomeViewController *addIncomeVC = [[TWOAddIncomeViewController alloc] init];
        [self.navigationController pushViewController:addIncomeVC animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offSet = scrollView.contentOffset.y;
    
    if (offSet < 0) {
        
        imageBackGround.contentMode = UIViewContentModeScaleAspectFill;
        CGRect frame = imageBackGround.frame;
        frame.origin.y = offSet;
        frame.size.height = height - offSet;
        imageBackGround.frame = frame;
    }
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
