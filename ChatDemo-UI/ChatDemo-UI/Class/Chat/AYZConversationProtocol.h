//
//  AYZConversationProtocol.h
//  ChatDemo-UI
//
//  Created by dhcdht on 14-5-20.
//  Copyright (c) 2014年 djp. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AYZConversationProtocol <NSObject>

//接收到消息
-(void)didReceiveMessage:(EMMessage *)message;

//conversation 数量变化
-(void)didUpdateConversationList:(NSArray *)conversationList;

@end
