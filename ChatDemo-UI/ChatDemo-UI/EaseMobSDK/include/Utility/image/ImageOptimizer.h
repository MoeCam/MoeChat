//
//  ImageOptimizer.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 8/13/13.
//  Copyright (c) 2013 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageOptimizer : NSObject

+(double)calculateInSampleSize:(CGSize)reqSize forImage:(UIImage *)image;

@end

@interface UIImage (Optimizer)

-(UIImage *)optimizeForJPEG;
-(UIImage *)optimizeForPNG;

-(NSString *)saveToJPEG:(NSString *)fullPath optimize:(BOOL)optimize;
-(NSString *)saveToPNG:(NSString *)fullPath optimize:(BOOL)optimize;
-(UIImage *)scaleRectImage;
@end
