//
//  EMASIS3BucketObject.h
//  Part of EMASIHTTPRequest -> http://allseeing-i.com/EMASIHTTPRequest
//
//  Created by Ben Copsey on 13/07/2009.
//  Copyright 2009 All-Seeing Interactive. All rights reserved.
//
//  Instances of this class represent objects stored in a bucket on S3
//  ASIS3BucketRequests return an array of ASIS3BucketObjects when you perform a list query

#import <Foundation/Foundation.h>
@class EMASIS3ObjectRequest;

@interface EMASIS3BucketObject : NSObject <NSCopying> {
	
	// The bucket this object belongs to
	NSString *bucket;
	
	// The key (path) of this object in the bucket
	NSString *key;
	
	// When this object was last modified
	NSDate *lastModified;
	
	// The ETag for this object's content
	NSString *ETag;
	
	// The size in bytes of this object
	unsigned long long size;
	
	// Info about the owner
	NSString *ownerID;
	NSString *ownerName;
}

+ (id)objectWithBucket:(NSString *)bucket;

// Returns a request that will fetch this object when run
- (EMASIS3ObjectRequest *)GETRequest;

// Returns a request that will replace this object with the contents of the file at filePath when run
- (EMASIS3ObjectRequest *)PUTRequestWithFile:(NSString *)filePath;

// Returns a request that will delete this object when run
- (EMASIS3ObjectRequest *)DELETERequest;

@property (retain) NSString *bucket;
@property (retain) NSString *key;
@property (retain) NSDate *lastModified;
@property (retain) NSString *ETag;
@property (assign) unsigned long long size;
@property (retain) NSString *ownerID;
@property (retain) NSString *ownerName;
@end
