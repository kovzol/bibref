const {chromium} = require('playwright');
const fs = require('fs');
const path = require('path');
const os = require('os');
(async () => {
 const outputDir = fs.mkdtempSync(path.join(os.tmpdir(), 'bibref-browser-'));
 const browser = await chromium.launch({headless:true});
 const page = await browser.newPage({viewport:{width:1280,height:960}});
 const errors=[]; page.on('pageerror', e=>errors.push(e.message));
 const start=Date.now();
 await page.goto(process.env.BIBREF_WEB_URL || 'http://localhost:8080/index-jt-dt.html');
 await page.waitForFunction(()=>typeof bibref_term !== 'undefined',{timeout:120000});
 const loadMs=Date.now()-start;
 const checks=[
 ['help', ['Aleppo','HunRUF','KJV','LXX','SBLGNT','StatResGNT']],
 ['lookup HunRUF Matthew 1:1',['Jézus']],
 ['lookup HunRUF Psalms 47:10',['népek']],
 ['lookup LXX Psalms 46:10',['θε']],
 ['lookup Aleppo Isaiah 11:1',['ויצא']],
 ['lookup Aleppo Psalms 119:176',['תעיתי']],
 ['lookup Aleppo Exodus 12:46',['בבית']],
 ['lookup Aleppo Zechariah 12:10',['ושפכתי']],
 ['lookup LXX Genesis 1:1',['αρχη']],
 ['lookup SBLGNT Matthew 1:23',['παρθενος']],
 ['lookup StatResGNT Matthew 1:23',['παρθενος']],
 ['lookup KJV Matthew 12:18',['servant']],
 ['lookup SBLGNT I_Corinthians 2:16',['κυριου']],
 ['lookup1 LXX Genesis 1:1',['Stored']],
 ['lookup2 LXX Genesis 1:1',['Stored']],
 ['jaccard12',['0.000000']],
 ['tokens StatResGNT John 7:38',['4215','5204']],
 ['search LXX 4215 5204 2',['Psalms']],
 ];
 const results=[];
 const norm=s=>s.normalize('NFD').replace(/\p{M}/gu,'');
 for(const [command,fragments] of checks){
   const output=await page.evaluate(c=>bibref_wasm(c),command);
   const pass=fragments.every(f=>norm(output).includes(norm(f))) && !/not installed|Invalid book|Invalid verse|error/i.test(output);
   results.push({command,output,pass});
   await page.evaluate(c=>bibref_term.exec(c),command);
 }
 const vocab=await page.evaluate(()=>keywords);
 results.push({command:'completion vocabulary',pass:['HunRUF','Aleppo','I_Corinthians','lookup'].every(v=>vocab.includes(v)),output:vocab.filter(v=>['HunRUF','Aleppo','I_Corinthians','lookup'].includes(v))});
 await page.evaluate(()=>bibref_term.exec('lookup Aleppo Isaiah 11:1'));
 await page.screenshot({path:path.join(outputDir, 'hebrew.png'),fullPage:true});
 await page.evaluate(()=>bibref_term.exec('diagram svg'));
 const statement=fs.readFileSync(path.join(process.cwd(), 'statements/StatResGNT/John/John-1,23+6.brst'),'utf8').replace(/\s+/g,' ').trim();
 const output=await page.evaluate(c=>bibref_wasm(c),statement);
 results.push({command:'Statement John-1,23+6 / diagram svg',output,pass:output.includes('<svg')});
 await page.keyboard.insertText(statement);
 await page.keyboard.press('Enter');
 await page.waitForTimeout(200);
 await page.keyboard.insertText('lookup Hun');
 await page.keyboard.press('Tab');
 const completed=await page.evaluate(()=>bibref_term.get_command());
 results.push({command:'Tab completion lookup Hun',output:completed,pass:completed.includes('HunRUF')});
 await page.evaluate(()=>bibref_term.set_command(''));
 const svgCount=await page.locator('svg').count();
 await page.screenshot({path:path.join(outputDir, 'statement.png'),fullPage:true});
 const payload=await page.evaluate(()=>performance.getEntriesByType('resource').filter(r=>r.name.includes('bibref.')).map(r=>({name:r.name,durationMs:r.duration,bytes:r.decodedBodySize})));
 const report={loadMs,payload,errors,svgCount,results};
 fs.writeFileSync(path.join(outputDir, 'results.json'),JSON.stringify(report,null,2));
 console.log(JSON.stringify({outputDir,loadMs,payload,errors,svgCount,checks:results.map(({command,pass})=>({command,pass}))},null,2));
 await browser.close();
 if(results.some(r=>!r.pass)||errors.length||!svgCount) process.exitCode=1;
})().catch(e=>{console.error(e);process.exitCode=1});
