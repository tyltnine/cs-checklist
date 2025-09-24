// ----- Data (bilingual) -----
const DATA = [
  {
    key: "demolition",
    title_en: "DEMOLITION",
    title_es: "DEMOLICIÓN",
    steps: [
      { en: "Shut off main water. Drain toilet. Turn off the toilet’s supply valve.", es: "Cierra el suministro principal de agua. Drena el inodoro. Cierra la llave de paso del inodoro." },
      { en: "Disconnect toilet water supply; remove toilet for disposal. Clean wax ring from flange. Seal pipe with plastic to block sewer gases.", es: "Desconecta el suministro de agua del inodoro; retira el inodoro para desecharlo. Limpia el anillo de cera del flange. Sella el tubo con plástico para bloquear los gases del drenaje." },
      { en: "Turn off lavatory shutoff valves. Disconnect lavatory supply lines and drain.", es: "Cierra las llaves del lavabo. Desconecta las líneas de suministro y el desagüe del lavabo." },
      { en: "Unscrew and carefully remove the vanity (it will be given to friends; do not damage).", es: "Desatornilla y retira el vanity/gabinete con cuidado (se entregará a amigos; no lo dañes)." },
      { en: "Remove tile and cement backer board down to plywood. Clean and prep for new cement board.", es: "Retira el azulejo y la tabla de cemento hasta llegar al plywood. Limpia y prepara para instalar la nueva tabla de cemento." }
    ]
  },
  {
    key: "tile-prep",
    title_en: "TILE PREP",
    title_es: "PREPARACIÓN PARA AZULEJO",
    steps: [
      { en: "Level wood subfloor: shave high spots; fill any gaps wider than 1/8\" (use thin-set if needed).", es: "Nivela el subpiso de madera: rebaja puntos altos; rellena huecos mayores a 1/8\" (usa thin-set si es necesario)." },
      { en: "Dry-fit cement board perpendicular to joists; stagger joints; keep a 1/8\" gap around the perimeter and between boards; cut with oscillating tool (wear masks).", es: "Presenta en seco la tabla de cemento perpendicular a las vigas; desfasa las juntas; deja separación de 1/8\" en el perímetro y entre tablas; corta con herramienta vibratoria/oscilante (usa mascarilla)." },
      { en: "Set boards in thin-set with a notched trowel; screw boards to the subfloor.", es: "Asienta las tablas sobre thin-set aplicado con llana dentada; atorníllalas al subpiso." },
      { en: "Fill board joints with thin-set; apply alkali-resistant mesh tape; embed with thin-set.", es: "Rellena las juntas con thin-set; coloca cinta de malla resistente a álcalis; embébela con thin-set." }
    ]
  },
  {
    key: "tile-dry",
    title_en: "TILE INSTALL (Dry-fit)",
    title_es: "INSTALACIÓN DE AZULEJO (Prueba en seco)",
    steps: [
      { en: "Snap layout lines. Start at the door with a full tile centered in the opening; run long joints parallel to the door.", es: "Marca líneas guía. Empieza en la puerta con una loseta completa centrada en la entrada; orienta las juntas largas paralelas a la puerta." },
      { en: "Lay a staggered pattern (end joints at mid or at the 1/3 point of the long side); aim for no pieces under 4\" near the tub or side wall.", es: "Traza un patrón escalonado (juntas de extremo a la mitad o al 1/3 del lado largo); evita piezas menores a 4\" junto a la tina o pared lateral." },
      { en: "Dry-fit from the door toward the toilet area; extend left and right to check layout around the toilet; use 1/8\" spacers for joint width.", es: "Presenta en seco desde la puerta hacia el área del inodoro; extiende a izquierda y derecha para revisar el trazo alrededor del inodoro; usa separadores de 1/8\" para el ancho de junta." }
    ]
  },
  {
    key: "tile-mortar",
    title_en: "TILE INSTALL (Mortar)",
    title_es: "INSTALACIÓN DE AZULEJO (Con mortero)",
    steps: [
      { en: "Dampen the cement board before spreading thin-set.", es: "Humedece la tabla de cemento antes de aplicar el thin-set." },
      { en: "Begin at the crossing of snap lines; work into the far corners first, then back toward the door (don’t tile yourself into a corner).", es: "Comienza en el cruce de las líneas guía; trabaja primero hacia las esquinas alejadas y luego de regreso hacia la puerta (no te encierres en una esquina)." }
    ]
  }
];

// ----- Utilities -----
const STORAGE_KEY = "cs_bilingual_checklist_v1";

function saveState(state){ localStorage.setItem(STORAGE_KEY, JSON.stringify(state)); }
function loadState(){
  try{ const raw = localStorage.getItem(STORAGE_KEY); return raw ? JSON.parse(raw) : {}; }
  catch(e){ return {}; }
}

