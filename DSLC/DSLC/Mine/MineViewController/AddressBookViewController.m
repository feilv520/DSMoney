//
//  AddressBookViewController.m
//  DSLC
//
//  Created by ios on 15/11/16.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "AddressBookViewController.h"
#import "AddressBookCell.h"
#import "InviteNameViewController.h"
#import "AddressBook.h"
#import <AddressBook/AddressBook.h>
#import "NSString+Characters.h"
#import "ChineseString.h"

@interface AddressBookViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    UITableView *_tablView;
    NSArray *letterArr;
    NSMutableArray *nameArr;
    UITextField *_textField;
    UIView *viewGray;
    UIView *viewButton;
    UIButton *butInput;
    UIButton *butBlack;
    UIButton *buttonCancel;
    CFIndex sumPeople;
    
//    中文排序后的数组
    NSMutableArray *sortArray;
    NSMutableArray *letterResultArr;
    
    NSMutableArray *addressArr;
}

@end

@implementation AddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    letterResultArr = [NSMutableArray array];
    sortArray = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"选择朋友"];
    
    [self tableViewShow];
    [self getPhoneNum];
    [self buttonSearchContent];
    [self buttonInviteContent];
    
    
}

- (void)tableViewShow
{
    _tablView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 100) style:UITableViewStyleGrouped];
    [self.view addSubview:_tablView];
    _tablView.dataSource = self;
    _tablView.delegate = self;
    _tablView.backgroundColor = [UIColor whiteColor];
    [_tablView registerNib:[UINib nibWithNibName:@"AddressBookCell" bundle:nil] forCellReuseIdentifier:@"reuse"];
    
    letterArr = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
}

//搜索
- (void)buttonSearchContent
{
    viewGray = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor huibai]];
    [self.view addSubview:viewGray];
    
    viewButton = [CreatView creatViewWithFrame:CGRectMake(10, 10, WIDTH_CONTROLLER_DEFAULT - 20, 30) backgroundColor:[UIColor whiteColor]];
    [viewGray addSubview:viewButton];
    viewButton.layer.cornerRadius = 4;
    viewButton.layer.masksToBounds = YES;
    viewButton.layer.borderWidth = 0.5;
    viewButton.layer.borderColor = [[UIColor colorWithRed:211.0 / 255.0 green:211.0 / 255.0 blue:211.0 / 255.0 alpha:1.0] CGColor];
    
    butInput = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT - 20, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor colorWithRed:190.0 / 225.0 green:191.0 / 225.0 blue:193.0 / 225.0 alpha:1.0] titleText:@" 搜索"];
    [viewButton addSubview:butInput];
    butInput.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [butInput setImage:[UIImage imageNamed:@"iconfont-sousuo"] forState:UIControlStateNormal];
    [butInput setImage:[UIImage imageNamed:@"iconfont-sousuo"] forState:UIControlStateHighlighted];
    [butInput addTarget:self action:@selector(buttonSearchPress:) forControlEvents:UIControlEventTouchUpInside];
}

