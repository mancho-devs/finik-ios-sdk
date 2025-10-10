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
            enableSupportButtons: true,
            tapableSupportButtons: true,
            onBackPressed: {
                print("ExampleApp: Back pressed from Flutter")
            },
            onPayment: { data in
                print("ExampleApp: Payment data: \(data)")
            },
            widget: CreateItemHandlerWidget(
                accountId: "YOUR_ACCOUNT_ID",
                nameEn: "YOUR_ITEM_NAME_EN",
                amount: FixedAmount(value: 99.99),
                description: "YOUR_ITEM_DESCRIPTION",
                callbackUrl: "YOUR_CALLBACK_URL",
                maxAvailableQuantity: 1,
                maxAvailableAmount: 1000.0,
                startDate: DateComponents(year: 2025, month: 7, day: 1),
                endDate: DateComponents(year: 2025, month: 12, day: 31),
                visibilityType: VisibilityType.PRIVATE,
                actionLabelType: ActionLabelType.BUY,
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

    }

    @IBAction func onTappedAlternative(_ sender: UIButton) {
        FinikProvider.present(
            from: self,
            apiKey: "YOUR_API_KEY",
            isBeta: true,
            locale: FinikSdkLocale.RU,
            textScenario: TextScenario.REPLENISHMENT,
            paymentMethods: [PaymentMethod.QR],
            enableShimmer: true,
            enableShare: true,
            enableSupportButtons: false,
            tapableSupportButtons: false,
            onBackPressed: {
                print("ExampleApp: Back pressed from Flutter")
            },
            onPayment: { data in
                print("ExampleApp: Payment data: \(data)")
            },
            widget: GetItemHandlerWidget(
                parameter: ItemId(value: "YOUR_ITEM_ID")
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
