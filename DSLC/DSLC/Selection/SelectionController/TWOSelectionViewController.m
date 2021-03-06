//
//  TWOSelectionViewController.m
//  DSLC
//
//  Created by ios on 16/5/4.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOSelectionViewController.h"
#import "UIColor+AddColor.h"
#import "NewInviteViewController.h"
#import "TWOYaoYiYaoViewController.h"
#import "define.h"
#import "CreatView.h"
#import "TWOFindViewController.h"
#import "TWOHomePageProductCell.h"
#import "TWOPickModel.h"
#import "TWOProductDetailViewController.h"
#import "AdModel.h"
#import "BannerViewController.h"
#import "TSignInViewController.h"
#import "TWOLoginAPPViewController.h"
#import "TWOMessageModel.h"
#import "TWONoticeDetailViewController.h"
#import "TWOProductHuiFuViewController.h"

@interface TWOSelectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate>

{
    UIButton *buttonClick;
    UIView *viewBottom;
    UIButton *buttonHei;
    UILabel *labelMonkey;
    UIImageView *imageSign;
    UIView *viewBanner;
    UIView *viewNotice;
    UICollectionView *_collection;
    UIScrollView *_scrollView;
    
    UIButton *buttonLeft;
    UIButton *buttonRight;
    NSInteger numberItem;
    UIView *viewDown;
    
    NSMutableArray *pickArray;
    
    CGFloat residueMoney;
    NSString *residueMoneyString;
    
    // 网络请求传值
    NSDictionary *parameter;
    
    // 广告位
    NSMutableArray *photoArray;
    UIPageControl *pageControl;
    NSTimer *timer;
    UIScrollView *bannerScrollView;
    
//    公告数组
    NSMutableArray *noticeArray;
    TWOMessageModel *messageModel;
//    公告滚动视图
    UIScrollView *_scrollViewNotice;
    NSTimer *timerNotice;
    NSInteger secondsNum;
    NSInteger everyNum;
    
    // 无数据猴子
    UIImageView *imageMonkey;
    
    // 无网络猴子
    UIImageView *noNetworkMonkey;
    UIButton *reloadButton;
    
    NSMutableArray *noticeMesArray;
    
    // 汇付开户窗口控件
    UIButton *buttBlack;
    UIView *viewThirdOpen;
    
    BOOL GGFlag;
}

@end

@implementation TWOSelectionViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor qianhuise];
    
    GGFlag = NO;
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidSetup:)
                          name:kJPFNetworkDidSetupNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidClose:)
                          name:kJPFNetworkDidCloseNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidRegister:)
                          name:kJPFNetworkDidRegisterNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidLogin:)
                          name:kJPFNetworkDidLoginNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidReceiveMessage:)
                          name:kJPFNetworkDidReceiveMessageNotification
                        object:nil];
    [defaultCenter addObserver:self
                      selector:@selector(serviceError:)
                          name:kJPFServiceErrorNotification
                        object:nil];
    
    pickArray = [NSMutableArray array];
    photoArray = [NSMutableArray array];
    noticeArray = [NSMutableArray array];
    
    [self loadingWithView:self.view loadingFlag:NO height:(HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 53)/2.0 - 50 + 64];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getProductList) name:@"getSelectionVC" object:nil];
    
    // 公告推送
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushGongGaoViewController:) name:@"gongGaoWithNotice" object:nil];
    // 公告H5
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushHFiveViewController:) name:@"hFiveWithNotice" object:nil];
    
    [self getAdvList];
    
    // 汇付开户
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToOpenAccount) name:@"huifuOpenAccount" object:nil];
    
}

//签到成功
- (void)signFinish
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
//    if (app.window.rootViewController.view.alpha == 1.0) {
        buttonHei = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, self.view.frame.size.height) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
        [app.tabBarVC.view addSubview:buttonHei];
        buttonHei.alpha = 0.6;
        [buttonHei addTarget:self action:@selector(clickedBlackDisappear:) forControlEvents:UIControlEventTouchUpInside];
        
        viewDown = [CreatView creatViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 530/2/2, 194.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 530/2, 397/2 + 30) backgroundColor:[UIColor clearColor]];
        [app.tabBarVC.view addSubview:viewDown];
        viewDown.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAddClicked:)];
        [viewDown addGestureRecognizer:tapView];
        
        labelMonkey = [CreatView creatWithLabelFrame:CGRectMake(0, 0, viewDown.frame.size.width, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:27] text:[NSString stringWithFormat:@"%@猴币", @"+66"]];
        [viewDown addSubview:labelMonkey];
        
        imageSign = [CreatView creatImageViewWithFrame:CGRectMake(0, 30, viewDown.frame.size.width, viewDown.frame.size.height - 30) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"doSign"]];
        [viewDown addSubview:imageSign];
        imageSign.userInteractionEnabled = YES;
        
        CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animation.duration = 0.5;
        
        NSMutableArray *values = [NSMutableArray array];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
        animation.values = values;
        [viewDown.layer addAnimation:animation forKey:nil];
