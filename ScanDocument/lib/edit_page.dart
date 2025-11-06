import 'package:dynamsoft_capture_vision_flutter/dynamsoft_capture_vision_flutter.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final ImageData originalImageData;
  final Quadrilateral quad;

  const EditPage({super.key, required this.originalImageData, required this.quad});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  ImageEditorViewController? _controller;

  @override
  void initState() {
    super.initState();
    // Set original image and quad after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller?.setImageData(widget.originalImageData);
      _controller?.setDrawingQuads([widget.quad], EnumDrawingLayerId.ddn.value);
    });
  }

  Future<void> _cropImageAndPop() async {
    try {
      final selectedQuad = await _controller!.getSelectedQuad();
      final croppedImageData = await ImageProcessor().cropAndDeskewImage(widget.originalImageData, selectedQuad);

      if (mounted) {
        Navigator.pop(context, {'croppedImageData': croppedImageData, 'updatedQuad': selectedQuad});
      }
    } catch (e) {
      print('The quadrilateral is invalid.');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('The selected area is close to a triangle, please change it to a quadrilateral.'),
            duration: const Duration(seconds: 5),
            action: SnackBarAction(label: 'OK', onPressed: () {}),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Document')),
      body: Column(
        children: [
          Expanded(
            child: ImageEditorView(
              imageData: widget.originalImageData,
              // drawingLayerId: EnumDrawingLayerId.ddn.id,
              drawingQuadsByLayer: {
                EnumDrawingLayerId.ddn: [widget.quad],
              },
              onPlatformViewCreated: (controller) {
                _controller = controller;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(onPressed: _cropImageAndPop, child: const Text('Confirm')),
          ),
        ],
      ),
    );
  }
}
