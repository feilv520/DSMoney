//
//  TextTableViewCell.h
//  DSLC
//
//  Created by 马成铭 on 15/11/2.
//  Copyright © 2015年 马成铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *introduction;

-(void)setIntroductionText:(NSString*)text;

@end
