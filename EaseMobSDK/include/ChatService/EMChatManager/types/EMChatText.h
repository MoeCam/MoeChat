/*!
 @header EMChatText.h
 @abstract 聊天的文本对象类型
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>
#import "EMChatObject.h"

/*!
 @class 
 @brief 聊天的文本对象类型
 */
@interface EMChatText : EMChatObject

/*!
 @property
 @brief 文本对象的文本内容
 */
@property (nonatomic, strong) NSString *text;

/*!
 @method
 @brief 以字符串构造文本对象
 @discussion 
 @param text 文本内容
 @result 文本对象
 */
- (id)initWithText:(NSString *)text;

@end
