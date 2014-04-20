//
//  UIImage+Data.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 3/3/14.
//  Copyright (c) 2014 EaseMob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Data)

#pragma mark - image converter
+ (UIImage *)optimizeImageForPNG:(UIImage *)image;
+ (UIImage *)optimizeImageForJPEG:(UIImage *)image;

+ (NSString *)saveImage:(UIImage *)image
            withPNGName:(NSString *)fullFilePath
               optimize:(BOOL)optimize;
+ (NSString *)saveImage:(UIImage *)image
            withJPGName:(NSString *)fullFilePath
               optimize:(BOOL)optimize;

+(double)_calculateInSampleSize:(CGSize)reqSize forImage:(UIImage *)image;

/**
 *  保存单个 UIImage 对象到磁盘
 *
 *  @param fileName 保存到磁盘的文件名字
 *  @param image    需要保存的UIImage对象
 *
 *  @return 返回保存后的本地文件路径
 */
+ (NSString *)saveImageToDisk:(UIImage *)image savedFileName:(NSString *)fileName;

@end
