package expo.modules.jetpackcomposetest

import expo.modules.kotlin.modules.Module
import expo.modules.kotlin.modules.ModuleDefinition
import java.net.URL

class ExpoJetpackComposeTestModule : Module() {

  override fun definition() = ModuleDefinition {

    Name("ExpoJetpackComposeTest")

    View(ExpoJetpackComposeTestView::class) {
    }
  }
}
