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
#import "TWOMyAccountModel.h"
#import "TWOLiftMoneyViewController.h"
#import "TWOMoneyMoreViewController.h"
#import "TWONoticeDetailViewController.h"
#import "BannerViewController.h"

@interface TWOMineViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

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
    UIButton *butHeadImage;
    
    // 头像元素
    UIView *viewDown;
    UIButton *butBlack;
    UIView *viewHateLine;
    
    // 头部元素
    UIButton *buttEmail;
    UIButton *buttonSet;
    UIView *viewAlpha;
    
    // 总资产钱数
    UIButton *buttMoney;
    UIButton *butMoneyYu;
    UIButton *butAddMoney;
    UIView *viewMoney;
    UIButton *buttonEye;
    UIButton *butTask;
    UIButton *butTastWen;
    UIView *viewLineH;
    UIButton *butFullMoney;
    UIView *viewLineS;
    UIButton *butFillMoney;
    UIButton *buttonZZC;
    UIButton *butYellowJiao;
    UIButton *butLeftJiao;
    UIButton *butRightJiao;
    
    YYAnimatedImageView *imgView;
    
    UILabel *labelMoneyZhong;
    UILabel *labelTeQuan;
    
    // 详情model
    TWOMyAccountModel *myAccount;
    
    // 初始化判断
    BOOL flagFirst;
    
    // 获取用户信息
    NSMutableDictionary *memberDic;
    
    NSMutableAttributedString *addMoneyString;
    NSMutableAttributedString *butMoneyStr;
    NSMutableAttributedString *butAddStr;
    
    // 刷新loading
    UIImageView *loadingImgView;
    
    // 提交表单loading
    MBProgressHUD *hud;
    
    NSDictionary *menusDic;
    UIButton *butMsgDian;
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
    
    // 可以解决navigation controller子view偏移问题
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getMyAccountInfoFuction) name:@"getMyAccountInfo" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDataOpen) name:@"getMyAccountInviteInfo" object:nil];
    
    [self loadingWithView:self.view loadingFlag:NO height:(HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 53)/2.0 - 50];
    
    flagFirst = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self tabelViewShow];
    
    butBlack = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.tabBarVC.view addSubview:butBlack];
    butBlack.alpha = 0.0;
    butBlack.hidden = YES;
    [butBlack addTarget:self action:@selector(buttonBlackDisappear:) forControlEvents:UIControlEventTouchUpInside];
    
    viewDown = [CreatView creatViewWithFrame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT, WIDTH_CONTROLLER_DEFAULT, 160) backgroundColor:[UIColor huibai]];
    [app.tabBarVC.view addSubview:viewDown];
    
    [self viewDownShow];
    
}

- (void)tabelViewShow
{
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 53 - 20) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = [UIColor lineColor];
        
    }
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 359.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
        
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 568) {
        NSLog(@"5s");
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 344.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
        
    } else {
        
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 330.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    }
    _tableView.tableHeaderView.backgroundColor = [UIColor whiteColor];
    
    [_tableView registerNib:[UINib nibWithNibName:@"TWOMineCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [self.view addSubview:_tableView];
    
    
    [self tableViewHeadShow];
    
    [self arrayShow];
}

- (void)arrayShow
{
    titleArray = @[@[@"我的理财", @"我的特权本金"], @[@"红包卡券", @"我的猴币", @"我的邀请"]];
    imageArray = @[@[@"我的理财", @"tequanbenjin"], @[@"红包卡券", @"我的猴币", @"myInvite"]];
    contentArr = @[@[@"----元在投", @"----元"], @[@"----张", @"----猴币", @"----"]];
}

//tableView头部
- (void)tableViewHeadShow
{
    if (imageBackGround == nil) {
        imageBackGround = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 281.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"我的背景图"]];
        
        if (HEIGHT_CONTROLLER_DEFAULT - 20 == 568) {
            imageBackGround.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 295.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20));
        } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
            imageBackGround.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 310.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20));
        }
        
        imageBackGround.userInteractionEnabled = YES;
        height = imageBackGround.frame.size.height;
        //    让子类自动布局
        imageBackGround.autoresizesSubviews = YES;
    }
    [_tableView.tableHeaderView addSubview:imageBackGround];
    
