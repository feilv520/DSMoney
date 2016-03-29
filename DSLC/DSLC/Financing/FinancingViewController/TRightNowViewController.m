//
//  TRightNowViewController.m
//  DSLC
//
//  Created by ios on 16/3/28.
//  Copyright © 2016年 马成铭. All rights reserved.
//

#import "TRightNowViewController.h"
#import "TtestResultViewController.h"
#import "TQuestionCell.h"

@interface TRightNowViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSArray *questionArr;
    NSArray *contentArr;
    NSArray *scoresArr;
    CGRect rect;
    CGFloat sumNumber;
    NSIndexPath *curruntIndex;
    UIButton *buttonLast;
    CGFloat scoreOne;
    CGFloat scoreTwo;
    CGFloat scoreThree;
    CGFloat scoreFour;
    CGFloat scoreFive;
}

@end

@implementation TRightNowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    scoreOne = -100;
    scoreTwo = -100;
    scoreThree = -100;
    scoreFour = -100;
    scoreFive = -100;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"风险测试"];
    
    questionArr = @[@"Q:在您每年的家庭收入中,可用于金融投资(储蓄存款除外)的比例为?", @"Q:您的投资目的是?", @"Q:您期望的投资年收益率?", @"Q:以下哪项描述最符合您的投资态度?", @"Q:您的投资出现何种程度的波动时,您会呈现明显的焦虑?"];
    contentArr = @[@[@"A.小于10%", @"B.10%至25%", @"C.25%至50%", @"大于50%"], @[@"A.资产保值，同时获得固定收益", @" B.资产稳健增长，同时获得波动适度的年回报", @"C.资产高回报，能接受短期的资产价值波动"], @[@"A.高于同期定期存款", @"B.5%左右，要求相对风险低", @"C.5%--15%，可承受中等风险", @" D.15%以上，可承担较高风险"], @[@" A.厌恶风险，不希望本金损失，希望获得稳定回报", @" B.保守投资，不希望本金损失，愿意承担一定幅度的收益波动", @"C.寻求资金的较高收益和成长性，愿意为此承担有限本金损失", @"D.希望赚取高回报，愿意为此承担较大本金损失"], @[@" A.本金无损失，但收益未达预期", @"B.出现轻微本金损失", @"C.本金10％以内的损失", @"D.本金20-50％的损失", @"E.本金50％以上损失"]];
    scoresArr = @[@[@"2", @"4", @"8", @"10"], @[@"2", @"6", @"10"], @[@"0", @"4", @"6", @"10"], @[@"0", @"4", @"8", @"10"], @[@"-5", @"5", @"10", @"15", @"20"]];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor qianhuise];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 75)];
    _tableView.tableHeaderView.backgroundColor = [UIColor whiteColor];
    
    UILabel *labelHead = [CreatView creatWithLabelFrame:CGRectMake(10, 0, WIDTH_CONTROLLER_DEFAULT - 20, 70) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont systemFontOfSize:12] text:@"投资有风险,不同承受能力和风险偏好的客户,应该选择不同的投资产品或投资组合,以下测试,可帮助您更好的了解自己的风险偏好和风险承受能力。"];
    [_tableView.tableHeaderView addSubview:labelHead];
    labelHead.numberOfLines = 0;
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 300)];
    _tableView.tableFooterView.backgroundColor = [UIColor qianhuise];
    
    UIButton *butSubmit = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(40, 25, WIDTH_CONTROLLER_DEFAULT - 80, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] titleText:@"提交"];
    [_tableView.tableFooterView addSubview:butSubmit];
    butSubmit.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [butSubmit setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
    [butSubmit setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
    [butSubmit addTarget:self action:@selector(submitButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewBottom = [CreatView creatViewWithFrame:CGRectMake(10, 90, WIDTH_CONTROLLER_DEFAULT - 20, 120) backgroundColor:[UIColor shurukuangColor]];
    [_tableView.tableFooterView addSubview:viewBottom];
    viewBottom.layer.cornerRadius = 5;
    viewBottom.layer.masksToBounds = YES;
    viewBottom.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
    viewBottom.layer.borderWidth = 1;
    
    CGFloat width = viewBottom.frame.size.width;
    CGFloat height = viewBottom.frame.size.height;
    
    UILabel *labelMonkAlert = [CreatView creatWithLabelFrame:CGRectMake(10, 0, width - 20, 40) backgroundColor:[UIColor clearColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:13] text:@"大圣特别提醒您:"];
    [viewBottom addSubview:labelMonkAlert];
    
    UIView *viewWhite = [CreatView creatViewWithFrame:CGRectMake(0, 40, width, height - 40) backgroundColor:[UIColor whiteColor]];
    [viewBottom addSubview:viewWhite];
    
    UILabel *labelContent = [CreatView creatWithLabelFrame:CGRectMake(10, 10, width - 20, viewWhite.frame.size.height - 20) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:12] text:@"1.平台向客户履行风险承受能力评估等适当性职责,并不能取代您自己的投资判断。\n2.大圣在此承诺,对于您在本问卷中所提供的一切信息,我们将严格履行保密协议。"];
    [viewWhite addSubview:labelContent];
    labelContent.numberOfLines = 0;
}

//提交按钮
- (void)submitButton:(UIButton *)button
{
    if (scoreOne == -100 || scoreTwo == -100 || scoreThree == -100 || scoreFour == -100 || scoreFive == -100) {
        [self showTanKuangWithMode:MBProgressHUDModeText Text:@"所有题目需答完整才能看到测评结果哦~"];
        return;
    }
    
    TtestResultViewController *testResult = [[TtestResultViewController alloc] init];
    testResult.score = sumNumber;
    [self.navigationController pushViewController:testResult animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return rect.size.height + 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10) backgroundColor:[UIColor qianhuise]];
    
    UILabel *labelQuse = [CreatView creatWithLabelFrame:CGRectMake(10, 0, WIDTH_CONTROLLER_DEFAULT - 20, 10) backgroundColor:[UIColor clearColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont systemFontOfSize:14] text:[questionArr objectAtIndex:section]];
    [view addSubview:labelQuse];
    [self labelHeight:labelQuse];
    
    labelQuse.frame = CGRectMake(10, 5, WIDTH_CONTROLLER_DEFAULT - 20, rect.size.height);
    
    view.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, rect.size.height + 10);
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    [self tableView:tableView viewForHeaderInSection:section];
    return rect.size.height + 10;
}

