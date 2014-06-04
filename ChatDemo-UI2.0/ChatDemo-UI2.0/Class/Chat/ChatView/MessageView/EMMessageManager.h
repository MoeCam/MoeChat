//
//  EMMessageManager.h
//  ChatDemo
//
//  Created by xieyajie on 14-4-16.
//  Copyright (c) 2014年 easemob. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MWPhotoBrowser.h"
#import "EMMessageModel.h"

typedef void (^FinishBlock)(BOOL success);
typedef void (^PlayBlock)(BOOL playing);

@class EMChatFireBubbleView;
@interface EMMessageManager : NSObject<MWPhotoBrowserDelegate>

@property (strong, nonatomic) MWPhotoBrowser *photoBrowser;
@property (strong, nonatomic) FinishBlock finishBlock;

@property (strong, nonatomic) EMMessageModel *audioMessage;

+ (id)defaultManager;

//default
- (void)showBrowserWithImages:(NSArray *)imageArray;

- (void)startMessageAudio:(EMMessageModel *)message
                  chatter:(NSString *)chatter
                playBlock:(PlayBlock)block;
- (void)stopMessageAudio;

@end
