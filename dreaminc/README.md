# dreaminc.io

Static site for DreamInc: plain HTML and CSS, no build step.

| File | Purpose |
| --- | --- |
| `index.html` | The page. Every block of copy to replace is marked `<!-- EDIT -->`. |
| `styles.css` | Styles, with light and dark mode that follow the visitor's system setting. |
| `favicon.svg` | Logo mark and browser-tab icon. |
| `CNAME` | Tells GitHub Pages to serve the site at `dreaminc.io`. |

Preview locally with `python3 -m http.server -d dreaminc 8000`, then open http://localhost:8000.

## Going live on dreaminc.io

`.github/workflows/deploy-dreaminc.yml` publishes this folder to GitHub Pages on every push to `main` or to the current default branch (`claude/manage-voss-advisory-6xIPn`) that touches `dreaminc/`. It can also be run by hand from the Actions tab.

1. Merge this branch into the default branch.
2. In the repo, go to **Settings → Pages** and set **Source** to **GitHub Actions**. GitHub Pages on a private repo needs a paid GitHub plan.
3. At the registrar for dreaminc.io, add these DNS records:
   - `A` records for `@`: `185.199.108.153`, `185.199.109.153`, `185.199.110.153`, `185.199.111.153`
   - `CNAME` record for `www`: `bremobonus.github.io`
4. Back in **Settings → Pages**, enter `dreaminc.io` as the custom domain. Tick **Enforce HTTPS** once the certificate is issued, which can take up to a day.

To host somewhere else (Netlify, Cloudflare Pages, or your own server), upload the contents of this folder as the site root.
