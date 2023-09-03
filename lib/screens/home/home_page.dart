// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

// TODO: ใส่รหัสนักศึกษาที่ค่าสตริงนี้
const studentId = '640710760';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme
        .of(context)
        .textTheme;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg_colorful.jpg"),
              opacity: 0.6,
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Good Morning',
                  textAlign: TextAlign.center, style: textTheme.headlineMedium),
              Text(studentId,
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black87)),
              Spacer(),
              _buildQuizView(),
              Spacer(),
              _buildButtonPanel(),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
  String correctAnswer = 'A. Bangkok'; // ระบุคำตอบที่ถูกต้อง

  String selectedAnswer = ''; // ใช้เก็บคำตอบที่ผู้ใช้เลือก


  Widget _buildQuizView() {
    return Container(
      width: double.infinity,
      height: 500.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildQuestion(
              'Question 1 of 30', 'What is the capital of Thailand?'),
          SizedBox(height: 20.0),
          _buildOption('A. Bangkok', isCorrect: true), // ตัวเลือก A ถูก
          _buildOption('B. Hanoi', isCorrect: false), // ตัวเลือก B ผิด
          _buildOption('C. Jakarta', isCorrect: false), // ตัวเลือก C ผิด
          _buildOption('D. Manila', isCorrect: false), // ตัวเลือก D ผิด
        ],

      ),

    );

  }


  Widget _buildQuestion(String questionNumber, String questionText) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              questionNumber,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 20.0),
        Container(
          width: 300.0,
          height: 50.0,
          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                questionText,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }

  Widget _buildOption(String text, {bool isCorrect = false}) {
    Color borderColor = isCorrect ? Colors.green : Colors.red; // สีขอบของตัวเลือกถูกหรือผิด
    Color backgroundColor = isCorrect ? Colors.lightGreen : Colors.pink; // สีพื้นหลังของตัวเลือกถูกหรือผิด

    bool isSelected = text == selectedAnswer; // ตรวจสอบว่าตัวเลือกถูกเลือกหรือไม่

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAnswer = text;
        });
      },
      child: Container(
        width: double.infinity,
        height: 50.0,
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : borderColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
          color: isSelected ? Colors.lightBlue : backgroundColor,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,

            ),
          ),
        ),
      ),
    );
  }



  Widget _buildButtonPanel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // รหัสที่ต้องการให้ปุ่ม "Back" ทำงาน
            },
            child: Text('Back'),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SecondPage(),
                ),
              );
            },
            child: Text('Next'),
          )
        ),
        ElevatedButton(
          onPressed: () {
            if (selectedAnswer == correctAnswer) {
              // แจ้งผู้ใช้ว่าคำตอบถูกต้อง
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Correct Answer'),
                    content: Text('Congratulations! Your answer is correct.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // ปิด AlertDialog
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            } else {
              // แจ้งผู้ใช้ว่าคำตอบผิด
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Wrong Answer'),
                    content: Text('Sorry, your answer is incorrect.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // ปิด AlertDialog
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Text('Check Answer'),
        )
      ],
    );

  }
}




