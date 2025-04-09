import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatController extends GetxController {
  List<Map<String, dynamic>> messages = [];
  List<Map<String, dynamic>> doctors = [];
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


  Future<void> fetchMessages() async {
    if (currentDoctorId == null || currentPatientId == null) return;

    try {
      final response = await http.get(Uri.parse(
          'http://localhost/grad/fetch_messages.php?sender_id=$currentPatientId&recipient_id=$currentDoctorId'));

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
        debugPrint(
            '❌ Failed to load messages, status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('❌ Error fetching messages: $e');
    }
    update();
  }


  void getDoctors() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost/grad/get_doctors.php'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['success']) {
          doctors = List<Map<String, dynamic>>.from(data['doctors']);
          update();
        } else {
          debugPrint('Failed to load doctors: ${data['message']}');
        }
      } else {
        debugPrint(
            'Failed to load doctors. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching doctors: $e');
    }
  }


  Future<void> getPatientId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      currentPatientId = prefs.getInt('user_id') ?? 0;
      update();
    } catch (e) {
      debugPrint('Error getting patient ID: $e');
    }
  }


  void sendMessage(String message) async {
    if (message.isEmpty) return;

    try {
      final url = Uri.parse('http://localhost/grad/send_message.php');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'sender_id': currentPatientId,
          'recipient_id': currentDoctorId,
          'message': message,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['success']) {
          messages.add({
            'sender_id': currentPatientId,
            'recipient_id': currentDoctorId,
            'message': message,
          });
          messageController.clear(); 
          await storeMessagesInPrefs(); 
          await fetchMessages(); 
          update();
        } else {
          debugPrint('Failed to send message: ${data['message']}');
        }
      } else {
        debugPrint(
            'Failed to send message. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('❌ Error sending message: $e');
    }
  }


  void connectToWebSocket() {
    channel = WebSocketChannel.connect(Uri.parse('ws://localhost:8081'));

    channel!.stream.listen((message) {
      var data = jsonDecode(message);
      if (data['recipient_id'] == currentPatientId ||
          data['sender_id'] == currentPatientId) {

        messages.add(data);
        update(); 
        storeMessagesInPrefs(); 
      }
    }, onError: (error) {
      debugPrint('WebSocket error: $error');
    });
  }


  void setCurrentDoctorId(dynamic doctorId) {
    currentDoctorId = int.tryParse(
        doctorId.toString());
    fetchMessages(); 
    update();
  }


Future<bool> checkPaymentStatus() async {
  if (currentPatientId == null || currentDoctorId == null) {
    debugPrint('❌ خطأ: معرف المريض أو الطبيب غير متوفر.');
    return false;
  }

  try {
    final response = await http.get(Uri.parse(
        'http://localhost/grad/check_payment.php?patient_id=$currentPatientId&doctor_id=$currentDoctorId'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      bool isPaid = data['success'] == true; 
      debugPrint('💰 حالة الدفع: ${isPaid ? "تم الدفع" : "لم يتم الدفع"}');
      return isPaid;
    } else {
      debugPrint('❌ فشل التحقق من الدفع: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    debugPrint('❌ خطأ أثناء التحقق من الدفع: $e');
    return false;
  }
}

  @override
  void onInit() async {
    super.onInit();
    await loadMessagesFromPrefs();
    getDoctors();
    getPatientId();
    connectToWebSocket(); 
    await fetchMessages();
  }

  @override
  void onClose() {
    channel?.sink.close(); 
    super.onClose();
  }
}
