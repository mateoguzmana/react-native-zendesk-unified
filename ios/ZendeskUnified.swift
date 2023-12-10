@objc(ZendeskUnified)
class ZendeskUnified: NSObject {

  @objc(multiply:withB:withResolver:withRejecter:)
  func multiply(a: Float, b: Float, resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
    resolve(a*b)
  }

  @objc(healthCheck:withRejecter:)
  func healthCheck(resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
    resolve("Module compiling and working")
  }

    //   Function("healthCheck") {
    //   return "Module compiling and working"
    // }

    // AsyncFunction("initialize") { (
    //   appId: String, 
    //   clientId: String,
    //   zendeskUrl: String,
    //   accountKey: String?
    // ) in
    //   initializeZendesk(appId: appId, clientId: clientId, zendeskUrl: zendeskUrl)

    //   if let accountKey = accountKey {
    //     initializeChat(accountKey: accountKey)
    //   }
    // }
  
}
