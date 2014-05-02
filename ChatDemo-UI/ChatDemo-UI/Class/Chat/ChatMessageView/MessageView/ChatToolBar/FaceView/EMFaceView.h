//
//  EMFaceView.h
//  ChatDemo
//
//  Created by dujiepeng on 14-2-27.
//  Copyright (c) 2014年 easemob. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FacialView.h"

@protocol EMFaceDelegate <FacialViewDelegate>

@required
- (void)selectedFacialView:(NSString *)str isDelete:(BOOL)isDelete;
- (void)faceViewSwitchToText;

@end


@interface EMFaceView : UIView <FacialViewDelegate>
@property (nonatomic, assign) id <EMFaceDelegate> delegate;

- (BOOL)stringIsFace:(NSString *)string;

@end
