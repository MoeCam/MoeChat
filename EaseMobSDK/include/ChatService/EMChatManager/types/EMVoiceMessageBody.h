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
 @brief 聊天的语音消息体对象
 */
@interface EMVoiceMessageBody : EMFileMessageBody

/*!
 @property
 @brief 语音时长, 秒为单位
 */
@property (nonatomic, readonly) NSInteger duration;

/*!
 @method
 @brief 以语音对象创建语音消息体实例
 @discussion
 @param aChatVoice 语音对象
 @result 语音消息体
 */
- (id)initWithChatObject:(EMChatVoice *)aChatVoice;

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
    语音对象
 */
- (EMChatVoice *)createChatFileWithFile:(NSString *)filename
                            displayName:(NSString *)displayName
                             fileLength:(long long)fileLength;

/*!
 @method
 @brief
    将语音消息体转为字典对象
 @discussion
    此方法用于发送消息过程中
 @result
    带有语音消息体信息的字典对象
 */
- (NSDictionary *)toDictionary;

@end
