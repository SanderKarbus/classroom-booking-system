# Süsteemi testiplaan (ÕV2)

*Classroom Booking CLI Application (Python + PostgreSQL)*
 

---

## 1. Rakenduse ja keskkonna kirjeldus

**Nimetus:** Arvutiklasside broneerimissüsteemi CLI-rakendus

**Milleks mõeldud:** Python 3.x baasil loodud käsurearakendus (CLI), mis liidestub *psycopg2-binary* teegi kaudu PostgreSQL-andmebaasiga, et hallata klasside broneeringuid ja kuvada kasutusstatistikat.

**Olulisemad funktsioonid (kõik käivitatavad läbi `main.py`):**
- **Täielik broneeringute haldus (CRUD):** broneeringute vaatamine (List), lisamine (Add), muutmine (Update) ja kustutamine (Delete).
- **Statistika moodul:** klasside kasutusstatistika arvutamine ja kuvamine otse käsureale.
- **Andmebaasi ühenduse haldus:** keskne andmebaasi konfigureerimine ja turvaline ühendamine funktsiooni `get_connection()` kaudu (`db.py`).

---

## 2. Testimise eesmärk

Testimise eesmärk on kontrollida, et `main.py` käsurealiides ja selle CRUD-funktsioonid suhtleksid PostgreSQL andmebaasiga vigadeta ning suudaksid andmebaasi piiranguid (constraints) kasutajale korrektselt vahendada. Kontrollitakse rakenduse loogikat nii tavapärastes olukordades kui ka veatuvastust vigaste andmete sisestamisel.

---

## 3. Testjuhtumid

| ID | Testi nimetus | Tüüp | Testimise sammud | Oodatav tulemus | Tegelik tulemus | Märkused |
|---|---|---|---|---|---|---|
| TC01 | Broneeringute nimekirja kuvamine | Tavaline kasutusjuhtum | 1. Käivita rakendus: `python main.py`<br>2. Vali menüüst valik: "List bookings" | Rakendus teeb andmebaasi päringu ja kuvab terminalis korrektselt kõigi broneeringute nimekirja. | PASSED | Kuvab andmed loetavalt. |
| TC02 | Uue broneeringu lisamine | Tavaline kasutusjuhtum | 1. Vali menüüst: "Add booking"<br>2. Sisesta korrektsed andmed (klass, kuupäev, algus/lõpp, osalejad) | Rakendus salvestab kirje andmebaasi ja kuvab kinnituse. Andmed ilmuvad "List bookings" alla. | PASSED | Andmebaasi kirje lisandus edukalt. |
| TC03 | Veatuvastus: loogikaviga kellaaegades | Veaolukord | 1. Vali menüüst: "Add booking"<br>2. Sisesta algusajaks 14:00 ja lõppajaks 12:00 (varasem) | Pythoni kood tuvastab loogikavea juba enne andmebaasipäringu saatmist. Et programm ei *crash*’iks, kuvatakse CLI-s veateate: "Lõppaeg peab olema hilisem kui algusaeg!". | PASSED | Veatöötlus toimib koodi tasemel, CLI jääb stabiilseks. |
| TC04 | Piirjuhtum: topeltbroneeringu osaline kattuvus | Piir- / erijuhtum | 1. Süsteemis on broneering kell 10:00–11:30<br>2. Vali menüüst: "Add booking"<br>3. Ürita luua osaliselt kattuvat broneeringut samale klassile kell 11:00–12:00 | Süsteemi valideerimisloogika tuvastab kellaaegade osalise kattuvuse. Päring blokeeritakse ja kuvatakse teade: "Klass on sel perioodil juba hõivatud!". | PASSED | Süsteem tuvastab ja hoiab ära nii täielikud kui ka osalised kattumised. |
| TC05 | Broneeringu edukas kustutamine | Tavaline kasutusjuhtum | 1. Vali menüüst: "Delete booking"<br>2. Sisesta eksisteeriva broneeringu ID | Kirje eemaldatakse andmebaasist ja järgmisel kuvamisel seda broneeringut enam nimekirjas pole. | PASSED | DELETE-funktsioon töötab korrektselt. |
| TC06 | Veatuvastus: olematu ID-ga broneeringu kustutamine | Veaolukord | 1. Vali menüüst: "Delete booking"<br>2. Sisesta ID, mida andmebaasis kindlasti ei ole (nt 99999) | Pythoni skript kontrollib enne kustutamist ID olemasolu või tuvastab, et andmebaasis muudeti 0 rida. Et programm ei *crash*’iks, ei toimu vigast kustutamist ja kuvatakse teade: "Viga: sellise ID-ga broneeringut ei eksisteeri!". | PASSED | Programm püsib stabiilne, vigast kustutamist ei teostata. |
| TC07 | Statistikavaate kuvamine | Tavaline kasutusjuhtum | 1. Vali menüüst: "Show classroom usage statistics" | Rakendus käivitab koondpäringu ja kuvab käsureal klasside kasutusstatistika (nt kasutustunnid nädalas). | PASSED | Andmed arvutatakse reaalajas andmebaasist ja kuvatakse õigesti. |
