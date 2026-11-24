// Usage: node render.js <outDir> [views...]   (serve the folder holding node_modules/ and render.html on :8765 first)
const { chromium } = require('playwright');
(async () => {
  const out = process.argv[2], views = process.argv.slice(3);
  const b = await chromium.launch({ args: ['--use-gl=angle', '--use-angle=swiftshader', '--enable-unsafe-swiftshader', '--ignore-gpu-blocklist'] });
  for (const v of views) {
    const [view, variant = 'volt'] = v.split(':');
    const p = await b.newPage({ viewport: { width: 1600, height: 2000 }, deviceScaleFactor: 1 });
    p.on('pageerror', e => console.log('ERR', e.message)); p.on('console', m => m.type() === 'error' && console.log('console', m.text()));
    await p.goto(`http://127.0.0.1:8765/render.html?view=${view}&variant=${variant}`);
    await p.waitForFunction('window.__done===true', null, { timeout: 120000 });
    console.log(view, variant, JSON.stringify(await p.evaluate('window.__info')));
    await p.screenshot({ path: `${out}/bremo-one-${variant}-${view}.png` });
    await p.close();
  }
  await b.close();
})();
