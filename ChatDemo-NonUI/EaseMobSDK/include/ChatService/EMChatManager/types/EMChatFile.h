/*!
 @header EMChatFile.h
 @abstract 聊天的文件对象类型
 @author Ji Fang
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>
#import "EMChatObject.h"

/*!
 @class 
 @abstract 聊天的文件对象类型
 */
@interface EMChatFile : EMChatObject {
    NSString *_displayName;
    NSString *_localPath;
    NSString *_remotePath;
    long long _fileLength;
}

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
 @abstract 文件对象远程服务器上的全路径
 */
@property (nonatomic, copy) NSString *remotePath;

/*!
 @property
 @abstract 文件对象所对应的文件的大小, 以字节为单位
 */
@property (nonatomic) long long fileLength;

/*!
 @method
 @abstract 生成基于时间的文件名
 @discussion 
 @result 基于时间的文件名字符串
 */
- (NSString *)generateName;

/*!
 @method
 @abstract 指定文件的长度, 以字节为单位
 @discussion 
 @param path 磁盘文件全路径
 @result 返回字节为单位的文件大小
 */
- (long long)lengthOfFile:(NSString *)path;

/*!
 @method
 @abstract 刷新文件对象状态信息
 @discussion 
 @result 
 */
- (void)update;

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
