//
//  TWOAboutDSLCViewController.m
//  DSLC
//
//  Created by ios on 16/5/18.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TWOAboutDSLCViewController.h"
#import "TWOAboutDSLCCell.h"
#import "TWOAboutDSLCUpCell.h"
#import "TWOHelpCenterViewController.h"
#import "TWOAgreeFeedbackViewController.h"
#import "AboutViewController.h"

@interface TWOAboutDSLCViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

{
    UITableView *_tableView;
    UIImageView *imagePicture;
    CGFloat height;
    UIButton *butBlack;
    UIView *viewTanKuang;
}

@end

@implementation TWOAboutDSLCViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor qianhuise];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 231.0)];
    _tableView.tableHeaderView.backgroundColor = [UIColor qianhuise];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOAboutDSLCUpCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [_tableView registerNib:[UINib nibWithNibName:@"TWOAboutDSLCCell" bundle:nil] forCellReuseIdentifier:@"reuseAbout"];
    
    [self tableViewHeadShow];
}

- (void)tableViewHeadShow
{
//    背景图
    imagePicture = [CreatView creatImageViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, _tableView.tableHeaderView.frame.size.height) backGroundColor:[UIColor qianhuise] setImage:[UIImage imageNamed:@"aboutBack"]];
    [_tableView.tableHeaderView addSubview:imagePicture];
    imagePicture.userInteractionEnabled = YES;
    height = imagePicture.frame.size.height;
    imagePicture.autoresizesSubviews = YES;
    
//    返回按钮
    UIButton *butReturn = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, 27, 20, 20) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [imagePicture addSubview:butReturn];
    [butReturn setBackgroundImage:[UIImage imageNamed:@"导航返回"] forState:UIControlStateNormal];
    [butReturn setBackgroundImage:[UIImage imageNamed:@"导航返回"] forState:UIControlStateHighlighted];
    butReturn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [butReturn addTarget:self action:@selector(buttonReturnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
//    页面标题
    UILabel *labelAbout = [CreatView creatWithLabelFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 45, 25, 90, 25) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"关于大圣理财"];
    [imagePicture addSubview:labelAbout];
    labelAbout.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
//    猴头logo
    UIImageView *imageHead = [CreatView creatImageViewWithFrame:CGRectMake(WIDTH_CONTROLLER_DEFAULT/2 - 100.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)/2, 25 + 25 + 27.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 100.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20), 100.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20)) backGroundColor:[UIColor clearColor] setImage:[UIImage imageNamed:@"aboutDSLC"]];
    [imagePicture addSubview:imageHead];
    imageHead.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
//    版本号
    UILabel *labelVersions = [CreatView creatWithLabelFrame:CGRectMake(0, 25 + 25 + 27.0 + 100.0 / 667.0 * (HEIGHT_CONTROLLER_DEFAULT - 20) + 5, WIDTH_CONTROLLER_DEFAULT, 16) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:[NSString stringWithFormat:@"版本号%@", @"2.0.0"]];
    [imagePicture addSubview:labelVersions];
    labelVersions.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    } else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        TWOAboutDSLCUpCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        
        NSArray *oneArray = @[@"帮助中心", @"意见反馈", @"去评分", @"关于我们"];
        cell.labelTitle.text = [oneArray objectAtIndex:indexPath.row];
        cell.imageRight.image = [UIImage imageNamed:@"righticon"];
        
        return cell;
        
    } else {
        
        TWOAboutDSLCCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseAbout"];
        
        NSArray *twoArray = @[@"客服热线", @"微信公众号", @"官方微博"];
        cell.labelTitle.text = [twoArray objectAtIndex:indexPath.row];
        
        NSArray *rightArray = @[@"400-816-2283", @"大圣理财服务号", @"大圣理财平台"];
        cell.labelState.text = [rightArray objectAtIndex:indexPath.row];
        cell.labelState.textColor = [UIColor profitColor];
        
        if (indexPath.row == 1) {
            cell.labelState.textColor = [UIColor orangecolor];
        }
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 51;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 9;
    } else {
        return 0.1;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
//            帮助中心
            TWOHelpCenterViewController *helpCenterVC = [[TWOHelpCenterViewController alloc] init];
            [self.navigationController pushViewController:helpCenterVC animated:YES];
        } else if (indexPath.row == 1) {
//            意见反馈
            TWOAgreeFeedbackViewController *agreeFeedback = [[TWOAgreeFeedbackViewController alloc] init];
            pushVC(agreeFeedback);
        } else if (indexPath.row == 2) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/da-sheng-li-cai/id1063185702?mt=8"]];
        } else {
//            关于我们
            AboutViewController *aboutVC = [[AboutViewController alloc] init];
            pushVC(aboutVC);
        }
    } else {
        
        if (indexPath.row == 0) {
//            联系客服弹框
            [self tanKuangShow];
            
        } else if (indexPath.row == 1) {
//            复制微信公众账号
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            [pasteboard setString:@"链接还没有"];
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"已复制公众号名称"];
            
        } else {
//            复制官方微博
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            [pasteboard setString:@"微博链接还没有"];
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"已复制微博名称"];
        }
    }
}

