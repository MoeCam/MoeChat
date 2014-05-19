/*!
 @header EaseMob.h
 @abstract EaseMob客户端基本类
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIApplication.h>

#import "EaseMobHeaders.h"

/*!
 @class
 @brief 本协议主要处理：录音、播放录音、停止录音、震动等操作
 @discussion SDK集成进工程后, 最先使用的类, 所有的类对象, 均是通过这个单实例来获取, 示例代码如下:
            [EaseMob sharedInstance]
 */
@interface EaseMob : NSObject<UIApplicationDelegate>

/*!
 @method
 @brief 获取单实例
 @discussion
 @result EaseMob实例对象
*/
+ (EaseMob *)sharedInstance;

/*!
 @property
 @brief 聊天管理器, 获取该对象后, 可以做登录、聊天、加好友等操作
 */
@property (nonatomic, readonly, strong) id<IChatManager> chatManager;

/*!
 @property
 @brief 设备管理器, 获取该对象后, 可以操作硬件相关的接口(照片、音频、地理位置信息等)
 */
@property (nonatomic, readonly, strong) id<IDeviceManager> deviceManager;

@end
