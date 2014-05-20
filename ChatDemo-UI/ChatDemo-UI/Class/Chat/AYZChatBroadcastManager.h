//
//  AYZChatBroadcastManager.h
//  BussinessLink
//
//  Created by xieyajie on 14-5-13.
//  Copyright (c) 2014年 Li Zhiping. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AYZMessageProtocol.h"
#import "AYZConversationProtocol.h"

@interface AYZChatBroadcastDelegateNode : NSObject

@property (weak, nonatomic) id<AYZMessageProtocol> delegate;

@property (strong, nonatomic) EMConversation *conversation;

@end

@interface AYZChatBroadcastManager : NSObject

@property (unsafe_unretained, nonatomic) id<AYZConversationProtocol> conversationDelegate;

+ (instancetype)defaultManager;

- (void)addDelegate:(id<AYZMessageProtocol>)delegate chatConversation:(EMConversation *)conversation;
- (void)removeDelegate:(id<AYZMessageProtocol>)delegate;

- (void)clear;

@end
