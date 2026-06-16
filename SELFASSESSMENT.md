# Enesehinnang — AI reeglite fail

## 1. Kõige kasulikum reegel

Kõige kasulikumaks osutus **regressioonitestide nõue** (peatükk 4). Varasemalt parandatud vead võivad kergesti tagasi tulla, kui nende kohta pole testi, mis ebaõnnestub enne parandust ja läbib pärast. See sunnib AI-d mitte ainult parandust tegema, vaid ka veendu, et probleem on tõeliselt lahendatud.

## 2. Alles jäänud risk

Suurim allesjäänud risk on **branch protection'i puudumine**. AGENTS.md ütleb küll, et "ära kunagi commiti otse main", aga see pole tehniliselt blokeeritud. Kui AI peaks ignoreerima juhiseid või kui keegi push'ib käsitsi main'i, satub sinna kontrollimata kood. Selle lahendamiseks on vaja GitHubi branch protection reegleid.

## 3. Mida parandaksin järgmises versioonis

Järgmises versioonis lisaksin:

- **Konkreetsed näited** – iga reegli juurde üks reaalne näide heast ja halvast AI käitumisest just selle projekti kontekstis
- **Hook'ide kasutamine** – pre-commit hook, mis keelab commitid, kui testid või süntaksikontroll ebaõnnestuvad
- **Kaustapõhised juhised** – eraldi reeglid `app/` kaustale (ärateraamistikud) ja `tests/` kaustale (testimiskäsud)
- **Täpsem CI integreerimine** – GitHub Actions required status checks, et katkine CI blokeeriks PR merge'i automaatselt
