//
//  MyNewsViewController.m
//  DSLC
//
//  Created by ios on 15/10/19.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "MyNewsViewController.h"
#import "UIColor+AddColor.h"
#import "CreatView.h"
#import "define.h"
#import "MyNewsCell.h"
#import "MessageDetailViewController.h"

@interface MyNewsViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSMutableArray *picArr;
}

@end

@implementation MyNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationItem setTitle:@"消息中心"];
    [self tableViewShow];
}

- (void)tableViewShow
{
    picArr = [NSMutableArray arrayWithObjects:@"icon04@2x", @"icon05@2x", @"icon04@2x", @"icon05@2x", nil];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10)];
    _tableView.backgroundColor = [UIColor huibai ];
    [_tableView registerNib:[UINib nibWithNibName:@"MyNewsCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [picArr removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 63;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return picArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell == nil) {
        
        cell = [[MyNewsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
    }
    
    cell.labelPrize.text = @"大圣理财年终福利大派送";
    cell.labelPrize.font = [UIFont systemFontOfSize:15];
    
    cell.labelTime.text = @"2015-09-09 18:38";
    cell.labelTime.textColor = [UIColor zitihui];
    cell.labelTime.font = [UIFont systemFontOfSize:12];
    
    cell.imageLeft.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [picArr objectAtIndex:indexPath.row]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MessageDetailViewController *messageDetailVC = [[MessageDetailViewController alloc] init];
    
    messageDetailVC.textString = @"为了庆祝大圣理财平台销售额突破1个亿，大圣理财特此推出年终福利大派送活动．为了庆祝大圣理财平台销售额突破1个亿，大圣理财特此推出年终福利大派送活动．\n为了庆祝大圣理财平台销售额突破1个亿，大圣理财特此推出年终福利大派送活动．为了庆祝大圣理财平台销售额突破1个亿，大圣理财特此推出年终福利大派送活动．\n为了庆祝大圣理财平台销售额突破1个亿，大圣理财特此推出年终福利大派送活动．为了庆祝大圣理财平台销售额突破1个亿，大圣理财特此推出年终福利大派送活动．\n为了庆祝大圣理财平台销售额突破1个亿，大圣理财特此推出年终福利大派送活动．为了庆祝大圣理财平台销售额突破1个亿，大圣理财特此推出年终福利大派送活动．\n为了庆祝大圣理财平台销售额突破1个亿，大圣理财特此推出年终福利大派送活动．为了庆祝大圣理财平台销售额突破1个亿，大圣理财特此推出年终福利大派送活动．";

    [self.navigationController pushViewController:messageDetailVC animated:YES];
    
}

#pragma mark buttonAction other
#pragma mark --------------------------------

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
