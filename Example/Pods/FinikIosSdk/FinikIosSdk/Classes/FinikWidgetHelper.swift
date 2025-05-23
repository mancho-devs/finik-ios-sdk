//
//  FinikWidgetHelper.swift
//  FinikIosSdk
//
//  Created by Akylbek Birimkulov on 22/5/25.
//

public class FinikWidget {
    public let textScenario: TextScenario

    public init(textScenario: TextScenario) {
        self.textScenario = textScenario
    }

    public func toDictionary() -> [String: Any] {
        return [
            "textScenario": textScenario.rawValueString
        ]
    }
}

public class GetItemHandlerWidget: FinikWidget {
    public let itemId: String

    public init(
        itemId: String, textScenario: TextScenario = TextScenario.payment
    ) {
        self.itemId = itemId
        super.init(textScenario: textScenario)
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
    public let callbackUrl: String?
    public let fixedAmount: Double?
    public let requiredFields: [RequiredField]?

    public init(
        accountId: String,
        nameEn: String,
        callbackUrl: String? = nil,
        textScenario: TextScenario = TextScenario.payment,
        fixedAmount: Double? = nil,
        requiredFields: [RequiredField]? = nil
    ) {
        self.accountId = accountId
        self.nameEn = nameEn
        self.callbackUrl = callbackUrl
        self.fixedAmount = fixedAmount
        self.requiredFields = requiredFields
        super.init(textScenario: textScenario)
    }

    public override func toDictionary() -> [String: Any] {
        var dict = super.toDictionary()
        dict["type"] = "createItem"
        dict["accountId"] = accountId
        dict["nameEn"] = nameEn
        dict["callbackUrl"] = callbackUrl
        dict["fixedAmount"] = fixedAmount

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
