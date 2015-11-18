//
//  NSString+Characters.h
//  AddressBook
//
//  Created by lzhr on 13/5/22.
//  Copyright (c) 2014年 www.lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Characters)

//讲汉字转换为拼音
- (NSString *)pinyinOfName;

//汉字转换为拼音后，返回大写的首字母
- (NSString *)firstCharacterOfName;

@end
