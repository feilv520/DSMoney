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
#import "TransactionViewController.h"
#import "MyInvitationViewController.h"
#import "PayMoneyViewController.h"
#import "GetMoneyViewController.h"
#import "MyPlannerViewController.h"
#import "BigMoneyViewController.h"
#import "SelectionOfSafe.h"
#import "YesterdayViewController.h"
#import "NewRedBagViewController.h"
#import "LoginViewController.h"
#import "MyChoosePlanner.h"
#import "MyAlreadyBindingBank.h"
#import "RechargeAlreadyBinding.h"
#import "LiftupMoneyViewController.h"
#import "TheThirdRedBagController.h"
#import "EditBigMoney.h"
#import "ApplyScheduleViewController.h"
#import "Planner.h"
#import "RealNameViewController.h"
#import "UserListViewController.h"
#import "MonkeyCell.h"
#import "InviteNewView.h"
#import "NewCastProductViewController.h"
#import "newLoginView.h"

@interface MineViewController () <UITableViewDataSource, UITableViewDelegate, UMSocialUIDelegate>

{
    NSArray *titleArr;
    NSArray *pictureArr;
    UITableView *_tableView;
    UIView *viewHead;
    UIView *viewFoot;
    MiddleView *middleView;
    UILabel *moneyLabel;
    UIButton *myRedBagButton;
    UIButton *messageButton;
    NSMutableArray *plannerArray;
    
    UIButton *butInvitate;
    
    UIView *viewGray;
    
    InviteNewView *inviteNV;
    
    newLoginView *newLView;
}

@property (nonatomic, strong) NSString *imgString;

@property (nonatomic, strong) NSDictionary *myAccountInfo;

@end


@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:NO];
    [app.tabBarVC setLabelLineHidden:NO];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    
    plannerArray = [NSMutableArray array];
    
    [self loadingWithView:self.view loadingFlag:NO height:self.view.center.y];
    
    if ([FileOfManage ExistOfFile:@"Member.plist"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
        if ([dic objectForKey:@"token"] != nil)
            [self MyAccountInfo];
    } 
    [self showPictureAndTitle];
    
    viewGray = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor]];
    viewGray.alpha = 0.3;
    
    [self shareWithView];
    
    viewGray.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exchangeWithImageView) name:@"exchangeWithImageView" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(diandianNonotice:) name:@"dian" object:nil];
    
}

- (void)diandianNonotice:(NSNotification *)notice
{
    [self MyAccountInfo];
}

- (void)pushWithViewController{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:NO];
}

- (void)showPictureAndTitle
{
    titleArr = @[@"我的投资", @"个人信息", @"我的红包", @"账单", @"好友邀请", @"金斗云购买权兑换"];
    pictureArr = @[@"zhanghu", @"ziliao", @"hongbao", @"jiaoyi", @"haoyou", @"haoyou"];
}

- (void)showTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 52) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor huibai];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorColor = [UIColor whiteColor];
    
    _tableView.bounces = NO;
    
    if (HEIGHT_CONTROLLER_DEFAULT == 500 || HEIGHT_CONTROLLER_DEFAULT == 480) {
        viewHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT * (320.0 / 667.0))];
    } else {
        viewHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT * (291.0 / 667.0))];
    }
    _tableView.tableHeaderView = viewHead;
    viewHead.backgroundColor = [UIColor huibai];
    
    viewFoot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 60)];
    _tableView.tableFooterView = viewFoot;
    viewFoot.backgroundColor = [UIColor huibai];
    
//    [self makeSafeView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MineCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [_tableView registerNib:[UINib nibWithNibName:@"MonkeyCell" bundle:nil] forCellReuseIdentifier:@"reuseMonkey"];
}

// 保障
- (void)makeSafeView{
    
    NSBundle *rootBundle = [NSBundle mainBundle];
    
    SelectionOfSafe *selectionSafeView = (SelectionOfSafe *)[[rootBundle loadNibNamed:@"SelectionOfSafe" owner:nil options:nil] lastObject];
    
    CGFloat button_X = WIDTH_CONTROLLER_DEFAULT * (180.0 / 375.0);
    CGFloat margin_left = ((WIDTH_CONTROLLER_DEFAULT - button_X) / 2 / 375.0) * WIDTH_CONTROLLER_DEFAULT;
    
    selectionSafeView.frame = CGRectMake(margin_left, HEIGHT_CONTROLLER_DEFAULT * (10.0 / 667.0), button_X, 17);
    
    [viewFoot addSubview:selectionSafeView];
    
}

