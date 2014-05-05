/*!
 @header EMChatServiceDefs.h
 @abstract ChatManager相关宏定义
 @author Ji Fang
 @version 1.00 2014/01/01 Creation (1.00)
 */

#ifndef EaseMobClientSDK_EMChatServiceDefs_h
#define EaseMobClientSDK_EMChatServiceDefs_h

#import "commonDefs.h"

/*!
 @enum
 @abstract 聊天类型
 @constant eMessageType_Text 文本类型
 @constant eMessageType_Image 图片类型
 @constant eMessageType_Video 视频类型
 @constant eMessageType_Location 位置类型
 @constant eMessageType_Voice 语音类型
 @constant eMessageType_File 文件类型
 @constant eMessageType_Command 命令类型
 */
typedef enum _MessageType {
    eMessageType_Text = 1,
    eMessageType_Image,
    eMessageType_Video,
    eMessageType_Location,
    eMessageType_Voice,
    eMessageType_File,
    eMessageType_Command
}MessageType;

/*!
 @enum
 @abstract 聊天消息发送状态
 @constant eMessageDeliveryState_Pending 待发送
 @constant eMessageDeliveryState_Delivering 正在发送
 @constant eMessageDeliveryState_Delivered 已发送, 成功
 @constant eMessageDeliveryState_Failure 已发送, 失败
 */
typedef enum _MessageDeliveryState {
    eMessageDeliveryState_Pending = 0, 
    eMessageDeliveryState_Delivering, 
    eMessageDeliveryState_Delivered, 
    eMessageDeliveryState_Failure
}MessageDeliveryState;

#endif
