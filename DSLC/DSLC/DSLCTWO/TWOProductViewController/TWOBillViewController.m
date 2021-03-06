//
//  BillViewController.m
//  DSLC
//
//  Created by ios on 15/10/28.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "TWOBillViewController.h"
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
#import "TWOProductDetailViewController.h"
#import "TWOProductDemoTableViewCell.h"
#import "TWONoticeDetailViewController.h"

@interface TWOBillViewController () <UITableViewDataSource, UITableViewDelegate>

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
    BOOL nFlag;
    
    MJRefreshGifHeader *headerT;
    MJRefreshBackGifFooter *footerT;
    
    // 广告位
    NSMutableArray *photoArray;
    UIPageControl *pageControl;
    NSTimer *timer;
    UIScrollView *bannerScrollView;
    
    // 无数据猴子
    UIImageView *imageMonkey;
    
    // 无网络猴子
    UIImageView *noNetworkMonkey;
    UIButton *reloadButton;
}

@property (nonatomic, strong) NSMutableArray *productListArray;

@end

@implementation TWOBillViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:NO];
    [app.tabBarVC setLabelLineHidden:NO];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    page = 1;
    
    moreFlag = NO;
    
    nFlag = NO;
    
    [self getProductList];
    
    [self loadingWithView:self.view loadingFlag:NO height:(HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 53)/2.0 - 50];
    
    [self tableViewShow];
    
    _tableView.hidden = YES;
    
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
    
//    [self getAdvList];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getBillProduct) name:@"BillVC" object:nil];
    
}

- (void)getBillProduct{
    
//    if (self.productListArray != nil) {
//
//        if (!nFlag){
//
//            [self.productListArray removeAllObjects];
//            self.productListArray = nil;
//            self.productListArray = [NSMutableArray array];
            nFlag = YES;
//        }
//    }
    
    page = 1;
    [self getProductList];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 53) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor huibai];
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10)];
    _tableView.tableFooterView.backgroundColor = [UIColor huibai];
    
    [_tableView setSeparatorColor:[UIColor colorWithRed:246 / 255.0 green:247 / 255.0 blue:249 / 255.0 alpha:1.0]];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOProductDemoTableViewCell" bundle:nil] forCellReuseIdentifier:@"reuseNNew"];
    
    [self addTableViewWithHeader:_tableView];
    [self addTableViewWithFooter:_tableView];
    
    butRedArray = @[@"3", @"6", @"9", @"12", @"7", @"9", @"1", @"5", @"6", @"8"];
}

