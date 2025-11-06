import 'dart:io';
import 'dart:typed_data';

import 'package:dynamsoft_capture_vision_flutter/dynamsoft_capture_vision_flutter.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'edit_page.dart';

class ResultPage extends StatefulWidget {
  final ImageData deskewedImage;
  final ImageData originalImage;
  final Quadrilateral sourceDeskewQuad;

  const ResultPage({super.key, required this.originalImage, required this.deskewedImage, required this.sourceDeskewQuad});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late ImageData _deskewedColorfulImage;
  late ImageData _showingImage;
  late Quadrilateral _quad;

  @override
  void initState() {
    super.initState();
    _deskewedColorfulImage = widget.deskewedImage;
    _showingImage = _deskewedColorfulImage;
    _quad = widget.sourceDeskewQuad;
  }

  Future<void> _changeColourMode(EnumImageColourMode mode) async {
    if (mode == EnumImageColourMode.colour) {
      _showingImage = _deskewedColorfulImage;
    } else if (mode == EnumImageColourMode.grayscale) {
      _showingImage = (await ImageProcessor().convertToGray(_deskewedColorfulImage))!;
    } else if (mode == EnumImageColourMode.binary) {
      _showingImage = (await ImageProcessor().convertToBinaryLocal(_deskewedColorfulImage, compensation: 15))!;
    }
    setState(() {}); // Update the UI to reflect the new colour mode
  }

  Future<void> _navigateToEdit() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => EditPage(originalImageData: widget.originalImage, quad: _quad),
      ),
    );

    if (result != null) {
      setState(() {
        if (result['croppedImageData'] != null) {
          _deskewedColorfulImage = result['croppedImageData'];
          _showingImage = _deskewedColorfulImage;
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
      final filePath = "${directory.path}/dynamsoft_output_${DateTime.now().millisecondsSinceEpoch}.png";

      ImageIO().saveToFile(_showingImage, filePath, true);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image saved as: $filePath'), duration: const Duration(seconds: 5)));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save image: $e')));
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
                future: ImageIO().saveToMemory(_showingImage, EnumImageFileFormat.png),
                builder: (context, snapshot) {
                  return snapshot.data != null ? Image.memory(snapshot.data!) : const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.edit_outlined), label: 'Back to Edit'),
          BottomNavigationBarItem(icon: Icon(Icons.color_lens_outlined), label: 'Switch colour Mode'),
          BottomNavigationBarItem(icon: Icon(Icons.save_alt_outlined), label: 'Export'),
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
