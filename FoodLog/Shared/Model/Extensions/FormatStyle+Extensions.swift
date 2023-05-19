import SwiftUI

// MARK: Measurement Style 
extension FormatStyle where Self == Measurement<Dimension>.FormatStyle {
  static var measurementStyle: Self {
    .measurement(
      width: .abbreviated,
      usage: .asProvided,
      numberFormatStyle: .number.precision(.fractionLength(0...1))
    )
  }
}

// MARK: Date Style
extension FormatStyle where Self == Date.FormatStyle {
  static var dateTimeStyle: Self {
    return .dateTime
      .day()
      .month(.wide)
      .year()
      .hour(.defaultDigits(amPM: .abbreviated))
      .minute(.twoDigits)
      .timeZone()
  }
}

// MARK: Double Style
extension FormatStyle where Self == FloatingPointFormatStyle<Double> {
  static var twoDecimalMaxStyle: Self {
    .number.precision(.fractionLength(0...2))
  }
}
