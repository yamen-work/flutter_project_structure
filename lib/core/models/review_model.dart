import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class ReviewModel {

  final int? id;
  final String game;
  final String name;
  final String email;
  final int rating;
  final String message;

  final List<String> imageUrls;

  final List<PlatformFile> imageFiles;


  Future<Map<String, dynamic>> toJson() async {
    return {
      "game": game,
      "name": name,
      "email": email,
      "rating": rating,
      "message": message,
      "images": [
        for (final image in imageFiles)
          await MultipartFile.fromFile(
            image.path!,
            filename: image.name
          ),
      ],
    };
  }


  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json["id"],
      game: json["game"],
      name: json["name"],
      email: json["email"],
      rating: json["rating"],
      message: json["message"],
      imageUrls: List<String>.from(json["images"] ?? []),
      imageFiles: [],
    );
  }

  ReviewModel({this.id, required this.game, required this.name, required this.email, required this.rating, required this.message, required this.imageUrls, required this.imageFiles});
}

