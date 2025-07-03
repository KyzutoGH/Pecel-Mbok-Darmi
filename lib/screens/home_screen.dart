import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../models/promo_card.dart';
import '../models/menu_item.dart';
import '../widgets/promo_card.dart';
import '../widgets/menu_item_card.dart';
import '../widgets/category_button.dart';
import 'menu_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final CardSwiperController _cardController = CardSwiperController();

  List<PromoCard> promoCards = [];
  List<MenuItem> featuredMenuItems = [];
  List<CategoryItem> categories = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    // Load promo cards
    promoCards = [
      PromoCard(
        title: 'Promo 20%',
        subtitle: 'Untuk 10 Pembeli Pertama',
        imageUrl: 'assets/images/food1.jpg',
        discount: '20%',
      ),
      PromoCard(
        title: 'Promo 30%',
        subtitle: 'Untuk 5 Pembeli Pertama',
        imageUrl: 'assets/images/food2.jpg',
        discount: '30%',
      ),
      PromoCard(
        title: 'Buy 1 Get 1',
        subtitle: 'Khusus Minuman Hari Ini',
        imageUrl: 'assets/images/food3.jpg',
        discount: 'BOGO',
      ),
    ];

    // Load featured menu items
    featuredMenuItems = [
      MenuItem(
        id: '1',
        name: 'Pecel Sembal Tumpang',
        description: 'Pecel Sambel Tumpang, Pecel Nasi Uduk',
        rating: 4.5,
        imageUrl: 'assets/images/pecel1.jpg',
        price: 15000,
        category: 'special',
      ),
      MenuItem(
        id: '2',
        name: 'Pecel Sambel',
        description: 'Pecel tradisional dengan sambel khas',
        rating: 4.5,
        imageUrl: 'assets/images/pecel2.jpg',
        price: 12000,
        category: 'special',
      ),
      MenuItem(
        id: '3',
        name: 'Gado-Gado Special',
        description: 'Gado-gado dengan bumbu kacang spesial',
        rating: 4.3,
        imageUrl: 'assets/images/gado.jpg',
        price: 13000,
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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: Row(
          children: [
            Icon(Icons.refresh, color: Colors.black),
            SizedBox(width: 8),
            Text(
              'localhost:58304/#',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.star_border, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shield_outlined, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person_outline, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header dengan Stack untuk promo cards
            Container(
              height: 220,
              child: Stack(
                children: [
                  // Promo Cards dengan CardSwiper
                  Container(
                    height: 180,
                    margin: EdgeInsets.all(16),
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
                        : CardSwiper(
                            controller: _cardController,
                            cardsCount: promoCards.length,
                            onSwipe: (previousIndex, currentIndex, direction) {
                              return true;
                            },
                            cardBuilder:
                                (
                                  context,
                                  index,
                                  percentThresholdX,
                                  percentThresholdY,
                                ) {
                                  return PromoCardWidget(
                                    promoCard: promoCards[index],
                                    onTap: () {
                                      // Handle promo card tap
                                      print(
                                        'Promo ${promoCards[index].title} tapped',
                                      );
                                    },
                                  );
                                },
                          ),
                  ),

                  // Keterangan penggunaan Stack
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Gunakan penyusunan secara Stack dibagian ini',
                        style: TextStyle(color: Colors.white, fontSize: 10),
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

            // Keterangan ListView
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Gunakan ListView dan bisa di scroll ke kanan-kiri',
                style: TextStyle(color: Colors.red.shade800, fontSize: 12),
              ),
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

            // Menu items dengan SingleChildScrollView
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
                  : Column(
                      children: featuredMenuItems
                          .map(
                            (item) => MenuItemCard(
                              menuItem: item,
                              onTap: () {
                                _showMenuDetail(item);
                              },
                              onAddToCart: () => _addToCart(item),
                            ),
                          )
                          .toList(),
                    ),
            ),

            // Keterangan SingleChildScrollView
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Gunakan SingleChildScrollView kebawah',
                style: TextStyle(color: Colors.blue.shade800, fontSize: 12),
              ),
            ),

            // FlutterClipPolygon section
            Container(
              margin: EdgeInsets.all(16),
              height: 100,
              child: ClipPath(
                clipper: CustomPolygonClipper(),
                child: Container(
                  color: Colors.orange,
                  child: Center(
                    child: Text(
                      'FlutterClipPolygon',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 100), // Space for bottom navigation
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MenuScreen()),
            );
          }
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _currentIndex == 1 ? Colors.yellow : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.restaurant_menu,
                color: _currentIndex == 1 ? Colors.black : Colors.grey,
              ),
            ),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
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

// Custom Polygon Clipper for FlutterClipPolygon
class CustomPolygonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, size.height * 0.3);
    path.lineTo(size.width * 0.3, 0);
    path.lineTo(size.width * 0.7, 0);
    path.lineTo(size.width, size.height * 0.3);
    path.lineTo(size.width, size.height * 0.7);
    path.lineTo(size.width * 0.7, size.height);
    path.lineTo(size.width * 0.3, size.height);
    path.lineTo(0, size.height * 0.7);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
