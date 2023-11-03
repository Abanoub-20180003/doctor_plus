class Doctor {
  String? name, email, password, id, organizationId, image;

  Doctor();

  Doctor.data(this.name, this.email, this.password, this.id, this.organizationId , this.image);

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor.data(json['name'], json['email'], json['password'], json['id'],
        json['organizationId'] , json['image']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'id,': id,
      'organizationId': organizationId,
      'image': image,
    };
  }
}
