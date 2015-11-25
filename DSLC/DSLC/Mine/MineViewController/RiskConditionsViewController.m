//
//  RiskConditionsViewController.m
//  DSLC
//
//  Created by 马成铭 on 15/11/2.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "RiskConditionsViewController.h"
#import "ProjectContentCell.h"

@interface RiskConditionsViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSArray *contentArr;
    CGRect rect;
}

@end

@implementation RiskConditionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"风控条件";
    
    [self contentShow];
}

- (void)contentShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = [UIColor clearColor];
    
    contentArr = @[
                   @"● 电影电视，是文化的载体和产物、是面向大众的精神产品，具有文化传承的功能。然而，在陈道明看来，当前的泛娱乐化正稀释影视节目的文化价值。",
                   @"● 更有甚者，开拍前不问剧本内容、不要情怀内涵，而是想方设法找话题、炒绯闻。”陈道明回忆，一位电视台收片负责人说“演员不会演戏没事儿、剧本再烂无妨，只要有绯闻，肯定有收视。更有甚者，开拍前不问剧本内容、不要情怀内涵，而是想方设法找话题、炒绯闻。”陈道明回忆，一位电视台收片负责人说“演员不会演戏没事儿、剧本再烂无妨，只要有绯闻，肯定有收视。更有甚者，开拍前不问剧本内容、不要情怀内涵，而是想方设法找话题、炒绯闻。”陈道明回忆，一位电视台收片负责人说“演员不会演戏没事儿、剧本再烂无妨，只要有绯闻，肯定有收视。更有甚者，开拍前不问剧本内容、不要情怀内涵，而是想方设法找话题、炒绯闻。”陈道明回忆，一位电视台收片负责人说“演员不会演戏没事儿、剧本再烂无妨，只要有绯闻，肯定有收视。更有甚者，开拍前不问剧本内容、不要情怀内涵，而是想方设法找话题、炒绯闻。”陈道明回忆，一位电视台收片负责人说“演员不会演戏没事儿、剧本再烂无妨，只要有绯闻，肯定有收视。更有甚者，开拍前不问剧本内容、不要情怀内涵，而是想方设法找话题、炒绯闻。”陈道明回忆，一位电视台收片负责人说“演员不会演戏没事儿、剧本再烂无妨，只要有绯闻，肯定有收视。更有甚者，开拍前不问剧本内容、不要情怀内涵，而是想方设法找话题、炒绯闻。”陈道明回忆，一位电视台收片负责人说“演员不会演戏没事儿、剧本再烂无妨，只要有绯闻，肯定有收视。更有甚者，开拍前不问剧本内容、不要情怀内涵，而是想方设法找话题、炒绯闻。”陈道明回忆，一位电视台收片负责人说“演员不会演戏没事儿、剧本再烂无妨，只要有绯闻，肯定有收视。更有甚者，开拍前不问剧本内容、不要情怀内涵，而是想方设法找话题、炒绯闻。”陈道明回忆，一位电视台收片负责人说“演员不会演戏没事儿、剧本再烂无妨，只要有绯闻，肯定有收视。更有甚者，开拍前不问剧本内容、不要情怀内涵，而是想方设法找话题、炒绯闻。”陈道明回忆，一位电视台收片负责人说“演员不会演戏没事儿、剧本再烂无妨，只要有绯闻，肯定有收视。",
                   @"● 无论院线经理还是电视台收片人，都掌握着排片大权。无论院线经理还是电视台收片人，都掌握着排片大权。无论院线经理还是电视台收片人，都掌握着排片大权。",
                   @"● 新华网北京11月9日新媒体专电 “衡量一个民族是否有风骨和底蕴、判断一部电影是否有价值和情怀、评价一名演员是否有教养和修养，看的是文化自觉。”演员陈道明认为，泛娱乐的文化生态、唯票房的剧本创作、纯圈钱的文企上市和没教养的艺人涉毒，深刻反映出当前的“文化失觉”现象和文艺浮躁风。",
                   @"● 文艺工作者如何成为时代风气的先觉者?"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProjectContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell == nil) {
        
        cell = [[ProjectContentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
    }
    
    cell.labelContent.text = [contentArr objectAtIndex:indexPath.row];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName, nil];
    rect = [cell.labelContent.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 20, 99999) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    cell.labelContent.numberOfLines = 0;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rect.size.height + 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
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
