//
//  TWOFindActivityCenterViewController.m
//  DSLC
//
//  Created by ios on 16/5/25.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOFindActivityCenterViewController.h"
#import "TWOFindActivityCenterCell.h"

@interface TWOFindActivityCenterViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UIScrollView *_scrollview;
    UITableView *_tableView1;
    UITableView *_tableView2;
    UITableView *_tableView3;
}

@end

@implementation TWOFindActivityCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"活动中心"];
    
    [self contentShow];
    [self tableViewShow];
}

- (void)contentShow
{
    UIView *viewWhite = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 55) backgroundColor:[UIColor whiteColor]];
    [self.view addSubview:viewWhite];
    
    NSArray *nameArray = @[@"进行中", @"期待中", @"已结束"];
    UISegmentedControl *segmented = [[UISegmentedControl alloc] initWithItems:nameArray];
    segmented.frame = CGRectMake(9, 9, WIDTH_CONTROLLER_DEFAULT - 18, viewWhite.frame.size.height - 18);
    [viewWhite addSubview:segmented];
    segmented.selectedSegmentIndex = 0;
    segmented.tintColor = [UIColor profitColor];
    [segmented addTarget:self action:@selector(segmentedSelect:) forControlEvents:UIControlEventValueChanged];
    
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 55, WIDTH_CONTROLLER_DEFAULT * 3, HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 55)];
    [self.view addSubview:_scrollview];
    _scrollview.contentSize = CGSizeMake(WIDTH_CONTROLLER_DEFAULT * 3, 0);
}

- (void)segmentedSelect:(UISegmentedControl *)seg
{
    if (seg.selectedSegmentIndex == 0) {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _scrollview.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            
        }];
        
    } else if (seg.selectedSegmentIndex == 1) {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _scrollview.contentOffset = CGPointMake(WIDTH_CONTROLLER_DEFAULT, 0);
        } completion:^(BOOL finished) {
            
        }];

    } else {
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            _scrollview.contentOffset = CGPointMake(WIDTH_CONTROLLER_DEFAULT * 2, 0);
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)tableViewShow
{
    _tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, _scrollview.frame.size.height) style:UITableViewStylePlain];
    [_scrollview addSubview:_tableView1];
    _tableView1.dataSource = self;
    _tableView1.delegate = self;
    _tableView1.separatorColor = [UIColor clearColor];
    [_tableView1 registerNib:[UINib nibWithNibName:@"TWOFindActivityCenterCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT, 0, WIDTH_CONTROLLER_DEFAULT, _scrollview.frame.size.height) style:UITableViewStylePlain];
    [_scrollview addSubview:_tableView2];
    _tableView2.dataSource = self;
    _tableView2.delegate = self;
    _tableView2.separatorColor = [UIColor clearColor];
    [_tableView2 registerNib:[UINib nibWithNibName:@"TWOFindActivityCenterCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    _tableView3 = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT * 2, 0, WIDTH_CONTROLLER_DEFAULT, _scrollview.frame.size.height) style:UITableViewStylePlain];
    [_scrollview addSubview:_tableView3];
    _tableView3.dataSource = self;
    _tableView3.delegate = self;
    _tableView3.separatorColor = [UIColor clearColor];
    [_tableView3 registerNib:[UINib nibWithNibName:@"TWOFindActivityCenterCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOFindActivityCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    cell.imageActivity.layer.cornerRadius = 4;
    cell.imageActivity.layer.masksToBounds = YES;
    
    if (tableView == _tableView1) {
        
        cell.imageActivity.image = [UIImage imageNamed:@"gameBanner"];
        cell.imageOver.hidden = YES;
        cell.imageWaiting.hidden = YES;
        cell.labelAlpha.hidden = YES;
        
    } else if (tableView == _tableView2) {
        
        cell.imageWaiting.hidden = NO;
        cell.imageOver.hidden = YES;
        cell.labelAlpha.hidden = YES;
        cell.imageActivity.image = [UIImage imageNamed:@"gameBanner"];
        cell.imageWaiting.image = [UIImage imageNamed:@"期待中"];
        
    } else {
        
        cell.imageWaiting.hidden = YES;
        cell.imageOver.hidden = NO;
        cell.labelAlpha.hidden = NO;
        cell.imageActivity.image = [UIImage imageNamed:@"gameBanner"];
        cell.labelAlpha.backgroundColor = [UIColor blackColor];
        cell.labelAlpha.alpha = 0.4;
        cell.imageOver.image = [UIImage imageNamed:@"over"];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
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
