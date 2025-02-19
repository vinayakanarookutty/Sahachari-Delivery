class UserData {
  final String name;
  final String address;
  final String phoneNo;

  UserData({
    required this.name,
    required this.address,
    required this.phoneNo,
  });

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      address: map['address'] ?? '',
      phoneNo: map['phoneNo'] ?? '',
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'phoneNo': phoneNo,
    };
  }
}
