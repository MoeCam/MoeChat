//
//  XDFaceView.h
//  leCar
//
//  Created by dujiepeng on 14-2-27.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacialView.h"

@protocol FaceDelegate <FacialViewDelegate>
-(void)selectedFacialView:(NSString *)str isDelete:(BOOL)isDelete;
-(void)sendMessageFormFaceView;
@end


@interface FaceView : UIView <FacialViewDelegate>
@property (nonatomic, assign) id <FaceDelegate> delegate;
@end
