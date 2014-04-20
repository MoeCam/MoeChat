//
//  EMChatText.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 2/15/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMChatObject.h"

@interface EMChatText : EMChatObject

@property (nonatomic, copy) NSString *text;

-(id)initWithText:(NSString *)text;

-(NSString *)description;

@end
