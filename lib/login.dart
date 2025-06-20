import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
   //definisi inputan email dan password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

   // Fungsi login
  void login() async {
  String email = emailController.text.trim();
  String password = passwordController.text.trim();

  if (email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Wajib Diisi Semua!')),
    );
    return;
  }

  try {
    // Query ke Firestore untuk mencari pengguna dengan email dan password yang cocok
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get();

    if (result.docs.isNotEmpty) {
      // Login berhasil
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Berhasil!')),
      );
      // Bisa navigate ke home atau simpan status login
    } else {
      // Tidak ditemukan pengguna dengan email dan password tersebut
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email atau Password salah')),
      );
    }
  } catch (e) {
    // Tangani error
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Terjadi kesalahan: $e')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            Text(
              'Selamat Datang di Aplikasi Palcomgas',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.poppins().fontFamily,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Color(0xff5bbbbb),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  //email inputan
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.email, color: Color(0xff5bbbbb)),
                          border: InputBorder.none,
                          hintText: 'Email'),
                    ),
                  ),
                  SizedBox(height: 20),
                  //password inputan
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                          icon: Icon(Icons.lock, color: Color(0xff5bbbbb)),
                          border: InputBorder.none,
                          hintText: 'Password'),
                    ),
                  ),
                  SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text('Lupa Password?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        )),
                  ),
                  //tombol login
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          ),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
