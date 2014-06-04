//
//  EMMessageModel.h
//  ChatDemo
//
//  Created by xieyajie on 14-4-14.
//  Copyright (c) 2014年 easemob. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KFIRETIME 20

@interface EMMessageModel : NSObject
{
    BOOL _isPlaying;
    NSMutableDictionary *_observerKeys;
}

@property (nonatomic) MessageBodyType type;
@property (nonatomic) MessageDeliveryState status;

@property (nonatomic) BOOL isSender;    //是否是发送者
@property (nonatomic) BOOL isRead;      //是否已读
@property (nonatomic) BOOL isChatroom;  //是否是群聊

@property (nonatomic, strong) NSString *messageId;
@property (nonatomic, strong) NSURL *headImageURL;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *username;

//text
@property (nonatomic, strong) NSString *content;

//image
@property (nonatomic) CGSize size;
@property (nonatomic) CGSize thumbnailSize;
@property (nonatomic, strong) NSURL *imageRemoteURL;
@property (nonatomic, strong) NSURL *thumbnailRemoteURL;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *thumbnailImage;

//audio
@property (nonatomic, strong) NSString *localPath;
@property (nonatomic, strong) NSString *remotePath;
@property (nonatomic) NSInteger time;
@property (nonatomic, strong) EMChatVoice *chatVoice;
@property (nonatomic) BOOL isPlaying;
@property (nonatomic) BOOL isPlayed;

//location
@property (nonatomic, strong) NSString *address;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

@property (nonatomic, strong)id<IEMMessageBody> messageBody;
@property (nonatomic, strong)EMMessage *message;

- (BOOL)observeKeyPath:(NSString *)keyPath;
- (void)addObserver:(NSObject *)object keyPath:(NSString *)keyPath;
- (void)removeObserver:(NSObject *)object keyPath:(NSString *)keyPath;
- (void)clearObservers;

@end