//    信封按钮
    if (buttEmail == nil) {
        buttEmail = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(14, 30, 23, 23) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
        [buttEmail setBackgroundImage:[UIImage imageNamed:@"email"] forState:UIControlStateNormal];
        [buttEmail setBackgroundImage:[UIImage imageNamed:@"email"] forState:UIControlStateHighlighted];
        buttEmail.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [buttEmail addTarget:self action:@selector(buttonEmailClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    [imageBackGround addSubview:buttEmail];
    
    //消息未读圆点
    if (butMsgDian == nil) {
        butMsgDian = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(buttEmail.frame.size.width - 5, 0, 7, 7) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
        butMsgDian.layer.cornerRadius = 7/2;
        butMsgDian.layer.masksToBounds = YES;
    }
    [buttEmail addSubview:butMsgDian];
    
//    设置按钮
    if (buttonSet == nil) {
        
        buttonSet = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 23 - 14, 30, 23, 23) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
        [buttonSet setBackgroundImage:[UIImage imageNamed:@"myset"] forState:UIControlStateNormal];
        [buttonSet setBackgroundImage:[UIImage imageNamed:@"myset"] forState:UIControlStateHighlighted];
        buttonSet.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [buttonSet addTarget:self action:@selector(buttonSetClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    [_tableView.tableHeaderView addSubview:buttonSet];
    
//    任务中心
    if (viewAlpha == nil) {
        
        viewAlpha = [CreatView creatViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 71, buttonSet.frame.size.height + 23 + 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 71 + 20, 48.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor colorWithRed:33.0 / 225.0 green:125.0 / 225.0 blue:226.0 / 225.0 alpha:1.0]];
        viewAlpha.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        viewAlpha.layer.cornerRadius = 15;
        viewAlpha.layer.masksToBounds = YES;
    }
    [imageBackGround addSubview:viewAlpha];
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        viewAlpha.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT - 71, buttonSet.frame.size.height + 23 + 18.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 71 + 20, 62.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20));
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 568) {
        viewAlpha.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT - 71, buttonSet.frame.size.height + 23 + 18.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 71 + 20, 57.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20));
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 736) {
        viewAlpha.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT - 71, buttonSet.frame.size.height + 30 + 18.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 71 + 20, 43.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20));
    }
    
    if (butTask == nil) {
        
        butTask = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(71/2 - 16, 0, 30, 30) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
        [butTask setBackgroundImage:[UIImage imageNamed:@"renwuzhongxinicon"] forState:UIControlStateNormal];
        [butTask setBackgroundImage:[UIImage imageNamed:@"renwuzhongxinicon"] forState:UIControlStateHighlighted];
        [butTask addTarget:self action:@selector(jobCenterButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    [viewAlpha addSubview:butTask];
    
    if (butTastWen == nil) {
        
        butTastWen = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 30, 71, 12) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"任务中心"];
        butTastWen.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        [butTastWen addTarget:self action:@selector(jobCenterButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    [viewAlpha addSubview:butTastWen];
    
//    任务中心数字显示
    if (labelTestShu == nil) {
        
        labelTestShu = [CreatView creatWithLabelFrame:CGRectMake(butTask.frame.size.width - 3, 3, 13, 13) backgroundColor:[UIColor orangeColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:9] text:[myAccount taskNum]];
        labelTestShu.layer.cornerRadius = 13 / 2;
        labelTestShu.layer.masksToBounds = YES;
    }
    
    [butTask addSubview:labelTestShu];
    if ([[[myAccount taskNum] description] isEqualToString:@""] || [[[myAccount taskNum] description] isEqualToString:@"0"]) {
        labelTestShu.hidden = YES;
    } else {
        labelTestShu.text = [myAccount taskNum];
    }
    
//    充值提现上面的横线
    if (viewLineH == nil) {
        
        viewLineH = [CreatView creatViewWithFrame:CGRectMake(0, imageBackGround.frame.size.height - 1, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor whiteColor]];
        viewLineH.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        viewLineH.alpha = 0.5;
    }
    [imageBackGround addSubview:viewLineH];
    
//    充值按钮
    if (butFullMoney == nil) {
        
        butFullMoney = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, imageBackGround.frame.size.height, WIDTH_CONTROLLER_DEFAULT/2, 49.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor colorWithRed:16.0 / 225.0 green:101.0 / 225.0 blue:205.0 / 225.0 alpha:1.0] textColor:[UIColor whiteColor] titleText:@"充值"];
        butFullMoney.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:16];
        [butFullMoney setImage:[UIImage imageNamed:@"充值"] forState:UIControlStateNormal];
        butFullMoney.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [butFullMoney addTarget:self action:@selector(buttonFullMoney:) forControlEvents:UIControlEventTouchUpInside];
    }
    [_tableView.tableHeaderView addSubview:butFullMoney];
    
//    充值与提现之间的竖线
    if (viewLineS == nil) {
        
        viewLineS = [CreatView creatViewWithFrame:CGRectMake(butFullMoney.frame.size.width - 0.5, 0, 0.5, butFullMoney.frame.size.height) backgroundColor:[UIColor whiteColor]];
        viewLineS.alpha = 0.5;
    }
    [butFullMoney addSubview:viewLineS];
    
//    提现按钮
    if (butFillMoney == nil) {
        
        butFillMoney = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(butFullMoney.frame.size.width, imageBackGround.frame.size.height, WIDTH_CONTROLLER_DEFAULT/2, butFullMoney.frame.size.height) backgroundColor:[UIColor colorWithRed:16.0 / 225.0 green:101.0 / 225.0 blue:205.0 / 225.0 alpha:1.0] textColor:[UIColor whiteColor] titleText:@"提现"];
        butFillMoney.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:16];
        [butFillMoney setImage:[UIImage imageNamed:@"提现"] forState:UIControlStateNormal];
        butFillMoney.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [butFillMoney addTarget:self action:@selector(buttonFillMoney:) forControlEvents:UIControlEventTouchUpInside];
    }
    [_tableView.tableHeaderView addSubview:butFillMoney];
    
