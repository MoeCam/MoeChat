//
//  EMReceipt.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 4/15/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EMMessage;

@interface EMReceipt : NSObject

@property (nonatomic, copy) NSString *from;
@property (nonatomic, copy) NSString *to;
@property (nonatomic, copy) NSString *chatId;
@property (nonatomic) BOOL isChatroom;
@property (nonatomic) long long timestamp;

@end

@interface EMReceiptReq : EMReceipt

+(EMReceiptReq *)createFromMessage:(EMMessage *)message;

@end

@interface EMReceiptResp : EMReceipt

+(EMReceiptResp *)createFromMessage:(EMMessage *)message;

@end
