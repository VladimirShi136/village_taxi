import 'package:flutter/material.dart';

void main() {
  runApp(const VillageTaxiApp());
}

const _ink = Color(0xFF203A32);
const _muted = Color(0xFF89928B);
const _lime = Color(0xFFD7F27A);
const _paper = Color(0xFFF6F6F1);

class VillageTaxiApp extends StatelessWidget {
  const VillageTaxiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Рядом — такси',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: _paper,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _ink,
          primary: _ink,
          surface: Colors.white,
        ),
        fontFamily: 'Roboto',
      ),
      home: const BookingPage(),
    );
  }
}

enum RideType {
  economy('Эконом', 'До 4 мест', Icons.directions_car_outlined, 320),
  comfort('Комфорт', 'До 4 мест', Icons.airline_seat_recline_extra, 450),
  van('Минивэн', 'До 6 мест', Icons.airport_shuttle_outlined, 560);

  const RideType(this.title, this.subtitle, this.icon, this.price);

  final String title;
  final String subtitle;
  final IconData icon;
  final int price;
}

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _fromController = TextEditingController(text: 'ул. Центральная, 12');
  final _toController = TextEditingController(text: 'Ж/д вокзал');
  RideType _selectedRide = RideType.economy;

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  Future<void> _showDemoConfirmation() async {
    FocusScope.of(context).unfocus();
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  color: Color(0xFFEAF3D5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded, color: _ink, size: 28),
              ),
              const SizedBox(height: 18),
              const Text(
                'Заказ оформлен!',
                style: TextStyle(
                  color: _ink,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Это демо-режим приложения для портфолио. '
                'Реальный водитель не вызывается.',
                style: TextStyle(color: _muted, fontSize: 15, height: 1.45),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: FilledButton.styleFrom(
                    backgroundColor: _ink,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Отлично'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(22, 14, 22, 28),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _buildHeader(),
                      const SizedBox(height: 24),
                      _buildTitle(),
                      const SizedBox(height: 18),
                      _buildMap(),
                      const SizedBox(height: 22),
                      _buildRouteCard(),
                      const SizedBox(height: 22),
                      _buildSectionTitle('Выберите поездку', 'Цены честные'),
                      const SizedBox(height: 12),
                      _buildRideOptions(),
                      const SizedBox(height: 16),
                      _buildPaymentRow(),
                      const SizedBox(height: 18),
                      _buildOrderButton(),
                      const SizedBox(height: 18),
                      _buildLocalPromise(),
                      const SizedBox(height: 18),
                      const Center(
                        child: Text(
                          'РАЗРАБОТАНО ДЛЯ СВОИХ',
                          style: TextStyle(
                            color: _muted,
                            fontSize: 10,
                            letterSpacing: 1.8,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: _ink,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(Icons.local_taxi_rounded, color: _lime, size: 23),
        ),
        const SizedBox(width: 11),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'рядом',
              style: TextStyle(
                color: _ink,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                height: 1,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'ТАКСИ ДЛЯ СВОИХ',
              style: TextStyle(
                color: _muted,
                fontSize: 9,
                letterSpacing: 1.15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            children: [
              Icon(Icons.location_on_outlined, color: _ink, size: 15),
              SizedBox(width: 4),
              Text(
                'Берёзовка',
                style: TextStyle(
                  color: _ink,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 3),
              Icon(Icons.keyboard_arrow_down, color: _muted, size: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Доброе утро ☀️', style: TextStyle(color: _muted, fontSize: 14)),
        SizedBox(height: 5),
        Text(
          'Куда поедем?',
          style: TextStyle(
            color: _ink,
            fontSize: 29,
            height: 1.1,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.8,
          ),
        ),
      ],
    );
  }

  Widget _buildMap() {
    return SizedBox(
      height: 190,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            const CustomPaint(painter: _TownMapPainter()),
            Positioned(
              left: 15,
              top: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.near_me_rounded, color: _ink, size: 15),
                    SizedBox(width: 6),
                    Text(
                      'Машины рядом',
                      style: TextStyle(
                        color: _ink,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
              right: 29,
              top: 44,
              child: _MapCar(color: _ink, angle: -0.45),
            ),
            const Positioned(
              left: 85,
              bottom: 39,
              child: _MapCar(color: Color(0xFFD58D5B), angle: 0.55),
            ),
            Positioned(
              left: MediaQuery.sizeOf(context).width * 0.48 - 22,
              top: 74,
              child: Container(
                width: 39,
                height: 39,
                decoration: BoxDecoration(
                  color: _ink,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33203A32),
                      blurRadius: 9,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person_pin_circle_rounded,
                  color: _lime,
                  size: 21,
                ),
              ),
            ),
            const Positioned(
              right: 14,
              bottom: 13,
              child: Text(
                'БЕРЁЗОВКА',
                style: TextStyle(
                  color: Color(0x88627668),
                  fontSize: 9,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 15, 14, 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 21,
            child: Column(
              children: [
                const Icon(Icons.radio_button_checked, color: _ink, size: 16),
                Container(
                  width: 1,
                  height: 21,
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  color: const Color(0xFFDCE2D8),
                ),
                const Icon(
                  Icons.location_on,
                  color: Color(0xFFDA9061),
                  size: 17,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              children: [
                _routeField(
                  controller: _fromController,
                  label: 'ОТКУДА',
                  hint: 'Укажите адрес подачи',
                  textInputAction: TextInputAction.next,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 9),
                  child: Divider(height: 1, color: Color(0xFFF0F1EC)),
                ),
                _routeField(
                  controller: _toController,
                  label: 'КУДА',
                  hint: 'Куда отправимся?',
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Поменять адреса местами',
            onPressed: () {
              final from = _fromController.text;
              _fromController.text = _toController.text;
              _toController.text = from;
            },
            icon: const Icon(Icons.swap_vert_rounded, color: _muted),
          ),
        ],
      ),
    );
  }

  Widget _routeField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required TextInputAction textInputAction,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: _muted,
            fontSize: 9,
            letterSpacing: 1.15,
            fontWeight: FontWeight.w700,
          ),
        ),
        TextField(
          controller: controller,
          textInputAction: textInputAction,
          style: const TextStyle(
            color: _ink,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.only(top: 5),
            border: InputBorder.none,
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xFFADB3AD),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, String trailing) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: _ink,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        Text(
          trailing,
          style: const TextStyle(
            color: Color(0xFF78836F),
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildRideOptions() {
    return Row(
      children: RideType.values
          .map(
            (ride) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: ride == RideType.values.last ? 0 : 9,
                ),
                child: _rideCard(ride),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _rideCard(RideType ride) {
    final selected = ride == _selectedRide;
    return Semantics(
      button: true,
      selected: selected,
      label: '${ride.title}, ${ride.price} рублей',
      child: GestureDetector(
        onTap: () => setState(() => _selectedRide = ride),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.fromLTRB(11, 12, 8, 11),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFEFF4E8) : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected ? _ink : const Color(0xFFEAECE5),
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(ride.icon, color: _ink, size: 22),
              const SizedBox(height: 10),
              Text(
                ride.title,
                style: const TextStyle(
                  color: _ink,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                ride.subtitle,
                style: const TextStyle(color: _muted, fontSize: 9),
              ),
              const SizedBox(height: 8),
              Text(
                '${ride.price} ₽',
                style: const TextStyle(
                  color: _ink,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentRow() {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.payments_outlined, color: _ink, size: 19),
        ),
        const SizedBox(width: 10),
        const Text(
          'Наличными',
          style: TextStyle(
            color: _ink,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        const Text(
          'Оплата водителю',
          style: TextStyle(color: _muted, fontSize: 11),
        ),
      ],
    );
  }

  Widget _buildOrderButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton(
        onPressed: _showDemoConfirmation,
        style: FilledButton.styleFrom(
          backgroundColor: _ink,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Заказать такси',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
              decoration: BoxDecoration(
                color: _lime,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Text(
                '${_selectedRide.price} ₽',
                style: const TextStyle(
                  color: _ink,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocalPromise() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFECEFE5),
        borderRadius: BorderRadius.circular(17),
      ),
      child: const Row(
        children: [
          Icon(Icons.favorite_border_rounded, color: _ink, size: 19),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Свои водители, знакомые места и поездки без сюрпризов.',
              style: TextStyle(color: _ink, fontSize: 12, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapCar extends StatelessWidget {
  const _MapCar({required this.color, required this.angle});

  final Color color;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        width: 29,
        height: 16,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 4)],
        ),
        child: const Icon(
          Icons.local_taxi_rounded,
          color: Colors.white,
          size: 10,
        ),
      ),
    );
  }
}

class _TownMapPainter extends CustomPainter {
  const _TownMapPainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(const Color(0xFFE8EDDF), BlendMode.src);

    final park = Paint()..color = const Color(0xFFDCE8CE);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.7, size.height * 0.42, 86, 62),
        const Radius.circular(18),
      ),
      park,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.1, size.height * 0.68, 48, 34),
        const Radius.circular(12),
      ),
      park,
    );

    final sideRoad = Paint()
      ..color = const Color(0xFFF8F8F0)
      ..strokeWidth = 13
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final mainRoad = Paint()
      ..color = const Color(0xFFFDFCF7)
      ..strokeWidth = 22
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final roads = [
      Path()
        ..moveTo(-15, size.height * 0.75)
        ..cubicTo(
          size.width * 0.28,
          size.height * 0.5,
          size.width * 0.45,
          size.height * 0.92,
          size.width + 20,
          size.height * 0.54,
        ),
      Path()
        ..moveTo(size.width * 0.18, -15)
        ..cubicTo(
          size.width * 0.3,
          size.height * 0.36,
          size.width * 0.1,
          size.height * 0.65,
          size.width * 0.4,
          size.height + 15,
        ),
      Path()
        ..moveTo(size.width * 0.77, -10)
        ..cubicTo(
          size.width * 0.58,
          size.height * 0.36,
          size.width * 0.9,
          size.height * 0.65,
          size.width * 0.67,
          size.height + 10,
        ),
    ];

    for (final road in roads) {
      canvas.drawPath(road, sideRoad);
    }
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.48, size.height + 12)
        ..cubicTo(
          size.width * 0.37,
          size.height * 0.63,
          size.width * 0.7,
          size.height * 0.49,
          size.width * 0.58,
          -12,
        ),
      mainRoad,
    );

    final blockPaint = Paint()..color = const Color(0xFFD9E0D2);
    for (final block in [
      Rect.fromLTWH(size.width * 0.39, 16, 29, 17),
      Rect.fromLTWH(size.width * 0.79, 22, 24, 16),
      Rect.fromLTWH(size.width * 0.32, size.height * 0.72, 24, 17),
      Rect.fromLTWH(size.width * 0.82, size.height * 0.72, 32, 21),
    ]) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(block, const Radius.circular(5)),
        blockPaint,
      );
    }

    final label = TextPainter(
      text: const TextSpan(
        text: 'ЦЕНТР',
        style: TextStyle(
          color: Color(0x77718170),
          fontSize: 8,
          letterSpacing: 1.3,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    label.paint(canvas, Offset(size.width * 0.74, size.height * 0.77));
  }

  @override
  bool shouldRepaint(covariant _TownMapPainter oldDelegate) => false;
}
