//
//  MineViewController.m
//  DSLC
//
//  Created by ios on 15/10/8.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MineViewController.h"
#import "define.h"
#import "MineCell.h"
#import "UIColor+AddColor.h"
#import "CreatView.h"
#import "MiddleView.h"
#import "MyInformationViewController.h"
#import "MyRedBagViewController.h"
#import "ProductSettingViewController.h"
#import "MyNewsViewController.h"
#import "MyInvitationViewController.h"
#import "PayMoneyViewController.h"

@interface MineViewController () <UITableViewDataSource, UITableViewDelegate>

{
    NSArray *titleArr;
    NSArray *pictureArr;
    UITableView *_tableView;
    UIView *viewHead;
    MiddleView *middleView;
}

@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self showPictureAndTitle];
    [self showTableView];
}

- (void)showPictureAndTitle
{
    titleArr = @[@"账户资产", @"我的资料", @"红包活动", @"好友邀请", @"交易记录", @"消息中心"];
    pictureArr = @[@"zhanghu", @"ziliao", @"hongbao", @"haoyou", @"jiaoyi", @"xiaoxi"];
}

- (void)showTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 52) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    
    viewHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT * (291.0 / 667.0))];
    _tableView.tableHeaderView = viewHead;
    viewHead.backgroundColor = [UIColor huibai];
    [self viewHeadContent];
    
    UIView *viewFoot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT * (47.0 / 667.0))];
    _tableView.tableFooterView = viewFoot;
    viewFoot.backgroundColor = [UIColor huibai];
    
    UIImageView *imageSafe = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * (87.5 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (15.0 / 667.0), WIDTH_CONTROLLER_DEFAULT * (18.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (18.0 / 667.0)) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"iocn_saft"]];
    [viewFoot addSubview:imageSafe];
    
    UILabel *lableSafe = [CreatView creatWithLabelFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * (105.5 / 375), HEIGHT_CONTROLLER_DEFAULT * (15.0 / 667.0), WIDTH_CONTROLLER_DEFAULT * (180.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (18.0/ 667.0)) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont systemFontOfSize:12] text:@"由中国银行保障您的账户资金安全"];
    [viewFoot addSubview:lableSafe];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MineCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
}

- (void)viewHeadContent
{
    UIImageView *imageRedBG = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT * (156.0 / 667.0)) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"bei"]];
    [viewHead addSubview:imageRedBG];
    imageRedBG.userInteractionEnabled = YES;
    
//    头像按钮
    UIButton *butHeadPic = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(9, 22, 50, 50) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [imageRedBG addSubview:butHeadPic];
    [butHeadPic setBackgroundImage:[UIImage imageNamed:@"shape-29"] forState:UIControlStateNormal];
    butHeadPic.layer.cornerRadius = 25;
    butHeadPic.layer.masksToBounds = YES;
    [butHeadPic addTarget:self action:@selector(headPictureButton:) forControlEvents:UIControlEventTouchUpInside];
    
//    邀请按钮
    UIButton *butInvitate = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 85, 31, 75, 25) backgroundColor:nil textColor:[UIColor whiteColor] titleText:@"我的理财师"];
    [imageRedBG addSubview:butInvitate];
    [butInvitate setBackgroundImage:[UIImage imageNamed:@"anniu"] forState:UIControlStateNormal];
    butInvitate.titleLabel.font = [UIFont systemFontOfSize:13];
    [butInvitate addTarget:self action:@selector(inviteButton:) forControlEvents:UIControlEventTouchUpInside];
    
//    昨日收益钱数
    UILabel *labelNum = [CreatView creatWithLabelFrame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - 200)/2, HEIGHT_CONTROLLER_DEFAULT * (63.0 / 667.0), WIDTH_CONTROLLER_DEFAULT * (200.0 / 375.0), 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [imageRedBG addSubview:labelNum];
    
    NSMutableAttributedString *redStringM = [[NSMutableAttributedString alloc] initWithString:@"13.17元"];
    NSRange numString = NSMakeRange(0, [[redStringM string] rangeOfString:@"元"].location);
    [redStringM addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:35] range:numString];
    NSRange oneString = NSMakeRange([[redStringM string] length] - 1, 1);
    [redStringM addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:15] range:oneString];
    [labelNum setAttributedText:redStringM];
    
//    昨日收益文字
    UILabel *labelZi = [CreatView creatWithLabelFrame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - 70)/2, HEIGHT_CONTROLLER_DEFAULT * (110.0 / 667.0), WIDTH_CONTROLLER_DEFAULT * (70.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (15.0 / 667.0)) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"昨日收益"];
    [imageRedBG addSubview:labelZi];
    