//    }
}

//公告数据
#pragma mark data````````````````````````````````````````````````````````````````
- (void)getNoticeData
{
    if (!GGFlag) {
        NSDictionary *parmeter = @{@"type":@1};
        [[MyAfHTTPClient sharedClient] postWithURLString:@"notice/getNoticeList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            
            NSLog(@"首页公告::::::::%@", responseObject);
            if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
                NSMutableArray *dataArr = [responseObject objectForKey:@"noticeInfo"];
                
                timerNotice = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
                
                if (dataArr.count != 0) {
                    
                    for (NSDictionary *dataDic in dataArr) {
                        messageModel = [[TWOMessageModel alloc] init];
                        [messageModel setValuesForKeysWithDictionary:dataDic];
                        [noticeArray addObject:messageModel];
                    }

                    [self noticeContentShow];
                    GGFlag = YES;
                    
                }
                
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
    }
}

//
- (void)tapAddClicked:(UITapGestureRecognizer *)tap
{
    [buttonHei removeFromSuperview];
    [viewDown removeFromSuperview];
    [labelMonkey removeFromSuperview];
    [imageSign removeFromSuperview];
    
    buttonHei = nil;
    viewDown = nil;
    labelMonkey = nil;
    imageSign = nil;
}

//上半部分的视图
- (void)upContentShow
{
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 30)];
        _scrollView.contentSize = CGSizeMake(1, HEIGHT_CONTROLLER_DEFAULT + 90);
        _scrollView.scrollEnabled = YES;
        _scrollView.delegate = self;
        [self.view addSubview:_scrollView];
        
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 568) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT )];
        _scrollView.contentSize = CGSizeMake(1, HEIGHT_CONTROLLER_DEFAULT + 60);
        _scrollView.scrollEnabled = YES;
        _scrollView.delegate = self;
        [self.view addSubview:_scrollView];
    } else {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT)];
        _scrollView.scrollEnabled = NO;
        _scrollView.delegate = self;
        [self.view addSubview:_scrollView];
    }
    
    [_scrollView setHidden:YES];
    
//    轮播banner的位置
    viewBanner = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 180.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    [_scrollView addSubview:viewBanner];
    viewBanner.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageBanner = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, viewBanner.frame.size.height) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"首页banner"]];
//    [viewBanner addSubview:imageBanner];
    imageBanner.userInteractionEnabled = YES;
    
//    公告位置
    viewNotice = [[UIView alloc] initWithFrame:CGRectMake(0, viewBanner.frame.size.height, WIDTH_CONTROLLER_DEFAULT, 32.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
//    [viewBanner addSubview:viewNotice];
    viewNotice.userInteractionEnabled = YES;
    viewNotice.backgroundColor = [UIColor whiteColor];
    
    CGFloat noticeHeight = 17.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20);
    
    UIView *whiteBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, viewBanner.frame.size.height, 9 + 17.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 5, 32.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    [_scrollView addSubview:whiteBackgroundView];
    whiteBackgroundView.backgroundColor = Color_White;
    
//    公告图标
    UIImageView *imageNotice = [CreatView creatImageViewWithFrame:CGRectMake(9, 8, noticeHeight, noticeHeight) backGroundColor:Color_White setImage:[UIImage imageNamed:@"公告"]];
    [whiteBackgroundView addSubview:imageNotice];
    
//    公告view分界线
    UIView *viewLineNotice = [[UIView alloc] initWithFrame:CGRectMake(0, viewBanner.frame.size.height - 1, WIDTH_CONTROLLER_DEFAULT, 1)];
    [_scrollView addSubview:viewLineNotice];
    viewLineNotice.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    NSArray *imageArr = @[@"每日一摇", @"邀请好友"];
    
    for (int i = 0; i < 2; i++) {
        buttonClick = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.view addSubview:buttonClick];
        if (HEIGHT_CONTROLLER_DEFAULT - 20.0 == 480) {
            buttonClick.frame = CGRectMake(9 + (WIDTH_CONTROLLER_DEFAULT - 27)/2.0 * i + 9 * i, viewBanner.frame.size.height + viewNotice.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), (WIDTH_CONTROLLER_DEFAULT - 27)/2.0, 80.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT);
        } else if (HEIGHT_CONTROLLER_DEFAULT - 20.0 == 568) {
            buttonClick.frame = CGRectMake(9 + (WIDTH_CONTROLLER_DEFAULT - 27)/2.0 * i + 9 * i, viewBanner.frame.size.height + viewNotice.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), (WIDTH_CONTROLLER_DEFAULT - 27)/2.0, 74.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT);
        } else {
            buttonClick.frame = CGRectMake(9 + (WIDTH_CONTROLLER_DEFAULT - 27)/2.0 * i + 9 * i, viewBanner.frame.size.height + viewNotice.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), (WIDTH_CONTROLLER_DEFAULT - 27)/2.0, 73.0 / 667.0 * HEIGHT_CONTROLLER_DEFAULT);
        }
        buttonClick.backgroundColor = [UIColor qianhuise];
        buttonClick.tag = 1000 + i;
        [buttonClick setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [imageArr objectAtIndex:i]]] forState:UIControlStateNormal];
        [buttonClick setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [imageArr objectAtIndex:i]]] forState:UIControlStateHighlighted];
        [buttonClick addTarget:self action:@selector(buttonClickedChoose:) forControlEvents:UIControlEventTouchUpInside];
        
        [_scrollView addSubview:buttonClick];
    }
    
