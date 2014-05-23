//
//  UIViewController+ExtendedLayout.m
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-23.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import "UIViewController+ExtendedLayout.h"

@implementation UIViewController (ExtendedLayout)

- (void)versionAdapter{
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

@end