//    viewHateLine = [CreatView creatViewWithFrame:CGRectMake(0, -1, WIDTH_CONTROLLER_DEFAULT, 10) backgroundColor:[UIColor clearColor]];
    
    if (butHeadImage == nil) {
        
        butHeadImage = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(150.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 45.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT - ((150.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT) * 2), WIDTH_CONTROLLER_DEFAULT - ((150.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT) * 2)) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
        butHeadImage.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        butHeadImage.layer.cornerRadius = (WIDTH_CONTROLLER_DEFAULT - ((150.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT) * 2))/2;
        butHeadImage.layer.masksToBounds = YES;
        [butHeadImage addTarget:self action:@selector(buttonChangeHeadImage:) forControlEvents:UIControlEventTouchUpInside];
    }
    [imageBackGround addSubview:butHeadImage];
    
    NSLog(@"avatarImg = %@",[memberDic objectForKey:@"avatarImg"]);
    if ([[memberDic objectForKey:@"avatarImg"] isEqualToString:@""] || [memberDic objectForKey:@"avatarImg"] == nil) {
        imgView.hidden = YES;
        [butHeadImage setBackgroundImage:[UIImage imageNamed:@"two默认头像"] forState:UIControlStateNormal];
        [butHeadImage setBackgroundImage:[UIImage imageNamed:@"two默认头像"] forState:UIControlStateHighlighted];
    } else {
        butHeadImage.imageView.yy_imageURL = [NSURL URLWithString:[memberDic objectForKey:@"avatarImg"]];
        if (imgView == nil) {
            imgView = [YYAnimatedImageView new];
            imgView.tag = 4739;
            imgView.frame = CGRectMake(0, 0, butHeadImage.frame.size.width, butHeadImage.frame.size.height);
            imgView.layer.cornerRadius = imgView.frame.size.width/2;
            imgView.layer.masksToBounds = YES;
            imgView.layer.borderColor = [[UIColor pictureColor] CGColor];
            imgView.layer.borderWidth = 2.5;
        }
        imgView.hidden = NO;
        imgView.yy_imageURL = [NSURL URLWithString:[memberDic objectForKey:@"avatarImg"]];
        [butHeadImage addSubview:imgView];
    }
    
//    总资产底层view
    if (viewMoney == nil) {
        
        viewMoney = [CreatView creatViewWithFrame:CGRectMake(0, 143.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 30) backgroundColor:[UIColor clearColor]];
        viewMoney.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    }
    [imageBackGround addSubview:viewMoney];
    
//    总资产钱数
    if (buttMoney == nil) {
        
        buttMoney = [UIButton buttonWithType:UIButtonTypeCustom];
        buttMoney.backgroundColor = [UIColor clearColor];
        buttMoney.tag = 665;
    }
    [viewMoney addSubview:buttMoney];
    
    NSLog(@"myAccount = %@",myAccount);
    
    if (myAccount == nil) {
        addMoneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",@"----"]];
    } else {
        addMoneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",[DES3Util decrypt:[myAccount totalMoney]]]];
    }
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
    if (buttonEye == nil) {
        
        buttonEye = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - moneyButWidth.size.width) * 0.5 + moneyButWidth.size.width, viewMoney.frame.size.height - 19, 21, 21) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
        buttonEye.tag = 10;
        buttonEye.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [buttonEye addTarget:self action:@selector(openEyeOrCloseEye:) forControlEvents:UIControlEventTouchUpInside];
    }
    [viewMoney addSubview:buttonEye];

