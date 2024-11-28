import { NativeModule, requireNativeModule } from 'expo';

import { ExpoJetpackComposeTestModuleEvents } from './ExpoJetpackComposeTest.types';

declare class ExpoJetpackComposeTestModule extends NativeModule<ExpoJetpackComposeTestModuleEvents> {
  PI: number;
  hello(): string;
  setValueAsync(value: string): Promise<void>;
}

// This call loads the native module object from the JSI.
export default requireNativeModule<ExpoJetpackComposeTestModule>('ExpoJetpackComposeTest');
