//
//  WinAPrizeViewController.m
//  DSLC
//
//  Created by ios on 15/10/19.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "WinAPrizeViewController.h"
#import "define.h"
#import "WinAPrizeCell.h"
#import "UIColor+AddColor.h"
#import "MoreActivityCell.h"

@interface WinAPrizeViewController () <UITableViewDataSource, UITableViewDelegate>

{
    UITableView *_tableView;
    NSArray *picArr;
}

@end

@implementation WinAPrizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor greenColor];
    
    [self tableViewShow];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor huibai];
    
    UIView *viewFoot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 10)];
    _tableView.tableFooterView = viewFoot;
    
    [_tableView registerNib:[UINib nibWithNibName:@"MoreActivityCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    [_tableView registerNib:[UINib nibWithNibName:@"WinAPrizeCell" bundle:nil] forCellReuseIdentifier:@"reuse1"];
    
    picArr = @[@[@"computer0"], @[@"computer1"], @[@"computer1"], @[@"computer3"]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 11;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return HEIGHT_CONTROLLER_DEFAULT * (50.0 / 667.0);
        
    } else {
        
        return HEIGHT_CONTROLLER_DEFAULT * (72.0 / 667.0);
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        MoreActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        
        if (cell == nil) {
            
            cell = [[MoreActivityCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
        }
        
        cell.labelMore.text = @"更多活动";
        cell.labelMore.font = [UIFont systemFontOfSize:15];
        
        cell.imageRight.image = [UIImage imageNamed:@"arrow"];
        
        return cell;
        
    } else {
        
        WinAPrizeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse1"];
        
        if (cell == nil) {
            
            cell = [[WinAPrizeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse1"];
        }
        
        NSArray *imageArr = [picArr objectAtIndex:indexPath.section - 1];
        cell.imageViewPic.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [imageArr objectAtIndex:indexPath.row]]];
        
        cell.labelFestival.text = @"春节全民大派送";
        cell.labelFestival.font = [UIFont systemFontOfSize:14];
        
        cell.labelComputer.text = @"MacbookAir一台";
        cell.labelComputer.textColor = [UIColor zitihui];
        cell.labelComputer.font = [UIFont systemFontOfSize:13];
        
        cell.labelTime.text = @"2015-09-09 09:11";
        cell.labelTime.font = [UIFont fontWithName:@"CenturyGothic" size:12];
        cell.labelTime.textColor = [UIColor zitihui];
        cell.labelTime.textAlignment = NSTextAlignmentRight;
        
        return cell;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
