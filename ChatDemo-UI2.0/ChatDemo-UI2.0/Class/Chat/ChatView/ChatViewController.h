//
//  ChatViewController.h
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-23.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EMMessage;
@interface ChatViewController : UIViewController

- (id)initWithChatter:(NSString *)chatter
        andIsChatRoom:(BOOL)isChatroom;

- (void)addMessage:(EMMessage *)message;
- (void)addMessages:(NSArray *)messages;

- (void)didRemoveAllMessages;
- (void)didRemoveMessage:(NSString *)messageId success:(BOOL)isSuccess;

@end
