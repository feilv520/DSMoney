//
//  NewHandViewController.m
//  DSLC
//
//  Created by ios on 15/10/26.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "NewHandViewController.h"
#import "NewHandCell.h"

@interface NewHandViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSArray *contentArr;
    CGRect rect;
    BOOL sunShine;
}

@end

@implementation NewHandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationItem setTitle:@"新手指南"];
    
    [self contentShow];
}

- (void)contentShow
{
    sunShine = NO;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    [_tableView registerNib:[UINib nibWithNibName:@"NewHandCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    contentArr = @[@"1、大圣理财是什么?", @"2、大圣理财提供的投资理财项目?", @"3、大圣理财平台上的资金安全保障?", @"4、大圣理财平台的收益保障?"];
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *viewGray = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 145)];
//    viewGray.backgroundColor = [UIColor huibai];
//    
//    UILabel *labelContent = [CreatView creatWithLabelFrame:CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT - 20, 10) backgroundColor:[UIColor huibai] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为10000元由大圣理财提供,期限3天到期后兑付3天收益。\n新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为10000元由大圣理财提供,期限3天到期后兑付3天收益。"];
//    [viewGray addSubview:labelContent];
//    
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"CenturyGothic" size:14], NSFontAttributeName, nil];
//    rect = [labelContent.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 20, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
//    labelContent.numberOfLines = 0;
//    
//    labelContent.frame = CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT - 20, rect.size.height);
//    
//    return viewGray;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewHandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell == nil) {
        
        cell = [[NewHandCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
    }
    
    cell.labelQuestion.text = [contentArr objectAtIndex:indexPath.row];
    cell.labelQuestion.font = [UIFont systemFontOfSize:15];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
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
