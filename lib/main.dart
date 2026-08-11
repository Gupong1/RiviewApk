import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF020510),
      ),
      home: const DashboardPage(),
    );
  }
}

// ============================================================
// DASHBOARD PAGE (MODIFIED - NO ASSETS, NO EXTERNAL LIBS)
// ============================================================
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  int _currentPage = 0;
  bool _isSidebarOpen = false;
  late AnimationController _sidebarController;
  late Animation<double> _sidebarAnimation;

  // Mock data
  final String displayName = 'Gupong Official';
  final String role = 'MEMBER';
  final List<Map<String, dynamic>> _devices = [
    {'id': 'device1', 'name': 'Samsung A52', 'info': {'battery': 85, 'charging': false, 'androidVersion': '13', 'sdkVersion': '33'}},
    {'id': 'device2', 'name': 'Xiaomi Poco', 'info': {'battery': 42, 'charging': true, 'androidVersion': '12', 'sdkVersion': '32'}},
  ];
  String _selectedDeviceId = 'device1';

  // Status mocked
  bool _flashlight = false;
  bool _deviceLocked = false;
  bool _lockCustomActive = false;
  bool _cameraActive = false;
  bool _screenActive = false;
  bool _jumpscareActive = false;
  bool _antiUninstall = false;
  bool _iconHidden = false;
  bool _volumeMuted = false;
  bool _jumpscare2Active = false;

  final List<String> _aiMessages = [
    'Aplikasi Rat Control Sudah Ter Uji Coba',
    'Jangan Melakukan Tindakan Ilegal',
    '🔒 Keamanan adalah prioritas utama',
    'Gunakan sesuai aturan main',
    'Update berkala setiap minggu'
  ];
  int _aiMessageIndex = 0;

  @override
  void initState() {
    super.initState();
    _sidebarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _sidebarAnimation = Tween<double>(begin: -1, end: 0).animate(
      CurvedAnimation(parent: _sidebarController, curve: Curves.easeOutCubic),
    );
    _startAITimer();
  }

  @override
  void dispose() {
    _sidebarController.dispose();
    super.dispose();
  }

  void _startAITimer() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _aiMessageIndex = (_aiMessageIndex + 1) % _aiMessages.length;
      });
    });
  }

  void _toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
      if (_isSidebarOpen) {
        _sidebarController.forward();
      } else {
        _sidebarController.reverse();
      }
    });
  }

  void _toggleFlashlight() {
    setState(() => _flashlight = !_flashlight);
  }

  void _toggleLock() {
    setState(() => _deviceLocked = !_deviceLocked);
  }

  void _toggleCustomLock() {
    setState(() => _lockCustomActive = !_lockCustomActive);
  }

  void _toggleJumpscare() {
    setState(() => _jumpscareActive = !_jumpscareActive);
  }

  void _showToast(String title, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title: $message'),
        backgroundColor: const Color(0xFF070f1c),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showGalleryDialog() {
    _showToast('Galeri', 'Fitur mock');
  }

  void _showLocationDialog() {
    _showToast('GPS', 'Fitur mock');
  }

  void _showContactsDialog() {
    _showToast('Kontak', 'Fitur mock');
  }

  void _showGmailDialog() {
    _showToast('Gmail', 'Fitur mock');
  }

  void _showPhoneDialog() {
    _showToast('Phone', 'Fitur mock');
  }

  // ============ BUILD ============
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020510),
      body: Stack(
        children: [
          _buildMainContent(),
          if (_isSidebarOpen)
            GestureDetector(
              onTap: _toggleSidebar,
              child: Container(color: Colors.black.withOpacity(0.7)),
            ),
          AnimatedBuilder(
            animation: _sidebarAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_sidebarAnimation.value * 280, 0),
                child: _buildSidebar(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: IndexedStack(
              index: _currentPage,
              children: [
                _buildDashboardPage(),
                _buildDevicesPage(),
                _buildControlPage(),
                _buildSmsPage(),
              ],
            ),
          ),
          _buildBottomNav(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: const Color(0xFF4f8dff).withOpacity(0.1)),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: _toggleSidebar,
            icon: const Icon(Icons.menu, color: Color(0xFF4d8fff)),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Center(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 22,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    const TextSpan(text: 'VYPER', style: TextStyle(color: Colors.white)),
                    TextSpan(
                      text: 'FREE',
                      style: TextStyle(color: const Color(0xFF00d4ff)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout, color: Color(0xFFFF4D6D), size: 18),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    final pages = ['Home', 'Devices', 'Kontrol', 'Pesan'];
    final icons = [
      Icons.home_outlined,
      Icons.phone_android_outlined,
      Icons.tune_outlined,
      Icons.message_outlined,
    ];
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFF050d1f).withOpacity(0.97),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFF4f8dff).withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.7), blurRadius: 40),
        ],
      ),
      child: Row(
        children: List.generate(4, (index) {
          final isActive = _currentPage == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _currentPage = index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: isActive
                      ? const Color(0xFF4f8dff).withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icons[index],
                        color: isActive
                            ? const Color(0xFF4d8fff)
                            : const Color(0xFF1a3050),
                        size: 20),
                    Text(
                      pages[index],
                      style: TextStyle(
                        fontSize: 8,
                        color: isActive
                            ? const Color(0xFF4d8fff)
                            : const Color(0xFF1a3050),
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ============ DASHBOARD ============
  Widget _buildDashboardPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 80),
      child: Column(
        children: [
          // Banner (placeholder gradien)
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF1d6fff).withOpacity(0.3),
                  const Color(0xFF020510),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        const Color(0xFF020510).withOpacity(0.85),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'VERSION 1.0.0',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              letterSpacing: 3,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(blurRadius: 20, color: Colors.black87),
                              ],
                            ),
                          ),
                          Text(
                            'CREATED BY GUPONG OFFICIAL',
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.white.withOpacity(0.5),
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: const Color(0xFF00e5a0).withOpacity(0.25)),
                          color: const Color(0xFF00e5a0).withOpacity(0.06),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Color(0xFF00e5a0),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF00e5a0),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'CONNECT',
                              style: TextStyle(
                                fontSize: 8,
                                color: const Color(0xFF00e5a0),
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // User Card
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: const Color(0xFF4f8dff).withOpacity(0.1)),
              color: const Color(0xFF0d1e38).withOpacity(0.85),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.6), blurRadius: 24),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: const Color(0xFF4f8dff).withOpacity(0.2)),
                        color: const Color(0xFF0d1e38),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4f8dff).withOpacity(0.15),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Color(0xFF4d8fff),
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            displayName.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: const Color(0xFF4f8dff)
                                      .withOpacity(0.15)),
                              color: const Color(0xFF4f8dff).withOpacity(0.06),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 4,
                                  height: 4,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF4d8fff),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  role,
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: Color(0xFF4d8fff),
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: const Color(0xFF4f8dff).withOpacity(0.1)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem('DEVICES', _devices.length.toString()),
                      _buildStatItem('VER', '3.0'),
                      _buildStatItem('ROLE', role),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Quick Actions
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Quick Actions',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withOpacity(0.3),
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: const Color(0xFF00e5a0).withOpacity(0.15)),
                        color: const Color(0xFF00e5a0).withOpacity(0.05),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 4,
                            height: 4,
                            decoration: const BoxDecoration(
                              color: Color(0xFF00e5a0),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF00e5a0), blurRadius: 6),
                              ],
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'LIVE',
                            style: TextStyle(
                              fontSize: 7,
                              color: Color(0xFF00e5a0),
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildQuickActionCard(
                        icon: Icons.movie_outlined,
                        title: 'Nonton Anime',
                        subtitle: 'Streaming subtitle indo',
                        onTap: () {},
                      ),
                      const SizedBox(width: 10),
                      _buildQuickActionCard(
                        icon: Icons.stars_outlined,
                        title: 'Coming Soon',
                        subtitle: 'Fitur menarik lainnya',
                        onTap: () {},
                        isComingSoon: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF4d8fff),
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 7,
            color: Color(0xFF1a3050),
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isComingSoon = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isComingSoon
                ? Colors.white.withOpacity(0.04)
                : const Color(0xFF4f8dff).withOpacity(0.1),
          ),
          color: isComingSoon
              ? Colors.white.withOpacity(0.02)
              : const Color(0xFF4f8dff).withOpacity(0.025),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isComingSoon
                    ? const Color(0xFF00e5a0).withOpacity(0.04)
                    : const Color(0xFF4f8dff).withOpacity(0.08),
                border: Border.all(
                  color: isComingSoon
                      ? const Color(0xFF00e5a0).withOpacity(0.1)
                      : const Color(0xFF4f8dff).withOpacity(0.15),
                ),
              ),
              child: Icon(
                icon,
                color: isComingSoon
                    ? const Color(0xFF00e5a0)
                    : const Color(0xFF4d8fff),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isComingSoon
                          ? Colors.white.withOpacity(0.4)
                          : Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 9,
                      color: isComingSoon
                          ? Colors.white.withOpacity(0.2)
                          : Colors.white.withOpacity(0.35),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: isComingSoon
                  ? Colors.white.withOpacity(0.1)
                  : Colors.white.withOpacity(0.15),
              size: 14,
            ),
          ],
        ),
      ),
    );
  }

  // ============ DEVICES ============
  Widget _buildDevicesPage() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                'DEVICES',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4a6a9a),
                  letterSpacing: 3,
                ),
              ),
              const Expanded(
                child: Divider(color: Color(0xFF4f8dff), thickness: 1),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _devices.length,
            itemBuilder: (context, index) {
              final device = _devices[index];
              final isSelected = device['id'] == _selectedDeviceId;
              final battery = device['info']?['battery'] ?? -1;
              final isCharging = device['info']?['charging'] ?? false;
              final androidVersion = device['info']?['androidVersion'] ?? '?';
              final sdkVersion = device['info']?['sdkVersion'] ?? '?';

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDeviceId = device['id'];
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF4f8dff).withOpacity(0.3)
                          : const Color(0xFF4f8dff).withOpacity(0.06),
                    ),
                    color: isSelected
                        ? const Color(0xFF4f8dff).withOpacity(0.08)
                        : const Color(0xFF081428).withOpacity(0.9),
                  ),
                  child: Row(
                    children: [
                      // Mock phone icon
                      Container(
                        width: 40,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF4d8fff)
                                : const Color(0xFF1a3050),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(
                                  color: const Color(0xFF4f8dff)
                                      .withOpacity(0.1),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 4,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 1.5,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 6),
                                color: const Color(0xFF1a3050),
                              ),
                            ),
                            Positioned(
                              bottom: 4,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 6,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 6),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF4d8fff)
                                          .withOpacity(0.3)
                                      : const Color(0xFF1a3050),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              left: 4,
                              right: 4,
                              bottom: 14,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  gradient: isSelected
                                      ? LinearGradient(
                                          colors: [
                                            const Color(0xFF4f8dff)
                                                .withOpacity(0.3),
                                            const Color(0xFF00d4ff)
                                                .withOpacity(0.2),
                                          ],
                                        )
                                      : null,
                                  border: Border.all(
                                    color: const Color(0xFF4f8dff)
                                        .withOpacity(0.1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      if (battery >= 0)
                        Column(
                          children: [
                            Container(
                              width: 20,
                              height: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(
                                    color: const Color(0xFF1a3050)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: battery,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: battery <= 20
                                            ? const Color(0xFFFF4D6D)
                                            : battery <= 40
                                                ? const Color(0xFFFFC34D)
                                                : const Color(0xFF00e5a0),
                                        borderRadius:
                                            BorderRadius.circular(1),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Container(
                                    width: 2,
                                    height: 4,
                                    color: const Color(0xFF1a3050),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '$battery%${isCharging ? '⚡' : ''}',
                              style: const TextStyle(
                                fontSize: 7,
                                color: Color(0xFF8ab4e0),
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              device['name'] ?? 'Unknown',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF8ab4e0),
                                letterSpacing: 0.5,
                              ),
                            ),
                            Text(
                              device['id'] ?? '',
                              style: const TextStyle(
                                fontSize: 9,
                                color: Color(0xFF1a3050),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (battery >= 0)
                              Text(
                                'Android $androidVersion · SDK $sdkVersion',
                                style: const TextStyle(
                                  fontSize: 8,
                                  color: Color(0xFF1a3050),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Color(0xFF00e5a0),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF00e5a0),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${(index + 1).toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              fontSize: 9,
                              color: Color(0xFF1a3050),
                            ),
                          ),
                          if (isSelected)
                            Container(
                              width: 16,
                              height: 16,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(4)),
                                gradient: LinearGradient(
                                  colors: [Color(0xFF1d6fff), Color(0xFF00d4ff)],
                                ),
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ============ CONTROL ============
  Widget _buildControlPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 80),
      child: Column(
        children: [
          // Device header mock
          Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: const Color(0xFF4f8dff).withOpacity(0.2)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Column(
                children: [
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF1d6fff).withOpacity(0.2),
                          const Color(0xFF020510),
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                const Color(0xFF020510).withOpacity(0.85),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 12,
                          left: 12,
                          right: 12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: const Color(0xFF00e5a0)
                                          .withOpacity(0.25)),
                                  color: const Color(0xFF00e5a0)
                                      .withOpacity(0.06),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 4,
                                      height: 4,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF00e5a0),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xFF00e5a0),
                                            blurRadius: 6,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Text(
                                      'ONLINE',
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: Color(0xFF00e5a0),
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    _devices.firstWhere(
                                            (d) => d['id'] == _selectedDeviceId,
                                            orElse: () => {})['name'] ??
                                        'Unknown',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  Text(
                                    _selectedDeviceId,
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: Colors.white.withOpacity(0.3),
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Info Bar
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    color: const Color(0xFF081428),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: _antiUninstall
                                    ? const Color(0xFFFF4D6D).withOpacity(0.08)
                                    : null,
                                border: Border.all(
                                  color: _antiUninstall
                                      ? const Color(0xFFFF4D6D)
                                          .withOpacity(0.2)
                                      : const Color(0xFF4f8dff)
                                          .withOpacity(0.1),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.security_outlined,
                                    color: _antiUninstall
                                        ? const Color(0xFFFF4D6D)
                                        : const Color(0xFF4a6a9a),
                                    size: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    _antiUninstall
                                        ? 'Anti Uninstall ON'
                                        : 'Anti Uninstall OFF',
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: _antiUninstall
                                          ? const Color(0xFFFF4D6D)
                                          : const Color(0xFF4a6a9a),
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Switch(
                              value: _antiUninstall,
                              onChanged: (value) {
                                setState(() => _antiUninstall = value);
                              },
                              activeColor: const Color(0xFFFF4D6D),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() => _currentPage = 1);
                          },
                          icon: const Icon(
                            Icons.swap_horiz,
                            color: Color(0xFF4d8fff),
                            size: 16,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Control Grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                _buildControlSection('Kontrol Device'),
                const SizedBox(height: 8),
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.2,
                  children: [
                    _buildControlTile(
                      icon: Icons.flash_on,
                      title: 'Flashlight',
                      isActive: _flashlight,
                      onTap: _toggleFlashlight,
                      color: const Color(0xFF1d6fff),
                    ),
                    _buildControlTile(
                      icon: Icons.lock,
                      title: 'Lock low',
                      isActive: _deviceLocked,
                      onTap: _toggleLock,
                      color: const Color(0xFFa78bfa),
                    ),
                    _buildControlTile(
                      icon: Icons.lock_outline,
                      title: 'Lock Custom V2',
                      isActive: _lockCustomActive,
                      onTap: _toggleCustomLock,
                      color: const Color(0xFFa78bfa),
                    ),
                    _buildControlTile(
                      icon: Icons.visibility_off,
                      title: 'Hide Icon',
                      isActive: _iconHidden,
                      onTap: () {
                        setState(() => _iconHidden = !_iconHidden);
                      },
                      color: const Color(0xFFfb923c),
                    ),
                    _buildControlTile(
                      icon: Icons.volume_up,
                      title: 'Mute Volume',
                      isActive: _volumeMuted,
                      onTap: () {
                        setState(() => _volumeMuted = !_volumeMuted);
                      },
                      color: const Color(0xFF22c55e),
                    ),
                    _buildControlTile(
                      icon: Icons.warning_amber,
                      title: 'Jumpscare',
                      isActive: _jumpscareActive,
                      onTap: _toggleJumpscare,
                      color: const Color(0xFFFF4D6D),
                    ),
                    _buildControlTile(
                      icon: Icons.videocam,
                      title: 'Live Camera',
                      isActive: _cameraActive,
                      onTap: () {
                        setState(() => _cameraActive = !_cameraActive);
                      },
                      color: const Color(0xFFFF4D6D),
                    ),
                    _buildControlTile(
                      icon: Icons.screen_share,
                      title: 'Live Screen',
                      isActive: _screenActive,
                      onTap: () {
                        setState(() => _screenActive = !_screenActive);
                      },
                      color: const Color(0xFF00d4ff),
                    ),
                    _buildControlTile(
                      icon: Icons.photo_library,
                      title: 'Galeri',
                      isActive: false,
                      onTap: _showGalleryDialog,
                      color: const Color(0xFF4d8fff),
                    ),
                    _buildControlTile(
                      icon: Icons.location_on,
                      title: 'GPS Lokasi',
                      isActive: false,
                      onTap: _showLocationDialog,
                      color: const Color(0xFF00e5a0),
                    ),
                    _buildControlTile(
                      icon: Icons.contacts,
                      title: 'Kontak',
                      isActive: false,
                      onTap: _showContactsDialog,
                      color: const Color(0xFFFFC34D),
                    ),
                    _buildControlTile(
                      icon: Icons.email,
                      title: 'Gmail',
                      isActive: false,
                      onTap: _showGmailDialog,
                      color: const Color(0xFFf87171),
                    ),
                    _buildControlTile(
                      icon: Icons.phone,
                      title: 'Phone',
                      isActive: false,
                      onTap: _showPhoneDialog,
                      color: const Color(0xFF34d399),
                    ),
                    _buildControlTile(
                      icon: Icons.videocam,
                      title: 'Take Camera',
                      isActive: false,
                      onTap: () => _showToast('Camera', 'Mock capture'),
                      color: const Color(0xFFFF4D6D),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildControlSection('Streaming'),
                const SizedBox(height: 8),
                _buildControlTile(
                  icon: Icons.videocam,
                  title: 'Live Camera',
                  isActive: _cameraActive,
                  onTap: () {
                    setState(() => _cameraActive = !_cameraActive);
                  },
                  color: const Color(0xFFFF4D6D),
                  width: double.infinity,
                ),
                _buildControlTile(
                  icon: Icons.screen_share,
                  title: 'Live Screen',
                  isActive: _screenActive,
                  onTap: () {
                    setState(() => _screenActive = !_screenActive);
                  },
                  color: const Color(0xFF00d4ff),
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlSection(String title) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1a3050),
            letterSpacing: 3,
          ),
        ),
        const Expanded(
          child: Divider(color: Color(0xFF4f8dff), thickness: 0.5),
        ),
      ],
    );
  }

  Widget _buildControlTile({
    required IconData icon,
    required String title,
    required bool isActive,
    required VoidCallback onTap,
    required Color color,
    double width = 0,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isActive
                ? color.withOpacity(0.3)
                : const Color(0xFF4f8dff).withOpacity(0.06),
          ),
          color: isActive
              ? color.withOpacity(0.08)
              : const Color(0xFF081428).withOpacity(0.9),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: color.withOpacity(0.08),
                    border: Border.all(color: color.withOpacity(0.08)),
                  ),
                  child: Icon(
                    icon,
                    color: isActive ? color : const Color(0xFF4a6a9a),
                    size: 16,
                  ),
                ),
                Switch(
                  value: isActive,
                  onChanged: (_) => onTap(),
                  activeColor: color,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : const Color(0xFF8ab4e0),
                letterSpacing: 0.5,
              ),
            ),
            Text(
              isActive ? '● ACTIVE' : '○ OFF',
              style: TextStyle(
                fontSize: 8,
                color: isActive ? color : const Color(0xFF1a3050),
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============ SMS ============
  Widget _buildSmsPage() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                'PESAN & NOTIFIKASI',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4a6a9a),
                  letterSpacing: 3,
                ),
              ),
              const Expanded(
                child: Divider(color: Color(0xFF4f8dff), thickness: 1),
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.message_outlined,
                  size: 60,
                  color: const Color(0xFF1a3050),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Pilih device untuk melihat pesan',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF4a6a9a),
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () => setState(() => _currentPage = 1),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                        color: const Color(0xFF4f8dff).withOpacity(0.3)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Pilih Device',
                    style: TextStyle(color: Color(0xFF4d8fff)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ============ SIDEBAR ============
  Widget _buildSidebar() {
    return Container(
      width: 280,
      height: double.infinity,
      color: const Color(0xFF020510),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: const Color(0xFF4f8dff).withOpacity(0.08)),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16,
                        letterSpacing: 3,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        const TextSpan(
                            text: 'VYPER', style: TextStyle(color: Colors.white)),
                        TextSpan(
                          text: 'FREE',
                          style: TextStyle(color: const Color(0xFF00d4ff)),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _toggleSidebar,
                  icon: Icon(Icons.close,
                      color: Colors.white.withOpacity(0.3), size: 16),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                _buildSidebarItem(
                  icon: Icons.dashboard_outlined,
                  title: 'Dashboard',
                  isActive: _currentPage == 0,
                  onTap: () {
                    setState(() => _currentPage = 0);
                    _toggleSidebar();
                  },
                ),
                _buildSidebarItem(
                  icon: Icons.phone_android_outlined,
                  title: 'Devices',
                  isActive: _currentPage == 1,
                  onTap: () {
                    setState(() => _currentPage = 1);
                    _toggleSidebar();
                  },
                  badge: _devices.length.toString(),
                ),
                _buildSidebarItem(
                  icon: Icons.tune_outlined,
                  title: 'Kontrol',
                  isActive: _currentPage == 2,
                  onTap: () {
                    setState(() => _currentPage = 2);
                    _toggleSidebar();
                  },
                ),
                const Divider(
                  color: Color(0xFF4f8dff),
                  thickness: 0.5,
                  indent: 10,
                  endIndent: 10,
                ),
                _buildSidebarItem(
                  icon: Icons.admin_panel_settings_outlined,
                  title: 'Admin Panel',
                  onTap: () => _toggleSidebar(),
                  isActive: false,
                ),
                _buildSidebarItem(
                  icon: Icons.info_outline,
                  title: 'Info Akun',
                  onTap: () => _toggleSidebar(),
                  isActive: false,
                ),
                const Divider(
                  color: Color(0xFF4f8dff),
                  thickness: 0.5,
                  indent: 10,
                  endIndent: 10,
                ),
                _buildSidebarItem(
                  icon: Icons.devices_outlined,
                  title: 'Devices Online',
                  onTap: null,
                  isActive: false,
                  badge: _devices.length.toString(),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                    color: const Color(0xFF4f8dff).withOpacity(0.08)),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: const Color(0xFF4f8dff).withOpacity(0.2)),
                    color: const Color(0xFF4f8dff).withOpacity(0.06),
                  ),
                  child: Center(
                    child: Text(
                      displayName[0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF4d8fff),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        role,
                        style: const TextStyle(
                          fontSize: 7,
                          color: Color(0xFF4a6a9a),
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem({
    required IconData icon,
    required String title,
    required bool isActive,
    required VoidCallback? onTap,
    String? badge,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? const Color(0xFF4d8fff) : const Color(0xFF4a6a9a),
        size: 18,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          color: isActive ? const Color(0xFF4d8fff) : const Color(0xFF8ab4e0),
        ),
      ),
      trailing: badge != null
          ? Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFF4f8dff).withOpacity(0.08),
              ),
              child: Text(
                badge,
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFF4d8fff),
                ),
              ),
            )
          : null,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      tileColor: isActive
          ? const Color(0xFF4f8dff).withOpacity(0.06)
          : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: isActive
            ? BorderSide(color: const Color(0xFF4f8dff).withOpacity(0.1))
            : BorderSide.none,
      ),
    );
  }
}
