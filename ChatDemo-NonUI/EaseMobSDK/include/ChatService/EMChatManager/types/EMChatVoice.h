/*!
 @header EMChatVoice.h
 @abstract 聊天的语音对象类型
 @author Ji Fang
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>
#import "EMChatFile.h"

/*!
 @class
 @abstract 聊天的语音对象类型
 */
@interface EMChatVoice : EMChatFile {
}

/*!
 @property
 @abstract 语音的时长, 单位是秒
 */
@property (nonatomic) NSInteger duration;

/*!
 @method
 @abstract 以NSData构造语音对象
 @discussion
 @param aVoice NSData实例
 @param aDisplayName 语音对象的显示名
 @result 语音对象
 */
- (id)initWithVoice:(NSData *)aVoice displayName:(NSString *)aDisplayName;

/*!
 @method
 @abstract 以文件路径构造语音对象
 @discussion
 @param voiceFile 磁盘文件全路径
 @param aDisplayName 语音对象的显示名
 @result 语音对象
 */
- (id)initWithFile:(NSString *)voiceFile displayName:(NSString *)aDisplayName;

@end
