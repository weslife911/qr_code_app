import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrcode_gen/pages/generate_code_page.dart';

class ScanCodePage extends StatefulWidget {
  const ScanCodePage({super.key});

  @override
  State<ScanCodePage> createState() => _ScanCodePageState();
}

class _ScanCodePageState extends State<ScanCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QR Code"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GenerateCodePage(),
                  ));
            },
            icon: const Icon(Icons.qr_code),
          )
        ],
      ),
      body: MobileScanner(
        controller: MobileScannerController(
            detectionSpeed: DetectionSpeed.noDuplicates, returnImage: true),
        onDetect: (capture) {
          final List<Barcode> barCodes = capture.barcodes;
          final Uint8List? image = capture.image;

          if (image != null) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    barCodes.first.rawValue ?? ""
                  ),
                  content: Image(
                    image: MemoryImage(
                      image
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
