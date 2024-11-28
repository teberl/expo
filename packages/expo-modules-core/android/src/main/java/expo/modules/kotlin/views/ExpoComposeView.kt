package expo.modules.kotlin.views

import android.content.Context
import android.graphics.Canvas
import android.view.View
import android.view.ViewGroup.LayoutParams.MATCH_PARENT
import android.view.ViewGroup.LayoutParams.WRAP_CONTENT
import android.widget.LinearLayout
import androidx.annotation.UiThread
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.ui.platform.ComposeView
import com.facebook.react.uimanager.BackgroundStyleApplicator
import expo.modules.kotlin.AppContext
import androidx.compose.material3.*

import android.graphics.Color;

data class ColumnProps(
  var children: String = "",
)

/**
 * A base class that should be used by every exported views.
 */
abstract class ExpoComposeView(
  context: Context,
  appContext: AppContext
) : ExpoView(context, appContext) {

  val composeView = ComposeView(context).also {
    it.layoutParams = LayoutParams(MATCH_PARENT, MATCH_PARENT)

    it.setBackgroundColor(Color.BLUE)
    super.addView(it)
    println("add view")
  }

  private var props = mutableStateOf(ColumnProps())
//
//  override fun addView(child: View?, index: Int) {
//
//      if (child != null) {
//        props.value = props.value.copy(children = props.value.children + child)
//      }
//  }

  fun init() {
    println("init internal")

//    setContent()
  }

  fun setContent() {

    composeView.setContent {
      TextComposable()
      Button(onClick = { println("test") }) {
        Text("Filled")
      }

    }
  }



  @Composable
  fun TextComposable() {
    Text(text = "Hello!")
  }



}
