package com.eventsexport

import com.facebook.react.bridge.*
import com.facebook.react.module.annotations.ReactModule
import android.content.Intent
import android.provider.CalendarContract
import java.util.*

@ReactModule(name = EventsExportModule.NAME)
class EventsExportModule(private val reactContext: ReactApplicationContext):
    ReactContextBaseJavaModule(reactContext) {

    companion object {
        const val NAME = "CalendarModule"
    }

    override fun getName(): String = NAME

    @ReactMethod
    fun addEventWithEditor(
        title: String,
        startDate: Double,
        endDate: Double,
        location: String?
    ){
        val intent = Intent(Intent.ACTION_INSERT).apply {
            data = CalendarContract.Events.CONTENT_URI
            putExtra(CalendarContract.Events.TITLE, title)
            putExtra(CalendarContract.Events.EVENT_LOCATION, location)
            putExtra(CalendarContract.EXTRA_EVENT_BEGIN_TIME, startDate.toLong())
            putExtra(CalendarContract.EXTRA_EVENT_END_TIME, endDate.toLong())
        }

        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)

        if(intent.resolveActivity(reactContext.packageManager) != null) {
            reactContext.startActivity(intent)
        }
    }
}