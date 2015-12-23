//
//  SelectionViewController.m
//  DSLC
//
//  Created by ios on 15/10/9.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "SelectionViewController.h"
#import "SelectionOfThing.h"
#import "SelectionOfSafe.h"
#import "SelectionV.h"
#import "define.h"
#import "MyHandViewController.h"
#import "CastProduceViewController.h"
#import "ProductSettingViewController.h"
#import "MessageDetailViewController.h"
#import "NewHandViewController.h"
#import "MyAfHTTPClient.h"
#import "ProductListModel.h"
#import "FDetailViewController.h"
#import "AdModel.h"
#import "NewHandGuide.h"
#import "MillionsAndMillionsRiskMoney.h"
#import "SafeProtectViewController.h"
#import "BannerViewController.h"


@interface SelectionViewController ()<UIScrollViewDelegate>{

    UIScrollView *backgroundScrollView;
    
    UIScrollView *bannerScrollView;
    
    UIPageControl *pageControl;

    NSTimer *timer;
    
}

@property (nonatomic, strong) ProductListModel *productM;
@property (nonatomic, strong) NSDictionary *newProductDic;

@property (nonatomic, strong) NSMutableArray *photoArray;

@end

@implementation SelectionViewController

// 手势标识文件
- (NSDictionary *)newProductDic{
    if (_newProductDic == nil) {
        
        if (![FileOfManage ExistOfFile:@"NewProduct.plist"]) {
            [FileOfManage createWithFile:@"NewProduct.plist"];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"0",@"NewProduct",@"",@"dealSecret",nil];
            
            [dic writeToFile:[FileOfManage PathOfFile:@"NewProduct.plist"] atomically:YES];
        }
        
        NSDictionary *dics = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"NewProduct.plist"]];
        _newProductDic = dics;
    }
    return _newProductDic;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:NO];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
  
    self.photoArray = [NSMutableArray array];
    
    // 加密解密
    NSString* encrypt = @"T5+VBpjWOWNqKlfP5PGRIw==";
//    NSString* decrypt = [self decryptUseDES:encrypt];
//    NSString *encrypt = [DES3Util encrypt:@"11111111"];
    NSString *decrypt = [DES3Util decrypt:encrypt];
    
    NSLog(@"123123-12-3-123-12-3-123--- %@ ==== %@",encrypt,decrypt);
    
    [self makeBackgroundView];
    [self makeThreeButtons];
    [self makePayButton];
    [self makeSafeView];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(scrollViewFuction) userInfo:nil repeats:YES];

    // 修改timer的优先级与控件一致
    // 获取当前的消息循环对象
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    // 更改timer对象的优先级
    [runLoop addTimer:timer forMode:NSRunLoopCommonModes];
    
    [self getAdvList];
    [self getPickProduct];
    
    [self loadingWithView:self.view loadingFlag:NO height:self.view.center.y];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPickProduct) name:@"refrushToPickProduct" object:nil];
    
    backgroundScrollView.hidden = YES;
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
    NSInteger photoIndex = self.photoArray.count + 2;
    
    bannerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 180)];
    bannerScrollView.backgroundColor = Color_White;
    bannerScrollView.contentSize = CGSizeMake(WIDTH_CONTROLLER_DEFAULT * photoIndex,0);
    bannerScrollView.contentOffset = CGPointMake(WIDTH_CONTROLLER_DEFAULT, 0);
    bannerScrollView.showsHorizontalScrollIndicator = NO;
    bannerScrollView.showsVerticalScrollIndicator = NO;
    bannerScrollView.pagingEnabled = YES;
    
    bannerScrollView.delegate = self;
    
    [backgroundScrollView addSubview:bannerScrollView];
    
//    YYAnimatedImageView *bannerFirst = [YYAnimatedImageView new];
//    bannerFirst.yy_imageURL = [NSURL URLWithString:[[self.photoArray objectAtIndex:0] adImg]];
//    bannerFirst.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * (self.photoArray.count + 1), 0, WIDTH_CONTROLLER_DEFAULT, 180);
//    
//    YYAnimatedImageView *bannerLast = [YYAnimatedImageView new];
//    bannerLast.yy_imageURL = [NSURL URLWithString:[[self.photoArray objectAtIndex:self.photoArray.count - 1] adImg]];
//    bannerLast.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 180);
    
    for (NSInteger i = 0; i < self.photoArray.count; i++) {
        YYAnimatedImageView *bannerObject = [YYAnimatedImageView new];
        bannerObject.yy_imageURL = [NSURL URLWithString:[[self.photoArray objectAtIndex:i] adImg]];
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
    
//    [bannerScrollView addSubview:bannerFirst];
//    [bannerScrollView addSubview:bannerLast];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 150, WIDTH_CONTROLLER_DEFAULT, 30)];
    
    pageControl.numberOfPages = self.photoArray.count;
    pageControl.currentPage = 0;
    
    [self changePageControlImage];

    [backgroundScrollView addSubview:pageControl];
    
}

