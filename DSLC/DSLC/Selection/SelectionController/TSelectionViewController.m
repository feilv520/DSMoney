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
    
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(scrollViewFuction) userInfo:nil repeats:YES];
    
    // 修改timer的优先级与控件一致
    // 获取当前的消息循环对象
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    // 更改timer对象的优先级
    [runLoop addTimer:timer forMode:NSRunLoopCommonModes];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPickProduct) name:@"refrushToPickProduct" object:nil];
//    backgroundScrollView.hidden = YES;
    
    [self tableViewShow];
    [self viewHeadShow];
//    [self getAdvList];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor qianhuise];
    
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 260)];
    _tableView.tableHeaderView.backgroundColor = [UIColor qianhuise];
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    _tableView.tableFooterView.backgroundColor = [UIColor magentaColor];
    
    [_tableView registerNib:[UINib nibWithNibName:@"NewBieCell" bundle:nil] forCellReuseIdentifier:@"reuseNew"];
    [_tableView registerNib:[UINib nibWithNibName:@"FinancingCell" bundle:nil] forCellReuseIdentifier:@"reuse000"];
}

- (void)viewHeadShow
{
    CGFloat widthPlus = self.view.frame.size.width - 60;
    CGFloat butWidth = (widthPlus - 80)/3;
    NSArray *butImageArr = @[@"icon1", @"target-arrow", @"icon3"];
    NSArray *butWiteArr = @[@"签到", @"大转盘", @"排行榜"];
    
    for (int i = 0; i < 3; i++) {
        
        butActivity = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(30 + butWidth * i + 40 * i, 150, butWidth, butWidth) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
        [_tableView.tableHeaderView addSubview:butActivity];
        [butActivity setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [butImageArr objectAtIndex:i]]] forState:UIControlStateNormal];
        butActivity.tag = 6000 + i;
        [butActivity addTarget:self action:@selector(buttonActivityShow:) forControlEvents:UIControlEventTouchUpInside];
        
        buttonAct = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(30 + butWidth * i + 40 * i, 150 + butWidth, butWidth, 40) backgroundColor:[UIColor qianhuise] textColor:[UIColor zitihui] titleText:[butWiteArr objectAtIndex:i]];
        [_tableView.tableHeaderView addSubview:buttonAct];
        buttonAct.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        buttonAct.tag = 7000 + i;
        [buttonAct addTarget:self action:@selector(buttonActivityShow:) forControlEvents:UIControlEventTouchUpInside];
    }
}

//活动三个按钮 签到 大转盘 排行榜
- (void)buttonActivityShow:(UIButton *)button
{
    if (button.tag == 6000 || button.tag == 7000) {
        
        TSignInViewController *signInVC = [[TSignInViewController alloc] init];
        [self.navigationController pushViewController:signInVC animated:YES];
        
    } else if (button.tag == 6001 || button.tag == 7001) {
        
        TBigTurntableViewController *bigTurntable = [[TBigTurntableViewController alloc] init];
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
        
    } else {
        
        return 110;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
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
        
        return cell;
        
    } else {
        
        FinancingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse000"];
        return cell;
    }
}

- (void)scrollViewFuction{
    
    [bannerScrollView setContentOffset:CGPointMake((pageControl.currentPage + 2) * WIDTH_CONTROLLER_DEFAULT, 0) animated:YES];
    
    pageControl.currentPage += 1;
}

// 添加控件
- (void)makeBackgroundView{
    backgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -20, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT)];
    backgroundScrollView.backgroundColor = mainColor;
    backgroundScrollView.scrollEnabled = NO;
    
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        backgroundScrollView.scrollEnabled = YES;
        backgroundScrollView.contentSize = CGSizeMake(1, 667);
    }
    
    [self.view addSubview:backgroundScrollView];
}

// 广告滚动控件
- (void)makeScrollView{
    NSInteger photoIndex = photoArray.count + 2;
    
    bannerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 180)];
    bannerScrollView.backgroundColor = Color_White;
    bannerScrollView.contentSize = CGSizeMake(WIDTH_CONTROLLER_DEFAULT * photoIndex,0);
    bannerScrollView.contentOffset = CGPointMake(WIDTH_CONTROLLER_DEFAULT, 0);
    bannerScrollView.showsHorizontalScrollIndicator = NO;
    bannerScrollView.showsVerticalScrollIndicator = NO;
    bannerScrollView.pagingEnabled = YES;
    
    bannerScrollView.delegate = self;
    
    [backgroundScrollView addSubview:bannerScrollView];
    
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
    
    [backgroundScrollView addSubview:pageControl];
    
}

// 滚动后的执行方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (bannerScrollView == scrollView) {
        CGPoint offset = [scrollView contentOffset];
        
        //更新UIPageControl的当前页
        CGRect bounds = scrollView.frame;
        [pageControl setCurrentPage:offset.x / bounds.size.width - 1];
        
        if (offset.x == WIDTH_CONTROLLER_DEFAULT * (photoArray.count + 1)) {
            //        [bannerScrollView setContentOffset:CGPointMake(WIDTH_CONTROLLER_DEFAULT, 0) animated:NO];
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
    
    NSDictionary *parmeter = @{@"adType":@"2"};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/adv/getAdvList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"AD = %@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:500]]) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            return ;
        }
        
        for (NSDictionary *dic in [responseObject objectForKey:@"Advertise"]) {
            AdModel *adModel = [[AdModel alloc] init];
            [adModel setValuesForKeysWithDictionary:dic];
            [photoArray addObject:adModel];
        }
        
        [self makeScrollView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

//- (void)getPickProduct{
//    
//    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/product/getPickProduct" parameters:nil success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
//        
//        NSLog(@"getPickProduct = %@",responseObject);
//        
//        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:500]]) {
//            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
//            return ;
//        }
//        
//        [self loadingWithHidden:YES];
//        
//        backgroundScrollView.hidden = NO;
//        
//        productM = [[ProductListModel alloc] init];
//        NSDictionary *dic = [responseObject objectForKey:@"Product"];
//        [productM setValuesForKeysWithDictionary:dic];
//        
//        [self makeOnlyView];
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        NSLog(@"%@", error);
//        
//    }];
//}

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
