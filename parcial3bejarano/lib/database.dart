// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';

class Database {
  late FirebaseFirestore firestore;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> create(String name, int capa, String lat, String lon) async {
    try {
      await firestore.collection("estadios").add({
        'nombre': name,
        'capacidad': capa,
        'C_latitud': lat,
        'C_longitud': lon,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore.collection("estadios").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<List> read() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot =
          await firestore.collection('estadios').orderBy('nombre').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {
            "id": doc.id,
            "nombre": doc['nombre'],
            "capacidad": doc["capacidad"],
            "C_latitud": doc["C_latitud"],
            "C_longitud": doc["C_longitud"]
          };
          docs.add(a);
        }
        return docs;
      }
    } catch (e) {
      print(e);
    }
    return read();
  }

  Future<void> update(
      String id, String name, int capa, String lat, String lon) async {
    try {
      await firestore.collection("estadios").doc(id).update({
        'nombre': name,
        'capacidad': capa,
        'C_latitud': lat,
        'C_longitud': lon
      });
    } catch (e) {
      print(e);
    }
  }
}
