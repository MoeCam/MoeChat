/*!
 @header EMChatText.h
 @abstract 聊天的文本对象类型
 @author Ji Fang
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>
#import "EMChatObject.h"

/*!
 @class 
 @abstract 聊天的文本对象类型
 */
@interface EMChatText : EMChatObject

/*!
 @property
 @abstract 文本对象的文本内容
 */
@property (nonatomic, copy) NSString *text;

/*!
 @method
 @abstract 以字符串构造文本对象
 @discussion 
 @param text 文本内容
 @result 文本对象
 */
- (id)initWithText:(NSString *)text;

@end
