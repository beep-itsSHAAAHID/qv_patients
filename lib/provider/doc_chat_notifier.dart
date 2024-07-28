import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

final chatProvider = Provider((ref) => ChatController(ref));

class ChatController {
  final ProviderRef ref;

  ChatController(this.ref);

  final ImagePicker _picker = ImagePicker();
  final key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1');
  final iv = encrypt.IV.fromUtf8('myFixedIV1234567'); // 16 bytes
  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;
  bool _isRecording = false;

  FlutterSoundPlayer? get player => _player;
  bool get isRecording => _isRecording;

  Future<void> initializeRecorder() async {
    try {
      _recorder = FlutterSoundRecorder();
      await _recorder!.openRecorder();
      final status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw Exception('Microphone permission not granted');
      }
    } catch (e) {
      throw Exception('Failed to initialize recorder: $e');
    }
  }

  Future<void> initializePlayer() async {
    try {
      _player = FlutterSoundPlayer();
      await _player!.openPlayer();
    } catch (e) {
      throw Exception('Failed to initialize player: $e');
    }
  }

  void dispose() {
    _recorder?.closeRecorder();
    _player?.closePlayer();
  }

  String encryptMessage(String message) {
    try {
      final encrypter = encrypt.Encrypter(
          encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));
      final encrypted = encrypter.encrypt(message, iv: iv);
      return encrypted.base64;
    } catch (e) {
      throw Exception('Failed to encrypt message: $e');
    }
  }

  String decryptMessage(String encryptedMessage) {
    try {
      final encrypter = encrypt.Encrypter(
          encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));
      final encrypted = encrypt.Encrypted.fromBase64(encryptedMessage);
      return encrypter.decrypt(encrypted, iv: iv);
    } catch (e) {
      throw Exception('Failed to decrypt message: $e');
    }
  }

  Future<void> sendMessage(String text,
      [File? mediaFile, String? mediaType]) async {
    String? mediaUrl;
    if (mediaFile != null) {
      try {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('chat_media')
            .child(DateTime.now().toIso8601String() +
                (mediaType == 'image'
                    ? '.jpg'
                    : mediaType == 'video'
                        ? '.mp4'
                        : '.aac'));
        await storageRef.putFile(mediaFile);
        mediaUrl = await storageRef.getDownloadURL();
      } catch (e) {
        throw Exception('Failed to upload media: $e');
      }
    }

    final encryptedText = text.isNotEmpty ? encryptMessage(text) : '';

    try {
      await FirebaseFirestore.instance.collection('chat').add({
        'text': encryptedText,
        'mediaUrl': mediaUrl,
        'mediaType': mediaType,
        'timestamp': FieldValue.serverTimestamp(),
        'sender':
            'Patient', // Change this based on the user role (Patient/Doctor)
      });
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  Future<void> pickMedia(String mediaType) async {
    final pickedFile = await _picker.pickImage(
      source: mediaType == 'image' ? ImageSource.gallery : ImageSource.gallery,
    ); // change for videos
    if (pickedFile != null) {
      final mediaFile = File(pickedFile.path);
      await sendMessage('', mediaFile, mediaType);
    }
  }

  Future<void> startRecording() async {
    if (_recorder != null && !_isRecording) {
      try {
        await _recorder!.startRecorder(
          toFile: 'voice_message.aac',
          codec: Codec.aacMP4,
        );
        _isRecording = true;
      } catch (e) {
        throw Exception('Failed to start recorder: $e');
      }
    } else {
      throw Exception('Recorder is not available or already started');
    }
  }

  Future<void> stopRecording() async {
    if (_recorder != null && _isRecording) {
      try {
        final path = await _recorder!.stopRecorder();
        _isRecording = false;
        if (path != null) {
          final voiceFile = File(path);
          await sendMessage('', voiceFile, 'voice');
        }
      } catch (e) {
        throw Exception('Failed to stop recorder: $e');
      }
    } else {
      throw Exception('Recorder is not recording');
    }
  }

  void deleteMessage(String docId) {
    FirebaseFirestore.instance.collection('chat').doc(docId).delete();
  }

  void clearChat() {
    FirebaseFirestore.instance.collection('chat').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }
}
