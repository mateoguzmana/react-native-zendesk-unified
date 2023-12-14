import { Platform } from 'react-native';
import {
  useZendesk,
  ZendeskContext,
  ZendeskProvider,
} from './ZendeskUnified.context';
import { ZendeskUnified } from './ZendeskUnified.module';
import type {
  OpenHelpCenterOptions,
  OpenNewTicketOptions,
  PreChatFormFieldsStatus,
  PreChatFormFieldStatus,
  SetAnonymousIdentityOptions,
  StartChatOptions,
  ZendeskConfig,
} from './ZendeskUnified.types';

export function multiply(a: number, b: number): Promise<number> {
  return ZendeskUnified.multiply(a, b);
}

export class Zendesk {
  constructor(config: ZendeskConfig) {
    if (Platform.OS === 'ios') {
      ZendeskUnified.initialize(config);
    } else {
      // @TODO: Pass the whole config as an object instead of individual props
      ZendeskUnified.initialize(
        config?.appId,
        config?.clientId,
        config?.zendeskUrl,
        config?.accountKey
      );
    }
  }

  /**
   * Returns whether the Zendesk module is available.
   */
  public healthCheck(): string {
    return ZendeskUnified.healthCheck();
  }

  /**
   * Sets an anonymous identity for the user using an email and/or name.
   */
  public async setAnonymousIdentity(options: SetAnonymousIdentityOptions) {
    // @TODO: Pass the whole config as an object instead of individual props
    await ZendeskUnified.setAnonymousIdentity(options?.email, options?.name);
  }

  /**
   * Sets the identity of the user using a JWT.
   * @param jwt The JWT to use for the identity.
   */
  public async setIdentity(jwt: string) {
    await ZendeskUnified.setIdentity(jwt);
  }

  // @TODO: Disable ticket creation in the help center by passing a flag
  // @TODO: Pass the whole config as an object instead of individual props
  /**
   * Opens the Zendesk Help Center.
   */
  public async openHelpCenter(options: OpenHelpCenterOptions) {
    await ZendeskUnified.openHelpCenter(
      options?.labels,
      options?.groupType,
      options?.groupIds
    );
  }

  /**
   * Opens a ticket with the given ID.
   * @param ticketId The ID of the ticket to open.
   */
  public async openTicket(ticketId: string) {
    await ZendeskUnified.openTicket(ticketId);
  }

  // @TODO: allow passing custom fields
  // @TODO: Pass the whole config as an object instead of individual props
  /**
   * Opens the ticket creation screen.
   */
  public async openNewTicket(options: OpenNewTicketOptions) {
    await ZendeskUnified.openNewTicket(options?.subject, options?.tags);
  }

  /**
   * Lets you show a list of the user's tickets. The user can review and update their tickets.
   */
  public async listTickets() {
    await ZendeskUnified.listTickets();
  }

  /**
   * Opens an article with the given ID.
   * @param articleId The ID of the article to open.
   */
  public async openArticle(articleId: number) {
    await ZendeskUnified.openArticle(
      Platform.OS === 'ios' ? articleId.toString() : articleId
    );
  }

  /**
   * Overrides the device locale and forces the Help Center to a specific language.
   * @param locale
   */
  public async setHelpCenterLocaleOverride(locale: string) {
    await ZendeskUnified.setHelpCenterLocaleOverride(locale);
  }

  /**
   * iOS only: Changes the color theme of the Zendesk Help Center.
   * @param color The color to change the theme to.
   **/
  public async changeTheme(color: string) {
    await ZendeskUnified.changeTheme(color);
  }

  /**
   * Initializes the Zendesk Chat SDK.
   * @param accountKey The Zendesk account key.
   */
  public async initializeChat(accountKey: string) {
    await ZendeskUnified.initializeChat(accountKey);
  }

  /**
   * Opens the Zendesk Chat screen.
   */
  public async startChat(options?: StartChatOptions) {
    await ZendeskUnified.startChat(options);
  }

  // @TODO: define answer bot methods properly
  public async startAnswerBot() {
    await ZendeskUnified.startAnswerBot();
  }
}

export { useZendesk, ZendeskContext, ZendeskProvider };
export type {
  OpenHelpCenterOptions,
  OpenNewTicketOptions,
  PreChatFormFieldsStatus,
  PreChatFormFieldStatus,
  SetAnonymousIdentityOptions,
  StartChatOptions,
  ZendeskConfig,
};
