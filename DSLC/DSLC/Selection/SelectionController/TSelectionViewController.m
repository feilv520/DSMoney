//
//  TSelectionViewController.m
//  DSLC
//
//  Created by ios on 16/3/14.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TSelectionViewController.h"
#import "NewBieCell.h"
#import "FinancingCell.h"
#import "UIColor+AddColor.h"
#import "define.h"
#import "MyAfHTTPClient.h"
#import "AdModel.h"
#import "BannerViewController.h"
#import "ProductListModel.h"
#import "TSignInViewController.h"
#import "TBigTurntableViewController.h"
#import "TRankinglistViewController.h"
#import "TthreeRunCell.h"
#import "SafeProtectViewController.h"
#import "MillionsAndMillionsRiskMoney.h"
#import "NewHandGuide.h"
#import "BillCell.h"
#import "MDRadialProgressTheme.h"
#import "FDetailViewController.h"

@interface TSelectionViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

{
    UITableView *_tableView;
    NSMutableArray *photoArray;
    UIPageControl *pageControl;
    NSTimer *timer;
    UIScrollView *bannerScrollView;
    UIScrollView *backgroundScrollView;
    ProductListModel *productM;
    UIButton *butActivity;
    UIButton *buttonAct;
    NSMutableArray *newArray;
    NSDictionary *tempDic;
    
    UIView *viewScroll;
    
    NSDictionary *flagDic;
    NSDictionary *myDic;
}

@end

@implementation TSelectionViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    photoArray = [NSMutableArray array];
    newArray = [NSMutableArray array];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(scrollViewFuction) userInfo:nil repeats:YES];
    
    // 修改timer的优先级与控件一致
    // 获取当前的消息循环对象
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    // 更改timer对象的优先级
    [runLoop addTimer:timer forMode:NSRunLoopCommonModes];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPickProduct) name:@"refrushToPickProduct" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLoginView) name:@"showLoginView" object:nil];
    
    backgroundScrollView.hidden = YES;
    [self loadingWithView:self.view loadingFlag:NO height:self.view.frame.size.height/2];
    
    [self getPickProduct];
    
}

- (void)tableViewShow
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50) style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor qianhuise];
        _tableView.separatorColor = [UIColor clearColor];
        
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 185 + ((WIDTH_CONTROLLER_DEFAULT - 80) - 100)/3 + 15)];
        _tableView.tableHeaderView.backgroundColor = [UIColor qianhuise];
        
        [_tableView registerNib:[UINib nibWithNibName:@"NewBieCell" bundle:nil] forCellReuseIdentifier:@"reuseNew"];
        [_tableView registerNib:[UINib nibWithNibName:@"TthreeRunCell" bundle:nil] forCellReuseIdentifier:@"reuseThree"];
        [_tableView registerNib:[UINib nibWithNibName:@"BillCell" bundle:nil] forCellReuseIdentifier:@"reuse000"];

        [self viewHeadShow];
        
        [self getAdvList];
        
    }
}

- (void)viewHeadShow
{
    CGFloat widthPlus = WIDTH_CONTROLLER_DEFAULT - 80;
    CGFloat butWidth = (widthPlus - 100)/4;
    NSArray *butImageArr = @[@"icon1", @"target-arrow", @"icon3", @"icon3"];
    NSArray *butWiteArr = @[@"签到", @"大转盘", @"排行榜", @"大奖池"];
    
    for (int i = 0; i < 4; i++) {
        
        butActivity = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(30 + butWidth * i + 40 * i, 185, butWidth, butWidth) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
        [_tableView.tableHeaderView addSubview:butActivity];
        [butActivity setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [butImageArr objectAtIndex:i]]] forState:UIControlStateNormal];
        butActivity.tag = 6000 + i;
        [butActivity addTarget:self action:@selector(buttonActivityShow:) forControlEvents:UIControlEventTouchUpInside];
        
        buttonAct = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(30 + butWidth * i + 40 * i, 185 + butWidth, butWidth, 25) backgroundColor:[UIColor qianhuise] textColor:[UIColor zitihui] titleText:[butWiteArr objectAtIndex:i]];
        [_tableView.tableHeaderView addSubview:buttonAct];
        buttonAct.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        buttonAct.tag = 7000 + i;
        [buttonAct addTarget:self action:@selector(buttonActivityShow:) forControlEvents:UIControlEventTouchUpInside];
        
        if (WIDTH_CONTROLLER_DEFAULT == 320) {
            
            buttonAct.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:11];
        }
    }
    