- (void)viewHeadContent
{
    UIImageView *imageRedBG = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 156) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"bei"]];
    UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yesterdayButtonAction:)];
    singleRecognizer.numberOfTapsRequired = 1;
    [imageRedBG addGestureRecognizer:singleRecognizer];
    [viewHead addSubview:imageRedBG];
    imageRedBG.userInteractionEnabled = YES;
    
//    头像按钮
    UIButton *butHeadPic = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(15, 22,WIDTH_CONTROLLER_DEFAULT * (40 / 375.0), WIDTH_CONTROLLER_DEFAULT * (40 / 375.0)) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [imageRedBG addSubview:butHeadPic];
    
    if ([self.imgString isEqualToString:@""]) {
        [butHeadPic setBackgroundImage:[UIImage imageNamed:@"默认头像"] forState:UIControlStateNormal];
    } else {
        YYAnimatedImageView *imgView = [YYAnimatedImageView new];
        imgView.tag = 4739;
        imgView.yy_imageURL = [NSURL URLWithString:self.imgString];
        imgView.frame = CGRectMake(0, 0, butHeadPic.frame.size.width, butHeadPic.frame.size.height);
        [butHeadPic addSubview:imgView];
    }
    butHeadPic.layer.cornerRadius = WIDTH_CONTROLLER_DEFAULT * (20 / 375.0);
    butHeadPic.layer.masksToBounds = YES;
    [butHeadPic addTarget:self action:@selector(headPictureButton:) forControlEvents:UIControlEventTouchUpInside];
    
//    消息中心
    butInvitate = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - (85 / 375.0) * WIDTH_CONTROLLER_DEFAULT, 31, (75 / 375.0) * WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT * (25 / 667.0)) backgroundColor:nil textColor:[UIColor whiteColor] titleText:nil];
//    [butInvitate setBackgroundImage:[UIImage imageNamed:@"anniu"] forState:UIControlStateNormal];
    [butInvitate setTitle:@"消息中心" forState:UIControlStateNormal];
    butInvitate.titleLabel.font = [UIFont systemFontOfSize:12];
    butInvitate.tag = 9092;
    [butInvitate addTarget:self action:@selector(inviteButton:) forControlEvents:UIControlEventTouchUpInside];
    [imageRedBG addSubview:butInvitate];
    
    if ([[self.myAccountInfo objectForKey:@"msgCount"] isEqualToString:@"0"]) {
        [butInvitate setBackgroundImage:[UIImage imageNamed:@"messageOld"] forState:UIControlStateNormal];
    } else {
        [butInvitate setBackgroundImage:[UIImage imageNamed:@"messageNew"] forState:UIControlStateNormal];
    }
    
//    昨日收益钱数
    UILabel *labelNum = [CreatView creatWithLabelFrame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - (200 / 375.0) * WIDTH_CONTROLLER_DEFAULT)/2, HEIGHT_CONTROLLER_DEFAULT * (63.0 / 667.0), WIDTH_CONTROLLER_DEFAULT * (200.0 / 375.0), 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    
    NSMutableAttributedString *redStringM = [[NSMutableAttributedString alloc] initWithString:@"13.17元"];
    [redStringM replaceCharactersInRange:NSMakeRange(0, [[redStringM string] rangeOfString:@"元"].location) withString:[NSString stringWithFormat:@"%@ ",[DES3Util decrypt:[self.myAccountInfo objectForKey:@"yeMoney"]]]];
    NSRange numString = NSMakeRange(0, [[redStringM string] rangeOfString:@"元"].location);
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        [redStringM addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:32] range:numString];
        NSRange oneString = NSMakeRange([[redStringM string] length] - 1, 1);
        [redStringM addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:12] range:oneString];

    } else {
        [redStringM addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:35] range:numString];
        NSRange oneString = NSMakeRange([[redStringM string] length] - 1, 1);
        [redStringM addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:15] range:oneString];
    }
    [labelNum setAttributedText:redStringM];
    [imageRedBG addSubview:labelNum];
    
