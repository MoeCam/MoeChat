//
//  EMLog.h
//  EaseMobClientSDK
//
//  Created by jifang on 8/28/13.
//  Copyright (c) 2013 EaseMob. All rights reserved.
//

// log
#import "DDLog.h"

// Log levels: off, error, warn, info, verbose
#if DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_INFO;
#endif

#define EMLog DDLogVerbose