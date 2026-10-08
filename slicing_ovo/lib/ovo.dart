import 'package:flutter/material.dart';

void main() => runApp(const OvoApp());

const kPurple = Color(0xFF4B1DC9);
const kDark = Color(0xFF1E1A34);
const kGrey = Color(0xFF8E8E99);

class OvoApp extends StatelessWidget {
  const OvoApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'OVO',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: kPurple),
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
        ),
        home: const MainShell(),
      );
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const [
          HomePage(),
          Center(child: Text('Finance')),
          Center(child: Text('Pay')),
          Center(child: Text('Inbox')),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: _BottomBar(
        index: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onTap;

  const _BottomBar({
    required this.index,
    required this.onTap,
  });

  Widget _item(
    int i,
    IconData icon,
    String label, {
    int badge = 0,
  }) {
    final active = index == i;
    final color = active ? kPurple : kGrey;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(i),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 28,
                ),
                if (badge > 0)
                  Positioned(
                    right: -10,
                    top: -6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.shade700,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '$badge',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight:
                    active ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72 + MediaQuery.of(context).padding.bottom,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFEAEAF0),
          ),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            children: [
              _item(
                0,
                Icons.home_rounded,
                'Home',
              ),
              _item(
                1,
                Icons.paid_rounded,
                'Finance',
              ),
              const Expanded(
                child: SizedBox(),
              ),
              _item(
                3,
                Icons.notifications_rounded,
                'Inbox',
                badge: 36,
              ),
              _item(
                4,
                Icons.account_circle_rounded,
                'Profile',
              ),
            ],
          ),
          Positioned(
            top: -24,
            left: 0,
            right: 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => onTap(2),
                  child: Container(
                    width: 70,
                    height: 70,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF7B3FE4),
                            Color(0xFF4B1DC9),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'QRIS',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Pay',
                  style: TextStyle(
                    color: index == 2 ? kPurple : kGrey,
                    fontSize: 12,
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

class _Service {
  final String name;
  final IconData icon;
  final Color color;
  final String? badge;

  const _Service(
    this.name,
    this.icon,
    this.color, [
    this.badge,
  ]);
}

const _services = [
  _Service(
    'Nabung by Superbank',
    Icons.savings_rounded,
    Color(0xFF7B3FE4),
    'BARU',
  ),
  _Service(
    'Pinjaman',
    Icons.payments_rounded,
    Color(0xFF5B4BC4),
    '100JT',
  ),
  _Service(
    'Uang Elektronik',
    Icons.contactless_rounded,
    Color(0xFFE8552D),
    'Rp 1',
  ),
  _Service(
    'Angsuran Kredit',
    Icons.receipt_long_rounded,
    Color(0xFFD81B60),
  ),
  _Service(
    'Pulsa/Paket Data',
    Icons.smartphone_rounded,
    Color(0xFF2F6FE4),
    'PROMO',
  ),
  _Service(
    'PLN',
    Icons.bolt_rounded,
    Color(0xFFF5A623),
    'PROMO',
  ),
  _Service(
    'Air PDAM',
    Icons.water_drop_rounded,
    Color(0xFF29A9E0),
  ),
  _Service(
    'Internet & TV Kabel',
    Icons.live_tv_rounded,
    Color(0xFFE5483B),
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showBalance = false;
  int _tab = 0;

  final _tabs = const [
    'Favorit',
    'Finansial',
    'Hiburan',
    'Pilihan Lain',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFBFB0F0),
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.center,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _header(),
            _balanceCard(),
            const SizedBox(height: 16),
            _infoCard(),
            const SizedBox(height: 20),
            _tabRow(),
            const SizedBox(height: 12),
            _grid(),
            Container(
              height: 8,
              color: const Color(0xFFF3F3F7),
            ),
            _banner(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _header() => Padding(
        padding: const EdgeInsets.fromLTRB(
          20,
          12,
          20,
          16,
        ),
        child: Row(
          children: [
            Image.asset(
              'assets/ovo_logo.png',
              width: 100,
              height: 50,
              fit: BoxFit.contain,
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.discount_rounded,
                    color: kPurple,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Promo',
                    style: TextStyle(
                      color: kPurple,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _balanceCard() => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF5B2BD6),
              Color(0xFF4B1DC9),
              Color(0xFF5E8AE0),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x334B1DC9),
              blurRadius: 16,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'OVO Cash',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            const Row(
              children: [
                Text(
                  'Total Saldo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 6),
                Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(
                      () => _showBalance = !_showBalance,
                    ),
                    child: Text(
                      _showBalance
                          ? 'Rp 1.250.000'
                          : 'Tap untuk lihat',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        radius: 11,
                        backgroundColor: kDark,
                        child: Text(
                          'P',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'OVO Points',
                        style: TextStyle(
                          color: kPurple,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: kDark,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            const Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                _CardAction(
                  Icons.add_circle,
                  'Top Up',
                ),
                _CardAction(
                  Icons.arrow_circle_up,
                  'Transfer',
                ),
                _CardAction(
                  Icons.atm_rounded,
                  'Tarik Tunai',
                ),
                _CardAction(
                  Icons.list_alt_rounded,
                  'History',
                ),
              ],
            ),
          ],
        ),
      );

  Widget _infoCard() => SizedBox(
        height: 150,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 60,
              margin: const EdgeInsets.only(
                right: 12,
                bottom: 8,
              ),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 26,
                        backgroundColor: Color(0xFFF5B83D),
                        child: Icon(
                          Icons.track_changes,
                          color: kPurple,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Text(
                          'Cek data kamu demi kelancaran pemakaian akun OVO Premier kamu',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: kPurple,
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 48,
                        ),
                      ),
                      child: const Text('Cek'),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 120,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.star_rounded,
                    size: 44,
                    color: Color(0xFFE5483B),
                  ),
                  const Text(
                    'OVO STAMP',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFE5483B),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1DB954),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Mulai Misi!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _tabRow() => SizedBox(
        height: 46,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          itemCount: _tabs.length,
          separatorBuilder: (_, __) =>
              const SizedBox(width: 8),
          itemBuilder: (_, i) {
            final sel = _tab == i;

            return GestureDetector(
              onTap: () => setState(() => _tab = i),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: sel
                      ? const Color(0xFFF1F1F5)
                      : Colors.transparent,
                  borderRadius:
                      BorderRadius.circular(30),
                ),
                child: Text(
                  _tabs[i],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: sel ? kPurple : kGrey,
                  ),
                ),
              ),
            );
          },
        ),
      );

  Widget _grid() => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        child: GridView.builder(
          shrinkWrap: true,
          physics:
              const NeverScrollableScrollPhysics(),
          itemCount: _services.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisExtent: 128,
          ),
          itemBuilder: (_, i) =>
              _ServiceTile(_services[i]),
        ),
      );

  Widget _banner() => Container(
        height: 130,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF16122B),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.centerLeft,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              'EASYCASH × OVO',
              style: TextStyle(
                color: Colors.white70,
                letterSpacing: 2,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Cairkan Dana',
              style: TextStyle(
                color: Color(0xFF3DDC84),
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      );
}

class _CardAction extends StatelessWidget {
  final IconData icon;
  final String label;

  const _CardAction(
    this.icon,
    this.label,
  );

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 38,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ],
      );
}

