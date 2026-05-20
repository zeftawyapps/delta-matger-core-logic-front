# 🌐 كود الدمج والاستدعاء للـ Public Catalog Endpoint
> **خاص بـ:** مطوري الموقع الإلكتروني (Web Developers / Frontend)
> **Endpoint الموجه:** `/api/v1/products/public/catalog`

يحتوي هذا الملف على الدوال الجاهزة بلغة **JavaScript (Fetch / Axios)** و **Dart (Flutter)** لتسهيل دمج واستدعاء المنتجات العامة مع دعم كامل للفلترة والبحث بالاسم وقسم المنتجات بدون الحاجة لصلاحيات.

---

## ⚡ 1. دمج واستدعاء Endpoint في الموقع (JavaScript / TypeScript)

### خيار أ: باستخدام Fetch API (بدون مكتبات خارجية)

```javascript
/**
 * جلب منتجات الكتالوج العام مع إمكانية الفلترة
 * @param {Object} filters - خيارات الفلترة والبحث
 * @param {string} [filters.categoryId] - معرف القسم لتصفية المنتجات
 * @param {string} [filters.name] - الاسم أو جزء منه للبحث (يدعم العربية والإنجليزية)
 * @returns {Promise<Array>} قائمة المنتجات المسترجعة
 */
async function fetchPublicCatalog({ categoryId, name } = {}) {
  try {
    // استبدل الرابط برابط السيرفر الفعلي الخاص بك
    const baseUrl = 'https://your-domain.com/api/v1/products/public/catalog';
    const url = new URL(baseUrl);
    
    // إضافة خيارات الفلترة للـ Query Parameters إن وجدت
    if (categoryId) {
      url.searchParams.append('categoryId', categoryId);
    }
    if (name) {
      url.searchParams.append('name', name);
    }

    const response = await fetch(url, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
    });

    if (!response.ok) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }

    const result = await response.json();
    if (result.success) {
      return result.data; // قائمة المنتجات المفلترة
    } else {
      throw new Error(result.message || 'Failed to fetch public catalog');
    }
  } catch (error) {
    console.error('Error in fetchPublicCatalog:', error);
    throw error;
  }
}
```

### خيار ب: باستخدام مكتبة Axios

```javascript
import axios from 'axios';

/**
 * جلب منتجات الكتالوج العام باستخدام Axios
 * @param {Object} filters - خيارات الفلترة
 * @param {string} [filters.categoryId] - معرف القسم
 * @param {string} [filters.name] - البحث بالاسم
 */
async function fetchPublicCatalog({ categoryId, name } = {}) {
  try {
    const response = await axios.get('https://your-domain.com/api/v1/products/public/catalog', {
      params: {
        ...(categoryId && { categoryId }),
        ...(name && { name })
      },
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
    });

    if (response.data.success) {
      return response.data.data;
    }
    throw new Error(response.data.message || 'Failed to fetch public catalog');
  } catch (error) {
    console.error('Error in fetchPublicCatalog Axios:', error);
    throw error;
  }
}
```

---

## 📱 2. دمج واستدعاء Endpoint في تطبيقات الموبايل (Flutter / Dart)

في حال كان الموقع أو التطبيق مبنياً بـ Flutter، يمكن استخدام الدالة التالية مباشرة:

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

/// جلب منتجات الكتالوج العام مع دعم الفلترة بالقسم أو الاسم
Future<List<dynamic>> fetchPublicCatalog({String? categoryId, String? name}) async {
  final Map<String, String> queryParams = {};
  
  if (categoryId != null && categoryId.isNotEmpty) {
    queryParams['categoryId'] = categoryId;
  }
  
  if (name != null && name.isNotEmpty) {
    queryParams['name'] = name;
  }

  // استبدل النطاق بنطاق السيرفر الفعلي
  final uri = Uri.parse('https://your-domain.com/api/v1/products/public/catalog')
      .replace(queryParameters: queryParams);

  final response = await http.get(
    uri,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final body = jsonDecode(response.body);
    if (body['success'] == true) {
      return body['data'] as List<dynamic>;
    }
  }
  
  throw Exception('Failed to load public catalog');
}
```

---

## 📦 هيكلية البيانات المسترجعة المتوقعة (Sample Item Structure)

سيتلقى المطورون قائمة تحتوي على كائنات المنتجات بالهيكل التالي:

```json
{
  "productId": "6649f57d1b06df1e102cb45d",
  "name": {
    "ar": "آيفون 15 برو ماكس",
    "en": "iPhone 15 Pro Max"
  },
  "categoryId": "6649f39d1b06df1e102cb428",
  "price": 45000,
  "oldPrice": 48000,
  "discount": 3000,
  "stockQuantity": 15,
  "imageUrls": [
    "https://res.cloudinary.com/demo/image/upload/v1234/iphone15.jpg"
  ],
  "isActive": true,
  "isAvailable": true,
  "categoryData": {
    "categoryId": "6649f39d1b06df1e102cb428",
    "nameAr": "الهواتف الذكية",
    "nameEn": "Smartphones",
    "imageUrl": "https://res.cloudinary.com/demo/image/upload/v1234/phones-category.jpg"
  }
}
```
