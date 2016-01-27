//
//  AdsNativeCustomEvent.h
//  AftyChat
//
//  Created by Charles Chase on 1/26/16.
//  Copyright © 2016 AFTY, LLC. All rights reserved.
//

#if __has_include(<MoPub/MoPub.h>)
#import <MoPub/MoPub.h>
#else
#import "MPNativeCustomEvent.h"
#endif

@interface AdsNativeCustomEvent : MPNativeCustomEvent

@end
