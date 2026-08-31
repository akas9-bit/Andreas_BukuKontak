import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buku Kontak',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Menggunakan Named Routes
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/tambah': (context) => const TambahKontakPage(),
        '/tentang': (context) => const TentangPage(),
      },
    );
  }
}

// ---------------------------------------------------
// HALAMAN UTAMA (Beranda dengan TabBar & Drawer)
// ---------------------------------------------------
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Daftar kontak awal (Contoh data)
  List<Map<String, String>> kontakList = [
    {
      'nama': 'Annisa Kusumastuti',
      'email': 'nisa@gmail.com',
      'hp': '0895421903057',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BUKU KONTAK'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.account_circle), text: 'Kontak'),
              Tab(icon: Icon(Icons.star), text: 'Favorit'),
            ],
          ),
        ),
        // NAVIGATION DRAWER
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  'BUKU KONTAK',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.contacts),
                title: const Text('Kontak'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Tambah Kontak'),
                onTap: () async {
                  Navigator.pop(context);
                  final result = await Navigator.pushNamed(context, '/tambah');
                  if (result != null && result is Map<String, String>) {
                    setState(() {
                      kontakList.add(result);
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.star),
                title: const Text('Favorit'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Tentang'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/tentang');
                },
              ),
            ],
          ),
        ),
        // TAB BAR VIEW
        body: TabBarView(
          children: [
            // Tab 1: Daftar Kontak
            kontakList.isEmpty
                ? const Center(child: Text('Belum ada kontak'))
                : ListView.builder(
                    itemCount: kontakList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(kontakList[index]['nama']!),
                        subtitle: Text(
                          '${kontakList[index]['email']}\n${kontakList[index]['hp']}',
                        ),
                      );
                    },
                  ),
            // Tab 2: Favorit
            const Center(
              child: Text('Belum ada kontak favorit'),
            ),
          ],
        ),
        // FLOATING ACTION BUTTON
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.pushNamed(context, '/tambah');
            if (result != null && result is Map<String, String>) {
              setState(() {
                kontakList.add(result);
              });
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

// ---------------------------------------------------
// HALAMAN TAMBAH KONTAK
// ---------------------------------------------------
class TambahKontakPage extends StatefulWidget {
  const TambahKontakPage({super.key});

  @override
  State<TambahKontakPage> createState() => _TambahKontakPageState();
}

class _TambahKontakPageState extends State<TambahKontakPage> {
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _hpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Kontak'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _namaController,
              decoration: const InputDecoration(labelText: 'Nama Lengkap'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _hpController,
              decoration: const InputDecoration(labelText: 'No Handphone'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Mengirim data kembali ke HomePage
                Navigator.pop(context, {
                  'nama': _namaController.text,
                  'email': _emailController.text,
                  'hp': _hpController.text,
                });
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------
// HALAMAN TENTANG (Profil Diri)
// ---------------------------------------------------
class TentangPage extends StatelessWidget {
  const TentangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            // Placeholder Foto Menggunakan AssetImage
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.orange,
              backgroundImage: AssetImage('assets/foto_profil.png'),
            ),
            SizedBox(height: 20),
            Text(
              'Andreas Dwi Prakasa',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text('XII RPL B'),
            SizedBox(height: 5),
            Text('SMK Negeri 5 Surakarta'),
          ],
        ),
      ),
    );
  }
}