//
//  NSString+Valid.m
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-7-13.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import "NSString+Valid.h"

@implementation NSString (Valid)
+(BOOL)isChinese:(NSString *)str{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:str];
}
@end
