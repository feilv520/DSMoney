//
//  TWOAlreadyBankCardViewController.m
//  DSLC
//
//  Created by ios on 16/5/16.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOAlreadyBankCardViewController.h"
#import "TWOBankCardCell.h"
#import "TWOBankCardModel.h"

@interface TWOAlreadyBankCardViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

{
    UITableView *_tableView;
    NSMutableArray *bankListArray;
}

@end

@implementation TWOAlreadyBankCardViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = [UIColor profitColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"银行卡"];
    
    bankListArray = [NSMutableArray array];
    
    [self getDataBankCardList];
    [self loadingWithView:self.view loadingFlag:NO height:HEIGHT_CONTROLLER_DEFAULT/2 - 60];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 35)];
    _tableView.tableFooterView.backgroundColor = [UIColor qianhuise];
    _tableView.backgroundColor = [UIColor qianhuise];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOBankCardCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    UIView *viewBottom = [CreatView creatViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 265/2, 0, 265, 35) backgroundColor:[UIColor qianhuise]];
    [_tableView.tableFooterView addSubview:viewBottom];
    
    UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(0, 0, 175, 35) backgroundColor:[UIColor qianhuise] textColor:[UIColor findZiTiColor] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"更换绑定银行卡请致电客服:"];
    [viewBottom addSubview:labelAlert];
    
    UIButton *butCall = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(175, 0, 90, 35) backgroundColor:[UIColor qianhuise] textColor:[UIColor profitColor] titleText:@"400-816-2283"];
    [viewBottom addSubview:butCall];
    butCall.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    butCall.contentHorizontalAlignment = NSTextAlignmentLeft;
    butCall.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [butCall addTarget:self action:@selector(buttonCallPhone:) forControlEvents:UIControlEventTouchUpInside];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return bankListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    TWOBankCardModel *bankCardModel = [bankListArray objectAtIndex:indexPath.row];
    NSString *cardString = [bankCardModel bankCode];
    
    cell.imagePincture.image = [UIImage imageNamed:@"yinhangkabg"];
    
    if ([cardString isEqualToString:@"ICBC"]) {
        cell.labelBankName.text = @"工商银行";
        cell.imageBankLogo.image = [UIImage imageNamed:@"two工商"];
        
    } else if ([cardString isEqualToString:@"CCB"]) {
        cell.labelBankName.text = @"建设银行";
        cell.imageBankLogo.image = [UIImage imageNamed:@"two建设"];
        
    } else if ([cardString isEqualToString:@"ABC"]) {
        cell.labelBankName.text = @"农业银行";
        cell.imageBankLogo.image = [UIImage imageNamed:@"two农业"];

    } else if ([cardString isEqualToString:@"CEB"]) {
        cell.labelBankName.text = @"光大银行";
        cell.imageBankLogo.image = [UIImage imageNamed:@"two光大"];
        
    } else if ([cardString isEqualToString:@"HXB"]) {
        cell.labelBankName.text = @"华夏银行";
        cell.imageBankLogo.image = [UIImage imageNamed:@"two华夏"];
        
    } else if ([cardString isEqualToString:@"PINGAN"]) {
        cell.labelBankName.text = @"平安银行";
        cell.imageBankLogo.image = [UIImage imageNamed:@"two平安"];
        
    } else if ([cardString isEqualToString:@"SPDB"]) {
        cell.labelBankName.text = @"浦发银行";
        cell.imageBankLogo.image = [UIImage imageNamed:@"two浦发"];
        
    } else if ([cardString isEqualToString:@"CIB"]) {
        cell.labelBankName.text = @"兴业银行";
        cell.imageBankLogo.image = [UIImage imageNamed:@"two兴业"];
        
    } else if ([cardString isEqualToString:@"CMB"]) {
        cell.labelBankName.text = @"招商银行";
        cell.imageBankLogo.image = [UIImage imageNamed:@"two招商"];
        
    } else if ([cardString isEqualToString:@"BOC"]) {
        cell.labelBankName.text = @"中国银行";
        cell.imageBankLogo.image = [UIImage imageNamed:@"two中国"];
    }
    
    cell.labelStyle.text = @"储蓄卡";
    cell.labelCardNum.text = [DES3Util decrypt:[bankCardModel cardAccount]];
    
    cell.imageBankLogo.backgroundColor = [UIColor clearColor];
    cell.labelBankName.backgroundColor = [UIColor clearColor];
    cell.labelStyle.backgroundColor = [UIColor clearColor];
    cell.labelCardNum.backgroundColor = [UIColor clearColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//拨打电话
- (void)buttonCallPhone:(UIButton *)button
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", @"400-816-2283"]];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 0) {
        _tableView.scrollEnabled = NO;
    } else {
        _tableView.scrollEnabled = YES;
    }
}

#pragma data
- (void)getDataBankCardList
{
    NSDictionary *parermeter = @{@"curPage":@1, @"token":[self.flagDic objectForKey:@"token"]};
    [[MyAfHTTPClient sharedClient] postWithURLString:@"bankCard/getUserBankCardList" parameters:parermeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"银行卡列表;;;;;;;;%@", responseObject);
        [self loadingWithHidden:YES];
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            
            NSMutableArray *bankCardArray = [responseObject objectForKey:@"BankCard"];
            for (NSDictionary *dataDic in bankCardArray) {
                TWOBankCardModel *bankModel = [[TWOBankCardModel alloc] init];
                [bankModel setValuesForKeysWithDictionary:dataDic];
                [bankListArray addObject:bankModel];
            }
            
            [self tableViewShow];
            
        } else {
//            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
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
