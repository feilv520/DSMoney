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
#import "TWOJobCenterViewController.h"
#import "TWOMyMonkeyCoinViewController.h"
#import "NewInviteViewController.h"
#import "TWOPersonalSetViewController.h"
#import "TWOMessageCenterViewController.h"
#import "TWOUsableMoneyViewController.h"
#import "TWOLoginAPPViewController.h"
#import "TWOMoneyMoreFinishViewController.h"
#import "TWORedBagViewController.h"

@interface TWOMineViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UIImagePickerControllerDelegate>

{
    UITableView *_tableView;
    NSArray *titleArray;
    NSArray *imageArray;
    NSArray *contentArr;
    NSArray *contentXingArr;
    UIImageView *imageBackGround;
    CGFloat height;
    UIButton *butWenZi;
    UILabel *labelTestShu;
    
    // 头像元素
    UIView *viewDown;
    UIButton *butBlack;
    UIView *viewHateLine;
    
//    总资产钱数
    UIButton *buttMoney;
    UIButton *butMoneyYu;
    UIButton *butAddMoney;
    UIView *viewMoney;
    UIButton *buttonEye;
    
    UILabel *labelMoneyZhong;
    UILabel *labelTeQuan;
}

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation TWOMineViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 359.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
        
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 568) {
        NSLog(@"5s");
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 344.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
        
    } else {

        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 330.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    }
    _tableView.tableHeaderView.backgroundColor = [UIColor whiteColor];
    [self tableViewHeadShow];
    
    [_tableView registerNib:[UINib nibWithNibName:@"TWOMineCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    [self arrayShow];
}

- (void)arrayShow
{
    titleArray = @[@[@"我的理财", @"我的特权本金"], @[@"红包卡券", @"我的猴币", @"我的邀请"]];
    imageArray = @[@[@"我的理财", @"tequanbenjin"], @[@"红包卡券", @"我的猴币", @"myInvite"]];
    contentArr = @[@[@"13600元在投", @"300000元"], @[@"2张", @"3000.00猴币", @"邀请好友送星巴克券"]];
}

//tableView头部
- (void)tableViewHeadShow
{
    imageBackGround = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 281.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backGroundColor:[UIColor greenColor] setImage:[UIImage imageNamed:@"我的背景图"]];
    [_tableView.tableHeaderView addSubview:imageBackGround];
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 568) {
        imageBackGround.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 295.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20));
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        imageBackGround.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 310.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20));
    }
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
    UIView *viewAlpha = [CreatView creatViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 71, buttonSet.frame.size.height + 23 + 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 71 + 20, 48.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor colorWithRed:33.0 / 225.0 green:125.0 / 225.0 blue:226.0 / 225.0 alpha:1.0]];
    [imageBackGround addSubview:viewAlpha];
    viewAlpha.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    viewAlpha.layer.cornerRadius = 15;
    viewAlpha.layer.masksToBounds = YES;
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        viewAlpha.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT - 71, buttonSet.frame.size.height + 23 + 18.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 71 + 20, 62.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20));
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 568) {
        viewAlpha.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT - 71, buttonSet.frame.size.height + 23 + 18.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 71 + 20, 57.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20));
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 736) {
        viewAlpha.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT - 71, buttonSet.frame.size.height + 23 + 18.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 71 + 20, 43.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20));
    }
    
    UIButton *butTask = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(71/2 - 16, 0, 30, 30) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [viewAlpha addSubview:butTask];
    [butTask setBackgroundImage:[UIImage imageNamed:@"renwuzhongxinicon"] forState:UIControlStateNormal];
    [butTask setBackgroundImage:[UIImage imageNamed:@"renwuzhongxinicon"] forState:UIControlStateHighlighted];
    [butTask addTarget:self action:@selector(jobCenterButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *butTastWen = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 30, 71, 12) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"任务中心"];
    [viewAlpha addSubview:butTastWen];
    butTastWen.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    [butTastWen addTarget:self action:@selector(jobCenterButton:) forControlEvents:UIControlEventTouchUpInside];
    
