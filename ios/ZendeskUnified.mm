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

// @objc(openHelpCenter:withGroupType:withGroupIds:withResolver:withRejecter:)
//   func openHelpCenter(
//     labels: [String]?,
//     groupType: String?,
//     groupIds: [NSNumber]?,
//     resolve: RCTPromiseResolveBlock,
//     reject: RCTPromiseRejectBlock
//   ) -> Void {
//     openHelpCenter(labels: labels, groupType: groupType, groupIds: groupIds)
//   }

//   @objc(openTicket:withResolver:withRejecter:)
//   func openTicket(
//     ticketId: String,
//     resolve: RCTPromiseResolveBlock,
//     reject: RCTPromiseRejectBlock
//   ) -> Void {
//     openTicket(ticketId: ticketId)
//   }

//   @objc(openNewTicket:withTags:withResolver:withRejecter:)
//   func openNewTicket(
//     subject: String?,
//     tags: [String]?,
//     resolve: RCTPromiseResolveBlock,
//     reject: RCTPromiseRejectBlock
//   ) -> Void {
//     openNewTicket(subject: subject, tags: tags)
//   }

//   @objc(listTickets:withRejecter:)
//   func listTickets(
//     resolve: RCTPromiseResolveBlock,
//     reject: RCTPromiseRejectBlock
//   ) -> Void {
//     listTickets()
//   }

//   @objc(openArticle:withResolver:withRejecter:)
//   func openArticle(
//     articleId: String,
//     resolve: RCTPromiseResolveBlock,
//     reject: RCTPromiseRejectBlock
//   ) -> Void {
//     openArticle(articleId: articleId)
//   }

//   @objc(setHelpCenterLocaleOverride:withResolver:withRejecter:)
//   func setHelpCenterLocaleOverride(
//     locale: String,
//     resolve: RCTPromiseResolveBlock,
//     reject: RCTPromiseRejectBlock
//   ) -> Void {
//     setHelpCenterLocaleOverride(locale: locale)
//   }

//   @objc(changeTheme:withResolver:withRejecter:)
//   func changeTheme(
//     color: String,
//     resolve: RCTPromiseResolveBlock,
//     reject: RCTPromiseRejectBlock
//   ) -> Void {
//     changeTheme(color: color)
//   }

//   // Chat methods
//   @objc(initializeChat:withResolver:withRejecter:)
//   func initializeChat(
//     accountKey: String,
//     resolve: RCTPromiseResolveBlock,
//     reject: RCTPromiseRejectBlock
//   ) -> Void {
//     initializeChat(accountKey: accountKey)
//   }

+ (BOOL)requiresMainQueueSetup
{
  return NO;
}

@end
