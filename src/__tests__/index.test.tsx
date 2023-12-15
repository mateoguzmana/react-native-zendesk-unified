import { NativeModules, Platform } from 'react-native';
import { Zendesk } from '../index';
import type { StartChatOptions, ZendeskConfig } from '../ZendeskUnified.types';

jest.mock('react-native', () => {
  const reactNative = jest.requireActual('react-native');

  reactNative.NativeModules.ZendeskUnified = {
    initialize: jest.fn(),
    healthCheck: jest.fn(() => Promise.resolve('OK')),
    setAnonymousIdentity: jest.fn(() => Promise.resolve(true)),
    setIdentity: jest.fn(() => Promise.resolve(true)),
    openHelpCenter: jest.fn(() => Promise.resolve()),
    openTicket: jest.fn(() => Promise.resolve()),
    openNewTicket: jest.fn(() => Promise.resolve()),
    listTickets: jest.fn(() => Promise.resolve()),
    openArticle: jest.fn(() => Promise.resolve()),
    setHelpCenterLocaleOverride: jest.fn(() => Promise.resolve()),
    changeTheme: jest.fn(() => Promise.resolve()),
    initializeChat: jest.fn(() => Promise.resolve()),
    startChat: jest.fn(() => Promise.resolve()),
    startAnswerBot: jest.fn(() => Promise.resolve()),
  };

  return reactNative;
});

const ZendeskUnified = NativeModules.ZendeskUnified;

describe('Zendesk class', () => {
  const zendeskConfig: ZendeskConfig = {
    appId: 'appId',
    clientId: 'clientId',
    zendeskUrl: 'zendeskUrl',
    accountKey: 'accountKey',
  };

  const zendesk = new Zendesk(zendeskConfig);

  it('should initialize ZendeskUnified with the provided config', () => {
    expect(zendesk).toBeDefined();
    expect(zendesk instanceof Zendesk).toBe(true);
    expect(ZendeskUnified.initialize).toHaveBeenCalledWith(zendeskConfig);
  });

  it('should perform health check', async () => {
    const result = await zendesk.healthCheck();
    expect(result).toEqual('OK');
  });

  it('should set anonymous identity', async () => {
    const options = {};
    const result = await zendesk.setAnonymousIdentity(options);
    expect(result).toBe(true);
  });

  it('should set identity', async () => {
    const jwt = 'mock-jwt';
    const result = await zendesk.setIdentity(jwt);
    expect(result).toBe(true);
  });

  it('should open an article', async () => {
    const articleId = 123;
    await zendesk.openArticle(articleId);
    expect(ZendeskUnified.openArticle).toHaveBeenCalledWith(
      Platform.OS === 'ios' ? articleId.toString() : articleId
    );
  });

  it('should set Help Center locale override', async () => {
    const locale = 'en_US';
    await zendesk.setHelpCenterLocaleOverride(locale);
    expect(ZendeskUnified.setHelpCenterLocaleOverride).toHaveBeenCalledWith(
      locale
    );
  });

  it('should change theme', async () => {
    const color = 'blue';
    await zendesk.changeTheme(color);
    expect(ZendeskUnified.changeTheme).toHaveBeenCalledWith(color);
  });

  it('should initialize chat', async () => {
    const accountKey = 'chat-account-key';
    await zendesk.initializeChat(accountKey);
    expect(ZendeskUnified.initializeChat).toHaveBeenCalledWith(accountKey);
  });

  it('should start chat', async () => {
    const options: StartChatOptions = { botName: 'bot-name' };
    await zendesk.startChat(options);
    expect(ZendeskUnified.startChat).toHaveBeenCalledWith(options);
  });

  it('should start Answer Bot', async () => {
    await zendesk.startAnswerBot();
    expect(ZendeskUnified.startAnswerBot).toHaveBeenCalled();
  });
});
