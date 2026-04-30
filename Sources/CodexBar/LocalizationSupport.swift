import Foundation

@inline(__always)
func localizedUI(_ text: String) -> String {
    let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !trimmed.isEmpty else { return text }
    return NSLocalizedString(text, comment: "")
}

@inline(__always)
func localizedUIFormat(_ key: String, _ args: CVarArg...) -> String {
    String(format: NSLocalizedString(key, comment: ""), arguments: args)
}
