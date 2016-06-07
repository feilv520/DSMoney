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

@interface TWOSelectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

{
    UIButton *buttonClick;
    UIScrollView *scrollView;
    UIView *viewBottom;
    UIButton *buttonHei;
    UILabel *labelMonkey;
    UIImageView *imageSign;
    UIView *viewBanner;
    UIView *viewNotice;
    UICollectionView *_collection;
}

@end

@implementation TWOSelectionViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor qianhuise];
    
    [self signFinish];
    [self upContentShow];
    [self collectionViewShow];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLoginView) name:@"showLoginView" object:nil];
}

//签到成功
- (void)signFinish
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    buttonHei = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, self.view.frame.size.height) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
    [app.tabBarVC.view addSubview:buttonHei];
    buttonHei.alpha = 0.6;
    [buttonHei addTarget:self action:@selector(clickedBlackDisappear:) forControlEvents:UIControlEventTouchUpInside];
    
    labelMonkey = [CreatView creatWithLabelFrame:CGRectMake(0, 194.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:27] text:[NSString stringWithFormat:@"%@猴币", @"+66"]];
    [app.tabBarVC.view addSubview:labelMonkey];
    
    imageSign = [CreatView creatImageViewWithFrame:CGRectMake(40, 194.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 30, WIDTH_CONTROLLER_DEFAULT - 80, 230) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"doSign"]];
    [app.tabBarVC.view addSubview:imageSign];
}

//上半部分的视图
- (void)upContentShow
{
//    轮播banner的位置
    viewBanner = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 180.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    [self.view addSubview:viewBanner];
    viewBanner.backgroundColor = [UIColor qianhuise];
    
    UIImageView *imageBanner = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, viewBanner.frame.size.height) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"首页banner"]];
    [viewBanner addSubview:imageBanner];
    
//    公告位置
    viewNotice = [[UIView alloc] initWithFrame:CGRectMake(0, viewBanner.frame.size.height, WIDTH_CONTROLLER_DEFAULT, 32.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    [self.view addSubview:viewNotice];
    viewNotice.backgroundColor = [UIColor whiteColor];
    
    CGFloat noticeHeight = 17.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20);
//    公告图标
    UIImageView *imageNotice = [CreatView creatImageViewWithFrame:CGRectMake(6, (viewNotice.frame.size.height - noticeHeight)/2, noticeHeight, noticeHeight) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"公告"]];
    [viewNotice addSubview:imageNotice];
    
