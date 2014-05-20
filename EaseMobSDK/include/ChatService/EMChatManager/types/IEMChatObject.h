//
//  IEMChatObject.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 5/20/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EMMessageBody;

@protocol IEMChatObject <NSObject>

@required

/*!
 @property
 @brief
 聊天对象所在的消息体对象
 @discussion
 当消息体通过聊天对象创建完成后, messageBody为非nil, 当聊天对象并不属于任何消息体对象的时候, messageBody为nil
 */
@property (nonatomic, weak) EMMessageBody *messageBody;

@end