//    任务中心数字显示
    labelTestShu = [CreatView creatWithLabelFrame:CGRectMake(butTask.frame.size.width - 3, 3, 13, 13) backgroundColor:[UIColor orangeColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:9] text:@"38"];
    [butTask addSubview:labelTestShu];
    labelTestShu.layer.cornerRadius = 13 / 2;
    labelTestShu.layer.masksToBounds = YES;
    
//    充值提现上面的横线
    UIView *viewLineH = [CreatView creatViewWithFrame:CGRectMake(0, imageBackGround.frame.size.height - 1, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor whiteColor]];
    [imageBackGround addSubview:viewLineH];
    viewLineH.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
//    充值按钮
    UIButton *butFullMoney = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, imageBackGround.frame.size.height, WIDTH_CONTROLLER_DEFAULT/2, 49.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor colorWithRed:16.0 / 225.0 green:101.0 / 225.0 blue:205.0 / 225.0 alpha:1.0] textColor:[UIColor whiteColor] titleText:@"充值"];
    [_tableView.tableHeaderView addSubview:butFullMoney];
    butFullMoney.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:16];
    [butFullMoney setImage:[UIImage imageNamed:@"充值"] forState:UIControlStateNormal];
    butFullMoney.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [butFullMoney addTarget:self action:@selector(buttonFullMoney:) forControlEvents:UIControlEventTouchUpInside];
    
//    充值与提现之间的竖线
    UIView *viewLineS = [CreatView creatViewWithFrame:CGRectMake(butFullMoney.frame.size.width - 0.5, 0, 0.5, butFullMoney.frame.size.height) backgroundColor:[UIColor whiteColor]];
    [butFullMoney addSubview:viewLineS];
    
//    提现按钮
    UIButton *butFillMoney = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(butFullMoney.frame.size.width, imageBackGround.frame.size.height, WIDTH_CONTROLLER_DEFAULT/2, butFullMoney.frame.size.height) backgroundColor:[UIColor colorWithRed:16.0 / 225.0 green:101.0 / 225.0 blue:205.0 / 225.0 alpha:1.0] textColor:[UIColor whiteColor] titleText:@"提现"];
    [_tableView.tableHeaderView addSubview:butFillMoney];
    butFillMoney.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:16];
    [butFillMoney setImage:[UIImage imageNamed:@"提现"] forState:UIControlStateNormal];
    butFillMoney.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [butFillMoney addTarget:self action:@selector(buttonFillMoney:) forControlEvents:UIControlEventTouchUpInside];
    
    viewHateLine = [CreatView creatViewWithFrame:CGRectMake(0, -1, WIDTH_CONTROLLER_DEFAULT, 10) backgroundColor:[UIColor greenColor]];
    
    UIButton *butHeadImage = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(150.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 45.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT - ((150.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT) * 2), WIDTH_CONTROLLER_DEFAULT - ((150.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT) * 2)) backgroundColor:[UIColor greenColor] textColor:nil titleText:nil];
    [imageBackGround addSubview:butHeadImage];
    [butHeadImage setBackgroundImage:[UIImage imageNamed:@"我的头像"] forState:UIControlStateNormal];
    [butHeadImage setBackgroundImage:[UIImage imageNamed:@"我的头像"] forState:UIControlStateHighlighted];
    butHeadImage.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    butHeadImage.layer.cornerRadius = (WIDTH_CONTROLLER_DEFAULT - ((150.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT) * 2))/2;
    butHeadImage.layer.masksToBounds = YES;
    [butHeadImage addTarget:self action:@selector(buttonChangeHeadImage:) forControlEvents:UIControlEventTouchUpInside];
    
