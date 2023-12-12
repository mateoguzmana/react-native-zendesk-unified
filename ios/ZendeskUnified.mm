#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(ZendeskUnified, NSObject)

RCT_EXTERN_METHOD(
  multiply: (float)a
  withB: (float)b
  withResolver: (RCTPromiseResolveBlock)resolve
  withRejecter: (RCTPromiseRejectBlock)reject
)

RCT_EXTERN_METHOD(
  healthCheck:(RCTPromiseResolveBlock)resolve
  withRejecter:(RCTPromiseRejectBlock)reject
)

RCT_EXTERN_METHOD(
  initialize: (NSString *)appId
  withClientId: (NSString *)clientId
  withZendeskUrl: (NSString *)zendeskUrl
  withAccountKey: (NSString *)accountKey
  withResolver: (RCTPromiseResolveBlock)resolve
  withRejecter: (RCTPromiseRejectBlock)reject
)

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
