//
//  MessageDetailViewController.h
//  DSLC
//
//  Created by 马成铭 on 15/10/19.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import "BaseViewController.h"

@interface MessageDetailViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) NSString *textString;

@property (nonatomic, copy) NSString *idString;

@end
