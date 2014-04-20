//
//  EMASICloudFilesContainerRequest.h
//
//  Created by Michael Mayo on 1/6/10.
//

#import "ASICloudFilesRequest.h"

@class EMASICloudFilesContainer, EMASICloudFilesContainerXMLParserDelegate;

@interface EMASICloudFilesContainerRequest : EMASICloudFilesRequest {
	
	// Internally used while parsing the response
	NSString *currentContent;
	NSString *currentElement;
	EMASICloudFilesContainer *currentObject;
	EMASICloudFilesContainerXMLParserDelegate *xmlParserDelegate;
}

@property (retain) NSString *currentElement;
@property (retain) NSString *currentContent;
@property (retain) EMASICloudFilesContainer *currentObject;
@property (retain) EMASICloudFilesContainerXMLParserDelegate *xmlParserDelegate;

// HEAD /<api version>/<account>
// HEAD operations against an account are performed to retrieve the number of Containers and the total bytes stored in Cloud Files for the account. This information is returned in two custom headers, X-Account-Container-Count and X-Account-Bytes-Used.
+ (id)accountInfoRequest;
- (NSUInteger)containerCount;
- (NSUInteger)bytesUsed;

// GET /<api version>/<account>/<container>
// Create a request to list all containers
+ (id)listRequest;
+ (id)listRequestWithLimit:(NSUInteger)limit marker:(NSString *)marker;
- (NSArray *)containers;

// PUT /<api version>/<account>/<container>
+ (id)createContainerRequest:(NSString *)containerName;

// DELETE /<api version>/<account>/<container>
+ (id)deleteContainerRequest:(NSString *)containerName;

@end
