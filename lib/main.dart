import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const IslamicApp());
}

class IslamicApp extends StatelessWidget {
  const IslamicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Islamic Super App",
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B1220),
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.95, end: 1.05).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🕌 Islamic Super App"),
        centerTitle: true,
        backgroundColor: const Color(0xFF0B1220),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(15),
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        children: [
          menu("Namaz", Icons.access_time, const PrayerPage(), _animation),
          menu("Quran", Icons.menu_book, const QuranPage(), _animation),
          menu("Hadith", Icons.auto_stories, const HadithPage(), _animation),
          menu("Books", Icons.book, const BookPage(), _animation),
          menu("Video", Icons.play_circle, const VideoPage(), _animation),
          menu("Search", Icons.search, const SearchPage(), _animation),
          menu("Tasbih", Icons.fingerprint, const TasbihPage(), _animation),
          menu("Ramadan", Icons.nightlight_round, const RamadanPage(), _animation),
        ],
      ),
    );
  }

  Widget menu(String title, IconData icon, Widget page, Animation<double> anim) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
      child: AnimatedBuilder(
        animation: anim,
        builder: (context, child) {
          return Transform.scale(
            scale: anim.value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.greenAccent.withOpacity(0.2),
                    blurRadius: 15,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 40, color: Colors.greenAccent),
                  const SizedBox(height: 10),
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

//////////////////////////////////////////////////////////////
// 🕌 PRAYER PAGE (AZAN TIMER)
//////////////////////////////////////////////////////////////

class PrayerPage extends StatefulWidget {
  const PrayerPage({super.key});

  @override
  State<PrayerPage> createState() => _PrayerPageState();
}

class _PrayerPageState extends State<PrayerPage> {
  int seconds = 10;
  String status = "Next Prayer: Fajr";

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      setState(() {
        if (seconds == 0) {
          status = "🕌 AZAN TIME!";
          seconds = 60;
        } else {
          seconds--;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Namaz Time")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(status,
                style: const TextStyle(
                    fontSize: 22, color: Colors.greenAccent)),
            const SizedBox(height: 20),
            Text("$seconds sec",
                style: const TextStyle(fontSize: 40)),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////
// 📖 QURAN
//////////////////////////////////////////////////////////////

class QuranPage extends StatelessWidget {
  const QuranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quran")),
      body: ListView(
        children: const [
          ListTile(title: Text("Surah Fatiha")),
          ListTile(title: Text("Surah Ikhlas")),
          ListTile(title: Text("Surah Yasin")),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////////////
// 📚 HADITH
//////////////////////////////////////////////////////////////

class HadithPage extends StatelessWidget {
  const HadithPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hadith")),
      body: const Center(child: Text("Bukhari / Muslim Section")),
    );
  }
}

//////////////////////////////////////////////////////////////
// 📘 BOOKS
//////////////////////////////////////////////////////////////

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Books")),
      body: const ListView(
        children: [
          ListTile(title: Text("Bukhari Bangla")),
          ListTile(title: Text("Fiqh Notes")),
          ListTile(title: Text("Aqeedah Class")),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////////////
// 🎥 VIDEO
//////////////////////////////////////////////////////////////

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Video System Coming")),
    );
  }
}

//////////////////////////////////////////////////////////////
// 🔎 SEARCH
//////////////////////////////////////////////////////////////

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  String result = "";

  List<String> data = [
    "Fajr Namaz",
    "Quran Surah Yasin",
    "Bukhari Hadith",
    "Moulana Class"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search")),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: controller,
              onChanged: (value) {
                setState(() {
                  result = data
                      .where((e) =>
                          e.toLowerCase().contains(value.toLowerCase()))
                      .join("\n");
                });
              },
              decoration: const InputDecoration(
                hintText: "Search...",
                filled: true,
                fillColor: Colors.white10,
              ),
            ),
            const SizedBox(height: 20),
            Text(result),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////
// 📿 TASBIH
//////////////////////////////////////////////////////////////

class TasbihPage extends StatefulWidget {
  const TasbihPage({super.key});

  @override
  State<TasbihPage> createState() => _TasbihPageState();
}

class _TasbihPageState extends State<TasbihPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tasbih")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$count", style: const TextStyle(fontSize: 50)),
            ElevatedButton(
              onPressed: () => setState(() => count++),
              child: const Text("Tap"),
            ),
            ElevatedButton(
              onPressed: () => setState(() => count = 0),
              child: const Text("Reset"),
            ),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////
// 🌙 RAMADAN
//////////////////////////////////////////////////////////////

class RamadanPage extends StatelessWidget {
  const RamadanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Sehri / Iftar Tracker Coming"),
      ),
    );
  }
}
