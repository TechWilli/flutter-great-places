import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_great_places/providers/great_place_provider.dart';

import 'package:flutter_great_places/widgets/image_input.dart';
import 'package:flutter_great_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

class PlaceForm extends StatefulWidget {
  const PlaceForm({Key? key}) : super(key: key);

  @override
  State<PlaceForm> createState() => _PlaceFormState();
}

class _PlaceFormState extends State<PlaceForm> {
  final _titleController = TextEditingController();
  File? _pickedImage;

  void _selectImage(File? image) => _pickedImage = image;

  void _handleSubmitForm() {
    if (_titleController.text.isEmpty || _pickedImage == null) return;

    // listen false pois a função nao está denrtro do build da árvore de renderização
    Provider.of<GreatPlaceProvider>(context, listen: false).addPlace(
      title: _titleController.text,
      image: _pickedImage!,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final formHeight = MediaQuery.of(context).size.height -
        kToolbarHeight -
        MediaQuery.of(context).viewPadding.top;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Novo Lugar'),
          elevation: 1,
          toolbarHeight: kToolbarHeight,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: formHeight,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ImageInput(onSelectImage: _selectImage),
                const LocationInput(),
                const Spacer(),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    elevation: 0,
                    shape: const BeveledRectangleBorder(),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: _handleSubmitForm,
                  icon: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  label: const Text(
                    'Adicionar',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
