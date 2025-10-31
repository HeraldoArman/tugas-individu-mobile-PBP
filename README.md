# Tugas 7: Elemen Dasar Flutter

**Nama:** Heraldo Arman  
**NPM:** 2406420702  
**Kelas:** PBP - E  
**Link Penugasan:** [Tugas 7](https://pbp-fasilkom-ui.github.io/ganjil-2026/assignments/individual/assignment-7)

---

## 1. Apa itu _widget tree_ pada Flutter dan bagaimana hubungan _parent–child_ (induk–anak) bekerja antar widget?

![widgetTree](https://miro.medium.com/v2/resize:fit:640/format:webp/0*ReZqQfTircHLUHQi.png)

Sumber: [medium](https://medium.com/@mca.saboor/flutter-widget-and-widget-tree-3585a9f94d7a)

_Widget tree_ adalah susunan atau struktur dari semua widget yang ada di dalam aplikasi flutter. Bisa dibilang ini semacam pohon yang menunjukkan siapa yang ada di dalam siapa.
Di flutter, hampir semua hal adalah widget seperti teks, tombol, ikon, layout, dan yang lainnya. Widget widget ini saling berhubungan tersusun dari atas ke bawah. Widget yang di atas disebut parent dan di dalamnya disebut child. Hubungan ini menentukan bagaimana tampilan dan perilaku elemen-elemen di layar dibentuk.

---

## 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.

1. **`MaterialApp`**
   Menjadi dasar dari aplikasi Flutter yang memakai gaya dan aturan desain _Material Design_.
   Menyediakan tema, warna, dan mengatur halaman awal aplikasi.

2. **`Scaffold`**
   Menyediakan struktur dasar untuk setiap halaman, seperti tempat untuk `AppBar`, `Body`, dan lainnya .
   Bisa dibilang ini adalah kerangka utama tampilan aplikasi.

3. **`AppBar`**
   Bagian atas halaman yang menampilkan judul aplikasi (dalam kasus ini adalah “Pacil Station”).
   Biasanya berisi nama halaman, ikon, atau tombol menu.

4. **`Padding`**
   Memberi jarak di sekitar konten agar tampilan tidak terlalu menempel di tepi layar.

5. **`Column`**
   Menyusun widget secara vertikal (dari atas ke bawah).
   Dalam proyek ini digunakan untuk menata bagian-bagian tampilan agar rapi.

6. **`Center`**
   Meletakkan widget di tengah layar.

7. **`GridView.count`**
   Menampilkan beberapa elemen dalam bentuk grid (seperti kotak-kotak).
   Digunakan untuk menampilkan tiga tombol: _All Products_, _My Products_, dan _Create Product_.

8. **`Material`**
   Memberikan efek _Material Design_ seperti bayangan dan warna latar pada tombol (card).

9. **`InkWell`**
   Membuat area yang bisa ditekan (klik).
   Digunakan agar tombol menampilkan _SnackBar_ ketika ditekan.

10. **`SnackBar`**
    Pesan kecil yang muncul di bagian bawah layar ketika tombol ditekan.
    Misalnya, menampilkan teks seperti “Kamu telah menekan tombol All Products!”.

11. **`Icon`**
    Menampilkan ikon pada setiap tombol.

12. **`Text`**
    Menampilkan tulisan seperti nama tombol dan judul aplikasi.

13. **`SizedBox`**
    Memberi jarak atau ruang kosong antar elemen agar tata letak lebih rapi.

14. **`Card`**
    Memberikan tampilan seperti kartu dengan bayangan dan tepi melengkung.

---

## 3. Apa fungsi dari widget `MaterialApp`? Jelaskan mengapa widget ini sering digunakan sebagai _root widget_.

`MaterialApp` adalah widget utama yang digunakan untuk memulai aplikasi flutter dengan gaya **Material Design** dari Google.
Widget ini biasanya menjadi **root widget** (widget paling atas) dari aplikasi karena dia mengatur banyak hal penting yang dibutuhkan oleh aplikasi.

Beberapa fungsi penting `MaterialApp`:

1. **Menentukan halaman utama aplikasi** dengan properti `home`. Misalnya, `home: MyHomePage()` akan menampilkan halaman tersebut pertama kali.
2. **Mengatur tema dan warna aplikasi** seperti warna utama (primary color), font, atau gaya tombol.
3. **Menentukan judul aplikasi** melalui properti `title`.
4. **Mengaktifkan fitur Material Design**, seperti _AppBar_, _SnackBar_, _Drawer_, dan _FloatingActionButton_ agar tampil dengan gaya khas Android.

Karena `MaterialApp` menyediakan semua pengaturan dasar ini, maka widget ini hampir selalu ditempatkan di bagian paling luar dari aplikasi Flutter sebelum semua widget lainnya.
Tanpa `MaterialApp`, beberapa widget khas Material seperti `Scaffold` atau `SnackBar` tidak bisa berfungsi dengan baik.

---

## 4. Jelaskan perbedaan antara `StatelessWidget` dan `StatefulWidget`. Kapan kamu memilih salah satunya?

di flutter, semua tampilan dibuat dari widget. Ada dua jenis utama widget berdasarkan apakah tampilannya bisa berubah atau tidak, yaitu `StatelessWidget` dan `StatefulWidget`.

### `StatelessWidget`

`StatelessWidget` adalah widget yang **tidak memiliki perubahan tampilan** setelah dibuat.
Artinya, semua data dan tampilan di dalamnya **tetap sama** atau **statis** selama aplikasi berjalan.

Contohnya:

- Teks statis
- Tombol dengan aksi sederhana
- Ikon atau gambar yang tidak berubah

### `StatefulWidget`

`StatefulWidget` adalah widget yang **bisa berubah tampilannya** saat aplikasi berjalan.
Widget ini memiliki _state_ (keadaan) yang bisa diubah dengan memanggil `setState()`.

Contohnya:

- Tombol yang warnanya berubah saat ditekan
- Counter yang bertambah saat diklik
- Form input yang menampilkan teks yang diketik pengguna

### Kapan digunakan?

- Gunakan **`StatelessWidget`** jika tampilan kamu tidak perlu berubah (sederhana dan statis).
- Gunakan **`StatefulWidget`** jika kamu butuh interaksi atau perubahan data yang akan mengubah tampilan di layar.

---

## 5. Apa itu `BuildContext` dan mengapa penting di Flutter? Bagaimana penggunaannya di metode `build()`?

`BuildContext` adalah objek yang menyimpan informasi tentang posisi sebuah widget di dalam _widget tree_.
Dengan kata lain, `BuildContext` membantu Flutter mengetahui di mana letak suatu widget berada dan apa saja yang bisa diakses oleh widget itu. misalnya tema, warna, atau _parent widget_-nya.

Setiap kali Flutter memanggil metode `build()`, ia akan memberikan `BuildContext` agar widget bisa tahu konteks tempatnya berada di dalam aplikasi.

`BuildContext` sangat penting karena:

1. Digunakan untuk mengakses tema dan warna aplikasi dengan `Theme.of(context)`.
   Contohnya di kode yang sudah dibuat sebelumnya:
   ```dart
   backgroundColor: Theme.of(context).colorScheme.primary,
   ```
   Di sini, `context` membantu mengambil warna utama dari tema aplikasi.
2. Dipakai untuk menampilkan widget lain seperti `SnackBar` atau dialog.
   ```dart
   ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(content: Text("Kamu telah menekan tombol All Products!")),
   );
   ```
   Tanpa `context`, Flutter tidak tahu di mana harus menampilkan `SnackBar` tersebut. Dalam kasus ini Snackbar ditampilkan di dalam scaffold
3. Membantu **navigasi antar halaman** dengan `Navigator.of(context)`.

---

## 6. Jelaskan konsep _hot reload_ di Flutter dan bagaimana bedanya dengan _hot restart_.

**_Hot reload_** adalah fitur di Flutter yang memungkinkan kita melihat hasil perubahan kode secara langsung tanpa perlu menghentikan aplikasi.
Saat kita menekan _hot reload_, Flutter akan:

- Menyimpan dan memperbarui kode yang diubah,
- Menjalankan ulang fungsi `build()` pada widget yang terpengaruh,
- Tidak menghapus data atau state yang sedang berjalan.

**_Hot Restart_** adalah dimana kita memulai ulang seluruh aplikasi
Flutter akan membangun ulang semua widget dari nol dan menghapus semua state atau data yang sebelumnya disimpan.

| Fitur           | Apa yang dilakukan             | State aplikasi  | Kapan digunakan                                |
| --------------- | ------------------------------ | --------------- | ---------------------------------------------- |
| **Hot Reload**  | Memperbarui kode yang berubah  | Tetap tersimpan | Saat mengubah tampilan/UI                      |
| **Hot Restart** | Memulai ulang seluruh aplikasi | Hilang/reset    | Saat mengubah struktur atau data awal aplikasi |

---

## Lampiran Screenshot Project

![main page](image/main_page.png)
