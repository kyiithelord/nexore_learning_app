import 'package:flutter/material.dart';

void main() => runApp(const Nexora());
const teal = Color(0xff0b8f82),
    mint = Color(0xffe8f7f0),
    cream = Color(0xfff7f7f1),
    ink = Color(0xff152b30),
    muted = Color(0xff748589),
    coral = Color(0xffff8b67);

class Nexora extends StatelessWidget {
  const Nexora({super.key});
  @override
  Widget build(BuildContext c) => MaterialApp(
    title: 'Nexora',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: cream,
      colorScheme: ColorScheme.fromSeed(seedColor: teal),
    ),
    home: const Shell(),
  );
}

class Shell extends StatefulWidget {
  const Shell({super.key});
  @override
  State<Shell> createState() => _Shell();
}

class _Shell extends State<Shell> {
  int tab = 0;
  bool lesson = false, done = false;
  void start() => setState(() => lesson = true);
  @override
  Widget build(BuildContext c) {
    if (done) {
      return Result(
        back: () => setState(() {
          done = false;
          lesson = false;
          tab = 1;
        }),
      );
    }
    if (lesson) {
      return Lesson(
        close: () => setState(() => lesson = false),
        finish: () => setState(() => done = true),
      );
    }
    final p = [
      Home(start: start, profile: () => setState(() => tab = 3)),
      Learn(start: start),
      const League(),
      const Profile(),
    ];
    return Scaffold(
      body: SafeArea(child: p[tab]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        indicatorColor: mint,
        onDestinationSelected: (v) => setState(() => tab = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.map_outlined), label: 'Learn'),
          NavigationDestination(
            icon: Icon(Icons.emoji_events_outlined),
            label: 'League',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class Page extends StatelessWidget {
  const Page(this.child, {super.key});
  final Widget child;
  @override
  Widget build(BuildContext c) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 620),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: child,
      ),
    ),
  );
}

BoxDecoration box([Color color = Colors.white]) => BoxDecoration(
  color: color,
  border: Border.all(color: const Color(0xffe5ece9)),
  borderRadius: BorderRadius.circular(18),
);

class Home extends StatelessWidget {
  const Home({required this.start, required this.profile, super.key});
  final VoidCallback start, profile;
  @override
  Widget build(BuildContext c) => Page(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'nexora',
              style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.w900,
                color: teal,
              ),
            ),
            const Text(
              '.',
              style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.w900,
                color: coral,
              ),
            ),
            const Spacer(),
            IconButton.filledTonal(
              onPressed: profile,
              icon: const Icon(Icons.waving_hand),
            ),
          ],
        ),
        const SizedBox(height: 22),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: teal,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'YOUR DAILY PRACTICE',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Ready for a little\nprogress?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  height: 1.1,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 22),
              FilledButton.tonalIcon(
                onPressed: start,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Continue lesson'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        const Row(
          children: [
            Expanded(
              child: Stat(Icons.local_fire_department, '7', 'Day streak'),
            ),
            SizedBox(width: 8),
            Expanded(child: Stat(Icons.bolt, '420', 'Total XP')),
            SizedBox(width: 8),
            Expanded(child: Stat(Icons.workspace_premium, '12', 'Lessons')),
          ],
        ),
        const SizedBox(height: 28),
        const Head('Keep learning', 'Unit 1 of 4'),
        const SizedBox(height: 12),
        Tile(
          Icons.waving_hand,
          'Everyday greetings',
          '3 of 5 lessons completed',
          onTap: start,
        ),
        const SizedBox(height: 10),
        const Tile(
          Icons.local_cafe_outlined,
          'Food & drinks',
          'Next up after greetings',
        ),
      ],
    ),
  );
}

