//
//  TWODSPublicBenefitViewController.m
//  DSLC
//
//  Created by ios on 16/5/25.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWODSPublicBenefitViewController.h"
#import "TWODSPublicBenefitCell.h"
#import "TWOPublicDetailViewController.h"

@interface TWODSPublicBenefitViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
}

@end

@implementation TWODSPublicBenefitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"大圣公益行"];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor qianhuise];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10)];
    _tableView.tableFooterView.backgroundColor = [UIColor qianhuise];
    [_tableView registerNib:[UINib nibWithNibName:@"TWODSPublicBenefitCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [_tableView.tableFooterView addSubview:viewLine];
    viewLine.alpha = 0.3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWODSPublicBenefitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.imagePic.image = [UIImage imageNamed:@"dagyx"];
    cell.imagePic.layer.cornerRadius = 3;
    cell.imagePic.layer.masksToBounds = YES;
    
    cell.labelName.text = @"大圣理财捐助贫困灾区儿童";
    cell.labelName.backgroundColor = [UIColor qianhuise];
    cell.labelTime.text = @"2016-09-09 08:20";
    cell.labelTime.backgroundColor = [UIColor qianhuise];
    
    [cell.buttonSee setTitle:@" 236" forState:UIControlStateNormal];
    [cell.buttonSee setImage:[UIImage imageNamed:@"see"] forState:UIControlStateNormal];
    cell.buttonSee.backgroundColor = [UIColor qianhuise];
    [cell.buttonSee setTitleColor:[UIColor findZiTiColor] forState:UIControlStateNormal];
    
    cell.backgroundColor = [UIColor qianhuise];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TWOPublicDetailViewController *publicDetail = [[TWOPublicDetailViewController alloc] init];
    pushVC(publicDetail);
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
