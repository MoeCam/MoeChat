//
//  NSArray+Search.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 8/23/13.
//  Copyright (c) 2013 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NSArraySearchableItem <NSObject>
- (NSString *)stringValue;
@end

@interface NSArray (Search)

+(NSArray *)searchInArray:(NSArray *)array
                byCritera:(NSString *)searchCritera
               countLimit:(long long)countLimit;

-(NSArray *)searchByCritera:(NSString *)searchCritera
                 countLimit:(long long)countLimit;
@end
