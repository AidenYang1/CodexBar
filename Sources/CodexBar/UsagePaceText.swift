import CodexBarCore
import Foundation

enum UsagePaceText {
    struct WeeklyDetail {
        let leftLabel: String
        let rightLabel: String?
        let expectedUsedPercent: Double
        let stage: UsagePace.Stage
    }

    static func weeklySummary(pace: UsagePace, now: Date = .init()) -> String {
        let detail = self.weeklyDetail(pace: pace, now: now)
        if let rightLabel = detail.rightLabel {
            return String(format: NSLocalizedString("usage.pace.summary.detail", comment: ""), detail.leftLabel, rightLabel)
        }
        return String(format: NSLocalizedString("usage.pace.summary", comment: ""), detail.leftLabel)
    }

    static func weeklyDetail(pace: UsagePace, now: Date = .init()) -> WeeklyDetail {
        WeeklyDetail(
            leftLabel: self.detailLeftLabel(for: pace),
            rightLabel: self.detailRightLabel(for: pace, now: now),
            expectedUsedPercent: pace.expectedUsedPercent,
            stage: pace.stage)
    }

    private static func detailLeftLabel(for pace: UsagePace) -> String {
        let deltaValue = Int(abs(pace.deltaPercent).rounded())
        switch pace.stage {
        case .onTrack:
            return NSLocalizedString("usage.pace.on_track", comment: "")
        case .slightlyAhead, .ahead, .farAhead:
            return String(format: NSLocalizedString("usage.pace.in_deficit", comment: ""), deltaValue)
        case .slightlyBehind, .behind, .farBehind:
            return String(format: NSLocalizedString("usage.pace.in_reserve", comment: ""), deltaValue)
        }
    }

    private static func detailRightLabel(for pace: UsagePace, now: Date) -> String? {
        let etaLabel: String?
        if pace.willLastToReset {
            etaLabel = NSLocalizedString("usage.pace.lasts_until_reset", comment: "")
        } else if let etaSeconds = pace.etaSeconds {
            let etaText = Self.durationText(seconds: etaSeconds, now: now)
            etaLabel = etaText == NSLocalizedString("time.now", comment: "")
                ? NSLocalizedString("usage.pace.runs_out_now", comment: "")
                : String(format: NSLocalizedString("usage.pace.runs_out_in", comment: ""), etaText)
        } else {
            etaLabel = nil
        }

        guard let runOutProbability = pace.runOutProbability else { return etaLabel }
        let roundedRisk = self.roundedRiskPercent(runOutProbability)
        let riskLabel = String(format: NSLocalizedString("usage.pace.run_out_risk", comment: ""), roundedRisk)
        if let etaLabel {
            return "\(etaLabel) · \(riskLabel)"
        }
        return riskLabel
    }

    private static func durationText(seconds: TimeInterval, now: Date) -> String {
        let date = now.addingTimeInterval(seconds)
        let countdown = UsageFormatter.resetCountdownDescription(from: date, now: now)
        let localizedNow = NSLocalizedString("time.now", comment: "")
        if countdown == localizedNow { return localizedNow }
        let inPrefix = NSLocalizedString("time.in_prefix", comment: "")
        if countdown.hasPrefix(inPrefix) { return String(countdown.dropFirst(inPrefix.count)) }
        return countdown
    }

    private static func roundedRiskPercent(_ probability: Double) -> Int {
        let percent = probability.clamped(to: 0...1) * 100
        let rounded = (percent / 5).rounded() * 5
        return Int(rounded)
    }
}