//    总资产底层view
    viewMoney = [CreatView creatViewWithFrame:CGRectMake(0, 143.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 30) backgroundColor:[UIColor clearColor]];
    [imageBackGround addSubview:viewMoney];
    viewMoney.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
//    总资产钱数
    buttMoney = [UIButton buttonWithType:UIButtonTypeCustom];
    [viewMoney addSubview:buttMoney];
    buttMoney.backgroundColor = [UIColor clearColor];
    buttMoney.tag = 665;
    
    NSMutableAttributedString *addMoneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", @"2,273,457.00"]];
    NSRange leftrange = NSMakeRange(0, [[addMoneyString string] rangeOfString:@"元"].location);
    [addMoneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:28] range:leftrange];
    [addMoneyString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:leftrange];
    NSRange rightrange = NSMakeRange([[addMoneyString string] length] - 1, 1);
    [addMoneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:12] range:rightrange];
    [addMoneyString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:rightrange];
    [buttMoney setAttributedTitle:addMoneyString forState:UIControlStateNormal];
    [buttMoney addTarget:self action:@selector(checkMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect moneyButWidth = [buttMoney.titleLabel.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT, viewMoney.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:28]} context:nil];
    buttMoney.frame = CGRectMake((WIDTH_CONTROLLER_DEFAULT - moneyButWidth.size.width) * 0.5, 0, moneyButWidth.size.width, viewMoney.frame.size.height);
    
//    睁眼闭眼按钮
    buttonEye = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - moneyButWidth.size.width) * 0.5 + moneyButWidth.size.width, viewMoney.frame.size.height - 19, 21, 21) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [viewMoney addSubview:buttonEye];
    buttonEye.tag = 10;
    buttonEye.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [buttonEye setImage:[UIImage imageNamed:@"openEye"] forState:UIControlStateNormal];
    [buttonEye addTarget:self action:@selector(openEyeOrCloseEye:) forControlEvents:UIControlEventTouchUpInside];