//    [_scrollView addSubview:viewBanner];
//    [_scrollView addSubview:viewNotice];
}

//首页公告视图
- (void)noticeContentShow
{
    _scrollViewNotice = [[UIScrollView alloc] initWithFrame:CGRectMake(9 + 17.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 5, viewBanner.frame.size.height, WIDTH_CONTROLLER_DEFAULT, 32.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    [_scrollView addSubview:_scrollViewNotice];
    _scrollViewNotice.backgroundColor = Color_White;
    _scrollViewNotice.contentOffset = CGPointMake(1, 30);
    _scrollViewNotice.contentSize = CGSizeMake(1, 30 * (noticeArray.count + 2));
    _scrollViewNotice.delegate = self;
    _scrollViewNotice.userInteractionEnabled = YES;
    
    for (int i = 1; i <= noticeArray.count; i++) {
        UILabel *labelNotice = [CreatView creatWithLabelFrame:CGRectMake(0, 30 * i + 1, _scrollViewNotice.frame.size.width - 50, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:[[noticeArray objectAtIndex:i - 1] title]];
        [_scrollViewNotice addSubview:labelNotice];
        labelNotice.userInteractionEnabled = YES;
        labelNotice.exclusiveTouch = YES;
        UITapGestureRecognizer *gensture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTapAction)];
        gensture.delegate = self;
        [labelNotice addGestureRecognizer:gensture];
    }
    
    UILabel *labelLast = [CreatView creatWithLabelFrame:CGRectMake(0, 30 * 4, _scrollViewNotice.frame.size.width, 30) backgroundColor:Color_White textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:[[noticeArray objectAtIndex:0] title]];
    [_scrollViewNotice addSubview:labelLast];
    UITapGestureRecognizer *gensture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTapAction)];
    gensture.delegate = self;
    labelLast.userInteractionEnabled = YES;
    labelLast.exclusiveTouch = YES;
    [labelLast addGestureRecognizer:gensture];
    
    if (noticeArray.count >= 3){
        everyNum = 3 + 2;
        secondsNum = 3;
    } else {
        everyNum = noticeArray.count + 2;
        secondsNum = noticeArray.count;
    }
}

- (void)scrollViewTapAction
{
    if (noticeArray.count >= 3) {
        if (secondsNum <= 0) {
            
            messageModel = [noticeArray objectAtIndex:0];
        } else {
            
            messageModel = [noticeArray objectAtIndex:3 - secondsNum];
        }
    } else {
        messageModel = [noticeArray objectAtIndex:noticeArray.count - secondsNum];
    }
    
    if (noticeArray.count >= 3) {
        
        if (_scrollViewNotice.contentOffset.y >= 120) {
            [_scrollViewNotice setContentOffset:CGPointMake(0, 30) animated:NO];
            secondsNum = 3;
        }
    } else {
        
        if (_scrollViewNotice.contentOffset.y >= noticeArray.count * 30 + 30) {
            [_scrollViewNotice setContentOffset:CGPointMake(0, 30) animated:NO];
            secondsNum = noticeArray.count;
        }
    }
    
    TWONoticeDetailViewController *messageDetailVC = [[TWONoticeDetailViewController alloc] init];
    messageDetailVC.messageID = [messageModel ID];
    pushVC(messageDetailVC);
    
}

-(void)timerFireMethod:(NSTimer *)theTimer
{
    [_scrollViewNotice setContentOffset:CGPointMake(0, 30 * (everyNum - secondsNum)) animated:YES];
    secondsNum--;
}

