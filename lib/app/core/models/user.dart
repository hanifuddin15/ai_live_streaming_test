import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  String? id;
  String? name;
  String?email;
  String?role;
  bool? isActive;
  String? companyId;
  String? organizationId;
  UserModel({
    this.id,
    this.name,
    this.email,
    this.role,
    this.isActive,
    this.companyId,
    this.organizationId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'isActive': isActive,
      'companyId': companyId,
      'organizationId': organizationId,
     
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      role: map['role'],
      isActive: map['isActive'],
    companyId: map['companyId'],
      organizationId: map['organizationId'],
   
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, name: $name, role: $role, isActive: $isActive, companyId: $companyId, organizationId: $organizationId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.email == email &&
        other.name == name &&
        other.role == role &&
        other.isActive == isActive &&
        other.companyId == companyId &&
        other.organizationId == organizationId;
        
        
        
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        name.hashCode ^
        role.hashCode ^
        isActive.hashCode ^
        companyId.hashCode ^
        organizationId.hashCode;
       
  }
}
