//
//  TWOFindViewController.m
//  DSLC
//
//  Created by ios on 16/5/6.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOFindViewController.h"
#import "define.h"
#import "CreatView.h"
#import "TwoFindActCell.h"
#import "TwoActivityCell.h"
#import "PleaseExpectCell.h"
#import "TWOgameCenterViewController.h"
#import "TWOMyPrerogativeMoneyViewController.h"
#import "TWODSPublicBenefitViewController.h"
#import "TWOFindActivityCenterViewController.h"
#import "TWOMoneySweepViewController.h"
#import "AdModel.h"
#import "BannerViewController.h"

@interface TWOFindViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

{
    UITableView *_tableView;
    NSArray *imageArray;
    UICollectionView *_collection;
    NSArray *titleArr;
    NSArray *imagePicArray;
    NSArray *contentArr;
    UIImageView *imageDian;
    
    // 轮播图
    UIPageControl *pageControl;
    NSTimer *timer;
    UIScrollView *bannerScrollView;
    NSMutableArray *photoArray;
    UIView *viewScroll;
}

@end

@implementation TWOFindViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(scrollViewFuction) userInfo:nil repeats:YES];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self tabelViewShow];
}

- (void)tabelViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 53) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor];

    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 180.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 220)];
        
    } else if (WIDTH_CONTROLLER_DEFAULT == 375) {
        
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 400)];
        
    } else {
        
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 413)];
    }
    
    _tableView.tableHeaderView.backgroundColor = [UIColor whiteColor];
    [_tableView registerNib:[UINib nibWithNibName:@"TwoFindActCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    [self tableViewShowHead];
}

- (void)tableViewShowHead
{
    if (photoArray == nil && photoArray.count == 0) {
        
        UIImageView *imageBanner = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 180.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"findbanner"]];
        [_tableView.tableHeaderView addSubview:imageBanner];
    } else {
        
        viewScroll = [CreatView creatViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor qianhuise]];
        [_tableView.tableHeaderView addSubview:viewScroll];
    }
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((WIDTH_CONTROLLER_DEFAULT - 18 - 5)/2, 66);
    flowLayout.minimumInteritemSpacing = 5;
//    纵向间距
    flowLayout.minimumLineSpacing = 5;
    _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 180.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 220) collectionViewLayout:flowLayout];
    [_tableView.tableHeaderView addSubview:_collection];
    _collection.dataSource = self;
    _collection.delegate = self;
    _collection.scrollEnabled = NO;
    _collection.backgroundColor = [UIColor whiteColor];
    _collection.contentInset = UIEdgeInsetsMake(6, 9, 6, 9);
    [_collection registerNib:[UINib nibWithNibName:@"TwoActivityCell" bundle:nil] forCellWithReuseIdentifier:@"reuse"];
    [_collection registerNib:[UINib nibWithNibName:@"PleaseExpectCell" bundle:nil] forCellWithReuseIdentifier:@"reuse5"];
    
//    金箍棒
    imageDian = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    imageDian.image = [UIImage imageNamed:@"Reddian"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TwoFindActCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    imageArray = @[@"排行榜", @"公益行", @"大扫描"];
    cell.imagePicture.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
//        大圣公益行
        TWODSPublicBenefitViewController *publicBenefit = [[TWODSPublicBenefitViewController alloc] init];
        pushVC(publicBenefit);
    } else if (indexPath.row == 2) {
//        投资大扫描
        TWOMoneySweepViewController *moneySweepVC = [[TWOMoneySweepViewController alloc] init];
        pushVC(moneySweepVC);
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 5) {
        
        PleaseExpectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse5" forIndexPath:indexPath];
        
        cell.layer.cornerRadius = 3;
        cell.layer.masksToBounds = YES;
        cell.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
        cell.layer.borderWidth = 1;
        
        cell.imageExpect.image = [UIImage imageNamed:@"敬请期待"];
        cell.labelName.text = @"更多精彩,敬请期待";
        cell.labelName.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        cell.labelName.textColor = [UIColor profitColor];
        
        if (WIDTH_CONTROLLER_DEFAULT == 320) {
            cell.labelName.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        }
        
        return cell;
        
    } else {
        
        TwoActivityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
        
        cell.layer.cornerRadius = 3;
        cell.layer.masksToBounds = YES;
        cell.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
        cell.layer.borderWidth = 1;
        
        imagePicArray = @[@"huodong", @"tequan", @"大转盘", @"baojichoujiang", @"youxi"];
        titleArr = @[@"活动中心", @"特权本金", @"大转盘", @"爆击抽奖", @"游戏中心"];
        contentArr = @[@"月月活动玩不停", @"零花钱赚不停", @"猴币转出大礼来", @"实物猴彩等你来", @"玩游戏赚猴币"];
        NSArray *colorArray = @[[UIColor daohanglan], [UIColor tequanColor], [UIColor profitColor], [UIColor daohanglan], [UIColor tequanColor]];
        
        cell.imagePIC.image = [UIImage imageNamed:[imagePicArray objectAtIndex:indexPath.item]];
        cell.labelTitle.text = [titleArr objectAtIndex:indexPath.item];
        cell.labelTitle.textColor = [colorArray objectAtIndex:indexPath.item];
        cell.labelTitle.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        if (indexPath.item == 2) {
            imageDian.frame = CGRectMake(cell.labelTitle.text.length * 15, 3, 11, 11);
            [cell.labelTitle addSubview:imageDian];
            
        } else if (indexPath.item == 3) {
            imageDian.frame = CGRectMake(cell.labelTitle.text.length * 15, 3, 11, 11);
            [cell.labelTitle addSubview:imageDian];
        }
        
        cell.labelContent.text = [contentArr objectAtIndex:indexPath.item];
        cell.labelContent.textColor = [UIColor findZiTiColor];
        cell.labelContent.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        if (WIDTH_CONTROLLER_DEFAULT == 320) {
            cell.labelTitle.font = [UIFont fontWithName:@"CenturyGothic" size:14];
            cell.labelContent.font = [UIFont fontWithName:@"CenturyGothic" size:10];
        }
        
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 4) {
        
        TWOgameCenterViewController *gameVC = [[TWOgameCenterViewController alloc] init];
        [self.navigationController pushViewController:gameVC animated:YES];
        
    } else if (indexPath.item == 1) {
        
        TWOMyPrerogativeMoneyViewController *myPrerogativeMoney = [[TWOMyPrerogativeMoneyViewController alloc] init];
        myPrerogativeMoney.activity = NO;
        [self.navigationController pushViewController:myPrerogativeMoney animated:YES];
        
    } else if (indexPath.item == 0) {
        
        TWOFindActivityCenterViewController *findActivityVC = [[TWOFindActivityCenterViewController alloc] init];
        pushVC(findActivityVC);
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
    
    bannerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 180.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
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