- (void)collectionViewShow
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(WIDTH_CONTROLLER_DEFAULT, 308);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    if (_collection == nil) {
        
        _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, viewBanner.frame.size.height + viewNotice.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + buttonClick.frame.size.height, WIDTH_CONTROLLER_DEFAULT, 308) collectionViewLayout:flowLayout];
        
        _collection.dataSource = self;
        _collection.delegate = self;
        _collection.bounces = NO;
        _collection.showsHorizontalScrollIndicator = NO;
        _collection.pagingEnabled = YES;
        _collection.backgroundColor = [UIColor whiteColor];
        //    默认显示中间
        _collection.contentOffset = CGPointMake(WIDTH_CONTROLLER_DEFAULT, 0);
        
        [_collection registerNib:[UINib nibWithNibName:@"TWOHomePageProductCell" bundle:nil] forCellWithReuseIdentifier:@"reuse"];
    } else {
        
        [_collection reloadData];
    }
    
    [_scrollView addSubview:_collection];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TWOHomePageProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    
    cell.imageBuying.image = [UIImage imageNamed:@"热卖"];
    cell.viewBottom.layer.cornerRadius = 5;
    cell.viewBottom.layer.masksToBounds = YES;
    cell.viewBottom.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
    cell.viewBottom.layer.borderWidth = 1;
    
    TWOPickModel *model = [pickArray objectAtIndex:indexPath.item];
    
    if ([[[model isHotSale] description] isEqualToString:@"0"]) {
        cell.imageBuying.hidden = YES;
    } else {
        cell.imageBuying.hidden = NO;
    }
    
    cell.labelName.text = [model productName];
    
    [cell.butQuanQuan setBackgroundImage:[UIImage imageNamed:@"产品圈圈"] forState:UIControlStateNormal];
    [cell.butQuanQuan setBackgroundImage:[UIImage imageNamed:@"产品圈圈"] forState:UIControlStateHighlighted];
    cell.butQuanQuan.backgroundColor = [UIColor clearColor];
    NSMutableAttributedString *butString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%", [model annualYield]]];
    NSRange leftRange = NSMakeRange(0, [[butString string] rangeOfString:@"%"].location);
    [butString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:40] range:leftRange];
    [butString addAttribute:NSForegroundColorAttributeName value:[UIColor profitColor] range:leftRange];
    NSRange rightRange = NSMakeRange([[butString string] length] - 1, 1);
    [butString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:rightRange];
    [butString addAttribute:NSForegroundColorAttributeName value:[UIColor profitColor] range:rightRange];
    [cell.butQuanQuan setAttributedTitle:butString forState:UIControlStateNormal];
    cell.butQuanQuan.enabled = NO;
    
    cell.butLeft.tag = indexPath.item + 20;
    [cell.butLeft setBackgroundImage:[UIImage imageNamed:@"首页左箭头"] forState:UIControlStateNormal];
    [cell.butLeft setBackgroundImage:[UIImage imageNamed:@"首页左箭头"] forState:UIControlStateHighlighted];
    [cell.butLeft addTarget:self action:@selector(buttonLeftClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.butRight.tag = indexPath.item + 30;
    [cell.butRight setBackgroundImage:[UIImage imageNamed:@"首页右箭头"] forState:UIControlStateNormal];
    [cell.butRight setBackgroundImage:[UIImage imageNamed:@"首页右箭头"] forState:UIControlStateHighlighted];
    [cell.butRight addTarget:self action:@selector(buttonRightClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if (indexPath.item == 0) {
        cell.butLeft.hidden = YES;
    } else {
        cell.butLeft.hidden = NO;
    }
    
    if (indexPath.item == 2) {
        cell.butRight.hidden = YES;
    } else {
        cell.butRight.hidden = NO;
    }
        
    [self changeColorAndSize:[NSString stringWithFormat:@"%@天",[model period]] label:cell.labelData length:1];
    
    residueMoneyString = [[model residueMoney] stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    residueMoney = [[[model residueMoney] stringByReplacingOccurrencesOfString:@"," withString:@""] floatValue];
    
    if (residueMoney / 10000.0 > 0) {
        
        residueMoney = residueMoney / 10000.0;
        
        [self changeColorAndSize:[NSString stringWithFormat:@"%.2lf万元",residueMoney] label:cell.labelLastMoney length:2];
    } else {
        
        [self changeColorAndSize:[NSString stringWithFormat:@"%.0lf元",residueMoney] label:cell.labelLastMoney length:1];
    }
    
    [self changeColorAndSize:[NSString stringWithFormat:@"%d元",[[[model startMoney] stringByReplacingOccurrencesOfString:@"," withString:@""] intValue]] label:cell.labelQiTou length:1];
        
    cell.labelYuQi.text = @"预期年化收益率";
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        cell.labelYuQi.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    }
    cell.labelDownONe.text = @"理财期限";
    cell.labelDownMid.text = @"剩余可投";
    cell.labelDownRight.text = @"起投资金";
    
    [cell.butRightNow setBackgroundColor:[UIColor profitColor]];
    cell.butRightNow.layer.cornerRadius = 20;
    cell.butRightNow.layer.masksToBounds = YES;
    [cell.butRightNow setTitle:@"立即抢购" forState:UIControlStateNormal];
    cell.butRightNow.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [cell.butRightNow addTarget:self action:@selector(rightQiangGou:) forControlEvents:UIControlEventTouchUpInside];
        
    cell.backgroundColor = [UIColor qianhuise];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat pageNumber = _collection.contentOffset.x / WIDTH_CONTROLLER_DEFAULT;
    
    TWOPickModel *pickModel = [pickArray objectAtIndex:pageNumber];
    
    [MobClick event:@"jxproduct"];
    
    TWOProductDetailViewController *productDetailVC = [[TWOProductDetailViewController alloc] init];
    productDetailVC.idString = [pickModel productId];
    productDetailVC.productName = [pickModel productName];
    productDetailVC.residueMoney = residueMoneyString;
    
    if ([[[pickModel productType] description] isEqualToString:@"3"]) {
        productDetailVC.estimate = NO;
    } else {
        productDetailVC.estimate = YES;
    }
    
    pushVC(productDetailVC);
}

//封装改变字体大小
- (void)changeColorAndSize:(NSString *)string label:(UILabel *)label length:(NSInteger)num
{
    NSMutableAttributedString *changeString = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange leftRange = NSMakeRange([[changeString string] length] - num, num);
    [changeString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:12] range:leftRange];
    [changeString addAttribute:NSForegroundColorAttributeName value:[UIColor findZiTiColor] range:leftRange];
    [label setAttributedText:changeString];
}

//黑色遮罩层消失
- (void)clickedBlackDisappear:(UIButton *)button
{
    [buttonHei removeFromSuperview];
    [viewDown removeFromSuperview];
    [labelMonkey removeFromSuperview];
    [imageSign removeFromSuperview];
    
    buttonHei = nil;
    viewDown = nil;
    labelMonkey = nil;
    imageSign = nil;
}

//签到记录
- (void)signRecordButton:(UIButton *)button
{
    NSDictionary *dicLogin = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"isLogin.plist"]];
    
    if ([[dicLogin objectForKey:@"loginFlag"] isEqualToString:@"NO"]) {
        TWOLoginAPPViewController *loginVC = [[TWOLoginAPPViewController alloc] init];
        
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [nvc setNavigationBarHidden:YES animated:YES];
        
        [self presentViewController:nvc animated:YES completion:^{
            
        }];
        return;
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    [MobClick event:@"attendance"];
    
    TSignInViewController *signInVC = [[TSignInViewController alloc] init];
    signInVC.tokenString = [dic objectForKey:@"token"];
    [self.navigationController pushViewController:signInVC animated:YES];
}

//每日一摇和邀请好友点击方法
- (void)buttonClickedChoose:(UIButton *)button
{
    if (button.tag == 1000) {
        [MobClick event:@"shake"];
        
        TWOYaoYiYaoViewController *yaoyiyaoVC = [[TWOYaoYiYaoViewController alloc] init];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
        yaoyiyaoVC.invitationCode = [dic objectForKey:@"invitationMyCode"];
        [self.navigationController pushViewController:yaoyiyaoVC animated:YES];
        
    } else {
        
        NSDictionary *loginDic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"isLogin.plist"]];
        
        if ([[loginDic objectForKey:@"loginFlag"] isEqualToString:@"NO"]) {
            
            AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
            
            TWOLoginAPPViewController *loginVC = [[TWOLoginAPPViewController alloc] init];
            
            UINavigationController *nvc=[[UINavigationController alloc] initWithRootViewController:loginVC];
            [nvc setNavigationBarHidden:YES animated:YES];
            
            [app.tabBarVC presentViewController:nvc animated:YES completion:^{
                
            }];
            return;
        }
        
        [MobClick event:@"Ginvite"];
        
        NewInviteViewController *inviteVc = [[NewInviteViewController alloc] init];
        
        [self.navigationController pushViewController:inviteVc animated:YES];
    }
}

