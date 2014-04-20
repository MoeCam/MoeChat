//
//  HttpUtils.h
//  EaseMobClientSDK
//
//  Created by Ji Fang on 9/21/13.
//  Copyright (c) 2013 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpStatusCodeDefs.h"

@interface HttpUtils : NSObject

#pragma mark - http method
+(NSDictionary *)httpDelete:(NSString *)aUri
                    headers:(NSArray *)headers
                  parameter:(NSDictionary *)aParam
                 credential:(NSString *)aCredential
               responseCode:(int *)pRespCode;
+(NSDictionary *)httpPut:(NSString *)aUri
                 headers:(NSArray *)headers
               parameter:(NSDictionary *)aParam
              credential:(NSString *)aCredential
            responseCode:(int *)pRespCode;
+(NSDictionary *)httpGet:(NSString *)aUri
                 headers:(NSArray *)headers
               parameter:(NSDictionary *)aParam
              credential:(NSString *)aCredential
            responseCode:(int *)pRespCode;
+(NSDictionary *)httpPost:(NSString *)aUri
                  headers:(NSArray *)headers
                parameter:(NSDictionary *)aParam
               credential:(NSString *)aCredential
             responseCode:(int *)pRespCode;

#pragma mark - http method with basic authentication
+(NSDictionary *)httpDelete:(NSString *)aUri
                    headers:(NSArray *)headers
                  parameter:(NSDictionary *)aParam
                   username:(NSString *)username
                   password:(NSString *)password
               responseCode:(int *)pRespCode;
+(NSDictionary *)httpPut:(NSString *)aUri
                 headers:(NSArray *)headers
               parameter:(NSDictionary *)aParam
                username:(NSString *)username
                password:(NSString *)password
            responseCode:(int *)pRespCode;
+(NSDictionary *)httpGet:(NSString *)aUri
                 headers:(NSArray *)headers
               parameter:(NSDictionary *)aParam
                username:(NSString *)username
                password:(NSString *)password
            responseCode:(int *)pRespCode;
+(NSDictionary *)httpPost:(NSString *)aUri
                  headers:(NSArray *)headers
                parameter:(NSDictionary *)aParam
                 username:(NSString *)username
                 password:(NSString *)password
             responseCode:(int *)pRespCode;

#pragma mark - https methods
#pragma mark - http method
+(NSDictionary *)httpsDelete:(NSString *)aUri
                    headers:(NSArray *)headers
                  parameter:(NSDictionary *)aParam
                 credential:(NSString *)aCredential
               responseCode:(int *)pRespCode;
+(NSDictionary *)httpsPut:(NSString *)aUri
                 headers:(NSArray *)headers
               parameter:(NSDictionary *)aParam
              credential:(NSString *)aCredential
            responseCode:(int *)pRespCode;
+(NSDictionary *)httpsGet:(NSString *)aUri
                 headers:(NSArray *)headers
               parameter:(NSDictionary *)aParam
              credential:(NSString *)aCredential
            responseCode:(int *)pRespCode;
+(NSDictionary *)httpsPost:(NSString *)aUri
                  headers:(NSArray *)headers
                parameter:(NSDictionary *)aParam
               credential:(NSString *)aCredential
             responseCode:(int *)pRespCode;

#pragma mark - http method with basic authentication
+(NSDictionary *)httpsDelete:(NSString *)aUri
                    headers:(NSArray *)headers
                  parameter:(NSDictionary *)aParam
                   username:(NSString *)username
                   password:(NSString *)password
               responseCode:(int *)pRespCode;
+(NSDictionary *)httpsPut:(NSString *)aUri
                 headers:(NSArray *)headers
               parameter:(NSDictionary *)aParam
                username:(NSString *)username
                password:(NSString *)password
            responseCode:(int *)pRespCode;
+(NSDictionary *)httpsGet:(NSString *)aUri
                 headers:(NSArray *)headers
               parameter:(NSDictionary *)aParam
                username:(NSString *)username
                password:(NSString *)password
            responseCode:(int *)pRespCode;
+(NSDictionary *)httpsPost:(NSString *)aUri
                  headers:(NSArray *)headers
                parameter:(NSDictionary *)aParam
                 username:(NSString *)username
                 password:(NSString *)password
             responseCode:(int *)pRespCode;

@end
