#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "BKCloudComponent.h"
#import "BKCloudManager.h"
#import "BKCloudTools.h"
#import "BKCloudType.h"
#import "BKNetWorkManager.h"

FOUNDATION_EXPORT double BKCloudVersionNumber;
FOUNDATION_EXPORT const unsigned char BKCloudVersionString[];

