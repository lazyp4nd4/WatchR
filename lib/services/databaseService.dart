import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:osint/hunter/hunter.dart';
import 'package:osint/ip-locator/ipadd.dart';
import 'package:osint/phone/phone.dart';
import 'package:osint/profile-generation/profile.dart';
import 'package:osint/services/sharedPreferences.dart';

class DatabaseServices {
  final String uid;
  DatabaseServices(this.uid);
  final CollectionReference profileCollection =
      FirebaseFirestore.instance.collection('profiles');

  Future<bool> createUser(String name, String phoneNumber) async {
    phoneNumber != null
        ? await FirebaseFirestore.instance
            .collection('profiles')
            .doc(uid)
            .set({'name': name, 'phoneNumber': phoneNumber, 'uid': uid})
        : await FirebaseFirestore.instance
            .collection('profiles')
            .doc(uid)
            .set({'name': name, 'phoneNumber': "Not Found", 'uid': uid});
    bool ans1 = await SharedFunctions.saveUserName(name);
    bool ans2 = await SharedFunctions.saveUserPN(phoneNumber);
    bool ans3 = await SharedFunctions.saveUserUid(uid);

    return (ans1 && ans2 && ans3);
  }

  addIP(city, country, serviceProvider, ip, lat, lang) {
    FirebaseFirestore.instance.collection('ipaddresses').doc(ip).set({
      'country': country,
      'uid': uid,
      'city': city,
      'service_provider': serviceProvider,
      'ip': ip,
      'lat': lat,
      'lang': lang
    });
  }

  addProfile(photoUrl, fullName, followers, following, bio, username) {
    FirebaseFirestore.instance
        .collection('profileGenerated')
        .doc(username)
        .set({
      'photo_url': photoUrl,
      'uid': uid,
      'full_name': fullName,
      'followers': followers,
      'following': following,
      'bio': bio,
      'username': username,
      'time': DateTime.now().millisecondsSinceEpoch
    });
  }

  addHunterProfile(first, last, domain, email, company, position, confidence) {
    FirebaseFirestore.instance.collection("hunterProfiles").doc(email).set({
      'user_uid': uid,
      'first': first,
      'last': last,
      'domain': domain,
      'email': email,
      'company': company,
      'position': position,
      'confidence': confidence
    });
  }

  addPhoneNumberLocations(
      // ignore: non_constant_identifier_names
      location,
      carrier,
      countryName,
      lineType,
      phoneNumber) {
    FirebaseFirestore.instance.collection("phoneNumbers").doc(phoneNumber).set({
      'id': phoneNumber,
      'uid': uid,
      'location': location,
      'carrier': carrier,
      'country_name': countryName,
      'line_type': lineType,
      'phone_number': phoneNumber
    });
  }

  Future getNameFromUid() async {
    String name;
    await FirebaseFirestore.instance
        .collection('profiles')
        .doc(uid)
        .get()
        .then((value) {
      name = value['name'];
    });
    return name;
  }

  Future getPhoneNumberFromUid() async {
    String phoneNumber;
    await FirebaseFirestore.instance
        .collection('profiles')
        .doc(uid)
        .get()
        .then((value) {
      phoneNumber = value['phoneNumber'];
    });
    return phoneNumber;
  }

  List<IPAdd> _ipListFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return IPAdd(
          city: doc['city'],
          country: doc['country'],
          service_provider: doc['service_provider'],
          ip: doc['ip'],
          lat: doc['lat'],
          lang: doc['lang']);
    }).toList();
  }

  Stream<List<IPAdd>> get ips {
    return FirebaseFirestore.instance
        .collection('ipaddresses')
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map(_ipListFromSnapshots);
  }

  List<Profiless> _profileListFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Profiless(
          city: doc['city'],
          country: doc['country'],
          service_provider: doc['service_provider'],
          ip: doc['ip'],
          lat: doc['lat'],
          lang: doc['lang'],
          username: doc['username'],
          bio: doc['bio'],
          photo_url: doc['photo_url'],
          followers: doc['followers'],
          following: doc['following']);
    }).toList();
  }

  Stream<List<Profiless>> get profiles {
    return FirebaseFirestore.instance
        .collection('profileGenerated')
        .snapshots()
        .map(_profileListFromSnapshots);
  }

  List<Hunter> _hunterProfileListFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Hunter(
          first: doc['first'],
          last: doc['last'],
          domain: doc['domain'],
          company: doc['company'],
          email: doc['email'],
          position: doc['position'],
          confidence: doc['confidence']);
    }).toList();
  }

  Stream<List<Hunter>> get hunterProfiles {
    return FirebaseFirestore.instance
        .collection('hunterProfiles')
        .where('user_uid', isEqualTo: uid)
        .snapshots()
        .map(_hunterProfileListFromSnapshots);
  }

  List<PhoneSt> _phoneNumberListFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PhoneSt(
          location: doc['location'],
          carrier: doc['carrier'],
          line_type: doc['line_type'],
          country_name: doc['country_name'],
          phone_number: doc['phone_number']);
    }).toList();
  }

  Stream<List<PhoneSt>> get phoneNumbers {
    return FirebaseFirestore.instance
        .collection('phoneNumbers')
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map(_phoneNumberListFromSnapshots);
  }
}
