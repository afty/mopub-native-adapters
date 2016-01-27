//
//  AdsNativeAdAdapter.h
//  AftyChat
//
//  Created by Charles Chase on 1/26/16.
//  Copyright © 2016 AFTY, LLC. All rights reserved.
//

#import "MPNativeAdAdapter.h"
#import <AdsNativeSDK/AdsNativeSDK.h>

@interface AdsNativeAdAdapter : NSObject <MPNativeAdAdapter>

@property (nonatomic, weak) id<MPNativeAdAdapterDelegate> delegate;

- (instancetype)initWithNativeAd:(ANNativeAd *)adNative;

@end
