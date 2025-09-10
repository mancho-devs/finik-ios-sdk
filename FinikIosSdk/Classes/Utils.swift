//
//  Utils.swift
//  FinikIosSdk
//
//  Created by Akylbek Birimkulov on 22/5/25.
//

public class FinikSdkLocale {
    private init() {}

    public static let EN = "en"
    public static let RU = "ru"
    public static let KY = "ky"
}

@objc public enum TextScenario: Int {
    case PAYMENT
    case REPLENISHMENT

    public var rawValueString: String {
        switch self {
        case .PAYMENT: return "PAYMENT"
        case .REPLENISHMENT: return "REPLENISHMENT"
        }
    }

    public init?(rawString: String) {
        switch rawString {
        case "PAYMENT": self = .PAYMENT
        case "REPLENISHMENT": self = .REPLENISHMENT
        default: return nil
        }
    }
}

@objc public enum VisibilityType: Int {
    case PRIVATE
    case PUBLIC

    public var rawValueString: String {
        switch self {
        case .PRIVATE: return "PRIVATE"
        case .PUBLIC: return "PUBLIC"
        }
    }

    public init?(rawString: String) {
        switch rawString {
        case "PRIVATE": self = .PRIVATE
        case "PUBLIC": self = .PUBLIC
        default: return nil
        }
    }
}

@objc public enum PaymentMethod: Int {
    case ALL
    case APP
    case QR

    public var rawValueString: String {
        switch self {
        case .ALL: return "ALL"
        case .APP: return "APP"
        case .QR: return "QR"
        }
    }

    public init?(rawString: String) {
        switch rawString {
        case "ALL": self = .ALL
        case "APP": self = .APP
        case "QR": self = .QR
        default: return nil
        }
    }
}

@objc public enum KeyboardType: Int {
    case EMAIL
    case MONEY
    case NUMBER
    case PHONE
    case PHONE_USER
    case TEXT
    case TEXT_DEVICE_ID

    public var rawValueString: String {
        switch self {
        case .EMAIL: return "EMAIL"
        case .MONEY: return "MONEY"
        case .NUMBER: return "NUMBER"
        case .PHONE: return "PHONE"
        case .PHONE_USER: return "PHONE_USER"
        case .TEXT: return "TEXT"
        case .TEXT_DEVICE_ID: return "TEXT_DEVICE_ID"
        }
    }

    public init?(rawString: String) {
        switch rawString {
        case "EMAIL": self = .EMAIL
        case "MONEY": self = .MONEY
        case "NUMBER": self = .NUMBER
        case "PHONE": self = .PHONE
        case "PHONE_USER": self = .PHONE_USER
        case "TEXT": self = .TEXT
        case "TEXT_DEVICE_ID": self = .TEXT_DEVICE_ID
        default: return nil
        }
    }
}
