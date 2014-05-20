//
//  AYZMessageProtocol.h
//  BussinessLink
//
//  Created by dhcdht on 14-5-13.
//  Copyright (c) 2014年 Li Zhiping. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AYZMessageProtocol <NSObject>

-(void)didSendMessage:(EMMessage *)message error:(EMError *)error;

-(void)didReceiveMessage:(EMMessage *)message;

@end
