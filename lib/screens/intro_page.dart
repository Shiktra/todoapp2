import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Icon(Icons. task_alt_rounded, size: 120, color: Color(0xFF6CBE7C)),
            const SizedBox(height: 20),
            const Text(
              "Daily Planner",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
            ),
            const Text("Organize your life with ease.", style: TextStyle(color: Colors.grey)),
            const Spacer(),
            GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(context, 'tasks'),
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D3142),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text("Get Started", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}