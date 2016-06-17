//
//  TWOUseTicketViewController.m
//  DSLC
//
//  Created by ios on 16/5/26.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOUseTicketViewController.h"
#import "TWOUseRedBagCell.h"

@interface TWOUseTicketViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
}

@end

@implementation TWOUseTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"可用加息券"];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 -64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10)];
    _tableView.tableFooterView.backgroundColor = [UIColor whiteColor];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOUseRedBagCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOUseRedBagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.imagePicture.image = [UIImage imageNamed:@"jiaxijuan"];
    
    NSMutableAttributedString *moneyString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%", @"2"]];
    NSRange signRange = NSMakeRange(0, [[moneyString string] rangeOfString:@"%"].location);
    [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:39] range:signRange];
    NSRange baifenhao = NSMakeRange([[moneyString string] length] - 1, 1);
    [moneyString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:28] range:baifenhao];
    [cell.labelMoney setAttributedText:moneyString];
    cell.labelMoney.backgroundColor = [UIColor clearColor];
    
    NSMutableAttributedString *useing = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"单笔投资满%@可用", @"10000"]];
    NSRange leftRange = NSMakeRange(0, 5);
    [useing addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:leftRange];
    [useing addAttribute:NSForegroundColorAttributeName value:[UIColor moneyColor] range:leftRange];
    NSRange rightRange = NSMakeRange([[useing string] length] - 2, 2);
    [useing addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:rightRange];
    [useing addAttribute:NSForegroundColorAttributeName value:[UIColor moneyColor] range:rightRange];
    [cell.labelTiaoJian setAttributedText:useing];
    cell.labelTiaoJian.backgroundColor = [UIColor clearColor];
    
    cell.labelEvery.text = @"所有产品适用";
    cell.labelEvery.backgroundColor = [UIColor clearColor];
    
    cell.labelCanUse.text = @"可\n使\n用";
    cell.labelCanUse.numberOfLines = 3;
    cell.labelCanUse.backgroundColor = [UIColor clearColor];
    
    cell.labelData.text = [NSString stringWithFormat:@"%@至%@有效", @"2016-09-09", @"2016-09-09"];
    cell.labelData.backgroundColor = [UIColor clearColor];
    
    if (indexPath.row == 2) {
        cell.contentView.alpha = 0.5;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    popVC;
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
