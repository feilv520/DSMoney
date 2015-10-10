//
//  FDetailViewController.m
//  DSLC
//
//  Created by ios on 15/10/10.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "FDetailViewController.h"
#import "define.h"
#import "FixInvestCell.h"
#import "BasicMessageCell.h"
#import "PlanCell.h"
#import "ThreeCell.h"

@interface FDetailViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation FDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"产品详情";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self showTableView];
}

- (void)showTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 53) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerNib:[UINib nibWithNibName:@"FixInvestCell" bundle:nil] forCellReuseIdentifier:@"reuse1"];
    [_tableView registerNib:[UINib nibWithNibName:@"BasicMessageCell" bundle:nil] forCellReuseIdentifier:@"reuse2"];
    [_tableView registerNib:[UINib nibWithNibName:@"PlanCell" bundle:nil] forCellReuseIdentifier:@"reuse3"];
    [_tableView registerNib:[UINib nibWithNibName:@"ThreeCell" bundle:nil] forCellReuseIdentifier:@"reuse4"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        
        return 53;
        
    } else {
        
        return 11;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        FixInvestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse1"];
        if (cell == nil) {
            
            cell = [[FixInvestCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse1"];
        }
        return cell;
        
    } else if (indexPath.section == 1) {
        
        BasicMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse2"];
        
        if (cell == nil) {
            
            cell = [[BasicMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse2"];
        }
        return cell;
        
    } else if (indexPath.section == 2) {
        
        PlanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse3"];
        
        if (cell == nil) {
            
            cell = [[PlanCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse3"];
        }
        return cell;
    }
        
    ThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse4"];
    
    if (cell == nil) {
        
        cell = [[ThreeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse4"];
    }
    return cell;

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
