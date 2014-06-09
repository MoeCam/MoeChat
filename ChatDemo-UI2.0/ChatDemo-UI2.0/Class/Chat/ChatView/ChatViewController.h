//
//  ChatViewController.h
//  ChatDemo
//
//  Created by xieyajie on 14-4-29.
//  Copyright (c) 2014年 easemob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController

- (instancetype)initWithChatter:(NSString *)chatter;

- (instancetype)initWithGroup:(EMGroup *)chatGroup;

@end
