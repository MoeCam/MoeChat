//
//  DirectoryUtils.h
//  EaseMobClientSDK
//
//  Created by jifang on 8/26/13.
//  Copyright (c) 2013 EaseMob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DirectoryUtils : NSObject

+ (NSString *)chatBufferDir;
+ (NSString *)applicationHomeDirectory;
+ (NSString *)applicationLibraryDirectory;
+ (NSString *)applicationDocumentsDirectory;
+ (NSString *)applicationTemporaryDirectory;
+ (NSString *)applicationLogDirectory;

+ (NSString *)generateTimeBasedStringForString:(NSString *)string;
+ (NSString *)generateTimeBasedFileNameForUser:(NSString *)userId andFileName:(NSString *)fileName;
+ (NSInteger)randomNumber;

+ (NSString *)generateUUID;
+ (NSString *)generateTrimmedUUID;

@end
