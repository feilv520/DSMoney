//
//  MyRedBagViewController.m
//  DSLC
//
//  Created by ios on 15/10/19.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MyRedBagViewController.h"
#import "UIColor+AddColor.h"
#import "CreatView.h"
#import "define.h"
#import "MyRedBagCell.h"
#import "GrabBagCell.h"
#import "WinAPrizeViewController.h"
#import "NewRedBagCell.h"
#import "NewHandViewController.h"

@interface MyRedBagViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    UIView *viewHead;
    UIButton *butMyRedBag;
    UIButton * butRecord;
    UILabel *labelLine;
    NSArray *twoArr;
    WinAPrizeViewController *winPrizeVC;
    MyRedBagViewController *redVC;
    BOOL consult;
}

@end

@implementation MyRedBagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationItem setTitle:@"我的红包"];
    [self tableViewShow];
    
    consult = YES;
}

//内容展示
- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    UIView *viewFoot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT * (11.0 / 667.0))];
    _tableView.tableFooterView = viewFoot;
    viewFoot.backgroundColor = [UIColor huibai];
    
    [_tableView registerNib:[UINib nibWithNibName:@"GrabBagCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [_tableView registerNib:[UINib nibWithNibName:@"MyRedBagCell" bundle:nil] forCellReuseIdentifier:@"reuse1"];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 0;
        
    } else {
        
        return HEIGHT_CONTROLLER_DEFAULT * (11.0 / 667.0);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 50;
        
    } else {
        
        return 132;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
        
    } else {
        
        return 1;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        GrabBagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        
        if (cell == nil) {
            
            cell = [[GrabBagCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
        }
        
        cell.labelGrab.text = @"累计获得红包收益";
        cell.labelGrab.font = [UIFont systemFontOfSize:15];
        
        cell.labelQianShu.text = @"999元";
        cell.labelQianShu.textColor = [UIColor daohanglan];
        cell.labelQianShu.textAlignment = NSTextAlignmentRight;
        cell.labelQianShu.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    } else {
        
        MyRedBagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse1"];
        
        if (cell == nil) {
            
            cell = [[MyRedBagCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse1"];
        }
        
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        cell.viewBottm.layer.cornerRadius = 3;
        cell.viewBottm.layer.masksToBounds = YES;
        cell.viewBottm.backgroundColor = [UIColor whiteColor];
        
        cell.viewDown.backgroundColor = [UIColor qianhuise];
        
        cell.bigBag.text = @"国庆现金大礼包";
        cell.bigBag.font = [UIFont systemFontOfSize:15];
        
        cell.labelDeduction.text = @"现金抵扣";
        cell.labelDeduction.textColor = [UIColor daohanglan];
        cell.labelDeduction.font = [UIFont systemFontOfSize:11];
        cell.labelDeduction.textAlignment = NSTextAlignmentCenter;
        cell.labelDeduction.layer.cornerRadius = 6;
        cell.labelDeduction.layer.masksToBounds = YES;
        cell.labelDeduction.layer.borderWidth = 1;
        cell.labelDeduction.layer.borderColor = [[UIColor daohanglan] CGColor];
        
        cell.validData.text = [NSString stringWithFormat:@"%@ : %@", @"有效期", @"2015.09.09- 2015.12.31"];
        cell.validData.textColor = [UIColor zitihui];
        cell.validData.font = [UIFont systemFontOfSize:13];
        
        cell.labelLine.backgroundColor = [UIColor grayColor];
        cell.labelLine.alpha = 0.2;
        
        NSMutableAttributedString *redString = [[NSMutableAttributedString alloc] initWithString:@"10,000元"];
        NSRange yuanRange = NSMakeRange(0, [[redString string] rangeOfString:@"元"] .location);
        [redString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:19] range:yuanRange];
        NSRange wenZi = NSMakeRange([[redString string] length] - 1, 1);
        [redString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:wenZi];
        [cell.yuanShu setAttributedText:redString];
        cell.yuanShu.textColor = [UIColor daohanglan];
        cell.yuanShu.textAlignment = NSTextAlignmentRight;
        
        cell.labelUse.text = @"可使用";
        cell.labelUse.textColor = [UIColor colorWithRed:134.0 / 255.0 green:205.0 / 255.0 blue:151.0 / 255.0 alpha:1.0];
        cell.labelUse.font = [UIFont systemFontOfSize:13];
        cell.labelUse.textAlignment = NSTextAlignmentRight;
        
        cell.labelLowest.text = [NSString stringWithFormat:@"%@ : %@", @"最低投资金额", @"2,000元"];
        cell.labelLowest.textColor = [UIColor zitihui];
        cell.labelLowest.font = [UIFont systemFontOfSize:11];
        cell.labelLowest.backgroundColor = [UIColor clearColor];
        
        cell.labelDaYu.text = @"3个月及以上标的,出借≥1,000元";
        cell.labelDaYu.font = [UIFont systemFontOfSize:11];
        cell.labelDaYu.textColor = [UIColor zitihui];
        cell.labelDaYu.backgroundColor = [UIColor clearColor];
        
        cell.labelMonth.text = [NSString stringWithFormat:@"%@ : %@", @"起投期限", @"3个月"];
        cell.labelMonth.textColor = [UIColor zitihui];
        cell.labelMonth.font = [UIFont systemFontOfSize:11];
        cell.labelMonth.textAlignment = NSTextAlignmentRight;
        cell.labelMonth.backgroundColor = [UIColor clearColor];
        
        cell.bottomLine.backgroundColor = [UIColor grayColor];
        cell.bottomLine.alpha = 0.2;
        
        return cell;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
