import React from 'react';
import { Button as RNButton, StyleSheet, View } from 'react-native';
import type { ButtonProps } from 'react-native';

export function Button(props: ButtonProps) {
  return (
    <View style={styles.buttonContainer}>
      <RNButton {...props} />
    </View>
  );
}

const styles = StyleSheet.create({
  buttonContainer: {
    margin: 10,
  },
});
