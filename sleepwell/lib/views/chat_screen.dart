import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sleepwell/constants/app_colors.dart';
import 'package:sleepwell/controllers/chat_controller.dart';

class ChatScreen extends GetWidget<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
      final doctor = Get.arguments; 
  return SafeArea(
    child: Scaffold(
        backgroundColor: AppColors.mainColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.mainColor,
          title: Text('Chat with DR / ${doctor['username']}',
            
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
    
        body: 
        Padding(padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(child: 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Container(
                      height: 30,
                      width: 30,
                      alignment: Alignment.center,
                      decoration:
                          const BoxDecoration(color: AppColors.arrowColor),
                      child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20,
                          )),
                    ),
            const SizedBox(height: 20,),
            // Display messages
           GetBuilder<ChatController>(
             builder: (controller) {
               return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                 itemCount: controller.messages.length,
                 itemBuilder: (context, index) {
                   var message = controller.messages[index];
           
                 bool isSent = message['sender_id'] == controller.currentPatientId;
           // bool isReceived = message['sender_id'] == controller.currentDoctorId;
           
                   return Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Align(
                       alignment: isSent
                           ? Alignment.centerLeft
                           : Alignment.centerRight,  
                       child: Container(
                         padding: const EdgeInsets.all(10),
                         decoration: BoxDecoration(
                           color: isSent ? Colors.blueAccent : Colors.grey,
                           borderRadius: BorderRadius.circular(8),
                         ),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                               message['message'],
                               style: const TextStyle(color: Colors.white),
                             ),
                             const SizedBox(height: 5),
                             Text(
                               isSent ? 'You' : 'Doctor',  
                               style: const TextStyle(color: Colors.white70, fontSize: 12),
                             ),
                           ],
                         ),
                       ),
                     ),
                   );
                 },
               );
             },
           ),

            const SizedBox(height: 150,),
            Row(
              children: [
                Expanded(
                  flex: 80,
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: controller.messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  flex: 20,
                  child: TextButton(style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.blue)),onPressed: (){
                        controller.sendMessage(controller.messageController.text);
                  }, child: const Text("Send",style: TextStyle(color: Colors.white),)),
                ),
                
              ],
            ),
          ],
        ),
        ),)
      
      ),
  );
  }
}
