# LogSwifty

Simple logging for Swift.

### Usage

```swift
import LogSwifty

class AppDelegate {
  func applicationDidFinishLaunching(_ application: UIApplication) {
    Log.add(logger: DebugLogger())
    Log.v("Test Debug output")
  }
}
```

For other use cases create your own `Logger`:

```swift
class RESTLogger: Logger {
    func log(message: String) {
        // post the log somewhere
    }
}
```