//固收活动展示
- (void)activityShowViewHead
{
    imageActivit = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 140) backgroundColor:[UIColor whiteColor]];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 152)];
    _tableView.tableHeaderView.backgroundColor = [UIColor huibai];
    [_tableView.tableHeaderView addSubview:imageActivit];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOProductDemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseNNew"];
    
    cell.labelDetail.hidden = YES;
    
    cell.viewGiPian.layer.masksToBounds = YES;
    cell.viewGiPian.layer.cornerRadius = 4;
    
    cell.labelproductName.text = [[self.productListArray objectAtIndex:indexPath.row] productName];
    cell.labelproductName.font = [UIFont systemFontOfSize:15];
    
    cell.viewLine.alpha = 0.7;
    cell.viewLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    cell.labelPercentage.textColor = [UIColor blackColor];
    cell.labelPercentage.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *textString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%",[[self.productListArray objectAtIndex:indexPath.row] productAnnualYield]]];
    //    ,号前面是指起始位置 ,号后面是指到%这个位置截止的总长度
    NSRange redRange = NSMakeRange(0, [[textString string] rangeOfString:@"%"].location + 1);
    [textString addAttribute:NSForegroundColorAttributeName value:[UIColor orangecolor] range:redRange];
    [textString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:redRange];
    //    此句意思是指起始位置 是8.02%这个字符串的总长度减掉1 就是指起始位置是% 长度只有1
    NSRange symbol = NSMakeRange([[textString string] length] - 1, 1);
    [textString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:symbol];
    [cell.labelPercentage setAttributedText:textString];
    
    cell.labelDayNum.textAlignment = NSTextAlignmentCenter;
    cell.labelDayNum.font = [UIFont systemFontOfSize:22];
    cell.labelDayNum.textColor = [UIColor ZiTiColor];
    
    NSMutableAttributedString *textYear = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@天",[[self.productListArray objectAtIndex:indexPath.row] productPeriod]]];
    NSRange numText = NSMakeRange(0, [[textYear string] rangeOfString:@"天"].location);
    [textYear addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:numText];
    NSRange dayText = NSMakeRange([[textYear string] length] - 1, 1);
    [textYear addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:dayText];
    [cell.labelDayNum setAttributedText:textYear];
    
    //            NSLog(@"88888888-%ld",(long)indexPath.row);
    if ([[[self.productListArray objectAtIndex:indexPath.row] productStatus] isEqualToString:@"6"]) {
    
        cell.outPay.hidden = NO;
        cell.outPay.image = [UIImage imageNamed:@"TWOSaled"];
        cell.quanView.hidden = YES;
        
        cell.contentView.alpha = 0.5;
    }else if ([[[self.productListArray objectAtIndex:indexPath.row] productStatus] isEqualToString:@"4"]) {
        
        cell.outPay.hidden = NO;
        cell.outPay.image = [UIImage imageNamed:@"TWOProfitting"];
        cell.quanView.hidden = YES;
        
        cell.contentView.alpha = 0.5;
        
    } else {
        
        cell.contentView.alpha = 1.0;
        
        cell.outPay.hidden = YES;
        cell.quanView.hidden = NO;
        cell.quanView.progressTotal = [[[self.productListArray objectAtIndex:indexPath.row] productInitLimit] floatValue];
        
        CGFloat hadSellNumber = [[[self.productListArray objectAtIndex:indexPath.row] productInitLimit] floatValue] - [[[self.productListArray objectAtIndex:indexPath.row] residueMoney] floatValue];
        
        CGFloat onePriceNumber = [[[self.productListArray objectAtIndex:indexPath.row] productInitLimit] floatValue] * 0.01;
        
        CGFloat ninetyPriceNumber = [[[self.productListArray objectAtIndex:indexPath.row] productInitLimit] floatValue] * 0.99;
        //        if ([[[self.productListArray objectAtIndex:indexPath.row] productInitLimit] isEqualToString:[[self.productListArray objectAtIndex:indexPath.row] residueMoney]]) {
        //
        //            cell.quanView.progressCounter = 1;
        //        } else
        if (hadSellNumber == 0.0) {
            
            cell.quanView.progressCounter = 1;
        } else if (hadSellNumber < onePriceNumber){
            
            cell.quanView.progressCounter = onePriceNumber;
        } else if(hadSellNumber > ninetyPriceNumber){
            
            cell.quanView.progressCounter = ninetyPriceNumber;
        } else {
            
            cell.quanView.progressCounter = hadSellNumber;
        }
        
        cell.quanView.theme.sliceDividerHidden = YES;
        
    }
    //    设置进度条的进度值 并动画展示
    //        CGFloat bL = [[[self.productListArray objectAtIndex:indexPath.row] residueMoney] floatValue] / [[[self.productListArray objectAtIndex:indexPath.row] productInitLimit] floatValue];
    //
    //        CGFloat bLL = 1.0 - bL;
    
    //        [cell.progressView setProgress:bLL animated:YES];
    //        //    设置进度条的颜色
    //        cell.progressView.trackTintColor = [UIColor progressBackColor];
    //        //    设置进度条的进度颜色
    //        cell.progressView.progressTintColor = [UIColor progressColor];
    
    cell.labelDetail.text = [[self.productListArray objectAtIndex:indexPath.row] productResume];
    
    cell.backgroundColor = [UIColor huibai];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [MobClick event:@"mm"];
    
    ProductListModel *productM = [self.productListArray objectAtIndex:indexPath.row];
    
    TWOProductDetailViewController *twoPDVC = [[TWOProductDetailViewController alloc] init];
    twoPDVC.productName = productM.productName;
    twoPDVC.estimate = YES;
    twoPDVC.pandaun = YES;
    twoPDVC.residueMoney = [productM residueMoney];
    twoPDVC.idString = [[self.productListArray objectAtIndex:indexPath.row] productId];
    
    pushVC(twoPDVC);
    
    
