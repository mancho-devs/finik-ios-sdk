# FinikIosSdk

FinikIosSdk is a native iOS SDK for integrating the Finik payment platform, including full support for embedded Flutter
modules via `.xcframework`.

## 📦 Features

- 🔐 Secure payment integration with Finik server
- 📲 Prebuilt payment UI using Flutter
- 📡 Built-in support for GraphQL data retrieval
- 🧱 Supports multiple widget types (Create/Get payment Item)
- 🌐 Multi-language support: `ky`, `en`, `ru`

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

## Screenshots

<img src="https://github.com/mancho-devs/finik-ios-sdk/blob/master/images/combined-screenshots.png" width="100%" alt="screenshots" />

# 💡 Usage

## 📲 Example Code

Here’s how to use **FinikProvider** to add the SDK to your app:

```swift
FinikProvider.present(
    from: self,
    apiKey: "YOUR_API_KEY",
    isBeta: true,
    locale: FinikSdkLocale.KY,
    textScenario: TextScenario.REPLENISHMENT,
    paymentMethods: [PaymentMethod.ALL],
    enableShare: true,
    enableSupportButtons: true,
    tapableSupportButtons: true,
    onBackPressed: {
      print("ExampleApp: Back pressed from Flutter")
    },
    onPayment: { data in
        print("ExampleApp: Payment data: \(data)")
        
        // Example output:
        // Payment Data: {accountId: test_account_id, amount: 77.95, fields: {amount: 77.77, YOU_FIELD_ID: 
        // YOUR_FIELD_VALUE}, id: 692910201_97ab0bec-69c5-419d-8cfa-4b7963r98b82_DEBIT, requestDate: 1737537122065, 
        // status: SUCCEEDED, transactionDate: 1737537124659, transactionId: 97ab0bec-69c5-419d-8cfa-4b7963b98b82, 
        // transactionType: DEBIT, item: {id: 3667229233_e3b98d14-ffd3-4cf8-b520-e1be9079c3f0}}
    },
    widget: CreateItemHandlerWidget(
        accountId: "YOUR_ACCOUNT_ID",
        nameEn: "YOUR_ITEM_NAME_EN",
        requestId: "110ec58a-a0f2-4ac4-8393-c866d813b8d1",
        amount: FixedAmount(value: 10.0),
        description: "YOUR_ITEM_DESCRIPTION",
        callbackUrl: "YOUR_CALLBACK_URL",
        maxAvailableQuantity: 1,
        maxAvailableAmount: 1000.0,
        startDate: DateComponents(year: 2025, month: 7, day: 1),
        endDate: DateComponents(year: 2025, month: 12, day: 31),
        visibilityType: VisibilityType.PRIVATE,
        requiredFields: [
            RequiredField(
                fieldId: "YOU_FIELD_ID",
                label: "YOU_FIELD_LABEL",
                value: "YOUR_FIELD_VALUE",
                isHidden: false
            )
        ]
    )
)     
```

### Parameters Explained

- **apiKey**: API client key provided by Finik.
- **isBeta**: Whether to use the beta server.
- **locale**: The language used for UI translations. Supported options: FinikSdkLocale.KY, FinikSdkLocale.EN,
  FinikSdkLocale.RU.
- **textScenario**: Defines the context for displayed UI text. Accepted values: TextScenario.PAYMENT,
  TextScenario.REPLENISHMENT.
- **paymentMethods**: Defines which payment options are shown to users:
    - [PaymentMethod.ALL] - Shows all available methods (APP + QR)
    - [PaymentMethod.APP] - Mobile application payment only
    - [PaymentMethod.QR] - QR code payment only
- **enableShimmer**: Controls the visibility of the shimmer animations in the app.
- **enableShare**: Controls the visibility of the share button in the app bar.
- **enableSupportButtons**: Controls whether support buttons are visible.
- **tapableSupportButtons**: Controls whether support buttons are interactive.
- **onBackPressed**: A function triggered when the back button is pressed. Useful for
  custom navigation or showing dialogs.
- **onPayment**: A function triggered when the payment is done. Returns the payment status and other payment data.
- **widget**: The `FinikWidget` managed by `FinikProvider`. ('CreateItemHandlerWidget' or 'GetItemHandlerWidget')

---

## FinikWidget Details

