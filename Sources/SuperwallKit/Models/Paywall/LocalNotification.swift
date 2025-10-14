//
//  File.swift
//  
//
//  Created by Yusuf Tör on 19/06/2023.
//

import Foundation

/// A local notification.
@objc(SWKLocalNotification)
@objcMembers
public final class LocalNotification: NSObject, Codable {
  /// The type of the notification.
  public let type: LocalNotificationType

  /// The title text of the notification.
  public let title: String

  /// The subtitle text of the notification.
  public let subtitle: String?

  /// The body text of the notification.
  public let body: String

  /// The delay to the notification in milliseconds.
  public let delay: Milliseconds

  init(
    type: LocalNotificationType,
    title: String,
    subtitle: String?,
    body: String,
    delay: Milliseconds
  ) {
    self.type = type
    self.title = title
    self.subtitle = subtitle
    self.body = body
    self.delay = delay
  }
}

// MARK: - Stubbable
extension LocalNotification: Stubbable {
  static func stub() -> LocalNotification {
    let oneDay: Milliseconds = 86400000
    return .init(
      type: .trialStarted,
      title: "title",
      subtitle: "subtitle",
      body: "body",
      delay: oneDay
    )
  }
}

/// The type of notification.
@objc(SWKLocalNotificationType)
public enum LocalNotificationType: Int, Codable {
  /// The notification will fire after a transaction.
  case trialStarted

  enum CodingKeys: String, CodingKey {
    case trialStarted = "TRIAL_STARTED"
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let rawValue = try container.decode(String.self)
    let type = CodingKeys(rawValue: rawValue)
    switch type {
    case .trialStarted:
      self = .trialStarted
    case .none:
      throw DecodingError.valueNotFound(
        String.self,
        .init(
          codingPath: [],
          debugDescription: "Unsupported notification type."
        )
      )
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()

    let rawValue: String
    switch self {
    case .trialStarted:
      rawValue = CodingKeys.trialStarted.rawValue
    }

    try container.encode(rawValue)
  }
}
