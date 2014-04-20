//
//  EMMessage.h
//  EaseMobClientSDK
//
//  Created by jifang on 2/12/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMMessageBody.h"

@interface EMMessage : NSObject

@property (nonatomic, copy) NSString *from; // should be username for now
@property (nonatomic, copy) NSString *to;   // should be username for now
@property (nonatomic, copy) NSString *messageId;
@property (nonatomic, readonly) BOOL isEncrypted;
@property (nonatomic) long long timestamp;
@property (nonatomic) BOOL isRead;
@property (nonatomic, strong) NSArray *messageBodies;

@property (nonatomic) BOOL isChatroom;
@property (nonatomic, copy) NSString *chatroomSenderName;
@property (nonatomic, strong) NSDictionary *ext;
@property (nonatomic, strong) NSData *encryptionKey;

@property (nonatomic) MessageDeliveryState deliveryState;

-(id)initWithSender:(NSString *)sender
           receiver:(NSString *)receiver
             bodies:(NSArray *)bodies;

-(NSArray *)addMessageBody:(EMMessageBody *)body;
-(NSArray *)removeMessageBody:(EMMessageBody *)body;

@end
