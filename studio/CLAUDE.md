# Two+ — Studio Instructions

This folder is the studio worksurface.

- Read `STUDIO.md` to find registered projects.
- Use the working-unit and default-jurisdiction settings in `STUDIO.md` unless a project records an explicit override.
- Firm-created Claude Code skills live in `.claude/skills/`; Codex skills use the parallel `.agents/skills/` root.
- Project facts live in each project’s `PROJECT.md`.
- Decision rationale lives in each project’s `decisions/` directory.
- Never treat the installed Architecture Studio plugin cache as a project or private-skill destination.
- This local version does not store workspace data with ALPA. Treat the configured LLM provider and account terms as the boundary for content sent to the model.

## Beceri kapsamı (Two+)

Two+'ın aktif çalışma alanı Türkiye'dir (İstanbul — Bakırköy, Kağıthane, Ümraniye ve
benzeri ilçeler). Architecture Studio plugin'i kuruluysa, aşağıdaki kapsam bu stüdyo
için geçerlidir:

- **Genel / yargı-bağımsız beceriler kullanımda kalır**: `environmental-analysis`,
  `mobility-analysis`, `demographics-analysis`, `site-history`, `workplace-programmer`,
  `product-*` (araştırma, eşleştirme, çizelge, temizleme), `epd-*` (EPD/GWP
  sürdürülebilirlik), `slide-deck-generator`, `color-palette-generator`,
  `resize-images`, `master-schedule`, `csv-to-sif`/`sif-to-csv`, `meeting-minutes`,
  `site-visit-report`, `tasklist`, `timetracker`, `workplan`, `project`,
  `studio-feedback`, `tool-catalog`, `learn`, `skill-maker`. Bunlar zaten
  `STUDIO.md`'deki metrik/jurisdiction varsayılanlarını (metrik, Türkiye, İstanbul)
  okur.
- **ABD/NYC'ye özgü beceriler ve `nyc-zoning-expert` agent'ı Two+ için kapsam
  dışıdır**: `nyc-acris`, `nyc-bsa`, `nyc-dob-permits`, `nyc-dob-violations`,
  `nyc-hpd`, `nyc-landmarks`, `nyc-property-report`, `zoning-analysis-nyc`. Bu
  beceriler PLUTO gibi NYC'ye özel açık verilere bağlıdır ve Türkiye parselleri için
  **hiçbir zaman** kullanılmaz — Türkiye'deki imar/parsel/ruhsat işleri için her zaman
  `turkiye-imar-parsel-analizi` kullanılır (bkz. `.claude/skills/turkiye-imar-parsel-analizi/`).
- **`zoning-envelope`** NYC'ye bağımlı bir veri kaynağı kullanmaz, yalnızca uyumlu bir
  "Envelope Data" JSON'u görselleştirir — Türkiye analizinden üretilecek bir envelope
  JSON'u ile de (kaynağı doğrulanmış olmak kaydıyla) kullanılabilir; kilitli değildir.
- **`occupancy-calculator` ve `spec-writer`** IBC/CSI (ABD) tabanlıdır. Türkiye
  işlerinde bunları yalnızca kavramsal çapraz kontrol için kullan; sayısal sonuçlarını
  doğrudan Türk mevzuatına (BYKHY, Planlı Alanlar İmar Yönetmeliği vb.) eşitleme —
  Türkiye'deki yangın/kaçış/ruhsat sorularını `turkiye-imar-parsel-analizi` üstlenir.

Türkiye'de bir arsa, imar, fizibilite veya kütle kararı gerektiren her istek —isim
verilmeden ("Ümraniye'deki şu ada-parsel için imar fizibilitesi çıkar" gibi) gelse
de— varsayılan olarak `turkiye-imar-parsel-analizi` becerisiyle işlenir. Bu beceri
resmî kaynak (imar durumu belgesi, plan notu, tapu/kadastro, ilgili mevzuat)
olmadan hiçbir sayısal değeri (Emsal, TAKS, yükseklik, çekme mesafesi vb.) kesin
kabul etmez, kanıtları tek bir tabloda ayrıştırır ve sonucu Yapılabilir / Doğrulama
şartıyla yapılabilir / Kısıtlı / No-Go kararlarından biriyle, kısa ve müşteriye
sunulabilir bir fizibilite notu formatında verir.
