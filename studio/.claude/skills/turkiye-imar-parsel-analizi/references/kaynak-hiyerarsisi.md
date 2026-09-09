# Kaynak hiyerarşisi ve "kaynaksız değer yok" ilkesi

## Neden bu beceri hiçbir zaman tahmin yapmaz

NYC'deki PLUTO gibi, bir parselin güncel imar hakkını (TAKS, KAKS/Emsal, çekme, yükseklik,
kullanım kararı) sorgulanabilir, tek ve güvenilir bir açık API üzerinden veren ulusal bir
sistem Türkiye'de yoktur. Belediyelerin e-imar/e-belediye portalları birbirinden farklıdır,
kapsamları değişkendir ve genel amaçlı bir web sorgusuyla güvenilir biçimde okunamaz.

Aynı ada/parsel için değer, planın hangi tarihte onaylandığına, hangi plan notunun revize
edildiğine ve hangi belediyenin (büyükşehir/ilçe) yetkili olduğuna göre değişir. Bu beceriyi
çalıştıran modelin eğitim verisi bu değerler için **güncel değil** ve **parsel özelinde
doğru olduğu garanti edilemez**. Bu yüzden:

> **Kaynaksız hiçbir sayısal değer üretilmez, tahmin edilmez ya da "tipik olarak şöyledir"
> diye genellenmez.** Bir değerin kaynağı yoksa, o değer rapora `[KAYNAK GEREKLİ]` olarak
> girer — asla bir sayıyla doldurulmaz.

Bu, bu becerinin diğer tüm adımlarını yöneten tek kuraldır. Aşağıdaki hiyerarşi ve kontrol
listesi bu kuralı nasıl uygulayacağını gösterir.

## Kaynak hiyerarşisi (en güçlüden en zayıfa)

1. **Parsele özel, güncel imar durumu belgesi** — ilgili belediyeden (imar müdürlüğü) resmî
   olarak alınmış belge. Ada/parsel, yüzölçüm, imar hattı, TAKS/KAKS veya Emsal, Yençok/kat
   adedi, çekme mesafeleri, kullanım kararını içerir. Belgenin **tarihine** ve hangi plana
   atıfla düzenlendiğine bak — eski bir belge, plan değişikliğinden sonra geçerliliğini
   kaybetmiş olabilir.
2. **Yürürlükteki uygulama imar planı plan notları** (genellikle 1/1000 ölçekli) — madde
   numarasıyla. Plan notu, imar durumu belgesindeki değerle çelişiyorsa bunu rapora açıkça
   yaz; kendiliğinden birini "doğru" seçme.
3. **İlgili belediyenin kendi imar yönetmeliği / meclis kararları** (varsa) — genel imar
   yönetmeliğinden farklı, o belediyeye özel hükümler içerebilir.
4. **Ulusal çerçeve mevzuat** — 3194 sayılı İmar Kanunu, Planlı Alanlar İmar Yönetmeliği,
   konuya özel yönetmelikler (otopark, yangın, ruhsat). Bunların başlıklarını ve genel
   çerçevesini `mevzuat-cercevesi.md` içinde bulabilirsin, ama **maddelerin güncel metnini
   ve sayısal eşiklerini hafızandan yazma** — kullanıcıdan metni iste veya (yalnızca ulusal
   mevzuat için, parsel verisi için değil) resmî bir kaynaktan (mevzuat.gov.tr,
   resmigazete.gov.tr, ilgili belediyenin resmî yayınladığı yönetmelik PDF'i) WebFetch ile
   getir ve linkini/tarihini raporda göster.
5. **Genel bilgi / ezber** — bu hiyerarşide yer almaz. Hiçbir sayısal sonucu bu kaynakla
   üretme.

## Uygulama kuralı

Her adımda (imar durumu, plan notu, TAKS/KAKS-Emsal, çekme, yükseklik, otopark, yangın,
ruhsat) şu üçünü birlikte üret:

1. **Değer** — kaynaktan aynen alınan sayı/ifade.
2. **Kaynak** — belge adı, madde/sayfa numarası, tarih (ör. "Bakırköy Belediyesi İmar
   Durumu Belgesi, 12.03.2025" veya "1/1000 Uygulama İmar Planı Plan Notu Md. 4.2").
3. **Durum** — `Doğrulandı` (kaynaktan doğrudan okundu) veya `[KAYNAK GEREKLİ]`
   (kullanıcı henüz sağlamadı).

Kaynak eksikse Adım 0'da dur, `AskUserQuestion` ile tam olarak hangi belgenin eksik
olduğunu sor. Analizi eksik kaynakla "tamamlanmış" gibi sunma — eksik kalemleri raporun
"Doğrulanmamış Kalemler" bölümünde topla.
