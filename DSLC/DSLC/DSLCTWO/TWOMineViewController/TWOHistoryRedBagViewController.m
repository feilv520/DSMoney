//
//  TWOHistoryRedBagViewController.m
//  DSLC
//
//  Created by ios on 16/5/27.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOHistoryRedBagViewController.h"
#import "TWOUseRedBagCell.h"

@interface TWOHistoryRedBagViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSMutableArray *historyRedBagArr;
}

@end

@implementation TWOHistoryRedBagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"历史红包"];
    
    [self getMyRedPacketListFuction];
}

- (void)NoHistoryRedBagShow
{
    
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 9)];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOUseRedBagCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOUseRedBagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
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

    cell.imagePicture.image = [UIImage imageNamed:@"历史红包ios"];
    
    NSMutableAttributedString *moneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@", @"20"]];
    NSRange signRange = NSMakeRange(0, 1);
    [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:28] range:signRange];
    [cell.labelMoney setAttributedText:moneyString];
    cell.labelMoney.backgroundColor = [UIColor clearColor];
    cell.labelMoney.textColor = [UIColor findZiTiColor];
    
    NSMutableAttributedString *useing = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"单笔投资满%@可用", @"10000"]];
    NSRange leftRange = NSMakeRange(0, 5);
    [useing addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:leftRange];
    NSRange rightRange = NSMakeRange([[useing string] length] - 2, 2);
    [useing addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:rightRange];
    [cell.labelTiaoJian setAttributedText:useing];
    cell.labelTiaoJian.backgroundColor = [UIColor clearColor];
    cell.labelTiaoJian.textColor = [UIColor findZiTiColor];
    
    cell.labelEvery.text = @"所有产品适用";
    cell.labelEvery.backgroundColor = [UIColor clearColor];
    cell.labelEvery.textColor = [UIColor findZiTiColor];
    
    [cell.butCanUse setTitle:@"已\n过\n期" forState:UIControlStateNormal];
    cell.butCanUse.titleLabel.numberOfLines = 3;
    cell.butCanUse.backgroundColor = [UIColor clearColor];
    cell.butCanUse.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    
    cell.labelData.text = [NSString stringWithFormat:@"%@至%@有效", @"2016-09-09", @"2016-09-09"];
    cell.labelData.backgroundColor = [UIColor clearColor];
    cell.labelData.textColor = [UIColor findZiTiColor];
    
//    机型frame判断
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark history~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)getMyRedPacketListFuction{
    NSDictionary *parmeter = @{@"curPage":@1,@"status":@"1,2,3",@"pageSize":@10,@"token":[self.flagDic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"welfare/getMyRedPacketList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"getMyRedPacketList = %@",responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            historyRedBagArr = [responseObject objectForKey:@"RedPacket"];
            
            if (historyRedBagArr.count == 0) {
                [self NoHistoryRedBagShow];
            } else {
                [self tableViewShow];
            }
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
