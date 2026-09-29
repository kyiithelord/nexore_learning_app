import 'package:flutter/material.dart';

void main() => runApp(const App());
const teal = Color(0xff0b8f82),
    ink = Color(0xff152b30),
    muted = Color(0xff748589),
    canvas = Color(0xfff4f7f5);

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext c) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: teal),
      scaffoldBackgroundColor: canvas,
    ),
    home: const Admin(),
  );
}

class Admin extends StatefulWidget {
  const Admin({super.key});
  @override
  State<Admin> createState() => _Admin();
}

class _Admin extends State<Admin> {
  int page = 0;
  @override
  Widget build(BuildContext c) => Scaffold(
    body: Row(
      children: [
        Container(
          width: 230,
          color: ink,
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'nexora.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              ...List.generate(
                5,
                (i) => Material(
                  type: MaterialType.transparency,
                  child: ListTile(
                    selected: i == page,
                    selectedTileColor: teal,
                    selectedColor: Colors.white,
                    textColor: Colors.white70,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    leading: Icon(
                      [
                        Icons.dashboard_outlined,
                        Icons.menu_book_outlined,
                        Icons.quiz_outlined,
                        Icons.people_outline,
                        Icons.campaign_outlined,
                      ][i],
                    ),
                    title: Text(
                      [
                        'Overview',
                        'Courses',
                        'Lessons',
                        'Learners',
                        'Reminders',
                      ][i],
                    ),
                    onTap: () => setState(() => page = i),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                height: 70,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                color: Colors.white,
                child: Row(
                  children: [
                    Text(
                      [
                        'Overview',
                        'Courses',
                        'Lessons',
                        'Learners',
                        'Reminders',
                      ][page],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.notifications_none),
                    const SizedBox(width: 14),
                    const CircleAvatar(child: Icon(Icons.person_outline)),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: page == 0 ? const Overview() : Section(index: page),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class Overview extends StatelessWidget {
  const Overview({super.key});
  @override
  Widget build(BuildContext c) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Good morning, May',
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: ink),
      ),
      const Text(
        'Here is how Nexora is growing this week.',
        style: TextStyle(color: muted),
      ),
      const SizedBox(height: 24),
      GridView.count(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        shrinkWrap: true,
        childAspectRatio: 1.45,
        children: const [
          Metric(Icons.people_outline, '1,284', 'Active learners'),
          Metric(Icons.task_alt, '8,492', 'Lessons finished'),
          Metric(Icons.local_fire_department, '6.4', 'Average streak'),
          Metric(Icons.workspace_premium, '82%', 'Completion rate'),
        ],
      ),
      const SizedBox(height: 24),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: box(),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Course performance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 18),
            Course('English basics', .82, '1,042 learners'),
            Course('Business English', .61, '188 learners'),
            Course('Travel essentials', .48, '54 learners'),
          ],
        ),
      ),
    ],
  );
}

class Section extends StatelessWidget {
  const Section({required this.index, super.key});
  final int index;
  @override
  Widget build(BuildContext c) {
    final names = ['', 'Courses', 'Lessons', 'Learners', 'Practice reminders'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              names[index],
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Create new'),
            ),
          ],
        ),
        const SizedBox(height: 100),
        const Center(
          child: Column(
            children: [
              Icon(Icons.edit_note, size: 70, color: teal),
              Text(
                'Content workspace',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
              ),
              Text(
                'Connected to the Nexora API.',
                style: TextStyle(color: muted),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Metric extends StatelessWidget {
  const Metric(this.icon, this.value, this.label, {super.key});
  final IconData icon;
  final String value, label;
  @override
  Widget build(BuildContext c) => Container(
    padding: const EdgeInsets.all(18),
    decoration: box(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: teal),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w900),
        ),
        Text(label, style: const TextStyle(color: muted, fontSize: 12)),
      ],
    ),
  );
}

class Course extends StatelessWidget {
  const Course(this.name, this.value, this.learners, {super.key});
  final String name, learners;
  final double value;
  @override
  Widget build(BuildContext c) => Padding(
    padding: const EdgeInsets.only(bottom: 18),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            Text(learners, style: const TextStyle(color: muted)),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: value,
          minHeight: 8,
          color: teal,
          backgroundColor: const Color(0xffe5ece9),
        ),
      ],
    ),
  );
}

BoxDecoration box() => BoxDecoration(
  color: Colors.white,
  border: Border.all(color: const Color(0xffe2eae6)),
  borderRadius: BorderRadius.circular(8),
);
