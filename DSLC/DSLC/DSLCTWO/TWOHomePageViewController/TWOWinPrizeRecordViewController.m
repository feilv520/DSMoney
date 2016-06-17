//
//  TWOWinPrizeRecordViewController.m
//  DSLC
//
//  Created by ios on 16/5/23.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOWinPrizeRecordViewController.h"
#import "TWOWinPrizeRecordCell.h"
#import "TWORedBagViewController.h"

@interface TWOWinPrizeRecordViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

{
    UITableView *_tableView;
}

@end

@implementation TWOWinPrizeRecordViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor profitColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"中奖纪录"];
    
    [self tabelViewShow];
}

- (void)tabelViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor qianhuise];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 116.0)];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10)];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOWinPrizeRecordCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [_tableView.tableFooterView addSubview:viewLine];
    viewLine.alpha = 0.4;
    
    [self tabelViewHeadShow];
}

- (void)tabelViewHeadShow
{
    UIImageView *imageHead = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, _tableView.tableHeaderView.frame.size.height) backGroundColor:[UIColor qianhuise] setImage:[UIImage imageNamed:@"productDetailBackground"]];
    [_tableView.tableHeaderView addSubview:imageHead];
    
    UILabel *labelCiShu = [CreatView creatWithLabelFrame:CGRectMake(0, 15, WIDTH_CONTROLLER_DEFAULT, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:nil];
    [imageHead addSubview:labelCiShu];
    NSMutableAttributedString *ciShuString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@次", @"20"]];
    NSRange ciShuRange = NSMakeRange(0, [[ciShuString string] rangeOfString:@"次"].location);
    [ciShuString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:39] range:ciShuRange];
    [labelCiShu setAttributedText:ciShuString];
    
    UILabel *labelAlert = [CreatView creatWithLabelFrame:CGRectMake(0, 15 + 40 + 14, WIDTH_CONTROLLER_DEFAULT, 15) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"每日一摇中奖"];
    [imageHead addSubview:labelAlert];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOWinPrizeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.imagePic.image = [UIImage imageNamed:@"winRecord"];
    cell.imageRight.image = [UIImage imageNamed:@"clickRightjiantou"];
    cell.labelTime.text = @"2016-05-21";
    
    NSMutableAttributedString *percentString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"摇一摇获得%@加息券", @"2%"]];
    NSRange leftRange = NSMakeRange(0, 5);
    [percentString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:15] range:leftRange];
    [percentString addAttribute:NSForegroundColorAttributeName value:[UIColor blackZiTi] range:leftRange];
    NSRange rightRange = NSMakeRange([[percentString string] length] - 3, 3);
    [percentString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:15] range:rightRange];
    [percentString addAttribute:NSForegroundColorAttributeName value:[UIColor blackZiTi] range:rightRange];
    [cell.labelPrize setAttributedText:percentString];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TWORedBagViewController *redBageVC = [[TWORedBagViewController alloc] init];
    pushVC(redBageVC);
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
