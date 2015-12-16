//
//  ServiceViewController.m
//  DSLC
//
//  Created by ios on 15/10/26.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "ServiceViewController.h"
#import "ServiceCell.h"

@interface ServiceViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSArray *imageArr;
    NSArray *titleArr;
    NSArray *contentArr;
    UIButton *buttonBlack;
    UIView *viewWhite;
    UIButton *butblack;
    UIView *viewCopy;
    UILabel *labelCallOut;
}

@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationItem setTitle:@"联系客服"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor huibai];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 1)];
    [_tableView registerNib:[UINib nibWithNibName:@"ServiceCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    imageArr = @[@[@"lianxikefu"], @[@"微信", @"新浪微博"]];
    titleArr = @[@[@"客服热线"],@[@"微信公众号", @"官方微博"]];
    contentArr = @[@[@"400-816-2283"], @[@"大圣理财服务号", @"大圣理财平台"]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 0;
        
    } else {
        
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
        
    } else {
        
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    NSArray *rowArr = [imageArr objectAtIndex:indexPath.section];
    cell.imageViewLeft.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [rowArr objectAtIndex:indexPath.row]]];
    
    cell.imageRight.image = [UIImage imageNamed:@"arrow"];
    
    cell.labelTitle.text = [[titleArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.labelTitle.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    cell.labelNum.text = [[contentArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.labelNum.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    cell.labelNum.textAlignment = NSTextAlignmentRight;
    
    if (indexPath.section == 0) {
        
        cell.labelNum.textColor = [UIColor daohanglan];
    }
    
    cell.labelLine.backgroundColor = [UIColor grayColor];
    cell.labelLine.alpha = 0.1;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        buttonBlack = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        [app.tabBarVC.view addSubview:buttonBlack];
        buttonBlack.alpha = 0.3;
        [buttonBlack addTarget:self action:@selector(buttonDisappearFromView:) forControlEvents:UIControlEventTouchUpInside];
        
        viewWhite = [CreatView creatViewWithFrame:CGRectMake(50, HEIGHT_CONTROLLER_DEFAULT/2 - 100, WIDTH_CONTROLLER_DEFAULT - 100, HEIGHT_CONTROLLER_DEFAULT/4 - 20) backgroundColor:[UIColor whiteColor]];
        [app.tabBarVC.view addSubview:viewWhite];
        viewWhite.layer.cornerRadius = 3;
        viewWhite.layer.masksToBounds = YES;
        
        [self viewWhiteShow];
        
    } else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"已复制微信公众号名称"];
            
//            butblack = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
//            AppDelegate *app = [[UIApplication sharedApplication] delegate];
//            [app.tabBarVC.view addSubview:butblack];
//            butblack.alpha = 0.3;
//            [butblack addTarget:self action:@selector(buttonWeiXin:) forControlEvents:UIControlEventTouchUpInside];
//            
//            viewCopy = [CreatView creatViewWithFrame:CGRectMake(40, HEIGHT_CONTROLLER_DEFAULT/2 - 80, WIDTH_CONTROLLER_DEFAULT - 80, 100) backgroundColor:[UIColor whiteColor]];
//            [app.tabBarVC.view addSubview:viewCopy];
//            viewCopy.layer.cornerRadius = 5;
//            viewCopy.layer.masksToBounds = YES;
//            
//            UILabel *labelWeiXin = [CreatView creatWithLabelFrame:CGRectMake(0, 0, viewCopy.frame.size.width, viewCopy.frame.size.height) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter textFont:[UIFont fontWithName:@"CenturyGothic" size:18] text:@"已复制微信公众号名称"];
//            [viewCopy addSubview:labelWeiXin];
            
        } else {
        
            [self showTanKuangWithMode:MBProgressHUDModeText Text:@"已复制微博公众账号"];
        }
    }
}