//    总资产按钮
    UIButton *buttonZZC = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 25, 142.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + viewMoney.frame.size.height, 50, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"总资产"];
    [imageBackGround addSubview:buttonZZC];
    buttonZZC.tag = 665;
    buttonZZC.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    buttonZZC.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [buttonZZC addTarget:self action:@selector(checkMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
    
//    总资产右下角黄色三角按钮
    UIButton *butYellowJiao = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 25 + 52, 142.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + viewMoney.frame.size.height + 17.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 12, 12) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [imageBackGround addSubview:butYellowJiao];
    butYellowJiao.tag = 665;
    [butYellowJiao setBackgroundImage:[UIImage imageNamed:@"yellowSanJiao"] forState:UIControlStateNormal];
    [butYellowJiao setBackgroundImage:[UIImage imageNamed:@"yellowSanJiao"] forState:UIControlStateHighlighted];
    butYellowJiao.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [butYellowJiao addTarget:self action:@selector(checkMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
    
//    可用余额钱数
    butMoneyYu = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 142.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + viewMoney.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 14 + 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT/2, 16) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:nil];
    [imageBackGround addSubview:butMoneyYu];
    butMoneyYu.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    butMoneyYu.tag = 666;
    
    NSMutableAttributedString *butMoneyStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", @"2,789,681.00"]];
    NSRange shuRange = NSMakeRange(0, [[butMoneyStr string] rangeOfString:@"元"].location);
    [butMoneyStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:16] range:shuRange];
    [butMoneyStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:shuRange];
    NSRange yuanRange = NSMakeRange([[butMoneyStr string] length] - 1, 1);
    [butMoneyStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:yuanRange];
    [butMoneyStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:yuanRange];
    [butMoneyYu setAttributedTitle:butMoneyStr forState:UIControlStateNormal];
    [butMoneyYu addTarget:self action:@selector(checkMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
    
//    累计收益钱数
    butAddMoney = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2, 142.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + viewMoney.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 14 + 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT/2, 16) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [imageBackGround addSubview:butAddMoney];
    butAddMoney.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    butAddMoney.tag = 667;
    
    NSMutableAttributedString *butAddStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", @"2,909.00"]];
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
        butWenZi = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT / 2 * i, 142.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + viewMoney.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 14 + 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 16, WIDTH_CONTROLLER_DEFAULT/2, 25) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:[titArray objectAtIndex:i]];
        [imageBackGround addSubview:butWenZi];
        butWenZi.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        butWenZi.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        butWenZi.tag = 666 + i;
        [butWenZi addTarget:self action:@selector(checkMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
//    可用余额三角按钮
    UIButton *butLeftJiao = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(122.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 142.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + viewMoney.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 14 + 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 16 + 15, 12, 12) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [imageBackGround addSubview:butLeftJiao];
    butLeftJiao.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [butLeftJiao setBackgroundImage:[UIImage imageNamed:@"baisanjiao"] forState:UIControlStateNormal];
    [butLeftJiao setBackgroundImage:[UIImage imageNamed:@"baisanjiao"] forState:UIControlStateHighlighted];
    butLeftJiao.tag = 666;
    [butLeftJiao addTarget:self action:@selector(checkMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
    
//    累计收益三角按钮
    UIButton *butRightJiao = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 + 122.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 142.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + viewMoney.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 14 + 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 16 + 15, 12, 12) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
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
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.labelContent.tag = 10;
        } else {
            cell.labelContent.tag = 90;
        }
    }
    
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
    return 53.0;
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
    } else {
        if (indexPath.row == 1) {
            TWOMyMonkeyCoinViewController *myMonkeyCoinVC = [[TWOMyMonkeyCoinViewController alloc] init];
            [self.navigationController pushViewController:myMonkeyCoinVC animated:YES];
            
        } else if (indexPath.row == 2) {
            NewInviteViewController *inviteVC = [[NewInviteViewController alloc] init];
            [self.navigationController pushViewController:inviteVC animated:YES];
            
        } else {
            TWORedBagViewController *redBagVC = [[TWORedBagViewController alloc] init];
            pushVC(redBagVC);
        }
    }
}

//任务中心按钮
- (void)jobCenterButton:(UIButton *)button
{
    labelTestShu.hidden = YES;
    TWOJobCenterViewController *jobCenterVC = [[TWOJobCenterViewController alloc] init];
    pushVC(jobCenterVC);
}

//睁眼或闭眼按钮
- (void)openEyeOrCloseEye:(UIButton *)button
{
    labelMoneyZhong = (UILabel *)[self.view viewWithTag:10];
    labelTeQuan = (UILabel *)[self.view viewWithTag:90];
    
    if (button.tag == 10) {
       
        [self closeEyesButton:buttMoney];
        buttMoney.frame = CGRectMake((WIDTH_CONTROLLER_DEFAULT - 60) * 0.5, viewMoney.frame.size.height - viewMoney.frame.size.height/3 - 3, 60, viewMoney.frame.size.height/3);
//    闭眼眼睛的frame
        buttonEye.frame = CGRectMake((WIDTH_CONTROLLER_DEFAULT - 60) * 0.5 + 60, viewMoney.frame.size.height - 22, 21, 21);
        
        [self closeEyesButton:butMoneyYu];
        [self closeEyesButton:butAddMoney];
        
        labelMoneyZhong.text = @"****";
        labelMoneyZhong.font = [UIFont fontWithName:@"CenturyGothic" size:17];
        
        labelTeQuan.text = @"****";
        labelTeQuan.font = [UIFont fontWithName:@"CenturyGothic" size:17];
        
        [button setImage:[UIImage imageNamed:@"biyan"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"biyan"] forState:UIControlStateHighlighted];
        button.tag = 20;
        
    } else {
        
        [self zongMoney];
        [self canMakeMoney];
        [self addMoney];
        
        labelMoneyZhong.text = @"13600元在投";
        labelMoneyZhong.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        
        labelTeQuan.text = @"300000元";
        labelTeQuan.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        
        [button setImage:[UIImage imageNamed:@"openEye"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"openEye"] forState:UIControlStateHighlighted];
        button.tag = 10;
    }
}

