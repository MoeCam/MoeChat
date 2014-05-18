/*!
 @header EMChatVoice.h
 @abstract 聊天的语音对象类型
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>
#import "EMChatFile.h"

/*!
 @class
 @abstract 聊天的语音对象类型
 */
@interface EMChatVoice : EMChatFile 

/*!
 @property
 @abstract 语音的时长, 单位是秒
 */
@property (nonatomic) NSInteger duration;

@end
