//
//  FinikWidgetHelper.swift
//  FinikIosSdk
//
//  Created by Akylbek Birimkulov on 22/5/25.
//

public class FinikWidget {

    public init() {
    }

    public func toDictionary() -> [String: Any] {
        return [:]
    }
}

public class GetItemHandlerWidget: FinikWidget {
    public let itemId: String

    public init(itemId: String) {
        self.itemId = itemId
        super.init()
    }

    public override func toDictionary() -> [String: Any] {
        var dict = super.toDictionary()
        dict["type"] = "getItem"
        dict["itemId"] = itemId
        return dict
    }
}

public class CreateItemHandlerWidget: FinikWidget {
    public let accountId: String
    public let nameEn: String
    public let requestId: String
    public let callbackUrl: String?
    public let fixedAmount: Double?
    public let maxAvailableQuantity: Int?
    public let requiredFields: [RequiredField]?

    public init(
        accountId: String,
        nameEn: String,
        requestId: String,
        callbackUrl: String? = nil,
        fixedAmount: Double? = nil,
        maxAvailableQuantity: Int? = nil,
        requiredFields: [RequiredField]? = nil
    ) {
        self.accountId = accountId
        self.nameEn = nameEn
        self.requestId = requestId
        self.callbackUrl = callbackUrl
        self.fixedAmount = fixedAmount
        self.maxAvailableQuantity = maxAvailableQuantity
        self.requiredFields = requiredFields
        super.init()
    }

    public override func toDictionary() -> [String: Any] {
        var dict = super.toDictionary()
        dict["type"] = "createItem"
        dict["accountId"] = accountId
        dict["requestId"] = requestId
        dict["nameEn"] = nameEn
        dict["callbackUrl"] = callbackUrl
        dict["fixedAmount"] = fixedAmount
        dict["maxAvailableQuantity"] = maxAvailableQuantity

        if let fields = requiredFields {
            dict["requiredFields"] = fields.map { $0.toDictionary() }
        }

        return dict
    }
}

@objc public enum TextScenario: Int {
    case payment
    case replenishment

    public var rawValueString: String {
        switch self {
        case .payment: return "payment"
        case .replenishment: return "replenishment"
        }
    }

    public init?(rawString: String) {
        switch rawString {
        case "payment": self = .payment
        case "replenishment": self = .replenishment
        default: return nil
        }
    }
}

public class RequiredField {
    public let fieldId: String
    public let value: String

    public init(fieldId: String, value: String) {
        self.fieldId = fieldId
        self.value = value
    }

    public func toDictionary() -> [String: Any] {
        return [
            "fieldId": fieldId,
            "value": value,
        ]
    }
}
