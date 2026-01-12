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
        enableShimmer: Bool = true,
        enableShare: Bool = true,
        enableSupportButtons: Bool = true,
        tapableSupportButtons: Bool = true,
        onBackPressed: @escaping () -> Void,
        onPayment: @escaping ([String: Any]) -> Void,
        widget: FinikWidget
    ) {
        let engine = FlutterEngine(name: "finik_ios_sdk-\(UUID().uuidString)")
        
        engine.run()
        GeneratedPluginRegistrant.register(with: engine)
        
        let flutterVC = FlutterViewController(
            engine: engine,
            nibName: nil,
            bundle: nil
        )
        flutterVC.modalPresentationStyle = .fullScreen
        
        let channel = FlutterMethodChannel(
            name: "finik_sdk_channel",
            binaryMessenger: flutterVC.binaryMessenger
        )
        
        
        DispatchQueue.main.async {
            
            guard let windowScene = UIApplication.shared.connectedScenes
                .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
                  let window = windowScene.windows.first
            else {
                return
            }
            
            let previousRootVC = window.rootViewController
            
            window.rootViewController = flutterVC
            window.makeKeyAndVisible()
            
            let args: [String: Any] = [
                "apiKey": apiKey,
                "isBeta": isBeta,
                "locale": locale,
                "textScenario": textScenario.rawValueString,
                "paymentMethods": paymentMethods.map { $0.rawValueString },
                "enableShimmer": enableShimmer,
                "enableShare": enableShare,
                "enableSupportButtons": enableSupportButtons,
                "tapableSupportButtons": tapableSupportButtons,
                "widget": widget.toDictionary(),
            ]
            
            channel.invokeMethod("getFinikSdkParams", arguments: args)
            
            channel.setMethodCallHandler {
                (call: FlutterMethodCall, result: @escaping FlutterResult) in
                switch call.method {
                    
                case "onBackPressed":
                    onBackPressed()
                    flutterVC.dismiss(animated: true) {
                        engine.destroyContext()
                    }
                    window.rootViewController = previousRootVC
                    result(nil)
                    
                case "onPayment":
                    if let args = call.arguments as? [String: Any] {
                        onPayment(args)
                        flutterVC.dismiss(animated: true) {
                            engine.destroyContext()
                        }
                    } else {
                        print("Invalid arguments for onPayment")
                    }
                    window.rootViewController = previousRootVC
                    result(nil)
                    
                case "onCreated":
                    if let args = call.arguments as? [String: Any] {
                        print("FinikProvider onCreated \(args)")
                        if let createItemWidget = widget as? CreateItemHandlerWidget {
                            createItemWidget.onCreated?(args)
                        } else {
                            print("onCreated ignored: widget is not CreateItemHandlerWidget")
                        }
                    } else {
                        print("Invalid arguments for onCreated")
                    }
                    result(nil)
                    
                default:
                    result(FlutterMethodNotImplemented)
                }
            }
        }
        
    }
}
