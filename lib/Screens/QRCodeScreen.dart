import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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
            overlay: QrScannerOverlayShape(
              borderColor: Colors.white,
              borderRadius: 10,
              borderWidth: 5,
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
          if (result != null)
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
              ),
              child: Text(
                'Scanned Code: ${result!.code}',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }
}
