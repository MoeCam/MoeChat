//
//  ChatViewController.h
//  leCar
//
//  Created by dujiepeng on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *photos;
-(id)initWithUsername:(NSString *)username
           isChatroom:(BOOL)isChatroom;
@end