//总资产方法
- (void)zongMoney
{
    NSMutableAttributedString *addMoneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", @"2,273,457.00"]];
    NSRange leftrange = NSMakeRange(0, [[addMoneyString string] rangeOfString:@"元"].location);
    [addMoneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:28] range:leftrange];
    [addMoneyString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:leftrange];
    NSRange rightrange = NSMakeRange([[addMoneyString string] length] - 1, 1);
    [addMoneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:12] range:rightrange];
    [addMoneyString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:rightrange];
    [buttMoney setAttributedTitle:addMoneyString forState:UIControlStateNormal];
    
    CGRect moneyButWidth = [buttMoney.titleLabel.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT, viewMoney.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:28]} context:nil];
//        睁眼钱数的frame
    buttMoney.frame = CGRectMake((WIDTH_CONTROLLER_DEFAULT - moneyButWidth.size.width) * 0.5, 0, moneyButWidth.size.width, viewMoney.frame.size.height);
//        眼睛的frame
    buttonEye.frame = CGRectMake((WIDTH_CONTROLLER_DEFAULT - moneyButWidth.size.width) * 0.5 + moneyButWidth.size.width, viewMoney.frame.size.height - 19, 21, 21);
}

//可用余额
- (void)canMakeMoney
{
    NSMutableAttributedString *butMoneyStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", @"2,789,681.00"]];
    NSRange shuRange = NSMakeRange(0, [[butMoneyStr string] rangeOfString:@"元"].location);
    [butMoneyStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:16] range:shuRange];
    [butMoneyStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:shuRange];
    NSRange yuanRange = NSMakeRange([[butMoneyStr string] length] - 1, 1);
    [butMoneyStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:yuanRange];
    [butMoneyStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:yuanRange];
    [butMoneyYu setAttributedTitle:butMoneyStr forState:UIControlStateNormal];
}

//累计收益
- (void)addMoney
{
    NSMutableAttributedString *butAddStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", @"2,909.00"]];
    NSRange frontRange = NSMakeRange(0, [[butAddStr string] rangeOfString:@"元"].location);
    [butAddStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:16] range:frontRange];
    [butAddStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:frontRange];
    NSRange afterRange = NSMakeRange([[butAddStr string] length] - 1, 1);
    [butAddStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:afterRange];
    [butAddStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:afterRange];
    [butAddMoney setAttributedTitle:butAddStr forState:UIControlStateNormal];
}

//封装闭眼
- (void)closeEyesButton:(UIButton *)button
{
    NSMutableAttributedString *addMoneyString = [[NSMutableAttributedString alloc] initWithString:@"****"];
    NSRange allRange = NSMakeRange(0, 4);
    [addMoneyString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:allRange];
    [addMoneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:30] range:allRange];
    [button setAttributedTitle:addMoneyString forState:UIControlStateNormal];
}

//充值按钮
- (void)buttonFullMoney:(UIButton *)button
{
    TWOMoneyMoreFinishViewController *finishVC = [[TWOMoneyMoreFinishViewController alloc] init];
    [self.navigationController pushViewController:finishVC animated:YES];
}

//提现按钮
- (void)buttonFillMoney:(UIButton *)button
{
    NSLog(@"tixian");
}

//点击头像按钮
- (void)buttonChangeHeadImage:(UIButton *)button
{
    butBlack = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.tabBarVC.view addSubview:butBlack];
    butBlack.alpha = 0.3;
    [butBlack addTarget:self action:@selector(buttonBlackDisappear:) forControlEvents:UIControlEventTouchUpInside];
    viewDown = [CreatView creatViewWithFrame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT - 180, WIDTH_CONTROLLER_DEFAULT, 160) backgroundColor:[UIColor huibai]];
    [app.tabBarVC.view addSubview:viewDown];
    
    [self viewDownShow];
}