//    昨日收益文字
    UILabel *labelZi = [CreatView creatWithLabelFrame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - (70 / 375.0) * WIDTH_CONTROLLER_DEFAULT)/2, HEIGHT_CONTROLLER_DEFAULT * (110.0 / 667.0), WIDTH_CONTROLLER_DEFAULT * (70.0 / 375.0), HEIGHT_CONTROLLER_DEFAULT * (15.0 / 667.0)) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"昨日收益"];
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        labelZi.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    }
    
    [imageRedBG addSubview:labelZi];
    
    UIButton *yesterdayButton = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 25, HEIGHT_CONTROLLER_DEFAULT * (128.0 / 667.0), 20, 20) backgroundColor:nil textColor:nil titleText:nil];
    [yesterdayButton setImage:[UIImage imageNamed:@"zuorishouyi-678"] forState:UIControlStateNormal];
    [yesterdayButton addTarget:self action:@selector(yesterdayButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [imageRedBG addSubview:yesterdayButton];
    
//    中间部分xib
    NSBundle *root = [NSBundle mainBundle];
    middleView = (MiddleView *)[[root loadNibNamed:@"MiddleView" owner:nil options:nil] lastObject];
    
    [viewHead addSubview:middleView];
    middleView.frame = CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT * (156.0 / 667.0), WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT * (127 / 667.0));
    middleView.backgroundColor = [UIColor whiteColor];
    
    middleView.viewLine.backgroundColor = [UIColor grayColor];
    middleView.viewLine.alpha = 0.3;
    
    middleView.viewLLine.backgroundColor = [UIColor grayColor];
    middleView.viewLLine.alpha = 0.3;
    
    middleView.labelYuan.text = [[DES3Util decrypt: [self.myAccountInfo objectForKey:@"accBalance"]]  stringByReplacingOccurrencesOfString:@"," withString:@""];
    middleView.labelYuan.font = [UIFont systemFontOfSize:[self sizeOfLength:middleView.labelWanYuan.text]];
    middleView.labelYuan.textColor = Color_Black;
    middleView.labelYuan.alpha = 0.7;
    middleView.labelYuan.textAlignment = NSTextAlignmentCenter;
    
    middleView.labelWanYuan.text = [[DES3Util decrypt: [self.myAccountInfo objectForKey:@"totalProfit"]] stringByReplacingOccurrencesOfString:@"," withString:@""];
    middleView.labelWanYuan.font = [UIFont systemFontOfSize:[self sizeOfLength:middleView.labelWanYuan.text]];
    middleView.labelWanYuan.textColor = Color_Black;
    middleView.labelWanYuan.alpha = 0.7;
    middleView.labelWanYuan.textAlignment = NSTextAlignmentCenter;
    
    middleView.labelAllMoney.text = [self.myAccountInfo objectForKey:@"monkeyNum"];
    middleView.labelAllMoney.font = [UIFont systemFontOfSize:[self sizeOfLength:middleView.labelWanYuan.text]];
    middleView.labelAllMoney.textColor = Color_Black;
    middleView.labelAllMoney.alpha = 0.7;
    middleView.labelAllMoney.textAlignment = NSTextAlignmentCenter;
    
    middleView.labelMyMoney.text = @"账户余额(元)";
    middleView.labelMyMoney.textColor = [UIColor zitihui];
    middleView.labelMyMoney.textAlignment = NSTextAlignmentCenter;
    middleView.labelMyMoney.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    
    middleView.labelData.text = @"累计收益(元)";
    middleView.labelData.textColor = [UIColor zitihui];
    middleView.labelData.textAlignment = NSTextAlignmentCenter;
    middleView.labelData.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    
    middleView.labelTAllMoney.text = @"猴币(个)";
    middleView.labelTAllMoney.textColor = [UIColor zitihui];
    middleView.labelTAllMoney.textAlignment = NSTextAlignmentCenter;
    middleView.labelTAllMoney.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    
    middleView.viewDiBu.backgroundColor = [UIColor huibai];
        
    middleView.butCashMoney.backgroundColor = [UIColor colorWithRed:221.0 / 255.0 green:75.0 / 255.0 blue:72.0 / 255.0 alpha:1.0];
    middleView.butWithdrawal.backgroundColor = [UIColor colorWithRed:41.0 / 255.0 green:168.0 / 255.0 blue:244.0 / 255.0 alpha:1.0];
    middleView.butBigMoney.backgroundColor = [UIColor colorWithRed:138.0 / 255.0 green:206.0 / 255.0 blue:154.0 / 255.0 alpha:1.0];
    
    [middleView.butCashMoney addTarget:self action:@selector(rechargeMoney:) forControlEvents:UIControlEventTouchUpInside];
    [middleView.butWithdrawal addTarget:self action:@selector(withdrawMoney:) forControlEvents:UIControlEventTouchUpInside];
    [middleView.butBigMoney addTarget:self action:@selector(bigMoneyRecharge:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    } else {
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
//        
//        MonkeyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseMonkey"];
//        
//        cell.imageName.image = [UIImage imageNamed:@"椭圆猴-9"];
//        cell.labelName.text = @"猴币";
//        cell.labelName.font = [UIFont fontWithName:@"CenturyGothic" size:15];
//        cell.labelName.textColor = [UIColor zitihui];
//        
//        cell.labelGeShu.font = [UIFont fontWithName:@"CenturyGothic" size:14];
//        cell.labelGeShu.textAlignment = NSTextAlignmentRight;
//        NSMutableAttributedString *textShu = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@个", [self.myAccountInfo objectForKey:@"monkeyNum"]]];
//        NSRange geText = NSMakeRange([[textShu string] length] - 1, 1);
//        NSRange leftText = NSMakeRange(0, [[textShu string]rangeOfString:@"个"].location);
//        [textShu addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:leftText];
//        [textShu addAttribute:NSForegroundColorAttributeName value:[UIColor zitihui] range:geText];
//        [cell.labelGeShu setAttributedText:textShu];
//        
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//        
//    } else {
    
        MineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        
        cell.imageViewPic.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [pictureArr objectAtIndex:indexPath.row]]];
        cell.labelLine.backgroundColor = [UIColor zitihui];
        cell.labelLine.alpha = 0.3;
        cell.labelLine.text = @"";
        
        cell.labelTitle.text = [titleArr objectAtIndex:indexPath.row];
        cell.labelTitle.textColor = [UIColor zitihui];
        cell.labelTitle.font = [UIFont systemFontOfSize:15];
        
        cell.imageRight.image = [UIImage imageNamed:@"arrow"];
        
        if (indexPath.row == 0) {
            
            if (moneyLabel == nil) {
                moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, WIDTH_CONTROLLER_DEFAULT - 125, 50)];
                
                moneyLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
                moneyLabel.textColor = [UIColor zitihui];
                moneyLabel.textAlignment = NSTextAlignmentRight;
                [cell addSubview:moneyLabel];
            }
            moneyLabel.text = [NSString stringWithFormat:@"%@元在投资金",[DES3Util decrypt:[self.myAccountInfo objectForKey:@"totalMoney"]]];
        } else if (indexPath.row == 2) {
            
            if (myRedBagButton == nil) {
                myRedBagButton = [UIButton buttonWithType:UIButtonTypeCustom];
                
                myRedBagButton.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT - 60, 15, 30, 20);
                
                myRedBagButton.userInteractionEnabled = NO;
                
                myRedBagButton.layer.masksToBounds = YES;
                myRedBagButton.layer.cornerRadius = 8.f;
                
                [myRedBagButton setBackgroundImage:[UIImage imageNamed:@"shouyeqiepian_17"] forState:UIControlStateNormal];
                
                myRedBagButton.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
                
                [cell addSubview:myRedBagButton];
                
            }
            if ([[self.myAccountInfo objectForKey:@"redPacket"] isEqualToString:@"0"]) {
                myRedBagButton.hidden = YES;
            } else {
                myRedBagButton.hidden = NO;
                [myRedBagButton setTitle:[self.myAccountInfo objectForKey:@"redPacket"] forState:UIControlStateNormal];
            }
            
        } else if (indexPath.row == 5) {
//            if (messageButton == nil) {
//                messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
//                
//                messageButton.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT - 60, 15, 30, 20);
//                
//                messageButton.userInteractionEnabled = NO;
//                
//                messageButton.layer.masksToBounds = YES;
//                messageButton.layer.cornerRadius = 8.f;
//                
//                [messageButton setBackgroundImage:[UIImage imageNamed:@"shouyeqiepian_17"] forState:UIControlStateNormal];
//                
//                messageButton.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
//                
//                [cell addSubview:messageButton];
//                
//            }
//            if ([[self.myAccountInfo objectForKey:@"msgCount"] isEqualToString:@"0"]) {
//                messageButton.hidden = YES;
//            } else {
//                messageButton.hidden = NO;
//                [messageButton setTitle:[self.myAccountInfo objectForKey:@"msgCount"] forState:UIControlStateNormal];
//            }
        }
        
        return cell;
