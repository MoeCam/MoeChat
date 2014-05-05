//
//  DeviceManager+Camera.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 1/30/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import "DeviceManagerBase.h"

@interface DeviceManager (Camera)

#pragma mark - camera support
/**
 check if camera is available.
 @returns boolean to indicate the result.
 @comments result block let users do the future process.
 */
- (BOOL)checkCameraAvailability:(void (^)(BOOL available))result
                       onQueue:(dispatch_queue_t)aQueue;

@end