//    总资产按钮
    if (buttonZZC == nil) {

        buttonZZC = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 25, 142.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + viewMoney.frame.size.height, 50, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"总资产"];
        buttonZZC.tag = 665;
        buttonZZC.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        buttonZZC.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [buttonZZC addTarget:self action:@selector(checkMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    [imageBackGround addSubview:buttonZZC];
    
//    总资产右下角黄色三角按钮
    if (butYellowJiao == nil) {
        
        butYellowJiao = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 25 + 52, 142.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + viewMoney.frame.size.height + 17.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 12, 12) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
        butYellowJiao.tag = 665;
        [butYellowJiao setBackgroundImage:[UIImage imageNamed:@"yellowSanJiao"] forState:UIControlStateNormal];
        [butYellowJiao setBackgroundImage:[UIImage imageNamed:@"yellowSanJiao"] forState:UIControlStateHighlighted];
        butYellowJiao.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [butYellowJiao addTarget:self action:@selector(checkMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    [imageBackGround addSubview:butYellowJiao];
    
//    可用余额钱数
    if (butMoneyYu == nil) {
        
        butMoneyYu = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 142.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + viewMoney.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 14 + 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT/2, 16) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:nil];
        butMoneyYu.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        butMoneyYu.tag = 666;
    }
    [imageBackGround addSubview:butMoneyYu];
    
    if (myAccount == nil) {
        butMoneyStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",@"----"]];
    } else {
        butMoneyStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",[DES3Util decrypt:[myAccount accBalance]]]];
    }
    
    NSRange shuRange = NSMakeRange(0, [[butMoneyStr string] rangeOfString:@"元"].location);
    [butMoneyStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:16] range:shuRange];
    [butMoneyStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:shuRange];
    NSRange yuanRange = NSMakeRange([[butMoneyStr string] length] - 1, 1);
    [butMoneyStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:yuanRange];
    [butMoneyStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:yuanRange];
    [butMoneyYu setAttributedTitle:butMoneyStr forState:UIControlStateNormal];
    [butMoneyYu addTarget:self action:@selector(checkMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
    
//    累计收益钱数
    if (butAddMoney == nil) {
        
        butAddMoney = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2, 142.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + viewMoney.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 14 + 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT/2, 16) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
        butAddMoney.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        butAddMoney.tag = 667;
    }
    [imageBackGround addSubview:butAddMoney];
    
    if (myAccount == nil) {
        butAddStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",@"----"]];
    } else {
        butAddStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",[DES3Util decrypt:[myAccount totalProfit]]]];
    }
    
    NSRange frontRange = NSMakeRange(0, [[butAddStr string] rangeOfString:@"元"].location);
    [butAddStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:16] range:frontRange];
    [butAddStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:frontRange];
    NSRange afterRange = NSMakeRange([[butAddStr string] length] - 1, 1);
    [butAddStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:afterRange];
    [butAddStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:afterRange];
    [butAddMoney setAttributedTitle:butAddStr forState:UIControlStateNormal];
    [butAddMoney addTarget:self action:@selector(checkMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
    
    if (butWenZi == nil) {
        
        //可用剩余&累计收益 文字
        NSArray *titArray = @[@"可用余额", @"累计收益"];
        for (int i = 0; i < 2; i++) {
            butWenZi = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT / 2 * i, 142.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + viewMoney.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 14 + 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 16, WIDTH_CONTROLLER_DEFAULT/2, 25) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:[titArray objectAtIndex:i]];
            [imageBackGround addSubview:butWenZi];
            butWenZi.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
            butWenZi.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:12];
            butWenZi.tag = 666 + i;
            [butWenZi addTarget:self action:@selector(checkMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
//    可用余额三角按钮
    if (butLeftJiao == nil) {
        
        butLeftJiao = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(122.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 142.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + viewMoney.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 14 + 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 16 + 15, 12, 12) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
        butLeftJiao.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [butLeftJiao setBackgroundImage:[UIImage imageNamed:@"baisanjiao"] forState:UIControlStateNormal];
        [butLeftJiao setBackgroundImage:[UIImage imageNamed:@"baisanjiao"] forState:UIControlStateHighlighted];
        butLeftJiao.tag = 666;
        [butLeftJiao addTarget:self action:@selector(checkMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    [imageBackGround addSubview:butLeftJiao];
    
//    累计收益三角按钮
    if (butRightJiao == nil) {
        
        butRightJiao = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 + 122.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 142.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + viewMoney.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 14 + 25.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 16 + 15, 12, 12) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
        butRightJiao.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [butRightJiao setBackgroundImage:[UIImage imageNamed:@"baisanjiao"] forState:UIControlStateNormal];
        [butRightJiao setBackgroundImage:[UIImage imageNamed:@"baisanjiao"] forState:UIControlStateHighlighted];
        butRightJiao.tag = 667;
        [butRightJiao addTarget:self action:@selector(checkMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    [imageBackGround addSubview:butRightJiao];
    
//    读取文件 是闭眼显示还是睁眼显示
    NSDictionary *dicMoney = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"CloseEyes.plist"]];
    if ([[dicMoney objectForKey:@"closeEyes"] isEqualToString:@"YES"]) {
        [buttonEye setImage:[UIImage imageNamed:@"biyan"] forState:UIControlStateNormal];
        [self closeEyes];
    } else {
        [buttonEye setImage:[UIImage imageNamed:@"openEye"] forState:UIControlStateNormal];
        [self openEyes];
    }
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
        if (indexPath.row == 1) {
            
            cell.labelContent.hidden = YES;
            
//            if ([[[myAccount hasNewPrivilege] debugDescription] isEqualToString:@"1"]) {
//                cell.imageRedDian.hidden = NO;
//            } else {
                cell.imageRedDian.hidden = YES;
//            }
        } else {
            
            cell.labelContent.hidden = NO;
            
            cell.imageRedDian.hidden = YES;
        }
    } else {
        
        cell.labelContent.hidden = NO;
        
        if (indexPath.row == 0) {
            
            if ([[DES3Util decrypt:[myAccount redPacketNum]] isEqualToString:@"1"]) {
                cell.imageRedDian.hidden = NO;
            } else {
                cell.imageRedDian.hidden = YES;
            }
        } else if (indexPath.row == 1) {
            
            if ([[[myAccount hasNewMoneky] description] isEqualToString:@"1"]) {
                cell.imageRedDian.hidden = NO;
            } else {
                cell.imageRedDian.hidden = YES;
            }
        } else {
            cell.imageRedDian.hidden = YES;
        }
    }
    
    NSDictionary *dicMoney = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"CloseEyes.plist"]];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.labelContent.tag = 100;
        } else {
            cell.labelContent.tag = 90;
        }
        
        if ([[dicMoney objectForKey:@"closeEyes"] isEqualToString:@"YES"]) {
            if (cell.labelContent.tag == 100) {
                cell.labelContent.text = @"****在投";
            } else if (cell.labelContent.tag == 90) {
                cell.labelContent.text = @"****";
            }
        } else {
            
        }
    }
    
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [MobClick event:@"investrecord"];
            //我的理财
            TWOMyTidyMoneyViewController *tidyMoneyVC = [[TWOMyTidyMoneyViewController alloc] init];
            [self.navigationController pushViewController:tidyMoneyVC animated:YES];
            
        } else {
            [MobClick event:@"mybrokerage"];
            //特权本金开关
            [self teQuanMoneySwitch];
        }
    } else {
        if (indexPath.row == 1) {
            [MobClick event:@"dscoin"];
            //我的猴币
            TWOMyMonkeyCoinViewController *myMonkeyCoinVC = [[TWOMyMonkeyCoinViewController alloc] init];
            [self.navigationController pushViewController:myMonkeyCoinVC animated:YES];
            
        } else if (indexPath.row == 2) {
            [MobClick event:@"invite"];
            //我的邀请
            NewInviteViewController *inviteVC = [[NewInviteViewController alloc] init];
            [self.navigationController pushViewController:inviteVC animated:YES];
            
        } else {
            [MobClick event:@"prize"];
            //红包加息券
            TWORedBagViewController *redBagVC = [[TWORedBagViewController alloc] init];
            pushVC(redBagVC);
        }
    }
}

