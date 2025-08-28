import 'dart:io';

import 'package:dynamsoft_capture_vision_flutter/dynamsoft_capture_vision_flutter.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'edit_page.dart';
import 'dart:typed_data';

class ResultPage extends StatefulWidget {
  final ImageData deskewedImage;
  final ImageData originalImage;
  final Quadrilateral sourceDeskewQuad;

  const ResultPage({
    super.key,
    required this.originalImage,
    required this.deskewedImage,
    required this.sourceDeskewQuad,
  });

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late ImageData _deskewImage;
  late ImageData _showingImage;
  late Quadrilateral _quad;

  @override
  void initState() {
    super.initState();
    _deskewImage = widget.deskewedImage;
    _showingImage = _deskewImage;
    _quad = widget.sourceDeskewQuad;
  }

  Future<void> _changeColourMode(EnumImageColourMode mode) async {
    final cvr = CaptureVisionRouter.instance;
    final settings = await cvr.getSimplifiedSettings(EnumPresetTemplate.normalizeDocument);
    if (settings?.documentSettings != null) {
      settings!.documentSettings!.colourMode = mode;
      cvr.updateSettings(EnumPresetTemplate.normalizeDocument, settings);
      final result = await cvr.capture(_deskewImage, EnumPresetTemplate.normalizeDocument);
      if (result.processedDocumentResult?.enhancedImageResultItems != null &&
          result.processedDocumentResult?.enhancedImageResultItems?.isNotEmpty == true) {
        setState(() {
          _showingImage = result.processedDocumentResult!.enhancedImageResultItems![0].imageData!;
        });
      }
    }
  }

  Future<void> _navigateToEdit() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => EditPage(
          originalImageData: widget.originalImage,
          quad: _quad,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        if (result['croppedImageData'] != null) {
          _deskewImage = result['croppedImageData'];
          _showingImage = _deskewImage;
        }
        if (result['updatedQuad'] != null) {
          _quad = result['updatedQuad'];
        }
      });
    }
  }

  void _showColourModeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Colour Mode'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildColourModeOption('Colorful', EnumImageColourMode.colour),
              _buildColourModeOption('Grayscale', EnumImageColourMode.grayscale),
              _buildColourModeOption('Binary', EnumImageColourMode.binary),
            ],
          ),
        );
      },
    );
  }

  Widget _buildColourModeOption(String title, EnumImageColourMode mode) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        _changeColourMode(mode);
      },
    );
  }

  Future<void> _exportImage() async {
    try {
      Directory directory;
      if (Platform.isAndroid) {
        directory = (await getExternalStorageDirectory())!;
      } else {
        directory = await getApplicationDocumentsDirectory();
      }
      final filePath = "${directory.path}/dynamsoft_output.jpg";

      ImageManager().saveToFile(_deskewImage, filePath, true);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image saved as: $filePath'),
            duration: const Duration(seconds: 5),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save image: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Document Result')),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder<Uint8List?>(
                future: ImageDataUtils.imageDataToJpegBytes(_showingImage),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return Align(
                      alignment: Alignment.center,
                      child: Image.memory(snapshot.data!),
                    );
                  } else {
                    return const Text('No image data');
                  }
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_outlined),
            label: 'Back to Edit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.color_lens_outlined),
            label: 'Switch colour Mode',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save_alt_outlined),
            label: 'Export',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              _navigateToEdit();
              break;
            case 1:
              _showColourModeDialog();
              break;
            case 2:
              _exportImage();
              break;
          }
        },
      ),
    );
  }
}
