import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapp/models/sheep_models.dart';
import 'package:mobileapp/services/sheep_service.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  bool _flashOn = false;
  bool _frontCam = false;
  GlobalKey _qrKey = GlobalKey();
  QRViewController? _controller;
  final SheepService sheepService = SheepService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          QRView(
            key: _qrKey,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.white,
              borderRadius: 5,
            ),
            onQRViewCreated: _onQRViewCreated,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 60),
              child: const Text(
                "IS-USG",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  onPressed: () async {
                    if (!mounted) return;
                    setState(() {
                      _flashOn = !_flashOn;
                    });
                    await _controller?.toggleFlash();
                  },
                  icon: Icon(_flashOn ? Icons.flash_on : Icons.flash_off),
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: () async {
                    if (!mounted) return;
                    await _controller?.flipCamera();
                    setState(() {
                      _frontCam = !_frontCam;
                    });
                  },
                  icon:
                      Icon(_frontCam ? Icons.camera_front : Icons.camera_rear),
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // void _onQRViewCreated(QRViewController controller) {
  //   this._controller = controller;
  //   controller.scannedDataStream.listen((Barcode barcode) async {
  //     await controller.pauseCamera();
  //     if (!mounted) return;

  //     print('Scanned data: ${barcode.code}');

  //     // Get.toNamed('/detail-sheep', arguments: {
  //     //   'idDomba': barcode.code, // Data yang dipindai dari barcode
  //     //   // Tambahkan data lain yang dibutuhkan
  //     // });
  //      try {
  //       Sheep sheep = await sheepService.fetchSheepById(barcode.code!);
  //       Get.toNamed('/detail-sheep', arguments: {
  //         // 'idDomba' : barcode.code,
  //       'idDomba': sheep.id,
  //       'namaDomba': sheep.sheepName,
  //       'tanggalLahir': sheep.sheepBirth,
  //       'jenisDomba': sheep.sheepGender,
  //       });
  //     } catch (e) {
  //       print('Error fetching sheep data: $e');
  //     }
  //   });
  // }

  void _onQRViewCreated(QRViewController controller) {
    this._controller = controller;
    controller.scannedDataStream.listen((Barcode barcode) async {
      await controller.pauseCamera();
      if (!mounted) return;

      final String? scannedId = barcode.code;
      print('Scanned data: $scannedId');

      if (scannedId != null && scannedId.isNotEmpty) {
        try {
          // Panggil API untuk mendapatkan data domba
          Sheep sheep = await SheepService.fetchSheepById(scannedId);
          // Navigasi ke halaman detail
          Get.toNamed('/detail-sheep', arguments: sheep);
        } catch (e) {
          // Tampilkan pesan kesalahan jika ID tidak ditemukan
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Terjadi kesalahan: $e')),
          );
          await controller.resumeCamera();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kode QR tidak valid')),
        );
        await controller.resumeCamera();
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}