//左按钮点击方法
- (void)buttonLeftClicked:(UIButton *)button
{
    CGFloat pageNumber = _collection.contentOffset.x / WIDTH_CONTROLLER_DEFAULT;
    
    if (_collection.contentOffset.x == 0) {
    } else {
        [_collection setContentOffset:CGPointMake(WIDTH_CONTROLLER_DEFAULT * (pageNumber - 1), 0) animated:YES];
    }
}

//右按钮点击方法
- (void)buttonRightClicked:(UIButton *)button
{
    CGFloat pageNumber = _collection.contentOffset.x / WIDTH_CONTROLLER_DEFAULT;
    
    if (_collection.contentOffset.x == WIDTH_CONTROLLER_DEFAULT * 2) {
    } else {
        [_collection setContentOffset:CGPointMake(WIDTH_CONTROLLER_DEFAULT * (pageNumber + 1), 0) animated:YES];
    }
}

//立即抢购按钮
- (void)rightQiangGou:(UIButton *)button
{
    CGFloat pageNumber = _collection.contentOffset.x / WIDTH_CONTROLLER_DEFAULT;
    
    TWOPickModel *pickModel = [pickArray objectAtIndex:pageNumber];
    
    [MobClick event:@"jxproduct"];
    
    TWOProductDetailViewController *productDetailVC = [[TWOProductDetailViewController alloc] init];
    productDetailVC.idString = [pickModel productId];
    productDetailVC.productName = [pickModel productName];
    productDetailVC.residueMoney = residueMoneyString;
    
    if ([[[pickModel productType] description] isEqualToString:@"3"]) {
        productDetailVC.estimate = NO;
    } else {
        productDetailVC.estimate = YES;
    }
    
    pushVC(productDetailVC);
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _scrollViewNotice) {
        
        scrollView.panGestureRecognizer.enabled = NO;
    } else {
    
        if (_scrollView.contentOffset.y < 0) {
            _scrollView.scrollEnabled = NO;
        } else {
            _scrollView.scrollEnabled = YES;
        }
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
    
    [viewBanner addSubview:bannerScrollView];
    
    YYAnimatedImageView *bannerFirst = [YYAnimatedImageView new];
    bannerFirst.yy_imageURL = [NSURL URLWithString:[[photoArray objectAtIndex:0] adImg]];
    bannerFirst.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * (photoArray.count + 1), 0, WIDTH_CONTROLLER_DEFAULT, 180.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20));
    
    YYAnimatedImageView *bannerLast = [YYAnimatedImageView new];
    bannerLast.yy_imageURL = [NSURL URLWithString:[[photoArray objectAtIndex:photoArray.count - 1] adImg]];
    bannerLast.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 180.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20));
    
    for (NSInteger i = 0; i < photoArray.count; i++) {
        YYAnimatedImageView *bannerObject = [YYAnimatedImageView new];
        bannerObject.yy_imageURL = [NSURL URLWithString:[[photoArray objectAtIndex:i] adImg]];
        bannerObject.tag = i;
        bannerObject.frame = CGRectMake(WIDTH_CONTROLLER_DEFAULT * (i + 1), 0, WIDTH_CONTROLLER_DEFAULT, 180.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20));
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
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 150.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 30)];
    
    pageControl.numberOfPages = photoArray.count;
    pageControl.currentPage = 0;
    
    [self changePageControlImage];
    
    [viewBanner addSubview:pageControl];
    
    //    签到记录按钮
    UIButton *buttonSign = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 71.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 20, 71.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 53.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [viewBanner addSubview:buttonSign];
    [buttonSign setBackgroundImage:[UIImage imageNamed:@"signrecord"] forState:UIControlStateNormal];
    [buttonSign setBackgroundImage:[UIImage imageNamed:@"signrecord"] forState:UIControlStateHighlighted];
    [buttonSign addTarget:self action:@selector(signRecordButton:) forControlEvents:UIControlEventTouchUpInside];
    
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
    [MobClick event:@"banner"];
    
    BannerViewController *bannerVC = [[BannerViewController alloc] init];
    bannerVC.photoName = [[photoArray objectAtIndex:pageControl.currentPage] adLabel];
    bannerVC.photoUrl = [[photoArray objectAtIndex:pageControl.currentPage] adLink];
    bannerVC.page = pageControl.currentPage;
    