//自适应高度
- (void)labelHeight:(UILabel *)label
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, nil];
    rect = [label.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 20, 9999999999) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    label.numberOfLines = 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 2 || section == 3) {
        return 4;
    } else if (section == 1) {
        return 3;
    } else {
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell == nil) {
        cell = [[TQuestionCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuse"];
    }
    
    cell.labelQuestion.text = [[contentArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"CenturyGothic" size:12], NSFontAttributeName, nil];
    rect = [cell.labelQuestion.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 40, 900000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    cell.labelQuestion.numberOfLines = 0;
    
    if (curruntIndex != nil && curruntIndex.row == indexPath.row) {
        
        cell.butChoose.image = [UIImage imageNamed:@"椭圆-3-拷贝-7"];
        
    } else {
        
        cell.butChoose.image = [UIImage imageNamed:@"椭圆-3"];
    }
    
    cell.tag = 1989;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//选择答案
- (void)buttonChooseWhichOne:(UIButton *)button
{
    if (button != buttonLast) {
        buttonLast.selected = NO;
        buttonLast = button;
    }
    
    buttonLast.selected = YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    curruntIndex = indexPath;
    NSIndexSet *curruntSet = [[NSIndexSet alloc] initWithIndex:indexPath.section];
    [tableView reloadSections:curruntSet withRowAnimation:UITableViewRowAnimationNone];
    
    if (indexPath.section == 0) {
        
        CGFloat score = [[[scoresArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] floatValue];
        if (scoreOne != score) {
            scoreOne = score;
        }
        
    } else if (indexPath.section == 1) {
        
        CGFloat score = [[[scoresArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] floatValue];
        if (scoreTwo != score) {
            scoreTwo = score;
        }
        
    } else if (indexPath.section == 2) {
        
        CGFloat score = [[[scoresArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] floatValue];
        if (scoreThree != score) {
            scoreThree = score;
        }

    } else if (indexPath.section == 3) {
        
        CGFloat score = [[[scoresArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] floatValue];
        if (scoreFour != score) {
            scoreFour = score;
        }
        
    } else {
        
        CGFloat score = [[[scoresArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] floatValue];
        if (scoreFive != score) {
            scoreFive = score;
        }
    }
    
    sumNumber = scoreOne + scoreTwo + scoreThree + scoreFour + scoreFive;
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
