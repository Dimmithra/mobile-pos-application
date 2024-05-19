import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pos/utils/message.dart';
import 'package:mobile_pos/widget/qrResultScreen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:developer' as dev;

class QrScannerViewScreen extends StatefulWidget {
  const QrScannerViewScreen({super.key});

  @override
  State<QrScannerViewScreen> createState() => _QrScannerViewScreenState();
}

class _QrScannerViewScreenState extends State<QrScannerViewScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  String qrText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
        title: Text(
          "Scan QR",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text(
                      'Scan Success Please Press Add to card',
                      style: TextStyle(color: Colors.amber.shade900),
                    )
                  else
                    const Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: IconButton(
                          onPressed: () async {
                            await controller?.toggleFlash();
                            setState(() {});
                          },
                          icon: Icon(Icons.flash_on),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: IconButton(
                          onPressed: () async {
                            dev.log(result!.code.toString());
                            qrText = result!.code.toString();
                            Map<String, String> dataMap = parseQRResult(qrText);
                            if (result != null)
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QrResultScreen(
                                    dataMap: dataMap,
                                  ),
                                ),
                              );
                            else
                              commonMessage(context,
                                      errorTxt:
                                          "Blank Value Cannot add the cart",
                                      btnType: 1)
                                  .show();

                            setState(() {});
                          },
                          icon: Icon(Icons.add_shopping_cart_sharp),
                        ),
                      ),
                      //    ElevatedButton(
                      //     onPressed: () async {
                      //       // await controller?.resumeCamera();
                      //       dev.log("${result!.format}");
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (context) =>
                      //                 QrResultScreen(result: "${result!.code}"),
                      //           ));
                      //     },
                      //     child: const Text('Add to Card',
                      //         style: TextStyle(fontSize: 20)),
                      //   ),
                      // ),
                      // Container(
                      //     margin: const EdgeInsets.all(8),
                      //     child: IconButton(
                      //         onPressed: () async {
                      //           await controller?.flipCamera();
                      //           setState(() {});
                      //         },
                      //         icon: Icon(Icons.photo_camera_front_sharp)))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Container(
                      //   margin: const EdgeInsets.all(8),
                      //   child: ElevatedButton(
                      //     onPressed: () async {
                      //       await controller?.pauseCamera();
                      //     },
                      //     child: const Text('pause',
                      //         style: TextStyle(fontSize: 20)),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.blue,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 5,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) {
        setState(() {
          _onPermissionSet(context, ctrl, p);
        });
      },
      // (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    dev.log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Map<String, String> parseQRResult(String result) {
    Map<String, String> map = {};
    List<String> parts = result.split(', ');
    for (var part in parts) {
      List<String> keyValue = part.split(': ');
      if (keyValue.length == 2) {
        map[keyValue[0].trim()] = keyValue[1].trim();
      }
    }
    return map;
  }
}
