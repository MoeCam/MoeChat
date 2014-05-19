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
 @brief 聊天的视频消息体对象
 */
@interface EMVideoMessageBody : EMFileMessageBody

/*!
 @property
 @brief 视频时长, 秒为单位
 */
@property (nonatomic, readonly) NSInteger duration;

/*!
 @property
 @brief 视频大小
 */
@property (nonatomic, readonly) CGSize size;

/*!
 @method
 @brief 以视频对象创建视频消息体实例
 @discussion 视频部分目前不支持
 @param aChatVideo 视频对象
 @result 视频消息体
 */
- (id)initWithChatObject:(EMChatVideo *)aChatVideo;

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
    继承自EMFileMessageBody, 需要在派生类中改写.initWithBodyDict:messageDict:会调到此函数
 @param filename
    文件全路径
 @param displayName
    文件显示名
 @param fileLength
    文件长度
 @result
    视频对象
 */
- (EMChatVideo *)createChatFileWithFile:(NSString *)filename
                           displayName:(NSString *)displayName
                            fileLength:(long long)fileLength;

/*!
 @method
 @brief
    将视频消息体转为字典对象
 @discussion
    此方法用于发送消息过程中
 @result
    带有视频消息体信息的字典对象
 */
- (NSDictionary *)toDictionary;

@end
