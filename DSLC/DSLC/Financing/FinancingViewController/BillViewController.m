//
//  BillViewController.m
//  DSLC
//
//  Created by ios on 15/10/28.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "BillViewController.h"
#import "define.h"
#import "UIColor+AddColor.h"
#import "CreatView.h"
#import "FinancingViewController.h"
#import "NewbieViewController.h"
#import "BillCell.h"
#import "FDetailViewController.h"
#import "ProductListModel.h"
#import "MDRadialProgressTheme.h"
#import "AdModel.h"
#import "BannerViewController.h"

@interface BillViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UIButton *butThree;
    NSArray *butThrArr;
    UILabel *labelLine;
    
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
    
    FinancingViewController *financingVC;
    NewbieViewController *newbieVC;
    
    UITableView *_tableView;
    NSArray *butRedArray;
    
    UIImageView *imageView;
    UIView *imageActivit;
    
    NSInteger flag;
    
    NSMutableArray *flagArray;
    
    NSInteger page;
    
    BOOL moreFlag;
    BOOL newFlag;
    
    MJRefreshGifHeader *headerT;
    MJRefreshBackGifFooter *footerT;
    
    // 广告位
    NSMutableArray *photoArray;
    UIPageControl *pageControl;
    NSTimer *timer;
    UIScrollView *bannerScrollView;
}

@property (nonatomic, strong) NSMutableArray *productListArray;

@end

@implementation BillViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    page = 1;
    
    moreFlag = NO;
    
    newFlag = NO;
    
    [self getProductList];
    
    [self tableViewShow];
    
    _tableView.hidden = YES;
    
    [self loadingWithView:self.view loadingFlag:NO height:120.0];
    
    self.view.backgroundColor = [UIColor huibai];
    
    self.productListArray = [NSMutableArray array];
    
    flagArray = [NSMutableArray array];
    
    imageView = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 49, 65, 49, 49) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"已售罄"]];
    
    photoArray = [NSMutableArray array];
    timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(scrollViewFuction) userInfo:nil repeats:YES];
    
    // 修改timer的优先级与控件一致
    // 获取当前的消息循环对象
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    // 更改timer对象的优先级
    [runLoop addTimer:timer forMode:NSRunLoopCommonModes];
    
    [self getAdvList];
    
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 45 - 53) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor huibai];
    
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 100)];
    _tableView.tableHeaderView.backgroundColor = [UIColor greenColor];
    [self activityShowViewHead];
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10)];
    _tableView.tableFooterView.backgroundColor = [UIColor huibai];
    
    [_tableView setSeparatorColor:[UIColor colorWithRed:246 / 255.0 green:247 / 255.0 blue:249 / 255.0 alpha:1.0]];
    [_tableView registerNib:[UINib nibWithNibName:@"BillCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    [self addTableViewWithHeader:_tableView];
    [self addTableViewWithFooter:_tableView];
    
    butRedArray = @[@"3", @"6", @"9", @"12", @"7", @"9", @"1", @"5", @"6", @"8"];
}

//固收活动展示
- (void)activityShowViewHead
{
    imageActivit = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 100) backgroundColor:[UIColor whiteColor]];
    [_tableView.tableHeaderView addSubview:imageActivit];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 126;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.backgroundColor = [UIColor huibai];
    
    ProductListModel *proModel = [self.productListArray objectAtIndex:indexPath.row];
    
    NSString *monthStr = [proModel.productName substringWithRange:NSMakeRange(0, [proModel.productName rangeOfString:@"个"].location)];
    
    [cell.buttonRed setTitle:monthStr forState:UIControlStateNormal];
    [cell.buttonRed setBackgroundImage:[UIImage imageNamed:@"圆角矩形-2"] forState:UIControlStateNormal];
    
    NSString *lastStr = [proModel.productName substringWithRange:NSMakeRange([proModel.productName rangeOfString:@"个"].location, proModel.productName.length - monthStr.length)];
    
    cell.labelMonth.text = lastStr;
    cell.labelMonth.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    
    cell.labelQiTou.text = [NSString stringWithFormat:@"%@元起投",[[self.productListArray objectAtIndex:indexPath.row] productAmountMin]];
    cell.labelQiTou.textColor = [UIColor zitihui];
    cell.labelQiTou.font = [UIFont fontWithName:@"CenturyGothic" size:11];
    cell.labelQiTou.textAlignment = NSTextAlignmentRight;
    
    cell.viewLine1.backgroundColor = [UIColor grayColor];
    cell.viewLine1.alpha = 0.2;
    
