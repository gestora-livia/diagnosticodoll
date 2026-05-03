<!DOCTYPE html>
<html lang="pt-PT">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>D.O.L. — Diagnóstico Operacional de Lançamentos</title>
  
  <!-- Fontes Premium -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400;1,600&family=Montserrat:wght@300;400;600;700&display=swap" rel="stylesheet">
  
  <!-- Tailwind CSS para Estilização -->
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: {
            gold: '#947653',
            dark: '#5b3b03',
            cream: '#ffe1a1',
            offwhite: '#faf7f2',
            textdark: '#1a1a1a',
            textmid: '#2a1a00'
          },
          fontFamily: {
            serif: ['"Playfair Display"', 'serif'],
            sans: ['"Montserrat"', 'sans-serif'],
          }
        }
      }
    }
  </script>

  <!-- Ícones -->
  <script src="https://unpkg.com/lucide@latest"></script>

  <style>
    /* Animações suaves */
    .fade-in { animation: fadeIn 0.5s ease-in-out forwards; }
    @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
    
    /* Custom Scrollbar */
    ::-webkit-scrollbar { width: 8px; }
    ::-webkit-scrollbar-track { background: #faf7f2; }
    ::-webkit-scrollbar-thumb { background: #947653; border-radius: 4px; }
  </style>
</head>
<body class="bg-offwhite font-sans text-textmid selection:bg-gold/30 selection:text-dark min-h-screen">

  <!-- Header Fixo -->
  <header class="border-b border-[#e8e0d5] bg-white/90 backdrop-blur-md sticky top-0 z-50 shadow-sm">
    <div class="max-w-5xl mx-auto px-4 py-4 flex justify-between items-center">
      <div>
        <div class="font-serif text-2xl font-bold tracking-wider text-textdark leading-none">
          D.O.L.<span class="text-gold">.</span>
        </div>
        <div class="text-[10px] uppercase tracking-widest text-gold font-bold mt-1.5 hidden md:block">
          Diagnóstico Operacional de Lançamentos
        </div>
      </div>
      <div id="header-progress" class="hidden text-sm font-bold text-dark bg-offwhite px-4 py-1.5 rounded-full border border-[#e8e0d5]">
        <!-- Preenchido via JS -->
      </div>
    </div>
  </header>

  <!-- Container Principal da Aplicação -->
  <main id="app" class="animate-in fade-in duration-500"></main>

  <!-- Lógica da Aplicação -->
  <script>
    // --- DADOS DO DIAGNÓSTICO ---
    const PHASES = [
      {
        id: 'estrategia',
        name: '1. Estratégia e Planeamento',
        negative: [
          'Prazos são definidos de "boca" ou perdidos no WhatsApp.',
          'Não há um cronograma centralizado e visual da campanha.',
          'As metas não ficam claras para todos da equipa.',
          'A precificação e ofertas são decididas à última hora.'
        ],
        positive: [
          'Temos um briefing completo e documentado.',
          'Todos sabem exatamente quando começa/termina cada fase.',
          'Os KPIs (Metas) estão visíveis para acompanhamento.'
        ],
        img: 'https://via.placeholder.com/800x400/faf7f2/947653?text=Metodologia+S.O.L.+Estratégia'
      },
      {
        id: 'conteudo',
        name: '2. Produção de Conteúdo e Copy',
        negative: [
          'Copys são aprovadas no susto e geram retrabalho.',
          'Designers/Editores ficam parados à espera que a copy chegue.',
          'Perdemos muito tempo à procura dos arquivos finais.',
          'Falta de padronização nas pastas do Drive.'
        ],
        positive: [
          'Temos um fluxo claro de aprovação de Copy -> Design.',
          'Usamos templates e padrões de nomenclatura.',
          'O Especialista aprova tudo num só lugar.'
        ],
        img: 'https://via.placeholder.com/800x400/faf7f2/947653?text=Metodologia+S.O.L.+Conteúdo'
      },
      {
        id: 'prelancamento',
        name: '3. Captação e Pré-lançamento',
        negative: [
          'Não sabemos se todas as páginas estão tagueadas corretamente.',
          'Os criativos sobem na correria para o tráfego.',
          'Esquecemo-nos de testar a automação de e-mail/WhatsApp.',
          'A rotina de avisos nos grupos vira bagunça.'
        ],
        positive: [
          'Temos checklist de revisão de páginas (QA).',
          'As automações são testadas com antecedência.',
          'Existe um calendário definido de disparos nos grupos.'
        ],
        img: 'https://via.placeholder.com/800x400/faf7f2/947653?text=Metodologia+S.O.L.+Captação'
      },
      {
        id: 'lancamento',
        name: '4. Abertura e Carrinho',
        negative: [
          'A equipa de suporte fica sobrecarregada e sem direcionamento.',
          'Links de checkout quebram ou saem com preço errado.',
          'O acompanhamento de vendas é feito de forma manual e lenta.',
          'Falta de plano de contingência se a plataforma cair.'
        ],
        positive: [
          'A equipa de recuperação de vendas (suporte) tem guiões prontos.',
          'Temos um checklist de "Hora H" para abertura do carrinho.',
          'As métricas de conversão são atualizadas em tempo real.'
        ],
        img: 'https://via.placeholder.com/800x400/faf7f2/947653?text=Metodologia+S.O.L.+Carrinho'
      },
      {
        id: 'poslancamento',
        name: '5. Pós-lançamento e Debriefing',
        negative: [
          'Acaba o carrinho e a equipa "desaparece".',
          'Não fazemos reunião de Debriefing documentada.',
          'O onboarding dos novos alunos é confuso.',
          'Os mesmos erros repetem-se no próximo lançamento.'
        ],
        positive: [
          'Garantimos a entrega e suporte inicial aos alunos.',
          'Preenchemos um documento de "O que correu bem/mal".',
          'Criamos planos de ação baseados no lançamento anterior.'
        ],
        img: 'https://via.placeholder.com/800x400/faf7f2/947653?text=Metodologia+S.O.L.+Debriefing'
      }
    ];

    // ESTADO DA APLICAÇÃO
    let step = 0; // 0: Capture, 1-5: Questions, 6: Processing, 7: Results
    let userData = { name: '', email: '', phone: '' };
    let answers = {};
    let finalScore = 0;

    // Inicializar Respostas
    PHASES.forEach(p => { answers[p.id] = { negative: [], positive: [] }; });

    // --- FUNÇÕES DE CONTROLO ---

    function render() {
      const appDiv = document.getElementById('app');
      const headerProgress = document.getElementById('header-progress');
      
      // Atualizar Header Fixo
      if (step > 0 && step <= PHASES.length) {
        headerProgress.style.display = 'block';
        headerProgress.innerHTML = `Passo ${step} de ${PHASES.length}`;
      } else {
        headerProgress.style.display = 'none';
      }

      // Renderizar Ecrã Correto
      let content = '';
      if (step === 0) content = getCaptureHTML();
      else if (step > 0 && step <= PHASES.length) content = getQuestionnaireHTML();
      else if (step === 6) content = getProcessingHTML();
      else if (step === 7) content = getResultsHTML();

      appDiv.innerHTML = `<div class="fade-in">${content}</div>`;
      lucide.createIcons(); // Recarregar ícones
      window.scrollTo(0, 0);
    }

    function startDiagnosis(e) {
      e.preventDefault();
      userData.name = document.getElementById('input-name').value;
      userData.email = document.getElementById('input-email').value;
      userData.phone = document.getElementById('input-phone').value;
      
      console.log("Lead Capturada:", userData);
      // Aqui você integraria com o seu CRM/ActiveCampaign
      
      step = 1;
      render();
    }

    function toggleAnswer(phaseId, type, itemIndex) {
      const item = PHASES.find(p => p.id === phaseId)[type][itemIndex];
      const list = answers[phaseId][type];
      
      if (list.includes(item)) {
        answers[phaseId][type] = list.filter(i => i !== item);
      } else {
        list.push(item);
      }
      render(); // Atualizar UI
    }

    function prevStep() {
      step--;
      render();
    }

    function nextStep() {
      if (step < PHASES.length) {
        step++;
        render();
      } else {
        calculateResults();
      }
    }

    function calculateResults() {
      step = 6;
      render(); // Mostra Processing

      let totalNegative = 0, totalPositive = 0, selectedNegative = 0, selectedPositive = 0;

      PHASES.forEach(phase => {
        totalNegative += phase.negative.length;
        totalPositive += phase.positive.length;
        selectedNegative += answers[phase.id].negative.length;
        selectedPositive += answers[phase.id].positive.length;
      });

      const penaltyWeight = 60 / totalNegative; 
      const bonusWeight = 40 / totalPositive; 

      let scoreCalc = 100 - (selectedNegative * penaltyWeight);
      const missedPositives = totalPositive - selectedPositive;
      scoreCalc -= (missedPositives * bonusWeight);

      finalScore = Math.max(0, Math.round(scoreCalc));

      // Simular carregamento
      setTimeout(() => {
        step = 7;
        render();
      }, 2500);
    }

    function formatMissingProcess(item) {
      const map = {
        'Temos um briefing completo e documentado.': 'Ausência de um briefing completo e documentado.',
        'Todos sabem exatamente quando começa/termina cada fase.': 'Falta de clareza na equipa sobre o início e fim de cada fase.',
        'Os KPIs (Metas) estão visíveis para acompanhamento.': 'Os KPIs (Metas) da campanha não estão visíveis ou centralizados.',
        'Temos um fluxo claro de aprovação de Copy -> Design.': 'Não existe um fluxo claro de aprovação entre Copy e Design.',
        'Usamos templates e padrões de nomenclatura.': 'Falta de padronização (templates e nomenclatura) nos arquivos.',
        'O Especialista aprova tudo num só lugar.': 'O processo de aprovação do Especialista está descentralizado.',
        'Temos checklist de revisão de páginas (QA).': 'Ausência de um checklist de revisão e qualidade das páginas (QA).',
        'As automações são testadas com antecedência.': 'Falta de uma rotina de testes prévios para as automações.',
        'Existe um calendário definido de disparos nos grupos.': 'Não há um calendário definido para os disparos nos grupos de WhatsApp.',
        'A equipa de recuperação de vendas (suporte) tem guiões prontos.': 'A equipa de suporte não tem guiões prontos para recuperação de vendas.',
        'Temos um checklist de "Hora H" para abertura do carrinho.': 'Falta um checklist estruturado de "Hora H" para o dia da abertura.',
        'As métricas de conversão são atualizadas em tempo real.': 'As métricas de conversão não estão a ser acompanhadas em tempo real.',
        'Garantimos a entrega e suporte inicial aos alunos.': 'O processo de entrega e suporte inicial aos alunos carece de estruturação.',
        'Preenchemos um documento de "O que correu bem/mal".': 'Ausência de um documento de Debriefing estruturado no pós-venda.',
        'Criamos planos de ação baseados no lançamento anterior.': 'Não são criados planos de ação baseados nos dados e erros do lançamento anterior.'
      };
      return map[item] || item;
    }

    // --- TEMPLATES HTML ---

    function getCaptureHTML() {
      return `
        <div class="max-w-2xl mx-auto text-center px-4 py-12">
          <div class="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-cream/50 text-dark text-sm font-semibold mb-6 border border-gold/30">
            <i data-lucide="activity" class="w-4 h-4"></i> Ferramenta de Avaliação Gratuita
          </div>
          <h1 class="text-4xl md:text-5xl font-serif text-textdark mb-4 leading-tight">
            Descubra onde a sua operação de lançamento está a <span class="text-gold italic">perder dinheiro.</span>
          </h1>
          <p class="text-dark text-lg mb-10 max-w-xl mx-auto opacity-80">
            O <strong class="text-textdark">D.O.L. (Diagnóstico Operacional de Lançamentos)</strong> avalia 5 fases críticas do seu negócio e revela os gargalos operacionais que travam a sua escala.
          </p>

          <form onsubmit="startDiagnosis(event)" class="bg-white border border-[#e8e0d5] p-8 rounded-2xl shadow-xl text-left">
            <div class="space-y-4">
              <div>
                <label class="block text-sm font-semibold text-dark mb-1">O seu Nome</label>
                <div class="relative">
                  <i data-lucide="user" class="absolute left-3 top-1/2 -translate-y-1/2 text-gold w-4 h-4"></i>
                  <input required id="input-name" type="text" class="w-full bg-offwhite border border-[#e8e0d5] text-textdark rounded-lg py-3 pl-10 pr-4 focus:outline-none focus:border-gold focus:ring-1 focus:ring-gold transition-all" placeholder="Ex: João Silva" value="${userData.name}">
                </div>
              </div>
              <div>
                <label class="block text-sm font-semibold text-dark mb-1">O seu melhor E-mail</label>
                <div class="relative">
                  <i data-lucide="mail" class="absolute left-3 top-1/2 -translate-y-1/2 text-gold w-4 h-4"></i>
                  <input required id="input-email" type="email" class="w-full bg-offwhite border border-[#e8e0d5] text-textdark rounded-lg py-3 pl-10 pr-4 focus:outline-none focus:border-gold focus:ring-1 focus:ring-gold transition-all" placeholder="joao@suaempresa.com" value="${userData.email}">
                </div>
              </div>
              <div>
                <label class="block text-sm font-semibold text-dark mb-1">WhatsApp (com código de área)</label>
                <div class="relative">
                  <i data-lucide="phone" class="absolute left-3 top-1/2 -translate-y-1/2 text-gold w-4 h-4"></i>
                  <input required id="input-phone" type="tel" class="w-full bg-offwhite border border-[#e8e0d5] text-textdark rounded-lg py-3 pl-10 pr-4 focus:outline-none focus:border-gold focus:ring-1 focus:ring-gold transition-all" placeholder="(11) 91234-5678" value="${userData.phone}">
                </div>
              </div>
            </div>
            <button type="submit" class="w-full mt-8 bg-dark hover:bg-gold text-white font-bold py-4 px-6 rounded-lg shadow-lg hover:shadow-xl transition-all flex justify-center items-center gap-2">
              Iniciar Diagnóstico <i data-lucide="arrow-right" class="w-5 h-5"></i>
            </button>
            <p class="text-center text-dark/60 text-xs mt-4">Os seus dados estão seguros. Demora menos de 3 minutos.</p>
          </form>
        </div>
      `;
    }

    function getQuestionnaireHTML() {
      const pIndex = step - 1;
      const phase = PHASES[pIndex];
      const progress = ((step - 1) / PHASES.length) * 100;

      let negativeHTML = phase.negative.map((item, idx) => {
        const isSelected = answers[phase.id].negative.includes(item);
        return `
          <div onclick="toggleAnswer('${phase.id}', 'negative', ${idx})" class="cursor-pointer p-4 rounded-xl border transition-all duration-200 flex items-start gap-3 ${isSelected ? 'bg-red-50 border-red-300 text-red-900 shadow-sm' : 'bg-offwhite border-[#e8e0d5] text-textmid hover:border-gold/50'}">
            <div class="mt-0.5 w-5 h-5 rounded flex-shrink-0 flex items-center justify-center border ${isSelected ? 'bg-red-600 border-red-600 text-white' : 'border-gold/40 bg-white'}">
              ${isSelected ? '<i data-lucide="check" class="w-3.5 h-3.5"></i>' : ''}
            </div>
            <span class="leading-tight">${item}</span>
          </div>
        `;
      }).join('');

      let positiveHTML = phase.positive.map((item, idx) => {
        const isSelected = answers[phase.id].positive.includes(item);
        return `
          <div onclick="toggleAnswer('${phase.id}', 'positive', ${idx})" class="cursor-pointer p-4 rounded-xl border transition-all duration-200 flex items-start gap-3 ${isSelected ? 'bg-emerald-50 border-emerald-300 text-emerald-900 shadow-sm' : 'bg-offwhite border-[#e8e0d5] text-textmid hover:border-gold/50'}">
            <div class="mt-0.5 w-5 h-5 rounded flex-shrink-0 flex items-center justify-center border ${isSelected ? 'bg-emerald-600 border-emerald-600 text-white' : 'border-gold/40 bg-white'}">
              ${isSelected ? '<i data-lucide="check" class="w-3.5 h-3.5"></i>' : ''}
            </div>
            <span class="leading-tight">${item}</span>
          </div>
        `;
      }).join('');

      return `
        <div class="max-w-3xl mx-auto px-4 py-8">
          <div class="mb-8">
            <div class="flex justify-between text-xs font-semibold text-dark mb-2 uppercase tracking-wider">
              <span>Fase ${step} de ${PHASES.length}</span>
              <span>${Math.round(progress)}% Concluído</span>
            </div>
            <div class="w-full bg-[#e8e0d5] h-2 rounded-full overflow-hidden">
              <div class="bg-gold h-full transition-all duration-500 ease-out" style="width: ${progress}%"></div>
            </div>
          </div>

          <div class="bg-white border border-[#e8e0d5] rounded-2xl p-6 md:p-8 shadow-lg">
            <h2 class="text-2xl md:text-3xl font-serif text-textdark mb-2">${phase.name}</h2>
            <p class="text-dark/80 mb-8">Selecione as opções que representam a realidade atual da sua operação.</p>

            <div class="space-y-8">
              <div>
                <h3 class="text-red-700 font-bold mb-4 flex items-center gap-2">
                  <i data-lucide="alert-circle" class="w-5 h-5"></i> Quais destes problemas enfrenta?
                </h3>
                <div class="space-y-3">${negativeHTML}</div>
              </div>
              <div>
                <h3 class="text-emerald-700 font-bold mb-4 flex items-center gap-2">
                  <i data-lucide="check-circle-2" class="w-5 h-5"></i> Quais destes processos já possui?
                </h3>
                <div class="space-y-3">${positiveHTML}</div>
              </div>
            </div>
          </div>

          <div class="flex justify-between mt-8">
            <button onclick="prevStep()" class="px-6 py-3 text-dark font-semibold hover:text-gold flex items-center gap-2 transition-colors">
              <i data-lucide="chevron-left" class="w-5 h-5"></i> Voltar
            </button>
            
            <button onclick="nextStep()" class="${step < PHASES.length ? 'bg-gold hover:bg-dark text-white' : 'bg-emerald-600 hover:bg-emerald-700 text-white'} font-bold px-8 py-3 rounded-lg flex items-center gap-2 transition-colors shadow-md">
              ${step < PHASES.length ? 'Próxima Fase <i data-lucide="chevron-right" class="w-5 h-5"></i>' : 'Ver o Meu Resultado <i data-lucide="activity" class="w-5 h-5"></i>'}
            </button>
          </div>
        </div>
      `;
    }

    function getProcessingHTML() {
      return `
        <div class="min-h-[60vh] flex flex-col items-center justify-center text-center px-4">
          <div class="relative w-24 h-24 mb-8">
            <div class="absolute inset-0 border-4 border-[#e8e0d5] rounded-full"></div>
            <div class="absolute inset-0 border-4 border-gold rounded-full border-t-transparent animate-spin"></div>
            <div class="absolute inset-0 flex items-center justify-center text-gold">
              <i data-lucide="activity" class="w-8 h-8"></i>
            </div>
          </div>
          <h2 class="text-2xl font-serif text-textdark mb-2">A analisar a sua operação...</h2>
          <p class="text-dark">Cruzando dados de gargalos e eficiências.</p>
        </div>
      `;
    }

    function getResultsHTML() {
      const isGood = finalScore >= 80;
      const isWarn = finalScore >= 50 && finalScore < 80;
      const isBad = finalScore < 50;

      let colorClass = isGood ? 'text-emerald-600' : (isWarn ? 'text-amber-600' : 'text-red-600');
      let bgClass = isGood ? 'bg-emerald-100' : (isWarn ? 'bg-amber-100' : 'bg-red-100');
      let label = isGood ? 'Operação Otimizada' : (isWarn ? 'Requer Atenção' : 'Operação Caótica');
      let message = isGood ? "Parabéns! A sua operação está a rodar de forma redonda. O foco agora é escalar sem perder a qualidade dos processos." :
                   (isWarn ? "A sua operação funciona, mas com muito atrito. Está a deixar dinheiro na mesa e a sobrecarregar a equipa. É preciso padronizar e otimizar os processos." :
                             "Alerta Crítico: A sua operação depende inteiramente de força bruta e memória. Escalar neste cenário vai gerar burnout na equipa e queima de caixa.");

      let firstName = userData.name.trim().split(' ') || '';

      let detailsHTML = '';
      PHASES.forEach(phase => {
        const selectedNegatives = answers[phase.id].negative;
        const missedPositives = phase.positive.filter(p => !answers[phase.id].positive.includes(p));
        
        if (selectedNegatives.length === 0 && missedPositives.length === 0) return;

        let negList = selectedNegatives.map(item => `
          <li class="text-dark text-sm flex items-start gap-2 bg-red-50/50 p-2 rounded">
            <span class="text-red-500 mt-0.5 font-bold">✕</span> ${item}
          </li>
        `).join('');

        let posList = missedPositives.map(item => `
          <li class="text-dark text-sm flex items-start gap-2 bg-amber-50/50 p-2 rounded leading-tight">
            <span class="text-amber-500 mt-0.5 font-bold">—</span> ${formatMissingProcess(item)}
          </li>
        `).join('');

        detailsHTML += `
          <div class="bg-white border border-[#e8e0d5] rounded-xl p-6 shadow-sm mb-6">
            <div class="flex items-center gap-3 mb-4">
              <div class="w-8 h-8 rounded-full bg-offwhite flex items-center justify-center text-gold font-bold border border-[#e8e0d5]">
                ${phase.name.charAt(0)}
              </div>
              <h4 class="text-xl font-bold text-textdark">${phase.name.substring(3)}</h4>
            </div>
            <div class="grid md:grid-cols-2 gap-6">
              <div>
                ${negList ? `<div class="mb-4"><span class="text-red-600 text-sm font-bold flex items-center gap-1 mb-3"><i data-lucide="shield-alert" class="w-4 h-4"></i> Gargalos Encontrados:</span><ul class="space-y-2">${negList}</ul></div>` : ''}
              </div>
              <div>
                ${posList ? `<div><span class="text-amber-600 text-sm font-bold flex items-center gap-1 mb-3"><i data-lucide="alert-circle" class="w-4 h-4"></i> Processos em Falta:</span><ul class="space-y-2">${posList}</ul></div>` : ''}
              </div>
            </div>
            <div class="mt-8 pt-6 border-t border-[#e8e0d5] bg-offwhite -mx-6 -mb-6 p-6 rounded-b-xl">
              <p class="text-sm text-textmid mb-4">
                <strong class="text-gold uppercase tracking-wide text-xs block mb-1">A Solução Integrada</strong> 
                Veja como o processo <strong class="text-dark">S.O.L.</strong> estrutura e centraliza esta fase:
              </p>
              <img src="${phase.img}" alt="Estruturação da fase" class="w-full rounded-lg border border-[#e8e0d5] shadow-sm">
            </div>
          </div>
        `;
      });

      let ctaHTML = finalScore < 70 ? `
        <div class="bg-dark border-4 border-gold rounded-2xl p-8 md:p-12 text-center max-w-3xl mx-auto shadow-2xl relative overflow-hidden mt-12">
          <div class="absolute top-0 right-0 w-64 h-64 bg-cream opacity-5 rounded-full blur-3xl -translate-y-1/2 translate-x-1/2"></div>
          <i data-lucide="handshake" class="mx-auto text-cream mb-6 relative z-10 w-12 h-12 stroke-[1.5]"></i>
          <h3 class="text-2xl md:text-4xl font-serif text-white mb-4 relative z-10">Pare de perder dinheiro por desorganização.</h3>
          <p class="text-offwhite mb-8 text-lg relative z-10 max-w-2xl mx-auto leading-relaxed">
            O <strong class="text-cream">Sistema Operacional de Lançamentos (S.O.L.)</strong> não é apenas um template. É um <span class="underline decoration-gold decoration-2">processo de implementação construído lado a lado consigo</span>. Nós desenhamos o fluxo perfeito para a sua realidade e implementamos tudo para transformar a sua operação caótica numa máquina profissional.
          </p>
          <div class="relative z-10">
            <a href="#link-de-venda-aqui" class="inline-flex justify-center items-center gap-2 bg-cream hover:bg-white text-dark font-bold py-4 px-10 rounded-lg w-full md:w-auto transition-all hover:scale-105 shadow-xl text-lg">
              Quero Construir o Meu Processo <i data-lucide="trending-up" class="w-5 h-5 ml-1"></i>
            </a>
            <p class="text-cream/70 text-sm mt-4 font-medium">Implementação guiada para estruturar a sua agência.</p>
          </div>
        </div>
      ` : '';

      return `
        <div class="max-w-4xl mx-auto px-4 py-8 pb-24">
          <div class="text-center mb-10">
            <h1 class="text-sm font-bold tracking-widest text-gold uppercase mb-1">Relatório D.O.L. Gerado</h1>
            <div class="text-[11px] font-bold tracking-widest text-dark/60 uppercase mb-4">Diagnóstico Operacional de Lançamentos</div>
            <h2 class="text-3xl md:text-4xl font-serif text-textdark">Aqui está o seu diagnóstico, ${firstName}</h2>
          </div>

          <div class="bg-white border border-[#e8e0d5] rounded-3xl p-8 mb-10 relative overflow-hidden flex flex-col md:flex-row items-center gap-8 shadow-xl">
            <div class="absolute top-0 left-0 w-full h-1 bg-gradient-to-r from-red-500 via-amber-400 to-emerald-500"></div>
            
            <div class="relative w-48 h-48 flex-shrink-0 flex items-center justify-center rounded-full border-8 border-offwhite bg-white shadow-[0_0_20px_rgba(0,0,0,0.05)]">
              <div class="text-center">
                <span class="text-5xl font-bold block ${colorClass}">${finalScore}%</span>
                <span class="text-dark/60 text-xs uppercase tracking-wider font-bold mt-1 block">Eficiência</span>
              </div>
            </div>

            <div>
              <div class="inline-block px-4 py-1.5 rounded-full text-sm font-bold mb-4 ${bgClass} ${colorClass} border border-current/20">
                Diagnóstico: ${label}
              </div>
              <p class="text-textmid text-lg leading-relaxed mb-6">${message}</p>
            </div>
          </div>

          ${detailsHTML ? `<h3 class="text-2xl font-serif text-textdark mb-6 border-b border-[#e8e0d5] pb-4">Detalhamento dos Gargalos</h3> ${detailsHTML}` : ''}
          
          ${ctaHTML}
        </div>
      `;
    }

    // Inicializar app
    window.onload = render;
  </script>
</body>
</html>
