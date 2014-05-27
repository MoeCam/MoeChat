//
//  ChatViewModel.m
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-24.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import "ChatViewModel.h"
#import "ChatViewController.h"

@interface ChatViewModel ()<IChatManagerDelegate>{
    EMConversation *_conversation;
    EMMessage *_firstMessage;
    BOOL _isChatroom;
}
@end

@implementation ChatViewModel

- (id)initWithChatVC:(ChatViewController *)chatVC
         andChatter:(NSString *)chatter
       andIsChatroom:(BOOL)isChatroom{
    if (self = [super init]) {
        _chatVC = chatVC;
        _conversation = [[EaseMob sharedInstance].chatManager
                         conversationForChatter:chatter];
        _isChatroom = isChatroom;
    }
    
    return self;
}

- (void)registerNotification{
    [self unRegisterNotification];
    [[EaseMob sharedInstance].chatManager addDelegate:self
                                        delegateQueue:nil];
}

- (void)unRegisterNotification{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

- (void)removeAllMessages{
    [_conversation removeAllMessages];
    [_chatVC didRemoveAllMessages];
}

- (void)removeMessage:(NSString *)messageId{
    BOOL success =[_conversation removeMessage:messageId];
    [_chatVC didRemoveMessage:messageId
                      success:success];
}

- (void)loadMoreMessagesWithCount:(NSInteger)count{
    long long beforeTime = 0;
    if (_firstMessage) {
        beforeTime = _firstMessage.timestamp;
    }else{
        beforeTime = [_conversation latestMessage].timestamp;
    }

    NSArray *messages = [_conversation loadNumbersOfMessages:count before:beforeTime];
    _firstMessage = messages.firstObject;
    
    [_chatVC addMessages:messages];
}

// 收到新消息
-(void)didReceiveMessage:(EMMessage *)message{
    if (message.conversation == _conversation) {
        [_chatVC addMessage:message];
    }
}

@end