//    中间部分xib
    NSBundle *root = [NSBundle mainBundle];
    middleView = (MiddleView *)[[root loadNibNamed:@"MiddleView" owner:nil options:nil] lastObject];
    
    [viewHead addSubview:middleView];
    middleView.frame = CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT * (156.0 / 667.0), WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT * (135.0 / 667.0));
    middleView.backgroundColor = [UIColor whiteColor];
    
    middleView.viewLine.backgroundColor = [UIColor grayColor];
    middleView.viewLine.alpha = 0.3;
    
    NSMutableAttributedString *redString = [[NSMutableAttributedString alloc] initWithString:@"13,234.56元"];
    NSRange redShuZi = NSMakeRange(0, [[redString string] rangeOfString:@"元"].location);
    [redString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:23] range:redShuZi];
    
    NSRange YUANString = NSMakeRange([[redString string] length] - 1, 1);
    [redString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:12] range:YUANString];
    [middleView.labelYuan setAttributedText:redString];
    middleView.labelYuan.textColor = [UIColor daohanglan];
    middleView.labelYuan.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *wanYuanStr = [[NSMutableAttributedString alloc] initWithString:@"23.05万元"];
    NSRange shuziStr = NSMakeRange(0, [[wanYuanStr string] rangeOfString:@"万"].location);
    [wanYuanStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:23] range:shuziStr];
    NSRange wanZiStr = NSMakeRange([[wanYuanStr string] length] - 2, 2);
    [wanYuanStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:12] range:wanZiStr];
    [middleView.labelWanYuan setAttributedText:wanYuanStr];
    middleView.labelWanYuan.textAlignment = NSTextAlignmentCenter;
    
    middleView.labelMyMoney.text = @"我的资产";
    middleView.labelMyMoney.textColor = [UIColor zitihui];
    middleView.labelMyMoney.textAlignment = NSTextAlignmentCenter;
    middleView.labelMyMoney.font = [UIFont systemFontOfSize:12];
    
    middleView.labelData.text = @"理财期限";
    middleView.labelData.textColor = [UIColor zitihui];
    middleView.labelData.textAlignment = NSTextAlignmentCenter;
    middleView.labelData.font = [UIFont systemFontOfSize:12];
    
    middleView.viewDiBu.backgroundColor = [UIColor huibai];
        
    middleView.butCashMoney.backgroundColor = [UIColor colorWithRed:221.0 / 255.0 green:75.0 / 255.0 blue:72.0 / 255.0 alpha:1.0];
    middleView.butWithdrawal.backgroundColor = [UIColor colorWithRed:41.0 / 255.0 green:168.0 / 255.0 blue:244.0 / 255.0 alpha:1.0];
    middleView.butBigMoney.backgroundColor = [UIColor colorWithRed:138.0 / 255.0 green:206.0 / 255.0 blue:154.0 / 255.0 alpha:1.0];
    
//    middleView.butCashMoney.frame.size.width = (WIDTH_CONTROLLER_DEFAULT - 36)/3;
    
    [middleView.butCashMoney addTarget:self action:@selector(rechargeMoney:) forControlEvents:UIControlEventTouchUpInside];
    [middleView.butWithdrawal addTarget:self action:@selector(withdrawMoney:) forControlEvents:UIControlEventTouchUpInside];
    [middleView.butBigMoney addTarget:self action:@selector(bigMoneyRecharge:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT_CONTROLLER_DEFAULT * (50.0 / 667.0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.imageViewPic.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [pictureArr objectAtIndex:indexPath.row]]];
    
    cell.labelTitle.text = [titleArr objectAtIndex:indexPath.row];
    cell.labelTitle.textColor = [UIColor zitihui];
    cell.labelTitle.font = [UIFont systemFontOfSize:15];
    
    cell.imageRight.image = [UIImage imageNamed:@"arrow"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        
        MyInformationViewController *myInformationVC = [[MyInformationViewController alloc] init];
        [self.navigationController pushViewController:myInformationVC animated:YES];
        
    } else if (indexPath.row == 2) {
        
        MyRedBagViewController *myRedBagVC = [[MyRedBagViewController alloc] init];
        [self.navigationController pushViewController:myRedBagVC animated:YES];
        
    } else if (indexPath.row == 0) {
        
        ProductSettingViewController *pSettringVC = [[ProductSettingViewController alloc] init];
        [self.navigationController pushViewController:pSettringVC animated:YES];
        
    } else if (indexPath.row == 5) {
        
        MyNewsViewController *myNewsVC = [[MyNewsViewController alloc] init];
        [self.navigationController pushViewController:myNewsVC animated:YES];
        
    } else if (indexPath.row == 3) {
        
        MyInvitationViewController *myInvitationVC = [[MyInvitationViewController alloc] init];
        [self.navigationController pushViewController:myInvitationVC animated:YES];
        
    }
    
}

//头像按钮
- (void)headPictureButton:(UIButton *)button
{
    NSLog(@"我是头像");
}

//邀请按钮
- (void)inviteButton:(UIButton *)button
{
    NSLog(@"我的理财师");
}

//充值按钮
- (void)rechargeMoney:(UIButton *)button
{
    PayMoneyViewController *payMoneyVC = [[PayMoneyViewController alloc] init];
    [self.navigationController pushViewController:payMoneyVC animated:YES];
}

//提现按钮
- (void)withdrawMoney:(UIButton *)button
{
    NSLog(@"提现");
}

//大额充值
- (void)bigMoneyRecharge:(UIButton *)button
{
    NSLog(@"大额充值");
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
