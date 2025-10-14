//
//  File.swift
//  
//
//  Created by Yusuf Tör on 02/12/2022.
//

import UIKit
import Combine

final class PresentationItems: @unchecked Sendable {
  /// The publisher and request involved in the last successful paywall presentation request.
  var last: LastPresentationItems? {
    get {
      queue.sync { [weak self] in
        guard let self = self else {
          return nil
        }
        return self._last
      }
    }
    set {
      queue.async { [weak self] in
        self?._last = newValue
      }
    }
  }
  private var _last: LastPresentationItems?

  /// The ``PaywallInfo`` object stored from the last paywall view controller that was dismissed.
  var paywallInfo: PaywallInfo? {
    get {
      queue.sync { [weak self] in
        return self?._paywallInfo
      }
    }
    set {
      queue.async { [weak self] in
        self?._paywallInfo = newValue
      }
    }
  }
  private var _paywallInfo: PaywallInfo?

  /// The window that presents the paywall.
  @MainActor
  var window: UIWindow?

  private let queue = DispatchQueue(label: "com.superwall.presentationitems")

  func reset() {
    queue.async { [weak self] in
      self?._last = nil
      self?._paywallInfo = nil
    }
  }
}

/// Items involved in the last successful paywall presentation request.
struct LastPresentationItems {
  /// The last paywall presentation request.
  let request: PresentationRequest

  /// The last state publisher.
  let statePublisher: PassthroughSubject<PaywallState, Never>

  /// The feature gating behavior of the previous paywall.
  let featureGatingBehavior: FeatureGatingBehavior
}
