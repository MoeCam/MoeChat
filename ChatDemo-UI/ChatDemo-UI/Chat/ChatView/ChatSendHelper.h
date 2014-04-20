//
//  ChatSendHelper.h
//  leCar
//
//  Created by dujiepeng on 14-3-22.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatSendHelper : NSObject
+(EMMessage *)sendTextMessageWithString:(NSString *)str
                             toUsername:(NSString *)username;

+(void)sendMessageWithUsername:(NSString *)username
                 andIsChatroom:(BOOL)isChatroom;
@end
