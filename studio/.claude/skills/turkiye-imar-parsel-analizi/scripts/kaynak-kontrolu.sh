#!/usr/bin/env bash
# kaynak-kontrolu.sh — SKILL.md'nin son adımında, rapor tamamlanmadan önce çalıştırılır.
#
# Bu script "denetlenebilir karar aracı" ilkesini mekanik olarak uygular:
#   - Doldurulmamış şablon alanı ({{...}}) kalmışsa HATA verir (rapor yarım kalmış demektir).
#   - Karar satırı (Yapılabilir / Doğrulama şartıyla yapılabilir / Kısıtlı / No-Go)
#     yoksa veya bu dört değerden biri değilse HATA verir.
#   - 11 kanıt kalemi başlıklarından biri raporda yoksa HATA verir (kontrol listesi
#     atlanmış demektir).
#   - Uyarı bloğu + machine-readable marker yoksa HATA verir.
#   - [KAYNAK GEREKLİ] işaretlerini HATA saymaz ama tek tek listeler — bunlar rapor
#     tamamlanmadan önce ekibin görmesi gereken açık kalemlerdir.
#
# Kullanım: kaynak-kontrolu.sh <rapor.md>

set -euo pipefail

if [ "$#" -ne 1 ]; then
  printf 'kullanım: %s <rapor.md>\n' "$0" >&2
  exit 2
fi

REPORT="$1"
if [ ! -f "$REPORT" ]; then
  printf 'kaynak-kontrolu: dosya bulunamadı: %s\n' "$REPORT" >&2
  exit 2
fi

ERRORS=0

fail() {
  printf 'HATA: %s\n' "$1" >&2
  ERRORS=$((ERRORS + 1))
}

# 1. Doldurulmamış şablon alanı kaldı mı?
UNFILLED=$(grep -noE '\{\{[^}]*\}\}' "$REPORT" || true)
if [ -n "$UNFILLED" ]; then
  fail "doldurulmamış şablon alanları var (aşağıda satır:içerik):
$UNFILLED"
fi

# 2. Karar satırı var mı ve geçerli mi?
DECISION_LINE=$(grep -oE '\*\*(Yapılabilir|Doğrulama şartıyla yapılabilir|Kısıtlı|No-Go)\*\*' "$REPORT" || true)
if [ -z "$DECISION_LINE" ]; then
  fail "geçerli bir karar satırı bulunamadı — 'Yapılabilir', 'Doğrulama şartıyla yapılabilir', 'Kısıtlı' veya 'No-Go' değerlerinden birini içeren kalın (**...**) bir satır olmalı."
fi

# 3. 11 kanıt kalemi başlığı raporda geçiyor mu?
KALEMLER=(
  "İmar durumu"
  "Plan notu"
  "Tapu"
  "TAKS"
  "Çekme"
  "Yükseklik"
  "Erişim"
  "Otopark"
  "Yangın"
  "Ruhsat"
  "Teknik risk"
)
for kalem in "${KALEMLER[@]}"; do
  if ! grep -qF "$kalem" "$REPORT"; then
    fail "kontrol listesi kalemi raporda bulunamadı: '$kalem' (bkz. references/kontrol-listesi.md)"
  fi
done

# 4. Uyarı bloğu + marker var mı?
MARKER_RE='^[[:space:]]*<!-- two-plus-studio:imar-analizi-dogrulanmali -->[[:space:]]*$'
if ! grep -qE "$MARKER_RE" "$REPORT"; then
  fail "uyarı marker'ı eksik: <!-- two-plus-studio:imar-analizi-dogrulanmali --> dosyanın son satırı olmalı."
else
  MARKER_COUNT=$(grep -cE "$MARKER_RE" "$REPORT")
  if [ "$MARKER_COUNT" -gt 1 ]; then
    fail "marker $MARKER_COUNT kez geçiyor; tam olarak bir kez, dosyanın sonunda olmalı."
  fi
fi
if ! grep -qF 'ön değerlendirme amaçlı bir yapay zekâ analizidir' "$REPORT"; then
  fail "kanonik uyarı metni eksik (bkz. assets/fizibilite-notu-sablonu.md sonundaki blok)."
fi

# 5. [KAYNAK GEREKLİ] işaretlerini listele (hata değil, bilgi).
FLAGGED=$(grep -noF '[KAYNAK GEREKLİ]' "$REPORT" || true)
if [ -n "$FLAGGED" ]; then
  FLAG_COUNT=$(printf '%s\n' "$FLAGGED" | wc -l | tr -d ' ')
  printf 'BİLGİ: %s satırda [KAYNAK GEREKLİ] işareti var — bunlar "Doğrulanmamış Kalemler" bölümünde açıkça listelenmeli:\n%s\n' "$FLAG_COUNT" "$FLAGGED"
fi

if [ "$ERRORS" -gt 0 ]; then
  printf '\nSonuç: %s hata bulundu — rapor tamamlanmadan bunlar çözülmeli.\n' "$ERRORS" >&2
  exit 1
fi

printf 'Sonuç: yapısal kontrol geçti. [KAYNAK GEREKLİ] varsa yukarıdaki listeyi rapora ve karar gerekçesine yansıt.\n'
