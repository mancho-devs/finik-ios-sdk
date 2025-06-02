//
//  FinikSdkProvider.swift
//  FinikIosSdk
//
//  Created by Akylbek Birimkulov on 15/5/25.
//

import Flutter
import UIKit

public class FinikSdkProvider {

    public static func present(
        from viewController: UIViewController,
        apiKey: String,
        isBeta: Bool = false,
        locale: String,
        textScenario: TextScenario = TextScenario.payment,
        useHiveForGraphQLCache: Bool = true,
        onBackPressed: @escaping () -> Void,
        onPaymentSuccess: @escaping ([String: Any]) -> Void,
        onPaymentFailure: @escaping (String) -> Void,
        widget: FinikWidget
    ) {
        guard let engine = FlutterEngineHolder.shared.engine else {
            print("Flutter engine not initialized")
            return
        }

        engine.viewController = nil

        let flutterVC = FlutterViewController(
            engine: engine, nibName: nil, bundle: nil)

        flutterVC.modalPresentationStyle = .fullScreen

        let channel = FlutterMethodChannel(
            name: "finik_sdk_channel",
            binaryMessenger: flutterVC.binaryMessenger)

        channel.setMethodCallHandler {
            (call: FlutterMethodCall, result: @escaping FlutterResult) in
            switch call.method {

            case "onBackPressed":
                onBackPressed()
                flutterVC.dismiss(animated: true, completion: nil)
                result(nil)

            case "onPayment":
                if let args = call.arguments as? [String: Any] {
                    onPaymentSuccess(args)
                } else {
                    print("Invalid arguments for onPaymentSuccess")
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
                "useHiveForGraphQLCache": useHiveForGraphQLCache,
                "widget": widget.toDictionary(),
            ]

            channel.invokeMethod("getFinikSdkParams", arguments: args)

        }

    }

}