function buildSections(){
  const saved = loadState();
  const container = document.getElementById('sections');
  container.innerHTML = '';
  DATA.forEach((sec, sIdx)=>{
    const card = document.createElement('div');
    card.className = 'card';

    const head = document.createElement('div');
    head.className = 'section-head';

    const title = document.createElement('div');
    title.className = 'section-title';
    title.textContent = `${sec.title_en} / ${sec.title_es}`;

    const prog = document.createElement('div');
    prog.className = 'progress';
    prog.id = `prog-${sec.key}`;
    prog.textContent = '0 / 0';

    head.appendChild(title);
    head.appendChild(prog);
    card.appendChild(head);

    const badges = document.createElement('div');
    badges.className = 'badges';
    const btnCheck = document.createElement('button');
    btnCheck.className = 'btn success';
    btnCheck.textContent = 'Mark Section';
    const btnUncheck = document.createElement('button');
    btnUncheck.className = 'btn';
    btnUncheck.textContent = 'Unmark Section';
    badges.appendChild(btnCheck);
    badges.appendChild(btnUncheck);
    card.appendChild(badges);

    const details = document.createElement('details');
    if (sIdx === 0) details.open = true;
    const dl = document.createElement('div');

    sec.steps.forEach((st, i)=>{
      const id = `${sec.key}-${i}`;
      const item = document.createElement('div');
      item.className = 'item';

      const cb = document.createElement('input');
      cb.type = 'checkbox';
      cb.id = id;
      const isChecked = saved[id] === true;
      cb.checked = isChecked;

      const labels = document.createElement('label');
      labels.setAttribute('for', id);
      labels.className = 'labels';

      const en = document.createElement('div');
      en.className = 'en';
      en.textContent = `${i+1}. ${st.en}`;

      const es = document.createElement('div');
      es.className = 'es';
      es.textContent = `${i+1}. ${st.es}`;

      labels.appendChild(en);
      labels.appendChild(es);
      item.appendChild(cb);
      item.appendChild(labels);
      dl.appendChild(item);

      cb.addEventListener('change', ()=>{
        const state = loadState();
        state[id] = cb.checked;
        saveState(state);
        updateProgress();
      });
    });

    details.appendChild(dl);
    card.appendChild(details);
    container.appendChild(card);

    btnCheck.addEventListener('click', ()=>{
      const state = loadState();
      sec.steps.forEach((_, i)=>{
        const id = `${sec.key}-${i}`;
        state[id] = true;
        const el = document.getElementById(id);
        if (el) el.checked = true;
      });
      saveState(state);
      updateProgress();
    });
    btnUncheck.addEventListener('click', ()=>{
      const state = loadState();
      sec.steps.forEach((_, i)=>{
        const id = `${sec.key}-${i}`;
        state[id] = false;
        const el = document.getElementById(id);
        if (el) el.checked = false;
      });
      saveState(state);
      updateProgress();
    });
  });
  updateProgress();
}

function updateProgress(){
  let overallDone = 0, overallTotal = 0;
  DATA.forEach(sec=>{
    let sDone = 0;
    const total = sec.steps.length; overallTotal += total;
    sec.steps.forEach((_, i)=>{
      const el = document.getElementById(`${sec.key}-${i}`);
      if (el && el.checked){ sDone++; overallDone++; }
    });
    const elProg = document.getElementById(`prog-${sec.key}`);
    if (elProg) elProg.textContent = `${sDone} / ${total}`;
  });
  document.getElementById('overall').textContent = `Overall: ${overallDone} / ${overallTotal}`;
}

// Language toggle
document.addEventListener('click', (e)=>{
  const btn = e.target.closest('.lang-toggle .btn');
  if (!btn) return;
  document.querySelectorAll('.lang-toggle .btn').forEach(b=>b.classList.remove('active'));
  btn.classList.add('active');
  const lang = btn.dataset.lang;
  document.body.classList.remove('show-en','show-es','show-both');
  if (lang === 'en') document.body.classList.add('show-en');
  else if (lang === 'es') document.body.classList.add('show-es');
  else document.body.classList.add('show-both');
});

// Global actions
document.getElementById('markAll').addEventListener('click', ()=>{
  const state = loadState();
  DATA.forEach(sec=>{
    sec.steps.forEach((_, i)=>{
      const id = `${sec.key}-${i}`;
      state[id] = true;
      const el = document.getElementById(id);
      if (el) el.checked = true;
    });
  });
  saveState(state); updateProgress();
});
document.getElementById('unmarkAll').addEventListener('click', ()=>{
  const state = loadState();
  DATA.forEach(sec=>{
    sec.steps.forEach((_, i)=>{
      const id = `${sec.key}-${i}`;
      state[id] = false;
      const el = document.getElementById(id);
      if (el) el.checked = false;
    });
  });
  saveState(state); updateProgress();
});
document.getElementById('reset').addEventListener('click', ()=>{
  if (confirm('Clear all saved progress?')){
    localStorage.removeItem('cs_bilingual_checklist_v1');
    buildSections();
  }
});

// Init
buildSections();