- (void)bannerObject:(UITapGestureRecognizer *)tap{
    BannerViewController *bannerVC = [[BannerViewController alloc] init];
    bannerVC.photoName = [NSString stringWithFormat:@"%ld",tap.numberOfTouchesRequired];
    pushVC(bannerVC);
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


// 三个按钮View
- (void)makeThreeButtons
{
    UIView *threeView = [[UIView alloc] initWithFrame:CGRectMake(0, 180, WIDTH_CONTROLLER_DEFAULT, 90)];
    
    threeView.backgroundColor = mainColor;
    [backgroundScrollView addSubview:threeView];
    
    NSArray *nameArray = @[@"安全保障",@"千万风险金",@"新手指南"];
    NSArray *photoArray = @[@"shouyeqiepian_03",@"shouyeqiepian_05",@"shouyeqiepian_07"];
    
    CGFloat marginX = WIDTH_CONTROLLER_DEFAULT * (25 / 375.0);
    CGFloat buttonX = WIDTH_CONTROLLER_DEFAULT * (90 / 375.0);
    CGFloat buttonY = HEIGHT_CONTROLLER_DEFAULT * (110 / 667.0);
    
    for (NSInteger i = 0; i < nameArray.count; i++) {
        
        NSBundle *rootBundle = [NSBundle mainBundle];
        SelectionV *buttonView = [[rootBundle loadNibNamed:@"SelectionV" owner:nil options:nil] lastObject];
        
        CGFloat bVX = marginX + i * (marginX + buttonX);
        
        buttonView.frame = CGRectMake(bVX, 0, buttonX, buttonY);
        
        [buttonView.selectionButton setImage:[UIImage imageNamed:[photoArray objectAtIndex:i]] forState:UIControlStateNormal];
        buttonView.selectionButton.tag = i;
        buttonView.titleLabel.text = [nameArray objectAtIndex:i];
        
        [buttonView.selectionButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [threeView addSubview:buttonView];
    }
    
}

// 专享模块
// NSLog(@"%@",[UIFont familyNames]); 输出全部的字体
- (void)makeOnlyView{
    
    NSBundle *rootBundle = [NSBundle mainBundle];
    
    SelectionOfThing *selectionFTView = (SelectionOfThing *)[[rootBundle loadNibNamed:@"SelectionOfThing" owner:nil options:nil] lastObject];
    
    CGFloat margin_left = (22.5 / 375) * WIDTH_CONTROLLER_DEFAULT;
    
    selectionFTView.frame = CGRectMake(margin_left, 285, WIDTH_CONTROLLER_DEFAULT * (330 / 375.0), 215);
    
    selectionFTView.layer.cornerRadius = 4;
    
    selectionFTView.layer.masksToBounds = YES;
    
    selectionFTView.moreButton.layer.cornerRadius = 10;
    
    selectionFTView.moreButton.layer.masksToBounds = YES;
    //给图层添加一个有色边框
    selectionFTView.moreButton.layer.borderWidth = 1;
    
    selectionFTView.moreButton.layer.borderColor = [[UIColor colorWithRed:117.0 / 255.0 green:119.0 / 255.0 blue:125.0 / 255.0 alpha:1] CGColor];
    
    NSMutableAttributedString *numberText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%",[self.productM productAnnualYield]]];
    NSMutableAttributedString *dayText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@天",[self.productM productPeriod]]];
    NSMutableAttributedString *moneyText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",[self.productM residueMoney]]];
    NSMutableAttributedString *firstMoneyText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",[self.productM productAmountMin]]];
    
    NSRange numRange = NSMakeRange(0, [[numberText string] rangeOfString:@"%"].location);
    NSRange markRange = NSMakeRange([[numberText string] rangeOfString:@"%"].location, 1);
    
    [numberText addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:numRange];
    [numberText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:(45.0 / 375.0) * WIDTH_CONTROLLER_DEFAULT] range:numRange];
    [numberText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:(28.0 / 375.0) * WIDTH_CONTROLLER_DEFAULT] range:markRange];
    [selectionFTView.numberLabel setAttributedText:numberText];
    
    NSRange markDayRange = NSMakeRange([[dayText string] rangeOfString:@"天"].location , 1);
    NSRange markWRange = NSMakeRange([[moneyText string] rangeOfString:@"元"].location , 1);
    NSRange markYuanRange = NSMakeRange([[firstMoneyText string] rangeOfString:@"元"].location , 1);
    
    NSRange dRange = NSMakeRange(0, [[dayText string] rangeOfString:@"天"].location);
    NSRange qWRange = NSMakeRange(0, [[moneyText string] rangeOfString:@"元"].location);
    NSRange yRange = NSMakeRange(0, [[firstMoneyText string] rangeOfString:@"元"].location);
    
    [dayText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:[self sizeOfLength:[self.productM residueMoney]]] range:dRange];
    [dayText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:markDayRange];
    [moneyText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:[self sizeOfLength:[self.productM residueMoney]]] range:qWRange];
    [moneyText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:markWRange];
    [firstMoneyText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:[self sizeOfLength:[self.productM residueMoney]]] range:yRange];
    [firstMoneyText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:markYuanRange];
    
    [selectionFTView.dayLabel setAttributedText:dayText];
    [selectionFTView.moneyLabel setAttributedText:moneyText];
    [selectionFTView.firstLabel setAttributedText:firstMoneyText];
    
    [selectionFTView.moreButton addTarget:self action:@selector(moreActionButton:) forControlEvents:UIControlEventTouchUpInside];
    
    selectionFTView.productName.text = [self.productM productName];
    
    [backgroundScrollView addSubview:selectionFTView];
    
}

