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
    public let parameter: GetItemParameter

    public init(parameter: GetItemParameter) {
        self.parameter = parameter
        super.init()
    }

    public override func toDictionary() -> [String: Any] {
        var dict = super.toDictionary()
        dict["type"] = "getItem"
        dict["parameter"] = parameter.toDictionary()
        return dict
    }
}

public class GetItemParameter {
    public init() {
    }

    public func toDictionary() -> [String: Any] {
        return [:]
    }
}

public class ItemId: GetItemParameter {
    public let value: String

    public init(value: String) {
        self.value = value
        super.init()
    }

    public override func toDictionary() -> [String: Any] {
        var dict = super.toDictionary()
        dict["type"] = "itemId"
        dict["value"] = value
        return dict
    }
}

public class ItemShortUrl: GetItemParameter {
    public let value: String

    public init(value: String) {
        self.value = value
        super.init()
    }

    public override func toDictionary() -> [String: Any] {
        var dict = super.toDictionary()
        dict["type"] = "itemShortUrl"
        dict["value"] = value
        return dict
    }
}

public class ItemTransactionId: GetItemParameter {
    public let value: String

    public init(value: String) {
        self.value = value
        super.init()
    }

    public override func toDictionary() -> [String: Any] {
        var dict = super.toDictionary()
        dict["type"] = "itemTransactionId"
        dict["value"] = value
        return dict
    }
}

public class CreateItemHandlerWidget: FinikWidget {
    public let accountId: String
    public let nameEn: String
    public let requestId: String?
    public let amount: Amount?
    public let description: String?
    public let callbackUrl: String?
    public let maxAvailableQuantity: Int?
    public let maxAvailableAmount: Double?
    public let startDate: DateComponents?
    public let endDate: DateComponents?
    public let visibilityType: VisibilityType?
    public let mediaFiles: [MediaInput]?
    public let requiredFields: [RequiredField]?

    public init(
        accountId: String,
        nameEn: String,
        requestId: String? = nil,
        amount: Amount? = nil,
        description: String? = nil,
        callbackUrl: String? = nil,
        maxAvailableQuantity: Int? = nil,
        maxAvailableAmount: Double? = nil,
        startDate: DateComponents? = nil,
        endDate: DateComponents? = nil,
        visibilityType: VisibilityType? = VisibilityType.PRIVATE,
        mediaFiles: [MediaInput]? = nil,
        requiredFields: [RequiredField]? = nil
    ) {
        self.accountId = accountId
        self.nameEn = nameEn
        self.requestId = requestId
        self.amount = amount
        self.description = description
        self.callbackUrl = callbackUrl
        self.maxAvailableQuantity = maxAvailableQuantity
        self.maxAvailableAmount = maxAvailableAmount
        self.startDate = startDate
        self.endDate = endDate
        self.visibilityType = visibilityType
        self.mediaFiles = mediaFiles
        self.requiredFields = requiredFields
        super.init()
    }

    public override func toDictionary() -> [String: Any] {
        var dict = super.toDictionary()
        dict["type"] = "createItem"
        dict["accountId"] = accountId
        dict["nameEn"] = nameEn
        dict["requestId"] = requestId
        dict["description"] = description
        dict["callbackUrl"] = callbackUrl
        dict["maxAvailableQuantity"] = maxAvailableQuantity
        dict["maxAvailableAmount"] = maxAvailableAmount
        dict["visibilityType"] = visibilityType?.rawValueString

        let calendar = Calendar.current

        if startDate != nil {
            if let date = calendar.date(from: startDate!) {
                let formatter = ISO8601DateFormatter()
                let isoString = formatter.string(from: date)
                dict["startDate"] = isoString
            }
        }

        if endDate != nil {
            if let date = calendar.date(from: endDate!) {
                let formatter = ISO8601DateFormatter()
                let isoString = formatter.string(from: date)
                dict["endDate"] = isoString
            }
        }

        if let amountDict = amount?.toDictionary() {
            dict["amount"] = amountDict
        }

        if let mediaFiles = mediaFiles {
            dict["mediaFiles"] = mediaFiles.map { $0.toDictionary() }
        }

        if let fields = requiredFields {
            dict["requiredFields"] = fields.map { $0.toDictionary() }
        }

        return dict
    }
}

public class MediaInput {
    public let id: String

    public init(id: String) {
        self.id = id
    }

    public func toDictionary() -> [String: Any] {
        return [
            "id": id
        ]
    }
}

public class RequiredField {
    public let fieldId: String
    public let label: String?
    public let value: String?
    public let isHidden: Bool?
    // Temporarily commented
    // public let keyboardType: KeyboardType?

    public init(
        fieldId: String,
        label: String? = nil,
        value: String? = nil,
        isHidden: Bool? = true
        // keyboardType: KeyboardType? = nil
    ) {
        self.fieldId = fieldId
        self.label = label
        self.value = value
        self.isHidden = isHidden
        // self.keyboardType = keyboardType
    }

    public func toDictionary() -> [String: Any] {
        return [
            "fieldId": fieldId,
            "label": label as Any,
            "value": value as Any,
            "isHidden": isHidden as Any,
            // "keyboardType": keyboardType?.rawValueString as Any,
        ]
    }
}

public class Amount {
    public init() {
    }

    public func toDictionary() -> [String: Any] {
        return [:]
    }
}

public class FixedAmount: Amount {
    public let value: Double

    public init(value: Double) {
        self.value = value
        super.init()
    }

    public override func toDictionary() -> [String: Any] {
        var dict = super.toDictionary()
        dict["type"] = "fixedAmount"
        dict["fixedAmount"] = value
        return dict
    }
}

public class MinMaxAmount: Amount {
    public let min: Double?
    public let max: Double?

    public init(min: Double? = nil, max: Double? = nil) {
        self.min = min
        self.max = max
        super.init()
    }

    public override func toDictionary() -> [String: Any] {
        var dict = super.toDictionary()
        dict["type"] = "minMaxAmount"
        dict["min"] = min
        dict["max"] = max
        return dict
    }
}

public class FreeAmount: Amount {
    public override init() {
        super.init()
    }

    public override func toDictionary() -> [String: Any] {
        var dict = super.toDictionary()
        dict["type"] = "freeAmount"
        return dict
    }
}
