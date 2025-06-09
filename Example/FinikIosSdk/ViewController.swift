//
//  ViewController.swift
//  FinikIosSdk
//
//  Created by birimkulov951 on 05/15/2025.
//  Copyright (c) 2025 birimkulov951. All rights reserved.
//

import FinikIosSdk
import UIKit

class ViewController: UIViewController {

    @IBAction func onTapped(_ sender: UIButton) {

        FinikProvider.present(
            from: self,
            apiKey: "YOUR_API_KEY",
            isBeta: true,
            locale: FinikSdkLocale.KY,
            textScenario: TextScenario.REPLENISHMENT,
            paymentMethod: PaymentMethod.QR,
            onBackPressed: {
                print("ExampleApp: Back pressed from Flutter")
            },
            onPayment: { data in
                print("ExampleApp: Payment data: \(data)")
            },
            widget: CreateItemHandlerWidget(
                accountId: "YOUR_ACCOUNT_ID",
                nameEn: "YOUR_NAME_EN",
                requestId: "110ec58a-a0f2-4ac4-8393-c866d813b8d1",
                callbackUrl: "YOUR_CALLBACK_URL",
                fixedAmount: 77.77,
                maxAvailableQuantity: 1,
                requiredFields: [
                    RequiredField(
                        fieldId: "YOU_FIELD_ID", value: "YOUR_FIELD_VALUE")
                ]
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
