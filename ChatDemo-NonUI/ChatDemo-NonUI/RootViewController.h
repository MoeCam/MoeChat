//
//  RootViewController.h
//  ChatDemo-NonUI
//
//  Created by dujiepeng on 14-4-1.
//  Copyright (c) 2014年 djp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EaseMob.h"

@interface RootViewController : UIViewController<IChatManagerDelegate>
-(void)removeRandVC;
@end
