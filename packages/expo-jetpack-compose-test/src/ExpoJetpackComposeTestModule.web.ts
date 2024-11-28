import { registerWebModule, NativeModule } from 'expo';

import { ExpoJetpackComposeTestModuleEvents } from './ExpoJetpackComposeTest.types';

class ExpoJetpackComposeTestModule extends NativeModule<ExpoJetpackComposeTestModuleEvents> {
  PI = Math.PI;
  async setValueAsync(value: string): Promise<void> {
    this.emit('onChange', { value });
  }
  hello() {
    return 'Hello world! 👋';
  }
}

export default registerWebModule(ExpoJetpackComposeTestModule);