//    预期年化收益率
    cell.labelLeftUp.text = [[self.productListArray objectAtIndex:indexPath.row] productAnnualYield];
    cell.labelLeftUp.textColor = [UIColor daohanglan];
    
//    理财期限
    cell.labelMidUp.text = [[self.productListArray objectAtIndex:indexPath.row] productPeriod];
    
//    剩余总额
//    [cell.butRightUp setImage:[UIImage imageNamed:@"组-14"] forState:UIControlStateNormal];
//    NSMutableAttributedString *rightString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@元",[[self.productListArray objectAtIndex:indexPath.row] residueMoney]]];
//    NSRange rightLeft = NSMakeRange(0, [[rightString string] rangeOfString:@"元"].location);
//    [rightString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:[self sizeOfLength:[[self.productListArray objectAtIndex:indexPath.row] residueMoney]]] range:rightLeft];
//    NSRange rightR = NSMakeRange([[rightString string] length] - 1, 1);
//    [rightString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:rightR];
//    [rightString addAttribute:NSForegroundColorAttributeName value:[UIColor zitihui] range:rightR];
//    [cell.butRightUp setAttributedTitle:rightString forState:UIControlStateNormal];
//    cell.butRightUp.backgroundColor = [UIColor yellowColor];
    
    cell.labelLeftDown.text = @"预期年化(%)";
    cell.labelLeftDown.textColor = [UIColor zitihui];
    
    cell.labelMidDown.text = @"理财期限(天)";
    cell.labelMidDown.textColor = [UIColor zitihui];
    
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        
        cell.labelLeftUp.font = [UIFont fontWithName:@"ArialMT" size:20];
        cell.labelMidUp.font = [UIFont fontWithName:@"ArialMT" size:20];
        
        cell.labelLeftDown.font = [UIFont fontWithName:@"CenturyGothic" size:10];
        cell.labelMidDown.font = [UIFont fontWithName:@"CenturyGothic" size:10];
        
    } else {
        
        cell.labelLeftUp.font = [UIFont fontWithName:@"ArialMT" size:23];
        cell.labelMidUp.font = [UIFont fontWithName:@"ArialMT" size:23];
        
        cell.labelLeftDown.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        cell.labelMidDown.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    }
    
