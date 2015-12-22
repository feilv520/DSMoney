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
#import "RedBagModel.h"
#import "FDetailViewController.h"
#import "RedBagExplainViewController.h"

@interface TheThirdRedBagController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSArray *imageBagArr;
    NSArray *styleArr;
    
    UIButton *butBlack;
    UILabel *labelGet;
    
    UIView *headView;
    
    UILabel *labelMoney;
}

@property (nonatomic, strong) NSMutableArray *redBagArray;
@property (nonatomic, strong) NSDictionary *openRedBagDic;

@end

@implementation TheThirdRedBagController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.openRedBagDic = [NSDictionary dictionary];
    
    self.view.backgroundColor = [UIColor huibai];
    [self.navigationItem setTitle:@"我的红包"];
    
    self.redBagArray = [NSMutableArray array];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"红包说明" style:UIBarButtonItemStylePlain target:self action:@selector(barRightItem:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:13], NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    [self getMyRedPacketList];
    [self viewShow];
    [self tableViewShow];
}

//红包说明
- (void)barRightItem:(UIBarButtonItem *)bar
{
    RedBagExplainViewController *redBag = [[RedBagExplainViewController alloc] init];
    [self.navigationController pushViewController:redBag animated:YES];
}

- (void)viewShow
{
    headView = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:headView];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 49.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [headView addSubview:viewLine];
    viewLine.alpha = 0.3;
    
    UILabel *labelBag = [CreatView creatWithLabelFrame:CGRectMake(10, 10, (WIDTH_CONTROLLER_DEFAULT - 20)/2, 30) backgroundColor:[UIColor clearColor] textColor:nil textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"累计使用红包"];
    [headView addSubview:labelBag];
    
    labelMoney = [CreatView creatWithLabelFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2, 10, (WIDTH_CONTROLLER_DEFAULT - 20)/2, 30) backgroundColor:[UIColor clearColor] textColor:[UIColor daohanglan] textAlignment:NSTextAlignmentRight textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:[NSString stringWithFormat:@"0.00元"]];
    [headView addSubview:labelMoney];
    
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
    UIView *vieww = [UIView new];
    vieww.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10);
    _tableView.tableFooterView = vieww;
    [_tableView registerNib:[UINib nibWithNibName:@"NewHandCSSCell" bundle:nil] forCellReuseIdentifier:@"reuseNewHand"];
    [_tableView registerNib:[UINib nibWithNibName:@"TheThirdRedBagCell" bundle:nil] forCellReuseIdentifier:@"Reuse"];
    [_tableView registerNib:[UINib nibWithNibName:@"NotSeparateCell" bundle:nil] forCellReuseIdentifier:@"Reuse1"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RedBagModel *redbagModel = [self.redBagArray objectAtIndex:indexPath.row];
    
    if ([[redbagModel rpType] isEqualToString:@"1"] || [[redbagModel rpType] isEqualToString:@"0"] || [[redbagModel rpType] isEqualToString:@"3"] || [[redbagModel rpType] isEqualToString:@"4"] || [[redbagModel rpType] isEqualToString:@"2"]) {
        if ([[redbagModel rpStatus] isEqualToString:@"0"])
            return 145;
        else
            return 100;
    } else {
        
//        if ([[redbagModel rpStatus] isEqualToString:@"0"])
//            return 145;
//        else
            return 100;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.redBagArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RedBagModel *redbagModel = [self.redBagArray objectAtIndex:indexPath.row];

    if ([[redbagModel rpType] isEqualToString:@"1"]) {
    
        NewHandCSSCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseNewHand"];
        
        cell.buttonCan.hidden = YES;
        
        cell.labelSend.text = @"送";
        cell.labelSend.textColor = [UIColor whiteColor];
        cell.labelSend.textAlignment = NSTextAlignmentCenter;
        cell.labelSend.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        cell.labelSend.backgroundColor = [UIColor daohanglan];
        cell.labelSend.layer.cornerRadius = 5;
        cell.labelSend.layer.masksToBounds = YES;

        NSString *string = [NSString stringWithFormat:@"%@元",[redbagModel rpAmount]];
        
        NSMutableAttributedString *redStr = [[NSMutableAttributedString alloc] initWithString:string];
        NSRange leftStr = NSMakeRange(0, [[redStr string] rangeOfString:@"元"].location);
        [redStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:20] range:leftStr];
        [redStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:22] range:leftStr];
        [redStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:[string rangeOfString:@"元"]];
        [cell.labelMoney setAttributedText:redStr];
        cell.labelMoney.textColor = [UIColor daohanglan];
        cell.labelMoney.backgroundColor = [UIColor clearColor];

        cell.labelStyle.text = [redbagModel rpName];
        cell.labelStyle.backgroundColor = [UIColor clearColor];
        cell.labelStyle.font = [UIFont fontWithName:@"CenturyGothic" size:12];

//        cell.labelRequire.text = [NSString stringWithFormat:@"单笔投资金额满%@",[redbagModel rpLimit]];
        cell.labelRequire.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.labelRequire.textColor = [UIColor zitihui];
        cell.labelRequire.backgroundColor = [UIColor clearColor];
        
        cell.labelRequire.text = @"仅限购买新手专享";

        cell.labelTime.text = [NSString stringWithFormat:@"%@%@", @"有效期:截止", [redbagModel rpTime]];
        cell.labelTime.font = [UIFont fontWithName:@"CenturyGothic" size:11];
        cell.labelTime.textColor = [UIColor zitihui];
        cell.labelTime.backgroundColor = [UIColor clearColor];
        
        cell.backgroundColor = [UIColor huibai];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.imagePic.image = [UIImage imageNamed:@"新手体验金"];
        
        if ([[redbagModel rpStatus] isEqualToString:@"0"]) {
            
            cell.buttonCan.hidden = NO;
            
            [cell.buttonCan setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
            [cell.buttonCan setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
            [cell.buttonCan setTitle:@"立即使用" forState:UIControlStateNormal];
            [cell.buttonCan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            cell.buttonCan.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
            [cell.buttonCan addTarget:self action:@selector(buttonRightNowMake:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.imagePic.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [imageBagArr objectAtIndex:indexPath.row % 6]]];
            cell.labelSend.backgroundColor = [UIColor daohanglan];
            
        } else if ([[redbagModel rpStatus] isEqualToString:@"2"]){
            
            cell.imagePic.image = [UIImage imageNamed:[NSString stringWithFormat:@"已打开"]];
            cell.labelSend.backgroundColor = [UIColor zitihui];
            cell.labelStyle.textColor = [UIColor zitihui];
            cell.labelMoney.textColor = [UIColor zitihui];
            
        } else if ([[redbagModel rpStatus] isEqualToString:@"3"]){
            
            cell.imagePic.image = [UIImage imageNamed:[NSString stringWithFormat:@"已过期"]];
            cell.labelSend.backgroundColor = [UIColor zitihui];
            cell.labelStyle.textColor = [UIColor zitihui];
            cell.labelMoney.textColor = [UIColor zitihui];
            
        }

        return cell;

    } else if ([[redbagModel rpType] isEqualToString:@"0"]) {
        
        NewHandCSSCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseNewHand"];
        
        cell.buttonCan.hidden = YES;
        
        cell.labelSend.text = @"送";
        cell.labelSend.textColor = [UIColor whiteColor];
        cell.labelSend.textAlignment = NSTextAlignmentCenter;
        cell.labelSend.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        cell.labelSend.backgroundColor = [UIColor daohanglan];
        cell.labelSend.layer.cornerRadius = 5;
        cell.labelSend.layer.masksToBounds = YES;
        
        NSString *string = [NSString stringWithFormat:@"%@元",[redbagModel rpAmount]];
        
        NSMutableAttributedString *redStr = [[NSMutableAttributedString alloc] initWithString:string];
        NSRange leftStr = NSMakeRange(0, [[redStr string] rangeOfString:@"元"].location);
        [redStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:20] range:leftStr];
        [redStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:22] range:leftStr];
        [redStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:[string rangeOfString:@"元"]];
        [cell.labelMoney setAttributedText:redStr];
        cell.labelMoney.textColor = [UIColor daohanglan];
        cell.labelMoney.backgroundColor = [UIColor clearColor];
        
        cell.labelStyle.text = [redbagModel rpName];
        cell.labelStyle.backgroundColor = [UIColor clearColor];
        cell.labelStyle.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        //        cell.labelRequire.text = [NSString stringWithFormat:@"单笔投资金额满%@",[redbagModel rpLimit]];
        cell.labelRequire.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.labelRequire.textColor = [UIColor zitihui];
        cell.labelRequire.backgroundColor = [UIColor clearColor];
        
        cell.labelRequire.text = @"可直接打开";
        
        cell.labelTime.text = [NSString stringWithFormat:@"%@%@", @"有效期:截止", [redbagModel rpTime]];
        cell.labelTime.font = [UIFont fontWithName:@"CenturyGothic" size:11];
        cell.labelTime.textColor = [UIColor zitihui];
        cell.labelTime.backgroundColor = [UIColor clearColor];
        
        cell.backgroundColor = [UIColor huibai];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.imagePic.image = [UIImage imageNamed:@"新手体验金"];
        
        if ([[redbagModel rpStatus] isEqualToString:@"0"]) {
            
            cell.buttonCan.hidden = NO;
            [cell.buttonCan setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
            [cell.buttonCan setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
            [cell.buttonCan setTitle:@"拆红包" forState:UIControlStateNormal];
            [cell.buttonCan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            cell.buttonCan.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
            [cell.buttonCan addTarget:self action:@selector(openRedBagButton:) forControlEvents:UIControlEventTouchUpInside];
            
            cell.imagePic.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [imageBagArr objectAtIndex:indexPath.row % 6]]];
            cell.labelSend.backgroundColor = [UIColor daohanglan];
            
        } else if ([[redbagModel rpStatus] isEqualToString:@"2"]){
            
            cell.imagePic.image = [UIImage imageNamed:[NSString stringWithFormat:@"已打开"]];
            cell.labelSend.backgroundColor = [UIColor zitihui];
            cell.labelStyle.textColor = [UIColor zitihui];
            cell.labelMoney.textColor = [UIColor zitihui];
            
        } else if ([[redbagModel rpStatus] isEqualToString:@"3"]){
            
            cell.imagePic.image = [UIImage imageNamed:[NSString stringWithFormat:@"已过期"]];
            cell.labelSend.backgroundColor = [UIColor zitihui];
            cell.labelStyle.textColor = [UIColor zitihui];
            cell.labelMoney.textColor = [UIColor zitihui];
            
        }
        
        
        return cell;
        
    } else if ([[redbagModel rpType] isEqualToString:@"3"]) {
        TheThirdRedBagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Reuse"];
        
        cell.buttonOpen.hidden = YES;
        
        [cell.buttonOpen setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [cell.buttonOpen setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        [cell.buttonOpen setTitle:@"拆红包" forState:UIControlStateNormal];
        [cell.buttonOpen setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cell.buttonOpen.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        [cell.buttonOpen addTarget:self action:@selector(openRedBagButton:) forControlEvents:UIControlEventTouchUpInside];
        [cell.buttonOpen setTag:indexPath.row];
        
        cell.labelAend.text = @"送";
        cell.labelAend.textColor = [UIColor whiteColor];
        cell.labelAend.textAlignment = NSTextAlignmentCenter;
        cell.labelAend.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        cell.labelAend.backgroundColor = [UIColor daohanglan];
        cell.labelAend.layer.cornerRadius = 5;
        cell.labelAend.layer.masksToBounds = YES;
        
        NSString *string = [NSString stringWithFormat:@"%@元",[redbagModel rpAmount]];
        
        NSMutableAttributedString *redStr = [[NSMutableAttributedString alloc] initWithString:string];
        NSRange leftStr = NSMakeRange(0, [[redStr string] rangeOfString:@"元"].location);
        [redStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:20] range:leftStr];
        [redStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:22] range:leftStr];
        [redStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:[string rangeOfString:@"元"]];
        [cell.labelMoney setAttributedText:redStr];
        cell.labelMoney.textColor = [UIColor daohanglan];
        cell.labelMoney.backgroundColor = [UIColor clearColor];
        
        cell.labelStyle.text = [redbagModel rpName];
        cell.labelStyle.backgroundColor = [UIColor clearColor];
        cell.labelStyle.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.labelRequier.text = [NSString stringWithFormat:@"单笔投资金额满%@",[redbagModel rpLimit]];
        cell.labelRequier.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.labelRequier.textColor = [UIColor zitihui];
        cell.labelRequier.backgroundColor = [UIColor clearColor];
        
        cell.labelDay.text = [NSString stringWithFormat:@"理财期限大于%@天",[redbagModel daysLimit]];
        cell.labelDay.textColor = [UIColor zitihui];
        cell.labelDay.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        cell.labelDay.backgroundColor = [UIColor clearColor];
        
        if ([[redbagModel rpType] isEqualToString:@"0"]) {
            
            cell.labelDay.hidden = YES;
            
        }
        
        cell.labelTime.text = [NSString stringWithFormat:@"%@%@", @"有效期:截止", [redbagModel rpTime]];
        cell.labelTime.font = [UIFont fontWithName:@"CenturyGothic" size:11];
        cell.labelTime.textColor = [UIColor zitihui];
        cell.labelTime.backgroundColor = [UIColor clearColor];
        
        cell.backgroundColor = [UIColor huibai];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.imagePic.image = [UIImage imageNamed:@"新手体验金"];
        
        if ([[redbagModel rpStatus] isEqualToString:@"0"]) {
            cell.buttonOpen.hidden = NO;
            cell.imagePic.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [imageBagArr objectAtIndex:indexPath.row % 6]]];
            cell.labelAend.backgroundColor = [UIColor daohanglan];
            
        } else if ([[redbagModel rpStatus] isEqualToString:@"2"]){
            
            cell.imagePic.image = [UIImage imageNamed:[NSString stringWithFormat:@"已打开"]];
            cell.labelAend.backgroundColor = [UIColor zitihui];
            cell.labelStyle.textColor = [UIColor zitihui];
            cell.labelMoney.textColor = [UIColor zitihui];
            
        } else if ([[redbagModel rpStatus] isEqualToString:@"3"]){
            
            cell.imagePic.image = [UIImage imageNamed:[NSString stringWithFormat:@"已过期"]];
            cell.labelAend.backgroundColor = [UIColor zitihui];
            cell.labelStyle.textColor = [UIColor zitihui];
            cell.labelMoney.textColor = [UIColor zitihui];
            
        }
        
        return cell;
    } else if ([[redbagModel rpType] isEqualToString:@"2"]) {
        TheThirdRedBagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Reuse"];
        
        NSLog(@"rpStatus = %@",[redbagModel rpStatus]);
        
        cell.buttonOpen.hidden = YES;
        
        cell.labelAend.text = @"送";
        cell.labelAend.textColor = [UIColor whiteColor];
        cell.labelAend.textAlignment = NSTextAlignmentCenter;
        cell.labelAend.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        cell.labelAend.backgroundColor = [UIColor daohanglan];
        cell.labelAend.layer.cornerRadius = 5;
        cell.labelAend.layer.masksToBounds = YES;
        
        NSString *string = [NSString stringWithFormat:@"%@~%@元",[redbagModel rpFloor],[redbagModel rpTop]];
        
        NSMutableAttributedString *redStr = [[NSMutableAttributedString alloc] initWithString:string];
        NSRange leftStr = NSMakeRange(0, [[redStr string] rangeOfString:@"元"].location);
        [redStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:20] range:leftStr];
        [redStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:22] range:leftStr];
        [redStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:[string rangeOfString:@"元"]];
        [cell.labelMoney setAttributedText:redStr];
        cell.labelMoney.textColor = [UIColor daohanglan];
        cell.labelMoney.backgroundColor = [UIColor clearColor];
        
        cell.labelStyle.text = [redbagModel rpName];
        cell.labelStyle.backgroundColor = [UIColor clearColor];
        cell.labelStyle.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.labelRequier.text = [NSString stringWithFormat:@"单笔投资金额满%@",[redbagModel rpLimit]];
        cell.labelRequier.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.labelRequier.textColor = [UIColor zitihui];
        cell.labelRequier.backgroundColor = [UIColor clearColor];
        
        cell.labelDay.text = [NSString stringWithFormat:@"理财期限大于%@天",[redbagModel daysLimit]];
        cell.labelDay.textColor = [UIColor zitihui];
        cell.labelDay.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        cell.labelDay.backgroundColor = [UIColor clearColor];
        
        cell.labelTime.text = [NSString stringWithFormat:@"%@%@", @"有效期:截止", [redbagModel rpTime]];
        cell.labelTime.font = [UIFont fontWithName:@"CenturyGothic" size:11];
        cell.labelTime.textColor = [UIColor zitihui];
        cell.labelTime.backgroundColor = [UIColor clearColor];
        
        cell.backgroundColor = [UIColor huibai];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.imagePic.image = [UIImage imageNamed:@"新手体验金"];
        
        if ([[redbagModel rpStatus] isEqualToString:@"3"]){
            
            cell.imagePic.image = [UIImage imageNamed:[NSString stringWithFormat:@"已过期"]];
            cell.labelAend.backgroundColor = [UIColor zitihui];
            cell.labelStyle.textColor = [UIColor zitihui];
            cell.labelMoney.textColor = [UIColor zitihui];
            
        } else if ([[redbagModel rpStatus] isEqualToString:@"2"]){
            
            cell.imagePic.image = [UIImage imageNamed:[NSString stringWithFormat:@"已打开"]];
            cell.labelAend.backgroundColor = [UIColor zitihui];
            cell.labelStyle.textColor = [UIColor zitihui];
            cell.labelMoney.textColor = [UIColor zitihui];
            
        } else if ([[redbagModel rpStatus] isEqualToString:@"0"]) {
            cell.buttonOpen.hidden = NO;
            
            [cell.buttonOpen setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
            [cell.buttonOpen setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
            [cell.buttonOpen setTitle:@"拆红包" forState:UIControlStateNormal];
            [cell.buttonOpen setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            cell.buttonOpen.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
            [cell.buttonOpen addTarget:self action:@selector(openRedBagButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell.buttonOpen setTag:indexPath.row];
            
            cell.imagePic.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [imageBagArr objectAtIndex:indexPath.row % 6]]];
            cell.labelAend.backgroundColor = [UIColor daohanglan];
        }
        return cell;
    } else if ([[[self.redBagArray objectAtIndex:indexPath.row] rpType] isEqualToString:@"4"]) {
        NotSeparateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Reuse1"];
        
        cell.buttonOpen.hidden = YES;
        
        cell.labelSend.text = @"送";
        cell.labelSend.textColor = [UIColor whiteColor];
        cell.labelSend.textAlignment = NSTextAlignmentCenter;
        cell.labelSend.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        cell.labelSend.backgroundColor = [UIColor daohanglan];
        cell.labelSend.layer.cornerRadius = 5;
        cell.labelSend.layer.masksToBounds = YES;
        
        NSString *string = [NSString stringWithFormat:@"%@~%@元",[redbagModel rpFloor],[redbagModel rpTop]];
        NSMutableAttributedString *redStr = [[NSMutableAttributedString alloc] initWithString:string];
        NSRange leftStr = NSMakeRange(0, [[redStr string] rangeOfString:@"元"].location);
        [redStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:20] range:leftStr];
        [redStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:22] range:leftStr];
        [redStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:[string rangeOfString:@"元"]];
        [cell.labelMoney setAttributedText:redStr];
        cell.labelMoney.textColor = [UIColor daohanglan];
        cell.labelMoney.backgroundColor = [UIColor clearColor];
        
        cell.labelBagStyle.text = [redbagModel rpName];
        cell.labelBagStyle.backgroundColor = [UIColor clearColor];
        cell.labelBagStyle.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        
        cell.laeblRequest.text = [NSString stringWithFormat:@"单笔投资金额满%@",[redbagModel rpLimit]];
        cell.laeblRequest.font = [UIFont fontWithName:@"CenturyGothic" size:14];
        cell.laeblRequest.textColor = [UIColor zitihui];
        cell.laeblRequest.backgroundColor = [UIColor clearColor];
        
        cell.laeblRequest.hidden = YES;
        
        cell.labelDays.text = [NSString stringWithFormat:@"累积在投金额满%@元",[redbagModel rpLimit]];
