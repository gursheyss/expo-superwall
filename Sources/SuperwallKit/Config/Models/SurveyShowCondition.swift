//
//  File.swift
//  
//
//  Created by Yusuf Tör on 06/09/2023.
//

import Foundation

/// An enum whose cases indicate when a survey should
/// show.
@objc(SWKSurveyShowCondition)
public enum SurveyShowCondition: Int, Codable {
  /// Shows the survey when the user manually closes the paywall.
  case onManualClose

  /// Shows the survey after the user purchases.
  case onPurchase

  enum CodingKeys: String, CodingKey {
    case onManualClose = "ON_MANUAL_CLOSE"
    case onPurchase = "ON_PURCHASE"
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let rawValue = try container.decode(String.self)
    let reason = CodingKeys(rawValue: rawValue)
    switch reason {
    case .onManualClose:
      self = .onManualClose
    case .onPurchase:
      self = .onPurchase
    case .none:
      throw DecodingError.valueNotFound(
        String.self,
        .init(
          codingPath: [],
          debugDescription: "Unsupported survey condition."
        )
      )
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()

    let rawValue: String
    switch self {
    case .onManualClose:
      rawValue = CodingKeys.onManualClose.rawValue
    case .onPurchase:
      rawValue = CodingKeys.onPurchase.rawValue
    }

    try container.encode(rawValue)
  }
}