//任务中心按钮
- (void)jobCenterButton:(UIButton *)button
{
    // 任务中心等于零的时候 隐藏起来
    if ([[[myAccount taskNum] description] isEqualToString:@"0"]) {
        
        labelTestShu.hidden = YES;
    } else {
        
        labelTestShu.hidden = NO;
    }
    
    [MobClick event:@"tasks"];
    
    TWOJobCenterViewController *jobCenterVC = [[TWOJobCenterViewController alloc] init];
    pushVC(jobCenterVC);
}

//睁眼或闭眼按钮
- (void)openEyeOrCloseEye:(UIButton *)button
{
    if (button.tag == 10) {
       
        [self closeEyes];
        //存入本地
        [self closeEyesWriteThisLocality];
        
    } else {
        [self openEyes];
        //睁眼存入本地
        [self openEyesThisLocality];
    }
}

//闭眼走的方法
- (void)closeEyes
{
    labelMoneyZhong = (UILabel *)[self.view viewWithTag:100];
    labelTeQuan = (UILabel *)[self.view viewWithTag:90];
    
    [self closeEyesButton:buttMoney];
    buttMoney.frame = CGRectMake((WIDTH_CONTROLLER_DEFAULT - 60) * 0.5, viewMoney.frame.size.height - viewMoney.frame.size.height/3 - 3, 60, viewMoney.frame.size.height/3);
    //闭眼眼睛的frame
    buttonEye.frame = CGRectMake((WIDTH_CONTROLLER_DEFAULT - 60) * 0.5 + 60, viewMoney.frame.size.height - 22, 21, 21);
    
    [self closeEyesButton:butMoneyYu];
    [self closeEyesButton:butAddMoney];
    
    NSMutableAttributedString *touZiString = [[NSMutableAttributedString alloc] initWithString:@"****在投"];
    NSRange zaiTouRange = NSMakeRange([touZiString length] - 2, 2);
    [touZiString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:zaiTouRange];
    NSRange xingRange = NSMakeRange(0, 4);
    [touZiString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:17] range:xingRange];
    [labelMoneyZhong setAttributedText:touZiString];
    
    labelTeQuan.text = @"****";
    labelTeQuan.font = [UIFont fontWithName:@"CenturyGothic" size:17];
    
    [buttonEye setImage:[UIImage imageNamed:@"biyan"] forState:UIControlStateNormal];
    [buttonEye setImage:[UIImage imageNamed:@"biyan"] forState:UIControlStateHighlighted];
    buttonEye.tag = 20;
}

