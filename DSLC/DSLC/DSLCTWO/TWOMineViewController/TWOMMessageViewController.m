//
//  TWOMMessageViewController.m
//  DSLC
//
//  Created by 马成铭 on 16/5/16.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOMMessageViewController.h"
#import "define.h"
#import "UIColor+AddColor.h"
#import "CreatView.h"
#import "AppDelegate.h"
#import "TWOMessageTableViewCell.h"
#import "TWOMessageDetailViewController.h"

@interface TWOMMessageViewController () <UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *mainTableView;
    BOOL flag;
}

@end

@implementation TWOMMessageViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:YES];
    
    flag = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor huibai];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:mainTableView];
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    mainTableView.backgroundColor = [UIColor huibai];
    
    mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10)];
    mainTableView.tableFooterView.backgroundColor = [UIColor huibai];
    
//    [mainTableView setSeparatorColor:[UIColor colorWithRed:246 / 255.0 green:247 / 255.0 blue:249 / 255.0 alpha:1.0]];
    [mainTableView setSeparatorColor:[UIColor huibai]];
    [mainTableView registerNib:[UINib nibWithNibName:@"TWOMessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"message"];
    
    [self addTableViewWithHeader:mainTableView];
    [self addTableViewWithFooter:mainTableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TWOMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"message"];
    
    cell.titleLabel.text = @"喜大普奔,大圣理财APP2.0版本上线啦!";
    
    cell.subTitleLabel.text = @"经过小伙伴们两个月的努力,大圣理财2.0版本终于上线啦!大圣理财,专注银行信贷资产";
    
    cell.backgroundV.layer.masksToBounds = YES;
    cell.backgroundV.layer.cornerRadius = 5.0f;
    
    if (!flag) {
        
        cell.pointImage.hidden = YES;
        [cell.titleLabel setTextColor:[UIColor colorFromHexCode:@"8c909d"]];
    } else {
        
        cell.pointImage.hidden = NO;
        [cell.titleLabel setTextColor:[UIColor colorFromHexCode:@"434a54"]];
    }
    
    flag = !flag;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TWOMessageDetailViewController *messageDVC = [[TWOMessageDetailViewController alloc] init];
    pushVC(messageDVC);
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