//    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    if (indexPath.row == 1) {
        
        [MobClick event:@"MyInformation"];
        MyInformationViewController *myInformationVC = [[MyInformationViewController alloc] init];
        [self.navigationController pushViewController:myInformationVC animated:YES];
        
    } else if (indexPath.row == 2) {
        
        [MobClick event:@"ThirdRedBag"];
        TheThirdRedBagController *myRedBagVC = [[TheThirdRedBagController alloc] init];
        [self.navigationController pushViewController:myRedBagVC animated:YES];
        
    } else if (indexPath.row == 0) {
        
        [MobClick event:@"ProductSetting"];
        // 账户资产old
//        ProductSettingViewController *pSettringVC = [[ProductSettingViewController alloc] init];
//        [self.navigationController pushViewController:pSettringVC animated:YES];
        // 我的资产new
        NewCastProductViewController *newCastPVC = [[NewCastProductViewController alloc] init];
        pushVC(newCastPVC);
        
    } else if (indexPath.row == 3) {
        
        [MobClick event:@"Transaction"];
        TransactionViewController *transactionVC = [[TransactionViewController alloc] init];
        [self.navigationController pushViewController:transactionVC animated:YES];
        
    } else if (indexPath.row == 4) {
        
        [MobClick event:@"MyInvitation"];
        //好友邀请界面
//        MyInvitationViewController *myInvitationVC = [[MyInvitationViewController alloc] init];
//        [self.navigationController pushViewController:myInvitationVC animated:YES];

        [UIView animateWithDuration:0.5f animations:^{
            viewGray.hidden = NO;
            inviteNV.frame = CGRectMake(0, self.view.frame.size.height - 200, self.view.frame.size.width, 200);
        }];
        
    }
    
}