class _ServiceTile extends StatelessWidget {
  final _Service s;

  const _ServiceTile(this.s);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              width: 62,
              height: 62,
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: s.color.withValues(alpha: 0.12),
              ),
              child: Icon(
                s.icon,
                color: s.color,
                size: 30,
              ),
            ),
            if (s.badge != null)
              Positioned(
                top: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0161B),
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                  child: Text(
                    s.badge!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          s.name,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Widget _section(String t) => Padding(
        padding: const EdgeInsets.fromLTRB(
          20,
          28,
          20,
          8,
        ),
        child: Text(
          t,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: kDark,
          ),
        ),
      );

  Widget _row(
    IconData icon,
    String label, {
    Widget? trailing,
    bool divider = true,
  }) =>
      Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          border: divider
              ? const Border(
                  bottom: BorderSide(
                    color: Color(0xFFEAEAF0),
                  ),
                )
              : null,
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          minVerticalPadding: 18,
          leading: Icon(
            icon,
            color: kDark,
            size: 28,
          ),
          title: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: trailing ??
              const Icon(
                Icons.chevron_right,
                color: kDark,
              ),
          onTap: () {},
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              32,
              20,
              20,
            ),
            child: Text(
              'Profile',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFE3E3EA),
              ),
              borderRadius:
                  BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(0xFFE2D8F8),
                  child: Icon(
                    Icons.person,
                    color: kPurple,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Iffat Brian A.B',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '0857-5590-6190',
                        style: TextStyle(
                          fontSize: 16,
                          color:
                              Color(0xFF444450),
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  'Ubah',
                  style: TextStyle(
                    color: Color(0xFF1F5FD6),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            padding:
                const EdgeInsets.symmetric(
              vertical: 22,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFE3E3EA),
              ),
              borderRadius:
                  BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.barcode_reader,
                  size: 34,
                ),
                SizedBox(width: 14),
                Text(
                  'Loyalty Code',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          _section('Akun'),
          _row(
            Icons.track_changes,
            'OVO Premier',
            trailing: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: kPurple,
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
              ),
              child: const Text(
                'Upgrade',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          _row(
            Icons.stars_rounded,
            'OVO Points',
          ),
          _row(
            Icons.star_rounded,
            'OVO Stamp',
          ),
          _row(
            Icons.link_rounded,
            'Aplikasi Terhubung',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8164F),
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'NEW',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.chevron_right,
                  color: kDark,
                ),
              ],
            ),
          ),
          _section('Bantuan'),
          _row(
            Icons.help_rounded,
            'Pusat Bantuan',
          ),
          _section('Keamanan'),
          _row(
            Icons.lock_outline_rounded,
            'PIN & Keamanan',
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}