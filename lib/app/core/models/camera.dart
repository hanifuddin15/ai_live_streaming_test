class Camera {
  final String? id;
  final String? camId;
  final String? name;
  final String? rtspUrl;
  final String? companyId;
  final String? createdAt;
  final String? updatedAt;
  final String? relayAgentId;
  final String? rtspUrlEnc;
  final String? sendFps;
  final String? sendWidth;
  final String? sendHeight;
  final String? jpegQuality;
  final bool isActive;


  Camera({
     this.id,
     this.name,
     this.rtspUrl,
     this.camId,
     this.companyId,
     this.createdAt,
     this.updatedAt,
     this.relayAgentId,
     this.rtspUrlEnc,
     this.sendFps,
     this.sendWidth,
     this.sendHeight,
     this.jpegQuality,
    this.isActive = false,
  });

  factory Camera.fromJson(Map<String, dynamic> json) {
    return Camera(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      rtspUrl: json['rtspUrl'] ?? '',
      isActive: json['isActive'] ?? false,
      camId: json['camId'] ?? '',
      companyId: json['companyId'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      relayAgentId: json['relayAgentId'] ?? '',
      rtspUrlEnc: json['rtspUrlEnc'] ?? '',
      sendFps: json['sendFps'] ?? '',
      sendWidth: json['sendWidth'] ?? '',
      sendHeight: json['sendHeight'] ?? '',
      jpegQuality: json['jpegQuality'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'rtspUrl': rtspUrl,
      'isActive': isActive,
      'camId': camId,
      'companyId': companyId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'relayAgentId': relayAgentId,
      'rtspUrlEnc': rtspUrlEnc,
      'sendFps': sendFps,
      'sendWidth': sendWidth,
      'sendHeight': sendHeight,
      'jpegQuality': jpegQuality,
    };
  }

  Camera copyWith({
    String? id,
    String? name,
    String? rtspUrl,
    bool? isActive,
    String? camId,
    String? companyId,
    String? createdAt,
    String? updatedAt,
    String? relayAgentId,
    String? rtspUrlEnc,
    String? sendFps,
    String? sendWidth,
    String? sendHeight,
    String? jpegQuality,
  }) {
    return Camera(
      id: id ?? this.id,
      name: name ?? this.name,
      rtspUrl: rtspUrl ?? this.rtspUrl,
      isActive: isActive ?? this.isActive,
      camId: camId ?? this.camId,
      companyId: companyId ?? this.companyId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      relayAgentId: relayAgentId ?? this.relayAgentId,
      rtspUrlEnc: rtspUrlEnc ?? this.rtspUrlEnc,
      sendFps: sendFps ?? this.sendFps,
      sendWidth: sendWidth ?? this.sendWidth,
      sendHeight: sendHeight ?? this.sendHeight,
      jpegQuality: jpegQuality ?? this.jpegQuality,
    );
  }
}
