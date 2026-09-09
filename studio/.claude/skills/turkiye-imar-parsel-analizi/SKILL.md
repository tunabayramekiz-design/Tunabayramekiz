---
name: turkiye-imar-parsel-analizi
description: >
  Türkiye'deki bir parselin imar durumunu, plan notlarını, TAKS/KAKS-Emsal
  hesabını, çekme mesafelerini, yükseklik sınırlarını, tapu/kadastro kaydını,
  erişimini, otopark ve yangın gereklerini ve ruhsat hazırlığını KULLANICI
  TARAFINDAN SAĞLANAN belgelerden (imar durumu belgesi, plan notu, tapu kaydı,
  ilgili mevzuat) denetlenebilir biçimde çıkarır ve tek bir net karara
  (Yapılabilir / Doğrulama şartıyla yapılabilir / Kısıtlı / No-Go) bağlar.
  Bakırköy, Kağıthane, Ümraniye dahil her Türkiye belediyesi/ilçesi için Two+'ın
  BİRİNCİL ve VARSAYILAN aracıdır — kullanıcı bir arsa, imar, fizibilite veya
  kütle kararı istediğinde ("Ümraniye'deki şu ada-parsel için imar fizibilitesi
  çıkar", "bu parselde ne kadar inşaat yapabilirim", "TAKS/KAKS ne çıkıyor",
  "çekme mesafesi kaç", "ruhsat için ne eksik", "otopark yönetmeliğine göre kaç
  araçlık yer gerekiyor", "imar barışı bu parseli nasıl etkiler" gibi ifadelerle
  veya doğrudan isim vermeden) bu beceriyi HER ZAMAN devreye al. Türkiye'de
  NYC'nin PLUTO'su gibi resmî/güvenilir bir açık imar API'si YOKTUR — bu beceri
  bu yüzden asla belediye verisini tahmin etmez veya ezberden üretmez; kaynağı
  olmayan her değeri `[KAYNAK GEREKLİ]` olarak işaretler ve eksikse önce
  kullanıcıdan ister. NYC'ye özgü `zoning-analysis-nyc` bu senaryolarda
  KULLANILMAZ (bkz. `studio/CLAUDE.md` — Beceri Kapsamı).
allowed-tools:
  - Read
  - Write
  - Edit
  - Glob
  - Grep
  - Bash
  - AskUserQuestion
  - WebFetch
---

# Türkiye İmar–Parsel Analizi (Two+)

Bu beceri bir "veri getirme" aracı değildir — bir **denetim** aracıdır. Amacı,
kullanıcının/ekibin sağladığı gerçek belgelerden (imar durumu belgesi, plan
notu, tapu kaydı, mevzuat) TAKS/KAKS-Emsal, çekme, yükseklik, otopark, yangın
ve ruhsat durumunu şeffaf ve izlenebilir biçimde çıkarmak, ve bunları tek bir
net karara bağlamaktır. **Hiçbir sayısal değer kaynaksız üretilmez.**

Neden bu kadar sıkı? Çünkü Türkiye'de NYC'nin PLUTO'su gibi güvenilir, tek bir
açık imar API'si yok. Aynı ada/parsel için değer plana, belediyeye ve tarihe
göre değişir; bu beceriyi çalıştıran modelin ezber bilgisi hem güncel değildir
hem de bu parsel için doğru olduğu garanti edilemez. Detaylı gerekçe için
`references/kaynak-hiyerarsisi.md`'yi oku — bu dosya bu becerinin tüm diğer
adımlarını yönetir.

## Proje bağlamı

