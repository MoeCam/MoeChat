//
//  RootViewController+sendChat.m
//  ChatDemo-NonUI
//
//  Created by dujiepeng on 14-4-1.
//  Copyright (c) 2014年 djp. All rights reserved.
//

#import "RootViewController+sendChat.h"
#import "EaseMob.h"
@implementation RootViewController (sendChat)
-(void)sendMessage:(NSString *)message{
    EMChatText *text = [[EMChatText alloc] initWithText:message];
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithChatObject:text];
    
    EMMessage *msg = [[EMMessage alloc]
                      initWithReceiver:@"bot"
                      bodies:[NSArray arrayWithObject:body]];
    
    [[EaseMob sharedInstance].chatManager sendMessage:msg
                                             progress:nil
                                                error:nil];
}
@end