The `FinikWidget` is a basic widget used in the Finik SDK. It lets you add different functions
to your app and is passed to `FinikProvider`. The SDK currently includes these widgets:

# 🧩 Widgets

## 1. CreateItemHandlerWidget

Use this widget to create a new payment item and generate a QR code.

### Parameters

- **accountId** (required): This is the Finik account where the funds will be deposited, acquired from the merchant's
  clients. Reach out to Finik representatives to receive your corporate accountId along with the x-api-key.
- **nameEn** (required): A field used as a QR name that will be displayed to the merchant's clients on their devices
  upon payment.
- **requestId** (optional): A field to control the uniqueness of a request. For each request, it must be unique so that
  Finik ensures no duplicate QR items are created.
- **amount** (optional): Defines the payment configuration. Supported types:
    * \[FixedAmount] - A predefined, non-editable payment amount.
    * \[MinMaxAmount] - Allows users to enter an amount within a specified minimum and maximum range.
    * \[FreeAmount] - Fully flexible; users can input any amount.
- **description** (optional): A short description of the item. Displayed in the payment UI.
- **callbackUrl** (optional): A field used as a webhook. When specified, Finik will send a POST request to your server
  with the payment details in its JSON body, including its final status (either SUCCEEDED or FAILED), as well as
  requiredFields in the form of a `fields` object attribute.
- For detailed specifications, see: https://quip.com/0IA3An5NLWRb
- **maxAvailableQuantity** (optional): Maximum number of times this item can be purchased. Prevents over-selling.
- **maxAvailableAmount** (optional): Maximum total payable amount allowed across all purchases of this item.
- **startDate** (optional): The start date and time from which the item becomes available for payment.
- **endDate** (optional): The end date and time after which the item is no longer available for payment.
- **visibilityType** (optional): Determines whether the item is public or private.
- **requiredFields** (optional): Represents an input field that can be pre-configured and optionally proxied back to
  your server. When RequiredField objects are provided, their key:value pairs will be included in the fields map sent
  to callbackUrl (if configured).
    * fieldId (required): Unique identifier of the field.
    * label (optional): Display text shown to the user.
    * value (optional): Pre-filled value. If not provided, the SDK will prompt the user to enter it.
    * isHidden (optional, default: true): Whether the field should be hidden in the UI.
    * keyboardType (optional): Type of keyboard to use for input (e.g., text, number, email).

### Example Code

```swift
CreateItemHandlerWidget( 
    accountId: "YOUR_ACCOUNT_ID",
    nameEn: "YOUR_ITEM_NAME_EN",
    requestId: "110ec58a-a0f2-4ac4-8393-c866d813b8d1",
    amount: FixedAmount(value: 10.0),
    description: "YOUR_ITEM_DESCRIPTION",
    callbackUrl: "YOUR_CALLBACK_URL",
    maxAvailableQuantity: 1,
    maxAvailableAmount: 1000.0,
    startDate: DateComponents(year: 2025, month: 7, day: 1),
    endDate: DateComponents(year: 2025, month: 12, day: 31),
    visibilityType: VisibilityType.PRIVATE,
    requiredFields: [
        RequiredField(
            fieldId: "YOU_FIELD_ID",
            label: "YOU_FIELD_LABEL",
            value: "YOUR_FIELD_VALUE",
            isHidden: false
        )
    ]
)
```

## 2. GetItemHandlerWidget

Use this widget to retrieve an existing item by its ID and display its details.

### Parameters

- **parameter** (required): Represents a set of parameters that can be used to retrieve an item. Each subtype wraps a
  specific identifier type, ensuring type safety and clarity when making item queries.Supported types:
    * \[ItemId] - Uses the unique item ID to fetch the item.
    * \[ItemShortUrl] - Uses the short URL to fetch the item.
    * \[FreeAmount] - Uses the associated transaction ID to fetch the item.

### Example Code

```swift
GetItemHandlerWidget(
    parameter: ItemId(value: "YOUR_ITEM_ID")
)
```

## Requirements

- iOS 13.0 or later

## 🙋‍♂️ Contributing

- We welcome PRs and issues!
- Feel free to open discussions, suggest features, or contribute code.

## 📄 License

- FinikIosSdk is available under the MIT license. See the LICENSE file for more info.

## 👨‍💻 Author

- Finik — engineering@quickpay.kg

