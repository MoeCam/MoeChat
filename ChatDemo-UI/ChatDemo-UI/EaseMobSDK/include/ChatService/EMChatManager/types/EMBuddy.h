//
//  EMBuddy.h
//  EaseMobClientSDK
//
//  Created by Li Zhiping on 14-5-3.
//  Copyright (c) 2014年 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMBuddy : NSObject

+ (instancetype)buddyWithUsername:(NSString *)username;

@property (copy, nonatomic, readonly)NSString *username;

@end
