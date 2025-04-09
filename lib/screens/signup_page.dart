import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/fireworks.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> with SingleTickerProviderStateMixin {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  String? _passwordError;
  String? _nameError;
  String? _emailError;
  String? _phoneError;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late AnimationController _fadeInController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _fadeInController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeInController, curve: Curves.easeIn),
    );
    _fadeInController.forward();
  }

  void _handleSignup() async {
    setState(() {
      _passwordError = null;
      _nameError = null;
      _emailError = null;
      _phoneError = null;
    });

    bool isValid = true;

    if (_nameController.text.isEmpty) {
      setState(() {
        _nameError = 'Please enter your name.';
      });
      isValid = false;
    }

    if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
      setState(() {
        _emailError = 'Please enter a valid email.';
      });
      isValid = false;
    }

    if (_phoneController.text.isEmpty || _phoneController.text.length != 11 || !_phoneController.text.startsWith('0')) {
      setState(() {
        _phoneError = 'Please enter a valid phone number (11 digits, starting with 0).';
      });
      isValid = false;
    }

    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = 'Please enter a password.';
      });
      isValid = false;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _passwordError = 'Passwords do not match!';
      });
      isValid = false;
    }

    if (isValid) {
      // Check for duplicate email or phone number
      bool emailExists = await _checkForDuplicateEmail(_emailController.text);
      bool phoneExists = await _checkForDuplicatePhone(_phoneController.text);

      if (emailExists) {
        setState(() {
          _emailError = 'Email is already registered.';
        });
        return;
      }

      if (phoneExists) {
        setState(() {
          _phoneError = 'Phone number is already registered.';
        });
        return;
      }

      // Proceed with creating user
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text, // Password securely handled by Firebase
        );

        // Store user data in Firestore (without password)
        await _firestore.collection('users').doc(userCredential.user?.uid).set({
          'name': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
           'type': 'user',
        });

        // Navigate to FireworksPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FireworksPage()),
        );
      } catch (e) {
        print('Error during sign-up: $e');
      }
    }
  }

  Future<bool> _checkForDuplicateEmail(String email) async {
    QuerySnapshot result = await _firestore.collection('users').where('email', isEqualTo: email).get();
    return result.docs.isNotEmpty;
  }

  Future<bool> _checkForDuplicatePhone(String phone) async {
    QuerySnapshot result = await _firestore.collection('users').where('phone', isEqualTo: phone).get();
    return result.docs.isNotEmpty;
  }

  @override
  void dispose() {
    _fadeInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: -120,
              child: Opacity(
                opacity: 0.08,
                child:Icon(Icons.delete_outline, size: 210),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    const Text(
                      'Welcome!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,  // Make text black
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'We are here to help you through\nkeeping our environment clean!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,  // Make text black
                      ),
                    ),
                    const SizedBox(height: 60),
                    FadeTransition(
                      opacity: _fadeInAnimation,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Full Name',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            const SizedBox(height: 8),
                            _buildTextField(
                              controller: _nameController,
                              hintText: 'Enter your name here.....',
                              errorText: _nameError,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Email',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            const SizedBox(height: 8),
                            _buildTextField(
                              controller: _emailController,
                              hintText: 'Enter your email here...',
                              keyboardType: TextInputType.emailAddress,
                              errorText: _emailError,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Phone Number',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            const SizedBox(height: 8),
                            _buildTextField(
                              controller: _phoneController,
                              hintText: 'Enter your phone number here...',
                              keyboardType: TextInputType.phone,
                              errorText: _phoneError,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Password',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            const SizedBox(height: 8),
                            _buildPasswordField(
                              controller: _passwordController,
                              hintText: 'Enter your password here...',
                              errorText: _passwordError,
                              isVisible: _passwordVisible,
                              toggleVisibility: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Confirm Password',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            const SizedBox(height: 8),
                            _buildPasswordField(
                              controller: _confirmPasswordController,
                              hintText: 'Confirm your password...',
                              errorText: _passwordError,
                              isVisible: _confirmPasswordVisible,
                              toggleVisibility: () {
                                setState(() {
                                  _confirmPasswordVisible = !_confirmPasswordVisible;
                                });
                              },
                            ),
                            const SizedBox(height: 28),
                            Center(
                              child: ElevatedButton(
                                onPressed: _handleSignup,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,  // Button background color black
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 14),
                                ),
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context); // Go back
                                },
                                child: const Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,  // Make text black
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    String? errorText,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 12,
        ),
        errorText: errorText,
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    String? errorText,
    required bool isVisible,
    required VoidCallback toggleVisibility,
  }) {
    return TextField(
      controller: controller,
      obscureText: !isVisible,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 12,
        ),
        errorText: errorText,
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.black54,
          ),
          onPressed: toggleVisibility,
        ),
      ),
    );
  }
}