//头像按钮
- (void)headPictureButton:(UIButton *)button
{
    [MobClick event:@"MyInformation"];
    MyInformationViewController *myInformationVC = [[MyInformationViewController alloc] init];
    [self.navigationController pushViewController:myInformationVC animated:YES];
}

//我的咨询按钮
- (void)userListButton:(UIButton *)button
{
    UserListViewController *userList = [[UserListViewController alloc] init];
    [self.navigationController pushViewController:userList animated:YES];
}

//我的理财师按钮
- (void)inviteButton:(UIButton *)button
{
    [MobClick event:@"MyNews"];
    
    MyNewsViewController *myNewsVC = [[MyNewsViewController alloc] init];
    [self.navigationController pushViewController:myNewsVC animated:YES];

    
    // 理财师判断,, 这地方一定要记住
//    if ([[[self.myAccountInfo objectForKey:@"myFinPlanner"] description] isEqualToString:@"0"]) {
//        
////      如果还没有自己的理财师 跳转到理财师列表的页面
//        MyChoosePlanner *myChoose = [[MyChoosePlanner alloc] init];
//        [self.navigationController pushViewController:myChoose animated:YES];
//        
//    } else {
//        
////      如果已经有自己的理财师直接跳转到我的理财师
//        MyPlannerViewController *myPlannerVC = [[MyPlannerViewController alloc] init];
//        myPlannerVC.design = 1;
//        [self.navigationController pushViewController:myPlannerVC animated:YES];        
//    }
}

