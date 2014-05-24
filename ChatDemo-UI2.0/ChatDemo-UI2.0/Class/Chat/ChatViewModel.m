//
//  ChatViewModel.m
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-24.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import "ChatViewModel.h"

@implementation ChatViewModel

-(id)initWithChatVC:(ChatViewController *)chatVC{
    if (self = [super init]) {
        __chatVC = chatVC;
    }
    
    return self;
}

-(void)registerNotification{
    [self unRegisterNotification];
}

-(void)unRegisterNotification{

}
@end
