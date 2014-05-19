/*!
 @header EMChatVideo.h
 @abstract 聊天的视频对象类型
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>
#import "EMChatFile.h"

/*!
 @class 
 @brief 聊天的视频对象类型
 */
@interface EMChatVideo : EMChatFile

/*!
 @property
 @brief 视频对象的时长, 秒为单位
 */
@property (nonatomic) NSInteger duration;

/*!
 @property
 @brief 视频对象的大小
 */
@property (nonatomic) CGSize size;

@end
