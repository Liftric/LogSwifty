# LogSwifty

Simple logging for Swift.

### Usage

```swift
import LogSwifty

class AppDelegate {
  func applicationDidFinishLaunching(_ application: UIApplication) {
    Log.add(logger: Log.debug)
  }
}

class SomeViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    Log.v("hi there!")
  }
}
```

For other use cases create your own Logger:

```swift
import LogSwifty

class RESTLogger: Logger {
    func log(message: Message) {
        // post the log somewhere
        SomeHttpService.postLogMessage(message)
    }
}

class AppDelegate {
  func applicationDidFinishLaunching(_ application: UIApplication) {
    Log.add(logger: RESTLogger())
    #if DEBUG
      Log.add(logger: Log.debug)
    #endif
  }
}
```
