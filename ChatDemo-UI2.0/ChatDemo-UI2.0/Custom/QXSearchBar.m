//
//  QXSearchBar.m
//  ChatDemo-UI2.0
//
//  Created by dujiepeng on 14-5-23.
//  Copyright (c) 2014年 dujiepeng. All rights reserved.
//

#import "QXSearchBar.h"

#define PADDING 8

@interface QXSearchBar (){
    UITextField *_searchTextField;
    UIButton    *_searchBtn;
}

@end

@implementation QXSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    BOOL isShowSearchBtn = NO;
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subView removeFromSuperview];
        }
        
        if ([subView isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
            _searchTextField = (UITextField *)subView;
        }
        
        if ([subView isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
            _searchBtn = (UIButton *)subView;
            isShowSearchBtn = YES;
        }
    }
 
    if (!isShowSearchBtn) {
        _searchBtn = nil;
    }
    if (_searchTextField) {
        [_searchTextField setBorderStyle:UITextBorderStyleNone];
        _searchTextField.background = nil;
        _searchTextField.frame = CGRectMake(PADDING,
                                           PADDING,
                                           self.bounds.size.width - 2* PADDING - _searchBtn.frame.size.width,
                                           self.bounds.size.height - 2* PADDING);
        _searchTextField.layer.cornerRadius = 6;
        
        _searchTextField.clipsToBounds = YES;
        _searchTextField.backgroundColor = [UIColor whiteColor];
    }
    self.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
}



@end
