# TAKS / KAKS–Emsal: tanımlar ve formüller

Bu dosyadaki formüller ve terimler genel, uzun süredir değişmeyen mühendislik/planlama
tanımlarıdır — bir belediyenin veya planın SAYISAL eşiği değildir. Sayısal değerler
(TAKS oranı, KAKS/Emsal değeri) her zaman `kaynak-hiyerarsisi.md`'deki hiyerarşiye göre
parsele özel kaynaktan alınır. Bu dosyayı sadece formülü doğru uygulamak için kullan.

## TAKS (Taban Alanı Kat Sayısı)

```
TAKS = Zemin (taban) alanı ÷ Parsel alanı
```

- **Zemin alanı**: binanın araziyle temas eden, dış duvarların dış yüzeyinden ölçülen
  izdüşüm alanı. Saçaklar, açık balkonlar genelde hariç — ama bu istisna da plana/
  yönetmeliğe göre değişir; kaynakta açıkça tanımlanmamışsa `[KAYNAK GEREKLİ]` yaz.
- **Maksimum taban alanı** = TAKS × Parsel alanı. TAKS'ı kaynaktan al, parsel alanını
  imar durumu belgesinden veya tapu kaydından al (ikisi çelişiyorsa ikisini de raporla).

## KAKS (Kat Alanı Kat Sayısı) / Emsal

Türkiye planlama pratiğinde "KAKS" ve "Emsal" aynı oranı ifade etmek için kullanılır;
bazı plan notları "Emsal", bazıları "KAKS" yazar. Aynı parselde ikisi farklı yazılmışsa
bunu çelişki olarak işaretle, birini "doğru" diye seçme.

```
KAKS (Emsal) = Toplam (brüt) inşaat alanı ÷ Parsel alanı
İzin verilen toplam inşaat alanı = KAKS (Emsal) değeri × Parsel alanı
```

- **Brüt inşaat alanı**: tüm katların toplam kapalı alanı (dış duvar dış yüzeyinden).
- **Emsal harici alanlar**: bazı planlarda/yönetmeliklerde otopark, sığınak, ortak
  tesisat alanları, asansör/merdiven boşlukları gibi kalemler emsale dahil edilmez.
  Bunun bu parsel için geçerli olup olmadığını **plan notunda veya yönetmelikte ara**;
  genel bir kural olarak varsayma. Kaynakta yoksa `[KAYNAK GEREKLİ — emsal harici alan
  tanımı doğrulanmadı]` yaz.
- **Net inşaat alanı**: brüt alandan ortak kullanım/dolaşım alanlarının çıkarılmasıyla
  bulunur; bağımsız bölüm satışı/kiralaması bağlamında geçer ama imar hesabında brüt alan
  esastır — kaynak farklı bir tanım veriyorsa kaynağı esas al.

## Hesabı raporda gösterme kuralı

Her hesap üç satırda gösterilir:

1. Formül: `İzin verilen toplam inşaat alanı = KAKS × Parsel alanı`
2. Girdiler (her biri kaynaklı): `KAKS = 1.50 — Kaynak: [belge, madde, tarih]` /
   `Parsel alanı = 850 m² — Kaynak: [belge, tarih]`
3. Sonuç: `1.50 × 850 m² = 1.275 m² azami toplam inşaat alanı`

Girdilerden biri `[KAYNAK GEREKLİ]` ise sonucu da `[KAYNAK GEREKLİ]` olarak işaretle —
eksik girdiyle "yaklaşık" bir sonuç üretme; bu, tek bir tahmini rakamın kesin bir hesap
gibi sunulmasına yol açar.
