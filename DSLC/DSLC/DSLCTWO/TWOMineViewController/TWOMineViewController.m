//
//  TWOMineViewController.m
//  DSLC
//
//  Created by ios on 16/5/5.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOMineViewController.h"
#import "define.h"
#import "TWOMineCell.h"

@interface TWOMineViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

{
    UITableView *_tableView;
    NSArray *titleArray;
    NSArray *imageArray;
    NSArray *contentArr;
    UIImageView *imageBackGround;
    CGFloat height;
}

@end

@implementation TWOMineViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self tabelViewShow];
}

- (void)tabelViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 53) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 330.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20))];
    _tableView.tableHeaderView.backgroundColor = [UIColor whiteColor];
    [self tableViewHeadShow];
                                                                          
    [_tableView registerNib:[UINib nibWithNibName:@"TWOMineCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    titleArray = @[@[@"我的理财", @"我的特权本金"], @[@"红包卡券", @"我的猴币", @"我的邀请"]];
    imageArray = @[@[@"我的理财", @"tequanbenjin"], @[@"红包卡券", @"我的猴币", @"myInvite"]];
    contentArr = @[@[@"13600元在投", @"300000元"], @[@"2张", @"3000.00猴币", @"邀请好友送星巴克券"]];
}

//tableView头部
- (void)tableViewHeadShow
{
    imageBackGround = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, _tableView.tableHeaderView.frame.size.height) backGroundColor:[UIColor greenColor] setImage:[UIImage imageNamed:@"我的背景图"]];
    [_tableView.tableHeaderView addSubview:imageBackGround];
    imageBackGround.userInteractionEnabled = YES;
    height = imageBackGround.frame.size.height;
//    让子类自动布局
    imageBackGround.autoresizesSubviews = YES;
    
//    信封按钮
    UIButton *buttEmail = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(14, 30, 23, 23) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [imageBackGround addSubview:buttEmail];
    [buttEmail setBackgroundImage:[UIImage imageNamed:@"email"] forState:UIControlStateNormal];
    [buttEmail setBackgroundImage:[UIImage imageNamed:@"email"] forState:UIControlStateHighlighted];
    buttEmail.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [buttEmail addTarget:self action:@selector(buttonEmailClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    设置按钮
    UIButton *buttonSet = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 23 - 14, 30, 23, 23) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [_tableView.tableHeaderView addSubview:buttonSet];
    [buttonSet setBackgroundImage:[UIImage imageNamed:@"myset"] forState:UIControlStateNormal];
    [buttonSet setBackgroundImage:[UIImage imageNamed:@"myset"] forState:UIControlStateHighlighted];
    buttonSet.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [buttonSet addTarget:self action:@selector(buttonSetClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    充值提现上面的横线
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    } else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOMineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.imagePic.image = [UIImage imageNamed:[[imageArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    cell.imageRight.image = [UIImage imageNamed:@"clickRightjiantou"];
    
    cell.labelName.text = [[titleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.labelName.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    cell.labelName.textColor = [UIColor ZiTiColor];
    
    cell.labelContent.text = [[contentArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.labelContent.textColor = [UIColor zitihui];
    cell.labelContent.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    
//    if (indexPath.section == 0) {
//        if (indexPath.row == 1) {
//            cell.imageRedDian.image = [UIImage imageNamed:@"Reddian"];
//        }
//    } else {
//        if (indexPath.row == 1) {
//            cell.imageRedDian.image = [UIImage imageNamed:@"Reddian"];
//        }
//    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 53.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 9.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20);
}

//信封按钮
- (void)buttonEmailClicked:(UIButton *)button
{
    NSLog(@"xin");
}

//设置按钮
- (void)buttonSetClicked:(UIButton *)button
{
    NSLog(@"set");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offSet = scrollView.contentOffset.y;
    
    if (offSet < 0) {
        
        imageBackGround.contentMode = UIViewContentModeScaleAspectFill;
        CGRect frame = imageBackGround.frame;
        frame.origin.y = offSet;
        frame.size.height = height - offSet;
        imageBackGround.frame = frame;
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
