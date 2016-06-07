//
//  TWOHelpCenterViewController.m
//  DSLC
//
//  Created by ios on 16/5/18.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOHelpCenterViewController.h"
#import "TWOHelpCenterCell.h"
#import "NewHandViewController.h"
#import "UsualQuestionViewController.h"

@interface TWOHelpCenterViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tabelView;
}

@end

@implementation TWOHelpCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"帮助中心"];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tabelView];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    _tabelView.backgroundColor = [UIColor qianhuise];
    _tabelView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10)];
    _tabelView.tableFooterView.backgroundColor = [UIColor qianhuise];
    [_tabelView registerNib:[UINib nibWithNibName:@"TWOHelpCenterCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [_tabelView.tableFooterView addSubview:viewLine];
    viewLine.alpha = 0.3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWOHelpCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    NSArray *imageArray = @[@"newhand", @"question"];
    cell.imagePic.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
    NSArray *titleArray = @[@"新手指南", @"常见问题"];
    cell.labelTitle.text = [titleArray objectAtIndex:indexPath.row];
    cell.imageRight.image = [UIImage imageNamed:@"righticon"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NewHandViewController *newHandVC = [[NewHandViewController alloc] init];
        pushVC(newHandVC);
        
    } else {
        UsualQuestionViewController *usualQuestion = [[UsualQuestionViewController alloc] init];
        pushVC(usualQuestion);
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
