//
//  MakeSureViewController.m
//  DSLC
//
//  Created by ios on 15/10/13.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MakeSureViewController.h"
#import "UIColor+AddColor.h"
#import "define.h"
#import "ContentCell.h"
#import "MoneyCell.h"
#import "RedBagCell.h"
#import "CashMoneyCell.h"

@interface MakeSureViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) UITableView *tableView;
@end

@implementation MakeSureViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:YES];
    [app.tabBarVC setLabelLineHidden:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"确认投资";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];

    [self showNavigation];
    [self showTableView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:NO];
    [app.tabBarVC setLabelLineHidden:NO];
}

//导航栏修改返回按钮
- (void)showNavigation
{
    UIImageView *imageViewBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIImage *imageBack = [UIImage imageNamed:@"750产品111"];
    imageViewBack.image = imageBack;
    imageViewBack.userInteractionEnabled = YES;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageViewBack];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnBack:)];
    [imageViewBack addGestureRecognizer:tap];
}

//TableView展示
- (void)showTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UIView *viewFoot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 200)];
    viewFoot.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.tableFooterView = viewFoot;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ContentCell" bundle:nil] forCellReuseIdentifier:@"reuse1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MoneyCell" bundle:nil] forCellReuseIdentifier:@"reuse2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"RedBagCell" bundle:nil] forCellReuseIdentifier:@"reuse3"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CashMoneyCell" bundle:nil] forCellReuseIdentifier:@"reuse4"];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 0;
        
    } else {
        
        return 11;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 145;
        
    } else if (indexPath.section == 1) {
        
        return 158;
        
    } else if (indexPath.section == 2) {
        
        return 48;
        
    } else {
        
        return 44;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        
        return 2;
        
    } else {
        
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse1"];
        if (cell == nil) {
            
            cell = [[ContentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse1"];
        }
        
        cell.labelMonth.text = @"3个月固定投资";
        cell.labelMonth.font = [UIFont systemFontOfSize:15];
        cell.viewLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.viewLine.alpha = 0.7;
        
        
        
        NSMutableAttributedString *year = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ : %@", @"年化收益率", @"8.02%"]];
        NSRange black = NSMakeRange(0, [[year string] rangeOfString:@":"].location);
        [year addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:black];
        
        NSMutableAttributedString *moneyStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ : %@", @"剩余总额", @"34.2万元"]];
        NSRange moneyRange = NSMakeRange(0, [[moneyStr string] length]);
        [year addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:moneyRange];
        [cell.labelSheng setAttributedText:moneyStr];
        
        NSMutableAttributedString *moneyS = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ : %@", @"剩余总额", @"34.2万元"]];
        NSRange Range = NSMakeRange(0, [[moneyS string] length]);
        [year addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:Range];
        [cell.labelMoney setAttributedText:moneyS];
        
        return cell;
        
    } else if (indexPath.section == 1) {
        
        MoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse2"];
        if (cell == nil) {
            
            cell = [[MoneyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse2"];
        }
        
        return cell;
        
    } else if (indexPath.section == 2) {
        
        RedBagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse3"];
        if (cell == nil) {
            
            cell = [[RedBagCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse3"];
        }
        
        return cell;
        
    } else {
        
        CashMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse4"];
        
        if (cell == nil) {
            
            cell = [[CashMoneyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse4"];
        }
        
        return cell;
    }
}

//返回按钮
- (void)returnBack:(UIBarButtonItem *)bar
{
    [self.navigationController popViewControllerAnimated:YES];
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
