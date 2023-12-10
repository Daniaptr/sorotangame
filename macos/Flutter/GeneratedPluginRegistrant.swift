//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import cloud_firestore
<<<<<<< HEAD
import file_selector_macos
import firebase_auth
import firebase_core
import firebase_storage
=======
import firebase_auth
import firebase_core
>>>>>>> 7886a56aa30fb3dd0b92fe27dc20c1fb389e0d30
import path_provider_foundation

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  FLTFirebaseFirestorePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseFirestorePlugin"))
<<<<<<< HEAD
  FileSelectorPlugin.register(with: registry.registrar(forPlugin: "FileSelectorPlugin"))
  FLTFirebaseAuthPlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseAuthPlugin"))
  FLTFirebaseCorePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseCorePlugin"))
  FLTFirebaseStoragePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseStoragePlugin"))
=======
  FLTFirebaseAuthPlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseAuthPlugin"))
  FLTFirebaseCorePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseCorePlugin"))
>>>>>>> 7886a56aa30fb3dd0b92fe27dc20c1fb389e0d30
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
}