//白色弹框
- (void)viewWhiteShow
{
    UIButton *butCancle = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(viewWhite.frame.size.width - 26, 8, WIDTH_CONTROLLER_DEFAULT * (20.0 / 375.0), WIDTH_CONTROLLER_DEFAULT * (20.0 / 375.0)) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [butCancle setBackgroundImage:[UIImage imageNamed:@"cuo"] forState:UIControlStateNormal];
    [viewWhite addSubview:butCancle];
    [butCancle addTarget:self action:@selector(buttonCanclePress:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect rectMain = [[UIScreen mainScreen] bounds];
    
    labelCallOut = [[UILabel alloc] initWithFrame:CGRectMake(0, WIDTH_CONTROLLER_DEFAULT * (20.0 / 375.0) + 10, viewWhite.frame.size.width, HEIGHT_CONTROLLER_DEFAULT * (30.0 / 667.0))];
    UIButton *butMakeSure = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(20, HEIGHT_CONTROLLER_DEFAULT * (30.0 / 667.0) + WIDTH_CONTROLLER_DEFAULT * (20.0 / 375.0) + 20, viewWhite.frame.size.width - 40, HEIGHT_CONTROLLER_DEFAULT * (40.0 / 667.0)) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"呼叫"];
    
    if (rectMain.size.width == 320) {
        
        NSMutableAttributedString *callOutStr = [[NSMutableAttributedString alloc] initWithString:@"拨打客服电话 :400-816-2283?"];
        NSRange callString = NSMakeRange(0, [[callOutStr string] rangeOfString:@":"].location);
        [callOutStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:callString];
        
        NSRange numString = NSMakeRange(8, [[callOutStr string] rangeOfString:@"?"].location - 8);
        [callOutStr addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:numString];
        [callOutStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:14] range:numString];
        
        NSRange yuan = NSMakeRange([[callOutStr string] length] - 1, 1);
        [callOutStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:yuan];
        [labelCallOut setAttributedText:callOutStr];

    } else {
        
        NSMutableAttributedString *callOutStr = [[NSMutableAttributedString alloc] initWithString:@"拨打客服电话 : 400-816-2283?"];
        NSRange callString = NSMakeRange(0, [[callOutStr string] rangeOfString:@":"].location);
        [callOutStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:18] range:callString];
        
        NSRange numString = NSMakeRange(8, [[callOutStr string] rangeOfString:@"?"].location - 8);
        [callOutStr addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:numString];
        [callOutStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:18] range:numString];
        
        NSRange yuan = NSMakeRange([[callOutStr string] length] - 1, 1);
        [callOutStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:yuan];
        [labelCallOut setAttributedText:callOutStr];
        
        butMakeSure.frame = CGRectMake(20, HEIGHT_CONTROLLER_DEFAULT * (30.0 / 667.0) + WIDTH_CONTROLLER_DEFAULT * (20.0 / 375.0) + 30, viewWhite.frame.size.width - 40, HEIGHT_CONTROLLER_DEFAULT * (40.0 / 667.0));
    }
    
    [viewWhite addSubview:labelCallOut];
    labelCallOut.textAlignment = NSTextAlignmentCenter;
    
    [viewWhite addSubview:butMakeSure];
    [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
    [butMakeSure setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    [butMakeSure addTarget:self action:@selector(callMakeSureButton:) forControlEvents:UIControlEventTouchUpInside];
}

//黑色遮罩层消失
- (void)buttonDisappearFromView:(UIButton *)button
{
    [button removeFromSuperview];
    [viewWhite removeFromSuperview];
    
    button = nil;
    viewWhite = nil;
}

//点差按钮
- (void)buttonCanclePress:(UIButton *)button
{
    [buttonBlack removeFromSuperview];
    [viewWhite removeFromSuperview];
    
    button = nil;
    viewWhite = nil;
}

//微信遮罩消失
- (void)buttonWeiXin:(UIButton *)button
{
    [butblack removeFromSuperview];
    [viewCopy removeFromSuperview];
    
    butblack = nil;
    viewCopy = nil;
}

- (void)callMakeSureButton:(UIButton *)button
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", @"400-816-2283"]];
    [[UIApplication sharedApplication] openURL:url];
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
