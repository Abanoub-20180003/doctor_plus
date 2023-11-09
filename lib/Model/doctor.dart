class Doctor {
  String? name, email, id, organizationId, image;
  String? password;

  Doctor();

  Doctor.data(
  {
    required String id,
    required String name,
    required String email,
    required String image,
    required String organizationId,
    required String password,
}
      ){
    this.id=id;
    this.name = name;
    this.email = email;
    this.password = password;
    this.organizationId = organizationId;
    this.image= image;

  }

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor.data(
      id: '',
      //json['id'],
      name: json['name'],
      email:  json['email'],
      image: json['image'],
      organizationId: '',
      //json['organizationId'],
      password: '',
      //json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name' : name,
      'email': email,
      'organizationId': organizationId,
      'image': image,
      'password': password,
    };
  }
}
