import SupportSDK
import ZendeskCoreSDK
import AnswerBotProvidersSDK
import SDKConfigurations
import CommonUISDK
import AnswerBotSDK
import ChatSDK
import ChatProvidersSDK
import MessagingSDK

@objc(ZendeskUnified)
class ZendeskUnified: NSObject {
  @objc(healthCheck:withRejecter:)
  func healthCheck(resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void {
    resolve("Module compiling and working")
  }

  @objc(initialize:withResolver:withRejecter:)
  func initialize(
    config: NSDictionary,
    resolve: RCTPromiseResolveBlock,
    reject: RCTPromiseRejectBlock
  ) -> Void {
    let appId = config["appId"] as! String
    let clientId = config["clientId"] as! String
    let zendeskUrl = config["zendeskUrl"] as! String
    let accountKey = config["accountKey"] as? String

    initializeZendesk(appId: appId, clientId: clientId, zendeskUrl: zendeskUrl)

    if let accountKey = accountKey {
      initializeChat(accountKey: accountKey)
    }
  }

  @objc(setAnonymousIdentity:withResolver:withRejecter:)
  func setAnonymousIdentity(
    options: NSDictionary,
    resolve: RCTPromiseResolveBlock,
    reject: RCTPromiseRejectBlock
  ) -> Void {
    let email = options["email"] as? String
    let name = options["name"] as? String

    setAnonymousIdentity(email: email, name: name)
  }

  @objc(setIdentity:withResolver:withRejecter:)
  func setIdentity(
    jwt: String,
    resolve: RCTPromiseResolveBlock,
    reject: RCTPromiseRejectBlock
  ) -> Void {
    setIdentity(jwt: jwt)
  }

  @objc(openHelpCenter:withResolver:withRejecter:)
  func openHelpCenter(
    options: NSDictionary,
    resolve: RCTPromiseResolveBlock,
    reject: RCTPromiseRejectBlock
  ) -> Void {
    let labels = options["labels"] as? [String]
    let groupType = options["groupType"] as? String
    let groupIds = options["groupIds"] as? [NSNumber]

    openHelpCenter(labels: labels, groupType: groupType, groupIds: groupIds)
  }

  @objc(openTicket:withResolver:withRejecter:)
  func openTicket(
    ticketId: String,
    resolve: RCTPromiseResolveBlock,
    reject: RCTPromiseRejectBlock
  ) -> Void {
    openTicket(ticketId: ticketId)
  }

  @objc(openNewTicket:withTags:withResolver:withRejecter:)
  func openNewTicket(
    subject: String?,
    tags: [String]?,
    resolve: RCTPromiseResolveBlock,
    reject: RCTPromiseRejectBlock
  ) -> Void {
    openNewTicket(subject: subject, tags: tags)
  }

  @objc(listTickets:withRejecter:)
  func listTickets(
    resolve: RCTPromiseResolveBlock,
    reject: RCTPromiseRejectBlock
  ) -> Void {
    listTickets()
  }

  @objc(openArticle:withResolver:withRejecter:)
  func openArticle(
    articleId: String,
    resolve: RCTPromiseResolveBlock,
    reject: RCTPromiseRejectBlock
  ) -> Void {
    print("openArticle called with articleId: \(articleId)")

    openArticle(articleId: articleId)
  }

  @objc(setHelpCenterLocaleOverride:withResolver:withRejecter:)
  func setHelpCenterLocaleOverride(
    locale: String,
    resolve: RCTPromiseResolveBlock,
    reject: RCTPromiseRejectBlock
  ) -> Void {
    setHelpCenterLocaleOverride(locale: locale)
  }

  @objc(changeTheme:withResolver:withRejecter:)
  func changeTheme(
    color: String,
    resolve: RCTPromiseResolveBlock,
    reject: RCTPromiseRejectBlock
  ) -> Void {
    changeTheme(color: color)
  }

  @objc(initializeChat:withResolver:withRejecter:)
  func initializeChat(
    accountKey: String,
    resolve: RCTPromiseResolveBlock,
    reject: RCTPromiseRejectBlock
  ) -> Void {
    initializeChat(accountKey: accountKey)
  }

  @objc(startChat:withResolver:withRejecter:)
  func startChat(
    options: NSDictionary?,
    resolve: RCTPromiseResolveBlock,
    reject: RCTPromiseRejectBlock
  ) -> Void {
    let botName = options?["botName"] as? String
    let multilineResponseOptionsEnabled = options?["multilineResponseOptionsEnabled"] as? Bool
    let agentAvailabilityEnabled = options?["agentAvailabilityEnabled"] as? Bool
    let transcriptEnabled = options?["transcriptEnabled"] as? Bool
    let offlineFormsEnabled = options?["offlineFormsEnabled"] as? Bool
    let preChatFormEnabled = options?["preChatFormEnabled"] as? Bool
    let preChatFormOptions = options?["preChatFormOptions"] as? [String?: String?]

    startChat(
      botName: botName,
      multilineResponseOptionsEnabled: multilineResponseOptionsEnabled,
      agentAvailabilityEnabled: agentAvailabilityEnabled,
      transcriptEnabled: transcriptEnabled,
      offlineFormsEnabled: offlineFormsEnabled,
      preChatFormEnabled: preChatFormEnabled,
      preChatFormOptions: preChatFormOptions
    )
  }

  @objc(startAnswerBot:withRejecter:)
  func startAnswerBot(
    resolve: RCTPromiseResolveBlock,
    reject: RCTPromiseRejectBlock
  ) -> Void {
    startAnswerBot()
  }

  private func initializeZendesk(
    appId: String,
    clientId: String,
    zendeskUrl: String
  ) { 
    Zendesk.initialize(appId: appId, clientId: clientId, zendeskUrl: zendeskUrl)
    Support.initialize(withZendesk: Zendesk.instance)
    AnswerBot.initialize(withZendesk: Zendesk.instance, support: Support.instance!)
  }

  private func setAnonymousIdentity(email: String?, name: String?) {
    var identity = Identity.createAnonymous()

    if let email = email {
      if let name = name {
        identity = Identity.createAnonymous(name: name, email: email)
      }

      identity = Identity.createAnonymous(email: email)
    }

    Zendesk.instance?.setIdentity(identity)
  }

  private func setIdentity(jwt: String) {
    let identity = Identity.createJwt(token: jwt)

    Zendesk.instance?.setIdentity(identity)
  }

  private func openHelpCenter(
    labels: [String]?,
    groupType: String?,
    groupIds: [NSNumber]?
  ) {
    DispatchQueue.main.async {
      let helpCenterConfig = HelpCenterUiConfiguration()

      if let labels = labels {
        helpCenterConfig.labels = labels
      }

      if let groupType = groupType {
        if groupType == "category" {
          helpCenterConfig.groupType = .category
        } else if groupType == "section" {
          helpCenterConfig.groupType = .section
        }
      }

      if let groupIds = groupIds {
        helpCenterConfig.groupIds = groupIds
      }

      // @TODO: pass this as a config
      helpCenterConfig.showContactOptions = true

      let helpCenterController = HelpCenterUi.buildHelpCenterOverviewUi(withConfigs: [helpCenterConfig])
      let navigationController = UINavigationController(rootViewController: helpCenterController)

      UIApplication.shared.keyWindow?.rootViewController?.present(navigationController, animated: true, completion: nil)
    }
  }

  private func openTicket(ticketId: String) {
    DispatchQueue.main.async {
      let requestController = RequestUi.buildRequestUi(requestId: ticketId)
      let navigationController = UINavigationController(rootViewController: requestController)

      UIApplication.shared.keyWindow?.rootViewController?.present(navigationController, animated: true, completion: nil)
    }
  }

  private func openNewTicket(
    subject: String?,
    tags: [String]?
  ) {
    DispatchQueue.main.async {
      let requestConfig = RequestUiConfiguration()

      if let tags = tags {
        requestConfig.tags = tags
      }

      if let subject = subject {
        requestConfig.subject = subject
      }

      let requestController = RequestUi.buildRequestUi(with: [requestConfig])
      let navigationController = UINavigationController(rootViewController: requestController)

      UIApplication.shared.keyWindow?.rootViewController?.present(navigationController, animated: true, completion: nil)
    }
  }

  private func listTickets() {
    DispatchQueue.main.async {
      let requestListConfig = RequestListUIConfiguration()
      requestListConfig.allowRequestCreation = true

      let requestListController = RequestUi.buildRequestList(with: [requestListConfig])
      let navigationController = UINavigationController(rootViewController: requestListController)

      UIApplication.shared.keyWindow?.rootViewController?.present(navigationController, animated: true, completion: nil)
    }
  }

  private func openArticle(articleId: String) {
    DispatchQueue.main.async {
      let articleController = HelpCenterUi.buildHelpCenterArticleUi(withArticleId: articleId, andConfigs: [])
      let navigationController = UINavigationController(rootViewController: articleController)

      UIApplication.shared.keyWindow?.rootViewController?.present(navigationController, animated: true, completion: nil)
    }
  }

  private func setHelpCenterLocaleOverride(locale: String) {
    Support.instance?.helpCenterLocaleOverride = locale
  }

  private func changeTheme(color: String) {
    CommonTheme.currentTheme.primaryColor = UIColorFromHex(color)
  }

  // Converts hex string to UIColor
  private func UIColorFromHex(_ hex: String, alpha: CGFloat = 1.0) -> UIColor {
    var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
    hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

    var rgb: UInt64 = 0

    Scanner(string: hexSanitized).scanHexInt64(&rgb)

    let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
    let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
    let blue = CGFloat(rgb & 0x0000FF) / 255.0

    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
  }

  private func initializeChat(accountKey: String) {
    Chat.initialize(accountKey: accountKey)
  }

  private func startChat(
    botName: String?,
    multilineResponseOptionsEnabled: Bool?,
    agentAvailabilityEnabled: Bool?,
    transcriptEnabled: Bool?,
    offlineFormsEnabled: Bool?,
    preChatFormEnabled: Bool?,
    preChatFormOptions: [String?: String?]?
  ) {
    DispatchQueue.main.async {
      do {
        let chatEngine = try ChatEngine.engine()
        let chatConfiguration = ChatConfiguration()
        let chatFormConfiguration = ChatFormConfiguration()
        let messagingConfiguration = MessagingConfiguration()

        if let botName = botName {
          messagingConfiguration.name = botName
        }

        if let multilineResponseOptionsEnabled = multilineResponseOptionsEnabled {
          messagingConfiguration.isMultilineResponseOptionsEnabled = multilineResponseOptionsEnabled
        }

        if let agentAvailabilityEnabled = agentAvailabilityEnabled {
          chatConfiguration.isAgentAvailabilityEnabled = agentAvailabilityEnabled
        }

        if let transcriptEnabled = transcriptEnabled {
          chatConfiguration.isChatTranscriptPromptEnabled = transcriptEnabled
        }

        if let offlineFormsEnabled = offlineFormsEnabled {
          chatConfiguration.isOfflineFormEnabled = offlineFormsEnabled
        }

        if let preChatFormEnabled = preChatFormEnabled {
          chatConfiguration.isPreChatFormEnabled = preChatFormEnabled
        }

        if let preChatFormOptions = preChatFormOptions {
          if let name = preChatFormOptions["nameFieldStatus"] {
            chatFormConfiguration.name = self.getPreChatFormFieldStatus(status: name)
          }

          if let email = preChatFormOptions["emailFieldStatus"] {
            chatFormConfiguration.email = self.getPreChatFormFieldStatus(status: email)
          }

          if let phone = preChatFormOptions["phoneFieldStatus"] {
            chatFormConfiguration.phoneNumber = self.getPreChatFormFieldStatus(status: phone)
          }

          if let department = preChatFormOptions["departmentFieldStatus"] {
            chatFormConfiguration.department = self.getPreChatFormFieldStatus(status: department)
          }
        }

        chatConfiguration.preChatFormConfiguration = chatFormConfiguration

        let viewController = try Messaging.instance.buildUI(
          engines: [chatEngine],
          configs: [chatConfiguration, messagingConfiguration]
        )
        let navigationController = UINavigationController(rootViewController: viewController)

        UIApplication.shared.keyWindow?.rootViewController?.present(navigationController, animated: true, completion: nil)
      } catch {
        print("Error initializing ChatEngine")
      }
    }
  }

  private func getPreChatFormFieldStatus(status: String?) -> FormFieldStatus {
    switch status {
      case "required":
        return .required
      case "optional":
        return .optional
      case "hidden":
        return .hidden
      default:
        return .hidden
    }
  }

  private func startAnswerBot() {
    DispatchQueue.main.async {
      do {
        let answerBotEngine = try AnswerBotEngine.engine()
        let messagingConfiguration = MessagingConfiguration()

        let viewController = try Messaging.instance.buildUI(
          engines: [answerBotEngine],
          configs: [messagingConfiguration]
        )
        let navigationController = UINavigationController(rootViewController: viewController)

        UIApplication.shared.keyWindow?.rootViewController?.present(navigationController, animated: true, completion: nil)
      } catch {
        print("Error initializing AnswerBotEngine")
      }
    }
  }  
}
