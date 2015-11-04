//
//  CashFinishViewController.m
//  DSLC
//
//  Created by ios on 15/11/3.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "CashFinishViewController.h"
#import "FinancingViewController.h"
#import "ShareEveryCell.h"
#import "ShareFinishViewController.h"
#import "ShareFailureViewController.h"

@interface CashFinishViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

{
    NSArray *titleArr;
    UIButton *butBlack;
    UIView *viewTanKuang;
    UICollectionView *collection;
    
    NSArray *imageArray;
    NSArray *nameArray;
    
    UIButton *butCancle;
}

@end

@implementation CashFinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"支付完成"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishButton:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:15], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    [self contentShow];
}

- (void)contentShow
{
    titleArr = @[@"投资金额:10,000元", @"预期到期收益:200元", @"兑付日期:2015-2-3"];
    
    UIButton *butFinish = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 60, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] titleText:@"恭喜您投资成功"];
    [self.view addSubview:butFinish];
    butFinish.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butFinish setImage:[UIImage imageNamed:@"iconfont_complete"] forState:UIControlStateNormal];
    
    UIView *viewBottom = [CreatView creatViewWithFrame:CGRectMake(40, 120, WIDTH_CONTROLLER_DEFAULT - 80, 140) backgroundColor:[UIColor shurukuangColor]];
    [self.view addSubview:viewBottom];
    viewBottom.layer.cornerRadius = 5;
    viewBottom.layer.masksToBounds = YES;
    viewBottom.layer.borderColor = [[UIColor shurukuangBian] CGColor];
    viewBottom.layer.borderWidth = 0.5;
    
    UILabel *labelNew = [CreatView creatWithLabelFrame:CGRectMake(0, 15, WIDTH_CONTROLLER_DEFAULT - 80, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"新手专享"];
    [viewBottom addSubview:labelNew];
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(0, 45 + 20 * i + 10 * i, WIDTH_CONTROLLER_DEFAULT - 80, 20) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:[titleArr objectAtIndex:i]];
        [viewBottom addSubview:label];
    }
    
    UIButton *buttonGoOn = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 300, (WIDTH_CONTROLLER_DEFAULT - 80 - 10)/2, 40) backgroundColor:[UIColor daohanglan] textColor:[UIColor whiteColor] titleText:@"继续投资"];
    [self.view addSubview:buttonGoOn];
    buttonGoOn.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonGoOn.layer.cornerRadius = 3;
    buttonGoOn.layer.masksToBounds = YES;
    [buttonGoOn addTarget:self action:@selector(goOnButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *butShare = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - 80 - 10)/2 + 50, 300, (WIDTH_CONTROLLER_DEFAULT - 80 - 10)/2, 40) backgroundColor:[UIColor daohanglan] textColor:[UIColor whiteColor] titleText:@"分享拿红包"];
    [self.view addSubview:butShare];
    butShare.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    butShare.layer.cornerRadius = 3;
    butShare.layer.masksToBounds = YES;
    [butShare addTarget:self action:@selector(shareGiveRedBag:) forControlEvents:UIControlEventTouchUpInside];
}

//继续投资按钮
- (void)goOnButton:(UIButton *)button
{
    NSLog(@"继续投资");
}

//分享拿红包按钮
- (void)shareGiveRedBag:(UIButton *)button
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
//    ShareFinishViewController *shareVC = [[ShareFinishViewController alloc] init];
//    [self.navigationController pushViewController:shareVC animated:YES];
    ShareFailureViewController *failureVC = [[ShareFailureViewController alloc] init];
    [self.navigationController pushViewController:failureVC animated:YES];
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

//导航完成按钮
- (void)finishButton:(UIBarButtonItem *)bar
{
    NSArray *array = self.navigationController.viewControllers;
    [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [butBlack removeFromSuperview];
    [viewTanKuang removeFromSuperview];
    
    butBlack = nil;
    viewTanKuang = nil;
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