//
//  IBuddyGroup.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 12/28/13.
//  Copyright (c) 2013 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IBuddyGroup <NSObject>

@required
@property (nonatomic, strong) id rawBuddyGroup;

- (id)attributeForKey:(NSString *)key;
- (void)setAttribute:(id)attribute
             forKey:(NSString *)key;

@property (nonatomic, copy) NSString *groupName;

/**
 *  符合 <IUserBase>协议的对象组成
 */
@property (nonatomic, strong) NSArray *members;

- (id)initWithRawGroup:(id)rawGroup;

@end
