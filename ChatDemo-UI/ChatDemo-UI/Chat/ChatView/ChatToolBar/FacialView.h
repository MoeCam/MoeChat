//
//  FacialView.h
//  KeyBoardTest
//
//  Created by wangqiulei on 11-8-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FacialViewDelegate
@optional
-(void)selectedFacialView:(NSString*)str;
-(void)deleteSelected:(NSString *)str;
@end


@interface FacialView : UIView {
	NSArray *faces;
}
@property(nonatomic, assign) id<FacialViewDelegate>delegate;

-(void)loadFacialView:(int)page size:(CGSize)size;

@end
