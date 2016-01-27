//
//  AdsNativeAdAdapter.m
//  AftyChat
//
//  Created by Charles Chase on 1/26/16.
//  Copyright © 2016 AFTY, LLC. All rights reserved.
//

#import "AdsNativeAdAdapter.h"
#import "MPNativeAdConstants.h"
#import "MPNativeAdError.h"
#import "MPLogging.h"
#import "AFTY_AdManager.h"

@interface AdsNativeAdAdapter() <ANNativeAdDelegate>

@property (nonatomic, strong) ANNativeAd *adNative;

@end

@implementation AdsNativeAdAdapter

@synthesize properties = _properties;

- (instancetype)initWithNativeAd:(ANNativeAd *)adNative
{
    self = [super init];
    
    if (self)
    {
        _adNative = adNative;
        _adNative.delegate = self;
        
        NSMutableDictionary *properties = [NSMutableDictionary dictionary];
        
        [properties setObject:kAdNetworkAdsNative forKey:kAdNetwork];
        
        if ([adNative.nativeAssets objectForKey:kNativeTitleKey])
        {
            [properties setObject:[adNative.nativeAssets objectForKey:kNativeTitleKey] forKey:kAdTitleKey];
        }
        if ([adNative.nativeAssets objectForKey:kNativeTextKey])
        {
            [properties setObject:[adNative.nativeAssets objectForKey:kNativeTextKey] forKey:kAdTextKey];
        }
        if ([adNative.nativeAssets objectForKey:kNativeIconImageKey])
        {
            [properties setObject:[adNative.nativeAssets objectForKey:kNativeIconImageKey] forKey:kAdIconImageKey];
        }
        if ([adNative.nativeAssets objectForKey:kNativeMainImageKey])
        {
            [properties setObject:[adNative.nativeAssets objectForKey:kNativeMainImageKey] forKey:kAdMainImageKey];
        }
        if ([adNative.nativeAssets objectForKey:kNativeCTATextKey] && [[adNative.nativeAssets objectForKey:kNativeCTATextKey] length] > 0)
        {
            [properties setObject:[adNative.nativeAssets objectForKey:kNativeCTATextKey] forKey:kAdCTATextKey];
        }
        else
        {
            [properties setObject:@"Learn More" forKey:kAdCTATextKey];
        }

        _properties = properties;
    }
    
    return self;
}

- (void)dealloc
{
    _adNative.delegate = nil;
    _adNative = nil;
}

#pragma mark - MPNativeAdAdapter

- (NSURL*)defaultActionURL
{
    return nil;
}

- (void)willAttachToView:(UIView *)view
{
    [self.adNative registerNativeAdForView:view];
}

- (void)didDetachFromView:(UIView *)view {}

#pragma mark - ANNativeAdDelegate

- (void)anNativeAdDidLoad:(ANNativeAd *)nativeAd {}
- (void)anNativeAdDidRecordImpression {}
- (void)anNativeAd:(ANNativeAd *)nativeAd didFailWithError:(NSError *)error {}

@end
