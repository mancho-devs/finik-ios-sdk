# FinikIosSdk

FinikIosSdk is a native iOS SDK for integrating the Finik payment platform, including full support for embedded Flutter
modules via `.xcframework`.

## 📦 Features

- 🔐 Secure payment integration with Finik server
- 📲 Prebuilt payment UI using Flutter
- 📡 Built-in support for GraphQL data retrieval
- 🧱 Supports multiple widget types (Create/Get payment item)
- 🌐 Multi-language support: `kg`, `en`, `ru`

## 📁 Example Project

To run the example:

1. Clone the repo
2. Run pod install in Example/ directory
3. Run on a real device (simulator is not supported with Flutter release xcframework)

## Getting Started

### 🔧 Installation

Add this line to your Podfile:

```ruby
pod 'FinikIosSdk', '~> "LASTEST_VERSION"'
```

## Ensure you are using dynamic frameworks:

```
target 'YOUR_PROJECT_NAME' do
    use_frameworks!
    # Pods for YOUR_PROJECT_NAME
end
```

## Enable Flutter post-install step (if you integrate a Flutter module):

```
post_install do |installer|
  flutter_post_install(installer) if defined?(flutter_post_install)
end
```

# 🧠 Flutter Engine Initialization

## In AppDelegate.swift, initialize the shared Flutter engine:

``` swift
lazy var flutterEngine = FlutterEngine(name: "finik_ios_sdk")

func application(
  _ application: UIApplication,
  didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
  flutterEngine.run()
  GeneratedPluginRegistrant.register(with: flutterEngine)
  FlutterEngineHolder.shared.engine = flutterEngine
  return true
}    
```

# 💡 Usage

## 📲 Presenting the Finik SDK UI

```swift
FinikSdkProvider.present(
    from: self,
    apiKey: "YOUR_API_KEY",
    isBeta: true,
    locale: FinikSdkLocale.kg,
    useHiveForGraphQLCache: true,
    onBackPressed: {
        print("ExampleApp: Back pressed from Flutter")
    },
    onPaymentSuccess: { data in
        print("ExampleApp: Payment success: \(data)")
        
        // OUTPUT example:
        // payment succeeded: {accountId: test_account_id, amount: 123.95, fields:
        // {amount: 123.95, YOU_FIELD_ID_FOR_REQUIRED_FIELD: YOUR_VALUE}, id:
        // 692910201_9qaq0fec-69c5-419d-8cfa-4b796qb98d82_DEBIT, requestDate: 1737537122065, status: SUCCEEDED,
        // transactionDate: 1737537124659, transactionId: 97ab0bwc-69c5-419d-8cfa-4b7963b98b82, transactionType:
        // DEBIT, item: {id: 3667229233_e3b98d14-ffd3-4cf8-b520-edbef079c3f0}}
    },
    onPaymentFailure: { error in
        print("ExampleApp: Payment failed: \(error)")
    },
    widget: CreateItemHandlerWidget(
        accountId: "YOUR_ACCOUNT_ID",
        nameEn: "YOUR_NAME_EN",
        callbackUrl: "YOUR_CALBACK_URL",
        textScenario: TextScenario.replenishment,
        fixedAmount: 11.11,
        requiredFields: [
            RequiredField(fieldId: "FIELD_ID", value: "VALUE")
        ]
    )
)
```

## Parameters Explained

- **apiKey**: Your API key from the Finik server.
- **isBeta**: Whether to use the beta server. Default is `false`.
- **locale**: The language for translations. Supported options: 'kg', 'en', 'ru'.
- **useHiveForGraphQLCache**: Chooses where to store GraphQL data:
    - Set to `true` for local disk storage using Hive.
    - Set to `false` for temporary in-memory storage (good for app runtime).
- **onBackPressed**: A function triggered when the back button is pressed. Useful for
  custom navigation or showing dialogs.
- **onPaymentSuccess**: A function triggered when the payment is succeeded. Returns the payment data.
- **onPaymentFailure**: A function triggered when the payment is failed. Returns the error message.
- **widget**: The `FinikWidget` managed by `FinikSdkProvider`.

## FinikWidget Details

The `FinikWidget` is a basic widget used in the Finik SDK. It lets you add different functions
to your app and is passed to `FinikSdkProvider`. The SDK currently includes these widgets:

# 🧩 Widgets

## 1. CreateItemHandlerWidget

Use this widget to create a new payment item and generate a QR code.

| Parameter        | Type              | Description                                    |
|------------------|-------------------|------------------------------------------------|
| `accountId`      | `String`          | Required account identifier                    |
| `nameEn`         | `String`          | Item name (English)                            |
| `callbackUrl`    | `String?`         | Optional callback URL                          |
| `textScenario`   | `TextScenario`    | UI text variant (`.payment`, `.replenishment`) |
| `fixedAmount`    | `Double`          | QR amount                                      |
| `requiredFields` | `[RequiredField]` | Additional form fields                         |

### Example Code

```swift
CreateItemHandlerWidget(
    accountId: "YOUR_ACCOUNT_ID",
    nameEn: "YOUR_NAME_EN",
    callbackUrl: "YOUR_CALBACK_URL",
    textScenario: TextScenario.payment,
    fixedAmount: 11.11,
    requiredFields: [
        RequiredField(fieldId: "FIELD_ID", value: "VALUE")
    ]
)
```

## 2. GetItemHandlerWidget

Use this widget to retrieve an existing item by its ID and display its details.

### Parameters

| Parameter      | Type           | Description                                    |
|----------------|----------------|------------------------------------------------|
| `itemId`       | `String`       | The unique ID for the item to fetch            |
| `textScenario` | `TextScenario` | UI text variant (`.payment`, `.replenishment`) |

### Example Code

```swift
GetItemHandlerWidget(
    itemId: "YOUR_ITEM_ID",
    textScenario: TextScenario.replenishment,
)
```

## Requirements

- iOS 12.0 or later

## 🙋‍♂️ Contributing

- We welcome PRs and issues!
- Feel free to open discussions, suggest features, or contribute code.

## 📄 License

- FinikIosSdk is available under the MIT license. See the LICENSE file for more info.

## 👨‍💻 Author

- Finik — engineering@quickpay.kg