//    FDetailViewController *detailVC = [[FDetailViewController alloc] init];
//    detailVC.estimate = YES;
//    detailVC.pandaun = YES;
//    detailVC.idString = [[self.productListArray objectAtIndex:indexPath.row] productId];
//    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getProductList{
    
    NSDictionary *userDic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parameter = @{@"productType":@1,@"curPage":[NSString stringWithFormat:@"%ld",(long)page],@"token":[userDic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"product/getProductList" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [self loadingWithHidden:YES];
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            
            _tableView.hidden = NO;
            
            NSLog(@"%@",responseObject);
            
            if (headerT.state == MJRefreshStateRefreshing || nFlag) {
                
                [self.productListArray removeAllObjects];
                self.productListArray = nil;
                self.productListArray = [NSMutableArray array];
            }
            
            NSArray *array = [responseObject objectForKey:@"Product"];
            
            for (NSDictionary *dic in array) {
                ProductListModel *productM = [[ProductListModel alloc] init];
                [productM setValuesForKeysWithDictionary:dic];
                [self.productListArray addObject:productM];
            }
            
            if (self.productListArray.count == 0) {
                
                [self noDataShowMoney];
                _tableView.hidden = YES;
                noNetworkMonkey.hidden = YES;
                reloadButton.hidden = YES;
                imageMonkey.hidden = NO;
                return ;
            } else {
                
                imageMonkey.hidden = YES;
                noNetworkMonkey.hidden = YES;
                reloadButton.hidden = YES;
                _tableView.hidden = NO;
            }
            
            if ([[responseObject objectForKey:@"currPage"] isEqual:[responseObject objectForKey:@"totalPage"]]) {
                moreFlag = YES;
            } else {
                moreFlag = NO;
            }
            
            nFlag = NO;
            
            [footerT endRefreshing];
            [headerT endRefreshing];
            
            [_tableView reloadData];
            
        } else {
            [self noDataShowMoney];
            _tableView.hidden = YES;
            noNetworkMonkey.hidden = YES;
            reloadButton.hidden = YES;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self loadingWithHidden:YES];
        [self noNetworkView];
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
        
    page = 1;
    [self getProductList];
    
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getAdvList{
    
    NSDictionary *parmeter = @{@"adType":@"2",@"adPosition":@"5"};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/adv/getAdvList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"ADProduct = %@",responseObject);
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:500]]) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            return ;
        }
        
        for (NSDictionary *dic in [responseObject objectForKey:@"Advertise"]) {
            AdModel *adModel = [[AdModel alloc] init];
            [adModel setValuesForKeysWithDictionary:dic];
            [photoArray addObject:adModel];
        }
        
        if (photoArray.count != 0) {
            [self activityShowViewHead];
            [self makeScrollView];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        NSLog(@"%@", error);
        
    }];
}

// 广告滚动控件
- (void)makeScrollView{
    NSInteger photoIndex = photoArray.count + 2;
    
    bannerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 140)];
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
    bannerFirst.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * (photoArray.count + 1), 0, WIDTH_CONTROLLER_DEFAULT, 140);
    
    YYAnimatedImageView *bannerLast = [YYAnimatedImageView new];
    bannerLast.yy_imageURL = [NSURL URLWithString:[[photoArray objectAtIndex:photoArray.count - 1] adImg]];
    bannerLast.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 140);
    
    for (NSInteger i = 0; i < photoArray.count; i++) {
        YYAnimatedImageView *bannerObject = [YYAnimatedImageView new];
        bannerObject.yy_imageURL = [NSURL URLWithString:[[photoArray objectAtIndex:i] adImg]];
        bannerObject.tag = i;
        bannerObject.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * (i + 1), 0, WIDTH_CONTROLLER_DEFAULT, 140);
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
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 110, WIDTH_CONTROLLER_DEFAULT, 30)];
    
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
        imgCurrent = [UIImage imageNamed:@"TWOBannerBlue"];
        imgOther = [UIImage imageNamed:@"TWOBannerBlack"];
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

- (void)noDataShowMoney
{
    _tableView.hidden = YES;
    
    if (imageMonkey == nil) {
        imageMonkey = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 284/2/2, 100, 284/2, 284/2) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"noWithData"]];
    }
    imageMonkey.hidden = NO;
    [self.view addSubview:imageMonkey];
}

- (void)noNetworkView {
    
    _tableView.hidden = YES;
    
    if (noNetworkMonkey == nil) {
        noNetworkMonkey = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 413/2.0/2.0, 100, 413/2.0, 268/2.0) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"TWONoPower"]];
    }
    noNetworkMonkey.hidden = NO;
    [self.view addSubview:noNetworkMonkey];
    
    if (reloadButton == nil) {
        
        reloadButton = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * 0.5 - 75, CGRectGetMaxY(noNetworkMonkey.frame) + 10, 140, 35) backgroundColor:[UIColor clearColor] textColor:Color_White titleText:nil];
        
        reloadButton.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        [reloadButton setBackgroundImage:[UIImage imageNamed:@"TWORefrush"] forState:UIControlStateNormal];
        [reloadButton setBackgroundImage:[UIImage imageNamed:@"TWORefrush"] forState:UIControlStateHighlighted];
        
        [reloadButton addTarget:self action:@selector(getProductList) forControlEvents:UIControlEventTouchUpInside];
    }
    reloadButton.hidden = NO;
    [self.view addSubview:reloadButton];
    
    // 判断是否存在isLogin.plist文件
    if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
        [FileOfManage createWithFile:@"isLogin.plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
        [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
    } else {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
        [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
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
