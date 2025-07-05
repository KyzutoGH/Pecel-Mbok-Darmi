import 'package:flutter/material.dart';
import '../models/promo_card.dart';
import '../models/menu_item.dart';
import '../widgets/promo_card.dart';
import '../widgets/menu_item_card.dart';
import 'menu_screen.dart';

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

// Widget CategoryButtonList
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
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: categories.map((category) {
          bool isSelected = selectedCategory == category.id;
          return Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: GestureDetector(
                onTap: () => onCategorySelected(category.id),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? category.color.withOpacity(0.9)
                        : category.color,
                    borderRadius: BorderRadius.circular(12),
                    border: isSelected
                        ? Border.all(color: Colors.white, width: 2)
                        : null,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                          isSelected ? 0.15 : 0.1,
                        ),
                        blurRadius: isSelected ? 6 : 4,
                        offset: Offset(0, isSelected ? 3 : 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        category.icon,
                        color: Colors.white,
                        size: isSelected ? 20 : 18,
                      ),
                      SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          category.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isSelected ? 13 : 12,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w600,
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
          );
        }).toList(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  PageController _pageController = PageController();
  int _currentPromoIndex = 0;

  List<PromoCard> promoCards = [];
  List<MenuItem> featuredMenuItems = [];
  List<CategoryItem> categories = [];

  @override
  void initState() {
    super.initState();
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
        title: 'Promo 25%',
        subtitle: 'Menu Spesial Hari Ini',
        imageUrl: 'images/pecel3.jpg',
        discount: '25%',
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
        title: 'Menu Terfaris',
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MenuScreen()),
    );
  }

  void _addToCart(MenuItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.name} ditambahkan ke keranjang'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Pecel Mbok Darmi',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header dengan promo cards menggunakan PageView
            Container(
              height: 200,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: promoCards.isEmpty
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Tidak ada promo tersedia',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  : Stack(
                      children: [
                        // PageView untuk promo cards
                        PageView.builder(
                          controller: _pageController,
                          itemCount: promoCards.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPromoIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              child: PromoCardWidget(
                                promoCard: promoCards[index],
                                onTap: () {
                                  print(
                                    'Promo ${promoCards[index].title} tapped',
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        // Indikator dots
                        Positioned(
                          bottom: 12,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              promoCards.length,
                              (index) => Container(
                                width: 8,
                                height: 8,
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentPromoIndex == index
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),

            // Menu kategori dengan ListView horizontal
            CategoryButtonList(
              categories: categories,
              onCategorySelected: _onCategorySelected,
            ),

            // Menu Pilihan header
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Menu Pilihan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MenuScreen()),
                      );
                    },
                    child: Text(
                      'Lihat Semua',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Menu items dengan ListView vertikal
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
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
                            SizedBox(height: 16),
                            Text(
                              'Tidak ada menu tersedia',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: featuredMenuItems.length,
                      itemBuilder: (context, index) {
                        final item = featuredMenuItems[index];
                        return MenuItemCard(
                          menuItem: item,
                          onTap: () {
                            _showMenuDetail(item);
                          },
                          onAddToCart: () => _addToCart(item),
                        );
                      },
                    ),
            ),

            // Space for bottom navigation
            SizedBox(height: 120),
          ],
        ),
      ),
      // Custom Bottom Navigation dengan floating menu button
      bottomNavigationBar: Container(
        height: 90,
        child: Stack(
          children: [
            // Background untuk bottom navigation
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Home Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentIndex = 0;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home_outlined,
                                color: _currentIndex == 0
                                    ? Colors.orange
                                    : Colors.grey,
                                size: 24,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Home',
                                style: TextStyle(
                                  color: _currentIndex == 0
                                      ? Colors.orange
                                      : Colors.grey,
                                  fontSize: 12,
                                  fontWeight: _currentIndex == 0
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Space untuk menu button
                    SizedBox(width: 100),

                    // Cart Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentIndex = 2;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                color: _currentIndex == 2
                                    ? Colors.orange
                                    : Colors.grey,
                                size: 24,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Keranjang',
                                style: TextStyle(
                                  color: _currentIndex == 2
                                      ? Colors.orange
                                      : Colors.grey,
                                  fontSize: 12,
                                  fontWeight: _currentIndex == 2
                                      ? FontWeight.bold
                                      : FontWeight.normal,
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

            // Floating Menu Button
            Positioned(
              top: 0,
              left: MediaQuery.of(context).size.width / 2 - 35,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MenuScreen()),
                  );
                },
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 60,
                      height: 50,
                      child: ClipPath(
                        clipper: HexagonClipper(),
                        child: Container(
                          color: Colors.yellow[600],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.restaurant_menu,
                                color: Colors.black87,
                                size: 20,
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Menu',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 10,
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
            ),
          ],
        ),
      ),
    );
  }

  void _showMenuDetail(MenuItem menuItem) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 12, bottom: 20),
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
              margin: EdgeInsets.symmetric(horizontal: 20),
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
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      menuItem.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 20),
                        SizedBox(width: 4),
                        Text(
                          menuItem.rating.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      menuItem.description,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Harga: ${menuItem.formattedPrice}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[600],
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _addToCart(menuItem);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
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
          ],
        ),
      ),
    );
  }
}

// Improved Hexagon Clipper
class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    double width = size.width;
    double height = size.height;

    // Create hexagon shape
    path.moveTo(width * 0.2, height * 0.1);
    path.lineTo(width * 0.8, height * 0.1);
    path.lineTo(width * 0.95, height * 0.5);
    path.lineTo(width * 0.8, height * 0.9);
    path.lineTo(width * 0.2, height * 0.9);
    path.lineTo(width * 0.05, height * 0.5);
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