//    公告view分界线
    UIView *viewLineNotice = [[UIView alloc] initWithFrame:CGRectMake(0, viewNotice.frame.size.height - 0.5, WIDTH_CONTROLLER_DEFAULT, 0.5)];
    [viewNotice addSubview:viewLineNotice];
    viewLineNotice.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    NSArray *imageArr = @[@"每日一摇", @"邀请好友"];
    
    for (int i = 0; i < 2; i++) {
        buttonClick = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:buttonClick];
        buttonClick.frame = CGRectMake(9 + (WIDTH_CONTROLLER_DEFAULT - 27)/2.0 * i + 9 * i, viewBanner.frame.size.height + viewNotice.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), (WIDTH_CONTROLLER_DEFAULT - 27)/2.0, 73.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20));
        buttonClick.backgroundColor = [UIColor qianhuise];
        buttonClick.tag = 1000 + i;
        [buttonClick setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [imageArr objectAtIndex:i]]] forState:UIControlStateNormal];
        [buttonClick setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [imageArr objectAtIndex:i]]] forState:UIControlStateHighlighted];
        [buttonClick addTarget:self action:@selector(buttonClickedChoose:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)collectionViewShow
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(WIDTH_CONTROLLER_DEFAULT, 308.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20));
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, viewBanner.frame.size.height + viewNotice.frame.size.height + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + buttonClick.frame.size.height, WIDTH_CONTROLLER_DEFAULT, 308.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) collectionViewLayout:flowLayout];
    [self.view addSubview:_collection];
    _collection.dataSource = self;
    _collection.delegate = self;
    _collection.bounces = NO;
    _collection.showsHorizontalScrollIndicator = NO;
    _collection.pagingEnabled = YES;
    _collection.backgroundColor = [UIColor whiteColor];
    [_collection registerNib:[UINib nibWithNibName:@"TWOHomePageProductCell" bundle:nil] forCellWithReuseIdentifier:@"reuse"];
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
    
    NSArray *nameArray = @[@"美猴王001期", @"金斗云77期", @"3个月齐系列"];
    cell.labelName.text = [nameArray objectAtIndex:indexPath.item];
    
    [cell.butQuanQuan setBackgroundImage:[UIImage imageNamed:@"产品圈圈"] forState:UIControlStateNormal];
    cell.butQuanQuan.backgroundColor = [UIColor clearColor];
    NSMutableAttributedString *butString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%", @"11.5"]];
    NSRange leftRange = NSMakeRange(0, [[butString string] rangeOfString:@"%"].location);
    [butString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:40] range:leftRange];
    [butString addAttribute:NSForegroundColorAttributeName value:[UIColor profitColor] range:leftRange];
    NSRange rightRange = NSMakeRange([[butString string] length] - 1, 1);
    [butString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:rightRange];
    [butString addAttribute:NSForegroundColorAttributeName value:[UIColor profitColor] range:rightRange];
    [cell.butQuanQuan setAttributedTitle:butString forState:UIControlStateNormal];
    
    [cell.butLeft setBackgroundImage:[UIImage imageNamed:@"首页左箭头"] forState:UIControlStateNormal];
    [cell.butLeft setBackgroundImage:[UIImage imageNamed:@"首页左箭头"] forState:UIControlStateHighlighted];
    [cell.butLeft addTarget:self action:@selector(buttonLeftClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.butRight setBackgroundImage:[UIImage imageNamed:@"首页右箭头"] forState:UIControlStateNormal];
    [cell.butRight setBackgroundImage:[UIImage imageNamed:@"首页右箭头"] forState:UIControlStateHighlighted];
    [cell.butRight addTarget:self action:@selector(buttonRightClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self changeColorAndSize:@"3天" label:cell.labelData length:1];
    [self changeColorAndSize:@"24.3万元" label:cell.labelLastMoney length:2];
    [self changeColorAndSize:@"1,000元" label:cell.labelQiTou length:1];
    
    cell.labelYuQi.text = @"预期年化收益率";
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
    [labelMonkey removeFromSuperview];
    [imageSign removeFromSuperview];
    
    buttonHei = nil;
    labelMonkey = nil;
    imageSign = nil;
}

//每日一摇和邀请好友点击方法
- (void)buttonClickedChoose:(UIButton *)button
{
    if (button.tag == 1000) {
        TWOYaoYiYaoViewController *yaoyiyaoVC = [[TWOYaoYiYaoViewController alloc] init];
        [self.navigationController pushViewController:yaoyiyaoVC animated:YES];
    } else {
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
        [_collection setContentOffset:CGPointMake(WIDTH_CONTROLLER_DEFAULT * (pageNumber - 1), 1) animated:YES];
    }
}

//右按钮点击方法
- (void)buttonRightClicked:(UIButton *)button
{
    CGFloat pageNumber = _collection.contentOffset.x / WIDTH_CONTROLLER_DEFAULT;
    if (_collection.contentOffset.x == WIDTH_CONTROLLER_DEFAULT * 2) {
    } else {
        [_collection setContentOffset:CGPointMake(WIDTH_CONTROLLER_DEFAULT * (pageNumber + 1), 1) animated:YES];
    }
}

//立即抢购按钮
- (void)rightQiangGou:(UIButton *)button
{
    NSLog(@"qiang");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)showLoginView
{
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
