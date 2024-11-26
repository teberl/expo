//  Copyright © 2024 650 Industries. All rights reserved.

import ExpoModulesCore
import UIKit
import MachO

// swiftlint:disable identifier_name
let notificationTriggerTypeKey = "type"
let notificationTriggerRepeatsKey = "repeats"

let intervalNotificationTriggerType = "timeInterval"
let intervalNotificationTriggerIntervalKey = "seconds"

let dailyNotificationTriggerType = "daily"
let dailyNotificationTriggerHourKey = "hour"
let dailyNotificationTriggerMinuteKey = "minute"

let weeklyNotificationTriggerType = "weekly"
let weeklyNotificationTriggerWeekdayKey = "weekday"
let weeklyNotificationTriggerHourKey = "hour"
let weeklyNotificationTriggerMinuteKey = "minute"

let monthlyNotificationTriggerType = "monthly"
let monthlyNotificationTriggerDayKey = "day"
let monthlyNotificationTriggerHourKey = "hour"
let monthlyNotificationTriggerMinuteKey = "minute"

let yearlyNotificationTriggerType = "yearly"
let yearlyNotificationTriggerMonthKey = "month"
let yearlyNotificationTriggerDayKey = "day"
let yearlyNotificationTriggerHourKey = "hour"
let yearlyNotificationTriggerMinuteKey = "minute"

let dateNotificationTriggerType = "date"
let dateNotificationTriggerTimestampKey = "timestamp"

let calendarNotificationTriggerType = "calendar"
let calendarNotificationTriggerComponentsKey = "value"
let calendarNotificationTriggerTimezoneKey = "timezone"
// swiftlint:enable identifier_name

let dateComponentsMatchMap: [String: Calendar.Component] = [
  "year": .year,
  "month": .month,
  "day": .day,
  "hour": .hour,
  "minute": .minute,
  "second": .second,
  "weekday": .weekday,
  "weekOfMonth": .weekOfMonth,
  "weekOfYear": .weekOfYear,
  "weekdayOrdinal": .weekdayOrdinal
]

public class SchedulerModule: Module {
  let builder: NotificationBuilder = NotificationBuilder()