//弹出框
- (void)viewDownShow
{
    UIButton *butCamera = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] titleText:@"拍照"];
    [viewDown addSubview:butCamera];
    butCamera.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butCamera addTarget:self action:@selector(takeCamera:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *labelLine1 = [CreatView creatWithLabelFrame:CGRectMake(0, 49.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [butCamera addSubview:labelLine1];
    labelLine1.alpha = 0.2;
    
    UIButton *butPicture = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 50, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] titleText:@"从手机相册选择"];
    [viewDown addSubview:butPicture];
    butPicture.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butPicture addTarget:self action:@selector(chooseFromPicture:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *butCancle = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 110, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor] textColor:[UIColor daohanglan] titleText:@"取消"];
    [viewDown addSubview:butCancle];
    butCancle.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butCancle addTarget:self action:@selector(buttonCancle:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *labelLine2 = [CreatView creatWithLabelFrame:CGRectMake(0, 49.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [butPicture addSubview:labelLine2];
    labelLine2.alpha = 0.3;
    
    UILabel *labelLine3 = [CreatView creatWithLabelFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [butCancle addSubview:labelLine3];
    labelLine3.alpha = 0.3;
}

//拍照
- (void)takeCamera:(UIButton *)button
{
    
    [butBlack removeFromSuperview];
    [viewDown removeFromSuperview];
    
    butBlack = nil;
    viewDown = nil;
    
    NSLog(@"拍照");
    //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
    //            sourceType = UIImagePickerControllerSourceTypeCamera;
    //        }
    //sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
    //sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
    //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];//进入照相界面
}

//从相册选择
- (void)chooseFromPicture:(UIButton *)button
{
    [butBlack removeFromSuperview];
    [viewDown removeFromSuperview];
    
    butBlack = nil;
    viewDown = nil;
    
    NSLog(@"从相册选择");
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
    }
    
    pickerImage.delegate = self;
    
    pickerImage.navigationBar.barTintColor = [UIColor profitColor];
    
    pickerImage.allowsEditing = NO;
    [self presentViewController:pickerImage animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.imageView = (UIImageView *)[self.view viewWithTag:9908];
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    // 保存图片至本地，方法见下文
    [self saveImage:image withName:@"currentImage.png"];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    [self.imageView setImage:savedImage];
    
    [[MyAfHTTPClient sharedClient] uploadFile:savedImage];
}

- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录

    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}

//取消按钮
- (void)buttonCancle:(UIButton *)button
{
    [butBlack removeFromSuperview];
    [viewDown removeFromSuperview];
    
    butBlack = nil;
    viewDown = nil;
}

//黑色遮罩层消失
- (void)buttonBlackDisappear:(UIButton *)button
{
    [button removeFromSuperview];
    [viewDown removeFromSuperview];
    
    viewDown = nil;
    button = nil;
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
    TWOPersonalSetViewController *personalSetVC = [[TWOPersonalSetViewController alloc] init];
    [self.navigationController pushViewController:personalSetVC animated:YES];
}

//总资产&可用余额&累计收益查看
- (void)checkMoneyButton:(UIButton *)button
{
    if (button.tag == 665) {
        
        TWOMyMoneyViewController *myMoneyVC = [[TWOMyMoneyViewController alloc] init];
        [self.navigationController pushViewController:myMoneyVC animated:YES];
        
    } else if (button.tag == 666) {
        
        TWOUsableMoneyViewController *usableMoneyVC = [[TWOUsableMoneyViewController alloc] init];
        usableMoneyVC.whichOne = YES;
        pushVC(usableMoneyVC);
        
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
    
    if (scrollView.contentOffset.y < -20) {
        _tableView.scrollEnabled = NO;
    } else {
        _tableView.scrollEnabled = YES;
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
