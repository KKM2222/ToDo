package com.flutterjunction.homescreen_widget  // 패키지 이름

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

class HomeScreenWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray, widgetData: SharedPreferences) {
        // 각 위젯에 대해 업데이트 이벤트를 처리하는 메서드

        appWidgetIds.forEach { widgetId ->
            // RemoteViews를 사용하여 위젯의 레이아웃 및 동작 설정
            val views = RemoteViews(context.packageName, R.layout.widget_layout).apply {

                // 위젯 클릭 시 앱 열기
                val pendingIntent = HomeWidgetLaunchIntent.getActivity(context, MainActivity::class.java)
                setOnClickPendingIntent(R.id.widget_root, pendingIntent)

                // SharedPreferences에서 카운터 값 가져오기
                val counter = widgetData.getInt("_counter", 0)

                var counterText = "현재 카운터 값: $counter"

                if (counter == 0) {
                    counterText = "카운터 버튼을 누르지 않았습니다."
                }

                // 텍스트 뷰에 카운터 값 설정
                setTextViewText(R.id.tv_counter, counterText)

                // 버튼 클릭 시 카운터 업데이트를 위한 Pending intent 설정
                val backgroundIntent = HomeWidgetBackgroundIntent.getBroadcast(context, Uri.parse("myAppWidget://updatecounter"))
                setOnClickPendingIntent(R.id.bt_update, backgroundIntent)
            }

            // 위젯 업데이트
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
