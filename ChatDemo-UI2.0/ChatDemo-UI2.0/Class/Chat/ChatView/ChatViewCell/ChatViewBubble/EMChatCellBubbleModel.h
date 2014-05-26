//
//  EMChatCellBubbleModel.h
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-26.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    chatSending  = 0,
    chatSendFailure,
    chatSent
}ChatSendType;

typedef enum {
    BubbleViewType_Text = 0,
    BubbleViewType_Image,
    BubbleViewType_Location,
    BubbleViewType_Voice
}BubbleViewType;

@interface EMChatCellBubbleModel : NSObject

@property (nonatomic, strong) NSString *chatId;
@property (nonatomic) BOOL isLeft;
@property (nonatomic) BOOL isRead;
@property (nonatomic) ChatSendType chatSendType;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSURL *avatarURL;
@property (nonatomic) BOOL isChatroom;
@property (nonatomic) BubbleViewType bubbleType;

//text
@property (nonatomic, strong) NSString * content;

// image
@property (nonatomic, strong) NSURL *imageRemoteURL;
@property (nonatomic, strong) UIImage *thumbnailImage;

//audio
@property (nonatomic, strong) NSString *localPath;
@property (nonatomic) NSInteger time;
@property (nonatomic) BOOL isPlaying;

//location
@property (nonatomic, strong) NSString *address;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

+(instancetype)modelWithMessage:(EMMessage *)message;

@end
