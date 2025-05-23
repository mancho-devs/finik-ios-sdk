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

        FinikSdkProvider.present(
            from: self,
            apiKey: "YOUR_API_KEY",
            isBeta: true,
            locale: FinikSdkLocale.kg,
            useHiveForGraphQLCache: true,
            onBackPressed: {
                print("ExampleApp: Back pressed from Flutter")
            },
            onPaymentSuccess: { data in
                print("ExampleApp: Payment success: \(data)")
            },
            onPaymentFailure: { error in
                print("ExampleApp: Payment failed: \(error)")
            },
            widget: CreateItemHandlerWidget(
                accountId: "YOUR_ACCOUNT_ID",
                nameEn: "YOUR_NAME_EN",
                callbackUrl: "YOUR_CALBACK_URL",
                textScenario: TextScenario.replenishment,
                fixedAmount: 11.11,
                requiredFields: [
                    RequiredField(fieldId: "FIELD_ID", value: "VALUE")
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
