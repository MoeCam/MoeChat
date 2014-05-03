/*!
 @header EMVoiceMessageBody.h
 @abstract 聊天的语音消息体对象类型
 @author Ji Fang
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
 @abstract 语音消息体的显示名
 */
@property (nonatomic, readonly) NSString *displayName;

/*!
 @property
 @abstract 语音时长, 秒为单位
 */
@property (nonatomic, readonly) NSInteger duration;

/*!
 @property
 @abstract 语音底层文件本地磁盘路径
 */
@property (nonatomic, readonly) NSString *localPath;

/*!
 @property
 @abstract 语音底层文件服务器远端路径
 */
@property (nonatomic, readonly) NSString *remotePath;

/*!
 @property
 @abstract 语音底层文件大小, 以字节为单位
 */
@property (nonatomic, readonly) long long fileLength;

/*!
 @property
 @abstract 语音对象
 */
@property (nonatomic, readonly) EMChatVoice *voice;

/*!
 @method
 @abstract 以语音对象创建语音消息体实例
 @discussion
 @param message 语音对象
 @result 语音消息体
 */
- (id)initWithMessage:(EMChatVoice *)message;

@end
