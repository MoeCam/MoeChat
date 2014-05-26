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
    NSString *_chatter;
}
@end

@implementation ChatViewModel

- (id)initWithChatVC:(ChatViewController *)chatVC
         andChatter:(NSString *)chatter
       andIsChatroom:(BOOL)isChatroom{
    if (self = [super init]) {
        _chatVC = chatVC;
        _chatter = chatter;
    }
    
    return self;
}

- (void)registerNotification{
    [self unRegisterNotification];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

- (void)unRegisterNotification{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

// 收到新消息
-(void)didReceiveMessage:(EMMessage *)message{
    if ([message.conversation.chatter isEqualToString:_chatter]) {
        _chatVC
    }
}

@end