//        cell.labelDays.text = [NSString stringWithFormat:@"理财期限大于%@天",[redbagModel daysLimit]];
        cell.labelDays.textColor = [UIColor zitihui];
        cell.labelDays.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        cell.labelDays.backgroundColor = [UIColor clearColor];
        
        cell.labelTime.text = [NSString stringWithFormat:@"%@%@", @"有效期:截止", [redbagModel rpTime]];
        cell.labelTime.font = [UIFont fontWithName:@"CenturyGothic" size:11];
        cell.labelTime.textColor = [UIColor zitihui];
        cell.labelTime.backgroundColor = [UIColor clearColor];
        
        cell.backgroundColor = [UIColor huibai];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.imagePic.image = [UIImage imageNamed:@"新手体验金"];
        
        if ([[redbagModel rpStatus] isEqualToString:@"3"]){
            
            cell.imagePic.image = [UIImage imageNamed:[NSString stringWithFormat:@"已过期"]];
            cell.labelSend.backgroundColor = [UIColor zitihui];
            cell.labelBagStyle.textColor = [UIColor zitihui];
            cell.labelMoney.textColor = [UIColor zitihui];
            
        } else if ([[redbagModel rpStatus] isEqualToString:@"2"]){
            
            cell.imagePic.image = [UIImage imageNamed:[NSString stringWithFormat:@"已打开"]];
            cell.labelSend.backgroundColor = [UIColor zitihui];
            cell.labelBagStyle.textColor = [UIColor zitihui];
            cell.labelMoney.textColor = [UIColor zitihui];
            
        } else if([[redbagModel rpStatus] isEqualToString:@"0"]){
            cell.buttonOpen.hidden = NO;
            
            [cell.buttonOpen setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
            [cell.buttonOpen setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
            [cell.buttonOpen setTitle:@"拆红包" forState:UIControlStateNormal];
            [cell.buttonOpen setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            cell.buttonOpen.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
            [cell.buttonOpen addTarget:self action:@selector(openRedBagButton:) forControlEvents:UIControlEventTouchUpInside];
            [cell.buttonOpen setTag:indexPath.row];
            
            cell.imagePic.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [imageBagArr objectAtIndex:indexPath.row]]];
            cell.labelSend.backgroundColor = [UIColor daohanglan];
        }
        
        
        return cell;
    } else {
        return nil;
    }