//睁眼走的方法
- (void)openEyes
{
    labelMoneyZhong = (UILabel *)[self.view viewWithTag:100];
    labelTeQuan = (UILabel *)[self.view viewWithTag:90];

    [self zongMoney];
    [self canMakeMoney];
    [self addMoney];
    
    if (myAccount == nil) {
        labelMoneyZhong.text = [NSString stringWithFormat:@"%@元在投",@"----"];
        labelMoneyZhong.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        
        labelTeQuan.text = [NSString stringWithFormat:@"%@元",@"----"];
        labelTeQuan.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    } else {
        labelMoneyZhong.text = [NSString stringWithFormat:@"%@元在投",[DES3Util decrypt:[myAccount investMoney]]];
        labelMoneyZhong.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        
        labelTeQuan.text = [NSString stringWithFormat:@"%@元",[DES3Util decrypt:[myAccount prlMoney]]];
        labelTeQuan.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    }
    
    [buttonEye setImage:[UIImage imageNamed:@"openEye"] forState:UIControlStateNormal];
    [buttonEye setImage:[UIImage imageNamed:@"openEye"] forState:UIControlStateHighlighted];
    buttonEye.tag = 10;
}

//点击闭眼存入本地
- (void)closeEyesWriteThisLocality
{
    if (![FileOfManage ExistOfFile:@"CloseEyes.plist"]) {
        [FileOfManage createWithFile:@"CloseEyes.plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"YES", @"closeEyes",nil];
        [dic writeToFile:[FileOfManage PathOfFile:@"CloseEyes.plist"] atomically:YES];
    } else {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"YES", @"closeEyes",nil];
        [dic writeToFile:[FileOfManage PathOfFile:@"CloseEyes.plist"] atomically:YES];
    }
}

//点击睁眼存入本地
- (void)openEyesThisLocality
{
    if (![FileOfManage ExistOfFile:@"CloseEyes.plist"]) {
        [FileOfManage createWithFile:@"CloseEyes.plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO", @"closeEyes", nil];
        [dic writeToFile:[FileOfManage PathOfFile:@"CloseEyes.plist"] atomically:YES];
    } else {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO", @"closeEyes", nil];
        [dic writeToFile:[FileOfManage PathOfFile:@"CloseEyes.plist"] atomically:YES];
    }
}

//总资产方法
- (void)zongMoney
{
    if (myAccount == nil) {
        addMoneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",@"----"]];
    } else {
        addMoneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", [DES3Util decrypt:[myAccount totalMoney]]]];
    }
    
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
    if (myAccount == nil) {
        butMoneyStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",@"----"]];
    } else {
        butMoneyStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", [DES3Util decrypt:[myAccount accBalance]]]];
    }

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
    if (myAccount == nil) {
        butAddStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",@"----"]];
    } else {
        butAddStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", [DES3Util decrypt:[myAccount totalProfit]]]];
    }
    
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
    addMoneyString = [[NSMutableAttributedString alloc] initWithString:@"****"];
    NSRange allRange = NSMakeRange(0, 4);
    [addMoneyString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:allRange];
    [addMoneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:30] range:allRange];
    [button setAttributedTitle:addMoneyString forState:UIControlStateNormal];
}

//充值按钮
- (void)buttonFullMoney:(UIButton *)button
{
    [MobClick event:@"recharge"];
    
    TWOMoneyMoreViewController *moneyMoreVC = [[TWOMoneyMoreViewController alloc] init];
    pushVC(moneyMoreVC);
}

//提现按钮
- (void)buttonFillMoney:(UIButton *)button
{
    [MobClick event:@"excash"];
    
    TWOLiftMoneyViewController *liftMoneyVC = [[TWOLiftMoneyViewController alloc] init];
    //余额传值
    liftMoneyVC.moneyString = [DES3Util decrypt:[myAccount accBalance]];
    pushVC(liftMoneyVC);
}

