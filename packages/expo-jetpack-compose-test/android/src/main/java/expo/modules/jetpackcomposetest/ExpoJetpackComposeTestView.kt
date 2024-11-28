@file:Suppress("INVISIBLE_MEMBER", "INVISIBLE_REFERENCE")
package expo.modules.jetpackcomposetest

import android.content.Context
import android.graphics.Color
import android.view.View
import android.view.ViewGroup.LayoutParams.MATCH_PARENT
import android.widget.LinearLayout
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.InternalComposeUiApi
import androidx.compose.ui.platform.AbstractComposeView
import androidx.compose.ui.platform.ComposeView
import androidx.compose.ui.platform.WindowRecomposerPolicy
import androidx.compose.ui.platform.compositionContext
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.findViewTreeLifecycleOwner
import androidx.lifecycle.setViewTreeLifecycleOwner
import expo.modules.kotlin.AppContext
import expo.modules.kotlin.views.ExpoView


@OptIn(InternalComposeUiApi::class)
class ExpoJetpackComposeTestView(context: Context, appContext: AppContext) : ExpoView(context, appContext) {


//  override fun measureChildWithMargins(child: View?, parentWidthMeasureSpec: Int, widthUsed: Int, parentHeightMeasureSpec: Int, heightUsed: Int) {
//    println("measureChild")
//    if(child is ComposeView) {
//      setMeasuredDimension(widthUsed, heightUsed)
//      return
//    }
//    super.measureChildWithMargins(child, parentWidthMeasureSpec, widthUsed, parentHeightMeasureSpec, heightUsed)
//  }

//  override fun onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {
//    val widthSize = MeasureSpec.getSize(widthMeasureSpec)
//    val heightSize = MeasureSpec.getSize(heightMeasureSpec)
//    println("onMeasure: " + widthSize +"," + heightSize)
//    setMeasuredDimension(widthSize, heightSize)
//    if(widthSize == 500) {
//
//    }
////    super.onMeasure(widthMeasureSpec, heightMeasureSpec)
//  }

  init {



//
//    class StubComposeView constructor(
//      context: Context,
//      attrs: AttributeSet? = null,
//    ) : AbstractComposeView(context, attrs) {
//      init { isVisible = false }
//      @Composable
//      override fun Content() {}
//    }


    val layout = ComposeView(context).also {
      it.layoutParams = LayoutParams(MATCH_PARENT, MATCH_PARENT)
      it.setBackgroundColor(Color.GREEN)
//      val compContext = appContext.activityProvider?.currentActivity?.findViewById<View>(android.R.id.content)!!.compositionContext

      // print rootView, currentActivity, compositionContext and rootView.handler
      println("rootView: ${appContext.activityProvider?.currentActivity?.findViewById<View>(android.R.id.content)}")
      println("rootView2: ${rootView}")
      println("currentActivity: ${appContext.activityProvider?.currentActivity}")
      println("compositionContext: ${rootView.compositionContext}")
      println("rootView.handler: ${appContext.activityProvider?.currentActivity?.findViewById<View>(android.R.id.content)!!.handler}")
//      println("findViewTreeLifecycleOwner: ${rootView.findViewTreeLifecycleOwner()}")
//      rootView.setViewTreeLifecycleOwner(appContext.activityProvider?.currentActivity as LifecycleOwner)
//it.setViewTreeLifecycleOwner(rootView.findViewTreeLifecycleOwner())
//      println("2222\nrootView: ${appContext.activityProvider?.currentActivity?.findViewById<View>(android.R.id.content)}")
//      println("currentActivity: ${appContext.activityProvider?.currentActivity}")
//      println("compositionContext: ${appContext.activityProvider?.currentActivity?.findViewById<View>(android.R.id.content)!!.compositionContext}")
//      println("rootView.handler: ${appContext.activityProvider?.currentActivity?.findViewById<View>(android.R.id.content)!!.handler}")
//      println("findViewTreeLifecycleOwner: ${rootView.findViewTreeLifecycleOwner()}")
//      WindowRecomposerPolicy.createAndInstallWindowRecomposer(rootView)
//      println("3333\nrootView: ${appContext.activityProvider?.currentActivity?.findViewById<View>(android.R.id.content)}")
//      println("currentActivity: ${appContext.activityProvider?.currentActivity}")
//      println("compositionContext: ${appContext.activityProvider?.currentActivity?.findViewById<View>(android.R.id.content)!!.compositionContext}")
//      println("rootView.handler: ${appContext.activityProvider?.currentActivity?.findViewById<View>(android.R.id.content)!!.handler}")
//      println("findViewTreeLifecycleOwner: ${rootView.findViewTreeLifecycleOwner()}")
//  it.setParentCompositionContext(rootView.compositionContext)

//
          it.setContent {
            Button(onClick = { println("test") }) {
              Text("Filled")
            }

          }
      addView(it)
      println("add view")
    }

    addOnAttachStateChangeListener(object : OnAttachStateChangeListener {
      override fun onViewAttachedToWindow(v: View) {
        println("onViewAttachedToWindow")
//  v.requestLayout()
//        v.measure(MeasureSpec.makeMeasureSpec(500, MeasureSpec.EXACTLY), MeasureSpec.makeMeasureSpec(500, MeasureSpec.EXACTLY))

      }

      override fun onViewDetachedFromWindow(v: View) {
        println("onViewDetachedFromWindow")
      }
    })
//    setContent()
//    super.init()

  }

}
