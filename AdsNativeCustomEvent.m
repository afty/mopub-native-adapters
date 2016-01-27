//
//  AdsNativeCustomEvent.m
//  AftyChat
//
//  Created by Charles Chase on 1/26/16.
//  Copyright © 2016 AFTY, LLC. All rights reserved.
//

#import "AdsNativeCustomEvent.h"
#import "AdsNativeAdAdapter.h"
#import <AdsNativeSDK/AdsNativeSDK.h>
#import "MPNativeAd.h"
#import "MPNativeAdError.h"
#import "MPLogging.h"

@interface AdsNativeCustomEvent () <ANNativeAdDelegate>

@property (nonatomic, retain) ANNativeAd *adNative;

@end

@implementation AdsNativeCustomEvent

- (void)requestAdWithCustomEventInfo:(NSDictionary *)info
{
    NSString *placementId = [info objectForKey:@"placementId"];
    if (placementId) {
        self.adNative = [[ANNativeAd alloc] initWithAdUnitId:placementId viewController:AppManager.rootViewController];
        self.adNative.delegate = self;
        [self.adNative loadAd];
    } else {
        [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:[NSError errorWithDomain:MoPubNativeAdsSDKDomain code:MPNativeAdErrorInvalidServerResponse userInfo:nil]];
    }
}

#pragma mark - Ads Native Ad Delegate

- (void)anNativeAdDidLoad:(ANNativeAd *)nativeAd
{
    AdsNativeAdAdapter *adAdapter = [[AdsNativeAdAdapter alloc] initWithNativeAd:nativeAd];
    MPNativeAd *interfaceAd = [[MPNativeAd alloc] initWithAdAdapter:adAdapter];
    
    NSMutableArray *imageURLs = [NSMutableArray array];
    
    if ([nativeAd.nativeAssets objectForKey:kNativeIconImageKey]) {
        [imageURLs addObject:[NSURL URLWithString:[nativeAd.nativeAssets objectForKey:kNativeIconImageKey]]];
    }
    
    if ([nativeAd.nativeAssets objectForKey:kNativeMainImageKey]) {
        [imageURLs addObject:[NSURL URLWithString:[nativeAd.nativeAssets objectForKey:kNativeMainImageKey]]];
    }
    
    [super precacheImagesWithURLs:imageURLs completionBlock:^(NSArray *errors) {
        if (errors) {
            MPLogDebug(@"%@", errors);
            MPLogInfo(@"Error: data received was invalid.");
            [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:[NSError errorWithDomain:MoPubNativeAdsSDKDomain code:MPNativeAdErrorInvalidServerResponse userInfo:nil]];
        } else {
            [self.delegate nativeCustomEvent:self didLoadAd:interfaceAd];
        }
    }];
}

- (void)anNativeAd:(ANNativeAd *)nativeAd didFailWithError:(NSError *)error
{
    [self.delegate nativeCustomEvent:self didFailToLoadAdWithError:error];
}

@end
