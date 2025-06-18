//
//  FinikProvider.swift
//  FinikIosSdk
//
//  Created by Akylbek Birimkulov on 3/6/25.
//

import Flutter
import FlutterPluginRegistrant
import UIKit

public class FinikProvider {

    public static func present(
        from viewController: UIViewController,
        apiKey: String,
        isBeta: Bool = false,
        locale: String,
        textScenario: TextScenario = TextScenario.PAYMENT,
        paymentMethods: [PaymentMethod] = [PaymentMethod.ALL],
        enableShare: Bool = true,
        tapableSupportButtons: Bool = true,
        onBackPressed: @escaping () -> Void,
        onPayment: @escaping ([String: Any]) -> Void,
        widget: FinikWidget
    ) {
        let engine = FlutterEngine(name: "finik_ios_sdk-\(UUID().uuidString)")

        engine.run()
        GeneratedPluginRegistrant.register(with: engine)

        engine.viewController = nil

        let flutterVC = FlutterViewController(
            engine: engine, nibName: nil, bundle: nil)
        flutterVC.modalPresentationStyle = .fullScreen

        let channel = FlutterMethodChannel(
            name: "finik_sdk_channel",
            binaryMessenger: flutterVC.binaryMessenger
        )

        channel.setMethodCallHandler {
            (call: FlutterMethodCall, result: @escaping FlutterResult) in
            switch call.method {

            case "onBackPressed":
                onBackPressed()
                flutterVC.dismiss(animated: true) {
                    engine.destroyContext()
                }
                result(nil)

            case "onPayment":
                if let args = call.arguments as? [String: Any] {
                    onPayment(args)
                } else {
                    print("Invalid arguments for onPayment")
                }
                result(nil)

            default:
                result(FlutterMethodNotImplemented)
            }
        }

        viewController.present(flutterVC, animated: true) {

            let args: [String: Any] = [
                "apiKey": apiKey,
                "isBeta": isBeta,
                "locale": locale,
                "textScenario": textScenario.rawValueString,
                "paymentMethods": paymentMethods.map { $0.rawValueString },
                "enableShare": enableShare,
                "tapableSupportButtons": tapableSupportButtons,
                "widget": widget.toDictionary(),
            ]

            channel.invokeMethod("getFinikSdkParams", arguments: args)
        }
    }
}
