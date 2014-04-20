//
//  IDepartment.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 1/6/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDepartment <NSObject>

@required
@property (nonatomic, copy) NSString *key;
@property (nonatomic, strong) id rawDepartment;

-(id)attributeForKey:(NSString *)key;
-(void)setAttribute:(id)attribute
             forKey:(NSString *)key;

@end
