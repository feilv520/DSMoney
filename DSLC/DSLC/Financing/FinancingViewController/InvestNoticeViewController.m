//
//  InvestNoticeViewController.m
//  DSLC
//
//  Created by ios on 15/11/4.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "InvestNoticeViewController.h"
#import "InvestNoticeCell.h"

@interface InvestNoticeViewController () <UITableViewDataSource, UITableViewDelegate, UIWebViewDelegate>

{
    UITableView *_tableView;
    NSArray *titleArr;
    NSArray *contentArr;
    CGRect rect;
}

@end

@implementation InvestNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"投资须知"];
    
    
    
//    [self tableViewShow];
    [self webViewShow];
}

- (void)webViewShow
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -44, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 40)];
    [self.view addSubview:webView];
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.delegate = self;
    webView.scrollView.bounces = NO;
    
    [self loadingWithView:webView loadingFlag:NO height:self.view.center.y];
    
    NSString *urlString = [NSString stringWithFormat:@"http://wap.dslc.cn/prouctInfo/product_descthree.html?productType=%@&type=2",self.productType];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self loadingWithHidden:YES];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor whiteColor];
    
    titleArr = @[@"新手专享", @"火爆专区", @"固收理财", @"银行票据"];
    contentArr = @[@[@"1、活动期间，新注册用户自动获取“5000个猴币”（1个猴币价值1元人民币）。\n\n2、“5000个猴币”只能用于体验“新手专享”，客户无需支付任何本金，到期即可获得活动收益。\n\n3、“新手专享”产品是为活动设定的虚拟借款产品，不对接真实借款人，其对应的法律文件均系为用户提供更真实的投资体验，无实际法律效力。\n\n 4、“猴币”是大圣理财平台开发的会员优惠，不具备货币功能。\n\n5、“5000个猴币”自新用户获得之日起有效，须一次性使用完。产品到期后该5000猴币由平台收回。\n\n6、到期收益如须提现，请先实名认证并绑定银行卡。\n\n7、恶意刷猴币、冒用他人身份信息使用猴币等行为（包括但不限于手机号码、身份证、IP等信息），一经核实，平台有权收回该用户所得猴币及收益，并冻结账户。\n\n8、 *活动最终解释权归国丞创投（上海）金融信息服务有限公司（大圣理财平台）所有，如您有任何疑问，请致电400-816-2283"],
                   @[@"◎购买条件\n\n火爆专区投资机会开放认购时，用户单笔投资金额不低于100元，且为100元的整数倍递增，单个客户购买额度无上限。\n\n◎相关费用\n\n充值、提现、投资买入相关手续费用均为0。"],
                   @[@"◎购买条件\n\n用户单笔投资金额不低于1000元，且为100元的整数倍递增，每日投资无上限。\n\n◎相关费用\n\n充值、提现、投资买入相关手续费用均为0。"],
                   @[@"◎购买条件\n\n大圣理财银行票据产品，用户单笔投资金额不低于100元，且为100元的整数倍递增，每日投资无上限。\n\n◎相关费用\n\n充值、提现、投资买入相关手续费用均为0。\n"]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rect.size.height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InvestNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell == nil) {
        
        cell = [[InvestNoticeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
    }
    
    cell.label.text = [[contentArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"CenturyGothic" size:13],NSFontAttributeName, nil];
    rect = [cell.label.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 20, 123456) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    cell.label.numberOfLines = 0;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewHead = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor]];
    
    UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT - 20, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:[titleArr objectAtIndex:section]];
    [viewHead addSubview:label];
    
    return viewHead;
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
