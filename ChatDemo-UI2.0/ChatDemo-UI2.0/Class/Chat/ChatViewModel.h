//
//  ChatViewModel.h
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-24.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatViewController.h"

@interface ChatViewModel : NSObject

@property (nonatomic, weak) ChatViewController *_chatVC;

-(id)initWithChatVC:(ChatViewController *)chatVC;
@end
