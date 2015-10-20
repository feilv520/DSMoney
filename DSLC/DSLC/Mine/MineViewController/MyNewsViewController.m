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
    NSArray *picArr;
}

@end

@implementation MyNewsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:YES];
    [app.tabBarVC setLabelLineHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self naviagationShow];
    [self tableViewShow];
}

//导航内容
- (void)naviagationShow
{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor daohanglan];
    
    self.navigationItem.title = @"消息中心";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"CenturyGothic" size:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIImageView *imageReturn = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, 20, 20) backGroundColor:nil setImage:[UIImage imageNamed:@"750产品111"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageReturn];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonReturn:)];
    [imageReturn addGestureRecognizer:tap];
}

- (void)tableViewShow
{
    picArr = @[@"icon04@2x", @"icon05@2x", @"icon04@2x", @"icon05@2x"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 20 - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10)];
    _tableView.backgroundColor = [UIColor huibai ];
    [_tableView registerNib:[UINib nibWithNibName:@"MyNewsCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 63;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
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
    messageDetailVC.textLabel.text = @"为了庆祝大圣理财平台销售额突破1个亿，大圣理财特此推出年终福利大派送活动．为了庆祝大圣理财平台销售额突破1个亿，大圣理财特此推出年终福利大派送活动．\n为了庆祝大圣理财平台销售额突破1个亿，大圣理财特此推出年终福利大派送活动．为了庆祝大圣理财平台销售额突破1个亿，大圣理财特此推出年终福利大派送活动．\n为了庆祝大圣理财平台销售额突破1个亿，大圣理财特此推出年终福利大派送活动．为了庆祝大圣理财平台销售额突破1个亿，大圣理财特此推出年终福利大派送活动．\n为了庆祝大圣理财平台销售额突破1个亿，大圣理财特此推出年终福利大派送活动．为了庆祝大圣理财平台销售额突破1个亿，大圣理财特此推出年终福利大派送活动．\n为了庆祝大圣理财平台销售额突破1个亿，大圣理财特此推出年终福利大派送活动．为了庆祝大圣理财平台销售额突破1个亿，大圣理财特此推出年终福利大派送活动．";
    messageDetailVC.textLabel.textAlignment = UIControlContentVerticalAlignmentTop;
    [self.navigationController pushViewController:messageDetailVC animated:YES];
    
}

#pragma mark buttonAction other
#pragma mark --------------------------------

//导航返回按钮
- (void)buttonReturn:(UIBarButtonItem *)bar
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC setSuppurtGestureTransition:NO];
    [app.tabBarVC setTabbarViewHidden:NO];
    [app.tabBarVC setLabelLineHidden:NO];
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