//    轮播位置
    viewScroll = [CreatView creatViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 170) backgroundColor:[UIColor qianhuise]];
    [_tableView.tableHeaderView addSubview:viewScroll];
    
//    _tableView.tableHeaderView.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 185 + butWidth + 35);
}

//活动三个按钮 签到 大转盘 排行榜
- (void)buttonActivityShow:(UIButton *)button
{
    flagDic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"isLogin.plist"]];
    myDic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    if (button.tag == 6000 || button.tag == 7000) {
        if ([[flagDic objectForKey:@"loginFlag"] isEqualToString:@"NO"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showLoginView" object:nil];
            return ;
        }
        
        TSignInViewController *signInVC = [[TSignInViewController alloc] init];
        signInVC.tokenString = [myDic objectForKey:@"token"];
        [self.navigationController pushViewController:signInVC animated:YES];
        
    } else if (button.tag == 6001 || button.tag == 7001) {
        if ([[flagDic objectForKey:@"loginFlag"] isEqualToString:@"NO"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showLoginView" object:nil];
            return ;
        }
        
        TBigTurntableViewController *bigTurntable = [[TBigTurntableViewController alloc] init];
        bigTurntable.tokenString = [myDic objectForKey:@"token"];
        [self.navigationController pushViewController:bigTurntable animated:YES];
        
    } else {
        
        TRankinglistViewController *rankinglist = [[TRankinglistViewController alloc] init];
        [self.navigationController pushViewController:rankinglist animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 209;
        
    } else if (indexPath.section == 3) {
        
        return 90;
        
    } else {
        
        return 126;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        
        return 10;
        
    } else {
        
        return 0.5;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        NewBieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseNew"];
        cell.backgroundColor = [UIColor qianhuise];
        
        cell.viewBottom.layer.cornerRadius = 5;
        cell.viewBottom.layer.masksToBounds = YES;
        cell.viewBottom.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
        cell.viewBottom.layer.borderWidth = 1;
        cell.viewBottom.backgroundColor = [UIColor whiteColor];
        
        cell.viewLine.backgroundColor = [UIColor grayColor];
        cell.viewLine.alpha = 0.1;
        
        productM = [newArray objectAtIndex:indexPath.section];
        
        cell.labelPercent.textColor = [UIColor daohanglan];
        cell.labelPercent.font = [UIFont fontWithName:@"ArialMT" size:45];
        cell.labelPercent.text = productM.productAnnualYield;
        
        cell.labelShouYiLv.text = @"预期年化(%)";
        cell.labelShouYiLv.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        
        [cell.buttonImage setImage:[UIImage imageNamed:@"liwu"] forState:UIControlStateNormal];
        if ([productM.productType isEqualToString:@"3"]) {
            [cell.buttonImage setTitle:@" 新手专享" forState:UIControlStateNormal];
        } else {
            [cell.buttonImage setTitle:[NSString stringWithFormat:@" %@",productM.productName] forState:UIControlStateNormal];
        }
        [cell.buttonImage setTitleColor:[UIColor daohanglan] forState:UIControlStateNormal];
        cell.buttonImage.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        cell.buttonImage.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
        cell.labelLeftUp.text = productM.productPeriod;
        cell.labelLeftUp.font = [UIFont fontWithName:@"ArialMT" size:20];
        
        cell.labelLeftRight.text = @"理财期限(天)";
        cell.labelLeftRight.textColor = [UIColor zitihui];
        cell.labelLeftRight.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.labelMidUp.text = [NSString stringWithFormat:@"%.1lf",[productM.residueMoney floatValue] / 10000];
        cell.labelMidUp.font = [UIFont fontWithName:@"ArialMT" size:20];
        
        cell.labelMidDOwn.text = @"剩余总额(万元)";
        cell.labelMidDOwn.textColor = [UIColor zitihui];
        cell.labelMidDOwn.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.labelRightUp.text = productM.productAmountMin;
        cell.labelRightUp.font = [UIFont fontWithName:@"ArialMT" size:20];
        
        cell.labelDownRight.text = @"起投资金(元)";
        cell.labelDownRight.textColor = [UIColor zitihui];
        cell.labelDownRight.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else if (indexPath.section == 3) {
        
        TthreeRunCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseThree"];
        cell.backgroundColor = [UIColor qianhuise];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.viewBottom.layer.cornerRadius = 5;
        cell.viewBottom.layer.masksToBounds = YES;
        cell.viewBottom.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
        cell.viewBottom.layer.borderWidth = 1;
        
        [cell.buttonSafe setBackgroundImage:[UIImage imageNamed:@"shouyeqiepian_03"] forState:UIControlStateNormal];
        [cell.buttonSafe setBackgroundImage:[UIImage imageNamed:@"shouyeqiepian_03"] forState:UIControlStateHighlighted];
        cell.buttonSafe.tag = 900;
        [cell.buttonSafe addTarget:self action:@selector(buttonRunClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.butRiskMoney setBackgroundImage:[UIImage imageNamed:@"shouyeqiepian_05"] forState:UIControlStateNormal];
        [cell.butRiskMoney setBackgroundImage:[UIImage imageNamed:@"shouyeqiepian_05"] forState:UIControlStateHighlighted];
        cell.butRiskMoney.tag = 910;
        [cell.butRiskMoney addTarget:self action:@selector(buttonRunClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.buttonNew setBackgroundImage:[UIImage imageNamed:@"shouyeqiepian_07"] forState:UIControlStateNormal];
        [cell.buttonNew setBackgroundImage:[UIImage imageNamed:@"shouyeqiepian_07"] forState:UIControlStateHighlighted];
        cell.buttonNew.tag = 920;
        [cell.buttonNew addTarget:self action:@selector(buttonRunClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.buttonOne setTitle:@"安全保障" forState:UIControlStateNormal];
        [cell.buttonOne setTitleColor:[UIColor zitihui] forState:UIControlStateNormal];
        cell.buttonOne.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        cell.buttonOne.tag = 930;
        [cell.buttonOne addTarget:self action:@selector(buttonRunClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.buttonTwo setTitle:@"千万风险金" forState:UIControlStateNormal];
        [cell.buttonTwo setTitleColor:[UIColor zitihui] forState:UIControlStateNormal];
        cell.buttonTwo.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        cell.buttonTwo.tag = 940;
        [cell.buttonTwo addTarget:self action:@selector(buttonRunClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.buttonThree setTitle:@"新手指南" forState:UIControlStateNormal];
        [cell.buttonThree setTitleColor:[UIColor zitihui] forState:UIControlStateNormal];
        cell.buttonThree.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        cell.buttonThree.tag = 950;
        [cell.buttonThree addTarget:self action:@selector(buttonRunClick:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    } else {
        
        BillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse000"];
        cell.backgroundColor = [UIColor qianhuise];
        
        cell.viewLine1.backgroundColor = [UIColor grayColor];
        cell.viewLine1.alpha = 0.1;
        
        cell.labelLeftDown.text = @"预期年化(%)";
        cell.labelLeftDown.textColor = [UIColor zitihui];
        cell.labelLeftDown.textAlignment = NSTextAlignmentCenter;
        
        productM = [newArray objectAtIndex:indexPath.section];
        
        NSString *monthStr = [productM.productName substringWithRange:NSMakeRange(0, [productM.productName rangeOfString:@"个"].location)];
        
        [cell.buttonRed setTitle:monthStr forState:UIControlStateNormal];
        [cell.buttonRed setBackgroundImage:[UIImage imageNamed:@"圆角矩形-2"] forState:UIControlStateNormal];
        
        NSString *lastStr = [productM.productName substringWithRange:NSMakeRange([productM.productName rangeOfString:@"个"].location, productM.productName.length - monthStr.length)];
        
        cell.labelQiTou.text = [NSString stringWithFormat:@"%@元起投",productM.productAmountMin];
        cell.labelQiTou.textColor = [UIColor zitihui];
        cell.labelQiTou.font = [UIFont fontWithName:@"CenturyGothic" size:11];
        cell.labelQiTou.textAlignment = NSTextAlignmentRight;
        cell.labelQiTou.backgroundColor = [UIColor greenColor];
        
        cell.labelMonth.text = lastStr;
        cell.labelMonth.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        
        cell.labelQiTou.text = [NSString stringWithFormat:@"%@元起投", productM.productAmountMin];
        cell.labelQiTou.textColor = [UIColor zitihui];
        cell.labelQiTou.font = [UIFont fontWithName:@"CenturyGothic" size:11];
        cell.labelQiTou.textAlignment = NSTextAlignmentRight;
        cell.labelQiTou.hidden = YES;
        
        cell.labelLeftUp.text = productM.productAnnualYield;
        cell.labelLeftUp.textColor = [UIColor daohanglan];
        cell.labelLeftUp.font = [UIFont fontWithName:@"ArialMT" size:20];
        
        cell.labelMidDown.text = @"理财期限(天)";
        cell.labelMidDown.textAlignment = NSTextAlignmentCenter;
        cell.labelMidDown.textColor = [UIColor zitihui];
        
        cell.labelMidUp.text = productM.productPeriod;
        cell.labelMidUp.font = [UIFont fontWithName:@"ArialMT" size:20];
        
        cell.quanView.progressTotal = [productM.productInitLimit floatValue];
        if ([productM.productInitLimit isEqualToString:productM.residueMoney]) {
            cell.quanView.progressCounter = 1;
        } else {
            cell.quanView.progressCounter = [productM.productInitLimit floatValue] - [productM.residueMoney floatValue];
        }
        cell.quanView.theme.sliceDividerHidden = YES;
        
        if (WIDTH_CONTROLLER_DEFAULT == 320) {
            
            cell.labelLeftDown.font = [UIFont fontWithName:@"CenturyGothic" size:10];
            cell.labelMidDown.font = [UIFont fontWithName:@"CenturyGothic" size:10];
            
        } else {
            
            cell.labelLeftDown.font = [UIFont fontWithName:@"CenturyGothic" size:10];
            cell.labelMidDown.font = [UIFont fontWithName:@"CenturyGothic" size:10];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FDetailViewController *detailVC = [[FDetailViewController alloc] init];
    detailVC.estimate = YES;
    detailVC.pandaun = YES;
    detailVC.idString = [[newArray objectAtIndex:indexPath.section] productId];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)buttonRunClick:(UIButton *)button
{
    if (button.tag == 900 || button.tag == 930) {
        
        SafeProtectViewController *safeVC = [[SafeProtectViewController alloc] init];
        [self.navigationController pushViewController:safeVC animated:YES];
        
    } else if (button.tag == 910 || button.tag == 940) {
        
        MillionsAndMillionsRiskMoney *millionVC = [[MillionsAndMillionsRiskMoney alloc] init];
        [self.navigationController pushViewController:millionVC animated:YES];
        
    } else {
        
        NewHandGuide *newHand = [[NewHandGuide alloc] init];
        [self.navigationController pushViewController:newHand animated:YES];
    }
}

- (void)scrollViewFuction{
    
    [bannerScrollView setContentOffset:CGPointMake((pageControl.currentPage + 2) * WIDTH_CONTROLLER_DEFAULT, 0) animated:YES];
    
    if (pageControl == nil) {
        pageControl.currentPage = 0;
    } else {
        pageControl.currentPage += 1;
    }
    
}

// 广告滚动控件
- (void)makeScrollView{
    NSInteger photoIndex = photoArray.count + 2;
    
    bannerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 170)];
    bannerScrollView.backgroundColor = Color_Clear;
    bannerScrollView.contentSize = CGSizeMake(WIDTH_CONTROLLER_DEFAULT * photoIndex,0);
    bannerScrollView.contentOffset = CGPointMake(WIDTH_CONTROLLER_DEFAULT, 0);
    bannerScrollView.showsHorizontalScrollIndicator = NO;
    bannerScrollView.showsVerticalScrollIndicator = NO;
    bannerScrollView.pagingEnabled = YES;
    
    bannerScrollView.delegate = self;
    
    [viewScroll addSubview:bannerScrollView];
    
    YYAnimatedImageView *bannerFirst = [YYAnimatedImageView new];
    bannerFirst.yy_imageURL = [NSURL URLWithString:[[photoArray objectAtIndex:0] adImg]];
    bannerFirst.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * (photoArray.count + 1), 0, WIDTH_CONTROLLER_DEFAULT, 180);
    
    YYAnimatedImageView *bannerLast = [YYAnimatedImageView new];
    bannerLast.yy_imageURL = [NSURL URLWithString:[[photoArray objectAtIndex:photoArray.count - 1] adImg]];
    bannerLast.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 180);
    
    for (NSInteger i = 0; i < photoArray.count; i++) {
        YYAnimatedImageView *bannerObject = [YYAnimatedImageView new];
        bannerObject.yy_imageURL = [NSURL URLWithString:[[photoArray objectAtIndex:i] adImg]];
        bannerObject.tag = i;
        bannerObject.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * (i + 1), 0, WIDTH_CONTROLLER_DEFAULT, 180);
        UITapGestureRecognizer *tapLeft = [[UITapGestureRecognizer alloc] init];
        [bannerObject addGestureRecognizer:tapLeft];
        [tapLeft addTarget:self action:@selector(bannerObject:)];
        bannerObject.userInteractionEnabled = YES;
        
        //手指数
        tapLeft.numberOfTouchesRequired = 1;
        //点击次数
        tapLeft.numberOfTapsRequired = 1;
        
        [bannerScrollView addSubview:bannerObject];
    }
    
    [bannerScrollView addSubview:bannerFirst];
    [bannerScrollView addSubview:bannerLast];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 150, WIDTH_CONTROLLER_DEFAULT, 30)];
    
    pageControl.numberOfPages = photoArray.count;
    pageControl.currentPage = 0;
    
    [self changePageControlImage];
    
    [viewScroll addSubview:pageControl];
    
}

// 滚动后的执行方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (bannerScrollView == scrollView) {
        CGPoint offset = [scrollView contentOffset];
        
        //更新UIPageControl的当前页
        CGRect bounds = scrollView.frame;
        [pageControl setCurrentPage:offset.x / bounds.size.width - 1];
        
        if (offset.x == WIDTH_CONTROLLER_DEFAULT * (photoArray.count + 1)) {
            [bannerScrollView setContentOffset:CGPointMake(WIDTH_CONTROLLER_DEFAULT, 0) animated:NO];
            pageControl.currentPage = 0;
        } else if (offset.x == 0) {
            [bannerScrollView setContentOffset:CGPointMake(WIDTH_CONTROLLER_DEFAULT * photoArray.count, 0) animated:NO];
            pageControl.currentPage = photoArray.count - 1;
        }
    }
}

// 准备滚动时候的执行方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [timer invalidate];
    // 调用invalidate方法后,对象已经无法使用,所以要指向nil.
    timer = nil;
}

- (void)bannerObject:(UITapGestureRecognizer *)tap
{
    //    if (pageControl.currentPage == 4) {
    //        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"本连接不支持app端"];
    //        return;
    //    }
    BannerViewController *bannerVC = [[BannerViewController alloc] init];
    bannerVC.photoName = [[photoArray objectAtIndex:pageControl.currentPage] adLabel];
    bannerVC.photoUrl = [[photoArray objectAtIndex:pageControl.currentPage] adLink];
    bannerVC.page = pageControl.currentPage;
    pushVC(bannerVC);
}

// 拖住完成的执行方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(scrollViewFuction) userInfo:nil repeats:YES];
    
    // 修改timer的优先级与控件一致
    // 获取当前的消息循环对象
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    // 更改timer对象的优先级
    [runLoop addTimer:timer forMode:NSRunLoopCommonModes];
    
}

//改变pagecontrol中圆点样式
- (void)changePageControlImage
{
    static UIImage *imgCurrent = nil;
    static UIImage *imgOther = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        imgCurrent = [UIImage imageNamed:@"banner_red"];
        imgOther = [UIImage imageNamed:@"banner_black"];
    });
    
    
    if (iOS7) {
        [pageControl setValue:imgCurrent forKey:@"_currentPageImage"];
        [pageControl setValue:imgOther forKey:@"_pageImage"];
    } else {
        for (int i = 0;i < 3; i++) {
            UIImageView *imageVieW = [pageControl.subviews objectAtIndex:i];
            imageVieW.frame = CGRectMake(imageVieW.frame.origin.x, imageVieW.frame.origin.y, 20, 20);
            imageVieW.image = pageControl.currentPage == i ? imgCurrent : imgOther;
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    CGPoint offset = [scrollView contentOffset];
    
    if (offset.x == WIDTH_CONTROLLER_DEFAULT * (photoArray.count + 1)) {
        [bannerScrollView setContentOffset:CGPointMake(WIDTH_CONTROLLER_DEFAULT, 0) animated:NO];
        pageControl.currentPage = 0;
    } else if (offset.x == 0) {
        [bannerScrollView setContentOffset:CGPointMake(WIDTH_CONTROLLER_DEFAULT * photoArray.count, 0) animated:NO];
        pageControl.currentPage = photoArray.count - 1;
    }
}

- (void)getAdvList{
    
    NSDictionary *parmeter = @{@"adType":@"2",@"adPosition":@"3"};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/adv/getAdvList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"AD = %@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:500]]) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            return ;
        }
        
        pageControl.numberOfPages = [[responseObject objectForKey:@"Advertise"] count];
        
        if (photoArray != nil) {
            [photoArray removeAllObjects];
            photoArray = nil;
            photoArray = [NSMutableArray array];
        }
        
        
        
        for (NSDictionary *dic in [responseObject objectForKey:@"Advertise"]) {
            AdModel *adModel = [[AdModel alloc] init];
            [adModel setValuesForKeysWithDictionary:dic];
            [photoArray addObject:adModel];
        }
        
        [self loadingWithHidden:YES];
        [self makeScrollView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

- (void)getPickProduct{
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/product/getPickProductTwo" parameters:nil success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"首页%@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:500]]) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            return ;
        }
        
        [self loadingWithHidden:YES];
        
        backgroundScrollView.hidden = NO;
        
        NSArray *dataArr = [responseObject objectForKey:@"Product"];
        for (tempDic in dataArr) {
            
            productM = [[ProductListModel alloc] init];
            [productM setValuesForKeysWithDictionary:tempDic];
            [newArray addObject:productM];
        }
        
        [self tableViewShow];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

#pragma mark 显示登录界面
#pragma mark --------------------------------

- (void)showLoginView{
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
