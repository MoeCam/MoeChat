//
//  EMRemarkImageView.h
//  ChatDemo-UI2.0
//
//  Created by dhcdht on 14-6-6.
//  Copyright (c) 2014年 dhcdht. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMRemarkImageView : UIView
{
    UILabel *_remarkLabel;
    UIImageView *_imageView;
    
    NSInteger _index;
    BOOL _editing;
}

@property (nonatomic) NSInteger index;
@property (nonatomic) BOOL editing;
@property (strong, nonatomic) NSString *remark;
@property (strong, nonatomic) UIImage *image;

@end
