/*!
 @header EMImageMessageBody.h
 @abstract 聊天的图片消息体对象类型
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import "EMFileMessageBody.h"
#import <CoreGraphics/CGGeometry.h>

@class EMChatImage;

/*!
 @class
 @brief 聊天的图片消息体对象
 */
@interface EMImageMessageBody : EMFileMessageBody 

/*!
 @property
 @brief 图片消息体中的预览图的显示名
 */
@property (nonatomic, readonly) NSString *thumbnailDisplayName;

/*!
 @property
 @brief 图片消息体中的预览图文件的本地路径
 */
@property (nonatomic, readonly) NSString *thumbnailLocalPath;

/*!
 @property
 @brief 图片消息体中的预览图文件的服务器远程路径
 */
@property (nonatomic, copy) NSString *thumbnailRemotePath;

/*!
 @property
 @brief 图片消息体中的预览图的尺寸
 */
@property (nonatomic, readonly) CGSize thumbnailSize;

/*!
 @property
 @brief 图片消息体中的预览图文件的大小, 以字节为单位
 */
@property (nonatomic, readonly) long long thumbnailFileLength;

/*!
 @property
 @brief 图片消息体中的大图的显示名
 */
@property (nonatomic, readonly) NSString *displayName;

/*!
 @property
 @brief 图片消息体中的大图文件的本地路径
 */
@property (nonatomic, readonly) NSString *localPath;

/*!
 @property
 @brief 图片消息体中的大图的尺寸
 */
@property (nonatomic, readonly) CGSize size;

/*!
 @property
 @brief 图片消息体中的大图文件的大小, 以字节为单位
 */
@property (nonatomic, readonly) long long fileLength;

/*!
 @property
 @brief 图片消息体中的大图对象
 */
@property (nonatomic, readonly, strong) EMChatImage *image;

/*!
 @property
 @brief 图片消息体中的预览图对象
 */
@property (nonatomic, readonly, strong) EMChatImage *thumbnailImage;

/*!
 @method
 @brief 以图片对象创建图片消息体
 @discussion 如果预览图对象为空或与大图为同一实例, 则会自动创建预览图对象
 @param aImage 大图对应的图片对象
 @param aThumbnialImage 预览图图对应的图片对象
 @result 图片消息体
 */
- (id)initWithImage:(EMChatImage *)aImage thumbnailImage:(EMChatImage *)aThumbnialImage;

/*!
 @method
 @brief 以图片对象创建图片消息体
 @discussion 会自动创建预览图对象
 @param aChatObject 大图对应的图片对象
 @result 图片消息体
 */
- (id)initWithChatObject:(EMChatImage *)aChatObject;

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
    继承自EMFileMessageBody, 需要在派生类中改写. initWithBodyDict:messageDict:会调到此函数
 @param filename    
    文件全路径
 @param displayName 
    文件显示名
 @param fileLength  
    文件长度
 @result
    图片对象
 */
- (EMChatImage *)createChatFileWithFile:(NSString *)filename
                            displayName:(NSString *)displayName
                             fileLength:(long long)fileLength;

/*!
 @method
 @brief
    将图片消息体转为字典对象
 @discussion
    此方法用于发送消息过程中
 @result
    带有图片消息体信息的字典对象
 */
- (NSDictionary *)toDictionary;

@end
