//
//  EMASIInputStream.h
//  Part of EMASIHTTPRequest -> http://allseeing-i.com/EMASIHTTPRequest
//
//  Created by Ben Copsey on 10/08/2009.
//  Copyright 2009 All-Seeing Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EMASIHTTPRequest;

// This is a wrapper for NSInputStream that pretends to be an NSInputStream itself
// Subclassing NSInputStream seems to be tricky, and may involve overriding undocumented methods, so we'll cheat instead.
// It is used by EMASIHTTPRequest whenever we have a request body, and handles measuring and throttling the bandwidth used for uploading

@interface EMASIInputStream : NSObject {
	NSInputStream *stream;
	EMASIHTTPRequest *request;
}
+ (id)inputStreamWithFileAtPath:(NSString *)path request:(EMASIHTTPRequest *)request;
+ (id)inputStreamWithData:(NSData *)data request:(EMASIHTTPRequest *)request;

@property (retain, nonatomic) NSInputStream *stream;
@property (assign, nonatomic) EMASIHTTPRequest *request;
@end
