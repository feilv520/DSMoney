//
//  TWOUseRedBagViewController.m
//  DSLC
//
//  Created by ios on 16/5/26.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOUseRedBagViewController.h"
#import "TWOUseRedBagCell.h"
#import "TWORedBagModel.h"

@interface TWOUseRedBagViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *mainTableView;
    
    NSInteger page;
    
    NSMutableArray *moneyArray;
    NSMutableArray *moneyNoArray;
    
    TWORedBagModel *packetModel;
}

@end

@implementation TWOUseRedBagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"可用红包"];
    
    moneyArray = [NSMutableArray array];
    
    moneyNoArray = [NSMutableArray array];
    
    page = 1;
    
    [self getMyRedPacketList];
}

- (void)returnText:(ReturnRedBagBlock)block {
    self.returnRedBagBlock = block;
}
- (void)viewWillDisappear:(BOOL)animated {
    
    if (self.returnRedBagBlock != nil) {
        self.returnRedBagBlock(packetModel);
    }
}

- (void)tableViewShow
{
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:mainTableView];
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    mainTableView.separatorColor = [UIColor clearColor];
    mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10)];
    mainTableView.tableFooterView.backgroundColor = [UIColor clearColor];
    [mainTableView registerNib:[UINib nibWithNibName:@"TWOUseRedBagCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return moneyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOUseRedBagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];
    
    TWORedBagModel *model = [moneyArray objectAtIndex:indexPath.row];
    
    cell.imagePicture.image = [UIImage imageNamed:@"twohongbao"];
    
    NSMutableAttributedString *moneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@", [model redPacketMoney]]];
    NSRange signRange = NSMakeRange(0, 1);
    [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:28] range:signRange];
    [cell.labelMoney setAttributedText:moneyString];
    cell.labelMoney.backgroundColor = [UIColor clearColor];
    
    if (WIDTH_CONTROLLER_DEFAULT == 320) {
        cell.labelMoney.frame = CGRectMake(10, 55, 108, 40);
        cell.butCanUse.frame = CGRectMake(281, 10, 23, 127);
        cell.labelTiaoJian.frame = CGRectMake(118, 27, 150, 19);
        cell.labelEvery.frame = CGRectMake(122, 56, 146, 15);
        cell.labelData.frame = CGRectMake(116, 110, 152, 12);
    } else if (WIDTH_CONTROLLER_DEFAULT == 375) {
        cell.labelMoney.frame = CGRectMake(10, 55, 127, 40);
    } else if (WIDTH_CONTROLLER_DEFAULT == 414) {
        cell.labelMoney.frame = CGRectMake(12, 55, 138, 40);
        cell.butCanUse.frame = CGRectMake(370, 10, 23, 127);
        cell.labelTiaoJian.frame = CGRectMake(158, 27, 195, 19);
        cell.labelEvery.frame = CGRectMake(158, 56, 195, 15);
        cell.labelData.frame = CGRectMake(158, 110, 195, 12);
    }
    
    NSMutableAttributedString *useing = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"单笔投资满%@可用", [model investMoney]]];
    NSRange leftRange = NSMakeRange(0, 5);
    [useing addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:leftRange];
    [useing addAttribute:NSForegroundColorAttributeName value:[UIColor moneyColor] range:leftRange];
    NSRange rightRange = NSMakeRange([[useing string] length] - 2, 2);
    [useing addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:rightRange];
    [useing addAttribute:NSForegroundColorAttributeName value:[UIColor moneyColor] range:rightRange];
    [cell.labelTiaoJian setAttributedText:useing];
    cell.labelTiaoJian.backgroundColor = [UIColor clearColor];

    if ([[[model applyTypeName] description] isEqualToString:@"0"]) {
        cell.labelEvery.text = @"所有产品可用";
    } else {
        cell.labelEvery.text = [NSString stringWithFormat:@"期限%@天及以上产品可用",[model applyDays]];
    }
    cell.labelEvery.backgroundColor = [UIColor clearColor];
    
    [cell.butCanUse setTitle:@"可\n使\n用" forState:UIControlStateNormal];
    cell.butCanUse.titleLabel.numberOfLines = 3;
    cell.butCanUse.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    cell.butCanUse.backgroundColor = [UIColor clearColor];
    
    cell.labelData.text = [NSString stringWithFormat:@"%@至%@有效", [model startDate], [model endDate]];
    cell.labelData.backgroundColor = [UIColor clearColor];
    
    if ([[[model isEnabled] description] isEqualToString:@"1"]) {
        
        cell.contentView.alpha = 0.5;
    } else {
        
        cell.contentView.alpha = 1.0;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    TWORedBagModel *model = [moneyArray objectAtIndex:indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (![[[model isEnabled] description] isEqualToString:@"1"]) {
        
        packetModel = model;
        popVC;
    }
}

- (void)getMyRedPacketList{
    
    if ([self.transMoney integerValue] <= 100) {
        self.transMoney = @"100";
    }
    
    NSDictionary *parmeter = @{@"curPage":[NSNumber numberWithInteger:page],@"status":@0,@"proPeriod":self.proPeriod,@"transMoney":self.transMoney,@"token":[self.flagDic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"welfare/getMyRedPacketList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"getMyRedPacketList = %@",responseObject);

        NSArray *redPackArray = [responseObject objectForKey:@"RedPacket"];
        for (NSDictionary *dic in redPackArray) {
            TWORedBagModel *model = [[TWORedBagModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            if ([[[model isEnabled] description] isEqualToString:@"0"]) {
                [moneyArray addObject:model];
            } else {
                [moneyNoArray addObject:model];
            }
        }
        
        [moneyArray addObjectsFromArray:moneyNoArray];
        
        if (page == 1) {
        
            [self tableViewShow];
        } else {
            [mainTableView reloadData];
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
