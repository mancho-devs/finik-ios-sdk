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

        
//        const apiKeyBeta = 'da2-qtfmf4xkzjeypiexb75aqxtn6u'; // Beta
//        const accountIdBeta = '72145c2f-b987-46b9-b718-5d8313854f69'; // Beta

        
        FinikSdkProvider.present(
            from: self,
            apiKey: "da2-qtfmf4xkzjeypiexb75aqxtn6u",
            isBeta: true,
            locale: FinikSdkLocale.kg,
            textScenario: TextScenario.payment,
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
                accountId: "72145c2f-b987-46b9-b718-5d8313854f69",
                nameEn: "YOUR_NAME_EN",
                requestId: "rewrewrwerewrewrefefewr",
                callbackUrl: "YOUR_CALLBACK_URL",
                fixedAmount: 22,
                maxAvailableQuantity: 1,
                requiredFields: [
                    RequiredField(fieldId: "YOU_FIELD_ID", value: "YOUR_FIELD_VALUE")
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
