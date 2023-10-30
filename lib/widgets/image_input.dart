import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  const ImageInput({
    Key? key,
    this.onSelectImage,
  }) : super(key: key);

  final Function(File? image)? onSelectImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedFile;

  Future<void> _takePicture() async {
    // usando o ImagePicker da lib image_picker
    final ImagePicker picker = ImagePicker();

    XFile? imageFile = await picker.pickImage(
      source: ImageSource.camera, // podíamos pegar da galeria tbm com .galery
      maxWidth: 600,
    );

    if (imageFile == null) return;

    setState(() {
      _storedFile = File(imageFile.path);
    });

    // para pegar a pasta que posso armazenar docs da aplicação
    final appDir = await syspaths.getApplicationDocumentsDirectory();

    if (_storedFile != null) {
      final String fileName = path.basename(_storedFile!.path);

      // copia o File da imagem para ser armazenado no caminho do appDir.path/fileName
      final savedImage = await _storedFile!.copy('${appDir.path}/$fileName');

      if (widget.onSelectImage != null) widget.onSelectImage!(savedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          child: _storedFile != null
              ? Image.file(
                  _storedFile!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : const Text(
                  'Nenhuma imagem',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
        ),
        const SizedBox(width: 10),
        TextButton.icon(
          onPressed: _takePicture,
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.primary,
          ),
          icon: const Icon(Icons.camera),
          label: const Text('Tirar foto'),
        )
      ],
    );
  }
}
