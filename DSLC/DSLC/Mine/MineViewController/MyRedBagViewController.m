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

@interface MyRedBagViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    UIView *viewHead;
    UIButton *butMyRedBag;
    UIButton * butRecord;
    UILabel *labelLine;
    NSArray *twoArr;
    UIImageView *imageRight;
    WinAPrizeViewController *winPrizeVC;
    MyRedBagViewController *redVC;
    BOOL consult;
}

@end

@implementation MyRedBagViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:YES];
    [app.tabBarVC setLabelLineHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self naviagationShow];
    [self tableViewShow];
    
    consult = YES;
}

//导航内容
- (void)naviagationShow
{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor daohanglan];
    
    self.navigationItem.title = @"红包活动";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIImageView *imageReturn = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, 20, 20) backGroundColor:nil setImage:[UIImage imageNamed:@"750产品111"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageReturn];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonReturn:)];
    [imageReturn addGestureRecognizer:tap];
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
    
    viewHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT * (44.0 / 667.0))];
    _tableView.tableHeaderView = viewHead;
    viewHead.backgroundColor = [UIColor whiteColor];
    [self viewHeadShow];
    
    [_tableView registerNib:[UINib nibWithNibName:@"GrabBagCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [_tableView registerNib:[UINib nibWithNibName:@"MyRedBagCell" bundle:nil] forCellReuseIdentifier:@"reuse1"];
    
    twoArr = @[@"红包为我带来的收益", @"抢红包"];
    
    imageRight = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 26, HEIGHT_CONTROLLER_DEFAULT * (17.0 / 667.0), 16, 16) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"arrow"]];
    
}

//tableView头部
- (void)viewHeadShow
{
    butMyRedBag = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT/2, HEIGHT_CONTROLLER_DEFAULT * (44.0 / 667.0)) backgroundColor:[UIColor whiteColor] textColor:[UIColor daohanglan] titleText:@"我的红包"];
    butMyRedBag.titleLabel.font = [UIFont systemFontOfSize:15];
    [viewHead addSubview:butMyRedBag];
    [butMyRedBag addTarget:self action:@selector(butMyRedBag:) forControlEvents:UIControlEventTouchUpInside];
    
    butRecord = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT / 2, 0, WIDTH_CONTROLLER_DEFAULT / 2, HEIGHT_CONTROLLER_DEFAULT * (44.0 / 667.0)) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] titleText:@"中奖纪录"];
    butRecord.titleLabel.font = [UIFont systemFontOfSize:15];
    [viewHead addSubview:butRecord];
    [butRecord addTarget:self action:@selector(butRecord:) forControlEvents:UIControlEventTouchUpInside];
    
    labelLine = [CreatView creatWithLabelFrame:CGRectMake(30, HEIGHT_CONTROLLER_DEFAULT * (42.0 / 667.0), butMyRedBag.frame.size.width - 60, 2) backgroundColor:[UIColor daohanglan] textColor:nil textAlignment:NSTextAlignmentCenter textFont:nil text:nil];
    [viewHead addSubview:labelLine];
}

//我的红包按钮
- (void)butMyRedBag:(UIButton *)button
{
    if (consult == YES) {
        
        [winPrizeVC removeFromParentViewController];
        
        redVC = [[MyRedBagViewController alloc] init];
        [self addChildViewController:redVC];
        [self.view addSubview:redVC.view];
        
        [butMyRedBag setTitleColor:[UIColor daohanglan] forState:UIControlStateNormal];
        [butRecord setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            
            labelLine.frame = CGRectMake(30, HEIGHT_CONTROLLER_DEFAULT * (42.0 / 667.0), butMyRedBag.frame.size.width - 60, 2);
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
    consult = NO;
}

//中奖纪录
- (void)butRecord:(UIButton *)button
{
    consult = NO;
    
    if (consult == YES) {
        
    } else {
        
        [redVC removeFromParentViewController];
        
        [butRecord setTitleColor:[UIColor daohanglan] forState:UIControlStateNormal];
        [butMyRedBag setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        labelLine.frame = CGRectMake(butMyRedBag.frame.size.width + 30, HEIGHT_CONTROLLER_DEFAULT * (42.0 / 667.0), butRecord.frame.size.width - 60, 2);
        
    } completion:^(BOOL finished) {
        
    }];
    
        winPrizeVC = [[WinAPrizeViewController alloc] init];
        [self addChildViewController:winPrizeVC];
        [self.view addSubview:winPrizeVC.view];
        winPrizeVC.view.frame = CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT * (44.0 / 667.0), WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT);
    }
    
    consult = YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEIGHT_CONTROLLER_DEFAULT * (11.0 / 667.0);
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
        
        return 2;
        
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
        
        cell.labelGrab.text = [twoArr objectAtIndex:indexPath.row];
        cell.labelGrab.font = [UIFont systemFontOfSize:15];
        
        cell.labelQianShu.text = @"999元";
        cell.labelQianShu.textColor = [UIColor daohanglan];
        cell.labelQianShu.textAlignment = NSTextAlignmentRight;
        cell.labelQianShu.font = [UIFont fontWithName:@"CenturyGothic" size:15];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 1) {
            
            cell.labelQianShu.hidden = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            [cell addSubview:imageRight];
        }
        
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

//导航返回按钮
- (void)buttonReturn:(UIBarButtonItem *)bar
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:NO];
    [app.tabBarVC setLabelLineHidden:NO];
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
