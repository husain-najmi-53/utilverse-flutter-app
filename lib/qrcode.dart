import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';




class QRCodeGenerator extends StatefulWidget {
  const QRCodeGenerator({Key? key}) : super(key: key);

  @override
  _QRCodeGeneratorState createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  String _data = '';

  Future<void> _saveQrCode() async {
    try {
      RenderRepaintBoundary boundary =
      key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      // Convert the boundary to an image
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      // Convert image to byte data
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      // Store image in gallery
      if (byteData != null) {
        await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
        // Show a snackbar upon successful save
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('QR code saved to gallery')),
        );
      }
    } catch (e) {
      // Show an error snackbar if saving fails
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save QR code')),
      );
    }
  }

  GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Generator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _saveQrCode,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter data',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  _data = value;
                });
              },
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: Center(
                child: _data.isEmpty
                    ? const Text('No data entered', style: TextStyle(fontSize: 18.0)) as Widget?
                    : RepaintBoundary(
                        key: key,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromRGBO(88, 20, 143, 1).withOpacity(0.4),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(20.0),
                          child: QrImageView(
                            data: _data,
                            version: QrVersions.auto,
                            size: 300.0,
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}