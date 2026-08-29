import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../errors/error_code.dart';
import '../../errors/error_handler.dart';
import '../../errors/remote_excpetions.dart';

class FirebaseService {
  FirebaseService._();

  static final FirebaseService instance = FirebaseService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  
  // AUTH
  

  User? get currentUser {
    return _auth.currentUser;
  }

  Future<UserCredential> register({
    required String email,
    required String password,
    required String name,
    required int age,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await createUserData(
        name: name,
        age: age,
      );

      return credential;
    } catch (e, stackTrace) {
      _handleAuthError(e, stackTrace);
    }
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e, stackTrace) {
      _handleAuthError(e, stackTrace);
    }
  }

  Future<void> forgotPassword({
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email,
      );
    } catch (e, stackTrace) {
      _handleAuthError(e, stackTrace);
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } on FirebaseException catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  
  // AUTH ERROR HANDLING
  

  Never _handleAuthError(
      Object e,
      StackTrace stackTrace,
      ) {
    if (e is RemoteExceptions) {
      throw e;
    }

    if (e is FirebaseAuthException) {
      throw RemoteExceptions(
        ErrorCode.APP_ERROR,
        e.message ?? ErrorCode.APP_ERROR.getLocalizedMessage(),
      );
    }

    if (e is FirebaseException) {
      throw RemoteExceptions(
        ErrorCode.APP_ERROR,
        e.message ?? ErrorCode.APP_ERROR.getLocalizedMessage(),
      );
    }

    debugPrintStack(stackTrace: stackTrace);

    throw RemoteExceptions(
      ErrorCode.APP_ERROR,
      ErrorCode.APP_ERROR.getLocalizedMessage(),
    );
  }

  
  // FIRESTORE - GET LIST
  

  /// Gets all documents from a collection/subcollection.
  ///
  /// Examples:
  ///
  /// getList('users')
  ///
  /// getList('products')
  ///
  /// getList('users/$uid/orders')
  Future<List<Map<String, dynamic>>> getList(
      String collectionPath,
      ) async {
    try {
      final snapshot = await _firestore
          .collection(collectionPath)
          .get();

      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data(),
        };
      }).toList();
    } on FirebaseException catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  
  // FIRESTORE - GET DOCUMENT
  

  /// Gets a single document.
  ///
  /// Returns null if the document doesn't exist.
  Future<Map<String, dynamic>?> getDocument(
      String collectionPath,
      String documentId,
      ) async {
    try {
      final snapshot = await _firestore
          .collection(collectionPath)
          .doc(documentId)
          .get();

      if (!snapshot.exists) {
        return null;
      }
      return {
        'id': snapshot.id,
        ...snapshot.data()!,
      };
    } on FirebaseException catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  
  // FIRESTORE - POST
  

  /// Creates a new document.
  ///
  /// If [documentId] is null, Firestore generates the ID.
  ///
  /// Returns the created document ID.
  Future<String> post(
      String collectionPath,
      Map<String, dynamic> data, {
        String? documentId,
      }) async {
    try {
      final collection = _firestore.collection(collectionPath);

      final document = documentId == null
          ? collection.doc()
          : collection.doc(documentId);

      await document.set(data);

      return document.id;
    } on FirebaseException catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  
  // FIRESTORE - PUT
  

  /// Updates an existing document.
  Future<void> put(
      String collectionPath,
      String documentId,
      Map<String, dynamic> data,
      ) async {
    try {
      await _firestore
          .collection(collectionPath)
          .doc(documentId)
          .update(data);
    } on FirebaseException catch (e) {
      throw ErrorHandler.handle(e);
    }
  }


  // FIRESTORE - DELETE


  /// Deletes a document.
  Future<void> delete(
      String collectionPath,
      String documentId,
      ) async {
    try {
      await _firestore
          .collection(collectionPath)
          .doc(documentId)
          .delete();
    } on FirebaseException catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  
  // USER DATA
  

  Future<void> createUserData({
    required String name,
    required int age,
  }) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw RemoteExceptions(
        ErrorCode.UNAUTHENTICATED,
        ErrorCode.UNAUTHENTICATED.getLocalizedMessage(),
      );
    }

    await post(
      'users',
      {
        'name': name,
        'age': age,
        'email': user.email,
      },
      documentId: user.uid,
    );
  }
}