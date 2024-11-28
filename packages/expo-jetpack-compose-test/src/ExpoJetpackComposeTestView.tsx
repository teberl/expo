import { requireNativeView } from 'expo';
import * as React from 'react';

import { ExpoJetpackComposeTestViewProps } from './ExpoJetpackComposeTest.types';

const NativeView: React.ComponentType<ExpoJetpackComposeTestViewProps> =
  requireNativeView('ExpoJetpackComposeTest');

export default function ExpoJetpackComposeTestView(props: ExpoJetpackComposeTestViewProps) {
  return <NativeView {...props} />;
}
