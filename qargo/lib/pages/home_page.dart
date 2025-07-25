import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _heroController;
  late AnimationController _featuresController;
  late AnimationController _statsController;

  @override
  void initState() {
    super.initState();
    _heroController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _featuresController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _statsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    
    _heroController.forward();
    Future.delayed(const Duration(milliseconds: 200), () => _featuresController.forward());
    Future.delayed(const Duration(milliseconds: 400), () => _statsController.forward());
  }

  @override
  void dispose() {
    _heroController.dispose();
    _featuresController.dispose();
    _statsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Enhanced Hero Section
            _buildHeroSection(),
            
            // Statistics Section
            _buildStatsSection(),
            
            // Services Section
            _buildServicesSection(),
            
            // How It Works Section
            _buildHowItWorksSection(),
            
            // Call to Action Section
            _buildCallToActionSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1CC6AE),
            Color(0xFF16A085),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/images/truck2.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(),
              ),
            ),
          ),
          // Navigation
          Positioned(
            top: 50,
            right: 20,
            child: Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF1CC6AE),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                  child: const Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          // Hero content
          FadeTransition(
            opacity: _heroController,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 100,
                      height: 100,
                      errorBuilder: (context, error, stackTrace) => 
                        const Icon(Icons.local_shipping, size: 100, color: Colors.white),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Kenya\'s Leading\nLogistics Platform',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Fast, reliable, and affordable truck booking\nfor all your shipping needs across Kenya',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF1CC6AE),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        elevation: 8,
                      ),
                      onPressed: () => Navigator.pushNamed(context, '/register'),
                      child: const Text(
                        'Start Shipping Today',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return FadeTransition(
      opacity: _statsController,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
        color: Colors.grey[50],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStatCard('1000+', 'Happy Clients'),
            _buildStatCard('5000+', 'Deliveries'),
            _buildStatCard('24/7', 'Support'),
            _buildStatCard('99%', 'On-Time'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1CC6AE),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildServicesSection() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _featuresController,
        curve: Curves.easeOut,
      )),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
        child: Column(
          children: [
            const Text(
              'Why Choose Qargo?',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Experience the future of logistics with our comprehensive platform',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.1,
              children: [
                _buildServiceCard(
                  Icons.flash_on,
                  'Instant Booking',
                  'Book trucks in seconds with our smart matching system',
                ),
                _buildServiceCard(
                  Icons.security,
                  'Secure & Insured',
                  'Your cargo is fully protected with comprehensive insurance',
                ),
                _buildServiceCard(
                  Icons.gps_fixed,
                  'Real-Time Tracking',
                  'Track your shipments live with GPS-enabled monitoring',
                ),
                _buildServiceCard(
                  Icons.payment,
                  'Flexible Payment',
                  'Pay via M-Pesa, bank transfer, or cash on delivery',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(IconData icon, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1CC6AE).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 32,
              color: const Color(0xFF1CC6AE),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHowItWorksSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: Colors.grey[50],
      child: Column(
        children: [
          const Text(
            'How It Works',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 50),
          Row(
            children: [
              Expanded(
                child: _buildStepCard(
                  '1',
                  'Request',
                  'Tell us what you need to ship and where',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildStepCard(
                  '2',
                  'Match',
                  'We find the perfect truck for your needs',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildStepCard(
                  '3',
                  'Track & Pay',
                  'Monitor delivery and pay securely',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepCard(String step, String title, String description) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            color: Color(0xFF1CC6AE),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              step,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCallToActionSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1CC6AE),
            Color(0xFF16A085),
          ],
        ),
      ),
      child: Column(
        children: [
          const Text(
            'Ready to Ship?',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Join thousands of satisfied customers\nwho trust Qargo for their logistics needs',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF1CC6AE),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 8,
                ),
                onPressed: () => Navigator.pushNamed(context, '/register'),
                child: const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 20),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white, width: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () => Navigator.pushNamed(context, '/login'),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
