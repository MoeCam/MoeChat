//
//  ChatViewModel.h
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-24.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChatViewController;

/*
@protocol ChatModeDelegate <NSObject>
@required

- (void)didRemoveAllMessages;
- (void)didRemoveMessage:(EMMessage *)message;

- (void)didReceiveMessage:(EMMessage *)message;
- (void)didReceiveMessages:(NSArray *)messages;

@end
*/

@interface ChatViewModel : NSObject

@property (nonatomic, weak) ChatViewController *chatVC;

- (id)initWithChatVC:(ChatViewController *)chatVC
          andChatter:(NSString *)chatter
       andIsChatroom:(BOOL)isChatroom;


// 删除所有消息
- (void)removeAllMessages;

// 删除指定消息
- (void)removeMessage:(NSString *)messageId;

// 载入消息条数
- (void)loadMoreMessagesWithCount:(NSInteger)count;

@end
