//
//  SocialPlatformViewController.m
//  DSLC
//
//  Created by ios on 15/11/13.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "SocialPlatformViewController.h"
#import "InviteSocilPlatFormCell.h"

@interface SocialPlatformViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSArray *picArr;
    NSArray *nameArr;
}

@end

@implementation SocialPlatformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"邀请"];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT ,HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor huibai];
    _tableView.separatorColor = [UIColor groupTableViewBackgroundColor];
    [_tableView registerNib:[UINib nibWithNibName:@"InviteSocilPlatFormCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    picArr = @[@[@"微信"], @[@"朋友圈"], @[@"新浪微博"], @[@"人人网"], @[@"QQ空间"], @[@"PhoneNum"]];
    nameArr = @[@[@"微信好友"], @[@"微信朋友圈"], @[@"新浪微博"], @[@"人人网"], @[@"QQ空间"], @[@"手机通讯录"]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InviteSocilPlatFormCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    NSArray *pictureArr = [picArr objectAtIndex:indexPath.section];
    cell.imagePIc.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [pictureArr objectAtIndex:indexPath.row]]];
    cell.labelNAME.text = [[nameArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.labelNAME.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