//    cell.labelRightDown.text = @"剩余总额";
//    cell.labelRightDown.textColor = [UIColor zitihui];
//    cell.labelRightDown.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    
    if ([[[self.productListArray objectAtIndex:indexPath.row] productStatus] isEqualToString:@"4"]) {
        cell.saleOut.hidden = NO;
        cell.quanView.hidden = YES;
    } else {
        cell.saleOut.hidden = YES;
        cell.quanView.hidden = NO;
        cell.quanView.progressTotal = [[[self.productListArray objectAtIndex:indexPath.row] productInitLimit] floatValue];
        cell.quanView.progressCounter = [[[self.productListArray objectAtIndex:indexPath.row] productInitLimit] floatValue] - [[[self.productListArray objectAtIndex:indexPath.row] residueMoney] floatValue];
        cell.quanView.theme.sliceDividerHidden = YES;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FDetailViewController *detailVC = [[FDetailViewController alloc] init];
    detailVC.estimate = YES;
    detailVC.pandaun = YES;
    detailVC.idString = [[self.productListArray objectAtIndex:indexPath.row] productId];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getProductList{
    
    NSDictionary *parameter = @{@"productType":@1,@"curPage":@1};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/product/getProductList" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            [self loadingWithHidden:YES];
            
            newFlag = YES;
            
            _tableView.hidden = NO;
            
            NSLog(@"%@",responseObject);
            
            NSArray *array = [responseObject objectForKey:@"Product"];
            
            for (NSDictionary *dic in array) {
                [flagArray addObject:[dic objectForKey:@"productStatus"]];
                ProductListModel *productM = [[ProductListModel alloc] init];
                [productM setValuesForKeysWithDictionary:dic];
                [self.productListArray addObject:productM];
            }
            
            if ([[responseObject objectForKey:@"currPage"] isEqual:[responseObject objectForKey:@"totalPage"]]) {
                moreFlag = YES;
            }
            
            [footerT endRefreshing];
            [headerT endRefreshing];
            
            [_tableView reloadData];

        } else {
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

#pragma mark 判断是否还要加载更多
#pragma mark --------------------------------

- (void)loadMoreData:(MJRefreshBackGifFooter *)footer{
    
    footerT = footer;
    
    if (moreFlag) {
        // 拿到当前的上拉刷新控件，结束刷新状态
        [footer endRefreshing];
    } else {
        page ++;
        [self getProductList];
    }
    
}

- (void)loadNewData:(MJRefreshGifHeader *)header{
    
    headerT = header;
    
    if (newFlag) {
        [header endRefreshing];
    } else {
        
        if (self.productListArray != nil) {
            [self.productListArray removeAllObjects];
            self.productListArray = nil;
            self.productListArray = [NSMutableArray array];
        }
        
        page = 1;
        [self getProductList];
    }
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

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

// 广告滚动控件
- (void)makeScrollView{
    NSInteger photoIndex = photoArray.count + 2;
    
    bannerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 100)];
    bannerScrollView.backgroundColor = Color_Gray;
    bannerScrollView.contentSize = CGSizeMake(WIDTH_CONTROLLER_DEFAULT * photoIndex,0);
    bannerScrollView.contentOffset = CGPointMake(WIDTH_CONTROLLER_DEFAULT, 0);
    bannerScrollView.showsHorizontalScrollIndicator = NO;
    bannerScrollView.showsVerticalScrollIndicator = NO;
    bannerScrollView.pagingEnabled = YES;
    
    bannerScrollView.delegate = self;
    
    [imageActivit addSubview:bannerScrollView];
    
    YYAnimatedImageView *bannerFirst = [YYAnimatedImageView new];
    bannerFirst.yy_imageURL = [NSURL URLWithString:[[photoArray objectAtIndex:0] adImg]];
    bannerFirst.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * (photoArray.count + 1), 0, WIDTH_CONTROLLER_DEFAULT, 100);
    
    YYAnimatedImageView *bannerLast = [YYAnimatedImageView new];
    bannerLast.yy_imageURL = [NSURL URLWithString:[[photoArray objectAtIndex:photoArray.count - 1] adImg]];
    bannerLast.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 100);
    
    for (NSInteger i = 0; i < photoArray.count; i++) {
        YYAnimatedImageView *bannerObject = [YYAnimatedImageView new];
        bannerObject.yy_imageURL = [NSURL URLWithString:[[photoArray objectAtIndex:i] adImg]];
        bannerObject.tag = i;
        bannerObject.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * (i + 1), 0, WIDTH_CONTROLLER_DEFAULT, 100);
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
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 70, WIDTH_CONTROLLER_DEFAULT, 30)];
    
    pageControl.numberOfPages = photoArray.count;
    pageControl.currentPage = 0;
    
    [self changePageControlImage];
    
    [imageActivit addSubview:pageControl];
    
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

- (void)scrollViewFuction{
    
    [bannerScrollView setContentOffset:CGPointMake((pageControl.currentPage + 2) * WIDTH_CONTROLLER_DEFAULT, 0) animated:YES];
    
    pageControl.currentPage += 1;
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

// 拖住完成的执行方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(scrollViewFuction) userInfo:nil repeats:YES];
    
    // 修改timer的优先级与控件一致
    // 获取当前的消息循环对象
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    // 更改timer对象的优先级
    [runLoop addTimer:timer forMode:NSRunLoopCommonModes];
    
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
