import 'package:cloud_firestore/cloud_firestore.dart' show CollectionReference, DocumentReference, FirebaseFirestore;

/// Configuration for the Firebase connector
class ConnectorConfig {
  final String region;
  final String namespace;
  final String projectId;

  const ConnectorConfig(this.region, this.namespace, this.projectId);
}

/// Types of SDK callers
enum CallerSDKType {
  generated,
  custom
}

/// Firebase Data Connection Manager
class FirebaseDataConnect {
  final ConnectorConfig config;
  final CallerSDKType sdkType;
  final FirebaseFirestore _firestore;

  FirebaseDataConnect._({
    required this.config,
    required this.sdkType,
  }) : _firestore = FirebaseFirestore.instance;

  static FirebaseDataConnect instanceFor({
    required ConnectorConfig connectorConfig,
    required CallerSDKType sdkType,
  }) {
    return FirebaseDataConnect._(
      config: connectorConfig,
      sdkType: sdkType,
    );
  }

  /// Get a collection reference
  CollectionReference collection(String path) {
    return _firestore.collection(path);
  }

  /// Get a document reference
  DocumentReference document(String path) {
    return _firestore.doc(path);
  }
}

/// Default connector implementation
class DefaultConnector {
  static const ConnectorConfig connectorConfig = ConnectorConfig(
    'us-west1',
    'default',
    'vvvnfccard-4f67c',  // Your Firebase project ID
  );

  final FirebaseDataConnect dataConnect;

  DefaultConnector({required this.dataConnect});

  static DefaultConnector get instance {
    return DefaultConnector(
      dataConnect: FirebaseDataConnect.instanceFor(
        connectorConfig: connectorConfig,
        sdkType: CallerSDKType.generated,
      ),
    );
  }

  /// Helper method to get a collection reference
  CollectionReference getCollection(String path) {
    return dataConnect.collection(path);
  }

  /// Helper method to get a document reference
  DocumentReference getDocument(String path) {
    return dataConnect.document(path);
  }
}

