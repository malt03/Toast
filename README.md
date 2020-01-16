# Toast

Present Toast.

## Usage
```swift
enum ToastInfo: ToastInfoProvider {
    case info
    case error

    var backgroundColor: UIColor {
        switch self {
        case .info:  return .systemGreen
        case .error: return .systemRed
        }
    }
    var messageColor: UIColor { .white }
    var duration: TimeInterval { 1 }
}

Toast.shared.present(message: "message", info: ToastInfo.info)
```
