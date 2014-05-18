/*!
 @header EMBuddy.h
 @abstract 好友的信息描述类
 @author EaseMob Inc.
 @version 1.00 2014/01/01 Creation (1.00)
 */
#import <Foundation/Foundation.h>

/*!
 @class
 @abstract 好友的信息描述类
 */
@interface EMBuddy : NSObject

/*!
 @method
 @abstract 通过username初始化一个EMBuddy对象
 @param username 好友的username
 @discussion
 @result EMBuddy实例对象
 */
+ (instancetype)buddyWithUsername:(NSString *)username;

/*!
 @property
 @abstract 好友的username
 */
@property (copy, nonatomic, readonly)NSString *username;

/*!
 @property
 @abstract 好友是否在线
 */
@property (nonatomic) BOOL isOnline;

/*!
 @property
 @abstract 是否等待对方接受好友请求()
 @discussion A向B发送好友请求,会自动将B添加到A的好友列表中,但isPendingApproval为NO,表示等待B接受A的好友请求,如果在好友列表中,不需要显示isPendingApproval为NO的用户,屏蔽它即可
 */
@property (nonatomic) BOOL isPendingApproval;

@end
