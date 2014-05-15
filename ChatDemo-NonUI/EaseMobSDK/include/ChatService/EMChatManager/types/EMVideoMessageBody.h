/*!
 @header EMVideoMessageBody.h
 @abstract 聊天的视频消息体对象类型
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import "EMFileMessageBody.h"

@class EMChatVideo;

/*!
 @class
 @abstract 聊天的视频消息体对象
 */
@interface EMVideoMessageBody : EMFileMessageBody

/*!
 @property
 @abstract 视频时长, 秒为单位
 */
@property (nonatomic, readonly) NSInteger duration;

/*!
 @property
 @abstract 视频大小
 */
@property (nonatomic, readonly) CGSize size;

/*!
 @method
 @abstract 以视频对象创建视频消息体实例
 @discussion 视频部分目前不支持
 @param aChatVideo 视频对象
 @result 视频消息体
 */
- (id)initWithChatObject:(EMChatVideo *)aChatVideo;

@end
