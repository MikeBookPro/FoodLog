import SwiftUI

struct EditorRowTextStyle: ViewModifier {
  @FocusState private var hasFocus: Bool
  let configuration: EditorRowStyle.TextOptions

  func body(content: Content) -> some View {
    content
      .submitLabel(configuration.contains(.preferContinue) ? .continue : .done)
      .keyboardType(.alphabet)
      .onSubmit(of: .text) {
        hasFocus = false
      }
  }
}

struct EditorRowDecimalStyle: ViewModifier {
  @FocusState private var hasFocus: Bool
  let configuration: EditorRowStyle.NumericOptions

  func body(content: Content) -> some View {
    content
      .focused($hasFocus)
      .keyboardType(configuration.contains(.decimalInput) ? .decimalPad : .numberPad)
      .toolbar {
        if hasFocus {
          ToolbarItemGroup(placement: .keyboard) {
            Spacer()
            Button(configuration.contains(.preferContinue) ? "Continue" : "Done", role: .destructive) {
              hasFocus = false
            }
          }
        }
      }
  }
}

enum EditorRowStyle {
  struct NumericOptions: OptionSet {
    let rawValue: Int64

    static let standard: Self = [.decimalInput, .preferDone]

    static let unknown = Self(rawValue: 1 << 0)
    static let decimalInput = Self(rawValue: 1 << 1)
    static let preferContinue = Self(rawValue: 1 << 2)
    static let preferDone = Self(rawValue: 1 << 3)
  }

  struct TextOptions: OptionSet {
    let rawValue: Int64

    static let standard: Self = [.preferDone]

    static let unknown = Self(rawValue: 1 << 0)
    static let preferContinue = Self(rawValue: 1 << 1)
    static let preferDone = Self(rawValue: 1 << 3)
  }
}

extension View {
  @warn_unqualified_access
  func editorRow(decimalStyle options: EditorRowStyle.NumericOptions, onSubmit submit: (() -> Void)? = nil) -> some View {
    self.modifier(EditorRowDecimalStyle(configuration: options))
  }

  @warn_unqualified_access
  func editorRow(textStyle options: EditorRowStyle.TextOptions) -> some View {
    self.modifier(EditorRowTextStyle(configuration: options))
  }
}

//        static let  option  = Self(rawValue: 1 << 3)
//        static let  option  = Self(rawValue: 1 << 4)
//        static let  option  = Self(rawValue: 1 << 5)
//        static let  option  = Self(rawValue: 1 << 6)
//        static let  option  = Self(rawValue: 1 << 7)
//        static let  option  = Self(rawValue: 1 << 8)
//        static let  option  = Self(rawValue: 1 << 9)
//        static let  option   = Self(rawValue: 1 << 10)
//        static let  option   = Self(rawValue: 1 << 11)
//        static let  option   = Self(rawValue: 1 << 12)
//        static let  option   = Self(rawValue: 1 << 13)
//        static let  option   = Self(rawValue: 1 << 14)
//        static let  option   = Self(rawValue: 1 << 15)
//        static let  option   = Self(rawValue: 1 << 16)
//        static let  option   = Self(rawValue: 1 << 17)
//        static let  option   = Self(rawValue: 1 << 18)
//        static let  option   = Self(rawValue: 1 << 19)
//        static let  option   = Self(rawValue: 1 << 20)
//        static let  option   = Self(rawValue: 1 << 21)
//        static let  option   = Self(rawValue: 1 << 22)
//        static let  option   = Self(rawValue: 1 << 23)
//        static let  option   = Self(rawValue: 1 << 24)
//        static let  option   = Self(rawValue: 1 << 25)
//        static let  option   = Self(rawValue: 1 << 26)
//        static let  option   = Self(rawValue: 1 << 27)
//        static let  option   = Self(rawValue: 1 << 28)
//        static let  option   = Self(rawValue: 1 << 29)
//        static let  option   = Self(rawValue: 1 << 30)
//        static let  option   = Self(rawValue: 1 << 31)
//        static let  option   = Self(rawValue: 1 << 32)
//        static let  option   = Self(rawValue: 1 << 33)
//        static let  option   = Self(rawValue: 1 << 34)
//        static let  option   = Self(rawValue: 1 << 35)
//        static let  option   = Self(rawValue: 1 << 36)
//        static let  option   = Self(rawValue: 1 << 37)
//        static let  option   = Self(rawValue: 1 << 38)
//        static let  option   = Self(rawValue: 1 << 39)
//        static let  option   = Self(rawValue: 1 << 40)
//        static let  option   = Self(rawValue: 1 << 41)
//        static let  option   = Self(rawValue: 1 << 42)
//        static let  option   = Self(rawValue: 1 << 43)
//        static let  option   = Self(rawValue: 1 << 44)
//        static let  option   = Self(rawValue: 1 << 45)
//        static let  option   = Self(rawValue: 1 << 46)
//        static let  option   = Self(rawValue: 1 << 47)
//        static let  option   = Self(rawValue: 1 << 48)
//        static let  option   = Self(rawValue: 1 << 49)
//        static let  option   = Self(rawValue: 1 << 50)
//        static let  option   = Self(rawValue: 1 << 51)
//        static let  option   = Self(rawValue: 1 << 52)
//        static let  option   = Self(rawValue: 1 << 53)
//        static let  option   = Self(rawValue: 1 << 54)
//        static let  option   = Self(rawValue: 1 << 55)
//        static let  option   = Self(rawValue: 1 << 56)
//        static let  option   = Self(rawValue: 1 << 57)
//        static let  option   = Self(rawValue: 1 << 58)
//        static let  option   = Self(rawValue: 1 << 59)
//        static let  option   = Self(rawValue: 1 << 60)
//        static let  option   = Self(rawValue: 1 << 61)
//        static let  option   = Self(rawValue: 1 << 62)
//        static let  option   = Self(rawValue: 1 << 63)
//        static let  option   = Self(rawValue: 1 << 64)
