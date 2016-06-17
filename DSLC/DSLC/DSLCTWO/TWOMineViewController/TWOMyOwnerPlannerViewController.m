//
//  TWOMyOwnerPlannerViewController.m
//  DSLC
//
//  Created by ios on 16/5/30.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOMyOwnerPlannerViewController.h"
#import "MyPlannerCell.h"
#import "TWOMyOwnerPlannerCell.h"

@interface TWOMyOwnerPlannerViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

{
    UITableView *_tableView;
}

@end

@implementation TWOMyOwnerPlannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"我的理财师"];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor qianhuise];
    _tableView.tableHeaderView = [UIView new];
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 280.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    } else {
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 266.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];    }
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 1)];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOMyOwnerPlannerCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [_tableView.tableFooterView addSubview:viewLine];
    viewLine.alpha = 0.3;
    
    [self tableViewHeadShow];
}

- (void)tableViewHeadShow
{
    UIImageView *imageBackground = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, _tableView.tableHeaderView.frame.size.height) backGroundColor:[UIColor whiteColor] setImage:[UIImage imageNamed:@"productDetailBackground"]];
    [_tableView.tableHeaderView addSubview:imageBackground];
    
    UIImageView *imageHead = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 48.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 15.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 96.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, 96.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"我的头像"]];
    [imageBackground addSubview:imageHead];
    imageHead.layer.cornerRadius = imageHead.frame.size.height/2;
    imageHead.layer.masksToBounds = YES;
    
    CGFloat imageJianJu = 15.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20);
    CGFloat imageNameJainJu = 7.0;
    CGFloat buttonNameJianJu = 20.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20);
    
    UILabel *labelName = [CreatView creatWithLabelFrame:CGRectMake(0, imageJianJu + imageHead.frame.size.height + imageNameJainJu, WIDTH_CONTROLLER_DEFAULT, 15) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"小明"];
    [imageBackground addSubview:labelName];
    
    CGFloat butWidth = (WIDTH_CONTROLLER_DEFAULT - 55.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT * 2 - 65.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT)/2;
    
    UIButton *buttonAsk = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(55.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, imageJianJu + imageHead.frame.size.height + imageNameJainJu + labelName.frame.size.height + buttonNameJianJu, butWidth, 35) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"咨询"];
    [imageBackground addSubview:buttonAsk];
    buttonAsk.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonAsk.layer.cornerRadius = 6;
    buttonAsk.layer.masksToBounds = YES;
    buttonAsk.layer.borderColor = [[UIColor whiteColor] CGColor];
    buttonAsk.layer.borderWidth = 1;
    
    UIButton *buttonAlready = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(55.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + buttonAsk.frame.size.width + 65.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, imageJianJu + imageHead.frame.size.height + imageNameJainJu + labelName.frame.size.height + buttonNameJianJu, butWidth, 35) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"已申请服务"];
    [imageBackground addSubview:buttonAlready];
    buttonAlready.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonAlready.layer.cornerRadius = 6;
    buttonAlready.layer.masksToBounds = YES;
    buttonAlready.layer.borderColor = [[UIColor whiteColor] CGColor];
    buttonAlready.layer.borderWidth = 1;
    
    CGFloat alertButtonJianJu = 20.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20);
    UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(0, imageJianJu + imageHead.frame.size.height + imageNameJainJu + labelName.frame.size.height + buttonNameJianJu + 35 + alertButtonJianJu, WIDTH_CONTROLLER_DEFAULT, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:@"“26年专职理财顾问,私人银行级的资产配置,为客户提\n供中立客观的真诚服务。”"];
    [imageBackground addSubview:labelAlert];
    labelAlert.numberOfLines = 2;
    
    if (HEIGHT_CONTROLLER_DEFAULT - 20 == 480) {
        
        buttonAsk.frame = CGRectMake(55.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, imageJianJu + imageHead.frame.size.height + imageNameJainJu + labelName.frame.size.height + 10.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), butWidth, 30);
        
        buttonAlready.frame = CGRectMake(55.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT + buttonAsk.frame.size.width + 65.0 / 375.0 * WIDTH_CONTROLLER_DEFAULT, imageJianJu + imageHead.frame.size.height + imageNameJainJu + labelName.frame.size.height + 10.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), butWidth, 30);
        
        labelAlert.frame = CGRectMake(0, 0 + imageHead.frame.size.height + imageNameJainJu + labelName.frame.size.height + 10.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 30 + alertButtonJianJu, WIDTH_CONTROLLER_DEFAULT, 40);
        
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 568) {
        
        labelAlert.frame = CGRectMake(0, imageJianJu + imageHead.frame.size.height + imageNameJainJu + labelName.frame.size.height + buttonNameJianJu + 35 + 10, WIDTH_CONTROLLER_DEFAULT, 40);
        
    } else if (HEIGHT_CONTROLLER_DEFAULT - 20 == 736) {
        
        labelAlert.frame = CGRectMake(0, imageJianJu + imageHead.frame.size.height + imageNameJainJu + labelName.frame.size.height + buttonNameJianJu + 35 + alertButtonJianJu + 5, WIDTH_CONTROLLER_DEFAULT, 40);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOMyOwnerPlannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    NSArray *titleArray = @[@"邀请码", @"已为客户赚取", @"已服务客户数", @"累计投资总额"];
    cell.labelTitle.text = [titleArray objectAtIndex:indexPath.row];
    
    NSArray *contentArray = @[@"A98766", [NSString stringWithFormat:@"%@元", @"1,898,766.00"], [NSString stringWithFormat:@"%@人", @"1989766"], [NSString stringWithFormat:@"%@元", @"1,898,766.00"]];
    cell.labelContent.text = [contentArray objectAtIndex:indexPath.row];
    if (indexPath.row == 0) {
        cell.labelContent.textColor = [UIColor orangecolor];
    }
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 0) {
        _tableView.scrollEnabled = NO;
    } else {
        _tableView.scrollEnabled = YES;
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
