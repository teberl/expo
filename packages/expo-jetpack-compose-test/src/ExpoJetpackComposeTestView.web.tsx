import * as React from 'react';

import { ExpoJetpackComposeTestViewProps } from './ExpoJetpackComposeTest.types';

export default function ExpoJetpackComposeTestView(props: ExpoJetpackComposeTestViewProps) {
  return (
    <div>
      <iframe
        style={{ flex: 1 }}
        src={props.url}
        onLoad={() => props.onLoad({ nativeEvent: { url: props.url } })}
      />
    </div>
  );
}
