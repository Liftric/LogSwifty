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

Example output:

```swift
2016-08-05 13:58:47 +0000	[info]	AwesomeViewController.swift:3	some stuff to be logged
```
