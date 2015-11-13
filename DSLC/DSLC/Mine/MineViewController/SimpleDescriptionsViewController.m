//
//  SimpleDescriptionsViewController.m
//  DSLC
//
//  Created by 马成铭 on 15/11/2.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "SimpleDescriptionsViewController.h"

@interface SimpleDescriptionsViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSArray *ContentArr;
    CGRect rect;
}

@end

@implementation SimpleDescriptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"项目简述";
    
    [self contentShow];
}

- (void)contentShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20) style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 15)];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.backgroundColor = [UIColor whiteColor];
    
    ContentArr = @[@[@"新鲜花生最好连壳煮着吃，煮熟后的花生不仅容易消化吸收，而且可以充分利用花生壳和内层红衣的医疗保健作用。花    生红衣能抑制纤维蛋白的溶解，促进血小板新生，加强毛细血管的收缩功能，可治疗血小板减少和防治出血性疾病；花生壳有降低血压、调整胆固醇的作用。古籍认为，花生补中益气，盐水煮食养肺。"],
                   @[@"有些人习惯吃炒花仁或用油炸后吃，这样会使花生红衣中所合甘油脂和塞醇酯成分被大量破坏，因此花生仁连红衣一起煮着吃营养价值更高。另外，花生容易感染黄曲霉菌毒素，水煮后，花生所污染的黄曲霉菌毒素基本上能溶到水里去，这样吃更安全。花生米含有人体所需要的不饱和脂肪酸，但毕竟脂类含量高、热量大、有油腻感。而醋中的多种有机酸恰是解腻又生香的，因此用醋浸泡花生米一周以上，每晚吃7到10粒，连吃一周为一个疗程，可降低血压，软化血管，减少胆固醇的堆积。"], @[@"花生中高含量的蛋白及氨基酸还可提高记忆力，延缓衰老。它所含的VE可延缓组织老化，并增强肝脏解毒功能。"], @[@"新浪体育讯　　北京时间11月13日消息，昨晚2018年世界杯预选赛亚洲区40强赛，国足在长沙12-0大胜不丹，据上海热线消息，就在比赛当天，从上海也传来了好消息武磊喜得千金，变身奶爸。国足与不丹比赛之前，武磊妻子临产，武磊也火速返回上海陪产，因此错过与不丹一战。令人欣喜的是，在国足狂胜不丹赛后，武磊正式发布了喜得千金的喜讯：“7斤2两的小公主，顺产很顺利，母女平安！感谢所有人的祝福，小公主很听话，壹壹妈妈最伟大！天下所有的母亲都是最伟大的！”新浪体育讯　　北京时间11月13日消息，昨晚2018年世界杯预选赛亚洲区40强赛，国足在长沙12-0大胜不丹，据上海热线消息，就在比赛当天，从上海也传来了好消息武磊喜得千金，变身奶爸。国足与不丹比赛之前，武磊妻子临产，武磊也火速返回上海陪产，因此错过与不丹一战。令人欣喜的是，在国足狂胜不丹赛后，武磊正式发布了喜得千金的喜讯：“7斤2两的小公主，顺产很顺利，母女平安！感谢所有人的祝福，小公主很听话，壹壹妈妈最伟大！天下所有的母亲都是最伟大的！”"], @[@"新浪体育讯　　北京时间11月13日消息，在昨晚进行的2018年世界杯预选赛亚洲区40强赛中，中国男足12-0大胜不丹，本场比赛杨旭上演大四喜，于汉超、于大宝、王永珀均梅开二度，梅方、张稀哲各入一球，不过在赛后亚足联的官方比赛报告上，于汉超的进球数也变成了4粒，亚足联将于大宝的进球全划到了于汉超头上。"]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
    }
    
    cell.textLabel.text = [[ContentArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"CenturyGothic" size:13], NSFontAttributeName, nil];
    rect = [cell.textLabel.text boundingRectWithSize:CGSizeMake(WIDTH_CONTROLLER_DEFAULT - 20, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    cell.textLabel.textColor = [UIColor zitihui];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rect.size.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 50)];
    
    UILabel *label = [CreatView creatWithLabelFrame:CGRectMake(10, 0, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:@"● 交易对手强"];
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
