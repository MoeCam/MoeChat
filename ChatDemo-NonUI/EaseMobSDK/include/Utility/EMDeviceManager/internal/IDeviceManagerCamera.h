//
//  IDeviceManagerCamera.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 5/3/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDeviceManagerBase.h"

@protocol IDeviceManagerCamera <IDeviceManagerBase>

@required

#pragma mark - camera support
/**
 check if camera is available.
 @returns boolean to indicate the result.
 @comments result block let users do the future process.
 */
- (BOOL)checkCameraAvailability:(void (^)(BOOL available))result
                        onQueue:(dispatch_queue_t)aQueue;

@end