//充值按钮
- (void)rechargeMoney:(UIButton *)button
{
    
//    if ([[self.myAccountInfo objectForKey:@"realName"] isEqualToString:@""]) {
//        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"充值必须先通过实名认证"];
//        RealNameViewController *realNameVC = [[RealNameViewController alloc] init];
//        [self.navigationController pushViewController:realNameVC animated:YES];
//    } else {
    [MobClick event:@"RechargeAlreadyBinding"];
    RechargeAlreadyBinding *recharge = [[RechargeAlreadyBinding alloc] init];
    [self.navigationController pushViewController:recharge animated:YES];
        
//    }
}

//提现按钮
- (void)withdrawMoney:(UIButton *)button
{
//    GetMoneyViewController *getMoneyVC = [[GetMoneyViewController alloc] init];
//    [self.navigationController pushViewController:getMoneyVC animated:YES];
    [MobClick event:@"LiftupMoney"];
    LiftupMoneyViewController *liftupVC = [[LiftupMoneyViewController alloc] init];
    liftupVC.moneyString = [[DES3Util decrypt: [self.myAccountInfo objectForKey:@"accBalance"]] stringByReplacingOccurrencesOfString:@"," withString:@""];
    [self.navigationController pushViewController:liftupVC animated:YES];
}

//大额充值
- (void)bigMoneyRecharge:(UIButton *)button
{
    [MobClick event:@"BigMoney"];
//    bigId为0的时候 说明没有进行大额申请 跳转的是到大额申请页面
    if ([[[self.myAccountInfo objectForKey:@"bigId"] description] isEqualToString:@"0"]) {
    
        BigMoneyViewController *bigMoneyVC = [[BigMoneyViewController alloc] init];
        [self.navigationController pushViewController:bigMoneyVC animated:YES];
        
    } else {
        
//        正在申请中跳转的是申请步骤页面
        ApplyScheduleViewController *apply = [[ApplyScheduleViewController alloc] init];
        apply.ID = [[self.myAccountInfo objectForKey:@"bigId"] description];
        [self.navigationController pushViewController:apply animated:YES];
    }
}

//昨日收益
- (void)yesterdayButtonAction:(id)sender{
    [MobClick event:@"Yesterday"];
    YesterdayViewController *yesterdayVC = [[YesterdayViewController alloc] init];
    [self.navigationController pushViewController:yesterdayVC animated:YES];
}

#pragma mark 网络请求方法
#pragma mark ----------=====================-----------

- (void)MyAccountInfo{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    self.imgString = [dic objectForKey:@"avatarImg"];
    
    NSDictionary *parameter = @{@"token":[dic objectForKey:@"token"]};
    
    NSLog(@"parameter -=- %@",parameter);
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/getMyAccountInfo" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"MyAccountInfo = %@",responseObject);
        
        self.myAccountInfo = responseObject;
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:400]]) {
            NSLog(@"134897189374987342987243789423");
            if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
                [FileOfManage createWithFile:@"isLogin.plist"];
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            } else {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"beforeWithView" object:nil];
            [self.navigationController popToRootViewControllerAnimated:NO];
            return ;
        } else if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]){
        
            [self loadingWithHidden:YES];
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
            
            [dic setValue:[responseObject objectForKey:@"inviteType"] forKey:@"inviteType"];
            [dic setValue:[responseObject objectForKey:@"myFinPlanner"] forKey:@"myFinPlanner"];
            [dic setValue:[responseObject objectForKey:@"invitationMyCode"] forKey:@"invitationMyCode"];
            [dic setValue:[responseObject objectForKey:@"accBalance"] forKey:@"accBalance"];
            [dic setValue:[responseObject objectForKey:@"redPacket"] forKey:@"redPacket"];
            [dic setValue:[responseObject objectForKey:@"realName"] forKey:@"realName"];
            [dic setValue:[responseObject objectForKey:@"cardNumber"] forKey:@"cardNumber"];
            [dic setValue:[responseObject objectForKey:@"monkeyNum"] forKey:@"monkeyNum"];
            [dic setValue:[responseObject objectForKey:@"totalMoney"] forKey:@"totalMoney"];
            
            [dic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
            
            [self showTableView];
            [self viewHeadContent];
            [_tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

#pragma mark 分享成功回调方法
#pragma mark --------------------------------

- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

- (void)exchangeWithImageView{
    [self MyAccountInfo];
}

/**
 *  分享实现的方法
 */


- (void)wAction{
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:@"大圣理财,金融街的新宠.大圣理财链接:https://itunes.apple.com/cn/app/da-sheng-li-cai/id1063185702?mt=8" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        NSLog(@"%u",response.responseCode);
        if (response.responseCode == UMSResponseCodeSuccess) {
            //                [self getShareRedPacket];
            NSLog(@"邀请成功！");
        }
    }];
}

- (void)xAction{
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"大圣理财,金融街的新宠.大圣理财链接:https://itunes.apple.com/cn/app/da-sheng-li-cai/id1063185702?mt=8" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
        NSLog(@"shareResponse = %u",shareResponse.responseCode);
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            //                [self getShareRedPacket];
            NSLog(@"邀请成功！");
        }
    }];
}

