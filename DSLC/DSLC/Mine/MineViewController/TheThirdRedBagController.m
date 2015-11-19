//
//  TheThirdRedBagController.m
//  DSLC
//
//  Created by ios on 15/11/18.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "TheThirdRedBagController.h"
#import "TheThirdRedBagCell.h"
#import "NotSeparateCell.h"
#import "NewHandCSSCell.h"

@interface TheThirdRedBagController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSArray *imageBagArr;
    NSArray *styleArr;
    
    UIButton *butBlack;
    UILabel *labelGet;
}

@end

@implementation TheThirdRedBagController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor huibai];
    [self.navigationItem setTitle:@"我的红包"];
    
    [self viewShow];
    [self tableViewShow];
}

- (void)viewShow
{
    UIView *view = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:view];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 49.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [view addSubview:viewLine];
    viewLine.alpha = 0.3;
    
    UILabel *labelBag = [CreatView creatWithLabelFrame:CGRectMake(10, 10, (WIDTH_CONTROLLER_DEFAULT - 20)/2, 30) backgroundColor:[UIColor whiteColor] textColor:nil textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"累计使用红包"];
    [view addSubview:labelBag];
    
    UILabel *labelMoney = [CreatView creatWithLabelFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2, 10, (WIDTH_CONTROLLER_DEFAULT - 20)/2, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor daohanglan] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"999元"];
    [view addSubview:labelMoney];
    
    imageBagArr = @[@"新手体验金", @"银元宝", @"铜元宝", @"钻石", @"金元宝", @"阶梯", @"邀请"];
    styleArr = @[@"新手体验金", @"银元宝红包", @"铜元宝红包", @"钻石红包", @"金元宝红包", @"阶梯红包", @"邀请红包"];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 50) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.backgroundColor = [UIColor huibai];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 5)];
    _tableView.tableHeaderView.backgroundColor = [UIColor huibai];
    _tableView.tableFooterView = [UIView new];
    [_tableView registerNib:[UINib nibWithNibName:@"NewHandCSSCell" bundle:nil] forCellReuseIdentifier:@"reuseNewHand"];
    [_tableView registerNib:[UINib nibWithNibName:@"TheThirdRedBagCell" bundle:nil] forCellReuseIdentifier:@"Reuse"];
    [_tableView registerNib:[UINib nibWithNibName:@"NotSeparateCell" bundle:nil] forCellReuseIdentifier:@"Reuse1"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 1) {
        
        return 145;
        
    } else {
        
        return 100;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        NewHandCSSCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseNewHand"];
        
        cell.imagePic.image = [UIImage imageNamed:@"新手体验金"];
        [cell.buttonCan setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [cell.buttonCan setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        [cell.buttonCan setTitle:@"立即使用" forState:UIControlStateNormal];
        [cell.buttonCan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cell.buttonCan.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        [cell.buttonCan addTarget:self action:@selector(buttonRightNowMake:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.labelSend.text = @"送";
        cell.labelSend.textColor = [UIColor whiteColor];
        cell.labelSend.textAlignment = NSTextAlignmentCenter;
        cell.labelSend.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        cell.labelSend.backgroundColor = [UIColor daohanglan];
        cell.labelSend.layer.cornerRadius = 5;
        cell.labelSend.layer.masksToBounds = YES;
        
        NSMutableAttributedString *redStr = [[NSMutableAttributedString alloc] initWithString:@"10,000元"];
        NSRange leftStr = NSMakeRange(0, [[redStr string] rangeOfString:@"元"].location);
        [redStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:20] range:leftStr];
        [redStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:22] range:leftStr];
        [redStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:[@"10,000元" rangeOfString:@"元"]];
        [cell.labelMoney setAttributedText:redStr];
        cell.labelMoney.textColor = [UIColor daohanglan];
        cell.labelMoney.backgroundColor = [UIColor clearColor];
        
        cell.labelStyle.text = [styleArr objectAtIndex:indexPath.row];
        cell.labelStyle.backgroundColor = [UIColor clearColor];
        cell.labelStyle.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.labelRequire.text = @"单笔投资金额满2,000";
        cell.labelRequire.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.labelRequire.textColor = [UIColor zitihui];
        cell.labelRequire.backgroundColor = [UIColor clearColor];
                
        cell.labelTime.text = [NSString stringWithFormat:@"%@%@", @"有效期:截止", @"2015.12.31"];
        cell.labelTime.font = [UIFont fontWithName:@"CenturyGothic" size:11];
        cell.labelTime.textColor = [UIColor zitihui];
        cell.labelTime.backgroundColor = [UIColor clearColor];
        
        cell.backgroundColor = [UIColor huibai];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else if (indexPath.row == 1) {
        
        TheThirdRedBagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Reuse"];
        
        cell.imagePic.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [imageBagArr objectAtIndex:indexPath.row]]];
        
        [cell.buttonOpen setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [cell.buttonOpen setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        [cell.buttonOpen setTitle:@"拆红包" forState:UIControlStateNormal];
        [cell.buttonOpen setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cell.buttonOpen.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        [cell.buttonOpen addTarget:self action:@selector(openRedBagButton:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.labelAend.text = @"送";
        cell.labelAend.textColor = [UIColor whiteColor];
        cell.labelAend.textAlignment = NSTextAlignmentCenter;
        cell.labelAend.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        cell.labelAend.backgroundColor = [UIColor daohanglan];
        cell.labelAend.layer.cornerRadius = 5;
        cell.labelAend.layer.masksToBounds = YES;
        
        NSMutableAttributedString *redStr = [[NSMutableAttributedString alloc] initWithString:@"10,000元"];
        NSRange leftStr = NSMakeRange(0, [[redStr string] rangeOfString:@"元"].location);
        [redStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:20] range:leftStr];
        [redStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:22] range:leftStr];
        [redStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:[@"10,000元" rangeOfString:@"元"]];
        [cell.labelMoney setAttributedText:redStr];
        cell.labelMoney.textColor = [UIColor daohanglan];
        cell.labelMoney.backgroundColor = [UIColor clearColor];
        
        cell.labelStyle.text = [styleArr objectAtIndex:indexPath.row];
        cell.labelStyle.backgroundColor = [UIColor clearColor];
        cell.labelStyle.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.labelRequier.text = @"单笔投资金额满2,000";
        cell.labelRequier.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.labelRequier.textColor = [UIColor zitihui];
        cell.labelRequier.backgroundColor = [UIColor clearColor];
        
        cell.labelDay.text = @"理财期限大于360天";
        cell.labelDay.textColor = [UIColor zitihui];
        cell.labelDay.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        cell.labelDay.backgroundColor = [UIColor clearColor];
        
        cell.labelTime.text = [NSString stringWithFormat:@"%@%@", @"有效期:截止", @"2015.12.31"];
        cell.labelTime.font = [UIFont fontWithName:@"CenturyGothic" size:11];
        cell.labelTime.textColor = [UIColor zitihui];
        cell.labelTime.backgroundColor = [UIColor clearColor];
        
        cell.backgroundColor = [UIColor huibai];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        
        NotSeparateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Reuse1"];
        
        cell.labelSend.text = @"送";
        cell.labelSend.textColor = [UIColor whiteColor];
        cell.labelSend.textAlignment = NSTextAlignmentCenter;
        cell.labelSend.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        cell.labelSend.backgroundColor = [UIColor daohanglan];
        cell.labelSend.layer.cornerRadius = 5;
        cell.labelSend.layer.masksToBounds = YES;
        
        NSMutableAttributedString *redStr = [[NSMutableAttributedString alloc] initWithString:@"50~70元"];
        NSRange leftStr = NSMakeRange(0, [[redStr string] rangeOfString:@"元"].location);
        [redStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:20] range:leftStr];
        [redStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:22] range:leftStr];
        [redStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:[@"50~70元" rangeOfString:@"元"]];
        [cell.labelMoney setAttributedText:redStr];
        cell.labelMoney.textColor = [UIColor daohanglan];
        cell.labelMoney.backgroundColor = [UIColor clearColor];
        
        cell.labelBagStyle.text = [styleArr objectAtIndex:indexPath.row];
        cell.labelBagStyle.backgroundColor = [UIColor clearColor];
        cell.labelBagStyle.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.laeblRequest.text = @"单笔投资金额满2,000";
        cell.laeblRequest.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.laeblRequest.textColor = [UIColor zitihui];
        cell.laeblRequest.backgroundColor = [UIColor clearColor];
        
        cell.labelDays.text = @"理财期限大于360天";
        cell.labelDays.textColor = [UIColor zitihui];
        cell.labelDays.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        cell.labelDays.backgroundColor = [UIColor clearColor];
        
        cell.labelTime.text = [NSString stringWithFormat:@"%@%@", @"有效期:截止", @"2015.12.31"];
        cell.labelTime.font = [UIFont fontWithName:@"CenturyGothic" size:11];
        cell.labelTime.textColor = [UIColor zitihui];
        cell.labelTime.backgroundColor = [UIColor clearColor];
        
        cell.imagePic.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [imageBagArr objectAtIndex:indexPath.row]]];
        
        cell.backgroundColor = [UIColor huibai];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 1) {
        
        
    }
    
}

