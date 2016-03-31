//
//  NewbieViewController.m
//  DSLC
//
//  Created by ios on 15/10/28.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "NewbieViewController.h"
#import "define.h"
#import "FinancingCell.h"
#import "NewBieCell.h"
#import "FDetailViewController.h"
#import "ProductListModel.h"
#import "MDRadialProgressTheme.h"
#import "AdModel.h"
#import "BannerViewController.h"

@interface NewbieViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    UIImageView *imageView;
    UIButton *butLastTime;
    UIView *imageActivity;
    
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


@implementation NewbieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    page = 1;
    
    moreFlag = NO;
    
    newFlag = NO;
    
    self.productListArray = [NSMutableArray array];
    
    photoArray = [NSMutableArray array];
    
    [self getProductList];
    
    [self tableViewShow];
    
    [self loadingWithView:self.view loadingFlag:NO height:120.0];
    
    self.view.backgroundColor = [UIColor huibai];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refrush) name:@"refrushToProductList" object:nil];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(scrollViewFuction) userInfo:nil repeats:YES];
    
    // 修改timer的优先级与控件一致
    // 获取当前的消息循环对象
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    // 更改timer对象的优先级
    [runLoop addTimer:timer forMode:NSRunLoopCommonModes];
    
    [self getAdvList];
}

- (void)refrush {
    
    [self getProductList];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 53 - 45) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor huibai];
    
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 100)];
    _tableView.tableHeaderView.backgroundColor = [UIColor greenColor];
    [self activityShowViewHead];
    
    [_tableView registerNib:[UINib nibWithNibName:@"FinancingCell" bundle:nil] forCellReuseIdentifier:@"reuseNNN"];
    [_tableView registerNib:[UINib nibWithNibName:@"NewBieCell" bundle:nil] forCellReuseIdentifier:@"reuse1"];
    
    [self addTableViewWithHeader:_tableView];
    [self addTableViewWithFooter:_tableView];
}