- (void)pAction{
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:@"大圣理财,金融街的新宠.大圣理财链接:https://itunes.apple.com/cn/app/da-sheng-li-cai/id1063185702?mt=8" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        NSLog(@"%u",response.responseCode);
        if (response.responseCode == UMSResponseCodeSuccess) {
            //                [self getShareRedPacket];
            NSLog(@"邀请成功！");
        }
    }];
}

- (void)rAction{
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToRenren] content:@"大圣理财,金融街的新宠.大圣理财链接:https://itunes.apple.com/cn/app/da-sheng-li-cai/id1063185702?mt=8" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        NSLog(@"%u",response.responseCode);
        if (response.responseCode == UMSResponseCodeSuccess) {
            //                [self getShareRedPacket];
            NSLog(@"邀请成功！");
        }
    }];
}

- (void)qAction{
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:@"大圣理财,金融街的新宠.大圣理财链接:https://itunes.apple.com/cn/app/da-sheng-li-cai/id1063185702?mt=8" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        NSLog(@"%u",response.responseCode);
        if (response.responseCode == UMSResponseCodeSuccess) {
            //                [self getShareRedPacket];
            NSLog(@"邀请成功！");
        }
    }];
}

- (void)closeAction:(id)sender{
    [UIView animateWithDuration:0.5f animations:^{
        inviteNV.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 200);
        
        viewGray.hidden = YES;
    }];
}

/**
 *  分享界面搭建
 */

- (void)shareWithView{
    NSBundle *rootBundle = [NSBundle mainBundle];
    
    viewGray.hidden = NO;
    
    inviteNV = (InviteNewView *)[[rootBundle loadNibNamed:@"InviteNewView" owner:nil options:nil]lastObject];
    
    inviteNV.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 200);
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [app.window addSubview:viewGray];
    
    [app.window addSubview:inviteNV];
    
    [inviteNV.wButton addTarget:self action:@selector(wAction) forControlEvents:UIControlEventTouchUpInside];
    [inviteNV.WButton addTarget:self action:@selector(wAction) forControlEvents:UIControlEventTouchUpInside];
    [inviteNV.xButton addTarget:self action:@selector(xAction) forControlEvents:UIControlEventTouchUpInside];
    [inviteNV.XButton addTarget:self action:@selector(xAction) forControlEvents:UIControlEventTouchUpInside];
    [inviteNV.pButton addTarget:self action:@selector(pAction) forControlEvents:UIControlEventTouchUpInside];
    [inviteNV.PButton addTarget:self action:@selector(pAction) forControlEvents:UIControlEventTouchUpInside];
    [inviteNV.rButton addTarget:self action:@selector(rAction) forControlEvents:UIControlEventTouchUpInside];
    [inviteNV.RButton addTarget:self action:@selector(rAction) forControlEvents:UIControlEventTouchUpInside];
    [inviteNV.qButton addTarget:self action:@selector(qAction) forControlEvents:UIControlEventTouchUpInside];
    [inviteNV.QButton addTarget:self action:@selector(qAction) forControlEvents:UIControlEventTouchUpInside];
    
    [inviteNV.cancelButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
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