//更多按钮
- (void)moreActionButton:(id)sender{
    [MobClick event:@"moreActionButton"];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC.tabScrollView setContentOffset:CGPointMake(WIDTH_CONTROLLER_DEFAULT, 0) animated:NO];
    
    UIButton *indexButton = [app.tabBarVC.tabButtonArray objectAtIndex:1];
    
    for (UIButton *tempButton in app.tabBarVC.tabButtonArray) {
        
        if (indexButton.tag != tempButton.tag) {
            NSLog(@"%ld",(long)tempButton.tag);
            [tempButton setSelected:NO];
        }
    }
    
    [indexButton setSelected:YES];
}

// 立即抢购
- (void)makePayButton{
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    payButton.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * (51 / 375.0), 520, WIDTH_CONTROLLER_DEFAULT * (271.0 / 375.0), 43);
    
    [payButton setBackgroundImage:[UIImage imageNamed:@"shouyeqiepian_17"] forState:UIControlStateNormal];
    [payButton setTitle:@"立即抢购" forState:UIControlStateNormal];
    
    [payButton addTarget:self action:@selector(payButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [backgroundScrollView addSubview:payButton];
    
}

// 保障
- (void)makeSafeView{
 
    NSBundle *rootBundle = [NSBundle mainBundle];
    
    SelectionOfSafe *selectionSafeView = (SelectionOfSafe *)[[rootBundle loadNibNamed:@"SelectionOfSafe" owner:nil options:nil] lastObject];
    
    CGFloat button_X = WIDTH_CONTROLLER_DEFAULT * (180.0 / 375.0);
    CGFloat margin_left = ((WIDTH_CONTROLLER_DEFAULT - button_X) / 2 / 375.0) * WIDTH_CONTROLLER_DEFAULT;
    
    selectionSafeView.frame = CGRectMake(margin_left, 570, button_X, 17);
    
    [backgroundScrollView addSubview:selectionSafeView];
    
}

- (void)payButtonAction:(id)sender{
    
    FDetailViewController *detailVC = [[FDetailViewController alloc] init];
    
    if ([[self.productM productType] isEqualToString:@"3"]) {
        detailVC.estimate = NO;
    } else {
        detailVC.estimate = YES;
    }
    
    detailVC.idString = [self.productM productId];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma scrollView dalagate
// 滚动后的执行方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGPoint offset = [scrollView contentOffset];
    
    //更新UIPageControl的当前页
    CGRect bounds = scrollView.frame;
    [pageControl setCurrentPage:offset.x / bounds.size.width - 1];
    
    if (offset.x == WIDTH_CONTROLLER_DEFAULT * (self.photoArray.count + 1)) {
        [bannerScrollView setContentOffset:CGPointMake(WIDTH_CONTROLLER_DEFAULT, 0) animated:NO];
        pageControl.currentPage = 0;
    } else if (offset.x == 0) {
        [bannerScrollView setContentOffset:CGPointMake(WIDTH_CONTROLLER_DEFAULT * self.photoArray.count, 0) animated:NO];
        pageControl.currentPage = self.photoArray.count - 1;
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
    
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(scrollViewFuction) userInfo:nil repeats:YES];
    
    // 修改timer的优先级与控件一致
    // 获取当前的消息循环对象
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    // 更改timer对象的优先级
    [runLoop addTimer:timer forMode:NSRunLoopCommonModes];
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    CGPoint offset = [scrollView contentOffset];
    
    if (offset.x == WIDTH_CONTROLLER_DEFAULT * (self.photoArray.count + 1)) {
        [bannerScrollView setContentOffset:CGPointMake(WIDTH_CONTROLLER_DEFAULT, 0) animated:NO];
        pageControl.currentPage = 0;
    } else if (offset.x == 0) {
        [bannerScrollView setContentOffset:CGPointMake(WIDTH_CONTROLLER_DEFAULT * self.photoArray.count, 0) animated:NO];
        pageControl.currentPage = self.photoArray.count - 1;
    }
}

- (void)scrollViewFuction{
    
    [bannerScrollView setContentOffset:CGPointMake((pageControl.currentPage + 2) * WIDTH_CONTROLLER_DEFAULT, 0) animated:YES];

    pageControl.currentPage += 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonAction:(id)sender{
    
    UIButton *button = (UIButton *)sender;
//    SelectionV *sView = (SelectionV *)button.superview;
    
    if (button.tag == 2) {
        [MobClick event:@"NewHandGuide"];
        NewHandGuide *newHand = [[NewHandGuide alloc] init];
        [self.navigationController pushViewController:newHand animated:YES];
        
    } else if (button.tag == 1){
        [MobClick event:@"MillionsAndMillionsRiskMoney"];
        MillionsAndMillionsRiskMoney *riskMoney = [[MillionsAndMillionsRiskMoney alloc] init];
        [self.navigationController pushViewController:riskMoney animated:YES];

    } else {
        [MobClick event:@"safeVC"];
        SafeProtectViewController *safe = [[SafeProtectViewController alloc] init];
        [self.navigationController pushViewController:safe animated:YES];

    }
    
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getAdvList{

    NSDictionary *parmeter = @{@"adType":@"2"};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/adv/getAdvList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"AD = %@",responseObject);
        
        for (NSDictionary *dic in [responseObject objectForKey:@"Advertise"]) {
            AdModel *adModel = [[AdModel alloc] init];
            [adModel setValuesForKeysWithDictionary:dic];
            [self.photoArray addObject:adModel];
        }
        
        [self makeScrollView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

#pragma mark 刷新精选产品 和 网络请求方法
#pragma mark --------------------------------

- (void)getPickProduct{
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/product/getPickProduct" parameters:nil success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"getPickProduct = %@",responseObject);
        
        [self loadingWithHidden:YES];
        
        backgroundScrollView.hidden = NO;
        
        self.productM = [[ProductListModel alloc] init];
        NSDictionary *dic = [responseObject objectForKey:@"Product"];
        [self.productM setValuesForKeysWithDictionary:dic];
        
        if (![FileOfManage ExistOfFile:@"NewProduct.plist"]) {
            [FileOfManage createWithFile:@"NewProduct.plist"];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithContentsOfFile:[FileOfManage PathOfFile:@"NewProduct.plist"]];
            //设置属性值,没有的数据就新建，已有的数据就修改。
            [dic setObject:[self.productM productId] forKey:@"NewProduct"];
            [dic writeToFile:[FileOfManage PathOfFile:@"NewProduct.plist"] atomically:YES];
        } else {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithContentsOfFile:[FileOfManage PathOfFile:@"NewProduct.plist"]];
            //设置属性值,没有的数据就新建，已有的数据就修改。
            [dic setObject:[self.productM productId] forKey:@"NewProduct"];
            [dic writeToFile:[FileOfManage PathOfFile:@"NewProduct.plist"] atomically:YES];
        }
        
        [self makeOnlyView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//
+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}

@end