Çalışma dizininde `PROJECT.md` varsa önce onu oku — ada/parsel, önceki imar
bulguları zaten kayıtlı olabilir. Analiz bittiğinde, imar sınıflandırması,
karar ve kaynakları `/as:project update` için önerebilirsin (Architecture
Studio plugin'i kurulu ve `PROJECT.md` mevcutsa). `PROJECT.md` yoksa sessizce
geç.

## Adım 0 — Kaynakları topla (zorunlu kapı)

Analize başlamadan önce şu belgelerin/bilgilerin hangisinin elde olduğunu,
hangisinin eksik olduğunu tek bir listede çıkar:

1. Güncel **imar durumu belgesi** (veya en azından ada/parsel, yüzölçüm, imar
   hattı, TAKS/KAKS-Emsal, Yençok/kat adedi, çekme mesafeleri, kullanım kararı)
2. Yürürlükteki **plan notu** (1/1000 uygulama imar planı, madde numarası)
3. **Tapu kaydı** (malik, yüzölçüm, takyidat) — en azından özet bilgi
4. İlgili **mevzuat/yönetmelik** metni veya en azından hangi belediyenin/planın
   geçerli olduğu bilgisi (bkz. `references/mevzuat-cercevesi.md`)
5. Varsa **teknik risk** kayıtları (zemin etüdü, taşkın/heyelan/afet riskli alan
   ilanı, imar barışı/kaçak yapı geçmişi)

Kullanıcı bunları zaten mesajında/eklerde verdiyse tekrar sorma — sadece
eksik olanı işaretle. Eksik olanlar için **tek bir toplu `AskUserQuestion`**
ile sor (her biri için ayrı ayrı sorma). Kullanıcı "elimde yok, sen bul" derse:
bunun mümkün olmadığını açıkça söyle (Türkiye'de bu veriler için genel amaçlı
güvenilir bir API yok) ve hangi belgeyi nereden (ilgili belediyenin imar
müdürlüğü, e-devlet, tapu müdürlüğü) temin edebileceğini öner — kendisi adına
tahmin etme.

Hiçbir kaynak yoksa ve kullanıcı yalnızca genel bir senaryo/ön-fikir istiyorsa
(örn. "bu ilçede tipik olarak ne çıkar" gibi kavramsal bir soru), bunun bu
becerinin kapsamı dışında olduğunu ve sonucun parsel-özel, kaynaklı bir analiz
olmayacağını açıkça söyleyip devam etme kararını kullanıcıya bırak.

## Adım 1–11 — Kanıt kalemlerini işle

`references/kontrol-listesi.md`'deki 11 kalemi sırayla işle: imar durumu, plan
notu, tapu/kadastro, TAKS/KAKS-Emsal (`references/taks-kaks-emsal.md`
formülüyle), çekme mesafeleri, yükseklik, erişim, otopark, yangın (BYKHY
kapsamı), ruhsat hazırlığı, teknik riskler.

Her kalem için üç şeyi birlikte üret: **Bulgu**, **Kaynak** (belge/madde/sayfa
+ tarih), **Durum** (`Doğrulandı` / `[KAYNAK GEREKLİ]` / `Çelişkili`). Bir
kalemde kaynaklar birbiriyle çelişiyorsa (örn. imar durumu belgesi ile plan
notu farklı bir Emsal değeri veriyorsa) ikisini de yaz, birini "doğru" diye
seçme — bu, `Çelişkili` durumudur ve karar gerekçesinde ayrıca ele alınmalı.

Ulusal mevzuatın (İmar Kanunu, Planlı Alanlar İmar Yönetmeliği, Otopark
Yönetmeliği, BYKHY, Yapı Ruhsatiyesi Yönetmeliği) güncel metni gerekiyorsa ve
kullanıcı sağlamadıysa, **yalnızca bu ulusal/genel mevzuat için** `WebFetch` ile
resmî bir kaynaktan (mevzuat.gov.tr, resmigazete.gov.tr, ilgili belediyenin
resmî sayfası) getir; linki ve erişim tarihini kaynak olarak göster. Parsele
özel hiçbir veri (imar durumu, plan notu, tapu) için WebFetch kullanma veya
tahmin etme — bunlar sadece kullanıcıdan/kaynak belgeden gelir.

## Adım 12 — Karar matrisini uygula

`references/kontrol-listesi.md` içindeki karar matrisini kullanarak tek bir üst
karar üret: **Yapılabilir / Doğrulama şartıyla yapılabilir / Kısıtlı / No-Go**.
Hangi kalemlerin bu kararı belirlediğini 2-4 cümlede gerekçelendir. Belirsizse
daha temkinli tarafa düş (`Doğrulama şartıyla yapılabilir` yerine `Kısıtlı`
gibi bir tercih değil — asıl kural: eksik kanıtla asla `Yapılabilir` deme).

## Adım 13 — Denetim: kaynak-kontrolu.sh çalıştır

Raporu `assets/fizibilite-notu-sablonu.md` şablonuyla doldurduktan sonra,
sunmadan/kaydetmeden önce şunu çalıştır:

```
bash <skill-root>/scripts/kaynak-kontrolu.sh <rapor-dosyası.md>
```

Script şunları kontrol eder: doldurulmamış `{{...}}` alanı kalmamış mı, geçerli
bir karar satırı var mı, 11 kanıt kalemi raporda geçiyor mu, uyarı bloğu +
marker satırda mı. Hata varsa raporu düzelt ve script'i tekrar çalıştır — hata
çözülmeden raporu "tamamlandı" olarak sunma. Script `[KAYNAK GEREKLİ]`
işaretlerini hata saymaz ama listeler — bu liste "Doğrulanmamış Kalemler"
bölümüyle tutarlı olmalı.

## Çıktı formatı

`assets/fizibilite-notu-sablonu.md`'yi birebir kullan. İki bölümden oluşur:

- **PART A — Fizibilite Notu**: kısa, müşteriye/karar vericiye doğrudan
  sunulabilir. Karar, gerekçe, parsel özeti, tek kanıt tablosu (11 satır),
  doğrulanmamış kalemler.
- **PART B — Teknik ek**: PART A'daki her satırın dayandığı hesap/detay
  (TAKS/KAKS formülü, çekme/yükseklik tablosu, otopark, yangın, ruhsat, kaynak
  listesi). PART A'sız asla paylaşılmaz (kanıt görülmeden karar paylaşılmaz),
  ama PART A tek başına da okunabilir olmalı — müşteri PART B'yi açmadan
  kararı ve gerekçesini anlayabilmeli.

Dosya adı önerisi: `imar-fizibilite-[parsel-slug].md`, çalışma dizinine
(genellikle ilgili projenin klasörüne) kaydet.

## Sınırlar — asla yapılmayacaklar

- Kaynağı olmayan bir TAKS, KAKS/Emsal, çekme, yükseklik, otopark oranı veya
  yangın gereksinimi **asla üretme/tahmin etme** — `[KAYNAK GEREKLİ]` yaz.
- Parsele özel veri için (imar durumu, plan notu, tapu) **asla WebFetch veya
  genel web araması kullanma** — bu veriler yalnızca kullanıcıdan/belgeden gelir.
- "Bu imar kanununa uygundur" gibi kesinlik ifadesi kullanma — `rules
  /professional-disclaimer.md` mantığıyla "kaynakta incelenen belgelere göre
  ... görünüyor" de.
- Eksik kanıtla `Yapılabilir` kararı verme.
- Kaynak-kontrolu.sh hata veriyorken raporu "tamamlandı" olarak sunma.

## Son adım: Uyarı + marker (zorunlu)

Şablonun sonundaki uyarı bloğunu ve `<!-- two-plus-studio:imar-analizi-dogrulanmali -->`
marker'ını hiçbir zaman çıkarma veya değiştirme — `kaynak-kontrolu.sh` bunu
denetler.
