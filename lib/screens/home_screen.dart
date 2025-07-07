import 'package:flutter/material.dart';
import '../models/promo_card.dart';
import '../models/menu_item.dart';
import '../widgets/promo_card.dart';
import '../widgets/menu_item_card.dart';
import 'menu_screen.dart';
import 'dart:math' show cos, sin;

// Model untuk CategoryItem
class CategoryItem {
  final String id;
  final String title;
  final Color color;
  final IconData icon;

  CategoryItem({
    required this.id,
    required this.title,
    required this.color,
    required this.icon,
  });
}

// Widget CategoryButtonList yang diperbaiki
class CategoryButtonList extends StatelessWidget {
  final List<CategoryItem> categories;
  final void Function(String) onCategorySelected;
  final String? selectedCategory;

  const CategoryButtonList({
    Key? key,
    required this.categories,
    required this.onCategorySelected,
    this.selectedCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: categories.map((category) {
          bool isSelected = selectedCategory == category.id;
          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onCategorySelected(category.id),
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? category.color
                          : category.color.withOpacity(0.9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(category.icon, color: Colors.white, size: 18),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            category.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late PageController _pageController;
  int _currentPromoIndex = 0;
  String? _selectedCategory;

  List<PromoCard> promoCards = [];
  List<MenuItem> featuredMenuItems = [];
  List<CategoryItem> categories = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _loadData() {
    // Load promo cards
    promoCards = [
      PromoCard(
        title: 'Promo 20%',
        subtitle: 'Untuk 10 Pembeli Pertama',
        imageUrl: 'images/pecel1.jpg',
        discount: '20%',
      ),
      PromoCard(
        title: 'Promo 15%',
        subtitle: 'Untuk Member Baru',
        imageUrl: 'images/pecel2.jpg',
        discount: '15%',
      ),
      PromoCard(
        title: 'Promo 10%',
        subtitle: 'Pembelian di atas 50rb',
        imageUrl: 'images/pecel1.jpg',
        discount: '10%',
      ),
    ];

    // Load featured menu items
    featuredMenuItems = [
      MenuItem(
        id: '1',
        name: 'Pecel Sembal Tumpang',
        description: 'Pecel Sambel Tumpang, Pecel Nasi Uduk',
        rating: 4.5,
        imageUrl: 'images/pecel2.jpg',
        price: 15000,
        category: 'special',
      ),
      MenuItem(
        id: '2',
        name: 'Pecel Sambel',
        description: 'Pecel tradisional dengan sambel khas',
        rating: 4.5,
        imageUrl: 'images/pecel2.jpg',
        price: 12000,
        category: 'special',
      ),
      MenuItem(
        id: '3',
        name: 'Pecel Komplit',
        description: 'Pecel lengkap dengan lauk pauk',
        rating: 4.8,
        imageUrl: 'images/pecel1.jpg',
        price: 18000,
        category: 'popular',
      ),
    ];

    // Load categories
    categories = [
      CategoryItem(
        id: 'special',
        title: 'Menu Spesial',
        color: Colors.green,
        icon: Icons.star,
      ),
      CategoryItem(
        id: 'popular',
        title: 'Menu Terlaris',
        color: Colors.red,
        icon: Icons.local_fire_department,
      ),
      CategoryItem(
        id: 'drink',
        title: 'Minuman',
        color: Colors.blue,
        icon: Icons.local_drink,
      ),
    ];
  }

  void _onCategorySelected(String categoryId) {
    setState(() {
      _selectedCategory = categoryId;
    });

    // Navigate to menu screen with selected category
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MenuScreen(selectedCategory: categoryId),
      ),
    );
  }

  void _addToCart(MenuItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.name} ditambahkan ke keranjang'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Pecel Mbok Darmi',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.black87,
            ),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header dengan promo cards menggunakan PageView
            _buildPromoSection(),

            // Menu kategori dengan ListView horizontal
            CategoryButtonList(
              categories: categories,
              onCategorySelected: _onCategorySelected,
              selectedCategory: _selectedCategory,
            ),

            // Menu Pilihan header
            _buildMenuHeader(),

            // Menu items dengan ListView vertikal
            _buildMenuItems(),

            // Space for bottom navigation
            const SizedBox(height: 100),
          ],
        ),
      ),
      // Custom Bottom Navigation dengan floating menu button
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildPromoSection() {
    return Container(
      height: 200,
      margin: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 8),
      child: promoCards.isEmpty
          ? Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.zero,
              ),
              child: Center(
                child: Text(
                  'Tidak ada promo tersedia',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: promoCards.asMap().entries.map((entry) {
                  int index = entry.key;
                  var promo = entry.value;

                  return Container(
                    width: index == 0
                        ? MediaQuery.of(context).size.width * 0.7
                        : MediaQuery.of(context).size.width * 0.5,
                    margin: EdgeInsets.only(
                      right: index == promoCards.length - 1 ? 0 : 8,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        print('Promo ${promo.title} tapped');
                        _showPromoDetail(promo);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.zero,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.zero,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(promo.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                ),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Discount badge
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: index == 0 ? 10 : 8,
                                          vertical: index == 0 ? 4 : 3,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.zero,
                                        ),
                                        child: Text(
                                          promo.discount,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: index == 0 ? 12 : 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  // Title dan subtitle
                                  Text(
                                    promo.title,
                                    style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: index == 0 ? 22 : 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    promo.subtitle,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: index == 0 ? 14 : 11,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }

  Widget _buildMenuHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Menu Pilihan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuScreen()),
                );
              },
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: const Text(
                  'Lihat Semua',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: featuredMenuItems.isEmpty
          ? Container(
              height: 200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.restaurant_menu,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Tidak ada menu tersedia',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: featuredMenuItems.length,
              itemBuilder: (context, index) {
                final item = featuredMenuItems[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: MenuItemCard(
                    menuItem: item,
                    onTap: () {
                      _showMenuDetail(item);
                    },
                    onAddToCart: () => _addToCart(item),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 80,
      child: Stack(
        children: [
          // Background untuk bottom navigation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Home Button
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _currentIndex = 0;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home,
                                color: _currentIndex == 0
                                    ? Colors.orange
                                    : Colors.grey,
                                size: 24,
                              ),
                              const SizedBox(height: 0),
                              Text(
                                'Home',
                                style: TextStyle(
                                  color: _currentIndex == 0
                                      ? Colors.orange
                                      : Colors.grey,
                                  fontSize: 12,
                                  fontWeight: _currentIndex == 0
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Space untuk menu button
                  const SizedBox(width: 80),

                  // Cart Button
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _currentIndex = 2;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  Icon(
                                    Icons.shopping_cart,
                                    color: _currentIndex == 2
                                        ? Colors.orange
                                        : Colors.grey,
                                    size: 24,
                                  ),
                                  // Badge untuk jumlah item di keranjang
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      constraints: const BoxConstraints(
                                        minWidth: 12,
                                        minHeight: 12,
                                      ),
                                      child: const Text(
                                        '0',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 0),
                              Text(
                                'Keranjang',
                                style: TextStyle(
                                  color: _currentIndex == 2
                                      ? Colors.orange
                                      : Colors.grey,
                                  fontSize: 12,
                                  fontWeight: _currentIndex == 2
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Floating Menu Button dengan bentuk Hexagon
          Positioned(
            top: 0,
            left: MediaQuery.of(context).size.width / 2 - 40,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MenuScreen()),
                  );
                },
                customBorder: const CircleBorder(),
                child: Container(
                  width: 80,
                  height: 80,
                  child: ClipPath(
                    clipper: HexagonClipper(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange[400],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.restaurant_menu,
                            color: Colors.white,
                            size: 24,
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Menu',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMenuDetail(MenuItem menuItem) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 20),
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Menu image
              Container(
                height: 200,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(menuItem.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Menu details
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          menuItem.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              menuItem.rating.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          menuItem.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Harga: ${menuItem.formattedPrice}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[600],
                          ),
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _addToCart(menuItem);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                            ),
                            child: const Text(
                              'Tambah ke Keranjang',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPromoDetail(PromoCard promo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(promo.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(promo.subtitle),
            const SizedBox(height: 8),
            Text('Diskon: ${promo.discount}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
}

// Improved Hexagon Clipper - disesuaikan dengan bentuk di gambar
class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    double width = size.width;
    double height = size.height;

    // Membuat bentuk hexagon yang lebih sesuai dengan gambar
    double centerX = width / 2;
    double centerY = height / 2;
    double radius = width * 0.4;

    // Titik hexagon dimulai dari atas
    List<Offset> points = [];
    for (int i = 0; i < 6; i++) {
      double angle = (i * 60 - 90) * (3.14159 / 180); // -90 untuk mulai dari atas
      double x = centerX + radius * cos(angle);
      double y = centerY + radius * sin(angle);
      points.add(Offset(x, y));
    }

    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Keep the old CustomPolygonClipper for backward compatibility
class CustomPolygonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    double width = size.width;
    double height = size.height;

    // Start from left middle
    path.moveTo(0, height * 0.5);
    // Top left
    path.lineTo(width * 0.15, height * 0.1);
    // Top right
    path.lineTo(width * 0.85, height * 0.1);
    // Right middle
    path.lineTo(width, height * 0.5);
    // Bottom right
    path.lineTo(width * 0.85, height * 0.9);
    // Bottom left
    path.lineTo(width * 0.15, height * 0.9);
    // Close the path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Import yang diperlukan untuk cos function
