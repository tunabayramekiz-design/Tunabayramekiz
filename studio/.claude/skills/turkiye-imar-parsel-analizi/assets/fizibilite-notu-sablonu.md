<!--
Bu şablonu SKILL.md Adım 9'da doldur. "{{...}}" alanlarının HİÇBİRİ hesaptan/hafızadan
doldurulmaz — her biri ya bir kaynaktan gelen değerle ya da [KAYNAK GEREKLİ] ile
değiştirilir. Doldurulmamış bir "{{...}}" kalmışsa scripts/kaynak-kontrolu.sh bunu
hata olarak işaretler.

Bu dosyanın PART A bölümü müşteriye/karar vericiye doğrudan gönderilebilir — teknik
jargon yerine sonuç ve gerekçe içerir. PART B, PART A'daki her satırın dayandığı
hesabı ve kaynağı gösterir; PART A'sız gönderilmez (kanıt görülmeden karar
paylaşılmaz), ama PART B mutlaka PART A'nın ARKASINDA/EKİNDE kalır.
-->

# İmar Fizibilite Notu — {{PARSEL_ADI_VEYA_ADRES}}

**Two+ — {{TARİH}}**

## PART A — Fizibilite Notu (müşteriye sunulabilir)

### Karar

> **{{KARAR: Yapılabilir / Doğrulama şartıyla yapılabilir / Kısıtlı / No-Go}}**

**Gerekçe (2-4 cümle):** {{Karar matrisine göre neden bu karara varıldığı, hangi
kalemlerin doğrulanmış hangi kalemlerin eksik/kısıtlayıcı olduğu.}}

### Parsel özeti

| Alan | Değer | Kaynak |
|---|---|---|
| İl / İlçe | {{...}} | — |
| Ada / Parsel | {{...}} | {{belge, tarih}} |
| Yüzölçümü | {{...}} m² | {{belge, tarih}} |
| Kullanım kararı | {{...}} | {{belge, tarih}} |
| İmar durumu belgesi tarihi | {{...}} | — |

### Tek kanıt tablosu

Aşağıdaki 11 kalem `references/kontrol-listesi.md`'deki sırayla verilir. "Durum"
sütunu `Doğrulandı`, `[KAYNAK GEREKLİ]` veya `Çelişkili` değerlerinden birini alır.

| # | Kalem | Bulgu | Kaynak | Durum |
|---|---|---|---|---|
| 1 | İmar durumu | {{...}} | {{...}} | {{...}} |
| 2 | Plan notu | {{...}} | {{...}} | {{...}} |
| 3 | Tapu / kadastro | {{...}} | {{...}} | {{...}} |
| 4 | TAKS / KAKS–Emsal | {{...}} | {{...}} | {{...}} |
| 5 | Çekme mesafeleri | {{...}} | {{...}} | {{...}} |
| 6 | Yükseklik | {{...}} | {{...}} | {{...}} |
| 7 | Erişim | {{...}} | {{...}} | {{...}} |
| 8 | Otopark | {{...}} | {{...}} | {{...}} |
| 9 | Yangın | {{...}} | {{...}} | {{...}} |
| 10 | Ruhsat hazırlığı | {{...}} | {{...}} | {{...}} |
| 11 | Teknik riskler | {{...}} | {{...}} | {{...}} |

### Doğrulanmamış kalemler / şartlar

{{Karar "Doğrulama şartıyla yapılabilir" veya "Kısıtlı" ise, hangi belgenin
sağlanması gerektiğini madde madde listele. "Yapılabilir" ise "Yok" yaz.}}

## PART B — Teknik ek

### TAKS / KAKS–Emsal hesabı

`references/taks-kaks-emsal.md` formatında, formül + kaynaklı girdiler + sonuç.

```
{{Formül}}
{{Girdi 1 = değer — Kaynak: ...}}
{{Girdi 2 = değer — Kaynak: ...}}
{{Sonuç}}
```

### Çekme mesafeleri ve yükseklik

| Parametre | Değer | Kaynak |
|---|---|---|
| Ön bahçe | {{...}} | {{...}} |
| Yan bahçe(ler) | {{...}} | {{...}} |
| Arka bahçe | {{...}} | {{...}} |
| Yençok / kat adedi | {{...}} | {{...}} |
| Kot alma noktası | {{...}} | {{...}} |

### Otopark

| Kullanım | Yükümlülük | Kaynak |
|---|---|---|
| {{...}} | {{...}} | {{...}} |

### Yangın (BYKHY kapsamı)

{{Kaçış merdiveni, yangın merdiveni, hidrant vb. — her biri madde numarası ve
tarihiyle kaynaklı.}}

### Ruhsat hazırlık durumu

| Belge | Mevcut mu? | Not |
|---|---|---|
| {{...}} | {{Evet/Hayır/[KAYNAK GEREKLİ]}} | {{...}} |

### Kaynak listesi

{{Bu raporda kullanılan her belgenin tam listesi: ad, tarih, veren kurum, varsa link.}}

---

> **Uyarı:** Bu, ön değerlendirme amaçlı bir yapay zekâ analizidir. Buradaki hiçbir
> bulgu, kaynak belgede (imar durumu belgesi, plan notu, tapu kaydı, ilgili mevzuat)
> doğrulanmadan tasarım, ruhsat başvurusu veya resmî bir başvuruda kullanılmamalıdır.
> Sayısal sonuçlar yalnızca yukarıda atıfı verilen belgelerden türetilmiştir;
> `[KAYNAK GEREKLİ]` olarak işaretli hiçbir satır doğrulanmış veri değildir.

<!-- two-plus-studio:imar-analizi-dogrulanmali -->
