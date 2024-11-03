

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget profileWidget({String? imageUrl,File? image}){
  print("image value $image");
  if (image==null){
    if (imageUrl==null) {
      return Image.asset(
        'assets/profile_ic.png',
        fit: BoxFit.cover,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            SizedBox(height: 50,width: 50,child: Container(margin: const EdgeInsets.all(20),child: const CircularProgressIndicator())),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    }
  }else{
    return Image.file(image,fit: BoxFit.cover,);
  }
}