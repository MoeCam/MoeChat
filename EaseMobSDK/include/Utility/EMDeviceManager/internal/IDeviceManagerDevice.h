/*!
 @header IDeviceManagerDevice.h
 @abstract 设备相关协议
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */
#import <Foundation/Foundation.h>
#import "IDeviceManagerBase.h"

/*!
 @protocol
 @abstract 设备相关协议
 @discussion
 */
@protocol IDeviceManagerDevice <IDeviceManagerBase>

@required

#pragma mark - device version

/*!
 @property
 @abstract 当前系统的版本号(eg: 7.0)
 */
@property (nonatomic, readonly) float deviceVersion;

/*!
 @property
 @abstract 当前设备的唯一标识
 */
@property (nonatomic, readonly) NSString *uniqueId;

/*!
 @property
 @abstract
 */
@property (nonatomic, readonly) NSString *compactUniqueId;

@end