//邀请新朋友
- (void)buttonInviteContent
{
    UIButton *button = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 50, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] titleText:nil];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonInviteFriend:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *butInvite = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(10, 15, 20, 20) backgroundColor:[UIColor whiteColor] textColor:nil titleText:nil];
    [button addSubview:butInvite];
    [butInvite setBackgroundImage:[UIImage imageNamed:@"iconfont-yaoqinghaoyou"] forState:UIControlStateNormal];
    [butInvite addTarget:self action:@selector(buttonInviteFriend:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonAlert = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(35, 10, WIDTH_CONTROLLER_DEFAULT/2, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] titleText:@"邀请新朋友"];
    [button addSubview:buttonAlert];
    buttonAlert.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    buttonAlert.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    [buttonAlert addTarget:self action:@selector(buttonInviteFriend:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *butRight = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 25, 17, 16, 16) backgroundColor:[UIColor whiteColor] textColor:nil titleText:nil];
    [button addSubview:butRight];
    [butRight setBackgroundImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    [butRight addTarget:self action:@selector(buttonInviteFriend:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewLineUp = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [button addSubview:viewLineUp];
    viewLineUp.alpha = 0.3;
    
    UIView *viewLineDown = [CreatView creatViewWithFrame:CGRectMake(0, 49.5, WIDTH_CONTROLLER_DEFAULT, 0.5) backgroundColor:[UIColor grayColor]];
    [button addSubview:viewLineDown];
    viewLineDown.alpha = 0.3;
}

//获取手机通讯录
- (void)getPhoneNum
{
    ABAddressBookRef addressBooks = nil;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
        
    {
        addressBooks =  ABAddressBookCreateWithOptions(NULL, NULL);
        
        //获取通讯录权限
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error){dispatch_semaphore_signal(sema);});
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
    } else {
        
        addressBooks = ABAddressBookCreate();
    }
    
//    获取通讯录中所有人
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
//    获取通讯录的人数
    sumPeople = ABAddressBookGetPersonCount(addressBooks);
    
    nameArr = [NSMutableArray array];
    
//    循环 获取每个人的个人信息
    for (int i = 0; i < sumPeople; i++) {
        
        AddressBook *addressBook = [[AddressBook alloc] init];
        
//        获取个人
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
//        获取个人名字
        CFTypeRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFTypeRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;
        
        if ((__bridge id)abFullName != nil) {
            nameString = (__bridge NSString *)abFullName;
        } else {
            if ((__bridge id)abLastName != nil)
            {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        addressBook.name = nameString;
        addressBook.recordID = (NSInteger)ABRecordGetRecordID(person);
        
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
            
            if (valuesCount == 0) {
                CFRelease(valuesRef);
                continue;
            }
            
            //获取电话号码
            for (NSInteger k = 0; k < valuesCount; k++) {
                CFTypeRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                switch (j) {
                    case 0: {// Phone number
                        addressBook.phoneNum = (__bridge NSString*)value;
                        break;
                    }
                    
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        
        [nameArr addObject:addressBook];
        NSLog(@"$$$$$$$$$$%@", nameArr);
        
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    sortArray = [ChineseString IndexArray:nameArr];
    return sortArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    letterResultArr = [ChineseString LetterSortArray:nameArr];
    addressArr = [self addWIthPhoneNumber:letterResultArr];
    NSLog(@"addressArr = %@",[[[addressArr objectAtIndex:0] objectAtIndex:0] name]);
    return [[addressArr objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
//    cell.labelName.text = [[letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.labelName.text = [[[letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] name];

    cell.labelName.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    
    cell.labelPhoneNum.text = [[[letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] phoneNum];
    cell.labelPhoneNum.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    cell.labelPhoneNum.textColor = [UIColor zitihui];
    
    [cell.buttonInvite setTitle:@"邀请" forState:UIControlStateNormal];
    [cell.buttonInvite setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
    cell.buttonInvite.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:15];
    cell.buttonInvite.layer.cornerRadius = 3;
    cell.buttonInvite.layer.masksToBounds = YES;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [CreatView creatViewWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, 20) backgroundColor:[UIColor huibai]];
    
    UILabel *labelLetter = [CreatView creatWithLabelFrame:CGRectMake(10, 0, WIDTH_CONTROLLER_DEFAULT - 20, 20) backgroundColor:[UIColor huibai] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft textFont:[UIFont fontWithName:@"CenturyGothic" size:15] text:[sortArray objectAtIndex:section]];
    [view addSubview:labelLetter];
    
    return view;
}

//设置索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
//    修改索引的背景颜色
    tableView.sectionIndexBackgroundColor = [UIColor clearColor];
//    修改索引的字体颜色
    tableView.sectionIndexColor= [UIColor zitihui];
    tableView.sectionIndexMinimumDisplayRowCount = 2;
    return letterArr;
}

//搜索按钮
- (void)buttonSearchPress:(UIButton *)button
{
    butInput.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT - 60, 30);
    butInput.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    butInput.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [butInput setTitle:nil forState:UIControlStateNormal];
    
    buttonCancel = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(viewButton.frame.size.width - 40, 0, 40, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor zitihui] titleText:@"取消"];
    [viewButton addSubview:buttonCancel];
    buttonCancel.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [buttonCancel addTarget:self action:@selector(makeButtonBlackDisappear:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *viewLine = [CreatView creatViewWithFrame:CGRectMake(0, 0, 0.5, 30) backgroundColor:[UIColor colorWithRed:211.0 / 255.0 green:211.0 / 255.0 blue:211.0 / 255.0 alpha:1.0]];
    [buttonCancel addSubview:viewLine];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    butBlack = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(0, 114, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 50 - 20) backgroundColor:[UIColor blackColor] textColor:nil titleText:nil];
    [app.tabBarVC.view addSubview:butBlack];
    butBlack.alpha = 0.3;
    [butBlack addTarget:self action:@selector(makeButtonBlackDisappear:) forControlEvents:UIControlEventTouchUpInside];
    
    _textField = [CreatView creatWithfFrame:CGRectMake(20, 0, butInput.frame.size.width - 25, 30) setPlaceholder:@"搜索" setTintColor:[UIColor grayColor]];
    [butInput addSubview:_textField];
    _textField.delegate = self;
    _textField.returnKeyType = UIReturnKeySearch;
    _textField.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [_textField becomeFirstResponder];
    [_textField addTarget:self action:@selector(searchTextFieldEdit:) forControlEvents:UIControlEventEditingChanged];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (void)searchTextFieldEdit:(UITextField *)textField
{
    
}

//邀请新朋友按钮
- (void)buttonInviteFriend:(UIButton *)button
{
    InviteNameViewController *inviteName = [[InviteNameViewController alloc] init];
    [self.navigationController pushViewController:inviteName animated:YES];
}

//搜索黑色遮罩消失
- (void)makeButtonBlackDisappear:(UIButton *)button
{
    [butBlack removeFromSuperview];
    [buttonCancel removeFromSuperview];
    [_textField removeFromSuperview];
    
    butBlack = nil;
    buttonCancel = nil;
    _textField = nil;
    
    [self.view endEditing:YES];
    
    butInput.frame = CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT - 20, 30);
    [butInput setTitle:@"搜索" forState:UIControlStateNormal];
    butInput.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [butInput setImage:[UIImage imageNamed:@"iconfont-sousuo"] forState:UIControlStateNormal];
    [butInput setImage:[UIImage imageNamed:@"iconfont-sousuo"] forState:UIControlStateHighlighted];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [butBlack removeFromSuperview];
    butBlack = nil;
}

#pragma mark 方法
#pragma mark --------------------

- (NSMutableArray *)addWIthPhoneNumber:(NSMutableArray *)arr{
//    NSLog(@"=-=-=-=-=-=-=-=-%@",arr);
    for (NSInteger i = 0; i < [arr count]; i++) {
        for (NSInteger d = 0; d < [[arr objectAtIndex:i] count]; d++) {
            for (NSInteger j = 0; j < [nameArr count]; j++) {
//                NSLog(@"%@,,%@",[[nameArr objectAtIndex:j] name],[[arr objectAtIndex:i] objectAtIndex:d]);
                if ([[[nameArr objectAtIndex:j] name] isEqualToString:[[arr objectAtIndex:i] objectAtIndex:d]]) {
                    AddressBook *addressB = [[AddressBook alloc] init];
                    [addressB setName:[[arr objectAtIndex:i] objectAtIndex:d]];
                    [addressB setPhoneNum:[[nameArr objectAtIndex:j] phoneNum]];
//                    NSLog(@"-----%@..,,%@",addressB.name,addressB.phoneNum);
                    [[arr objectAtIndex:i] replaceObjectAtIndex:d withObject:addressB];
                    break;
                }
            }
        }
    }
//    NSLog(@"-=-=-=-=-=-%@",arr);
    return arr;
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
