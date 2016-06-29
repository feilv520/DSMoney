//
//  TWOHistoryJiaXiQuanViewController.m
//  DSLC
//
//  Created by ios on 16/5/27.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOHistoryJiaXiQuanViewController.h"
#import "TWOWaitCashCell.h"
#import "TWOUseRedBagCell.h"
#import "TWIJiaXiQuanCell.h"

@interface TWOHistoryJiaXiQuanViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
}

@end

@implementation TWOHistoryJiaXiQuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"历史加息券"];
    
    [self getMyIncreaseListFuction];
}

- (void)historyJiaXiQuanShow
{
    UIImageView *imageMonkey = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 260/1.5/2, 130.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 260/1.5, 260/1.5) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"noWithData"]];
    [self.view addSubview:imageMonkey];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10)];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOWaitCashCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [_tableView registerNib:[UINib nibWithNibName:@"TWIJiaXiQuanCell" bundle:nil] forCellReuseIdentifier:@"reuseR"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1 || indexPath.row == 6) {
        return 160;
    } else {
        return 140;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1 || indexPath.row == 6) {
        
        TWOWaitCashCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        cell.imageWait.image = [UIImage imageNamed:@"历史兑换加息券ios"];
        
        NSMutableAttributedString *percentString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%", @"2"]];
        NSRange qianRange = NSMakeRange(0, [[percentString string] rangeOfString:@"%"].location);
        [percentString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:39] range:qianRange];
        [cell.labelPercent setAttributedText:percentString];
        cell.labelPercent.textColor = [UIColor findZiTiColor];
        cell.labelPercent.backgroundColor = [UIColor clearColor];
//            待兑付加息券frame值机型判断
        if (WIDTH_CONTROLLER_DEFAULT == 320) {
            cell.labelPercent.frame = CGRectMake(10, 56, 88, 40);
            cell.buttonWait.frame = CGRectMake(281, 16, 23, 127);
            cell.labelTiaoJian.frame = CGRectMake(100, 27, 170, 19);
            cell.labelEvery.frame = CGRectMake(100, 56, 170, 14);
            cell.laeblData.frame = CGRectMake(100, 81, 170, 12);
            cell.labelTime.frame = CGRectMake(100, 123, 170, 13);
            cell.laeblMoney.frame = CGRectMake(12, 140, 112, 13);
            cell.labelShuoMing.frame = CGRectMake(125, 139, 145, 13);
        } else if (WIDTH_CONTROLLER_DEFAULT == 375) {
            cell.labelPercent.frame = CGRectMake(10, 56, 105, 40);
        } else if (WIDTH_CONTROLLER_DEFAULT == 414) {
            cell.labelPercent.frame = CGRectMake(12, 56, 112, 40);
            cell.labelTiaoJian.frame = CGRectMake(130, 27, 220, 19);
            cell.labelEvery.frame = CGRectMake(130, 56, 220, 14);
            cell.laeblData.frame = CGRectMake(130, 81, 220, 12);
            cell.labelTime.frame = CGRectMake(130, 123, 220, 13);
            cell.labelShuoMing.frame = CGRectMake(175, 139, 175, 13);
            cell.laeblMoney.frame = CGRectMake(12, 140, 160, 13);
            cell.buttonWait.frame = CGRectMake(370, 17, 23, 127);
        }
        
        NSMutableAttributedString *moneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"单笔投资满%@可用", @"10000"]];
        NSRange leftRange = NSMakeRange(0, 5);
        [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:leftRange];
        NSRange rightRange = NSMakeRange([[moneyString string] length] - 2, 2);
        [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:rightRange];
        [cell.labelTiaoJian setAttributedText:moneyString];
        cell.labelTiaoJian.backgroundColor = [UIColor clearColor];
        cell.labelTiaoJian.textColor = [UIColor findZiTiColor];
        
        cell.labelEvery.text = @"所有产品适用";
        cell.labelEvery.textColor = [UIColor findZiTiColor];
        cell.labelEvery.backgroundColor = [UIColor clearColor];
        
        cell.laeblData.text = [NSString stringWithFormat:@"%@至%@有效", @"2016-09-09", @"2016-09-09"];
        cell.laeblData.textColor = [UIColor findZiTiColor];
        cell.laeblData.backgroundColor = [UIColor clearColor];
        
        NSMutableAttributedString *qianMianString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"待兑付金额:%@元", @"20"]];
        NSRange qianMianRange = NSMakeRange(0, 6);
        [qianMianString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:qianMianRange];
        NSRange houMianRange = NSMakeRange([[qianMianString string] length] - 1, 1);
        [qianMianString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:houMianRange];
        [cell.laeblMoney setAttributedText:qianMianString];
        cell.laeblMoney.textColor = [UIColor findZiTiColor];
        cell.laeblMoney.backgroundColor = [UIColor clearColor];
        
        cell.labelTime.text = [NSString stringWithFormat:@"产品到期日:2016-09-09"];
        cell.labelTime.textColor = [UIColor findZiTiColor];
        cell.labelTime.backgroundColor = [UIColor clearColor];
        
        cell.labelShuoMing.text = @"(到期日后7个工作日内兑付至余额)";
        cell.labelShuoMing.textColor = [UIColor findZiTiColor];
        cell.labelShuoMing.backgroundColor = [UIColor clearColor];
        if (WIDTH_CONTROLLER_DEFAULT == 320) {
            cell.labelShuoMing.font = [UIFont fontWithName:@"CenturyGothic" size:9];
        }
        
        [cell.buttonWait setTitle:@"已\n兑\n付" forState:UIControlStateNormal];
        cell.buttonWait.titleLabel.numberOfLines = 3;
        cell.buttonWait.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.buttonWait.backgroundColor = [UIColor clearColor];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        
        TWIJiaXiQuanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseR"];
        cell.imagePicture.image = [UIImage imageNamed:@"历史加息券ios"];
        
        NSMutableAttributedString *moneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%", @"2"]];
        NSRange signRange = NSMakeRange(0, [[moneyString string] rangeOfString:@"%"].location);
        [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:39] range:signRange];
        NSRange baiRange = NSMakeRange([[moneyString string] length] - 1, 1);
        [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:28] range:baiRange];
        [cell.labelMoney setAttributedText:moneyString];
        cell.labelMoney.textColor = [UIColor findZiTiColor];
        cell.labelMoney.backgroundColor = [UIColor clearColor];
        
