import type { PaywallInfo } from "./PaywallInfo"
import type { PaywallResult } from "./PaywallResult"
import type { PaywallSkippedReason } from "./PaywallSkippedReason"

/**
 * @category Handlers
 * @since 0.0.15
 * Handles events related to paywall presentation.
 */
export class PaywallPresentationHandler {
  // Handlers for various events
  onPresentHandler?: (info: PaywallInfo) => void
  onDismissHandler?: (info: PaywallInfo, result: PaywallResult) => void
  onErrorHandler?: (error: string) => void
  onSkipHandler?: (reason: PaywallSkippedReason) => void

  // Setters for the handlers
  onPresent(handler: (info: PaywallInfo) => void): void {
    this.onPresentHandler = handler
  }

  onDismiss(handler: (info: PaywallInfo, result: PaywallResult) => void): void {
    this.onDismissHandler = handler
  }

  onError(handler: (error: string) => void): void {
    this.onErrorHandler = handler
  }

  onSkip(handler: (reason: PaywallSkippedReason) => void): void {
    this.onSkipHandler = handler
  }
}
