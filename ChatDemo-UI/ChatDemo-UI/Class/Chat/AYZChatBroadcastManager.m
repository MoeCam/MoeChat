//
//  AYZChatBroadcastManager.m
//  BussinessLink
//
//  Created by dhcdht on 14-5-13.
//  Copyright (c) 2014年 Li Zhiping. All rights reserved.
//

#import "AYZChatBroadcastManager.h"

#pragma mark - AYZChatBroadcastDelegateNode

@implementation AYZChatBroadcastDelegateNode

//

@end


#pragma mark - AYZChatBroadcastManager

static AYZChatBroadcastManager *defaultManager = nil;

@interface AYZChatBroadcastManager()<IChatManagerDelegate>

@property (strong, nonatomic) NSMutableArray *delegates;

@end

@implementation AYZChatBroadcastManager

- (instancetype)init
{
    self = [super init];
    if (self) {
#warning 以下两行代码必须写，注册为SDK的ChatManager的delegate
        [[EaseMob sharedInstance].chatManager removeDelegate:self];
        //注册为SDK的ChatManager的delegate
        [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
        
        _delegates = [[NSMutableArray alloc] init];
    }
    
    return self;
}

+ (instancetype)defaultManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultManager = [[AYZChatBroadcastManager alloc] init];
    });
    
    return defaultManager;
}

- (void)dealloc
{
#warning 以下第一行代码必须写，将self从ChatManager的代理中移除
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

- (void)addDelegate:(id<AYZMessageProtocol>)delegate chatConversation:(EMConversation *)conversation
{
    if (delegate == nil)
    {
        return;
    }
    
	for (AYZChatBroadcastDelegateNode *node in self.delegates) {
        if (node.delegate == delegate && [node.conversation.chatter isEqualToString:conversation.chatter]) {
            return;
        }
    }
    
    AYZChatBroadcastDelegateNode *node = [[AYZChatBroadcastDelegateNode alloc] init];
    node.delegate = delegate;
    node.conversation = conversation;
    [_delegates addObject:node];
}

- (void)removeDelegate:(id<AYZMessageProtocol>)delegate
{
    if (delegate == nil) {
        return;
    }
    
    for (AYZChatBroadcastDelegateNode *node in self.delegates) {
        if (node.delegate == delegate) {
            [self.delegates removeObject:node];
            break;
        }
    }
}

- (void)clear
{
    [self.delegates removeAllObjects];
}

#pragma mark - IChatManagerDelegate

-(void)didSendMessage:(EMMessage *)message error:(EMError *)error
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (AYZChatBroadcastDelegateNode *node in self.delegates)
        {
            if (node.delegate && [node.conversation.chatter isEqualToString:message.conversation.chatter] && [node.delegate respondsToSelector:@selector(didSendMessage:error:)]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [node.delegate didSendMessage:message error:error];
                });
            }
        }
    });
}

-(void)didReceiveMessage:(EMMessage *)message
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (AYZChatBroadcastDelegateNode *node in self.delegates)
        {
            if (node.delegate && [node.conversation.chatter isEqualToString:message.conversation.chatter] && [node.delegate respondsToSelector:@selector(didReceiveMessage:)]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [node.delegate didReceiveMessage:message];
                });
            }
        }
        
        if (_conversationDelegate && [_conversationDelegate respondsToSelector:@selector(didReceiveMessage:)]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_conversationDelegate didReceiveMessage:message];
            });
        }
    });
}

-(void)didUpdateConversationList:(NSArray *)conversationList
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (_conversationDelegate && [_conversationDelegate respondsToSelector:@selector(didUpdateConversationList:)]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_conversationDelegate didUpdateConversationList:conversationList];
            });
        }
    });
}


@end
