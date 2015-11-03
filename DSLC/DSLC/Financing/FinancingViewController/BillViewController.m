//
//  BillViewController.m
//  DSLC
//
//  Created by ios on 15/10/28.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "BillViewController.h"
#import "define.h"
#import "UIColor+AddColor.h"
#import "CreatView.h"
#import "FinancingViewController.h"
#import "NewbieViewController.h"
#import "BillCell.h"
#import "FDetailViewController.h"

@interface BillViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UIScrollView *scrollView;
    UIButton *butThree;
    NSArray *butThrArr;
    UILabel *labelLine;
    
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
    
    FinancingViewController *financingVC;
    NewbieViewController *newbieVC;
    
    UITableView *_tableView;
    NSArray *butRedArray;
    
    UIImageView *imageView;
}

@end

@implementation BillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 45 - 53) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10)];
    _tableView.tableFooterView.backgroundColor = [UIColor huibai];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"BillCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    butRedArray = @[@"3", @"6", @"9", @"12", @"7", @"9", @"1", @"5", @"6", @"8"];
    
    imageView = [CreatView creatImageViewWithFrame:CGRectMake(275, 65, 49, 49) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"已售罄"]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 126;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BillCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.backgroundColor = [UIColor huibai];
    
    [cell.buttonRed setBackgroundImage:[UIImage imageNamed:@"圆角矩形-2"] forState:UIControlStateNormal];
    [cell.buttonRed setTitle:[NSString stringWithFormat:@"%@", [butRedArray objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    cell.buttonRed.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.labelMonth.text = @"个月固定投资";
    cell.labelMonth.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    
    cell.labelQiTou.text = @"1,000起投";
    cell.labelQiTou.textColor = [UIColor zitihui];
    cell.labelQiTou.font = [UIFont fontWithName:@"CenturyGothic" size:11];
    cell.labelQiTou.textAlignment = NSTextAlignmentRight;
    
    cell.viewLine1.backgroundColor = [UIColor grayColor];
    cell.viewLine1.alpha = 0.2;
    
    NSMutableAttributedString *leftString = [[NSMutableAttributedString alloc] initWithString:@"8.02%"];
    NSRange left = NSMakeRange(0, [[leftString string] rangeOfString:@"%"].location);
    [leftString addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:left];
    [leftString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:left];
    NSRange right = NSMakeRange([[leftString string] length] - 1, 1);
    [leftString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:right];
    [leftString addAttribute:NSForegroundColorAttributeName value:[UIColor zitihui] range:right];
    [cell.labelLeftUp setAttributedText:leftString];
    
    NSMutableAttributedString *midString = [[NSMutableAttributedString alloc] initWithString:@"90天"];
    NSRange leftMid = NSMakeRange(0, [[midString string] rangeOfString:@"天"].location);
    [midString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:leftMid];
    NSRange rightMid = NSMakeRange([[midString string] length] - 1, 1);
    [midString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:rightMid];
    [midString addAttribute:NSForegroundColorAttributeName value:[UIColor zitihui] range:rightMid];
    [cell.labelMidUp setAttributedText:midString];
    
    [cell.butRightUp setImage:[UIImage imageNamed:@"组-14"] forState:UIControlStateNormal];
    NSMutableAttributedString *rightString = [[NSMutableAttributedString alloc] initWithString:@"24.3万元"];
    NSRange rightLeft = NSMakeRange(0, [[rightString string] rangeOfString:@"万"].location);
    [rightString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:22] range:rightLeft];
    NSRange rightR = NSMakeRange([[rightString string] length] - 2, 2);
    [rightString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:rightR];
    [rightString addAttribute:NSForegroundColorAttributeName value:[UIColor zitihui] range:rightR];
    [cell.butRightUp setAttributedTitle:rightString forState:UIControlStateNormal];
    
    cell.labelLeftDown.text = @"年化收益率";
    cell.labelLeftDown.textColor = [UIColor zitihui];
    cell.labelLeftDown.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    
    cell.labelMidDown.text = @"理财期限";
    cell.labelMidDown.textColor = [UIColor zitihui];
    cell.labelMidDown.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    
    cell.labelRightDown.text = @"剩余总额";
    cell.labelRightDown.textColor = [UIColor zitihui];
    cell.labelRightDown.font = [UIFont fontWithName:@"CenturyGothic" size:12];
    
    if (indexPath.row == 3) {
        
        cell.labelRightDown.hidden = YES;
        cell.butRightUp.hidden = YES;
        
        [cell addSubview:imageView];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FDetailViewController *detailVC = [[FDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
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
