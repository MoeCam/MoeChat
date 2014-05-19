/*!
 @header EMFileMessageBody.h
 @abstract 聊天的文件消息体对象类型
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import "EMMessageBody.h"

@class EMChatFile;

/*!
 @class
 @brief 聊天的文件消息体对象
 */
@interface EMFileMessageBody : EMMessageBody

/*!
 @property
 @brief 文件消息体的显示名
 */
@property (nonatomic, readonly) NSString *displayName;

/*!
 @property
 @brief 文件消息体的本地文件路径
 */
@property (nonatomic, readonly) NSString *localPath;

/*!
 @property
 @brief 文件消息体的服务器远程文件路径
 */
@property (nonatomic, copy) NSString *remotePath;

/*!
 @property
 @brief 文件消息体的文件长度, 以字节为单位
 */
@property (nonatomic, readonly) long long fileLength;

/*!
 @method
 @brief 以文件对象创建文件消息体实例
 @discussion
 @param aChatFile 文件对象
 @result 文件消息体
 */
- (id)initWithChatObject:(EMChatFile *)aChatFile;

/*!
 @method
 @brief
    由字典创建消息体对象
 @discussion
    派生类需要改写此方法,此方法用于从远端发来的消息来构建消息体对象
 @param aBodyDict
    消息体对象字典
 @param aMessageDict
    消息对象字典
 @result
    消息体对象
 */
- (id)initWithBodyDict:(NSDictionary *)aBodyDict messageDict:(NSDictionary *)aMessageDict;

/*!
 @method
 @brief
    需要在派生类中改写.initWithBodyDict:messageDict:会调到此函数
 @param filename
    文件全路径
 @param displayName
    文件显示名
 @param fileLength
    文件长度
 @result
    文件对象
 */
- (EMChatFile *)createChatFileWithFile:(NSString *)filename
                            displayName:(NSString *)displayName
                             fileLength:(long long)fileLength;

/*!
 @method
 @brief
    将文件消息体转为字典对象
 @discussion
    此方法用于发送消息过程中
 @result
    带有文件消息体信息的字典对象
 */
- (NSDictionary *)toDictionary;

@end
