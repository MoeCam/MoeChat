/*!
 @header EMChatImage.h
 @abstract 聊天的图片对象类型
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>
#import "EMChatFile.h"

@class UIImage;

/*!
 @class 
 @brief 聊天的图片对象类型
 */
@interface EMChatImage : EMChatFile

/*!
 @property
 @brief 图片对象尺寸
 */
@property (nonatomic) CGSize size;

/*!
 @method
 @brief 以UIImage构造图片对象
 @discussion 
 @param aImage UIImage实例
 @param aDisplayName 图片对象的显示名
 @result 图片对象
 */
- (id)initWithUIImage:(UIImage *)aImage displayName:(NSString *)aDisplayName;

@end
