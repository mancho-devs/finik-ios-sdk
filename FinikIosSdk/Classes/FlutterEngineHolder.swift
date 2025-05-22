//
//  FlutterEngineHolder.swift
//  FinikIosSdk
//
//  Created by Akylbek Birimkulov on 21/5/25.
//

import Flutter

public class FlutterEngineHolder {
    public static let shared = FlutterEngineHolder()

    private init() {}

    public var engine: FlutterEngine?
}