//    if (indexPath.row == 0) {
//        
//        NewHandCSSCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseNewHand"];
//        
//        cell.imagePic.image = [UIImage imageNamed:@"新手体验金"];
//        [cell.buttonCan setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
//        [cell.buttonCan setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
//        [cell.buttonCan setTitle:@"立即使用" forState:UIControlStateNormal];
//        [cell.buttonCan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        cell.buttonCan.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
//        [cell.buttonCan addTarget:self action:@selector(buttonRightNowMake:) forControlEvents:UIControlEventTouchUpInside];
//        
//        cell.labelSend.text = @"送";
//        cell.labelSend.textColor = [UIColor whiteColor];
//        cell.labelSend.textAlignment = NSTextAlignmentCenter;
//        cell.labelSend.font = [UIFont fontWithName:@"CenturyGothic" size:12];
//        cell.labelSend.backgroundColor = [UIColor daohanglan];
//        cell.labelSend.layer.cornerRadius = 5;
//        cell.labelSend.layer.masksToBounds = YES;
//        
//        NSMutableAttributedString *redStr = [[NSMutableAttributedString alloc] initWithString:@"10,000元"];
//        NSRange leftStr = NSMakeRange(0, [[redStr string] rangeOfString:@"元"].location);
//        [redStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:20] range:leftStr];
//        [redStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:22] range:leftStr];
//        [redStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:[@"10,000元" rangeOfString:@"元"]];
//        [cell.labelMoney setAttributedText:redStr];
//        cell.labelMoney.textColor = [UIColor daohanglan];
//        cell.labelMoney.backgroundColor = [UIColor clearColor];
//        
//        cell.labelStyle.text = [styleArr objectAtIndex:indexPath.row];
//        cell.labelStyle.backgroundColor = [UIColor clearColor];
//        cell.labelStyle.font = [UIFont fontWithName:@"CenturyGothic" size:12];
//        
//        cell.labelRequire.text = @"单笔投资金额满2,000";
//        cell.labelRequire.font = [UIFont fontWithName:@"CenturyGothic" size:14];
//        cell.labelRequire.textColor = [UIColor zitihui];
//        cell.labelRequire.backgroundColor = [UIColor clearColor];
//                
//        cell.labelTime.text = [NSString stringWithFormat:@"%@%@", @"有效期:截止", @"2015.12.31"];
//        cell.labelTime.font = [UIFont fontWithName:@"CenturyGothic" size:11];
//        cell.labelTime.textColor = [UIColor zitihui];
//        cell.labelTime.backgroundColor = [UIColor clearColor];
//        
//        cell.backgroundColor = [UIColor huibai];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//        
//    } else if (indexPath.row == 1) {
//        
//        TheThirdRedBagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Reuse"];
//        
//        cell.imagePic.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [imageBagArr objectAtIndex:indexPath.row]]];
//        
//        [cell.buttonOpen setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
//        [cell.buttonOpen setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
//        [cell.buttonOpen setTitle:@"拆红包" forState:UIControlStateNormal];
//        [cell.buttonOpen setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        cell.buttonOpen.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
//        [cell.buttonOpen addTarget:self action:@selector(openRedBagButton:) forControlEvents:UIControlEventTouchUpInside];
//        
//        cell.labelAend.text = @"送";
//        cell.labelAend.textColor = [UIColor whiteColor];
//        cell.labelAend.textAlignment = NSTextAlignmentCenter;
//        cell.labelAend.font = [UIFont fontWithName:@"CenturyGothic" size:12];
//        cell.labelAend.backgroundColor = [UIColor daohanglan];
//        cell.labelAend.layer.cornerRadius = 5;
//        cell.labelAend.layer.masksToBounds = YES;
//        
//        NSMutableAttributedString *redStr = [[NSMutableAttributedString alloc] initWithString:@"10,000元"];
//        NSRange leftStr = NSMakeRange(0, [[redStr string] rangeOfString:@"元"].location);
//        [redStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:20] range:leftStr];
//        [redStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:22] range:leftStr];
//        [redStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:[@"10,000元" rangeOfString:@"元"]];
//        [cell.labelMoney setAttributedText:redStr];
//        cell.labelMoney.textColor = [UIColor daohanglan];
//        cell.labelMoney.backgroundColor = [UIColor clearColor];
//        
//        cell.labelStyle.text = [styleArr objectAtIndex:indexPath.row];
//        cell.labelStyle.backgroundColor = [UIColor clearColor];
//        cell.labelStyle.font = [UIFont fontWithName:@"CenturyGothic" size:12];
//        
//        cell.labelRequier.text = @"单笔投资金额满2,000";
//        cell.labelRequier.font = [UIFont fontWithName:@"CenturyGothic" size:14];
//        cell.labelRequier.textColor = [UIColor zitihui];
//        cell.labelRequier.backgroundColor = [UIColor clearColor];
//        
//        cell.labelDay.text = @"理财期限大于360天";
//        cell.labelDay.textColor = [UIColor zitihui];
//        cell.labelDay.font = [UIFont fontWithName:@"CenturyGothic" size:12];
//        cell.labelDay.backgroundColor = [UIColor clearColor];
//        
//        cell.labelTime.text = [NSString stringWithFormat:@"%@%@", @"有效期:截止", @"2015.12.31"];
//        cell.labelTime.font = [UIFont fontWithName:@"CenturyGothic" size:11];
//        cell.labelTime.textColor = [UIColor zitihui];
//        cell.labelTime.backgroundColor = [UIColor clearColor];
//        
//        cell.backgroundColor = [UIColor huibai];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//        
//    } else {
//        
//        NotSeparateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Reuse1"];
//        
//        cell.labelSend.text = @"送";
//        cell.labelSend.textColor = [UIColor whiteColor];
//        cell.labelSend.textAlignment = NSTextAlignmentCenter;
//        cell.labelSend.font = [UIFont fontWithName:@"CenturyGothic" size:12];
//        cell.labelSend.backgroundColor = [UIColor daohanglan];
//        cell.labelSend.layer.cornerRadius = 5;
//        cell.labelSend.layer.masksToBounds = YES;
//        
//        NSMutableAttributedString *redStr = [[NSMutableAttributedString alloc] initWithString:@"50~70元"];
//        NSRange leftStr = NSMakeRange(0, [[redStr string] rangeOfString:@"元"].location);
//        [redStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:20] range:leftStr];
//        [redStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:22] range:leftStr];
//        [redStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:[@"50~70元" rangeOfString:@"元"]];
//        [cell.labelMoney setAttributedText:redStr];
//        cell.labelMoney.textColor = [UIColor daohanglan];
//        cell.labelMoney.backgroundColor = [UIColor clearColor];
//        
//        cell.labelBagStyle.text = [styleArr objectAtIndex:indexPath.row];
//        cell.labelBagStyle.backgroundColor = [UIColor clearColor];
//        cell.labelBagStyle.font = [UIFont fontWithName:@"CenturyGothic" size:12];
//        
//        cell.laeblRequest.text = @"单笔投资金额满2,000";
//        cell.laeblRequest.font = [UIFont fontWithName:@"CenturyGothic" size:14];
//        cell.laeblRequest.textColor = [UIColor zitihui];
//        cell.laeblRequest.backgroundColor = [UIColor clearColor];
//        
//        cell.labelDays.text = @"理财期限大于360天";
//        cell.labelDays.textColor = [UIColor zitihui];
//        cell.labelDays.font = [UIFont fontWithName:@"CenturyGothic" size:12];
//        cell.labelDays.backgroundColor = [UIColor clearColor];
//        
//        cell.labelTime.text = [NSString stringWithFormat:@"%@%@", @"有效期:截止", @"2015.12.31"];
//        cell.labelTime.font = [UIFont fontWithName:@"CenturyGothic" size:11];
//        cell.labelTime.textColor = [UIColor zitihui];
//        cell.labelTime.backgroundColor = [UIColor clearColor];
//        
//        cell.imagePic.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [imageBagArr objectAtIndex:indexPath.row]]];
//        
//        cell.backgroundColor = [UIColor huibai];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    }
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
//    butBlack = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
//    AppDelegate *app = [[UIApplication sharedApplication] delegate];
//    [app.tabBarVC.view addSubview:butBlack];
//    [butBlack setBackgroundImage:[UIImage imageNamed:@"钻石红包"] forState:UIControlStateNormal];
//    [butBlack addTarget:self action:@selector(openFinish:) forControlEvents:UIControlEventTouchUpInside];
//    
//    labelGet = [[UILabel alloc] initWithFrame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT/3 + 40, butBlack.frame.size.width, 70)];
//    [butBlack addSubview:labelGet];
//    labelGet.textAlignment = NSTextAlignmentCenter;
//    labelGet.backgroundColor = [UIColor clearColor];
//    NSMutableAttributedString *frontStr = [[NSMutableAttributedString alloc] initWithString:@"恭喜您获得100元现金红包\n\n已转入账户余额"];
//    [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:16] range:[@"恭喜您获得100元现金红包\n\n已转入账户余额" rangeOfString:@"恭喜您获得"]];
//    [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:16] range:[@"恭喜您获得100元现金红包\n\n已转入账户余额" rangeOfString:@"元现金红包"]];
//    [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:[@"恭喜您获得100元现金红包\n\n已转入账户余额" rangeOfString:@"已转入账户余额"]];
//    //    取到恭~0的长度 减掉5 就剩100
//    NSRange shuZi = NSMakeRange(5, [[frontStr string] rangeOfString:@"元"].location - 5);
//    [frontStr addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:shuZi];
//    [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:25] range:shuZi];
//    [labelGet setAttributedText:frontStr];
//    labelGet.numberOfLines = 3;
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"NewProduct.plist"]];
    FDetailViewController *detailVC = [[FDetailViewController alloc] init];
    detailVC.estimate = NO;
    detailVC.nHand = @"my";
    detailVC.idString = [dic objectForKey:@"NewProduct"];
    [self.navigationController pushViewController:detailVC animated:YES];
}

