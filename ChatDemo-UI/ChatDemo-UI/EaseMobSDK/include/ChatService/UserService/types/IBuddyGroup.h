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

-(id)attributeForKey:(NSString *)key;
-(void)setAttribute:(id)attribute
             forKey:(NSString *)key;

@end
