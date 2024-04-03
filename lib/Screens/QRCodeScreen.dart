import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:artswindsoressex/constants.dart';
import 'package:artswindsoressex/Screens/DetailScreen.dart';

class QrScannerScreen extends StatefulWidget {
  static const id = "QRCodeScreen";
  @override
  _QrScannerScreenState createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? result;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            formatsAllowed: [
              BarcodeFormat.qrcode,
            ],
            overlay: QrScannerOverlayShape(
              borderColor: orangeColor,
              borderRadius: 20,
              borderWidth: 10,
              cutOutSize: MediaQuery.of(context).size.width / 2,
            ),
          ),
          Positioned(
            top: 70.0,
            left: 100.0,
            right: 100.0,
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Image.asset(
                  "assets/awe_logo.png",
                  height: 70,
                  width: 70,
                )
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.take(1).listen((scanData) {
        Navigator.pushNamed(context, DetailScreen.id,arguments: {'result' : scanData!.code});
    });
  }
}