//拆开红包
- (void)openRedBagButton:(UIButton *)button
{
    [self openRedPacket:button];
}

#pragma mark 网络请求方法
#pragma mark ------------------------------------------------------------------------------------------------

- (void)getMyRedPacketList{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parameter = @{@"token":[dic objectForKey:@"token"]};
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/user/getMyRedPacketList" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        NSLog(@"getMyRedPacketList = %@",responseObject);
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
            labelMoney.text = [NSString stringWithFormat:@"%@元",[DES3Util decrypt:[responseObject objectForKey:@"redPacketIncome"]]];
            
            for (NSDictionary *dic in [responseObject objectForKey:@"RedPacket"]) {
                RedBagModel *redbagModel = [[RedBagModel alloc] init];
                [redbagModel setValuesForKeysWithDictionary:dic];
                [self.redBagArray addObject:redbagModel];
            }
        }  else if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:400]] || responseObject == nil) {
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
        }
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@", error);
        
    }];
}

- (void)openRedPacket:(id)sender{
    
    UIButton *button = sender;
    
    NSLog(@"tag = %ld",(long)button.tag);
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[FileOfManage PathOfFile:@"Member.plist"]];
    
    NSDictionary *parameter = @{@"token":[dic objectForKey:@"token"],@"redPacketId":[[self.redBagArray objectAtIndex:button.tag] rpID]};
    
    NSLog(@"%@",parameter);
    NSLog(@"%@",[[self.redBagArray objectAtIndex:button.tag] rpType]);
    
    [[MyAfHTTPClient sharedClient] postWithURLString:@"app/redpacket/openRedPacket" parameters:parameter success:^(NSURLSessionDataTask * _Nullable task, NSDictionary * _Nullable responseObject) {
        
        if ([[responseObject objectForKey:@"result"] isEqualToNumber:[NSNumber numberWithInt:200]]) {
        
            NSLog(@"openRedPacket = %@",responseObject);
            
            self.openRedBagDic = [responseObject objectForKey:@"RedPacket"];
            
            butBlack = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
            AppDelegate *app = [[UIApplication sharedApplication] delegate];
            [app.tabBarVC.view addSubview:butBlack];
            [butBlack setBackgroundImage:[UIImage imageNamed:@"钻石红包"] forState:UIControlStateNormal];
            [butBlack addTarget:self action:@selector(openFinish:) forControlEvents:UIControlEventTouchUpInside];
            
            labelGet = [[UILabel alloc] initWithFrame:CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT/3 + 40, butBlack.frame.size.width, 70)];
            [butBlack addSubview:labelGet];
            labelGet.textAlignment = NSTextAlignmentCenter;
            labelGet.backgroundColor = [UIColor clearColor];
            
            NSString *moneyString = [NSString stringWithFormat:@"恭喜您获得%@元现金红包\n\n已转入账户余额",[self.openRedBagDic objectForKey:@"rpAmount"]];
            
            if (WIDTH_CONTROLLER_DEFAULT == 320) {
                
                NSMutableAttributedString *frontStr = [[NSMutableAttributedString alloc] initWithString:moneyString];
                [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:[moneyString rangeOfString:@"恭喜您获得"]];
                [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:13] range:[moneyString rangeOfString:@"元现金红包"]];
                [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:11] range:[moneyString rangeOfString:@"已转入账户余额"]];
                //    取到恭~0的长度 减掉5 就剩100
                NSRange shuZi = NSMakeRange(5, [[frontStr string] rangeOfString:@"元"].location - 5);
                [frontStr addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:shuZi];
                [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:20] range:shuZi];
                
                [labelGet setAttributedText:frontStr];
                
            } else {
            
                NSMutableAttributedString *frontStr = [[NSMutableAttributedString alloc] initWithString:moneyString];
                [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:16] range:[moneyString rangeOfString:@"恭喜您获得"]];
                [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:16] range:[moneyString rangeOfString:@"元现金红包"]];
                [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:[moneyString rangeOfString:@"已转入账户余额"]];
                //    取到恭~0的长度 减掉5 就剩100
                NSRange shuZi = NSMakeRange(5, [[frontStr string] rangeOfString:@"元"].location - 5);
                [frontStr addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:shuZi];
                [frontStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:25] range:shuZi];
                
                [labelGet setAttributedText:frontStr];
                
            }
            labelGet.numberOfLines = 3;
            
            [self.redBagArray removeAllObjects];
            self.redBagArray = nil;
            
            self.redBagArray = [NSMutableArray array];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"exchangeWithImageView" object:nil];
            
            [self getMyRedPacketList];
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