//点击头像按钮
- (void)buttonChangeHeadImage:(UIButton *)button
{

    [UIView animateWithDuration:0.3f animations:^{
        butBlack.alpha = 0.5;
        butBlack.hidden = NO;
        viewDown.frame = CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT - 180, WIDTH_CONTROLLER_DEFAULT, 160);
    } completion:^(BOOL finished) {
        
    }];
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
    
    UIButton *butCancle = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 110, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor] textColor:[UIColor profitColor] titleText:@"取消"];
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
    [UIView animateWithDuration:0.3f animations:^{
        butBlack.alpha = 0.0;
        viewDown.frame = CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT, WIDTH_CONTROLLER_DEFAULT, 160);
    } completion:^(BOOL finished) {
        butBlack.hidden = YES;
    }];
    
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
    [UIView animateWithDuration:0.3f animations:^{
        butBlack.alpha = 0.0;
        viewDown.frame = CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT, WIDTH_CONTROLLER_DEFAULT, 160);
    } completion:^(BOOL finished) {
        butBlack.hidden = YES;
    }];
    
    NSLog(@"从相册选择");
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
    }
    
    pickerImage.delegate = self;
    
    pickerImage.navigationBar.barTintColor = [UIColor profitColor];
    
    pickerImage.allowsEditing = YES;
    [self presentViewController:pickerImage animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    butHeadImage = (UIImageView *)[self.view viewWithTag:9908];
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage* original_image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    UIImage* image = [info objectForKey: @"UIImagePickerControllerEditedImage"];
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
    
    if (original_image == nil && image == nil) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"亲，只能选择图片哦~!"];
        return;
    }
    
    if (image == nil) {
        
        NSLog(@"originalImage");
        
        [self saveImage:original_image withName:@"currentImage.png"];
        
        NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
        
        UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
        
        //    [butHeadImage setImage:savedImage];
        imgView.image = savedImage;
        [butHeadImage setBackgroundImage:savedImage forState:UIControlStateNormal];
        
        [[MyAfHTTPClient sharedClient] uploadFile:savedImage];
        
    } else {
        
        NSLog(@"editedImage");
        
        [self saveImage:image withName:@"currentImage_new.png"];
        
        NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage_new.png"];
        
        UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
        
        //    [butHeadImage setImage:savedImage];
        imgView.image = savedImage;
        [butHeadImage setBackgroundImage:savedImage forState:UIControlStateNormal];
        
        [[MyAfHTTPClient sharedClient] uploadFile:savedImage];
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    NSLog(@"123");
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
    
    [UIView animateWithDuration:0.3f animations:^{
        butBlack.alpha = 0.0;
        viewDown.frame = CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT, WIDTH_CONTROLLER_DEFAULT, 160);
    } completion:^(BOOL finished) {
        butBlack.hidden = YES;
    }];
}

//黑色遮罩层消失
- (void)buttonBlackDisappear:(UIButton *)button
{
    
    [UIView animateWithDuration:0.3f animations:^{
        butBlack.alpha = 0.0;
        viewDown.frame = CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT, WIDTH_CONTROLLER_DEFAULT, 160);
    } completion:^(BOOL finished) {
        butBlack.hidden = YES;
    }];
}

//信封按钮
- (void)buttonEmailClicked:(UIButton *)button
{
    [MobClick event:@"news"];
    
    TWOMessageCenterViewController *messageCenterVC = [[TWOMessageCenterViewController alloc] init];
    pushVC(messageCenterVC);
}

//设置按钮
- (void)buttonSetClicked:(UIButton *)button
{
    [MobClick event:@"set"];
    
    TWOPersonalSetViewController *personalSetVC = [[TWOPersonalSetViewController alloc] init];
    personalSetVC.whoAreYou = [[myAccount inviteType] description];
    [self.navigationController pushViewController:personalSetVC animated:YES];
}