- (void)openFinish:(UIButton *)button
{
    [button removeFromSuperview];
    button = nil;
}

//立即使用
- (void)buttonRightNowMake:(UIButton *)button
{
    butBlack = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC.view addSubview:butBlack];
    [butBlack setBackgroundImage:[UIImage imageNamed:@"钻石红包"] forState:UIControlStateNormal];
    [butBlack addTarget:self action:@selector(openFinish:) forControlEvents:UIControlEventTouchUpInside];
    
    labelGet = [[UILabel alloc] initWithFrame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT/3 + 40, butBlack.frame.size.width, 70)];
    [butBlack addSubview:labelGet];
    labelGet.textAlignment = NSTextAlignmentCenter;
    labelGet.backgroundColor = [UIColor clearColor];
    NSMutableAttributedString *frontStr = [[NSMutableAttributedString alloc] initWithString:@"恭喜您获得100元现金红包\n\n已转入账户余额"];
    [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:16] range:[@"恭喜您获得100元现金红包\n\n已转入账户余额" rangeOfString:@"恭喜您获得"]];
    [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:16] range:[@"恭喜您获得100元现金红包\n\n已转入账户余额" rangeOfString:@"元现金红包"]];
    [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:[@"恭喜您获得100元现金红包\n\n已转入账户余额" rangeOfString:@"已转入账户余额"]];
    //    取到恭~0的长度 减掉5 就剩100
    NSRange shuZi = NSMakeRange(5, [[frontStr string] rangeOfString:@"元"].location - 5);
    [frontStr addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:shuZi];
    [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:25] range:shuZi];
    [labelGet setAttributedText:frontStr];
    labelGet.numberOfLines = 3;
}

