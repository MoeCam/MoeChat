/*!
 @header EMImageMessageBody.h
 @abstract 聊天的图片消息体对象类型
 @author Ji Fang
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import "EMFileMessageBody.h"
#import <CoreGraphics/CGGeometry.h>

@class EMChatImage;

/*!
 @class
 @abstract 聊天的图片消息体对象
 */
@interface EMImageMessageBody : EMFileMessageBody {
}

/*!
 @property
 @abstract 图片消息体中的预览图的显示名
 */
@property (nonatomic, readonly) NSString *thumbnailDisplayName;

/*!
 @property
 @abstract 图片消息体中的预览图文件的本地路径
 */
@property (nonatomic, readonly) NSString *thumbnailLocalPath;

/*!
 @property
 @abstract 图片消息体中的预览图文件的服务器远程路径
 */
@property (nonatomic, readonly) NSString *thumbnailRemotePath;

/*!
 @property
 @abstract 图片消息体中的预览图的尺寸
 */
@property (nonatomic, readonly) CGSize thumbnailSize;

/*!
 @property
 @abstract 图片消息体中的预览图文件的大小, 以字节为单位
 */
@property (nonatomic, readonly) long long thumbnailFileLength;

/*!
 @property
 @abstract 图片消息体中的大图的显示名
 */
@property (nonatomic, readonly) NSString *displayName;

/*!
 @property
 @abstract 图片消息体中的大图文件的本地路径
 */
@property (nonatomic, readonly) NSString *localPath;

/*!
 @property
 @abstract 图片消息体中的大图文件的服务器远程路径
 */
@property (nonatomic, readonly) NSString *remotePath;

/*!
 @property
 @abstract 图片消息体中的大图的尺寸
 */
@property (nonatomic, readonly) CGSize size;

/*!
 @property
 @abstract 图片消息体中的大图文件的大小, 以字节为单位
 */
@property (nonatomic, readonly) long long fileLength;

/*!
 @property
 @abstract 图片消息体中的大图对象
 */
@property (nonatomic, readonly, strong) EMChatImage *image;

/*!
 @property
 @abstract 图片消息体中的预览图对象
 */
@property (nonatomic, readonly, strong) EMChatImage *thumbnailImage;

/*!
 @method
 @abstract 以图片对象创建图片消息体
 @discussion 如果预览图对象为空或与大图为同一实例, 则会自动创建预览图对象
 @param aImage 大图对应的图片对象
 @param aThumbnialImage 预览图图对应的图片对象
 @result 图片消息体
 */
- (id)initWithImage:(EMChatImage *)aImage thumbnailImage:(EMChatImage *)aThumbnialImage;

@end
