
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as webRTC;
import 'package:get/get.dart';
import 'package:ip_camera_live_streaming/app/core/config/api_constant.dart';

class WebRTCService extends GetxService {
  webRTC.RTCPeerConnection? _peerConnection;
  webRTC.MediaStream? _localStream;
  WebSocket? _socket;
  final RxBool isActive = false.obs;
  final RxString error = ''.obs;

  @override
  void onClose() {
    stopStream();
    super.onClose();
  }

  Future<void> startStream({
    required String cameraId,
    String? companyId,
    String streamType = 'attendance',
  }) async {
    try {
      error.value = '';
      if (isActive.value) await stopStream();

      // 1. Get User Media
      final Map<String, dynamic> mediaConstraints = {
        'audio': false,
        'video': {
          'mandatory': {
            'minWidth': '640',
            'minHeight': '480',
            'minFrameRate': '30',
          },
          'facingMode': 'user',
          'optional': [],
        }
      };

      _localStream = await webRTC.navigator.mediaDevices.getUserMedia(mediaConstraints);
      // Removed _localRenderer logic as we don't need to show self-view, only status/result

      // 2. Create Peer Connection
      final Map<String, dynamic> configuration = {
        "iceServers": [
          {"url": "stun:stun.l.google.com:19302"},
        ]
      };

      _peerConnection = await webRTC.createPeerConnection(configuration);

      // Add Tracks
      _localStream!.getTracks().forEach((track) {
        _peerConnection!.addTrack(track, _localStream!);
      });

      // 3. Connect WebSocket
      // Construct WebSocket URL from AI_HOST
      // http://10.81.100.128:8000 -> ws://10.81.100.128:8000/webrtc/signal
      final aiBase = ApiConstant.aiBaseUrl;
      final wsBase = aiBase.replaceFirst(RegExp(r'^http'), 'ws');
      final wsUrl = '$wsBase/webrtc/signal'; // Remove trailing slash if any handled by simple string concat assumption

      debugPrint('Connecting to WS: $wsUrl');
      _socket = await WebSocket.connect(wsUrl);

      _socket!.listen(
        (data) => _handleWebSocketMessage(data, cameraId),
        onError: (e) {
          debugPrint('WebSocket Error: $e');
          error.value = 'WebSocket error: $e';
          stopStream();
        },
        onDone: () {
          debugPrint('WebSocket Closed');
          if (isActive.value) {
             error.value = 'WebSocket connection closed';
             stopStream();
          }
        },
      );

      // 4. Handle ICE Candidates
      _peerConnection!.onIceCandidate = (candidate) {
        if (_socket != null && _socket!.readyState == WebSocket.open) {
          _sendJson({
            'ice': {
              'candidate': candidate.candidate,
              'sdpMid': candidate.sdpMid,
              'sdpMLineIndex': candidate.sdpMLineIndex,
            },
            'cameraId': cameraId,
            'companyId': companyId,
            'type': streamType,
          });
        }
      };

      // 5. Create Offer
      webRTC.RTCSessionDescription offer = await _peerConnection!.createOffer();
      await _peerConnection!.setLocalDescription(offer);

      _sendJson({
        'sdp': {
          'type': offer.type,
          'sdp': offer.sdp,
        },
        'cameraId': cameraId,
        'companyId': companyId,
        'type': streamType,
      });

      isActive.value = true;
    } catch (e) {
      debugPrint('Error starting stream: $e');
      error.value = 'Failed to start camera: $e';
      await stopStream();
    }
  }

  Future<void> stopStream() async {
    try {
      _localStream?.getTracks().forEach((track) => track.stop());
      await _localStream?.dispose();
      _localStream = null;

      await _peerConnection?.close();
      _peerConnection = null;

      await _socket?.close();
      _socket = null;

      isActive.value = false;
    } catch (e) {
      debugPrint('Error stopping stream: $e');
    }
  }

  void _handleWebSocketMessage(dynamic data, String cameraId) async {
    try {
      final Map<String, dynamic> msg = jsonDecode(data);

      if (msg.containsKey('sdp') && msg['cameraId'] == cameraId) {
        final sdp = msg['sdp'];
        await _peerConnection!.setRemoteDescription(
          webRTC.RTCSessionDescription(sdp['sdp'], sdp['type']),
        );
      } else if (msg.containsKey('ice') && msg['cameraId'] == cameraId) {
        final ice = msg['ice'];
        await _peerConnection!.addCandidate(
          webRTC.RTCIceCandidate(
            ice['candidate'],
            ice['sdpMid'],
            ice['sdpMLineIndex'],
          ),
        );
      }
    } catch (e) {
      debugPrint('Error handling WS message: $e');
    }
  }

  void _sendJson(Map<String, dynamic> data) {
    if (_socket != null && _socket!.readyState == WebSocket.open) {
      _socket!.add(jsonEncode(data));
    }
  }
}