class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme
        .of(context)
        .textTheme;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg_colorful.jpg"),
              opacity: 0.6,
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Good Morning',
                  textAlign: TextAlign.center, style: textTheme.headlineMedium),
              Text(studentId,
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black87)),
              Spacer(),
              _buildQuizView(),
              Spacer(),
              _buildButtonPanel(),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
  String correctAnswer = 'A. Vientiane'; // ระบุคำตอบที่ถูกต้อง

  String selectedAnswer = ''; // ใช้เก็บคำตอบที่ผู้ใช้เลือก


  Widget _buildQuizView() {
    return Container(
      width: double.infinity,
      height: 500.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildQuestion(
              'Question 2 of 30', 'What is the capital of Laos?'),
          SizedBox(height: 20.0),
          _buildOption('A. Vientiane', isCorrect: true), // ตัวเลือก A ถูก
          _buildOption('B. Bangkok', isCorrect: false), // ตัวเลือก B ผิด
          _buildOption('C. Hanoi', isCorrect: false), // ตัวเลือก C ผิด
          _buildOption('D. Jakarta', isCorrect: false), // ตัวเลือก D ผิด
        ],

      ),

    );

  }


  Widget _buildQuestion(String questionNumber, String questionText) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              questionNumber,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 20.0),
        Container(
          width: 300.0,
          height: 50.0,
          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                questionText,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }

  Widget _buildOption(String text, {bool isCorrect = false}) {
    Color borderColor = isCorrect ? Colors.green : Colors.red; // สีขอบของตัวเลือกถูกหรือผิด
    Color backgroundColor = isCorrect ? Colors.lightGreen : Colors.pink; // สีพื้นหลังของตัวเลือกถูกหรือผิด

    bool isSelected = text == selectedAnswer; // ตรวจสอบว่าตัวเลือกถูกเลือกหรือไม่

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAnswer = text;
        });
      },
      child: Container(
        width: double.infinity,
        height: 50.0,
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : borderColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
          color: isSelected ? Colors.lightBlue : backgroundColor,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,

            ),
          ),
        ),
      ),
    );
  }



  Widget _buildButtonPanel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // ย้อนกลับไปหน้าหน้าแรก (หน้า 1)
            },
            child: Text('Back'),
          )
        ),
        Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ThreePage(),
                  ),
                );
              },
              child: Text('Next'),
            )
        ),
        ElevatedButton(
          onPressed: () {
            if (selectedAnswer == correctAnswer) {
              // แจ้งผู้ใช้ว่าคำตอบถูกต้อง
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Correct Answer'),
                    content: Text('Congratulations! Your answer is correct.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // ปิด AlertDialog
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            } else {
              // แจ้งผู้ใช้ว่าคำตอบผิด
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Wrong Answer'),
                    content: Text('Sorry, your answer is incorrect.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // ปิด AlertDialog
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Text('Check Answer'),
        )
      ],
    );

  }
}
class ThreePage extends StatefulWidget {
  @override
  _ThreePageState createState() => _ThreePageState();
}

class _ThreePageState extends State<ThreePage> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg_colorful.jpg"),
              opacity: 0.6,
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Good Morning',
                  textAlign: TextAlign.center, style: textTheme.headlineMedium),
              Text(studentId,
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.black87)),
              Spacer(),
              _buildQuizView(),
              Spacer(),
              _buildButtonPanel(),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
  String correctAnswer = 'B. Kuala Lumpur'; // ระบุคำตอบที่ถูกต้อง

  String selectedAnswer = ''; // ใช้เก็บคำตอบที่ผู้ใช้เลือก

  Widget _buildQuizView() {
    return Container(
      width: double.infinity,
      height: 500.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildQuestion(
              'Question 3 of 30', 'What is the capital of Malaysia?'),
          SizedBox(height: 20.0),
          _buildOption('A. Bangkok', isCorrect: false), // ตัวเลือก A   ผิด
          _buildOption('B. Kuala Lumpur', isCorrect: true), // ตัวเลือก B ถูก
          _buildOption('C. Jakarta', isCorrect: false), // ตัวเลือก C ผิด
          _buildOption('D. Hanoi', isCorrect: false), // ตัวเลือก D ผิด
        ],
      ),
    );
  }

  Widget _buildQuestion(String questionNumber, String questionText) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              questionNumber,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 20.0),
        Container(
          width: 300.0,
          height: 50.0,
          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                questionText,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20.0),
      ],
    );
  }

  Widget _buildOption(String text, {bool isCorrect = false}) {
    Color borderColor = isCorrect ? Colors.green : Colors.red; // สีขอบของตัวเลือกถูกหรือผิด
    Color backgroundColor = isCorrect ? Colors.lightGreen : Colors.pink; // สีพื้นหลังของตัวเลือกถูกหรือผิด

    bool isSelected = text == selectedAnswer; // ตรวจสอบว่าตัวเลือกถูกเลือกหรือไม่

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAnswer = text;
        });
      },
      child: Container(
        width: double.infinity,
        height: 50.0,
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : borderColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
          color: isSelected ? Colors.lightBlue : backgroundColor,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonPanel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // ย้อนกลับไปหน้าสอง
            },
            child: Text('Back'),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // รหัสที่ต้องการให้ปุ่ม "Next" ทำงาน
            },
            child: Text('Next'),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (selectedAnswer == correctAnswer) {
              // แจ้งผู้ใช้ว่าคำตอบถูกต้อง
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Correct Answer'),
                    content: Text('Congratulations! Your answer is correct.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // ปิด AlertDialog
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            } else {
              // แจ้งผู้ใช้ว่าคำตอบผิด
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Wrong Answer'),
                    content: Text('Sorry, your answer is incorrect.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // ปิด AlertDialog
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Text('Check Answer'),
        )
      ],
    );
  }
}