//            可使用加息券frame值机型判断
        if (WIDTH_CONTROLLER_DEFAULT == 320) {
            cell.labelMoney.frame = CGRectMake(10, 55, 88, 40);
            cell.labelTiaoJian.frame = CGRectMake(100, 27, 170, 19);
            cell.labelEvery.frame = CGRectMake(100, 56, 170, 14);
            cell.labelData.frame = CGRectMake(100, 110, 170, 12);
            cell.butCanUse.frame = CGRectMake(281, 10, 23, 127);
        } else if (WIDTH_CONTROLLER_DEFAULT == 375) {
            cell.labelMoney.frame = CGRectMake(10, 55, 105, 40);
        } else if (WIDTH_CONTROLLER_DEFAULT == 414) {
            cell.labelMoney.frame = CGRectMake(12, 55, 112, 40);
            cell.labelTiaoJian.frame = CGRectMake(130, 27, 220, 19);
            cell.labelEvery.frame = CGRectMake(130, 56, 220, 14);
            cell.labelData.frame = CGRectMake(130, 110, 220, 12);
            cell.butCanUse.frame = CGRectMake(370, 10, 23, 127);
        }
        
        NSMutableAttributedString *useing = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"单笔投资满%@可用", @"10000"]];
        NSRange leftRange = NSMakeRange(0, 5);
        [useing addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:leftRange];
        NSRange rightRange = NSMakeRange([[useing string] length] - 2, 2);
        [useing addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:rightRange];
        [cell.labelTiaoJian setAttributedText:useing];
        cell.labelTiaoJian.backgroundColor = [UIColor clearColor];
        cell.labelTiaoJian.textColor = [UIColor findZiTiColor];
        
        cell.labelEvery.text = @"所有产品适用";
        cell.labelEvery.textColor = [UIColor findZiTiColor];
        cell.labelEvery.backgroundColor = [UIColor clearColor];
        
        [cell.butCanUse setTitle:@"可\n使\n用" forState:UIControlStateNormal];
        cell.butCanUse.titleLabel.numberOfLines = 3;
        cell.butCanUse.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.butCanUse.backgroundColor = [UIColor clearColor];
        
        cell.labelData.text = [NSString stringWithFormat:@"%@至%@有效", @"2016-09-09", @"2016-09-09"];
        cell.labelData.textColor = [UIColor findZiTiColor];
        cell.labelData.backgroundColor = [UIColor clearColor];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
#pragma mark history>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
- (void)getMyIncreaseListFuction{
    NSDictionary *parmeter = @{@"curPage":@1,@"status":@"1,2,3",@"pageSize":@10,@"token":[self.flagDic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"welfare/getMyIncreaseList" parameters:parmeter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"getMyIncreaseList = %@",responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInteger:200]]) {
            NSMutableArray *dataArray = [responseObject objectForKey:@"Increase"];
            if (dataArray.count == 0) {
                [self historyJiaXiQuanShow];
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
