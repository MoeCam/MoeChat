//
//  EMConversation.h
//  EaseMobClientSDK
//
//  Created by jifang on 3/5/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EMMessage;
@interface EMConversation : NSObject

@property (nonatomic, copy) NSString *chatter;
@property (nonatomic) BOOL isChatroom;
@property (nonatomic, readonly) NSArray *messages;
@property (nonatomic) BOOL enableReceiveMessage;
@property (nonatomic) BOOL enableUnreadMessagesCountEvent;

-(id)init;
-(id)initWithChatter:(NSString *)chatter isChatroom:(BOOL)isChatroom;

#pragma mark - message
-(BOOL)removeMessage:(EMMessage *)message;
-(NSUInteger)removeMessages:(NSArray *)messages;
-(NSUInteger)removeAllMessages;

-(EMMessage *)loadMessage:(NSString *)messageId;
-(NSArray *)loadMessages:(NSArray *)messageIds;
-(NSArray *)loadAllMessages;
-(NSArray *)loadNumbersOfMessages:(NSUInteger)aCount before:(long long)timestamp;

-(BOOL)addMessage:(EMMessage *)message;
-(NSUInteger)addMessages:(NSArray *)messages;

#pragma mark - mark conversation
-(NSUInteger)markMessagesAsRead:(BOOL)isRead;
-(BOOL)markMessage:(EMMessage *)message asRead:(BOOL)isRead;

#pragma mark - statistics
-(NSUInteger)unreadMessagesCount;

@end
