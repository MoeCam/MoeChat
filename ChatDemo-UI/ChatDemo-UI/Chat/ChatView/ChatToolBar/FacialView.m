//
//  FacialView.m
//  KeyBoardTest
//
//  Created by wangqiulei on 11-8-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#define kImage        1
#define kTakePhoto    2
#define kLocation     3
#define kFile         4

#import "FacialView.h"
#import "Emoji.h"

@interface FacialView () {
    NSMutableArray *emojis;
}

@end

@implementation FacialView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        faces=[Emoji allEmoji];
        emojis = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}


//给faces设置位置
-(void)loadFacialView:(int)page size:(CGSize)size
{
	//row number
    for (int i=0; i<4; i++) {
        //column numer
        for (int y=0; y<9; y++) {
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundColor:[UIColor clearColor]];
            [button setFrame:CGRectMake(y*size.width, i*size.height, size.width, size.height)];
            if (i==3&&y==8) {
                [button setImage:[UIImage imageNamed:@"faceDelete"] forState:UIControlStateNormal];
                button.tag=10000;
                
            }else{
                [button.titleLabel setFont:[UIFont fontWithName:@"AppleColorEmoji" size:29.0]];
                [button setTitle: [faces objectAtIndex:i*9+y]forState:UIControlStateNormal];
                button.tag=i*9+y;
            }
            [button addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
}


-(void)selected:(UIButton*)bt
{
    if (bt.tag == 10000) {
        if (emojis.count > 0) {
            [_delegate deleteSelected:emojis.lastObject];
            [emojis removeLastObject];
        }
    }else{
        NSString *str = [faces objectAtIndex:bt.tag];
        if (_delegate) {
            [_delegate selectedFacialView:str];
            [emojis addObject:str];
        }
        
        /*   //为自定义表情添加[]
         NSString * imageName = [faces objectAtIndex:bt.tag];
         NSString *str= [NSString stringWithFormat:@"[%@]",imageName];
         NSLog(@"点击其他%@",str);
         [delegate selectedFacialView:str];
         */
    }
}


- (void)dealloc {
    
}
@end