- (void)tanKuangShow
{
//    黑色遮罩层
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    butBlack = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
    [app.tabBarVC.view addSubview:butBlack];
    butBlack.alpha = 0.5;
    [butBlack addTarget:self action:@selector(buttonBlackAlphaDisappear:) forControlEvents:UIControlEventTouchUpInside];
    
//    view弹框
    viewTanKuang = [CreatView creatViewWithFrame:CGRectMake(30, 30, WIDTH_CONTROLLER_DEFAULT - 60, 237) backgroundColor:[UIColor whiteColor]];
    [app.tabBarVC.view addSubview:viewTanKuang];
    viewTanKuang.center = app.tabBarVC.view.center;
    viewTanKuang.layer.cornerRadius = 5;
    viewTanKuang.layer.masksToBounds = YES;
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [viewTanKuang.layer addAnimation:animation forKey:nil];
    
    CGFloat viewWidth = viewTanKuang.frame.size.width;
    
    UILabel *labelHotLine = [CreatView creatWithLabelFrame:CGRectMake(0, 0, viewWidth, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor ZiTiColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"客服热线"];
    [viewTanKuang addSubview:labelHotLine];
    
    UIButton *butCancle = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(viewWidth - 5 - 20, 10, 20, 20) backgroundColor:[UIColor whiteColor] textColor:nil titleText:nil];
    [viewTanKuang addSubview:butCancle];
    [butCancle setBackgroundImage:[UIImage imageNamed:@"product-cuo"] forState:UIControlStateNormal];
    [butCancle setBackgroundImage:[UIImage imageNamed:@"product-cuo"] forState:UIControlStateHighlighted];
    [butCancle addTarget:self action:@selector(buttonBlackAlphaDisappear:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, labelHotLine.frame.size.height - 0.5, viewWidth, 0.5) backgroundColor:[UIColor profitColor]];
    [viewTanKuang addSubview:viewLine];
    
    UIButton *butPhoneNum = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 40 + 33, viewWidth, 50) backgroundColor:[UIColor whiteColor] textColor:[UIColor profitColor] titleText:@" 400-816-2283"];
    [viewTanKuang addSubview:butPhoneNum];
    butPhoneNum.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:34];
    [butPhoneNum setImage:[UIImage imageNamed:@"kefu"] forState:UIControlStateNormal];
    
    UIButton *buttonCall = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(20, 40 + 33 + butPhoneNum.frame.size.height + 35, viewWidth - 40, 40) backgroundColor:[UIColor profitColor] textColor:[UIColor whiteColor] titleText:@"呼叫"];
    [viewTanKuang addSubview:buttonCall];
    buttonCall.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    buttonCall.layer.cornerRadius = 5;
    buttonCall.layer.masksToBounds = YES;
    [buttonCall addTarget:self action:@selector(buttonCallHotLine:) forControlEvents:UIControlEventTouchUpInside];
}

//呼叫按钮
- (void)buttonCallHotLine:(UIButton *)button
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", @"400-816-2283"]];
    [[UIApplication sharedApplication] openURL:url];
    
    [butBlack removeFromSuperview];
    [viewTanKuang removeFromSuperview];
    
    butBlack = nil;
    viewTanKuang = nil;
}

- (void)buttonBlackAlphaDisappear:(UIButton *)button
{
    [butBlack removeFromSuperview];
    [viewTanKuang removeFromSuperview];
    
    butBlack = nil;
    viewTanKuang = nil;
}

//返回按钮
- (void)buttonReturnClicked:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offSet = scrollView.contentOffset.y;
    
    if (offSet < 0) {
        
        imagePicture.contentMode = UIViewContentModeScaleAspectFill;
        CGRect frame = imagePicture.frame;
        frame.origin.y = offSet;
        frame.size.height = height - offSet;
        imagePicture.frame = frame;
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
