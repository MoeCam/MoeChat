/*!
 @header EMChatVideo.h
 @abstract 聊天的视频对象类型
 @author Ji Fang
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>
#import "EMChatFile.h"

/*!
 @class 
 @abstract 聊天的视频对象类型
 */
@interface EMChatVideo : EMChatFile

/*!
 @property
 @abstract 视频对象的显示名
 */
@property (nonatomic, copy) NSString *displayName;

/*!
 @property
 @abstract 视频对象的时长, 秒为单位
 */
@property (nonatomic) NSInteger duration;

/*!
 @property
 @abstract 视频对象的文件本地路径
 */
@property (nonatomic, copy) NSString *localPath;

/*!
 @property
 @abstract 视频对象的文件远程路径
 */
@property (nonatomic, copy) NSString *remotePath;

/*!
 @property
 @abstract 视频对象的原始数据
 */
@property (nonatomic, strong) NSData *video;

/*!
 @method
 @abstract 以NSData构造视频对象
 @discussion 当前尚未支持视频
 @param aVideo NSData实例
 @param aDisplayName 视频对象的显示名
 @result 视频对象
 */
- (id)initWithVideo:(NSData *)aVideo displayName:(NSString *)aDisplayName;

/*!
 @method
 @abstract 以文件路径构造视频对象
 @discussion 当前尚未支持视频
 @param videoFile 磁盘文件全路径
 @param aDisplayName 视频对象的显示名
 @result 视频对象
 */
- (id)initWithFile:(NSString *)videoFile displayName:(NSString *)aDisplayName;

@end
