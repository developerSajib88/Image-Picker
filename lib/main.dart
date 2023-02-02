

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

  List<XFile?>? multiImage;
  File? cameraImage;
  File? galleryImage;


  Future multiFilePicker()async{

    ImagePicker imagePicker = ImagePicker();
    multiImage = await imagePicker.pickMultiImage();
    setState(() {});
  }

  Future pickFromCamera()async{
   ImagePicker imagePicker = ImagePicker();
   XFile? camera = await imagePicker.pickImage(source: ImageSource.camera);
   File getCameraImg = File(camera!.path);
   cameraImage = getCameraImg;
   setState(() {});
  }

  pickFromGallery()async{
    ImagePicker imagePicker = ImagePicker();
    XFile? gallery = await imagePicker.pickImage(source: ImageSource.gallery);
    File getGalleryImg = File(gallery!.path);
    galleryImage = getGalleryImg;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("File Picker"),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: (){
                      pickFromCamera();
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("Camera"),
                  ),

                  const SizedBox(width: 10.0,),

                  ElevatedButton.icon(
                    onPressed: (){
                      pickFromGallery();
                    },
                    icon: const Icon(Icons.image_rounded),
                    label: const Text("Gallery"),
                  ),

                  const SizedBox(width: 10.0,),


                  ElevatedButton.icon(
                    onPressed: (){
                      multiFilePicker();
                    },
                    icon: const Icon(Icons.folder),
                    label: const Text("File"),
                  ),
                ],
              ),


              Row(
                children: [
                 ClipRRect(
                   borderRadius: BorderRadius.circular(10),
                   child: cameraImage != null? Image.file(cameraImage!,width: 150.0,height: 200.0,fit: BoxFit.cover,):  Container(width: 150.0,height: 200.0 ,child: Icon(Icons.camera)),
                 ),


                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: galleryImage != null? Image.file(galleryImage!,width: 200.0,height: 200.0,fit: BoxFit.cover,): Container(width: 150.0,height: 200.0 ,child: Icon(Icons.image)),
                  )

                ],
              ),


              Expanded(
                child: Visibility(
                  visible: multiImage != null,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: multiImage?.length,
                    itemBuilder: (BuildContext context, int index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.file(File(multiImage![index]!.path),width: 200.0,height: 300.0,fit: BoxFit.cover,),
                        ),
                      );
                    },
                  ),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}

