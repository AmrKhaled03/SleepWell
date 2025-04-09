import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class DoctorChatController extends GetxController {
  List<Map<String, dynamic>> patients = [];
  List<Map<String, dynamic>> messages = [];

  int? currentDoctorId;
  int? currentPatientId;
  TextEditingController messageController = TextEditingController();
  WebSocketChannel? channel;


  Future<void> loadMessagesFromPrefs() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String key = 'messages_${currentPatientId}_$currentDoctorId';
      String? storedMessages = prefs.getString(key);
      if (storedMessages != null) {
        messages = List<Map<String, dynamic>>.from(jsonDecode(storedMessages));
        update();
      }
    } catch (e) {
      debugPrint('❌ Error loading messages: $e');
    }
  }


  Future<void> storeMessagesInPrefs() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String key = 'messages_${currentPatientId}_$currentDoctorId';
      String encodedMessages = jsonEncode(messages);
      await prefs.setString(key, encodedMessages);
    } catch (e) {
      debugPrint('❌ Error storing messages: $e');
    }
  }


  Future<void> getDoctorId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      currentDoctorId = prefs.getInt('user_id');
      if (currentDoctorId != null) {
        await getPatientsMessages(); 
      }
    } catch (e) {
      debugPrint('❌ خطأ أثناء جلب معرف الطبيب: $e');
    }
    update();
  }


  Future<void> getPatientsMessages() async {
    if (currentDoctorId == null) return;

    try {
      final response = await http.get(Uri.parse(
          'http://localhost/grad/get_doctor_messages.php?doctor_id=$currentDoctorId'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['success']) {
          patients = List<Map<String, dynamic>>.from(data['patients']);
        } else {
          debugPrint('⚠️ لا يوجد مرضى: ${data['message']}');
          patients = [];
        }
      } else {
        debugPrint('❌ فشل تحميل المرضى، كود الخطأ: ${response.statusCode}');
        patients = [];
      }
    } catch (e) {
      debugPrint('❌ خطأ أثناء جلب المرضى: $e');
      patients = [];
    }
    update();
  }


  Future<void> fetchMessages() async {
    if (currentDoctorId == null || currentPatientId == null) return;

    try {
      final response = await http.get(Uri.parse(
          'http://localhost/grad/fetch_messages.php?sender_id=$currentDoctorId&recipient_id=$currentPatientId'));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['success']) {
          List<Map<String, dynamic>> newMessages =
              List<Map<String, dynamic>>.from(data['messages']);
          messages.assignAll(
              newMessages); 
          update();
          await storeMessagesInPrefs(); 
        } else {
          debugPrint('⚠️ No messages: ${data['message']}');
          messages = [];
        }
      } else {
        debugPrint('❌ Failed to load messages, status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('❌ Error fetching messages: $e');
    }
    update();
  }


  void setCurrentPatientId(dynamic id) {
    currentPatientId = int.tryParse(id.toString());
    fetchMessages();
    update();
  }


  Future<void> sendMessage(String message) async {
    if (message.isEmpty || currentDoctorId == null || currentPatientId == null) {
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://localhost/grad/send_message.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'sender_id': currentDoctorId,
          'recipient_id': currentPatientId,
          'message': message,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['success']) {
          messages.add({
            'sender_id': currentDoctorId,
            'recipient_id': currentPatientId,
            'message': message,
            'timestamp': DateTime.now().toString(),
          });
          messageController.clear(); 
          await storeMessagesInPrefs(); 
          await fetchMessages(); 
          update();
        } else {
          debugPrint('⚠️ فشل إرسال الرسالة: ${data['message']}');
        }
      } else {
        debugPrint('❌ فشل إرسال الرسالة، كود الخطأ: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('❌ خطأ أثناء إرسال الرسالة: $e');
    }
  }


  void connectToWebSocket() {
    try {
      channel = WebSocketChannel.connect(Uri.parse('ws://localhost:8081'));

      channel!.stream.listen((message) {
        var data = jsonDecode(message);

        if (data['recipient_id'] == currentDoctorId ||
            data['sender_id'] == currentDoctorId) {
          messages.add(data);
          update();
          storeMessagesInPrefs();
        }
      }, onError: (error) {
        debugPrint('❌ خطأ في WebSocket: $error');
      });
    } catch (e) {
      debugPrint('❌ خطأ في WebSocket: $e');
    }
  }

  @override
  void onInit() async {
    super.onInit();
    getDoctorId(); 
    await loadMessagesFromPrefs(); 
    connectToWebSocket(); 
    await fetchMessages(); 
  }

  @override
  void onClose() {
    channel?.sink.close(); 
    super.onClose();
  }
}
