/*!
 @header EMVoiceMessageBody.h
 @abstract 聊天的语音消息体对象类型
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import "EMFileMessageBody.h"

@class EMChatVoice;

/*!
 @class
 @abstract 聊天的语音消息体对象
 */
@interface EMVoiceMessageBody : EMFileMessageBody

/*!
 @property
 @abstract 语音时长, 秒为单位
 */
@property (nonatomic, readonly) NSInteger duration;

/*!
 @method
 @abstract 以语音对象创建语音消息体实例
 @discussion
 @param aChatVoice 语音对象
 @result 语音消息体
 */
- (id)initWithChatObject:(EMChatVoice *)aChatVoice;

@end
