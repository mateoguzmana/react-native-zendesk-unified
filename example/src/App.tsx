import React, { useCallback, useEffect } from 'react';
import { StyleSheet, Text, View } from 'react-native';
import Config from 'react-native-config';
import { ZendeskProvider, useZendesk } from 'react-native-zendesk-unified';
import type { ZendeskConfig } from 'react-native-zendesk-unified';

import { Button } from './components/Button';

export const zendeskConfig: ZendeskConfig = {
  appId: Config.ZENDESK_APP_ID,
  clientId: Config.ZENDESK_CLIENT_ID,
  zendeskUrl: Config.ZENDESK_URL,
  accountKey: Config.ZENDESK_ACCOUNT_KEY,
};

// If you want to use the class directly, you can do it like this instead of using the hook:
// const zendesk = new Zendesk(zendeskConfig);

function Example() {
  const zendesk = useZendesk();
  const [healthCheck, setHealthCheck] = React.useState<string | undefined>();

  const loadHealthCheck = useCallback(async () => {
    try {
      const healthCheckResult = await zendesk.healthCheck();

      setHealthCheck(healthCheckResult);
    } catch (error) {
      if (error instanceof Error) {
        setHealthCheck(error.message);
      }
    }
  }, [zendesk]);

  const openHelpCenter = async () => {
    try {
      await zendesk.openHelpCenter({
        labels: ['test'],
        groupType: 'section',
        groupIds: [15138052595485],
        showContactOptions: false,
      });
    } catch (error) {
      console.log(error);
    }
  };

  const openTicket = async () => {
    try {
      await zendesk?.openTicket('28');
    } catch (error) {
      console.log(error);
    }
  };

  const openNewTicket = async () => {
    try {
      await zendesk?.openNewTicket({
        subject: 'Testing subjet passed from app',
        tags: ['test'],
        customFields: {
          360029274694: 'Testing custom field passed from app',
        },
      });
    } catch (error) {
      console.log(error);
    }
  };

  const listTickets = async () => {
    try {
      await zendesk?.listTickets();
    } catch (error) {
      console.log(error);
    }
  };

  const openArticle = async () => {
    try {
      await zendesk?.openArticle(15138112850333);
    } catch (error) {
      console.log(error);
    }
  };

  const startChat = async () => {
    try {
      await zendesk?.startChat({
        botName: 'Expo Zendesk Chat Bot',
        multilineResponseOptionsEnabled: true,
        agentAvailabilityEnabled: true,
        transcriptEnabled: false,
        offlineFormsEnabled: true,
        preChatFormEnabled: true,
        preChatFormFieldsStatus: {
          nameFieldStatus: 'optional',
          emailFieldStatus: 'optional',
          phoneFieldStatus: 'optional',
          departmentFieldStatus: 'optional',
        },
      });
    } catch (error) {
      console.log(error);
    }
  };

  const startAnswerBot = async () => {
    try {
      await zendesk?.startAnswerBot();
    } catch (error) {
      console.log(error);
    }
  };

  useEffect(() => {
    loadHealthCheck();

    try {
      zendesk.changeTheme('#3f2b96');
      zendesk.setAnonymousIdentity({
        email: 'testing6@mail.com',
        name: 'Mateo Guzmán',
      });
      zendesk.setHelpCenterLocaleOverride('nl');
      // zendesk.setIdentity("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9");
    } catch (error) {
      console.log(error);
    }
  }, [loadHealthCheck, zendesk]);

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Support SDK</Text>

      <Text style={styles.healthCheck}>{healthCheck}</Text>

      <Button onPress={openHelpCenter} title="Open Help Center" />

      <Button onPress={openTicket} title="Open Ticket" />

      <Button onPress={openNewTicket} title="Open New Ticket" />

      <Button onPress={listTickets} title="List Tickets" />

      <Button onPress={openArticle} title="Open Article" />

      <Text style={styles.title}>Chat SDK</Text>

      <Button onPress={startChat} title="Start Chat" />

      <Text style={styles.title}>Answer Bot SDK</Text>

      <Button onPress={startAnswerBot} title="Start Answer Bot" />
    </View>
  );
}

export default function App() {
  return (
    <ZendeskProvider zendeskConfig={zendeskConfig}>
      <Example />
    </ZendeskProvider>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
  title: {
    fontSize: 20,
    fontWeight: 'bold',
  },
  healthCheck: {
    fontSize: 20,
    margin: 10,
  },
  buttonContainer: {
    margin: 10,
  },
});
