//
//  RiskAlertBookViewController.m
//  DSLC
//
//  Created by ios on 15/11/13.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "RiskAlertBookViewController.h"
#import "RiskAlertBookCell.h"

@interface RiskAlertBookViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSArray *titleArr;
    NSArray *contentArr;
    CGRect rect;
}

@end

@implementation RiskAlertBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
        
    [self.navigationItem setTitle:@"大圣理财平台用户服务协议"];
    
    [self webViewShow];
//    [self tableViewsHOW];
}

- (void)webViewShow
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -44, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 40)];
    [self.view addSubview:webView];
    
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.bounces = NO;
    
    NSURL *url = [NSURL URLWithString:@"http://58.215.161.86/regist.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)tableViewsHOW
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10)];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorColor = [UIColor clearColor];
    
    titleArr = @[@"一.延期支付风险:", @"二.早偿风险:", @"三.相关机构的经营风险:"];
    contentArr = @[@[@"通常情况下，鲨鱼是不受人同情的。而斯莱特拍到的这些照片却记录了不可置信的一幕，让人对鲨鱼这种血腥杀手起了怜悯之心。画面上，五头海狮围攻一只鲨鱼，将其分食。摄影师称：“这简直令人难以置信，凶残的捕食者反被捕食，大自然简直太神奇了。”虽然他之前就见过海狮捕食鲨鱼，但那天所见还是让他大吃一惊。国足在上一轮客场0-1输给卡塔尔后，小组赛2胜1平1负仅积7分排名小组第三，晋级12强赛之路变得愈发艰难，主场面对小组垫底的不丹，国足必须拿到3分。本场比赛国足主帅佩兰前场派出于大宝、于海、于汉超的中场组合，而三“于”组合也让亚足联蒙圈了，统计进球时将于大宝的两粒进球全算到了于汉超头上，于是本场比赛就有两人完成了大四喜。(瑪塔)国足在上一轮客场0-1输给卡塔尔后，小组赛2胜1平1负仅积7分排名小组第三，晋级12强赛之路变得愈发艰难，主场面对小组垫底的不丹，国足必须拿到3分。本场比赛国足主帅佩兰前场派出于大宝、于海、于汉超的中场组合，而三“于”组合也让亚足联蒙圈了，统计进球时将于大宝的两粒进球全算到了于汉超头上，于是本场比赛就有两人完成了大四喜。(瑪塔)国足在上一轮客场0-1输给卡塔尔后，小组赛2胜1平1负仅积7分排名小组第三，晋级12强赛之路变得愈发艰难，主场面对小组垫底的不丹，国足必须拿到3分。本场比赛国足主帅佩兰前场派出于大宝、于海、于汉超的中场组合，而三“于”组合也让亚足联蒙圈了，统计进球时将于大宝的两粒进球全算到了于汉超头上，于是本场比赛就有两人完成了大四喜。(瑪塔)"],
        @[@"据英国《每日邮报》11月5日报道，摄影师斯莱特?穆尔(Slater Moore)近日跟随一搜捕鲸船出海，在美国加利福尼亚州纽波特海滩近海拍到几头海狮在“疯狂开饭”，他为了拍到更好的镜头，还起动了他的无人拍摄机。海洋哺乳动物中心(the Marine Mammal Center)把加利福尼亚海狮描述成投机型捕猎者，它们以鱿鱼、章鱼、鲱鱼、石斑鱼以及小鲨鱼等为食，但是它们也会被鲸鱼或大白鲨等捕食。加州州立大学鲨鱼实验室的主任克里斯?洛(ChrisLowe)解释道，海狮攻击幼鲨在加州海域特别常见。他说：“人们一般不认为海洋哺乳动物会捕食鲨鱼，不过这其实真的很常见。”"],
        @[@"2015年11月11日下午13时许，在南京1912广场，两男子为争抢女友决斗玩命大打出手。据江苏网络电视台报道。据目击者介绍，下午13点30分左右，1912广场某酒吧门口，两名男子发生争执，后殴打起来，在殴打的过程中，其中一名男子拿起附近的木招牌。"]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RiskAlertBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell == nil) {
        
        cell = [[RiskAlertBookCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
    }
    
    cell.labelBook.text = [[contentArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName, nil];
    rect = [cell.labelBook.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 20, 200000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    cell.labelBook.numberOfLines = 0;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rect.size.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 40) backgroundColor:[UIColor whiteColor]];
    
    UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(10, 0, WIDTH_CONTROLLER_DEFAULT - 20, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:[titleArr objectAtIndex:section]];
    [view addSubview:label];
    
    return view;
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
