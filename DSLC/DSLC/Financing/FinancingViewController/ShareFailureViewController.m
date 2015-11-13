//
//  ShareFailureViewController.m
//  DSLC
//
//  Created by ios on 15/11/4.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "ShareFailureViewController.h"
#import "ShareEveryCell.h"
#import "ShareFinishViewController.h"

@interface ShareFailureViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

{
    UIButton *butBlack;
    UIView *viewTanKuang;
    UICollectionView *collection;
    
    NSArray *imageArray;
    NSArray *nameArray;
    
    UIButton *butCancle;
}

@end

@implementation ShareFailureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"分享"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(button:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(buttonFinish:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:15], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    [self contentShow];
}

- (void)contentShow
{
    UIButton *buttonFail = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 52, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] titleText:@"分享失败"];
    [self.view addSubview:buttonFail];
    buttonFail.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonFail setImage:[UIImage imageNamed:@"分享失败"] forState:UIControlStateNormal];
    
    UILabel *labelTwo = [CreatView creatWithLabelFrame:CGRectMake(0, 80, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"有一个红包与你擦肩而过\n您可以继续分享或者去投资"];
    [self.view addSubview:labelTwo];
    labelTwo.numberOfLines = 2;
    
    UIButton *butGoOn = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 200, (WIDTH_CONTROLLER_DEFAULT - 90)/2, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor daohanglan] titleText:@"继续投资"];
    [self.view addSubview:butGoOn];
    butGoOn.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    butGoOn.layer.cornerRadius = 3;
    butGoOn.layer.masksToBounds = YES;
    butGoOn.layer.borderColor = [[UIColor daohanglan] CGColor];
    butGoOn.layer.borderWidth = 0.5;
    
    UIButton *butShare = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake((WIDTH_CONTROLLER_DEFAULT - 90)/2 + 50, 200, (WIDTH_CONTROLLER_DEFAULT - 90)/2, 40) backgroundColor:[UIColor daohanglan] textColor:[UIColor whiteColor] titleText:@"分享拿红包"];
    [self.view addSubview:butShare];
    butShare.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    butShare.layer.cornerRadius = 3;
    butShare.layer.masksToBounds = YES;
    [butShare addTarget:self action:@selector(buttonFailedPress:) forControlEvents:UIControlEventTouchUpInside];
}

//分享拿红包
- (void)buttonFailedPress:(UIButton *)button
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
//    ShareFailureViewController *failureVC = [[ShareFailureViewController alloc] init];
//    [self.navigationController pushViewController:failureVC animated:YES];
    
    [butBlack removeFromSuperview];
    [viewTanKuang removeFromSuperview];
    
    butBlack = nil;
    viewTanKuang = nil;
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

- (void)buttonFinish:(UIBarButtonItem *)bar
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)button:(UIBarButtonItem *)bar
{
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