  func triggerFromParams(_ params: [AnyHashable: Any]?) throws -> UNNotificationTrigger? {
    guard let params = params else {
      return nil
    }

    guard let triggerType = params[notificationTriggerTypeKey] as? String else {
      return nil
    }

    switch triggerType {
    case intervalNotificationTriggerType:
      let interval = (try? params.verifiedProperty(intervalNotificationTriggerIntervalKey, type: TimeInterval.self)) ?? 0
      let repeats: Bool = (try? params.verifiedProperty(notificationTriggerRepeatsKey, type: Bool.self)) ?? false
      var trigger: UNNotificationTrigger?
      try EXNotificationObjcWrapper.tryExecute {
        trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: repeats)
      }
      return trigger
    case dateNotificationTriggerType:
      let timestampMs: TimeInterval = (try? params.verifiedProperty(dateNotificationTriggerTimestampKey, type: TimeInterval.self)) ?? 0
      let timestamp: Int = Int(timestampMs / 1000)
      let date: Date = Date(timeIntervalSince1970: TimeInterval(timestamp))
      var trigger: UNNotificationTrigger?
      try EXNotificationObjcWrapper.tryExecute {
        trigger = UNTimeIntervalNotificationTrigger(timeInterval: date.timeIntervalSinceNow, repeats: false)
      }
      return trigger
    case dailyNotificationTriggerType:
      let hour: Int = (try? params.verifiedProperty(dailyNotificationTriggerHourKey, type: Int.self)) ?? 0
      let minute: Int = (try? params.verifiedProperty(dailyNotificationTriggerMinuteKey, type: Int.self)) ?? 0
      let dateComponents: DateComponents = DateComponents(hour: hour, minute: minute)
      var trigger: UNNotificationTrigger?
      try EXNotificationObjcWrapper.tryExecute {
        trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
      }
      return trigger
    case weeklyNotificationTriggerType:
      let weekday: Int = (try? params.verifiedProperty(weeklyNotificationTriggerWeekdayKey, type: Int.self)) ?? 0
      let hour: Int = (try? params.verifiedProperty(weeklyNotificationTriggerHourKey, type: Int.self)) ?? 0
      let minute: Int = (try? params.verifiedProperty(weeklyNotificationTriggerMinuteKey, type: Int.self)) ?? 0
      let dateComponents: DateComponents = DateComponents(hour: hour, minute: minute, weekday: weekday)
      var trigger: UNNotificationTrigger?
      try EXNotificationObjcWrapper.tryExecute {
        trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
      }
      return trigger
    case monthlyNotificationTriggerType:
      let day: Int = (try? params.verifiedProperty(monthlyNotificationTriggerDayKey, type: Int.self)) ?? 0
      let hour: Int = (try? params.verifiedProperty(monthlyNotificationTriggerHourKey, type: Int.self)) ?? 0
      let minute: Int = (try? params.verifiedProperty(monthlyNotificationTriggerMinuteKey, type: Int.self)) ?? 0
      let dateComponents: DateComponents = DateComponents(day: day, hour: hour, minute: minute)
      var trigger: UNNotificationTrigger?
      try EXNotificationObjcWrapper.tryExecute {
        trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
      }
      return trigger
    case yearlyNotificationTriggerType:
      let month: Int = (try? params.verifiedProperty(yearlyNotificationTriggerMonthKey, type: Int.self)) ?? 0
      let day: Int = (try? params.verifiedProperty(yearlyNotificationTriggerDayKey, type: Int.self)) ?? 0
      let hour: Int = (try? params.verifiedProperty(yearlyNotificationTriggerHourKey, type: Int.self)) ?? 0
      let minute: Int = (try? params.verifiedProperty(yearlyNotificationTriggerMinuteKey, type: Int.self)) ?? 0
      let dateComponents: DateComponents = DateComponents(month: month, day: day, hour: hour, minute: minute)
      var trigger: UNNotificationTrigger?
      try EXNotificationObjcWrapper.tryExecute {
        trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
      }
      return trigger
    case calendarNotificationTriggerType:
      let dateComponents: DateComponents = dateComponentsFrom(params) ?? DateComponents()
      let repeats: Bool = (try? params.verifiedProperty(notificationTriggerRepeatsKey, type: Bool.self)) ?? false
      var trigger: UNNotificationTrigger?
      try EXNotificationObjcWrapper.tryExecute {
        trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: repeats)
      }
      return trigger
    default:
      return nil
    }
  }

  func dateComponentsFrom(_ params: [AnyHashable: Any]) -> DateComponents? {
    var dateComponents = DateComponents()
    // TODO: Verify that DoW matches JS getDay()
    dateComponents.calendar = Calendar.init(identifier: .iso8601)
    if let timeZone = try? params.verifiedProperty(calendarNotificationTriggerTimezoneKey, type: String.self) {
      dateComponents.timeZone = TimeZone(identifier: timeZone)
    }
    dateComponentsMatchMap.keys.forEach { key in
      let calendarComponent = dateComponentsMatchMap[key] ?? .day
      if let value = try? params.verifiedProperty(key, type: Int.self) {
        dateComponents.setValue(value, for: calendarComponent)
      }
    }
    return dateComponents
  }

  func serializeNotificationRequests(_ requests: [UNNotificationRequest]) -> [Any] {
    var serializedRequests: [[AnyHashable: Any]] = []
    requests.forEach {request in
      serializedRequests.append(EXNotificationSerializer .serializedNotificationRequest(request))
    }
    return serializedRequests
  }

  func buildNotificationRequest(
    identifier: String,
    contentInput: [AnyHashable: Any],
    triggerInput: [AnyHashable: Any]
  ) throws -> UNNotificationRequest? {
    return try UNNotificationRequest(identifier: identifier, content: builder.content(contentInput), trigger: triggerFromParams(triggerInput))
  }

  public func definition() -> ModuleDefinition {
    Name("ExpoNotificationScheduler")

    AsyncFunction("getAllScheduledNotificationsAsync") { (promise: Promise) in
      UNUserNotificationCenter.current().getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
        var serializedRequests: [Any] = []
        requests.forEach {request in
          serializedRequests.append(EXNotificationSerializer.serializedNotificationRequest(request))
        }
        promise.resolve(serializedRequests)
      }
    }
    .runOnQueue(.main)

    AsyncFunction("cancelScheduledNotificationAsync") { (identifier: String) in
      UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }

    AsyncFunction("cancelAllScheduledNotificationsAsync") { () in
      UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    // swiftlint:disable:next line_length
    AsyncFunction("scheduleNotificationAsync") { (identifier: String, notificationSpec: [AnyHashable: Any], triggerSpec: [AnyHashable: Any], promise: Promise) in
      guard let request = try? buildNotificationRequest(identifier: identifier, contentInput: notificationSpec, triggerInput: triggerSpec) else {
        promise.reject("ERR_NOTIFICATIONS_FAILED_TO_SCHEDULE", "Failed to build notification request")
        return
      }
      UNUserNotificationCenter.current().add(request) {error in
        if let error = error {
          promise.reject("ERR_NOTIFICATIONS_FAILED_TO_SCHEDULE", "Failed to schedule notification, \(error)")
        } else {
          promise.resolve()
        }
      }
    }

    AsyncFunction("getNextTriggerDateAsync") { (triggerSpec: [AnyHashable: Any], promise: Promise) in
      guard let trigger = try? triggerFromParams(triggerSpec) else {
        promise.reject("ERR_NOTIFICATIONS_INVALID_CALENDAR_TRIGGER", "Invalid trigger specification")
        return
      }
      if trigger is UNCalendarNotificationTrigger {
        if let calendarTrigger = trigger as? UNCalendarNotificationTrigger,
          let nextTriggerDate = calendarTrigger.nextTriggerDate() {
          promise.resolve(nextTriggerDate.timeIntervalSince1970 * 1000)
        } else {
          promise.resolve(nil)
        }
        return
      }
      if trigger is UNTimeIntervalNotificationTrigger {
        if let timeIntervalTrigger = trigger as? UNTimeIntervalNotificationTrigger,
          let nextTriggerDate = timeIntervalTrigger.nextTriggerDate() {
          promise.resolve(nextTriggerDate.timeIntervalSince1970 * 1000)
        } else {
          promise.resolve(nil)
        }
        return
      }
      promise.reject("ERR_NOTIFICATIONS_INVALID_CALENDAR_TRIGGER", "It is not possible to get next trigger date for triggers other than calendar-based. Provided trigger resulted in \(type(of: trigger)) trigger.")
    }
  }
}
