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
