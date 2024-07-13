class AppConstants {
  static const appName = 'Perpus Unwahas Mobile';
  // static const baseURL = 'http://10.0.2.2:3000/api'; // dev
  // static const imgURL = 'http://10.0.2.2:3000/'; // dev
  static const baseURL = 'https://perpus.zainncoffee.com/api'; // prod
  static const imgURL = 'https://perpus.zainncoffee.com'; // dev
}

class APIURL {
  static const register = '/students';
  static const login = '/students/login';
  static const updatePassword = '/students/forgot-password';

  // <!-- BOOKS -->
  static const getAllBooks = '/books';
  static String filterBook(String query) => '/books/filter/$query';
  static String searchBooks(String query) => '/books/search?$query';
  static const getAllCategories = '/categories';
}
