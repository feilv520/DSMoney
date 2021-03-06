//
//  MoneyDetailViewController.m
//  DSLC
//
//  Created by ios on 15/10/29.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MoneyDetailViewController.h"
#import "ProjectNameCell.h"
#import "XinXiCell.h"
#import "OtherProjectCell.h"
#import "DownFourCell.h"
#import "PlanCell.h"
#import "UpCell.h"
#import "SimpleDescriptionsViewController.h"
#import "SimpleDetailViewController.h"
#import "RiskConditionsViewController.h"
#import "RiskDisclosureViewController.h"
#import "TeamDescriptionsViewController.h"
#import "RiskAlertBookViewController.h"
#import "MakeSureViewController.h"
#import "FDetailViewController.h"
#import "ProductO.h"

@interface MoneyDetailViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSArray *titleArray;
    NSArray *otherArray;
    NSArray *leftArray;
    NSArray *rightArray;
    NSMutableArray *proArray;
}

@property (nonatomic, strong) NSDictionary *asset;
@property (nonatomic, strong) NSArray *product;

@end

@implementation MoneyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self getAssetDetail];
    
    self.view.backgroundColor = [UIColor huibai];
    proArray = [NSMutableArray array];
    
    [self.navigationItem setTitle:@"资产详情"];
    [self tableViewShowContent];
}

