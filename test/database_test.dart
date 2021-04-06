import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';

void main() async {
  final instance = MockFirestoreInstance();

  // TEST PROFILE DATABASE

  print("Testing the Profile collection in Database ... \n");

  DocumentReference docRefProfile = instance.collection('profiles').doc();
  docRefProfile
      .set({'name': "Test Name", 'phone': 9999999999, 'uid': docRefProfile.id});
  final snapshotProfile = await instance.collection('profiles').get();
  print("Profiles count: " + snapshotProfile.docs.length.toString() + "\n");

  // TEST IP ADDRESS DATABASE

  print("Testing the ipaddresses collection in Database ... \n");

  DocumentReference docRefIp =
      instance.collection('ipaddresses').doc('121.121.121.121');
  docRefIp.set({
    'city': "Test City",
    'country': "test Country",
    'lang': 0.0,
    'lat': 0.0,
    'ip': '121.121.121.121',
    'service_provider': 'Test Service Provider'
  });
  final snapshotIp = await instance.collection('profiles').get();
  print("Profiles count: " + snapshotIp.docs.length.toString() + "\n");

  // TEST HUNTER PROFILE DATABASE

  print("Testing the hunterProfiles collection in Database ... \n");

  DocumentReference docRefHunter = instance.collection('hunterProfiles').doc();
  docRefHunter.set({
    'first': "Test First",
    'last': "Test Last",
    'domain': "Test Domain",
    'email': "Test Email",
    'comapny': "Test Company",
    'confidence': 100,
    'position': 'Test Position',
    'uid': docRefHunter.id
  });
  final snapshotHunter = await instance.collection('hunterProfiles').get();
  print(
      "HunterProfiles count: " + snapshotHunter.docs.length.toString() + "\n");

  // TEST PHONE NUMBER DATABASE

  print("Testing the phoneNumbers collection in Database ... \n");

  DocumentReference docRefPhone = instance.collection('phoneNumbers').doc();
  docRefPhone.set({
    'carrier': "Test Carrier",
    'line_type': "Test Line Tyoe",
    'country_name': "Test Country",
    'location': "Test Location",
    'phone_number': '+91 99999 99999',
    'uid': docRefPhone.id
  });
  final snapshotPhone = await instance.collection('phoneNumbers').get();
  print("PhoneNumbers count: " + snapshotPhone.docs.length.toString() + "\n");
  print(instance.dump());
}
