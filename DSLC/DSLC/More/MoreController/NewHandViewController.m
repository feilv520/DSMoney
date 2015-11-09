//
//  NewHandViewController.m
//  DSLC
//
//  Created by ios on 15/10/26.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "NewHandViewController.h"
#import "NewHandCell.h"

@interface NewHandViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSArray *contentArr;
    NSArray *redBagArr;
    CGRect rect;
    BOOL sunShine;
    
    UIView *viewGraySectionZero;
    UIView *viewGraySectionOne;
    UIView *viewGraySectionTwo;
    UIView *viewGraySectionThree;
    
    NSInteger sectionOfNumber;
}

@end

@implementation NewHandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    sectionOfNumber = 1000;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.signStr == YES) {
        
        [self.navigationItem setTitle:@"红包说明"];
        
    } else {
        
        [self.navigationItem setTitle:@"新手指南"];
    }
    
    [self setWithAllView];
    [self contentShow];
}

- (void)contentShow
{
    sunShine = NO;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [UIView new];
    [_tableView registerNib:[UINib nibWithNibName:@"NewHandCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    if (self.signStr == YES) {
        
        redBagArr = @[@"1、怎么获得红包", @"2、红包可以做什么", @"3、红包可以拆开多次使用吗?", @"4、下单时使用了红包,订单取消红包还会返还吗"];
        
    } else {
        
        contentArr = @[@"1、大圣理财是什么?", @"2、大圣理财提供的投资理财项目?", @"3、大圣理财平台上的资金安全保障?", @"4、大圣理财平台的收益保障?"];
    }
    
}

- (void)setWithAllView{
    viewGraySectionZero = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 145)];
    viewGraySectionZero.backgroundColor = [UIColor huibai];
    
    viewGraySectionZero.hidden = YES;
    viewGraySectionOne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 145)];
    viewGraySectionOne.backgroundColor = [UIColor huibai];
    
    viewGraySectionOne.hidden = YES;
    viewGraySectionTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 145)];
    viewGraySectionTwo.backgroundColor = [UIColor huibai];
    
    viewGraySectionTwo.hidden = YES;
    viewGraySectionThree = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 145)];
    viewGraySectionThree.backgroundColor = [UIColor huibai];
    
    viewGraySectionThree.hidden = YES;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        
        
        UILabel *labelContent = [CreatView creatWithLabelFrame:CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT - 20, 10) backgroundColor:[UIColor huibai] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为10000元由大圣理财提供,期限3天到期后兑付3天收益。\n新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为10000元由大圣理财提供,期限3天到期后兑付3天收益。"];
        [viewGraySectionZero addSubview:labelContent];
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"CenturyGothic" size:14], NSFontAttributeName, nil];
        rect = [labelContent.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 20, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        labelContent.numberOfLines = 0;
        
        labelContent.frame = CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT - 20, rect.size.height);
        
        return viewGraySectionZero;
        
    } else if (section == 1) {
        
        
        UILabel *labelContent = [CreatView creatWithLabelFrame:CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT - 20, 10) backgroundColor:[UIColor huibai] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为10000元由大圣理财提供,期限3天到期后兑付3天收益。\n新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为10000元由大圣理财提供,期限3天到期后兑付3天收益。"];
        [viewGraySectionOne addSubview:labelContent];
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"CenturyGothic" size:14], NSFontAttributeName, nil];
        rect = [labelContent.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 20, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        labelContent.numberOfLines = 0;
        
        labelContent.frame = CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT - 20, rect.size.height);
        
        return viewGraySectionOne;
    } else if (section == 2) {
        
        
        UILabel *labelContent = [CreatView creatWithLabelFrame:CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT - 20, 10) backgroundColor:[UIColor huibai] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为10000元由大圣理财提供,期限3天到期后兑付3天收益。\n新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为10000元由大圣理财提供,期限3天到期后兑付3天收益。"];
        [viewGraySectionTwo addSubview:labelContent];
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"CenturyGothic" size:14], NSFontAttributeName, nil];
        rect = [labelContent.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 20, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        labelContent.numberOfLines = 0;
        
        labelContent.frame = CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT - 20, rect.size.height);
        
        return viewGraySectionTwo;
    } else {
        
        
        UILabel *labelContent = [CreatView creatWithLabelFrame:CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT - 20, 10) backgroundColor:[UIColor huibai] textColor:[UIColor zitihui] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:14] text:@"新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为10000元由大圣理财提供,期限3天到期后兑付3天收益。\n新手专享是大圣理财对于每一位注册用户鼓励投资的一种模拟投资体验,投资本金为10000元由大圣理财提供,期限3天到期后兑付3天收益。"];
        [viewGraySectionThree addSubview:labelContent];
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"CenturyGothic" size:14], NSFontAttributeName, nil];
        rect = [labelContent.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 20, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        labelContent.numberOfLines = 0;
        
        labelContent.frame = CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT - 20, rect.size.height);
        
        return viewGraySectionThree;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        if (viewGraySectionZero.hidden) {
            return 0.5;
        } else {
            return 145;
        }
    } else if (section == 1) {
        if (viewGraySectionOne.hidden) {
            return 0.5;
        } else {
            return 145;
        }
    } else if (section == 2) {
        if (viewGraySectionTwo.hidden) {
            return 0.5;
        } else {
            return 145;
        }
    } else {
        if (viewGraySectionThree.hidden) {
            return 0.5;
        } else {
            return 145;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewHandCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.signStr == YES) {
        
        cell.labelQuestion.text = [redBagArr objectAtIndex:indexPath.section];
        
    } else {
        
        cell.labelQuestion.text = [contentArr objectAtIndex:indexPath.section];
        
    }
    
    cell.labelQuestion.font = [UIFont systemFontOfSize:15];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (sectionOfNumber == indexPath.section) {
        viewGraySectionZero.hidden = YES;
        viewGraySectionOne.hidden = YES;
        viewGraySectionTwo.hidden = YES;
        viewGraySectionThree.hidden = YES;
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:indexPath.section];
        [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        
        sectionOfNumber = 1000;
        
    } else if (indexPath.section == 0) {
        viewGraySectionZero.hidden = NO;
        viewGraySectionOne.hidden = YES;
        viewGraySectionTwo.hidden = YES;
        viewGraySectionThree.hidden = YES;
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        
        [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        
        sectionOfNumber = indexPath.section;
        
    } else if (indexPath.section == 1) {
        viewGraySectionZero.hidden = YES;
        viewGraySectionOne.hidden = NO;
        viewGraySectionTwo.hidden = YES;
        viewGraySectionThree.hidden = YES;
        NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] initWithIndex:1];
        [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        
        sectionOfNumber = indexPath.section;
        
    } else if (indexPath.section == 2) {
        viewGraySectionZero.hidden = YES;
        viewGraySectionOne.hidden = YES;
        viewGraySectionTwo.hidden = NO;
        viewGraySectionThree.hidden = YES;
        NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] initWithIndex:2];
        [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        
        sectionOfNumber = indexPath.section;
        
    } else {
        viewGraySectionZero.hidden = YES;
        viewGraySectionOne.hidden = YES;
        viewGraySectionTwo.hidden = YES;
        viewGraySectionThree.hidden = NO;
        NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] initWithIndex:3];
        [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        
        sectionOfNumber = indexPath.section;
        
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
