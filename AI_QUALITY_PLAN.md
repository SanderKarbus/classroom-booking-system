# AI Quality Plan — Classroom Booking System

## 1. Valitud reeglite fail ja põhjendus

Valisin **AGENTS.md**, sest:

- OpenAI Codex, GitHub Copilot ja teised tänapäevased AI tööriistad toetavad AGENTS.md formaati
- Asub projekti juurkaustas, kus AI selle automaatselt leiab
- Võimaldab kihistada juhiseid (juurkaustas + alamkaustades)

## 2. Kasutatud allikad

1. **OpenAI Developers** – AGENTS.md kui "agentide README", build'i, testimise, stiili ja turvalisuse juhised. Allikas: https://platform.openai.com/docs/guides/agents#agents-readme
2. **Anthropic Claude API Docs** – CLAUDE.md ja hook'ide roll AI käitumise suunamisel. Allikas: https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview
3. **GitHub Blog** – GitHub Copilot coding agent toetab AGENTS.md, .github/copilot-instructions.md, CLAUDE.md, GEMINI.md. Allikas: https://github.blog/news-insights/product-news/github-copilot-coding-agent/
4. **Projekti olemasolev kood** – Classroom Booking System'i tegelik struktuur, mille põhjal reeglid kohandati.

## 3. Suurimad riskid AI-ga arendamisel

| Risk | Tõenäosus | Mõju |
|------|-----------|------|
| AI lisab mittetöötava funktsionaalsuse (nt ORM, async) | Kõrge | Suur |
| AI muudab otse main harusse ilma branchita | Keskmine | Väga suur |
| AI kustutab või muudab olulist koodi (nt db.py connection logic) | Keskmine | Suur |
| AI ignoreerib teste või ei lisa uutele funktsioonidele teste | Kõrge | Keskmine |
| AI lisab uusi dependency'sid ilma põhjenduseta | Keskmine | Keskmine |
| AI teeb liiga suuri muudatusi korraga (üle 5 faili) | Keskmine | Suur |

## 4. Kuidas reeglid aitavad vältida katkise koodi jõudmist main harusse

1. **Branch reeglid** – AGENTS.md keelab otsesed commitid main/master. AI peab looma feature branch'i.
2. **CI pipeline** – Iga PR korral käivitatakse automaatselt testid ja süntaksikontroll. Kui need ebaõnnestuvad, ei saa PR mergeda.
3. **Quality gates** – Enne töö lõpetamist peab AI käivitama `pytest tests/ -v` ja `python -m py_compile`.
4. **Regression tests** – Iga bug fix'i juurde peab lisama regressioonitesti.
5. **Scope control** – AI tohib muuta ainult ülesandega otseselt seotud faile.

## 5. Käsud, mis peavad enne lõpetamist õnnestuma

Enne töö valmismärkimist peavad läbima:

```bash
pytest tests/ -v
python -m py_compile app/main.py
python -m py_compile app/db.py
```

Kui CI on seadistatud, peab ka GitHub Actions workflow olema roheline.

## 6. Kuidas tagatakse, et vana töötav funktsionaalsus ei lähe katki

- **Regression protection** – Iga bug fix nõuab testi, mis ebaõnnestub enne parandust ja läbib pärast.
- **Olemasolevate testide säilitamine** – Reeglid keelavad testide eemaldamise ilma põhjenduseta.
- **Minimal change strategy** – AI peab tegema võimalikult väikseid ja täpseid muudatusi.
- **Arhitektuuri muutmise keeld** – CQRS, ORM, async jne on keelatud, sest need lõhuvad olemasoleva süsteemi.

## 7. Reeglid, mis vajavad tehnilist tuge

| Reegel | Tehniline tugi | Staatus |
|--------|---------------|---------|
| Ära commiti main/master | GitHub branch protection | ❌ Pole seadistatud |
| Testid peavad läbima enne merge | CI pipeline + required status checks | ⚠️ CI on olemas, aga pytest puudub |
| PR review enne merge'i | GitHub branch protection (required reviews) | ❌ Pole seadistatud |
| CI peab olema roheline | GitHub required status checks | ❌ Pole seadistatud |
| Feature branch'i nõue | GitHub branch protection (restrict push to main) | ❌ Pole seadistatud |

**Järeldus:** AGENTS.md üksi ei kaitse main haru. Täielikuks kaitseks tuleb GitHubis seadistada:
- Branch protection rule: keela push otse main/master
- Required status checks: nõua CI läbimist
- Required pull request reviews: vähemalt 1 review enne merge'i
