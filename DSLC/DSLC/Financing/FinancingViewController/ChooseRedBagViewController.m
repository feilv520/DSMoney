//
//  ChooseRedBagViewController.m
//  DSLC
//
//  Created by ios on 15/11/4.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "ChooseRedBagViewController.h"
#import "ChooseRedBagCell.h"

@interface ChooseRedBagViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSArray *pictureArr;
    NSArray *redBagArray;
}

@end

@implementation ChooseRedBagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationItem setTitle:@"选择红包"];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableHeaderView = [UIView new];
    _tableView.separatorColor = [UIColor clearColor];
    [_tableView registerNib:[UINib nibWithNibName:@"ChooseRedBagCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    pictureArr = @[@"组-21-拷贝-2", @"组-21-拷贝-13", @"组-21-拷贝-14"];
    redBagArray = @[@"金元宝红包5~10元", @"银元宝红包7~12个", @"铜元宝红包1~2个"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChooseRedBagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.imageViewPic.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [pictureArr objectAtIndex:indexPath.row]]];
    
    cell.labelBagStyle.text = [redBagArray objectAtIndex:indexPath.row];
    cell.labelBagStyle.backgroundColor = [UIColor clearColor];
    cell.labelBagStyle.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.labelData.text = @"有效期:截止2015.12.31";
    cell.labelData.textColor = [UIColor zitihui];
    cell.labelData.backgroundColor = [UIColor clearColor];
    cell.labelData.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    
    cell.labelBottom.text = @"最低投资金额:2,000元  理财期限:9个月以上";
    cell.labelBottom.textColor = [UIColor zitihui];
    cell.labelBottom.backgroundColor = [UIColor clearColor];
    cell.labelBottom.font = [UIFont fontWithName:@"CenturyGothic" size:11];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
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
