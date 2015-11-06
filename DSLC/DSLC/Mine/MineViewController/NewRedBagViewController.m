//
//  NewRedBagViewController.m
//  DSLC
//
//  Created by ios on 15/11/5.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "NewRedBagViewController.h"
#import "NewRedBagCell.h"

@interface NewRedBagViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    UILabel *labelMoney;
    NSArray *titleArr;
    NSArray *imagePic;
    NSArray *styleArr;
}

@end

@implementation NewRedBagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"我的红包"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"红包说明" style:UIBarButtonItemStylePlain target:self action:@selector(redBagExplain:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:15], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    [self tabelViewShow];
}

- (void)tabelViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIView *viewHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 50)];
    _tableView.tableHeaderView = viewHead;
    viewHead.backgroundColor = [UIColor whiteColor];
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorColor = [UIColor clearColor];
    [_tableView registerNib:[UINib nibWithNibName:@"NewRedBagCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    UILabel *labelGet = [CreatView creatWithLabelFrame:CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT/2, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"累计获得红包金额"];
    [viewHead addSubview:labelGet];
    
    labelMoney = [CreatView creatWithLabelFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 + 10, 10, WIDTH_CONTROLLER_DEFAULT/2 - 20, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor daohanglan] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"999元"];
    [viewHead addSubview:labelMoney];
    
    titleArr = @[@"新手体验金10,000元", @"邀请红包10元", @"邀请红包20元", @"成长红包10,000元"];
    imagePic = @[@"使用", @"拆红包", @"拆红包", @"成长"];
    styleArr = @[@"仅限购买新手专享",
                 @"您邀请的好友已投资1,000元",
                 @"您邀请的好友已投资1,000元",
                 @"累计在投满5,000元                 理财期限:9个月以上"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 133;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewRedBagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.imagePic.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [imagePic objectAtIndex:indexPath.row]]];
    cell.labelMoney.text = [titleArr objectAtIndex:indexPath.row];
    cell.labelMoney.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    cell.labelMoney.backgroundColor = [UIColor clearColor];
    
    cell.labelTime.text = @"有效期:截至2015.12.31";
    cell.labelTime.textColor = [UIColor zitihui];
    cell.labelTime.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    cell.labelTime.backgroundColor = [UIColor clearColor];
    
    cell.labelGray.text = [styleArr objectAtIndex:indexPath.row];
    cell.labelGray.textColor = [UIColor zitihui];
    cell.labelGray.font = [UIFont fontWithName:@"CenturyGothic" size:11];
    cell.labelGray.backgroundColor = [UIColor clearColor];
    
    cell.backgroundColor = [UIColor huibai];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)redBagExplain:(UIBarButtonItem *)bar
{
    
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
