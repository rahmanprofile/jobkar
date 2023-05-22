import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobkar/controller/constant.dart';
import 'package:jobkar/view/components/round_button.dart';
import 'package:jobkar/controller/mysnackbar.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {

  final titController = TextEditingController();
  final descController = TextEditingController();

  feedback() {
    setState(() {
      titController.clear();
      descController.clear();
      MySnackBar(context, "Your feedback submitted successfully");
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Feedback"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title", style: styleGrey18),
            const SizedBox(height: 8),
            Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: whiteColor,
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "What your feedback?",
                  prefixIcon: Icon(CupertinoIcons.text_cursor, size: 18),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text("Description", style: styleGrey18),
            const SizedBox(height: 8),
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: whiteColor,
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "Describe your issue with us.",
                  prefixIcon: Icon(CupertinoIcons.text_cursor, size: 18),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            RoundButton(
                text: "Submit",
                onTap: feedback,
                textColor: Colors.white,
                color: blueColor!,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    descController.clear();
    titController.clear();
    super.dispose();
  }
}
