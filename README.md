# LogSwifty

Simple logging for Swift.

### Usage

```swift
class AwesomeViewController: UIViewController, Loggable {
  override func viewDidLoad() {
    log(.info, "some stuff to be logged")
  }
}
```
