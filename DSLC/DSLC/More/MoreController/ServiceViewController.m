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
    UIButton *buttonBlack;
    UIView *viewWhite;
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
    
    imageArr = @[@[@"zaixiankefu"], @[@"lianxikefu"]];
    titleArr = @[@[@"在线客服"], @[@"客服热线"]];
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell == nil) {
        
        cell = [[ServiceCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
    }
    
    NSArray *rowArr = [imageArr objectAtIndex:indexPath.section];
    cell.imageViewLeft.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [rowArr objectAtIndex:indexPath.row]]];
    
    cell.imageRight.image = [UIImage imageNamed:@"arrow"];
    
    cell.labelTitle.text = [[titleArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.labelTitle.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    
    if (indexPath.section == 0) {
        
        cell.labelNum.hidden = YES;
    }
    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            cell.labelNum.text = @"400-254-569";
            cell.labelNum.textColor = [UIColor daohanglan];
            cell.labelNum.font = [UIFont fontWithName:@"CenturyGothic" size:15];
            cell.labelNum.textAlignment = NSTextAlignmentRight;
            
        }
    }
    
    cell.labelLine.backgroundColor = [UIColor grayColor];
    cell.labelLine.alpha = 0.1;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        
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
        
    } else {
        
        NSLog(@"在线客服");
    }
}

//白色弹框
- (void)viewWhiteShow
{
    UIButton *butCancle = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(viewWhite.frame.size.width - 33, 8, 25, 25) backgroundColor:[UIColor clearColor] textColor:nil titleText:nil];
    [butCancle setBackgroundImage:[UIImage imageNamed:@"cuo"] forState:UIControlStateNormal];
    [viewWhite addSubview:butCancle];
    [butCancle addTarget:self action:@selector(buttonCanclePress:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *labelCallOut = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, viewWhite.frame.size.width, 30)];
    [viewWhite addSubview:labelCallOut];
    
    NSMutableAttributedString *callOutStr = [[NSMutableAttributedString alloc] initWithString:@"拨打客服电话 : 400-254-569?"];
    NSRange callString = NSMakeRange(0, [[callOutStr string] rangeOfString:@":"].location);
    [callOutStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:18] range:callString];
    
    NSRange numString = NSMakeRange(8, [[callOutStr string] rangeOfString:@"?"].location - 8);
    [callOutStr addAttribute:NSForegroundColorAttributeName value:[UIColor daohanglan] range:numString];
    [callOutStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"CenturyGothic" size:18] range:numString];
    
    NSRange yuan = NSMakeRange([[callOutStr string] length] - 1, 1);
    [callOutStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:yuan];
    
    [labelCallOut setAttributedText:callOutStr];
    labelCallOut.textAlignment = NSTextAlignmentCenter;
    
    UIButton *butMakeSure = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(20, 90, viewWhite.frame.size.width - 40, 40) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"呼叫"];
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

- (void)callMakeSureButton:(UIButton *)button
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%lld", 13354288036]];
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
