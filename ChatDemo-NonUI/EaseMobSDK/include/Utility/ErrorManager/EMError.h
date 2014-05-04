//
//  EMError.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 12/30/13.
//  Copyright (c) 2013 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMError : NSObject

@property (nonatomic) NSInteger errorCode;
@property (nonatomic, copy) NSString *description;

+ (EMError *)errorWithCode:(NSInteger)errCode 
           andDescription:(NSString *)description;

+ (EMError *)errorWithNSError:(NSError *)error;

@end
