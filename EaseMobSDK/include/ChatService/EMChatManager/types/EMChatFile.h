/*!
 @header EMChatFile.h
 @abstract 聊天的文件对象类型
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>
#import "EMChatObject.h"

/*!
 @class 
 @abstract 聊天的文件对象类型
 */
@interface EMChatFile : EMChatObject 

/*!
 @property
 @abstract 文件对象的显示名
 */
@property (nonatomic, copy, readonly) NSString *displayName;

/*!
 @property
 @abstract 文件对象本地磁盘位置的全路径
 */
@property (nonatomic, copy) NSString *localPath;

/*!
 @property
 @abstract 文件对象所对应的文件的大小, 以字节为单位
 */
@property (nonatomic) long long fileLength;

/*!
 @method
 @abstract 以NSData构造文件对象
 @discussion 
 @param aData 文件内容
 @param aDisplayName 文件对象的显示名
 @result 文件对象
 */
- (id)initWithData:(NSData *)aData displayName:(NSString *)aDisplayName;

/*!
 @method
 @abstract 以文件路径构造文件对象
 @discussion 
 @param filePath 磁盘文件全路径
 @param aDisplayName 文件对象的显示名
 @result 文件对象
 */
- (id)initWithFile:(NSString *)filePath displayName:(NSString *)aDisplayName;

@end
