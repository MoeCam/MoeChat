/*!
 @header EMVideoMessageBody.h
 @abstract 聊天的视频消息体对象类型
 @author Ji Fang
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
 @abstract 视频消息体的显示名
 */
@property (nonatomic, readonly) NSString *displayName;

/*!
 @property
 @abstract 视频时长, 秒为单位
 */
@property (nonatomic, readonly) NSInteger duration;

/*!
 @property
 @abstract 视频底层文件本地磁盘路径
 */
@property (nonatomic, readonly) NSString *localPath;

/*!
 @property
 @abstract 视频底层文件服务器远端路径
 */
@property (nonatomic, readonly) NSString *remotePath;

/*!
 @property
 @abstract 视频底层文件大小, 以字节为单位
 */
@property (nonatomic, readonly) long long fileLength;

/*!
 @property
 @abstract 视频对象
 */
@property (nonatomic, readonly) EMChatVideo *video;

/*!
 @method
 @abstract 以视频对象创建视频消息体实例
 @discussion 视频部分目前不支持
 @param message 视频对象
 @result 视频消息体
 */
- (id)initWithMessage:(EMChatVideo *)message;

@end
