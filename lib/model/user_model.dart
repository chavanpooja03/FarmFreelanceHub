class UserModel {
  String? uid;
  String? name;
  String? phone;
  String? street;
  String? village;
  String? taluka;
  String? district;
  int? zip;
  String? state;

  UserModel({
    this.uid,
    this.name,
    this.phone,
    this.street,
    this.village,
    this.taluka,
    this.district,
    this.zip,
    this.state,
  });

  // Method to convert UserModel to JSON format
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'district': district,
      'phone': phone,
      'state': state,
      'street': street,
      'taluka': taluka,
      'uid': uid,
      'village': village,
      'zip': zip,
    };
  }
}