//火爆专区活动展示
- (void)activityShowViewHead
{
    imageActivity = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 100) backgroundColor:[UIColor whiteColor]];
    [_tableView.tableHeaderView addSubview:imageActivity];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[self.productListArray objectAtIndex:0] productType] isEqualToString:@"3"]) {
        if (indexPath.row == 0) {
        
            return 209;
        
        } else {
            return 110;
        }
    } else {
        
        return 145;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.productListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[self.productListArray objectAtIndex:0] productType] isEqualToString:@"3"]) {
        if (indexPath.row == 0) {
            
            NewBieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse1"];
            
            cell.viewBottom.backgroundColor = [UIColor whiteColor];
            cell.viewBottom.layer.cornerRadius = 3;
            cell.viewBottom.layer.masksToBounds = YES;
            
            cell.labelShouYiLv.text = @"预期年化(%)";
            cell.labelShouYiLv.font = [UIFont fontWithName:@"CenturyGothic" size:13];
            
            cell.labelPercent.textAlignment = NSTextAlignmentCenter;
            cell.labelPercent.text = [[self.productListArray objectAtIndex:indexPath.row] productAnnualYield];
            cell.labelPercent.textColor = [UIColor daohanglan];
            cell.labelPercent.font = [UIFont fontWithName:@"ArialMT" size:45];
            
            cell.viewLine.backgroundColor = [UIColor grayColor];
            cell.viewLine.alpha = 0.1;
            
            [cell.buttonImage setImage:[UIImage imageNamed:@"liwu"] forState:UIControlStateNormal];
            [cell.buttonImage setTitle:@" 新手专享" forState:UIControlStateNormal];
            [cell.buttonImage setTitleColor:[UIColor daohanglan] forState:UIControlStateNormal];
            cell.buttonImage.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
            cell.buttonImage.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            
            NSString *residueString = [[self.productListArray objectAtIndex:indexPath.row] residueMoney];
            
            cell.labelLeftUp.text = [[self.productListArray objectAtIndex:indexPath.row] productPeriod];
            cell.labelLeftUp.font = [UIFont fontWithName:@"ArialMT" size:[self sizeOfLength:residueString]];
            
            cell.labelMidUp.text = [[self.productListArray objectAtIndex:indexPath.row] residueMoney];
            cell.labelMidUp.font = [UIFont fontWithName:@"ArialMT" size:[self sizeOfLength:residueString]];
            
//            NSMutableAttributedString *rightString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",[[self.productListArray objectAtIndex:indexPath.row] productAmountMin]]];
//            NSRange threeRange = NSMakeRange(0, [[rightString string] rangeOfString:@"元"].location);
//            [rightString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:[self sizeOfLength:residueString]] range:threeRange];
//            NSRange three = NSMakeRange([[rightString string] length] - 1, 1);
//            [rightString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:three];
//            [cell.labelRightUp setAttributedText:rightString];
            
            cell.labelRightUp.text = [[self.productListArray objectAtIndex:indexPath.row] productAmountMin];
            cell.labelRightUp.font = [UIFont fontWithName:@"ArialMT" size:[self sizeOfLength:residueString]];
            
            cell.labelLeftRight.text = @"理财期限(天)";
            cell.labelLeftRight.textColor = [UIColor zitihui];
            cell.labelLeftRight.font = [UIFont fontWithName:@"CenturyGothic" size:12];
            
            cell.labelMidDOwn.text = @"剩余总额(万元)";
            cell.labelMidDOwn.textColor = [UIColor zitihui];
            cell.labelMidDOwn.font = [UIFont fontWithName:@"CenturyGothic" size:12];
            
            cell.labelDownRight.text = @"起投资金(元)";
            cell.labelDownRight.textColor = [UIColor zitihui];
            cell.labelDownRight.font = [UIFont fontWithName:@"CenturyGothic" size:12];
            
            cell.backgroundColor = [UIColor huibai];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        } else {
            
            FinancingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseNNN"];
            cell.backgroundColor = [UIColor qianhuise];
            
            cell.viewGiPian.layer.cornerRadius = 4;
            cell.viewGiPian.layer.masksToBounds = YES;
            
            cell.labelMonth.text = [[self.productListArray objectAtIndex:indexPath.row] productName];
            cell.labelMonth.font = [UIFont systemFontOfSize:15];
            
            cell.viewLine.alpha = 0.7;
            cell.viewLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
            
//            预期年化收益率
            cell.labelPercentage.text = [[self.productListArray objectAtIndex:indexPath.row] productAnnualYield];
            cell.labelPercentage.textColor = [UIColor daohanglan];
            cell.labelPercentage.textAlignment = NSTextAlignmentCenter;
            
            cell.labelYear.text = @"预期年化(%)";
            cell.labelYear.textColor = [UIColor zitihui];
            cell.labelYear.textAlignment = NSTextAlignmentCenter;
            
//            理财期限
            cell.labelDayNum.textAlignment = NSTextAlignmentCenter;
            cell.labelDayNum.text = [[self.productListArray objectAtIndex:indexPath.row] productPeriod];
            
            cell.labelData.text = @"理财期限(天)";
            cell.labelData.textAlignment = NSTextAlignmentCenter;
            cell.labelData.textColor = [UIColor zitihui];
            
            if (WIDTH_CONTROLLER_DEFAULT == 320) {
                
                cell.labelPercentage.font = [UIFont fontWithName:@"ArialMT" size:20];
                cell.labelYear.font = [UIFont fontWithName:@"CenturyGothic" size:10];
                
                cell.labelDayNum.font = [UIFont fontWithName:@"ArialMT" size:20];
                cell.labelData.font = [UIFont fontWithName:@"CenturyGothic" size:10];
                
            } else {
                
                cell.labelPercentage.font = [UIFont fontWithName:@"ArialMT" size:23];
                cell.labelYear.font = [UIFont fontWithName:@"CenturyGothic" size:12];
                
                cell.labelDayNum.font = [UIFont fontWithName:@"ArialMT" size:23];
                cell.labelData.font = [UIFont fontWithName:@"CenturyGothic" size:12];
            }
            
            if ([[[self.productListArray objectAtIndex:indexPath.row] residueMoney] isEqualToString:@"0.00"]) {
                
                cell.outPay.hidden = NO;
                cell.quanView.hidden = YES;
            } else {
            
                cell.outPay.hidden = YES;
                cell.quanView.hidden = NO;
                cell.quanView.progressTotal = [[[self.productListArray objectAtIndex:indexPath.row] productInitLimit] floatValue];
                cell.quanView.progressCounter = [[[self.productListArray objectAtIndex:indexPath.row] productInitLimit] floatValue] - [[[self.productListArray objectAtIndex:indexPath.row] residueMoney] floatValue];
                cell.quanView.theme.sliceDividerHidden = YES;
                
            }
            //    设置进度条的进度值 并动画展示
//            CGFloat bL = [[[self.productListArray objectAtIndex:indexPath.row] residueMoney] floatValue] / [[[self.productListArray objectAtIndex:indexPath.row] productInitLimit] floatValue];
//            
//            CGFloat bLL = 1.0 - bL;
            
//            [cell.progressView setProgress:bLL animated:YES];
//            //    设置进度条的颜色
//            cell.progressView.trackTintColor = [UIColor progressBackColor];
//            //    设置进度条的进度颜色
//            cell.progressView.progressTintColor = [UIColor progressColor];
        
            cell.backgroundColor = [UIColor huibai];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    } else {
        
        FinancingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseNNN"];
        
        cell.viewGiPian.layer.cornerRadius = 4;
        cell.viewGiPian.layer.masksToBounds = YES;
        
        cell.labelMonth.text = [[self.productListArray objectAtIndex:indexPath.row] productName];
        cell.labelMonth.font = [UIFont systemFontOfSize:15];
        
        cell.viewLine.alpha = 0.7;
        cell.viewLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        cell.labelPercentage.textColor = [UIColor blackColor];
        cell.labelPercentage.textAlignment = NSTextAlignmentCenter;
        
        NSMutableAttributedString *textString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%",[[self.productListArray objectAtIndex:indexPath.row] productAnnualYield]]];
        //    ,号前面是指起始位置 ,号后面是指到%这个位置截止的总长度
        NSRange redRange = NSMakeRange(0, [[textString string] rangeOfString:@"%"].location);
        [textString addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:redRange];
        [textString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:redRange];
        //    此句意思是指起始位置 是8.02%这个字符串的总长度减掉1 就是指起始位置是% 长度只有1
        NSRange symbol = NSMakeRange([[textString string] length] - 1, 1);
        [textString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:symbol];
        [cell.labelPercentage setAttributedText:textString];
        
        cell.labelYear.text = @"预期年化(%)";
        cell.labelYear.textColor = [UIColor zitihui];
        cell.labelYear.textAlignment = NSTextAlignmentCenter;
        cell.labelYear.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.labelDayNum.textAlignment = NSTextAlignmentCenter;
        cell.labelDayNum.font = [UIFont systemFontOfSize:22];
        
        NSMutableAttributedString *textYear = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@天",[[self.productListArray objectAtIndex:indexPath.row] productPeriod]]];
        NSRange numText = NSMakeRange(0, [[textYear string] rangeOfString:@"天"].location);
        [textYear addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:numText];
        NSRange dayText = NSMakeRange([[textYear string] length] - 1, 1);
        [textYear addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:dayText];
        [cell.labelDayNum setAttributedText:textYear];
        
        cell.labelData.text = @"理财期限(天)";
        cell.labelData.textAlignment = NSTextAlignmentCenter;
        cell.labelData.textColor = [UIColor zitihui];
        cell.labelData.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        NSLog(@"88888888-%ld",(long)indexPath.row);
        
//        if ([[[self.productListArray objectAtIndex:indexPath.row] residueMoney] isEqualToString:@"0.00"]) {
//            
//            cell.outPay.hidden = NO;
//            cell.quanView.hidden = YES;
//            
//        } else {
        
            cell.outPay.hidden = YES;
            cell.quanView.hidden = NO;
            cell.quanView.progressTotal = [[[self.productListArray objectAtIndex:indexPath.row] productInitLimit] floatValue];
            cell.quanView.progressCounter = [[[self.productListArray objectAtIndex:indexPath.row] productInitLimit] floatValue] - [[[self.productListArray objectAtIndex:indexPath.row] residueMoney] floatValue];
            cell.quanView.theme.sliceDividerHidden = YES;
//            
//        }
        //    设置进度条的进度值 并动画展示
//        CGFloat bL = [[[self.productListArray objectAtIndex:indexPath.row] residueMoney] floatValue] / [[[self.productListArray objectAtIndex:indexPath.row] productInitLimit] floatValue];
//        
//        CGFloat bLL = 1.0 - bL;
        
//        [cell.progressView setProgress:bLL animated:YES];
//        //    设置进度条的颜色
//        cell.progressView.trackTintColor = [UIColor progressBackColor];
//        //    设置进度条的进度颜色
//        cell.progressView.progressTintColor = [UIColor progressColor];
    
        cell.backgroundColor = [UIColor huibai];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FDetailViewController *detailVC = [[FDetailViewController alloc] init];
    if ([[[self.productListArray objectAtIndex:0] productType] isEqualToString:@"3"]) {
        if (indexPath.row == 0) {
            detailVC.estimate = NO;
        } else {
            detailVC.estimate = YES;
        }
    } else {
        detailVC.estimate = YES;
    }
    detailVC.idString = [[self.productListArray objectAtIndex:indexPath.row] productId];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getProductList{
    
    NSDictionary *parameter = @{@"productType":@3,@"curPage":[NSNumber numberWithInteger:page]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/product/getProductList" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
            [self loadingWithHidden:YES];
            
            NSLog(@"%@",responseObject);
            
            if (page == 1) {
                NSLog(@"123");
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
            
            if ([[[self.productListArray objectAtIndex:0] productType] isEqualToString:@"3"]) {
                if (![FileOfManage ExistOfFile:@"NewProduct.plist"]) {
                    [FileOfManage createWithFile:@"NewProduct.plist"];
                    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[[array objectAtIndex:0] objectForKey:@"productId"],@"NewProduct",@"0",@"dealSecret",nil];
                    //设置属性值,没有的数据就新建，已有的数据就修改。
                    [dic writeToFile:[FileOfManage PathOfFile:@"NewProduct.plist"] atomically:YES];
                } else {
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithContentsOfFile:[FileOfManage PathOfFile:@"NewProduct.plist"]];
                    //设置属性值,没有的数据就新建，已有的数据就修改。
#warning asdasdasdasdasdasdasdasdasdasd
                    [dic setObject:[[array objectAtIndex:0] objectForKey:@"productId"] forKey:@"NewProduct"];
                    [dic writeToFile:[FileOfManage PathOfFile:@"NewProduct.plist"] atomically:YES];
                }
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
    
    [imageActivity addSubview:bannerScrollView];
    
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
    
    [imageActivity addSubview:pageControl];
    
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
