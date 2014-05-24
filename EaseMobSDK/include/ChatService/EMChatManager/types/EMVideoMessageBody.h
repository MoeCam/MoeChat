/*!
 @header EMVideoMessageBody.h
 @abstract 聊天的视频消息体对象类型
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>
#import "IEMFileMessageBody.h"
#import "EMChatServiceDefs.h"

@class EMChatVideo;
@protocol IEMChatObject;
@class EMMessage;

/*!
 @class
 @brief 聊天的视频消息体对象
 */
@interface EMVideoMessageBody : NSObject<IEMFileMessageBody>

/*!
 @property
 @brief 消息体的类型
 */
@property (nonatomic, readonly) MessageBodyType messageBodyType;

/*!
 @property
 @brief 消息体的底层聊天对象
 */
@property (nonatomic, strong, readonly) id<IEMChatObject> chatObject;

/*!
 @property
 @brief 消息体所在的消息对象
 */
@property (nonatomic, weak) EMMessage *message;

/*!
 @property
 @brief 文件消息体的显示名
 */
@property (nonatomic, strong) NSString *displayName;

/*!
 @property
 @brief 文件消息体的本地文件路径
 */
@property (nonatomic, strong) NSString *localPath;

/*!
 @property
 @brief 文件消息体的服务器远程文件路径
 */
@property (nonatomic, strong) NSString *remotePath;

/*!
 @property
 @brief 文件消息体的文件长度, 以字节为单位
 */
@property (nonatomic) long long fileLength;

/*!
 @property
 @brief 视频时长, 秒为单位
 */
@property (nonatomic) NSInteger duration;

/*!
 @property
 @brief 视频大小
 */
@property (nonatomic) CGSize size;

/*!
 @method
 @brief 以视频对象创建视频消息体实例
 @discussion 视频部分目前不支持
 @param aChatVideo 视频对象
 @result 视频消息体
 */
- (id)initWithChatObject:(EMChatVideo *)aChatVideo;

@end
