//
//  CashOtherFinViewController.m
//  DSLC
//
//  Created by ios on 15/11/5.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "CashOtherFinViewController.h"
#import "ShareEveryCell.h"
#import "ShareFailureViewController.h"

@interface CashOtherFinViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

{
    NSArray *contentArr;
    
    UIButton *butBlack;
    UIView *viewTanKuang;
    UICollectionView *collection;
    
    NSArray *imageArray;
    NSArray *nameArray;
    
    UIButton *butCancle;
}

@end

@implementation CashOtherFinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"支付完成"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(buttonNull:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishBarPress:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:13], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    [self contentShow];
}

- (void)contentShow
{
    contentArr = @[@"投资金额:10,000元", @"预期到期收益:200元", @"兑付日期:2015-02-03"];
    
    UIButton *butonDo = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 60, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] titleText:@"恭喜你投资成功"];
    [butonDo setImage:[UIImage imageNamed:@"iconfont_complete"] forState:UIControlStateNormal];
    [self.view addSubview:butonDo];
    butonDo.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    UIView *viewBottom = [CreatView creatViewWithFrame:CGRectMake(40, 120, WIDTH_CONTROLLER_DEFAULT - 80, 140) backgroundColor:[UIColor shurukuangColor]];
    [self.view addSubview:viewBottom];
    viewBottom.layer.cornerRadius = 5;
    viewBottom.layer.masksToBounds = YES;
    viewBottom.layer.borderColor = [[UIColor shurukuangBian] CGColor];
    viewBottom.layer.borderWidth = 0.5;
    
    UILabel *labelName = [CreatView creatWithLabelFrame:CGRectMake(0, 15, WIDTH_CONTROLLER_DEFAULT - 80, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"3个月固定投资"];
    [viewBottom addSubview:labelName];
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(0, 45 + 20 * i + 10 * i, WIDTH_CONTROLLER_DEFAULT - 80, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:[contentArr objectAtIndex:i]];
        [viewBottom addSubview:label];
    }
    
    UIButton *buttonGoOn = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 300, (WIDTH_CONTROLLER_DEFAULT - 80 - 10)/2, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor daohanglan] titleText:@"继续投资"];
    [self.view addSubview:buttonGoOn];
    buttonGoOn.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonGoOn.layer.cornerRadius = 3;
    buttonGoOn.layer.masksToBounds = YES;
    buttonGoOn.layer.borderColor = [[UIColor daohanglan] CGColor];
    buttonGoOn.layer.borderWidth = 0.5;
    [buttonGoOn addTarget:self action:@selector(finishBarPress:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonShare = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - 80 - 10)/2 + 50, 300, (WIDTH_CONTROLLER_DEFAULT - 80 - 10)/2, 40) backgroundColor:[UIColor daohanglan] textColor:[UIColor whiteColor] titleText:@"分享拿红包"];
    [self.view addSubview:buttonShare];
    buttonShare.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonShare.layer.cornerRadius = 3;
    buttonShare.layer.masksToBounds = YES;
    [buttonShare addTarget:self action:@selector(shareGetRedBag:) forControlEvents:UIControlEventTouchUpInside];
}

//分享拿红包
- (void)shareGetRedBag:(UIButton *)button
{
    butBlack = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC.view addSubview:butBlack];
    butBlack.alpha = 0.3;
    [butBlack addTarget:self action:@selector(makeButtonDisappear:) forControlEvents:UIControlEventTouchUpInside];
    
    viewTanKuang = [CreatView creatViewWithFrame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT - 330, WIDTH_CONTROLLER_DEFAULT, 330) backgroundColor:[UIColor whiteColor]];
    [app.tabBarVC.view addSubview:viewTanKuang];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(viewTanKuang.frame.size.width/3, (viewTanKuang.frame.size.height - 80)/2);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, viewTanKuang.frame.size.height - 59) collectionViewLayout:flowLayout];
    [viewTanKuang addSubview:collection];
    collection.dataSource = self;
    collection.delegate = self;
    collection.backgroundColor = [UIColor whiteColor];
    [collection registerNib:[UINib nibWithNibName:@"ShareEveryCell" bundle:nil] forCellWithReuseIdentifier:@"reuse"];
    
    nameArray = @[@"微信好友", @"新浪微博", @"朋友圈", @"人人网", @"QQ空间", @"腾讯微博"];
    imageArray = @[@"微信", @"新浪微博", @"朋友圈", @"人人网", @"QQ空间", @"腾讯微博"];
    
    butCancle = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, viewTanKuang.frame.size.height - 79, viewTanKuang.frame.size.width, 59) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] titleText:@"取消"];
    [viewTanKuang addSubview:butCancle];
    butCancle.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:16];
    [butCancle addTarget:self action:@selector(buttonCanclePress:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *labelLine = [CreatView creatWithLabelFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [butCancle addSubview:labelLine];
    labelLine.alpha = 0.3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShareEveryCell *cell = [collection dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    
    cell.labelName.text = [nameArray objectAtIndex:indexPath.item];
    cell.labelName.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.imagePIc.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [imageArray objectAtIndex:indexPath.item]]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShareFailureViewController *shareFailure = [[ShareFailureViewController alloc] init];
    [self.navigationController pushViewController:shareFailure animated:YES];
}

- (void)finishBarPress:(UIBarButtonItem *)bar
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)buttonNull:(UIBarButtonItem *)button
{
    
}

//黑色遮罩层
- (void)makeButtonDisappear:(UIButton *)button
{
    [button removeFromSuperview];
    [viewTanKuang removeFromSuperview];
    
    button = nil;
    viewTanKuang = nil;
}

//取消按钮
- (void)buttonCanclePress:(UIButton *)button
{
    [butBlack removeFromSuperview];
    [viewTanKuang removeFromSuperview];
    
    butBlack = nil;
    viewTanKuang = nil;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [butBlack removeFromSuperview];
    [viewTanKuang removeFromSuperview];
    
    butBlack = nil;
    viewTanKuang = nil;
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:NO];
    [app.tabBarVC setLabelLineHidden:NO];
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