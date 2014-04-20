//
//  NSArray+Reverse.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 8/13/13.
//  Copyright (c) 2013 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Reverse)

- (NSArray *)reversedArray;
- (NSString *)toStringWithDelimeter:(NSString *)delimeter;

@end

@interface NSMutableArray (Reverse)

- (void)reverse;

@end