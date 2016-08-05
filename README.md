# LogSwifty

Simple logging for Swift.

### Usage

Declare the logger anywhere once.

```swift
extension Logger {
    func logMessage(message: String) {
        print(message)
    }
}
```

Anywhere you need logging:

```swift
class AwesomeViewController: UIViewController, Loggable {
  override func viewDidLoad() {
    log(.info, "some stuff to be logged")
  }
}
```