class Learn extends StatelessWidget {
  const Learn({required this.start, super.key});
  final VoidCallback start;
  @override
  Widget build(BuildContext c) => Page(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Text(
              'Your path',
              style: TextStyle(fontSize: 29, fontWeight: FontWeight.w900),
            ),
            Spacer(),
            Icon(Icons.local_fire_department, color: coral),
            Text(
              ' 7',
              style: TextStyle(color: teal, fontWeight: FontWeight.w800),
            ),
          ],
        ),
        const Text(
          'English basics · Learn one small thing every day.',
          style: TextStyle(color: muted),
        ),
        const SizedBox(height: 28),
        const Text(
          'Unit 1 · Everyday greetings',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        Tile(Icons.check, 'Say hello', 'Vocabulary · 3 min', onTap: start),
        const SizedBox(height: 10),
        Tile(
          Icons.play_arrow,
          'Meet a new friend',
          'Translation · 4 min',
          onTap: start,
        ),
        const SizedBox(height: 10),
        const Opacity(
          opacity: .5,
          child: Tile(
            Icons.lock_outline,
            'Ask how someone is',
            'Unlock after lesson 2',
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Unit 2 · Food & drinks',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        const Opacity(
          opacity: .5,
          child: Tile(
            Icons.lock_outline,
            'At the tea shop',
            'Unlock after Unit 1',
          ),
        ),
      ],
    ),
  );
}

class League extends StatelessWidget {
  const League({super.key});
  @override
  Widget build(BuildContext c) => Page(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Weekly league',
          style: TextStyle(fontSize: 29, fontWeight: FontWeight.w900),
        ),
        const Text(
          'Practice a little each day to climb the board.',
          style: TextStyle(color: muted),
        ),
        const SizedBox(height: 28),
        const Head('Your week', '7-day streak'),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            7,
            (i) => Column(
              children: [
                CircleAvatar(
                  radius: 17,
                  backgroundColor: i < 6 ? teal : Colors.white,
                  child: Icon(
                    i < 6 ? Icons.check : Icons.more_horiz,
                    size: 17,
                    color: i < 6 ? Colors.white : muted,
                  ),
                ),
                Text(
                  ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][i],
                  style: const TextStyle(color: muted, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 28),
        const Head('Top learners', 'This week'),
        const SizedBox(height: 12),
        const Rank('01', 'Thiri', '690 XP'),
        const Rank('02', 'Su', '570 XP'),
        const Rank('03', 'You', '420 XP', active: true),
      ],
    ),
  );
}

