//
//  NSString+decoration.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 8/14/13.
//  Copyright (c) 2013 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (decoration)

-(NSString *)trimLeft:(NSString *)string;
-(NSString *)trimRight:(NSString *)string;
-(NSString *)trim:(NSString *)string;

-(BOOL)isBlank;
-(BOOL)contains:(NSString *)string;
-(NSArray *)splitOnChar:(char)ch;
-(NSArray *)splitByDelimeter:(NSString *)delimeter;
-(NSString *)substringFrom:(NSInteger)from to:(NSInteger)to;
-(NSString *)stringByStrippingWhitespace;

@end
