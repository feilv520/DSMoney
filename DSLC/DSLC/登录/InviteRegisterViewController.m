//
//  InviteRegisterViewController.m
//  DSLC
//
//  Created by ios on 15/11/12.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "InviteRegisterViewController.h"
#import "InviteNumReginCell.h"

@interface InviteRegisterViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    CGRect rect;
    NSArray *titleArr;
    NSArray *contentArr;
}

@end

@implementation InviteRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"邀请码说明"];
    
//    [self tableViewShow];
    [self webViewShow];
}

- (void)webViewShow
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -44, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 40)];
    [self.view addSubview:webView];
    
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    webView.scrollView.bounces = NO;
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.41:8080/tongjiang/lr_invite.do"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.backgroundColor = [UIColor whiteColor];
    
    titleArr = @[@"1.怎么获得邀请码?", @"2.邀请码可以做什么?"];
    contentArr = @[@[@"在谈到中美应对气候变化及开展新能源领域合作时，李克强表示，当前中国正在推进经济结构性改革和结构调整，走绿  色可持续发展道路。在这一进程中，中国愿同世界各国携手合作，综合施策，共同应对气候变化挑战。发展包括核电在内的清洁能源是一条重要途径。"],
                   @[@"中新社北京11月12日电 (记者 郭金超)中国国务院总理李克强12日下午在中南海紫光阁会见来华访问的比尔·盖茨。中新社北京11月12日电 (记者 郭金超)中国国务院总理李克强12日下午在中南海紫光阁会见来华访问的比尔·盖茨。中新社北京11月12日电 (记者 郭金超)中国国务院总理李克强12日下午在中南海紫光阁会见来华访问的比尔·盖茨。中新社北京11月12日电 (记者 郭金超)中国国务院总理李克强12日下午在中南海紫光阁会见来华访问的比尔·盖茨。中新社北京11月12日电 (记者 郭金超)中国国务院总理李克强12日下午在中南海紫光阁会见来华访问的比尔·盖茨。中新社北京11月12日电 (记者 郭金超)中国国务院总理李克强12日下午在中南海紫光阁会见来华访问的比尔·盖茨。中新社北京11月12日电 (记者 郭金超)中国国务院总理李克强12日下午在中南海紫光阁会见来华访问的比尔·盖茨。中新社北京11月12日电 (记者 郭金超)中国国务院总理李克强12日下午在中南海紫光阁会见来华访问的比尔·盖茨。中新社北京11月12日电 (记者 郭金超)中国国务院总理李克强12日下午在中南海紫光阁会见来华访问的比尔·盖茨。中新社北京11月12日电 (记者 郭金超)中国国务院总理李克强12日下午在中南海紫光阁会见来华访问的比尔·盖茨。中新社北京11月12日电 (记者 郭金超)中国国务院总理李克强12日下午在中南海紫光阁会见来华访问的比尔·盖茨。中新社北京11月12日电 (记者 郭金超)中国国务院总理李克强12日下午在中南海紫光阁会见来华访问的比尔·盖茨。中新社北京11月12日电 (记者 郭金超)中国国务院总理李克强12日下午在中南海紫光阁会见来华访问的比尔·盖茨。中新社北京11月12日电 (记者 郭金超)中国国务院总理李克强12日下午在中南海紫光阁会见来华访问的比尔·盖茨。中新社北京11月12日电 (记者 郭金超)中国国务院总理李克强12日下午在中南海紫光阁会见来华访问的比尔·盖茨。中新社北京11月12日电 (记者 郭金超)中国国务院总理李克强12日下午在中南海紫光阁会见来华访问的比尔·盖茨。中新社北京11月12日电 (记者 郭金超)中国国务院总理李克强12日下午在中南海紫光阁会见来华访问的比尔·盖茨。中新社北京11月12日电 (记者 郭金超)中国国务院总理李克强12日下午在中南海紫光阁会见来华访问的比尔·盖茨。中新社北京11月12日电 (记者 郭金超)中国国务院总理李克强12日下午在中南海紫光阁会见来华访问的比尔·盖茨。"]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InviteNumReginCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell == nil) {
        
        cell = [[InviteNumReginCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
    }
    
    cell.labelAsk.text = [[contentArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"CenturyGothic" size:13], NSFontAttributeName, nil];
    rect = [cell.labelAsk.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 20, 300000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    cell.labelAsk.numberOfLines = 0;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rect.size.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewHead = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor]];
    
    UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(10, 0, WIDTH_CONTROLLER_DEFAULT - 20, 50) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont systemFontOfSize:15] text:[titleArr objectAtIndex:section]];
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
