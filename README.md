# YOURLS-swift-api
YOURLS api made in swift

# Usage
```swift
import YOURLS

do {
    let YOURLSInstance = try YOURLS(domain: "sh.google.com", signature: "asc31s", cusConfig: ["usingSSL": true, "apiFilePath": "yourls-api.php"])
    let shorted = YOURLSInstance.short(url: "google.es", with: "gle")
    let stats = YOURLSInstance.getStats(from: "https://sh.google.com/gorliz")
    let filtered = YOURLSInstance.filterStats(from: "top", limit: 10)
    let dbStats = YOURLSInstance.dbStats()
} catch {
    print(error) // something wrong with instance configuration
}

```