//    NSLog(@"--=-=-=--%@,%@,%ld",[[photoArray objectAtIndex:pageControl.currentPage] adLabel],[[photoArray objectAtIndex:pageControl.currentPage] adLink],pageControl.currentPage);
    
    pushVC(bannerVC);
}

// 拖住完成的执行方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (bannerScrollView == scrollView) {
        timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(scrollViewFuction) userInfo:nil repeats:YES];
        
        // 修改timer的优先级与控件一致
        // 获取当前的消息循环对象
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        // 更改timer对象的优先级
        [runLoop addTimer:timer forMode:NSRunLoopCommonModes];
    }
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

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView == _scrollViewNotice) {
        
        if (noticeArray.count >= 3) {
            
            if (_scrollViewNotice.contentOffset.y >= 120) {
                [_scrollViewNotice setContentOffset:CGPointMake(0, 30) animated:NO];
                secondsNum = 3;
            }
        } else {
            
            if (_scrollViewNotice.contentOffset.y >= noticeArray.count * 30 + 30) {
                [_scrollViewNotice setContentOffset:CGPointMake(0, 30) animated:NO];
                secondsNum = noticeArray.count;
            }
        }
        
        
    } else {
        
        CGPoint offset = [scrollView contentOffset];
        
        if (offset.x == WIDTH_CONTROLLER_DEFAULT * (photoArray.count + 1)) {
            [bannerScrollView setContentOffset:CGPointMake(WIDTH_CONTROLLER_DEFAULT, 0) animated:NO];
            pageControl.currentPage = 0;
        } else if (offset.x == 0) {
            [bannerScrollView setContentOffset:CGPointMake(WIDTH_CONTROLLER_DEFAULT * photoArray.count, 0) animated:NO];
            pageControl.currentPage = photoArray.count - 1;
        }
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

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getProductList{
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    if ([FileOfManage ExistOfFile:@"Member.plist"] && [dic objectForKey:@"token"] != nil) {
        
        parameter = @{@"token":[dic objectForKey:@"token"]};
        
        [[MyAfHTTPClient sharedClient] postWithURLString:@"product/getPickProduct" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            
            NSLog(@"first = %@",responseObject);
            
            [self loadingWithHidden:YES];
            
            if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                //                [self loadingWithHidden:YES];
                
                NSArray *pickArr = [responseObject objectForKey:@"Product"];
                
                for (NSDictionary *dic in pickArr) {
                    TWOPickModel *model = [[TWOPickModel alloc] init];
                    [model setValuesForKeysWithDictionary:dic];
                    [pickArray addObject:model];
                }
                
                
                if (pickArray.count != 0) {
                    
                    if (pickArray.count < 3) {
                        return ;
                    }
                    
                    [pickArray exchangeObjectAtIndex:0 withObjectAtIndex:1];
                    
                    [self collectionViewShow];
                    noNetworkMonkey.hidden = YES;
                    reloadButton.hidden = YES;
                    [_scrollView setHidden:NO];
                } else {
                    
//                    [self noDataShowMoney];
//                    [_scrollView setHidden:YES];
                }
                
            } else {
                [self loadingWithHidden:YES];
                [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self loadingWithHidden:YES];
            NSLog(@"%@", error);
            
        }];
    } else {
        [[MyAfHTTPClient sharedClient] postWithURLString:@"product/getPickProduct" parameters:nil success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
            
            [self loadingWithHidden:YES];
            NSLog(@"first = %@",responseObject);
            
            if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
                
                NSArray *pickArr = [responseObject objectForKey:@"Product"];
                
                for (NSDictionary *dic in pickArr) {
                    TWOPickModel *model = [[TWOPickModel alloc] init];
                    [model setValuesForKeysWithDictionary:dic];
                    [pickArray addObject:model];
                }
                
                if (pickArray.count != 0) {
                    
                    if (pickArray.count < 3) {
                        return ;
                    }
                    
                    [pickArray exchangeObjectAtIndex:0 withObjectAtIndex:1];
                    
                    [self collectionViewShow];
                    noNetworkMonkey.hidden = YES;
                    reloadButton.hidden = YES;
                    [_scrollView setHidden:NO];
                } else {
                    
//                    [self noDataShowMoney];
//                    [_scrollView setHidden:YES];
                }
                
            } else {
                [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [self loadingWithHidden:YES];
            NSLog(@"%@", error);
        }];
    }
    
}

