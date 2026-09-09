# Mevzuat çerçevesi (başlıklar — sayısal eşik değil)

Bu liste, bir parsel analizinde "hangi belgeyi/mevzuatı isteyeyim" sorusuna cevap vermek
içindir. Aşağıdaki başlıklar iyi bilinen, uzun süredir yürürlükte olan üst düzey mevzuat
adlarıdır ve bu kadarıyla güvenilir kabul edilebilir. **Ama bu dosyada hiçbir maddenin
güncel metnini, sayısal eşiğini veya değişip değişmediğini iddia etme** — bunlar zamanla
değişir ve modelin eğitim verisi güncel olmayabilir. Güncel metin gerektiğinde:

- Kullanıcıdan doğrudan belge/metin iste, veya
- Yalnızca bu ulusal/genel mevzuat için (parsel verisi için değil) `mevzuat.gov.tr`,
  `resmigazete.gov.tr` veya ilgili belediyenin resmî yayınladığı yönetmelik sayfası
  üzerinden `WebFetch` ile getir; getirdiğin metnin linkini ve erişim tarihini raporda
  göster.

## Genel çerçeve (ulusal)

| Konu | Aranacak mevzuat başlığı |
|---|---|
| İmar hakkı, ruhsat, genel çerçeve | 3194 sayılı İmar Kanunu |
| Bulk/imar teknik detayları | Planlı Alanlar İmar Yönetmeliği |
| Otopark | Otopark Yönetmeliği (ulusal) + ilgili büyükşehir/ilçe belediyesinin kendi otopark yönetmeliği veya tablosu (çoğu büyükşehirde ulusal yönetmeliğin üzerine belediyeye özel bir yönetmelik/tablo uygulanır) |
| Yangın / hayat güvenliği | Binaların Yangından Korunması Hakkında Yönetmelik (BYKHY) |
| Ruhsat / yapı kullanma izni süreci | Yapı Ruhsatiyesi ve Yapı Kullanma İzni Yönetmeliği + ilgili belediyenin ruhsat başvuru şartnamesi/istenen belge listesi |
| Deprem / yapısal güvenlik ön koşulu | Türkiye Bina Deprem Yönetmeliği + zemin etüdü raporu |
| Afet/imar geçmişi özel durumları | İmar barışı / yapı kayıt belgesi kayıtları (varsa) — güncel hukuki statüsünü genel bilgiyle açıklama, parsel özelinde doğrula |

## Yerel / parsele özel katman

Bu katman ulusal mevzuatın **üzerine** eklenir, onun yerine geçmez:

- Yürürlükteki 1/1000 uygulama imar planı ve plan notları
- İlgili ilçe belediyesinin (örn. Bakırköy, Kağıthane, Ümraniye) kendi imar yönetmeliği
  veya meclis kararları
- İlgili büyükşehir belediyesinin (İstanbul için İBB) otopark ve diğer konu-özel
  yönetmelikleri

## Kesin kural

Ulusal mevzuat başlığını doğru isimlendirmek "kaynak vermek" değildir. Bir hesaba veya
gereksinime girecek her sayısal eşik (çekme mesafesi, yükseklik, otopark oranı, kaçış
merdiveni genişliği vb.) **mutlaka madde numarası + yürürlük/değişiklik tarihi ile**
kaynaklı olmalı; sadece "İmar Kanunu'na göre" gibi genel bir atıf yeterli değildir
(bkz. `rules/code-citations.md` mantığı — ayrı bir belediyeye/plana göre değişen her
şey için).
