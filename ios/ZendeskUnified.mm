#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(ZendeskUnified, NSObject)

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

RCT_EXTERN_METHOD(
  setAnonymousIdentity: (NSString *)email
  withName: (NSString *)name
  withResolver: (RCTPromiseResolveBlock)resolve
  withRejecter: (RCTPromiseRejectBlock)reject
)
  
RCT_EXTERN_METHOD(
  setIdentity: (NSString *)jwt
  withResolver: (RCTPromiseResolveBlock)resolve
  withRejecter: (RCTPromiseRejectBlock)reject
)

RCT_EXTERN_METHOD(
  openHelpCenter: (NSArray *)labels
  withGroupType: (NSString *)groupType
  withGroupIds: (NSArray *)groupIds
  withResolver: (RCTPromiseResolveBlock)resolve
  withRejecter: (RCTPromiseRejectBlock)reject
)

RCT_EXTERN_METHOD(
  openTicket: (NSString *)ticketId
  withResolver: (RCTPromiseResolveBlock)resolve
  withRejecter: (RCTPromiseRejectBlock)reject
)

RCT_EXTERN_METHOD(
  openNewTicket: (NSString *)subject
  withTags: (NSArray *)tags
  withResolver: (RCTPromiseResolveBlock)resolve
  withRejecter: (RCTPromiseRejectBlock)reject
)

RCT_EXTERN_METHOD(
  listTickets: (RCTPromiseResolveBlock)resolve
  withRejecter: (RCTPromiseRejectBlock)reject
)

RCT_EXTERN_METHOD(
  openTicketList: (RCTPromiseResolveBlock)resolve
  withRejecter: (RCTPromiseRejectBlock)reject
)

RCT_EXTERN_METHOD(
  openArticle: (NSString *)articleId
  withResolver: (RCTPromiseResolveBlock)resolve
  withRejecter: (RCTPromiseRejectBlock)reject
)

RCT_EXTERN_METHOD(
  setHelpCenterLocaleOverride: (NSString *)locale
  withResolver: (RCTPromiseResolveBlock)resolve
  withRejecter: (RCTPromiseRejectBlock)reject
)

RCT_EXTERN_METHOD(
  changeTheme: (NSString *)color
  withResolver: (RCTPromiseResolveBlock)resolve
  withRejecter: (RCTPromiseRejectBlock)reject
)

RCT_EXTERN_METHOD(
  initializeChat: (NSString *)accountKey
  withResolver: (RCTPromiseResolveBlock)resolve
  withRejecter: (RCTPromiseRejectBlock)reject
)

RCT_EXTERN_METHOD(
  startChat: (NSDictionary *)config
  withResolver: (RCTPromiseResolveBlock)resolve
  withRejecter: (RCTPromiseRejectBlock)reject
)

// RCT_EXTERN_METHOD(
//   startChat: (NSString *)botName
//   withMultilineResponseOptionsEnabled: (BOOL *)multilineResponseOptionsEnabled
//   withAgentAvailabilityEnabled: (BOOL *)agentAvailabilityEnabled
//   withTranscriptEnabled: (BOOL *)transcriptEnabled
//   withOfflineFormsEnabled: (BOOL *)offlineFormsEnabled
//   withPreChatFormEnabled: (BOOL *)preChatFormEnabled
//   withPreChatFormOptions: (NSDictionary *)preChatFormOptions
//   withResolver: (RCTPromiseResolveBlock)resolve
//   withRejecter: (RCTPromiseRejectBlock)reject
// )

RCT_EXTERN_METHOD(
  startAnswerBot: (RCTPromiseResolveBlock)resolve
  withRejecter: (RCTPromiseRejectBlock)reject
)

  // @objc(startAnswerBot:withRejecter:)
  // func startAnswerBot(
  //   resolve: RCTPromiseResolveBlock,
  //   reject: RCTPromiseRejectBlock
  // ) -> Void {
  //   startAnswerBot()
  // }

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