class Profile extends StatelessWidget {
  const Profile({super.key});
  @override
  Widget build(BuildContext c) => Page(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Profile',
          style: TextStyle(fontSize: 29, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 18),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: box(),
          child: const Column(
            children: [
              CircleAvatar(
                radius: 42,
                backgroundColor: Color(0xffffe9d1),
                child: Icon(Icons.waving_hand, size: 40, color: coral),
              ),
              SizedBox(height: 12),
              Text(
                'Your journey',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
              ),
              Text(
                'Learning English · Joined this month',
                style: TextStyle(color: muted),
              ),
              SizedBox(height: 18),
              Row(
                children: [
                  Expanded(child: Stat(Icons.bolt, '420', 'Total XP')),
                  SizedBox(width: 10),
                  Expanded(
                    child: Stat(
                      Icons.local_fire_department,
                      '7',
                      'Best streak',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Achievements',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        const Tile(
          Icons.local_fire_department,
          'On a roll',
          'Practiced for 7 days in a row',
        ),
        const SizedBox(height: 10),
        const Tile(
          Icons.spa_outlined,
          'First steps',
          'Completed your first lesson',
        ),
      ],
    ),
  );
}

class Lesson extends StatefulWidget {
  const Lesson({required this.close, required this.finish, super.key});
  final VoidCallback close, finish;
  @override
  State<Lesson> createState() => _Lesson();
}

class _Lesson extends State<Lesson> with SingleTickerProviderStateMixin {
  final qs = const [
    (
      'What does this phrase mean?',
      'Good morning!',
      ['မင်္ဂလာနံနက်ခင်းပါ', 'ကျေးဇူးတင်ပါတယ်', 'နောက်မှတွေ့မယ်'],
      0,
    ),
    (
      'Choose the right translation',
      'Nice to meet you.',
      ['ဗိုက်ဆာနေတယ်', 'တွေ့ရတာ ဝမ်းသာပါတယ်', 'ဘယ်လောက်လဲ'],
      1,
    ),
    (
      'What does this phrase mean?',
      'How are you?',
      ['မင်းနာမည် ဘာလဲ', 'ဘယ်သွားမလဲ', 'နေကောင်းလား'],
      2,
    ),
  ];
  int q = 0;
  int? pick;
  bool checked = false;
  late final AnimationController feedbackController;
  late final Animation<double> shake;
  late final Animation<double> successScale;

  @override
  void initState() {
    super.initState();
    feedbackController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 620),
    );
    shake =
        TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 0, end: -10), weight: 1),
          TweenSequenceItem(tween: Tween(begin: -10, end: 9), weight: 2),
          TweenSequenceItem(tween: Tween(begin: 9, end: -7), weight: 2),
          TweenSequenceItem(tween: Tween(begin: -7, end: 5), weight: 2),
          TweenSequenceItem(tween: Tween(begin: 5, end: 0), weight: 1),
        ]).animate(
          CurvedAnimation(
            parent: feedbackController,
            curve: const Interval(0, .7),
          ),
        );
    successScale =
        TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 1, end: 1.045), weight: 1),
          TweenSequenceItem(tween: Tween(begin: 1.045, end: .985), weight: 1),
          TweenSequenceItem(tween: Tween(begin: .985, end: 1), weight: 1),
        ]).animate(
          CurvedAnimation(parent: feedbackController, curve: Curves.easeOut),
        );
  }

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

  void next() {
    if (!checked) {
      setState(() => checked = true);
      feedbackController.forward(from: 0);
    } else if (q < 2) {
      setState(() {
        q++;
        pick = null;
        checked = false;
      });
      feedbackController.reset();
    } else {
      widget.finish();
    }
  }

  @override
  Widget build(BuildContext c) {
    final x = qs[q];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: widget.close,
                    icon: const Icon(Icons.close),
                  ),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: (q + 1) / 3,
                      minHeight: 10,
                      color: teal,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.favorite, color: coral),
                  const Text(' 5'),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(22),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 580),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'QUESTION ${q + 1} OF 3',
                          style: const TextStyle(
                            color: teal,
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          x.$1,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 28),
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: box(),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 35,
                                backgroundColor: Color(0xfffff3e1),
                                child: Icon(
                                  Icons.translate,
                                  size: 34,
                                  color: coral,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  x.$2,
                                  style: const TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              IconButton.filledTonal(
                                onPressed: () {},
                                icon: const Icon(Icons.volume_up_outlined),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'CHOOSE THE CORRECT ANSWER',
                          style: TextStyle(
                            color: muted,
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 11),
                        ...List.generate(3, (i) {
                          final right = checked && i == x.$4,
                              wrong = checked && i == pick && !right;
                          return AnimatedBuilder(
                            animation: feedbackController,
                            builder: (context, child) => Transform.translate(
                              offset: Offset(wrong ? shake.value : 0, 0),
                              child: Transform.scale(
                                scale: right ? successScale.value : 1,
                                child: child,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: InkWell(
                                onTap: checked
                                    ? null
                                    : () => setState(() => pick = i),
                                borderRadius: BorderRadius.circular(18),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 220),
                                  curve: Curves.easeOut,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: right || i == pick
                                        ? mint
                                        : wrong
                                        ? const Color(0xfffff0e8)
                                        : Colors.white,
                                    border: Border.all(
                                      color: right
                                          ? teal
                                          : wrong
                                          ? coral
                                          : const Color(0xffe5ece9),
                                      width: checked && (right || wrong)
                                          ? 2
                                          : 1,
                                    ),
                                    borderRadius: BorderRadius.circular(18),
                                    boxShadow: right
                                        ? [
                                            BoxShadow(
                                              color: teal.withValues(
                                                alpha: .18,
                                              ),
                                              blurRadius: 18,
                                              spreadRadius: 2,
                                            ),
                                          ]
                                        : const [],
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          x.$3[i],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      AnimatedSwitcher(
                                        duration: const Duration(
                                          milliseconds: 250,
                                        ),
                                        transitionBuilder: (child, animation) =>
                                            ScaleTransition(
                                              scale: animation,
                                              child: child,
                                            ),
                                        child: right
                                            ? const Icon(
                                                Icons.check_circle,
                                                key: ValueKey('right'),
                                                color: teal,
                                              )
                                            : wrong
                                            ? const Icon(
                                                Icons.cancel,
                                                key: ValueKey('wrong'),
                                                color: coral,
                                              )
                                            : const SizedBox(
                                                key: ValueKey('empty'),
                                                width: 24,
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(22, 13, 22, 24),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedSize(
                    duration: const Duration(milliseconds: 260),
                    curve: Curves.easeOut,
                    child: checked
                        ? FadeTransition(
                            opacity: CurvedAnimation(
                              parent: feedbackController,
                              curve: Curves.easeOut,
                            ),
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: pick == x.$4
                                    ? mint
                                    : const Color(0xfffff0e8),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    pick == x.$4
                                        ? Icons.celebration_outlined
                                        : Icons.lightbulb_outline,
                                    color: pick == x.$4 ? teal : coral,
                                  ),
                                  const SizedBox(width: 11),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          pick == x.$4
                                              ? 'Excellent!'
                                              : 'Almost there',
                                          style: TextStyle(
                                            color: pick == x.$4 ? teal : coral,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        Text(
                                          pick == x.$4
                                              ? '+20 XP · Great choice'
                                              : 'Correct answer: ${x.$3[x.$4]}',
                                          style: const TextStyle(
                                            color: ink,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      onPressed: pick == null ? null : next,
                      style: FilledButton.styleFrom(
                        backgroundColor: checked && pick != x.$4 ? coral : teal,
                      ),
                      child: Text(
                        !checked
                            ? 'Check answer'
                            : q == 2
                            ? 'Finish lesson'
                            : 'Continue',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Result extends StatelessWidget {
  const Result({required this.back, super.key});
  final VoidCallback back;
  @override
  Widget build(BuildContext c) => Scaffold(
    backgroundColor: mint,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            const Spacer(),
            Container(
              width: 165,
              height: 165,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(34)),
              ),
              child: const Icon(
                Icons.auto_awesome,
                size: 82,
                color: Color(0xffffc75b),
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'Lesson complete!',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
            ),
            const Text(
              "You showed up today. That's how progress grows.",
              textAlign: TextAlign.center,
              style: TextStyle(color: muted),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: back,
                child: const Text('Back to learning path'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class Head extends StatelessWidget {
  const Head(this.a, this.b, {super.key});
  final String a, b;
  @override
  Widget build(BuildContext c) => Row(
    children: [
      Expanded(
        child: Text(
          a,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
      ),
      Text(
        b,
        style: const TextStyle(
          color: teal,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    ],
  );
}

class Stat extends StatelessWidget {
  const Stat(this.icon, this.value, this.label, {super.key});
  final IconData icon;
  final String value, label;
  @override
  Widget build(BuildContext c) => Container(
    padding: const EdgeInsets.all(12),
    decoration: box(),
    child: Column(
      children: [
        Icon(icon, color: teal),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),
        Text(
          label,
          maxLines: 1,
          style: const TextStyle(color: muted, fontSize: 10),
        ),
      ],
    ),
  );
}

class Tile extends StatelessWidget {
  const Tile(this.icon, this.title, this.sub, {this.onTap, super.key});
  final IconData icon;
  final String title, sub;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext c) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(18),
    child: Container(
      padding: const EdgeInsets.all(13),
      decoration: box(),
      child: Row(
        children: [
          Container(
            width: 51,
            height: 51,
            decoration: BoxDecoration(
              color: mint,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: teal),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                Text(sub, style: const TextStyle(color: muted, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: muted),
        ],
      ),
    ),
  );
}

class Rank extends StatelessWidget {
  const Rank(this.rank, this.name, this.xp, {this.active = false, super.key});
  final String rank, name, xp;
  final bool active;
  @override
  Widget build(BuildContext c) => Container(
    margin: const EdgeInsets.only(bottom: 9),
    padding: const EdgeInsets.all(14),
    decoration: box(active ? mint : Colors.white),
    child: Row(
      children: [
        Text(
          rank,
          style: const TextStyle(color: teal, fontWeight: FontWeight.w800),
        ),
        const SizedBox(width: 16),
        const Icon(Icons.person_outline, color: coral),
        const SizedBox(width: 12),
        Text(name, style: const TextStyle(fontWeight: FontWeight.w800)),
        const Spacer(),
        Text(xp, style: const TextStyle(color: muted)),
      ],
    ),
  );
}
