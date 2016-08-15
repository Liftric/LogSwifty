# LogSwifty

Simple logging for Swift.

### Usage

```swift
import LogSwifty

class AppDelegate {
  func applicationDidFinishLaunching(_ application: UIApplication) {
    Log.add(logger: Log.debug)
    Log.v("Test Debug output")
  }
}
```

For other use cases create your own `Logger`:

```swift
import LogSwifty

class RESTLogger: Logger {
    func log(message: String) {
        // post the log somewhere
    }
}

class AppDelegate {
  func applicationDidFinishLaunching(_ application: UIApplication) {
    Log.add(logger: RESTLogger())
    Log.v("Test Debug output")
  }
}
```
