import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:artswindsoressex/constants.dart';
import 'package:artswindsoressex/Screens/DetailScreen.dart';
import 'package:artswindsoressex/API/TransactionRequest.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:artswindsoressex/ChangeNotifiers/ArtworkProvider.dart';
import 'package:artswindsoressex/Database/DatabaseHelper.dart';
import 'package:artswindsoressex/Database/TableEnum.dart';
import 'package:artswindsoressex/Database/ArtworkScanned.dart';
import 'package:artswindsoressex/Database/ArtworkTag.dart';
import 'package:artswindsoressex/Screens/Models/TagModel.dart';


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
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

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
    controller.scannedDataStream.take(1).listen((scanData) async {
      await Provider.of<ArtworkProvider>(context,listen: false).fetchSingleArtwork(scanData.code!);
      if(!Provider.of<ArtworkProvider>(context,listen: false).error){
        var artwork = Provider.of<ArtworkProvider>(context, listen: false).artwork;
        if(!(await DatabaseHelper().isArtworkIdExists(artwork.artwork_id))){
          ArtworkScanned artworkScanned = ArtworkScanned.db(artworkId: artwork.artwork_id, title: artwork.title, description: artwork.description, location: artwork.location.latitude + ", " + artwork.location.longitude, imageUrl: artwork.image, unlocked: true,);
          DatabaseHelper().insertData(TableName.ArtworkScanned, artworkScanned.toMap());

          List<TagModel> tagModels = artwork.tags;
          List<Map<String,dynamic>> artworkTags = tagModels.map((tag) => ArtworkTag(artworkId: artworkScanned.artworkId, tagId: tag.id).toMap()).toList();

          DatabaseHelper().insertAllData(TableName.ArtworkTag, artworkTags);
        }
        TransactionRequest.postTransaction(scanData.code!);
        Navigator.popAndPushNamed(context, DetailScreen.id);
      }
    });
  }

  _requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.request();
    switch (status) {
      case PermissionStatus.denied:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Permission Denied'),
              content: Text('Please enable camera permission in app settings.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        break;
      case PermissionStatus.permanentlyDenied:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Permission Denied'),
              content: Text('Please enable camera permission in app settings.'),
              actions: <Widget>[
                TextButton(
                  child: Text('Open Settings'),
                  onPressed: () {
                    openAppSettings();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        break;
      case PermissionStatus.restricted:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Permission Restricted'),
              content: Text('Camera permission is restricted.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        break;
      default:
        break;
    }
  }

}
