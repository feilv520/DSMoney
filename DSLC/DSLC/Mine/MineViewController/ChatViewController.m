//
//  ChatViewController.m
//  DSLC
//
//  Created by ios on 15/11/17.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatLeftCell.h"
#import "ChatRightCell.h"

@interface ChatViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

{
    UITableView *_tableView;
    
    UIView *viewImport;
    UITextField *_textField;
    UIButton *buttonSend;
    CGFloat keyboardhight;
    
    NSMutableArray *leftArray;
    NSMutableArray *rightArray;
    
    CGRect rect;
    
    NSInteger i ;
}

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    leftArray = [NSMutableArray arrayWithObjects:
                 @"你最近好吗",
                 @"你是我的小呀小苹果,怎么爱你都不嫌多,红红的小脸照进我的心窝",
                 @"加入中国银行业协会,成为中国银行业协会正式会员,东兴证券股份有限公司...加入中国银行业协会,成为中国银行业协会正式会员,东兴证券股份有限公司...加入中国银行业协会,成为中国银行业协会正式会员,东兴证券股份有限公司...加入中国银行业协会,成为中国银行业协会正式会员,东兴证券股份有限公司...",
                 @"明天我不迟到呀不迟到",
                 @"喔喔",
                 @"这是一个柚子, 好吃的柚子",
                 @"好好学习,天天向上",
                 @"非常好",
                 @"尊敬的用户,您的电话已欠费,情绪交话费,谢谢!",
                 @"太阳当空照,花儿对我笑,小鸟说早早早,你为什么背上小书包,我要炸学校,天天不迟到,爱学习,爱劳动,长大要为人民立功劳", nil];
    rightArray = [NSMutableArray arrayWithObjects:@"好好学习,天天向上", @"非常好", @"尊敬的用户,您的电话已欠费,情绪交话费,谢谢!", @"太阳当空照,花儿对我笑,小鸟说早早早,你为什么背上小书包,我要炸学校,天天不迟到,爱学习,爱劳动,长大要为人民立功劳", nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationItem setTitle:@"咨询理财师"];
    
    i = 0;
    
    [self importWindow];
    [self registerForKeyboardNotifications];
    [self tableViewShow];
}

- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 键盘出现时
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
}

//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification *)aNotification
{
    NSDictionary *info = [aNotification userInfo];
    
//     keyboardSize为键盘尺寸 (有width, height)
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到键盘的高度
    
    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        viewImport.frame = CGRectMake(0, self.view.frame.size.height - keyboardSize.height + 14, WIDTH_CONTROLLER_DEFAULT, 50);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)tableViewShow
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_CONTROLLER_DEFAULT, HEIGHT_CONTROLLER_DEFAULT - 64 - 20 - 50) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_tableView registerNib:[UINib nibWithNibName:@"ChatLeftCell" bundle:nil] forCellReuseIdentifier:@"reuseLeft"];
    [_tableView registerNib:[UINib nibWithNibName:@"ChatRightCell" bundle:nil] forCellReuseIdentifier:@"reuseRight"];
}

//输入窗口
- (void)importWindow
{
    viewImport = [CreatView creatViewWithFrame:CGRectMake(0, self.view.frame.size.height - 50, WIDTH_CONTROLLER_DEFAULT, 50) backgroundColor:[UIColor whiteColor]];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    [app.tabBarVC.view addSubview:viewImport];
    
    _textField = [CreatView creatWithfFrame:CGRectMake(15, 10, WIDTH_CONTROLLER_DEFAULT - 100, 30) setPlaceholder:nil setTintColor:[UIColor grayColor]];
    [viewImport addSubview:_textField];
    _textField.font = [UIFont fontWithName:@"CenturyGothic" size:13];
    _textField.delegate = self;
    _textField.layer.cornerRadius = 5;
    _textField.layer.masksToBounds = YES;
    _textField.layer.borderWidth = 0.5;
    _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.layer.borderColor = [[UIColor grayColor] CGColor];
    [_textField addTarget:self action:@selector(textFieldImportContent:) forControlEvents:UIControlEventEditingChanged];
    
    buttonSend = [CreatView creatWithButtonType:UIButtonTypeCustom frame:CGRectMake(WIDTH_CONTROLLER_DEFAULT - 15 - 60, 10, 60, 30) backgroundColor:[UIColor whiteColor] textColor:[UIColor whiteColor] titleText:@"发送"];
    [viewImport addSubview:buttonSend];
    buttonSend.titleLabel.font = [UIFont fontWithName:@"CenturyGothic" size:14];
    [buttonSend setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    [buttonSend setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    buttonSend.layer.cornerRadius = 5;
    buttonSend.layer.masksToBounds = YES;
}

//textField绑定的点击方法
- (void)textFieldImportContent:(UITextField *)textField
{
    if (textField.text.length > 0) {
        
        [buttonSend setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateNormal];
        [buttonSend setBackgroundImage:[UIImage imageNamed:@"btn_red"] forState:UIControlStateHighlighted];
        
    } else {
        
        [buttonSend setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        [buttonSend setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateHighlighted];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatLeftCell *cell = (ChatLeftCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%ld",leftArray.count);
    return leftArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
        
        ChatLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseLeft"];
        
        cell.imageLeft.image = [UIImage imageNamed:@"left"];
        cell.imageLeft.backgroundColor = [UIColor clearColor];
        
        cell.labelLeft.text = [leftArray objectAtIndex:(i++ % 5)];
        cell.labelLeft.backgroundColor = [UIColor greenColor];
        cell.labelLeft.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        cell.labelLeft.textColor = [UIColor zitihui];
        cell.labelLeft.numberOfLines = 0;
        
        CGFloat widthLeft = cell.labelLeft.text.length * 13;
        NSLog(@"拉拉%f", widthLeft);
//        NSLog(@"eeeeeeeeeeee%f", cell.labelLeft.frame.size.height);
        
        if (widthLeft > 273) {
            
            widthLeft = 273;
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"CenturyGothic" size:13], NSFontAttributeName, nil];
            rect = [cell.labelLeft.text boundingRectWithSize:CGSizeMake(273, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
            cell.labelLeft.frame = CGRectMake(90, 10, widthLeft, rect.size.height);
            cell.frame = CGRectMake(90, 10, widthLeft, rect.size.height);
//            NSLog(@"hhhhhhhhhh%f", rect.size.height);
        }
        
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        
        ChatRightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseRight"];
        
        cell.imageRight.image = [UIImage imageNamed:@"right"];
        cell.imageRight.backgroundColor = [UIColor clearColor];
        
        cell.labelRight.text = [leftArray objectAtIndex:indexPath.row / 2];
        cell.labelRight.backgroundColor = [UIColor magentaColor];
        cell.labelRight.font = [UIFont fontWithName:@"CenturyGothic" size:13];
        cell.labelRight.textColor = [UIColor whiteColor];
        cell.labelRight.numberOfLines = 0;
        
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

//label自适应高度
- (void)labelHeight:(UILabel *)label
{
    
}

//回收键盘
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > 0) {
        
        [_textField resignFirstResponder];//键盘回收
        
        [UIView animateWithDuration:0.001 animations:^{
            
            viewImport.frame = CGRectMake(0, HEIGHT_CONTROLLER_DEFAULT - 20 - 50, WIDTH_CONTROLLER_DEFAULT, 50);
        }];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [viewImport removeFromSuperview];
    viewImport = nil;
    
    [self.view endEditing:YES];
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