- (void)getAdvList{
    
    NSDictionary *parmeter = @{@"adType":@"2",@"adPosition":@"3"};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"front/getAdvList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        [self loadingWithHidden:YES];
        
        NSLog(@"AD = %@",responseObject);
        
        noNetworkMonkey.hidden = YES;
        reloadButton.hidden = YES;

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
        
        if (photoArray.count != 0) {
            
            [self upContentShow];
            [_scrollView setHidden:NO];
            
            [self getProductList];
            [self makeScrollView];
            
            timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(scrollViewFuction) userInfo:nil repeats:YES];
            
            [self getNoticeData];
            
        } else {
            
            [self upContentShow];
            [_scrollView setHidden:NO];
            [self getNoticeData];
            [self getProductList];
        }
        
        noNetworkMonkey.hidden = YES;
        reloadButton.hidden = YES;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self loadingWithHidden:YES];
        [self noNetworkView];
        NSLog(@"%@", error);
        
    }];
}

- (void)noDataShowMoney
{
    
    [_scrollView setHidden:YES];
    
    if (imageMonkey == nil) {
        imageMonkey = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 284/2/2, self.view.center.y - 284/2/2, 284/2, 284/2) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"noWithData"]];
    }
    [self.view addSubview:imageMonkey];
}

- (void)noNetworkView {
    
    [_scrollView setHidden:YES];
    
    if (noNetworkMonkey == nil) {
        noNetworkMonkey = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 413/2.0/2.0, 164, 413/2.0, 268/2.0) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"TWONoPower"]];
    }
    [self.view addSubview:noNetworkMonkey];
    
    if (reloadButton == nil) {
        
        reloadButton = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * 0.5 - 75, CGRectGetMaxY(noNetworkMonkey.frame) + 10, 140, 35) backgroundColor:[UIColor clearColor] textColor:Color_White titleText:nil];
        
        reloadButton.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        [reloadButton setBackgroundImage:[UIImage imageNamed:@"TWORefrush"] forState:UIControlStateNormal];
        [reloadButton setBackgroundImage:[UIImage imageNamed:@"TWORefrush"] forState:UIControlStateHighlighted];
        
        [reloadButton addTarget:self action:@selector(getAdvList) forControlEvents:UIControlEventTouchUpInside];
    }
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

- (void)networkDidSetup:(NSNotification *)notification {
    NSLog(@"已连接");
}

- (void)networkDidClose:(NSNotification *)notification {
    NSLog(@"未连接");
}

- (void)networkDidRegister:(NSNotification *)notification {
    NSLog(@"%@", [notification userInfo]);
    NSLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification *)notification {

    NSLog(@"已登录");
    
    if ([JPUSHService registrationID]) {
        NSLog(@"get RegistrationID");
    }
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSLog(@"networkDidReceiveMessage");
}

- (void)serviceError:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSString *error = [userInfo valueForKey:@"error"];
    NSLog(@"%@", error);
}