//总资产&可用余额&累计收益查看
- (void)checkMoneyButton:(UIButton *)button
{
    if (button.tag == 665) {
        
        //总资产
        TWOMyMoneyViewController *myMoneyVC = [[TWOMyMoneyViewController alloc] init];
        [self.navigationController pushViewController:myMoneyVC animated:YES];
        
    } else if (button.tag == 666) {
        
        [MobClick event:@"remainingmoney"];
        
        //可用余额
        TWOUsableMoneyViewController *usableMoneyVC = [[TWOUsableMoneyViewController alloc] init];
        usableMoneyVC.whichOne = YES;
        usableMoneyVC.moneyString = [myAccount accBalance];
        pushVC(usableMoneyVC);
        
    } else {
        
        [MobClick event:@"totalprofits"];
        
        // 累计收益
        TWOAddIncomeViewController *addIncomeVC = [[TWOAddIncomeViewController alloc] init];
        [self.navigationController pushViewController:addIncomeVC animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat offSet = scrollView.contentOffset.y;
    
//    if (offSet < 0) {
//        
//        imageBackGround.contentMode = UIViewContentModeScaleAspectFill;
//        CGRect frame = imageBackGround.frame;
//        frame.origin.y = offSet;
//        frame.size.height = height - offSet;
//        imageBackGround.frame = frame;
//    }
    
    if (scrollView.contentOffset.y < 0) {
        _tableView.scrollEnabled = NO;
    } else {
        _tableView.scrollEnabled = YES;
    }
}

#pragma mark 我的账户详情
#pragma mark --------------------------------

- (void)getMyAccountInfoFuction{
    
//    [self loadingWithheight:(HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 53)/2.0 - 50 + 64];
    
    memberDic = [NSMutableDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parmeter = @{@"token":[memberDic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"user/getMyAccountInfo" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"getMyAccountInfo = %@",responseObject);
        
        [self loadingWithHidden:YES];
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            myAccount = [[TWOMyAccountModel alloc] init];
            [myAccount setValuesForKeysWithDictionary:responseObject];
            
            NSMutableArray *newContentArr = [contentArr mutableCopy];
            NSMutableArray *contentArray = [NSMutableArray array];
            NSMutableArray *contentArrayOld = [NSMutableArray array];
            
            [contentArrayOld addObject:[NSString stringWithFormat:@"%@元在投",[DES3Util decrypt:[myAccount investMoney]]]];
            [contentArrayOld addObject:[NSString stringWithFormat:@"%@元",[DES3Util decrypt:[myAccount prlMoney]]]];
            
            if ([[myAccount redPacketNum] isEqualToString:@""] || [[myAccount incrUnUsedCount] isEqualToString:@""]) {
                [contentArray addObject:[NSString stringWithFormat:@"----张"]];
            } else {
                [contentArray addObject:[NSString stringWithFormat:@"%ld张",(long)[[myAccount redPacketNum] integerValue] + (long)[[myAccount incrUnUsedCount] integerValue]]];
            }
            [contentArray addObject:[NSString stringWithFormat:@"%@猴币",[DES3Util decrypt:[myAccount monkeyNum]]]];
            if (menusDic == nil || [[menusDic objectForKey:@"menuRemark"] isEqualToString:@""]) {
                
                [contentArray addObject:@"----"];
            } else {
                
                [contentArray addObject:[menusDic objectForKey:@"menuRemark"]];
            }
#warning 千万别忘了
            [newContentArr replaceObjectAtIndex:0 withObject:contentArrayOld];
            [newContentArr replaceObjectAtIndex:1 withObject:contentArray];
            contentArr = newContentArr;
            
            [_tableView reloadData];
            
            [self tableViewHeadShow];
            
            //判断是否有原点
            if ([[[myAccount unReadNum] description] isEqualToString:@"0"]) {
                butMsgDian.backgroundColor = [UIColor clearColor];
            } else {
                butMsgDian.backgroundColor = [UIColor orangecolor];
            }
            
            NSLog(@"00000----%@",[myAccount invitationMyCode]);
            
            [memberDic setObject:[myAccount accBalance] forKey:@"accBalance"];
            
            [memberDic setObject:[myAccount invitationMyCode] forKey:@"invitationMyCode"];
            
            [memberDic writeToFile:[FileOfManage PathOfFile:@"Member.plist"] atomically:YES];
            
        }
        flagFirst = YES;
     
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

- (void)loadingWithheight:(CGFloat)heightO
{
    NSMutableArray *imgArray = [NSMutableArray array];
    
    if (loadingImgView == nil) {
        
        loadingImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        
        loadingImgView.tag = 9098;
        
        if (WIDTH_CONTROLLER_DEFAULT == 320) {
            loadingImgView.center = CGPointMake(160, heightO);
        } else {
            loadingImgView.center = CGPointMake(self.view.center.x + 5, heightO);
        }
    
        for (NSInteger i = 1; i <= 7; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"TWO_Loading_Middle_0%ld",(long)i]];
            [imgArray addObject:image];
        }
        
        loadingImgView.animationImages = imgArray;
        
        loadingImgView.animationDuration = 1.0;
        
        loadingImgView.animationRepeatCount = 0;
        
        [loadingImgView startAnimating];
        
    }
    
    [self.view addSubview:loadingImgView];
    
    loadingImgView.hidden = NO;
}

//特权本金开关
#pragma mark teQuanMoney~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)teQuanMoneySwitch
{
    NSDictionary *parmeter = @{@"key":@"privilege"};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"sys/sysSwitch" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"特权本金开关********%@", responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:201]]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"waitMoment" object:nil];
            
        } else if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            //我的特权本金
            TWOMyPrerogativeMoneyViewController *myPrerogativeMoneyVC = [[TWOMyPrerogativeMoneyViewController alloc] init];
            [self.navigationController pushViewController:myPrerogativeMoneyVC animated:YES];
            
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)loadingWithHiddenTwo:(BOOL)hidden{
    loadingImgView.hidden = hidden;
}

//获取系统菜单列表
- (void)getDataOpen
{
    memberDic = [NSMutableDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parameter = @{@"menuCode":@"myInvitation",@"token":[memberDic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"sys/getSysMenuList" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"&*&*&*&*&*&*%@", responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            menusDic = [[responseObject objectForKey:@"Menus"] firstObject];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"wwwwwwwwwwwwwwwwwwwwwwwwww%@", error);
    }];
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