//拆开红包
- (void)openRedBagButton:(UIButton *)button
{
    butBlack = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC.view addSubview:butBlack];
    [butBlack setBackgroundImage:[UIImage imageNamed:@"钻石红包"] forState:UIControlStateNormal];
    [butBlack addTarget:self action:@selector(openFinish:) forControlEvents:UIControlEventTouchUpInside];
    
    labelGet = [[UILabel alloc] initWithFrame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT/3 + 40, butBlack.frame.size.width, 70)];
    [butBlack addSubview:labelGet];
    labelGet.textAlignment = NSTextAlignmentCenter;
    labelGet.backgroundColor = [UIColor clearColor];
    NSMutableAttributedString *frontStr = [[NSMutableAttributedString alloc] initWithString:@"恭喜您获得100元现金红包\n\n已转入账户余额"];
    [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:16] range:[@"恭喜您获得100元现金红包\n\n已转入账户余额" rangeOfString:@"恭喜您获得"]];
    [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:16] range:[@"恭喜您获得100元现金红包\n\n已转入账户余额" rangeOfString:@"元现金红包"]];
    [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:[@"恭喜您获得100元现金红包\n\n已转入账户余额" rangeOfString:@"已转入账户余额"]];
    //    取到恭~0的长度 减掉5 就剩100
    NSRange shuZi = NSMakeRange(5, [[frontStr string] rangeOfString:@"元"].location - 5);
    [frontStr addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:shuZi];
    [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:25] range:shuZi];
    [labelGet setAttributedText:frontStr];
    labelGet.numberOfLines = 3;
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