//
//  XDSendLocationViewController.h
//  leCar
//
//  Created by dujiepeng on 14-4-15.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LocationDelegate <NSObject>

-(void)sendLocationLatitude:(double)latitude
                  longitude:(double)longitude
                 andAddress:(NSString *)address;
@end

@interface SendLocationViewController : UIViewController
@property (nonatomic, assign) id <LocationDelegate> delegate;

+(instancetype)sendLocation;
+(instancetype)readLocationLatitude:(double)latitude
                          longitude:(double)longitude
                    address:(NSString *)address;
@end
