package com.zendeskunified

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.Promise
import android.content.Intent
import android.util.Log
import java.util.Locale
import zendesk.chat.Chat
import zendesk.chat.ChatEngine
import zendesk.chat.ChatConfiguration
import zendesk.chat.PreChatFormFieldStatus
import zendesk.core.AnonymousIdentity
import zendesk.core.JwtIdentity
import zendesk.core.Zendesk
import zendesk.support.Support
import zendesk.support.guide.HelpCenterActivity
import zendesk.support.guide.ViewArticleActivity
import zendesk.support.request.RequestActivity
import zendesk.support.requestlist.RequestListActivity
import zendesk.classic.messaging.MessagingActivity

class ZendeskUnifiedModule(reactContext: ReactApplicationContext) :
  ReactContextBaseJavaModule(reactContext) {

  private val context = getReactApplicationContext()

  override fun getName(): String {
    return NAME
  }

  companion object {
    const val NAME = "ZendeskUnified"
  }

  @ReactMethod
  fun healthCheck(promise: Promise) {
    promise.resolve("Module compiling and working")
  }

  @ReactMethod
  fun initialize(
    appId: String,
    clientId: String,
    zendeskUrl: String,
    accountKey: String?,
    promise: Promise
  ) {
    initializeZendesk(appId, clientId, zendeskUrl)

    // if (accountKey != null) {
    //   initializeChat(accountKey)
    // }
  }

  @ReactMethod
  fun setAnonymousIdentity(
    email: String?,
    name: String?,
    promise: Promise
  ) {
    setAnonymousIdentity(email, name)
  }

  @ReactMethod
  fun setIdentity(
    jwt: String,
    promise: Promise
  ) {
    setIdentity(jwt)
  }

// AsyncFunction("setIdentity") { jwt: String -> setIdentity(jwt) }

// AsyncFunction("openHelpCenter") { labels: List<String>, groupType: String?, groupIds: List<Long>
//   ->
//   openHelpCenter(labels, groupType, groupIds)
// }

// AsyncFunction("openTicket") { ticketId: String -> openTicket(ticketId) }

// AsyncFunction("openNewTicket") { subject: String?, tags: List<String>? ->
//   openNewTicket(subject, tags)
// }

// AsyncFunction("listTickets") { listTickets() }

// AsyncFunction("openArticle") { articleId: Long -> openArticle(articleId) }

// AsyncFunction("setHelpCenterLocaleOverride") { locale: String ->
//   setHelpCenterLocaleOverride(locale)
// }

// AsyncFunction("changeTheme") { color: String ->
//   Log.d("ExpoZendesk", "changeTheme is not supported on Android.")
// }

// AsyncFunction("initializeChat") { accountKey: String -> initializeChat(accountKey) }

// AsyncFunction("startChat") {
//   botName: String?,
//   multilineResponseOptionsEnabled: Boolean?,
//   agentAvailabilityEnabled: Boolean?,
//   transcriptEnabled: Boolean?,
//   offlineFormsEnabled: Boolean?,
//   preChatFormEnabled: Boolean?,
//   preChatFormOptions: Map<String, String>? ->
//   startChat(
//     botName,
//     multilineResponseOptionsEnabled,
//     agentAvailabilityEnabled,
//     transcriptEnabled,
//     offlineFormsEnabled,
//     preChatFormEnabled,
//     preChatFormOptions
//   )
// }
// }

  private fun initializeZendesk(appId: String, clientId: String, zendeskUrl: String) {
    Zendesk.INSTANCE.init(context, zendeskUrl, appId, clientId)
    Support.INSTANCE.init(Zendesk.INSTANCE)
  }

  private fun setAnonymousIdentity(email: String?, name: String?) {
    val builder = AnonymousIdentity.Builder()

    if (email != null) {
      builder.withEmailIdentifier(email)
    }

    if (name != null) {
      builder.withNameIdentifier(name)
    }

    Zendesk.INSTANCE.setIdentity(builder.build())
  }

  private fun setIdentity(jwt: String) {
    Zendesk.INSTANCE.setIdentity(JwtIdentity(jwt))
  }

  private fun openHelpCenter(labels: List<String>, groupType: String?, groupIds: List<Long>) {
    val helpCenterConfig = HelpCenterActivity.builder()

    if (labels.isNotEmpty()) {
      helpCenterConfig.withLabelNames(labels)
    }

    if (groupType != null && groupIds.isNotEmpty()) {
      if (groupType == "category") {
        helpCenterConfig.withArticlesForCategoryIds(groupIds)
      } else if (groupType == "section") {
        helpCenterConfig.withArticlesForSectionIds(groupIds)
      }
    }

    val intent: Intent = helpCenterConfig.intent(context)
    intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK

    context.startActivity(intent)
    }

    private fun openTicket(ticketId: String) {
    var requestConfig = RequestActivity.builder()

    requestConfig.withRequestId(ticketId)

    val intent: Intent = requestConfig.intent(context)
    intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK

    context.startActivity(intent)
  }

  private fun openNewTicket(subject: String?, tags: List<String>?) {
    var requestConfig = RequestActivity.builder()

    if (subject != null) {
      requestConfig.withRequestSubject(subject)
    }

    if (tags != null && tags.isNotEmpty()) {
      requestConfig.withTags(tags)
    }

    val intent: Intent = requestConfig.intent(context)
    intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK

    context.startActivity(intent)
  }

  private fun listTickets() {
    var requestListConfig = RequestListActivity.builder()

    val intent: Intent = requestListConfig.intent(context)
    intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK

    context.startActivity(intent)
  }

  private fun openArticle(articleId: Long) {
    var viewArticleConfig = ViewArticleActivity.builder(articleId)

    val intent: Intent = viewArticleConfig.intent(context)
    intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK

    context.startActivity(intent)
  }

  private fun setHelpCenterLocaleOverride(locale: String) {
    val userLocale = Locale(locale)

    Support.INSTANCE.setHelpCenterLocaleOverride(userLocale)
  }

// Chat functions
  private fun initializeChat(accountKey: String) {
    Chat.INSTANCE.init(context, accountKey)
  }

  private fun startChat(
    botName: String?,
    multilineResponseOptionsEnabled: Boolean?,
    agentAvailabilityEnabled: Boolean?,
    transcriptEnabled: Boolean?,
    offlineFormsEnabled: Boolean?,
    preChatFormEnabled: Boolean?,
    preChatFormOptions: Map<String, String>?
    ) {
    val messagingConfiguration = MessagingActivity.builder()
    val chatEngine = ChatEngine.engine()
    val chatConfiguration = ChatConfiguration.builder()

    if (botName != null) {
      messagingConfiguration.withBotLabelString(botName)
    }

    if (multilineResponseOptionsEnabled != null) {
      messagingConfiguration.withMultilineResponseOptionsEnabled(multilineResponseOptionsEnabled)
    }

    if (agentAvailabilityEnabled != null) {
      chatConfiguration.withAgentAvailabilityEnabled(agentAvailabilityEnabled)
    }

    if (transcriptEnabled != null) {
      chatConfiguration.withTranscriptEnabled(transcriptEnabled)
    }

    if (offlineFormsEnabled != null) {
      chatConfiguration.withOfflineFormEnabled(offlineFormsEnabled)
    }

    if (preChatFormEnabled != null) {
      chatConfiguration.withPreChatFormEnabled(preChatFormEnabled)
    }

    if (preChatFormOptions != null) {
      if (preChatFormOptions.containsKey("nameFieldStatus")) {
        chatConfiguration.withNameFieldStatus(
          getPreChatFormFieldStatus(preChatFormOptions["nameFieldStatus"]!!)
        )
      }

      if (preChatFormOptions.containsKey("emailFieldStatus")) {
        chatConfiguration.withEmailFieldStatus(
          getPreChatFormFieldStatus(preChatFormOptions["emailFieldStatus"]!!)
        )
      }

      if (preChatFormOptions.containsKey("phoneFieldStatus")) {
        chatConfiguration.withPhoneFieldStatus(
          getPreChatFormFieldStatus(preChatFormOptions["phoneFieldStatus"]!!)
        )
      }

      if (preChatFormOptions.containsKey("departmentFieldStatus")) {
        chatConfiguration.withDepartmentFieldStatus(
          getPreChatFormFieldStatus(preChatFormOptions["departmentFieldStatus"]!!)
        )
      }
    }

    val intent: Intent = messagingConfiguration
      .withEngines(chatEngine)
      .intent(context, chatConfiguration.build())

    intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK

    context.startActivity(intent)
  }

  private fun getPreChatFormFieldStatus(status: String): PreChatFormFieldStatus {
    return when (status) {
      "required" -> PreChatFormFieldStatus.REQUIRED
      "optional" -> PreChatFormFieldStatus.OPTIONAL
      "hidden" -> PreChatFormFieldStatus.HIDDEN
      else -> PreChatFormFieldStatus.HIDDEN
    }
  }
}