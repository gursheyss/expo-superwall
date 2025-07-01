import { Experiment } from "./Experiment"

/**
 * @category Enums
 * @since 0.0.15
 * Defines the possible types of results from a trigger.
 */
export enum TriggerResultType {
  placementNotFound = 0,
  noAudienceMatch = 1,
  paywall = 2,
  holdout = 3,
  error = 4,
}

/**
 * @category Models
 * @since 0.0.15
 * Represents the result of a trigger.
 */
export class TriggerResult {
  type: TriggerResultType
  experiment?: Experiment
  error?: string

  private constructor(type: TriggerResultType, experiment?: Experiment, error?: string) {
    this.type = type
    this.experiment = experiment
    this.error = error
  }

  static placementNotFound(): TriggerResult {
    return new TriggerResult(TriggerResultType.placementNotFound)
  }

  static noAudienceMatch(): TriggerResult {
    return new TriggerResult(TriggerResultType.noAudienceMatch)
  }

  static paywall(experiment: Experiment): TriggerResult {
    return new TriggerResult(TriggerResultType.paywall, experiment)
  }

  static holdout(experiment: Experiment): TriggerResult {
    return new TriggerResult(TriggerResultType.holdout, experiment)
  }

  static error(error: string): TriggerResult {
    return new TriggerResult(TriggerResultType.error, undefined, error)
  }

  static fromJson(json: any): TriggerResult {
    switch (json.result) {
      case "placementNotFound":
        return TriggerResult.placementNotFound()
      case "noAudienceMatch":
        return TriggerResult.noAudienceMatch()
      case "paywall":
        return TriggerResult.paywall(Experiment.fromJson(json.experiment))
      case "holdout":
        return TriggerResult.holdout(Experiment.fromJson(json.experiment))
      case "error":
        return TriggerResult.error(json.error)
      default:
        throw new Error("Invalid TriggerResult type")
    }
  }
}