- (void)pushGongGaoViewController:(NSNotification *)not{
    
    NSDictionary *userInfo = [not object];
    
    NSLog(@"GuserInfo = %@",userInfo);
    
    TWONoticeDetailViewController *messageDetailVC = [[TWONoticeDetailViewController alloc] init];
    messageDetailVC.messageID = [userInfo objectForKey:@"id"];
    pushVC(messageDetailVC);
    
}

- (void)pushHFiveViewController:(NSNotification *)not{
    
    NSDictionary *userInfo = [not object];
    
    NSLog(@"HuserInfo = %@",userInfo);
    
    BannerViewController *bannerVC = [[BannerViewController alloc] init];
    bannerVC.photoName = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    bannerVC.photoUrl = [userInfo objectForKey:@"url"];
    pushVC(bannerVC);
    
}

- (void)goToOpenAccount{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSString *dateString = [dic objectForKey:@"registerTime"];
    
    NSLog(@"chinaPnrAcc = %@",[dic objectForKey:@"chinaPnrAcc"]);
    NSLog(@"dateStringWithChinaCompareDate = %d",[self compareDate:dateString]);
    
    if ([[dic objectForKey:@"chinaPnrAcc"] isEqualToString:@""] && [self compareDate:dateString] == 1) {
        
        [self registThirdShow];
        return;
    }
}

//开通托管账户弹框
- (void)registThirdShow
{
    AppDelegate *app  = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    buttBlack = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
    [app.tabBarVC.view addSubview:buttBlack];
    buttBlack.alpha = 0.5;
    [buttBlack addTarget:self action:@selector(buttonViewDisappear:) forControlEvents:UIControlEventTouchUpInside];
    
    viewThirdOpen = [CreatView creatViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 310/2, HEIGHT_CONTROLLER_DEFAULT/3, 310, 228) backgroundColor:[UIColor whiteColor]];
    [app.tabBarVC.view addSubview:viewThirdOpen];
    viewThirdOpen.layer.cornerRadius = 4;
    viewThirdOpen.layer.masksToBounds = YES;
    
    UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(0, 3, viewThirdOpen.frame.size.width, 45) backgroundColor:[UIColor whiteColor] textColor:[UIColor profitColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:16] text:@"请激活汇付账户\n以便正常查询账户余额"];
    labelAlert.numberOfLines = 2;
    [viewThirdOpen addSubview:labelAlert];
    
    UIImageView *imageImg = [CreatView creatImageViewWithFrame:CGRectMake(viewThirdOpen.frame.size.width/2 - 314/2/2, 50, 314/2, 234/2) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"thirdimg"]];
    [viewThirdOpen addSubview:imageImg];
    
    UIButton *buttonok = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(12, 45 + imageImg.frame.size.height + 15, viewThirdOpen.frame.size.width - 24, 40) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"去激活"];
    [viewThirdOpen addSubview:buttonok];
    buttonok.layer.cornerRadius = 4;
    buttonok.layer.masksToBounds = YES;
    buttonok.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonok addTarget:self action:@selector(buttonOpenThirdOK:) forControlEvents:UIControlEventTouchUpInside];
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [viewThirdOpen.layer addAnimation:animation forKey:nil];
    
}

//开通三方确定按钮
- (void)buttonOpenThirdOK:(UIButton *)button
{
    [buttBlack removeFromSuperview];
    [viewThirdOpen removeFromSuperview];
    
    buttBlack = nil;
    viewThirdOpen = nil;
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.tabBarVC.tabScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    
    UIButton *indexButton = [app.tabBarVC.tabButtonArray objectAtIndex:0];
    
    for (UIButton *tempButton in app.tabBarVC.tabButtonArray) {
        
        if (indexButton.tag != tempButton.tag) {
            NSLog(@"%ld",(long)tempButton.tag);
            [tempButton setSelected:NO];
        }
    }
    
    [indexButton setSelected:YES];
    
    [app.tabBarVC setTabbarViewHidden:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
//    double delayInSeconds = 0.1;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        TWOProductHuiFuViewController *productHuiFuVC = [[TWOProductHuiFuViewController alloc] init];
        productHuiFuVC.fuctionName = @"userReg";
        pushVC(productHuiFuVC);
//    });
    
    
    
}

//开通三方弹框点击消失
- (void)buttonViewDisappear:(UIButton *)button
{
    [buttBlack removeFromSuperview];
    [viewThirdOpen removeFromSuperview];
    
    buttBlack = nil;
    viewThirdOpen = nil;
}

- (int)compareDate:(NSString*)date01{
    int ci;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMdd"];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    NSLog(@"%@----",date01);
    date01 = [date01 substringToIndex:8];
    NSLog(@"%@----",date01);
    dt1 = [df dateFromString:date01];
    dt2 = [df dateFromString:@"20160805"];
    
    NSLog(@"%@----%@",dt1,dt2);
    
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending: ci = 1;
            break;
            //date02比date01小
        case NSOrderedDescending: ci = -1;
            break;
            //date02=date01
        case NSOrderedSame: ci = 0;
            break;
        default: NSLog(@"erorr dates %@, %@", dt2, dt1); break;
    }
    return ci;
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
