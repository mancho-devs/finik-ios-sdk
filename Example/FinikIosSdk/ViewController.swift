//
//  ViewController.swift
//  FinikIosSdk
//
//  Created by birimkulov951 on 05/15/2025.
//  Copyright (c) 2025 birimkulov951. All rights reserved.
//

import FinikIosSdk
import Flutter
import FlutterPluginRegistrant
import UIKit

class ViewController: UIViewController {

    @IBAction func onTapped(_ sender: UIButton) {
        FinikProvider.present(
            from: self,
            apiKey: "YOUR_API_KEY",
            isBeta: true,
            locale: FinikSdkLocale.RU,
            textScenario: TextScenario.PAYMENT,
            paymentMethods: [PaymentMethod.ALL],
            enableShimmer: true,
            enableShare: true,
            tapableSupportButtons: true,
            onBackPressed: {
                print("ExampleApp: Back pressed from Flutter")
            },
            onPayment: { data in
                print("ExampleApp: Payment data: \(data)")
            },
            widget: CreateItemHandlerWidget(
                accountId: "YOUR_ACCOUNT_ID",
                nameEn: "YOUR_NAME_EN",
                description: "YOUR_ITEM_DESCRIPTION",
                callbackUrl: "YOUR_CALLBACK_URL",
                fixedAmount: 9.99,
                maxAvailableQuantity: 1,
                requiredFields: [
                    RequiredField(fieldId: "FIELD_ID", value: "VALUE")
                ]
            )
        )

    }

    @IBAction func onTappedAlternative(_ sender: UIButton) {
        FinikProvider.present(
            from: self,
            apiKey: "YOUR_API_KEY",
            isBeta: true,
            locale: FinikSdkLocale.RU,
            textScenario: TextScenario.REPLENISHMENT,
            paymentMethods: [PaymentMethod.QR],
            enableShimmer: false,
            enableShare: false,
            tapableSupportButtons: false,
            onBackPressed: {
                print("ExampleApp: Back pressed from Flutter")
            },
            onPayment: { data in
                print("ExampleApp: Payment data: \(data)")
            },
            widget: GetItemHandlerWidget(
                itemId: "YOUR_ITEM_ID"
            )
        )
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {

        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
