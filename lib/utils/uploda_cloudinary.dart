// import 'package:cloudinary_public/cloudinary_public.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class CloudinaryMethod {
//   /// Upload image to Cloudinary with optional timestamp in filename
//   Future<String> uploadImageToCloudinary(XFile file, String childName , bool isPost) async {
//     try {
//       final ext = file.path.split('.').last;
//       final cloudinary = CloudinaryPublic('dcoyszecc', 'vuwyknwj');
//
//       CloudinaryResponse? cloudinaryResponse;
//
//       // Upload only if isPost is true
//
//       if (isPost) {
//         CloudinaryFile.fromFile(
//           file.path,
//           folder: '$childName/${DateTime.now().millisecondsSinceEpoch}.$ext', // timestamp + extension
//           resourceType: CloudinaryResourceType.Image,
//         );
//       }
//
//         cloudinaryResponse = await cloudinary.uploadFile(
//           CloudinaryFile.fromFile(
//             file.path,
//             folder: '$childName/${DateTime.now().millisecondsSinceEpoch}.$ext', // timestamp + extension
//             resourceType: CloudinaryResourceType.Image,
//           ),
//         );
//
//
//       final imageUrl = cloudinaryResponse.secureUrl;
//       debugPrint('Image URL: $imageUrl');
//       return imageUrl;
//     } catch (e) {
//       debugPrint('Cloudinary upload failed: $e');
//       throw Exception('Cloudinary upload failed: $e');
//     }
//   }
// }
