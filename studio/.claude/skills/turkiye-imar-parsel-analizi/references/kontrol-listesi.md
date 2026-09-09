# Kontrol listesi ve karar matrisi

Bu dosya iki şeyi tanımlar: (1) her kanıt kalemi için ne sorulacağı ve nereden
doğrulanacağı, (2) toplam bulgunun nasıl tek bir nete karara (yapılabilir /
doğrulama şartıyla yapılabilir / kısıtlı / no-go) dönüştürüleceği.

## 1. Kanıt kalemleri

Her kalem için üç şey üret: **Bulgu** (kaynaktan aynen), **Kaynak** (belge/madde/tarih),
**Durum** (`Doğrulandı` / `[KAYNAK GEREKLİ]` / `Çelişkili — bkz. not`).

| # | Kalem | Ne sorulur / nereden doğrulanır |
|---|---|---|
| 1 | **İmar durumu** | Ada/parsel, yüzölçüm, imar hattı, kullanım kararı (fonksiyon), plan onay tarihi — güncel imar durumu belgesinden. |
| 2 | **Plan notu** | Yürürlükteki 1/1000 uygulama imar planı plan notları, ilgili madde numarası. İmar durumu belgesiyle çelişki var mı? |
| 3 | **Tapu / kadastro** | Malik(ler), yüzölçümü (tapudaki ile imar durumu belgesindeki alan aynı mı?), takyidat (ipotek, şerh, irtifak hakkı), kadastro/imar parseli farkı (18. madde uygulaması geçmişi var mı?). |
| 4 | **TAKS / KAKS–Emsal** | `taks-kaks-emsal.md` formülüyle hesapla; her girdi kaynaklı olmalı. |
| 5 | **Çekme mesafeleri** | Ön/yan/arka bahçe mesafeleri, nizam tipi (ayrık/bitişik/blok), köşe parsel veya ikiz/çoklu cephe durumu — plan notu veya imar durumu belgesinden. |
| 6 | **Yükseklik** | Yençok (mutlak yükseklik) veya izin verilen kat adedi, saçak/mahya kotu tanımı, kot alma noktası (yol kotu mu, tabii zemin mi) — kaynaktan. |
| 7 | **Erişim** | Parselin yola cephesi var mı, kadastral yola mı yoksa imar yoluna mı cephesi var, yol genişliği yapı ruhsatı için yeterli mi (bazı yönetmelikler asgari yol genişliği ister) — imar durumu belgesi/kadastro paftasından. |
| 8 | **Otopark** | Kullanım kararına göre otopark yükümlülüğü — ulusal Otopark Yönetmeliği VE ilgili (büyükşehir/ilçe) belediyenin kendi otopark yönetmeliği/tablosu; ikisi farklıysa daha sıkı olanı not et. |
| 9 | **Yangın** | Bina yüksekliği/kullanım sınıfına göre BYKHY kapsamında kaçış merdiveni, yangın merdiveni, hidrant, yangın dayanımı gereksinimleri — kaynaktan madde numarasıyla. |
| 10 | **Ruhsat hazırlığı** | Yapı ruhsatı başvurusu için ilgili belediyenin istediği belge listesi (statik proje, zemin etüdü, mimari proje, harç/ücret makbuzları vb.) tam mı, eksik mi. |
| 11 | **Teknik riskler** | Zemin etüdü/deprem (mikrobölgeleme, fay hattı yakınlığı), sel/dere yatağı, heyelan/afet riskli alan kaydı, kaçak yapı/imar barışı geçmişi — varsa kaynak, yoksa "bilgi verilmedi" olarak işaretle (bu bir "risk yok" anlamına gelmez). |

Kaynağı olmayan her kalem `[KAYNAK GEREKLİ]` ile işaretlenir ve raporun "Doğrulanmamış
Kalemler" bölümüne girer. Adım 0'da (bkz. `SKILL.md`) bu kalemlerin kaynağı istenmiş
olmalı; analiz bittiğinde hâlâ eksikse bu, raporu geçersiz kılmaz ama **karar
matrisini doğrudan etkiler** (aşağıya bak).

## 2. Karar matrisi

Kanıt kalemleri toplandıktan sonra tek bir üst-karar üret. Bu karar raporun en üstünde,
tek satırda görünür — müşterinin/ekibin ilk okuduğu şey budur.

| Karar | Ne zaman verilir |
|---|---|
| **Yapılabilir** | Kalem 1-11'in tamamı `Doğrulandı`, aralarında çözülmemiş çelişki yok, ve teknik risk kaydı temiz veya risk yok. |
| **Doğrulama şartıyla yapılabilir** | Kritik olmayan 1-3 kalem `[KAYNAK GEREKLİ]` (örn. otopark tablosu veya ruhsat belge listesi eksik) ama imar durumu, plan notu, TAKS/KAKS-Emsal, çekme, yükseklik doğrulanmış ve teknik risk kaydı temiz. Eksik kalemler net biçimde listelenir. |
| **Kısıtlı** | Doğrulanmış kalemler projeyi mümkün kılıyor ama belirli bir kısıtla (örn. çekme mesafesi nedeniyle brüt inşaat alanının önemli bir kısmı kullanılamıyor, yol genişliği asgari şartın altında, otopark yükümlülüğü parselde fiziksel olarak karşılanamıyor) — kısıt açıkça yazılır. |
| **No-Go** | Temel kalemlerden biri (imar durumu, plan notu, TAKS/KAKS-Emsal, tapu/kadastro) doğrulanamıyor VE alternatif kaynak da yok, VEYA teknik risk kaydında çözülemez bir engel var (örn. parsel tümüyle afet riskli alan ilanı kapsamında, veya imar planında bu kullanım kararı tanımlı değil). |

**Kritik/kritik-olmayan ayrımı proje bağlamına göre değişir** — bu beceri bunu otomatik
belirlemez; hangi kalemlerin "kritik" sayıldığını raporun karar gerekçesinde açıkça yaz,
böylece okuyan kişi seni takip edip aynı mantığı sorgulayabilir. Belirsizse "Doğrulama
şartıyla yapılabilir" tarafına düş — "Yapılabilir" kararını asla eksik kanıtla verme.
