//
//  IUserBase.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 12/17/13.
//  Copyright (c) 2013 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IUserBase <NSObject>

@required
@property (nonatomic, copy) NSString *key;
@property (nonatomic, strong) id rawUser;

- (id)attributeForKey:(NSString *)key;
- (void)setAttribute:(id)attribute 
             forKey:(NSString *)key;

@end
