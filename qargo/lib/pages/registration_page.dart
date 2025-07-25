import 'package:flutter/material.dart';
import 'user_repository.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

enum UserType { shipper }

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _companyAddressController =
      TextEditingController();
  final TextEditingController _licenseController = TextEditingController();
  final TextEditingController _truckTypeController = TextEditingController();
  String? _selectedTruckType;
  bool _agreedToTerms = false;
  UserType _userType = UserType.shipper;

  final List<String> _truckTypes = ['Flatbed'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAFA),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 12),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xFF1CC6AE),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Back',
                      style: TextStyle(
                        color: Color(0xFF1CC6AE),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Image.asset('assets/images/logo.png', width: 90, height: 90),
                const SizedBox(height: 16),
                Text(
                  'Create Your Qargo Account',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1CC6AE),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  'Sign up to book trucks and manage your shipments easily.',
                  style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 22),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(
                    vertical: 32,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 18,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 4),
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: Color(0xFF1CC6AE),
                          ),
                          hintText: 'Full Name',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _companyNameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.business_outlined,
                            color: Color(0xFF1CC6AE),
                          ),
                          hintText: 'Company Name (optional)',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _companyAddressController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.location_on_outlined,
                            color: Color(0xFF1CC6AE),
                          ),
                          hintText: 'Company Address (optional)',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Color(0xFF1CC6AE),
                          ),
                          hintText: 'Email',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone_outlined,
                            color: Color(0xFF1CC6AE),
                          ),
                          hintText: 'Phone',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Color(0xFF1CC6AE),
                          ),
                          hintText: 'Password',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Color(0xFF1CC6AE),
                          ),
                          hintText: 'Confirm Password',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: Color(0xFF1CC6AE),
                          ),
                          hintText: 'Full Name',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Color(0xFF1CC6AE),
                          ),
                          hintText: 'Email',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone_outlined,
                            color: Color(0xFF1CC6AE),
                          ),
                          hintText: 'Phone',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Color(0xFF1CC6AE),
                          ),
                          hintText: 'Password',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Color(0xFF1CC6AE),
                          ),
                          hintText: 'Confirm Password',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      if (_userType == UserType.shipper) ...[
                        const SizedBox(height: 16),
                        TextField(
                          controller: _companyNameController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.business_outlined,
                              color: Color(0xFF1CC6AE),
                            ),
                            hintText: 'Company Name',
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _companyAddressController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.location_on_outlined,
                              color: Color(0xFF1CC6AE),
                            ),
                            hintText: 'Company Address',
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ],
                      if (_userType == UserType.shipper) ...[
                        const SizedBox(height: 16),
                        TextField(
                          controller: _licenseController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.badge_outlined,
                              color: Color(0xFF1CC6AE),
                            ),
                            hintText: 'License Number',
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _selectedTruckType,
                          items: _truckTypes
                              .map(
                                (type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(type),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedTruckType = value;
                            });
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.local_shipping_outlined,
                              color: Color(0xFF1CC6AE),
                            ),
                            hintText: 'Truck Type',
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(
                              Icons.file_upload_outlined,
                              color: Color(0xFF1CC6AE),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Upload Insurance Document (placeholder)',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                final name = _nameController.text.trim();
                                final email = _emailController.text.trim();
                                final password = _passwordController.text
                                    .trim();
                                final phone = _phoneController.text.trim();
                                final success = UserRepository.instance
                                    .register(name, email, password, phone);
                                if (success) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Registration successful! Please log in.',
                                      ),
                                    ),
                                  );
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/login',
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Email already registered.',
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                'Choose File',
                                style: TextStyle(color: Color(0xFF1CC6AE)),
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Checkbox(
                            value: _agreedToTerms,
                            activeColor: Color(0xFF1CC6AE),
                            onChanged: (value) {
                              setState(() {
                                _agreedToTerms = value ?? false;
                              });
                            },
                          ),
                          Expanded(
                            child: Text(
                              'I agree to the Terms & Conditions',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1CC6AE),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: _agreedToTerms ? () {} : null,
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
