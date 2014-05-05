/*!
 @header EMChatLocation.h
 @abstract 聊天的位置对象类型
 @author Ji Fang
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>
#import "EMChatObject.h"

@class CLLocation;

/*!
 @class 
 @abstract 聊天的位置对象类型
 */
@interface EMChatLocation : EMChatObject

/*!
 @property
 @abstract 纬度
 */
@property (nonatomic) double latitude;

/*!
 @property
 @abstract 经度
 */
@property (nonatomic) double longitude;

/*!
 @property
 @abstract 地址信息
 */
@property (nonatomic, copy) NSString *address;

/*!
 @property
 @abstract CLLocation位置信息
 */
@property (nonatomic, strong) CLLocation *location;

/*!
 @method
 @abstract 以位置信息构造位置对象
 @discussion 
 @param latitude 纬度
 @param longitude 经度
 @param address 地址信息
 @result 位置对象
 */
- (id)initWithLatitude:(double)latitude 
            longitude:(double)longitude 
              address:(NSString *)address;

/*!
 @method
 @abstract 以CLLocation构造位置对象
 @discussion 
 @param location CLLocation实例
 @result 位置对象
 */
- (id)initWithCLLocation:(CLLocation *)location;

@end
