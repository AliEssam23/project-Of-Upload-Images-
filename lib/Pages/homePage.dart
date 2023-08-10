// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cloud/connect/server.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:image_cloud/connect/apis.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  serverApi server = new serverApi();
  bool _isLoading = false;
  Uint8List? decodedBytes;

  List _images = [];

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      final imageTemporary = File(image!.path);

      Uint8List imageBytes =
          await imageTemporary.readAsBytes(); //convert to bytes
      String base64string =
          base64.encode(imageBytes); //convert bytes to base64 string
      // print(base64string);
      Map<dynamic, dynamic> map = {"image": base64string};
      var info = await server.postRequest(apiPostRequest, map);
      _images.addAll(info);
      setState(() {});
    } on PlatformException catch (e) {
      print(e);
    }
  }

  getRequest() async {
    var info = await server.getRequest(apiGetRequest);

    _images.addAll(info);
    setState(() {});
  }

  @override
  void initState() {
    getRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pickImage();
          _images = [];
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Image Cloud'),
        actions: [
          _isLoading
              ? Padding(
                  padding: const EdgeInsets.all(10),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Container(),
        ],
      ),
      body: _images.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return Container(
                    child: Image.memory(
                  base64.decode("${_images[index]["image"]}"),
                  fit: BoxFit.cover,
                ));
              }),
    );
  }
}
