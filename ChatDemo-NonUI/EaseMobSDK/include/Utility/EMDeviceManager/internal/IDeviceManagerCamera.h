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

/*!
 @method
 @abstract check if camera is available.
 @return boolean to indicate the result.
 */
- (BOOL)checkCameraAvailability;

@end
