package com.eventsexport

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.module.annotations.ReactModule
import com.facebook.react.bridge.Promise
import android.content.Intent
import android.provider.CalendarContract
import com.eventsexport.NativeEventsExportSpec

@ReactModule(name = EventsExportModule.NAME)
class EventsExportModule(reactContext: ReactApplicationContext) :
  NativeEventsExportSpec(reactContext) {

  override fun getName(): String {
    return NAME
  }

  // Example method
  // See https://reactnative.dev/docs/native-modules-android
  override fun addEventWithEditor(
    title: String,
    startDate: Double,
    endDate: Double,
    location: String?,
    promise: Promise
  ) {
    try {
      val intent = Intent(Intent.ACTION_INSERT).apply {
        data = CalendarContract.Events.CONTENT_URI
        putExtra(CalendarContract.Events.TITLE, title)
        putExtra(CalendarContract.Events.EVENT_LOCATION, location)
        putExtra(CalendarContract.EXTRA_EVENT_BEGIN_TIME, startDate.toLong())
        putExtra(CalendarContract.EXTRA_EVENT_END_TIME, endDate.toLong())
      }

      intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
      reactApplicationContext.startActivity(intent)

      promise.resolve(true)
    } catch (e: Exception){
      promise.resolve(false)
    }
  }

  companion object {
    const val NAME = "EventsExport"
  }
}
