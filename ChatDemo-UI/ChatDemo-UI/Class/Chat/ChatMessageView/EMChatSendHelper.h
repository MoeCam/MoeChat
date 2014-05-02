//
//  EMChatSendHelper.h
//  ChatDemo
//
//  Created by xieyajie on 14-3-22.
//  Copyright (c) 2014年 easemob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMChatSendHelper : NSObject

+(EMMessage *)sendTextMessageWithString:(NSString *)str
                             toUsername:(NSString *)username;

// 发送图片
+(EMMessage *)sendImageMessageWithImage:(UIImage *)image
                             toUsername:(NSString *)username;

// 发送音频
+(EMMessage *)sendVoice:(EMChatVoice *)voice
             toUsername:(NSString *)username;

// 发送位置
+(EMMessage *)sendLocationLatitude:(double)latitude
                         longitude:(double)longitude
                           address:(NSString *)address
                        toUsername:(NSString *)username;


+(void)sendMessageWithUsername:(NSString *)username
                 andIsChatroom:(BOOL)isChatroom;

@end
