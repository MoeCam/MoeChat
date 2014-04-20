//
//  EMDBManagerBase.h
//  EaseMobClientSDK
//
//  Created by jifang on 3/6/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSManagedObjectContext;
@interface EMDBManager : NSObject

@property (nonatomic, readonly) NSManagedObjectContext *sdkContext;

#pragma mark - singleton methods
+(EMDBManager *)sharedInstance;

-(void)save;

@end
