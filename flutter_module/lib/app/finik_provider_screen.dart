import 'dart:developer';

import 'package:finik_sdk/finik_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/app/utils/utils.dart';
import 'package:flutter_module/app/widgets/initialization_progress_indicator.dart';

class FinikProviderScreen extends StatefulWidget {
  const FinikProviderScreen({super.key});

  @override
  State<FinikProviderScreen> createState() => _FinikProviderScreenState();
}

class _FinikProviderScreenState extends State<FinikProviderScreen> {
  static const _channel = MethodChannel('finik_sdk_channel');

  // SDK parameters
  String? apiKey;
  bool isBeta = false;
  String? locale;
  bool useHiveForGraphQLCache = true;
  bool isCreateItemWidget = true;

  // Widget-specific parameters
  String? accountId;
  String? nameEn;
  String? callbackUrl;
  double? fixedAmount;
  List<RequiredField>? requiredFields;
  String? itemId;
  TextScenario? textScenario;

  @override
  void initState() {
    super.initState();
    _initMethodChannel();
  }

  @override
  Widget build(BuildContext context) {
    if (apiKey == null || locale == null) {
      return const InitializationProgressIndicator();
    }

    final widgetToShow =
        isCreateItemWidget
            ? CreateItemHandlerWidget(
              accountId: accountId!,
              nameEn: nameEn!,
              callbackUrl: callbackUrl,
              textScenario: textScenario!,
              fixedAmount: fixedAmount,
              requiredFields: requiredFields,
            )
            : GetItemHandlerWidget(itemId: itemId!, textScenario: textScenario!);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: FinikProvider(
          apiKey: apiKey!,
          isBeta: isBeta,
          locale: locale!,
          useHiveForGraphQLCache: useHiveForGraphQLCache,
          onBackPressed: _onBackPressed,
          onPaymentSuccess: _onPaymentSuccess,
          onPaymentFailure: _onPaymentFailure,
          widget: widgetToShow,
        ),
      ),
    );
  }

  void _initMethodChannel() {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'getFinikSdkParams') {
        final args = Map<String, dynamic>.from(call.arguments);
        print('FinikSDK: getFinikSdkParams arguments - $args');

        final widgetArgs = Map<String, dynamic>.from(args['widget']);

        setState(() {
          apiKey = args['apiKey'];
          locale = args['locale'];
          isBeta = args['isBeta'] ?? false;
          useHiveForGraphQLCache = args['useHiveForGraphQLCache'] ?? true;

          isCreateItemWidget = widgetArgs['type'] == 'createItem';
          textScenario = parseTextScenario(widgetArgs['textScenario']);

          if (isCreateItemWidget) {
            accountId = widgetArgs['accountId'];
            nameEn = widgetArgs['nameEn'];
            callbackUrl = widgetArgs['callbackUrl'];
            fixedAmount = (widgetArgs['fixedAmount'] as num?)?.toDouble();
            requiredFields =
                (widgetArgs['requiredFields'] as List?)
                    ?.map((e) => RequiredField.fromJson(Map<String, dynamic>.from(e)))
                    .toList();
          } else {
            itemId = widgetArgs['itemId'];
          }
        });
      }
    });
  }

  void _onBackPressed() => _channel.invokeMethod('onBackPressed');

  void _onPaymentSuccess(Map? data) => _channel.invokeMethod('onPaymentSuccess', data);

  void _onPaymentFailure(String message) => _channel.invokeMethod('onPaymentFailure', message);
}
