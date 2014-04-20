//
//  EMMessageBody.h
//  EaseMobClientSDK
//
//  Created by jifang on 2/12/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMChatServiceDefs.h"
#import "EMChatObject.h"

@interface EMMessageBody : NSObject {
    EMChatObject *_message;
}

@property (nonatomic, readonly) MessageType messageType;
@property (nonatomic, strong, readonly) EMChatObject *message;
@property (nonatomic, readonly) BOOL isEncrypted;

@end
