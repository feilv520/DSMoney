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

@interface TWOFindViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

{
    UITableView *_tableView;
    NSArray *imageArray;
    UICollectionView *_collection;
    NSArray *titleArr;
    NSArray *imagePicArray;
    NSArray *contentArr;
}

@end

@implementation TWOFindViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self tabelViewShow];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)tabelViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 53) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 402.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    _tableView.tableHeaderView.backgroundColor = [UIColor whiteColor];
    [_tableView registerNib:[UINib nibWithNibName:@"TwoFindActCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    [self tableViewShowHead];
}

- (void)tableViewShowHead
{
    UIImageView *imageBanner = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 180.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"findbanner"]];
    [_tableView.tableHeaderView addSubview:imageBanner];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((WIDTH_CONTROLLER_DEFAULT - 18 - 5)/2, 66.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20));
    flowLayout.minimumInteritemSpacing = 5;
//    纵向间距
    flowLayout.minimumLineSpacing = 5;
    _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 180.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), WIDTH_CONTROLLER_DEFAULT, 220.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) collectionViewLayout:flowLayout];
    [_tableView.tableHeaderView addSubview:_collection];
    _collection.dataSource = self;
    _collection.delegate = self;
    _collection.scrollEnabled = NO;
    _collection.backgroundColor = [UIColor whiteColor];
    _collection.contentInset = UIEdgeInsetsMake(6.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 9, 5.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 9);
    [_collection registerNib:[UINib nibWithNibName:@"TwoActivityCell" bundle:nil] forCellWithReuseIdentifier:@"reuse"];
    [_collection registerNib:[UINib nibWithNibName:@"PleaseExpectCell" bundle:nil] forCellWithReuseIdentifier:@"reuse5"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TwoFindActCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    imageArray = @[@"大扫描", @"公益行", @"排行榜"];
    cell.imagePicture.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
//        大圣公益行
        TWODSPublicBenefitViewController *publicBenefit = [[TWODSPublicBenefitViewController alloc] init];
        pushVC(publicBenefit);
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
        cell.labelName.text = @"敬请期待";
        cell.labelName.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        cell.labelName.textColor = [UIColor profitColor];
        
        return cell;
        
    } else {
        
        TwoActivityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
        
        cell.layer.cornerRadius = 3;
        cell.layer.masksToBounds = YES;
        cell.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
        cell.layer.borderWidth = 1;
        
        imagePicArray = @[@"huodong", @"tequan", @"大转盘", @"baojichoujiang", @"youxi"];
        titleArr = @[@"活动中心", @"特权本金", @"大转盘", @"爆击抽奖", @"游戏中心"];
        contentArr = @[@"月月活动玩不停", @"玩high朋友圈", @"好运气快快来", @"中奖王就是你", @"玩游戏转猴币"];
        NSArray *colorArray = @[[UIColor daohanglan], [UIColor tequanColor], [UIColor profitColor], [UIColor daohanglan], [UIColor tequanColor]];
        
        cell.imagePIC.image = [UIImage imageNamed:[imagePicArray objectAtIndex:indexPath.item]];
        cell.labelTitle.text = [titleArr objectAtIndex:indexPath.item];
        cell.labelTitle.textColor = [colorArray objectAtIndex:indexPath.item];
        cell.labelTitle.font = [UIFont fontWithName:@"CenturyGothic" size:15];
//        cell.labelTitle.backgroundColor = [UIColor greenColor];
        
        CGRect rect = [cell.labelTitle.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT, 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:15]} context:nil];
        cell.labelTitle.frame = CGRectMake(69, 15, rect.size.width, 15);
        
        cell.labelContent.text = [contentArr objectAtIndex:indexPath.item];
        cell.labelContent.textColor = [UIColor findZiTiColor];
        cell.labelContent.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
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
