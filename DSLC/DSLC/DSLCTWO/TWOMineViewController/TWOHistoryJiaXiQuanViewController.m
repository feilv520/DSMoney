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
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOWaitCashCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOUseRedBagCell" bundle:nil] forCellReuseIdentifier:@"reuseR"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 140;
    } else {
        return 160;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        
        TWOWaitCashCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        cell.imageWait.image = [UIImage imageNamed:@"加息券已兑付"];
        
        NSMutableAttributedString *percentString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%", @"2"]];
        NSRange qianRange = NSMakeRange(0, [[percentString string] rangeOfString:@"%"].location);
        [percentString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:39] range:qianRange];
        [cell.labelPercent setAttributedText:percentString];
        cell.labelPercent.textColor = [UIColor findZiTiColor];
        cell.labelPercent.backgroundColor = [UIColor clearColor];
        if (WIDTH_CONTROLLER_DEFAULT == 320) {
            cell.labelPercent.textAlignment = NSTextAlignmentLeft;
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
        
        cell.labelShuoMing.text = @"( 到期日后7个工作日内兑付至余额 )";
        cell.labelShuoMing.textColor = [UIColor findZiTiColor];
        cell.labelShuoMing.backgroundColor = [UIColor clearColor];
        
        cell.labelWait.text = @"已\n兑\n付";
        cell.labelWait.numberOfLines = 3;
        cell.labelWait.backgroundColor = [UIColor clearColor];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        
        TWOUseRedBagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseR"];
        cell.imagePicture.image = [UIImage imageNamed:@"historyQuan"];
        
        NSMutableAttributedString *moneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%", @"2"]];
        NSRange signRange = NSMakeRange(0, [[moneyString string] rangeOfString:@"%"].location);
        [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:39] range:signRange];
        NSRange baiRange = NSMakeRange([[moneyString string] length] - 1, 1);
        [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:28] range:baiRange];
        [cell.labelMoney setAttributedText:moneyString];
        cell.labelMoney.textColor = [UIColor findZiTiColor];
        cell.labelMoney.backgroundColor = [UIColor clearColor];
        if (WIDTH_CONTROLLER_DEFAULT == 320) {
            cell.labelMoney.textAlignment = NSTextAlignmentLeft;
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
        
        cell.labelCanUse.text = @"可\n使\n用";
        cell.labelCanUse.numberOfLines = 3;
        cell.labelCanUse.backgroundColor = [UIColor clearColor];
        
        cell.labelData.text = [NSString stringWithFormat:@"%@至%@有效", @"2016-09-09", @"2016-09-09"];
        cell.labelData.textColor = [UIColor findZiTiColor];
        cell.labelData.backgroundColor = [UIColor clearColor];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
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
