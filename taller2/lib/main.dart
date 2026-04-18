import 'package:flutter/material.dart';

void main() {
  runApp(const GameApp());
}

class GameApp extends StatelessWidget {
  const GameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: Colors.amber,
          secondary: Colors.cyanAccent,
        ),
      ),
      home: const GameHome(),
    );
  }
}

class GameHome extends StatefulWidget {
  const GameHome({super.key});

  @override
  State<GameHome> createState() => _GameHomeState();
}

class _GameHomeState extends State<GameHome> {
  final PageController _controller = PageController();

  int level = 1;
  int xp = 0;

  final missions = [
    {"title": "Tutorial", "xp": 20, "desc": "Aprende lo básico"},
    {"title": "Exploración", "xp": 30, "desc": "Navega la app"},
    {"title": "Práctica", "xp": 40, "desc": "Completa ejercicios"},
    {"title": "Boss Final", "xp": 50, "desc": "Desbloquea el final"},
  ];

  void addXP(int value) {
    setState(() {
      xp += value;

      if (xp >= 100) {
        level++;
        xp = xp - 100;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("🔥 Subiste a nivel $level"),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }

  void next() {
    if (_controller.page!.toInt() < missions.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );

      addXP(missions[_controller.page!.toInt()]["xp"] as int);
    }
  }

  void back() {
    if (_controller.page!.toInt() > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double xpBar = xp / 100;

    return Scaffold(
      appBar: AppBar(title: const Text("🎮 Learning RPG"), centerTitle: true),

      body: Column(
        children: [
          // 🧠 HUD (Nivel + XP)
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "Nivel $level",
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                LinearProgressIndicator(
                  value: xpBar,
                  minHeight: 12,
                  backgroundColor: Colors.grey[800],
                  color: Colors.amber,
                ),

                const SizedBox(height: 5),

                Text("XP: $xp / 100"),
              ],
            ),
          ),

          // 🎮 MISIONES (PageView)
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: missions.length,
              itemBuilder: (context, index) {
                final mission = missions[index];

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.blueGrey.shade900],
                    ),
                    border: Border.all(color: Colors.amber, width: 2),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.sports_esports,
                          size: 80,
                          color: Colors.amber,
                        ),

                        const SizedBox(height: 20),

                        Text(
                          mission["title"].toString(),
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          mission["desc"].toString(),
                          style: const TextStyle(fontSize: 16),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          "+${mission["xp"]} XP",
                          style: const TextStyle(
                            color: Colors.cyanAccent,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // 🎮 CONTROLES
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: back,
                    child: const Text("⬅ Atrás"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: next,
                    child: const Text("Siguiente ➡"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