- (void)tableViewShowContent
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor huibai];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 30)];
    _tableView.tableFooterView.backgroundColor = [UIColor huibai];
    [_tableView setSeparatorColor:[UIColor colorWithRed:246 / 255.0 green:247 / 255.0 blue:249 / 255.0 alpha:1.0]];
    [_tableView registerNib:[UINib nibWithNibName:@"ProjectNameCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [_tableView registerNib:[UINib nibWithNibName:@"UpCell" bundle:nil] forCellReuseIdentifier:@"reuseUp"];
    [_tableView registerNib:[UINib nibWithNibName:@"XinXiCell" bundle:nil] forCellReuseIdentifier:@"reuse1"];
    [_tableView registerNib:[UINib nibWithNibName:@"PlanCell" bundle:nil] forCellReuseIdentifier:@"reuse2"];
    [_tableView registerNib:[UINib nibWithNibName:@"OtherProjectCell" bundle:nil] forCellReuseIdentifier:@"reuse3"];
    [_tableView registerNib:[UINib nibWithNibName:@"DownFourCell" bundle:nil] forCellReuseIdentifier:@"reuse4"];
    
    titleArray = @[@"项目简述", @"项目详情", @"风控条件", @"管理团队简介", @"风险揭示"];
    otherArray = @[@"其他包含此资产的产品", @"3个月固收理财", @"6个月固收理财", @"9个月固收理财"];
    leftArray = @[@"产品名称", @"产品类型", @"资产总额", @"开售时间", @"起息日", @"结息日", @"预计到帐日", @"收益分配方式", @"融资方名称", @"项目资金用途", @"还款来源"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 0;
        
    } else {
        
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 148;
        
    } else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            return 39;
            
        } else {
            
            return 32;
        }
        
    } else if (indexPath.section == 2) {
        
        return 154;
        
    } else if (indexPath.section == 3) {
        
        return 45;
        
    } else {
        
        return 45;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
        
    } else if (section == 1) {
        
        return 12;
        
    } else if (section == 2) {
        
        return 1;
        
    } else if (section == 3) {
        
        return 1 + proArray.count;
        
    } else {
        
        return 5;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        ProjectNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        
        cell.labelName.text = [self.asset objectForKey:@"assetName"];
        cell.labelName.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        NSMutableAttributedString *percentStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@~%@%%",[self.asset objectForKey:@"assetAnnualYieldb"],[self.asset objectForKey:@"assetAnnualYielde"]]];
        NSRange leftStr = NSMakeRange(0, [[percentStr string] rangeOfString:@"%"].location);
        [percentStr addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:leftStr];
        [percentStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:23] range:leftStr];
        NSRange rightStr = NSMakeRange([[percentStr string] length] - 1, 1);
        [percentStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:rightStr];
        cell.labelLeftUp.textAlignment = NSTextAlignmentCenter;
        [cell.labelLeftUp setAttributedText:percentStr];
        
        cell.labelLine.backgroundColor = [UIColor grayColor];
        cell.labelLine.alpha = 0.2;
        
        NSMutableAttributedString *monthStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@天",[self.asset objectForKey:@"days"]]];
        NSRange rangeMonth = NSMakeRange(0, [[monthStr string] rangeOfString:@"天"].location);
        [monthStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:23] range:rangeMonth];
        NSRange range = NSMakeRange([[monthStr string] length] - 1, 1);
        [monthStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:range];
        [cell.labelRightUp setAttributedText:monthStr];
        cell.labelRightUp.textAlignment = NSTextAlignmentCenter;
        
        cell.labelLeftDown.text = @"预期年化",
        cell.labelLeftDown.textAlignment = NSTextAlignmentCenter;
        cell.labelLeftDown.textColor = [UIColor zitihui];
        cell.labelLeftDown.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.labelRightDown.text = @"理财期限";
        cell.labelRightDown.textAlignment = NSTextAlignmentCenter;
        cell.labelRightDown.textColor = [UIColor zitihui];
        cell.labelRightDown.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.viewDown.backgroundColor = [UIColor qianhuise];
        cell.labelSheng.text = @"资产总额:";
        cell.labelSheng.textColor = [UIColor zitihui];
        cell.labelSheng.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.labelMoney.text = [NSString stringWithFormat:@"%@元",[self.asset objectForKey:@"assetAmount"]];
        cell.labelMoney.textColor = [UIColor zitihui];
        cell.labelMoney.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        cell.labelMoney.textAlignment = NSTextAlignmentRight;
        
        cell.labelLineDown.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.labelLineDown.alpha = 0.7;
        
        return cell;
        
    } else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            UpCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseUp"];
            
            cell.labelMessage.text = @"基本信息";
            cell.labelMessage.font = [UIFont fontWithName:@"CenturyGothic" size:15];
            
            cell.viewLine.backgroundColor = [UIColor grayColor];
            cell.viewLine.alpha = 0.2;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        } else {
            
            XinXiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse1"];
            
            cell.labelLeft.text = [leftArray objectAtIndex:indexPath.row - 1];
            cell.labelLeft.textColor = [UIColor zitihui];
            cell.labelLeft.font = [UIFont fontWithName:@"CenturyGothic" size:14];
            
            cell.labelRight.text = [rightArray objectAtIndex:indexPath.row - 1];
            cell.labelRight.textColor = [UIColor zitihui];
            cell.labelRight.font = [UIFont fontWithName:@"CenturyGothic" size:14];
            if (cell.labelRight.text.length > 15) {
                cell.labelRight.font = [UIFont fontWithName:@"CenturyGothic" size:12];
            } else if (cell.labelRight.text.length > 18) {
                cell.labelRight.font = [UIFont fontWithName:@"CenturyGothic" size:10];
            }
            cell.labelRight.textAlignment = NSTextAlignmentRight;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    } else if (indexPath.section == 2) {
        
        PlanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse2"];
        
        if (cell == nil) {
            
            cell = [[PlanCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse2"];
        }
        
        cell.labelPlan.text = @"投资计划";
        cell.labelPlan.textColor = [UIColor blackColor];
        cell.labelPlan.font = [UIFont systemFontOfSize:15];
        
        cell.viewLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.viewLine.alpha = 0.7;
        
        cell.imageTimeZhou.image = [UIImage imageNamed:@"750chanpin"];
        
        cell.buyPlan.text = @"开售时间";
        cell.buyPlan.textColor = [UIColor zitihui];
        cell.buyPlan.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.timeOne.text = [self.asset objectForKey:@"assetSaleTime"];
        cell.timeOne.textColor = [UIColor zitihui];
        cell.timeOne.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.beginDay.text = @"起息日";
        cell.beginDay.textColor = [UIColor zitihui];
        cell.beginDay.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.rightNowTime.text = [self.asset objectForKey:@"assetInterestBdate"];
        cell.rightNowTime.textColor = [UIColor zitihui];
        cell.rightNowTime.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.labelEndDay.text = @"结息日";
        cell.labelEndDay.textColor = [UIColor zitihui];
        cell.labelEndDay.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.endTime.text = [self.asset objectForKey:@"assetInterestEdate"];
        cell.endTime.textColor = [UIColor zitihui];
        cell.endTime.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.labelCash.text = @"预计到账日";
        cell.labelCash.textColor = [UIColor zitihui];
        cell.labelCash.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.cashDay.text = [self.asset objectForKey:@"assetToaccountDate"];
        cell.cashDay.textColor = [UIColor zitihui];
        cell.cashDay.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.imageQuan.image = [UIImage imageNamed:@"750产品详情"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    } else if (indexPath.section == 3) {
        
        OtherProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse3"];
        
        cell.labelContent.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.labelContent.textColor = [UIColor zitihui];
        
        cell.imageRight.image = [UIImage imageNamed:@"arrow"];
        
        if (indexPath.row == 0) {
            
            cell.labelContent.text = @"其他包含此资产的产品";
            cell.labelContent.font = [UIFont fontWithName:@"CenturyGothic" size:15];
            cell.labelContent.textColor = [UIColor blackColor];
            cell.imageRight.hidden = YES;
        } else {
            cell.labelContent.text = [[proArray objectAtIndex:indexPath.row - 1] productName];
        }
        
        cell.labelLine.backgroundColor = [UIColor grayColor];
        cell.labelLine.alpha = 0.2;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        
        DownFourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse4"];
        
        if (cell == nil) {
            
            cell = [[DownFourCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse4"];
        }
        
        cell.labelTitle.text = [titleArray objectAtIndex:indexPath.row];
        cell.labelTitle.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.imageViewRight.image = [UIImage imageNamed:@"arrow"];
        
        cell.labelLine.backgroundColor = [UIColor grayColor];
        cell.labelLine.alpha = 0.2;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 4) {
        
        if (indexPath.row == 0) {
            
//            项目简述
            SimpleDescriptionsViewController *simpleDesVC = [[SimpleDescriptionsViewController alloc] init];
            simpleDesVC.simple = [self.asset objectForKey:@"assetProjectResume"];
            [self.navigationController pushViewController:simpleDesVC animated:YES];
            
        } else if (indexPath.row == 1) {
            
//            项目详情
            SimpleDetailViewController *simpleDetailVC = [[SimpleDetailViewController alloc] init];
            simpleDetailVC.projectDeatil = [self.asset objectForKey:@"assetProjectDetail"];
            [self.navigationController pushViewController:simpleDetailVC animated:YES];
            
        } else if (indexPath.row == 2) {
            
//            风控条件
            RiskConditionsViewController *riskConVC = [[RiskConditionsViewController alloc] init];
            NSArray *array = [NSArray arrayWithObject:[self.asset objectForKey:@"assetStockControl"]];
            riskConVC.contentArr = array;
            [self.navigationController pushViewController:riskConVC animated:YES];
            
        } else if (indexPath.row == 4) {
            
//            风险揭示
            RiskAlertBookViewController *risk = [[RiskAlertBookViewController alloc] init];
            risk.disign = @"risk";
            risk.risk = [self.asset objectForKey:@"assetRiskNotice"];
            [self.navigationController pushViewController:risk animated:YES];
            
        } else if (indexPath.row == 3) {
            
//            管理团队简介
            TeamDescriptionsViewController *teamVC = [[TeamDescriptionsViewController alloc] init];
            teamVC.team = [self.asset objectForKey:@"assetManageTeam"];
            [self.navigationController pushViewController:teamVC animated:YES];
            
        }
        
    } else if (indexPath.section == 3) {
        
        FDetailViewController *detail = [[FDetailViewController alloc] init];
        detail.idString = [[proArray objectAtIndex:indexPath.row - 1] idid];
        NSLog(@"======%@", detail.idString);
        detail.estimate = YES;
        [self.navigationController pushViewController:detail animated:YES];
    }
}

#pragma mark 网络请求方法
#pragma mark --------------------------------

- (void)getAssetDetail{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parameter = @{@"assetId":self.idString,@"token":[dic objectForKey:@"token"]};
    
    NSLog(@"%@",parameter);
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/asset/getAssetDetail" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
            NSLog(@"%@",responseObject);
            
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:400]] || responseObject == nil) {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
            if (![FileOfManage ExistOfFile:@"isLogin.plist"]) {
                [FileOfManage createWithFile:@"isLogin.plist"];
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            } else {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"NO",@"loginFlag",nil];
                [dic writeToFile:[FileOfManage PathOfFile:@"isLogin.plist"] atomically:YES];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"beforeWithView" object:@"MCM"];
            [self.navigationController popToRootViewControllerAnimated:NO];
            return ;
        } else if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]){
            
            self.asset = [NSDictionary dictionary];
            self.asset = [responseObject objectForKey:@"Asset"];
            self.product = [NSArray array];
            self.product = [responseObject objectForKey:@"Product"];
            
            rightArray = @[[self.asset objectForKey:@"assetName"], [self.asset objectForKey:@"assetTypeName"], [NSString stringWithFormat:@"%@元",[self.asset objectForKey:@"assetAmount"]], [self.asset objectForKey:@"assetSaleTime"], [self.asset objectForKey:@"assetInterestBdate"], [self.asset objectForKey:@"assetInterestEdate"], [self.asset objectForKey:@"assetToaccountDate"], [self.asset objectForKey:@"assetYieldDistribType"], [self.asset objectForKey:@"assetFinancierName"], [self.asset objectForKey:@"assetFundsUse"], [self.asset objectForKey:@"assetRepaymentSource"]];
            
            for (NSDictionary *proDic in self.product) {
                ProductO *product = [[ProductO alloc] init];
                [product setValuesForKeysWithDictionary:proDic];
                [proArray addObject:product];
            }
            
            [_tableView reloadData];
        } else {
            [self showTanKuangWithMode:MBProgressHUDModeText Text:[responseObject objectForKey:@"resultMsg"]];
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
