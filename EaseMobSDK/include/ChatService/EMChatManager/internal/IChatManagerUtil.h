/*!
 @header IChatManagerUtil.h
 @abstract 为ChatManager提供工具类
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */


#import <Foundation/Foundation.h>
#import "IChatManagerBase.h"

@protocol IEMFileMessageBody;
@protocol IEMChatProgressDelegate;
@class EMError;

/*!
 @protocol
 @brief 本协议主要用于为ChatManager提供一些实用工具
 @discussion
 */
@protocol IChatManagerUtil <IChatManagerBase>

@required
#pragma mark - get remote path for message body
- (NSString *)remoteUrlForMessageBody:(id<IEMFileMessageBody>)aMessageBody;

#pragma mark - fetch message body
- (id<IEMFileMessageBody>)fetchMessage:(id<IEMFileMessageBody>)aMessageBody
                          progress:(id<IEMChatProgressDelegate>)progress
                             error:(EMError **)pError;
- (void)asyncFetchMessage:(id<IEMFileMessageBody>)aMessageBody
                 progress:(id<IEMChatProgressDelegate>)progress;
- (void)asyncFetchMessage:(id<IEMFileMessageBody>)aMessageBody
                 progress:(id<IEMChatProgressDelegate>)progress
               completion:(void (^)(id<IEMFileMessageBody> aMessageBody, 
                                    EMError *error))completion
                  onQueue:(dispatch_queue_t)aQueue;

@end
