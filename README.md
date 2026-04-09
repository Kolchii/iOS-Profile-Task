# Məlumatlarım — Profil Ekranı

iOS Developer müsahibə tapşırığı çərçivəsində SwiftUI ilə hazırlanmış profil ekranı.

## Layihə haqqında

Bu layihə istifadəçinin profil məlumatlarını REST API vasitəsilə əldə edib göstərir və redaktə etməyə imkan verir. Ekran tamamilə SwiftUI ilə yazılmış, MVVM arxitekturası və Protocol + Dependency Injection tətbiq edilmişdir.

## Texnologiyalar

- Swift 5.9
- SwiftUI (UIKit istifadə edilməyib)
- MVVM arxitekturası
- async/await + URLSession
- iOS 16+

## Funksionallıq

- GET API ilə profil məlumatlarının yüklənməsi
- ProgressView ilə loading göstəricisi
- Xəta halında Alert
- Ad, soyad, cins, şəhər, doğum tarixi redaktəsi
- Yadda saxla düyməsi ilə validation və mock PUT request

## Layihəni işə salmaq

### Tələblər
- Xcode 15 və ya yuxarı
- iOS 16+ Simulator
- macOS Ventura və ya yuxarı

### Addımlar

1. Repo-nu clone et: git clone https://github.com/Kolchii/iOS-Profile-Task.git
2. Xcode-da aç: open Task.xcodeproj
3. Config faylı yarat — bu addım mütləqdir: Task/Config/ qovluğunda Config.xcconfig adlı fayl yarat. İçinə yazılacaq dəyərlər təhlükəsizlik səbəbindən paylaşılmır. Layihəni qiymətləndirən şəxsə ayrıca göndəriləcək.
4. Simulator seç
5. Cmd + R ilə run et

## Qeydlər

- Config.xcconfig təhlükəsizlik səbəbindən .gitignore-a əlavə edilib və repoda yoxdur
- Fiziki cihaz tələb olunmur
- Üçüncü tərəf kitabxana istifadə edilməyib, bütün logika native yazılmışdır
