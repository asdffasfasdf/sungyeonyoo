<!DOCTYPE html>
<html lang="ko" class="scroll-smooth">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>유성연 | Backend Developer</title>
<script src="https://cdn.tailwindcss.com"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@300;400;500;600;700&family=Syne:wght@700;800&family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">

<script>
  tailwind.config = {
    theme: {
      extend: {
        colors: {
          bg:      '#0d0d0d',
          surface: '#111111',
          panel:   '#161616',
          border:  '#222222',
          muted:   '#333333',
          dim:     '#555555',
          subtle:  '#888888',
          body:    '#cccccc',
          bright:  '#f0f0f0',
          accent:  '#00e5a0',
          acc2:    '#00b87a',
          warn:    '#ff6b35',
        },
        fontFamily: {
          mono:    ['JetBrains Mono', 'monospace'],
          display: ['Syne', 'sans-serif'],
          sans:    ['Noto Sans KR', 'sans-serif'],
        },
      }
    }
  }
</script>

<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }
  html { background: #0d0d0d; }
  body { background: #0d0d0d; color: #cccccc; font-family: 'Noto Sans KR', sans-serif; overflow-x: hidden; }

  /* Scanline overlay */
  body::before {
    content: '';
    position: fixed;
    inset: 0;
    background: repeating-linear-gradient(0deg, transparent, transparent 2px, rgba(0,229,160,0.012) 2px, rgba(0,229,160,0.012) 4px);
    pointer-events: none;
    z-index: 9999;
  }

  /* Custom scrollbar */
  ::-webkit-scrollbar { width: 4px; }
  ::-webkit-scrollbar-track { background: #111; }
  ::-webkit-scrollbar-thumb { background: #00e5a0; border-radius: 2px; }

  /* Glow effect */
  .accent-glow { text-shadow: 0 0 30px rgba(0,229,160,0.4); }
  .box-glow { box-shadow: 0 0 0 1px rgba(0,229,160,0.15), 0 0 40px rgba(0,229,160,0.05); }
  .box-glow-hover:hover { box-shadow: 0 0 0 1px rgba(0,229,160,0.4), 0 0 30px rgba(0,229,160,0.1); }

  /* Noise texture */
  .noise::after {
    content: '';
    position: absolute;
    inset: 0;
    background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)' opacity='0.03'/%3E%3C/svg%3E");
    pointer-events: none;
    opacity: 0.4;
  }

  /* Animations */
  @keyframes fadeUp {
    from { opacity: 0; transform: translateY(20px); }
    to   { opacity: 1; transform: translateY(0); }
  }
  @keyframes blink {
    0%, 100% { opacity: 1; } 50% { opacity: 0; }
  }
  @keyframes slideIn {
    from { transform: translateX(-100%); opacity: 0; }
    to   { transform: translateX(0); opacity: 1; }
  }
  @keyframes pulse-glow {
    0%, 100% { box-shadow: 0 0 0 0 rgba(0,229,160,0.3); }
    50%       { box-shadow: 0 0 0 6px rgba(0,229,160,0); }
  }

  .animate-fade-up { animation: fadeUp 0.7s ease both; }
  .cursor-blink { animation: blink 1s step-end infinite; }
  .pulse-glow { animation: pulse-glow 2.5s ease infinite; }

  /* Reveal on scroll */
  .reveal {
    opacity: 0;
    transform: translateY(28px);
    transition: opacity 0.65s ease, transform 0.65s ease;
  }
  .reveal.visible { opacity: 1; transform: none; }

  /* Nav active state */
  nav a.active { color: #00e5a0; }
  nav a.active::after {
    content: '';
    display: block;
    height: 1px;
    background: #00e5a0;
    box-shadow: 0 0 8px rgba(0,229,160,0.6);
    margin-top: 2px;
  }

  /* Terminal cursor */
  .terminal-cursor::after {
    content: '_';
    animation: blink 0.8s step-end infinite;
    color: #00e5a0;
  }

  /* Tag styles */
  .tag {
    font-family: 'JetBrains Mono', monospace;
    font-size: 11px;
    padding: 3px 9px;
    background: rgba(0,229,160,0.06);
    border: 1px solid rgba(0,229,160,0.18);
    color: #888;
    border-radius: 2px;
    transition: all 0.2s;
  }
  .tag:hover { background: rgba(0,229,160,0.12); color: #00e5a0; }
  .tag.primary {
    background: rgba(0,229,160,0.1);
    border-color: rgba(0,229,160,0.35);
    color: #00e5a0;
  }

  /* Project card */
  .project-card {
    background: #111;
    border: 1px solid #222;
    transition: all 0.3s;
    position: relative;
    overflow: hidden;
  }
  .project-card::before {
    content: '';
    position: absolute;
    left: 0; top: 0; bottom: 0;
    width: 2px;
    background: #00e5a0;
    transform: scaleY(0);
    transform-origin: bottom;
    transition: transform 0.3s ease;
  }
  .project-card:hover::before { transform: scaleY(1); }
  .project-card:hover { border-color: rgba(0,229,160,0.3); background: #141414; }

  /* Filter buttons */
  .filter-btn {
    font-family: 'JetBrains Mono', monospace;
    font-size: 11px;
    padding: 6px 14px;
    border: 1px solid #222;
    color: #555;
    cursor: pointer;
    transition: all 0.2s;
    background: transparent;
    letter-spacing: 0.05em;
  }
  .filter-btn:hover { border-color: #444; color: #999; }
  .filter-btn.active {
    border-color: rgba(0,229,160,0.5);
    color: #00e5a0;
    background: rgba(0,229,160,0.06);
  }

  /* Tech grid hover */
  .tech-cell {
    background: #111;
    border: 1px solid #1a1a1a;
    transition: all 0.25s;
    cursor: default;
  }
  .tech-cell:hover { background: #161616; border-color: rgba(0,229,160,0.2); }

  /* Hero grid lines */
  .hero-grid {
    background-image:
      linear-gradient(rgba(0,229,160,0.03) 1px, transparent 1px),
      linear-gradient(90deg, rgba(0,229,160,0.03) 1px, transparent 1px);
    background-size: 64px 64px;
  }

  /* Contact link */
  .contact-link {
    font-family: 'JetBrains Mono', monospace;
    font-size: 12px;
    color: #555;
    text-decoration: none;
    display: flex;
    align-items: center;
    gap: 8px;
    padding: 10px 0;
    border-bottom: 1px solid #1a1a1a;
    transition: all 0.2s;
  }
  .contact-link:hover { color: #00e5a0; border-color: rgba(0,229,160,0.3); }
  .contact-link .arrow { transition: transform 0.2s; }
  .contact-link:hover .arrow { transform: translateX(4px); }

  /* Stat */
  .stat-box {
    border: 1px solid #1e1e1e;
    background: #111;
    padding: 24px 20px;
    position: relative;
    overflow: hidden;
    transition: border-color 0.3s;
  }
  .stat-box:hover { border-color: rgba(0,229,160,0.25); }
  .stat-box::after {
    content: '';
    position: absolute;
    bottom: 0; left: 0; right: 0;
    height: 1px;
    background: linear-gradient(90deg, transparent, rgba(0,229,160,0.3), transparent);
    transform: scaleX(0);
    transition: transform 0.3s;
  }
  .stat-box:hover::after { transform: scaleX(1); }

  /* Section label */
  .section-label {
    font-family: 'JetBrains Mono', monospace;
    font-size: 10px;
    letter-spacing: 0.25em;
    text-transform: uppercase;
    color: #00e5a0;
  }

  @media (max-width: 768px) {
    .hide-mobile { display: none !important; }
    .project-card-grid { grid-template-columns: 1fr !important; }
  }
</style>
</head>
<body>

<!-- ═══════════════════════════════════════════════════
     NAVIGATION
════════════════════════════════════════════════════ -->
<nav id="main-nav" class="fixed top-0 left-0 right-0 z-50 flex items-center justify-between px-6 md:px-12 py-4 border-b border-border" style="background: rgba(13,13,13,0.92); backdrop-filter: blur(12px);">
  <div class="font-mono text-xs text-dim tracking-widest">
    <span class="text-accent">~/</span>yoo-sungyeon
  </div>
  <div class="flex items-center gap-1">
    <a href="#hero"    class="nav-link font-mono text-xs text-dim px-3 py-2 hover:text-body transition-colors">#hero</a>
    <a href="#projects" class="nav-link font-mono text-xs text-dim px-3 py-2 hover:text-body transition-colors">#projects</a>
    <a href="#stack"   class="nav-link font-mono text-xs text-dim px-3 py-2 hover:text-body transition-colors">#stack</a>
    <a href="#contact" class="nav-link font-mono text-xs text-dim px-3 py-2 hover:text-body transition-colors">#contact</a>
  </div>
</nav>


<!-- ═══════════════════════════════════════════════════
     HERO
════════════════════════════════════════════════════ -->
<section id="hero" class="hero-grid relative min-h-screen flex flex-col justify-center pt-20 px-6 md:px-16 lg:px-24 noise" style="position: relative;">

  <!-- Corner decorators -->
  <div class="absolute top-24 left-6 font-mono text-xs text-muted opacity-40">001</div>
  <div class="absolute top-24 right-6 font-mono text-xs text-muted opacity-40 hide-mobile">2008 – 2026</div>

  <!-- Large background text -->
  <div class="absolute bottom-8 right-0 font-display text-8xl md:text-[180px] font-extrabold text-white opacity-[0.025] select-none pointer-events-none leading-none tracking-tighter">
    DEV
  </div>

  <div class="max-w-5xl w-full">

    <!-- Status badge -->
    <div class="animate-fade-up flex items-center gap-3 mb-10" style="animation-delay:0s">
      <span class="w-2 h-2 rounded-full bg-accent pulse-glow"></span>
      <span class="font-mono text-xs text-accent tracking-widest uppercase">Available for Projects</span>
    </div>

    <!-- Name block -->
    <div class="animate-fade-up" style="animation-delay:0.1s">
      <div class="section-label mb-4">Backend Developer · Full-Stack</div>
      <h1 class="font-display text-5xl md:text-7xl lg:text-8xl font-extrabold text-bright leading-[0.92] tracking-tight mb-2">
        유성연
      </h1>
      <h2 class="font-display text-5xl md:text-7xl lg:text-8xl font-extrabold leading-[0.92] tracking-tight" style="color: transparent; -webkit-text-stroke: 1px #2a2a2a;">
        Yoo Sungyeon
      </h2>
    </div>

    <!-- Desc -->
    <div class="animate-fade-up mt-10 max-w-2xl" style="animation-delay:0.2s">
      <p class="text-subtle text-sm md:text-base leading-relaxed">
        2008년부터 금융·커머스·통신·항공·글로벌 프로젝트까지 <span class="text-accent font-mono">17년+</span>의 Java 기반
        백엔드 및 Full-Stack 개발 경력. 삼성 SDS America, SKT, LG전자, 키움증권 등
        대형 SI 프로젝트 다수 참여.
      </p>
    </div>

    <!-- Terminal line -->
    <div class="animate-fade-up mt-8 font-mono text-sm text-dim" style="animation-delay:0.3s">
      <span class="text-accent">$</span>
      <span class="ml-2 text-subtle">profile</span>
      <span class="text-body ml-2">—grade</span>
      <span class="text-accent ml-2">고급</span>
      <span class="text-body ml-2">—status</span>
      <span class="text-accent ml-2">즉시투입가능</span>
      <span class="cursor-blink ml-1"> </span>
    </div>

    <!-- Stats row -->
    <div class="animate-fade-up grid grid-cols-3 gap-2 mt-12 max-w-lg" style="animation-delay:0.4s">
      <div class="stat-box text-center">
        <div class="font-display text-3xl font-extrabold text-bright">17<span class="text-accent text-xl">+</span></div>
        <div class="font-mono text-xs text-dim mt-1 tracking-wider">YEARS</div>
      </div>
      <div class="stat-box text-center">
        <div class="font-display text-3xl font-extrabold text-bright">28<span class="text-accent text-xl">+</span></div>
        <div class="font-mono text-xs text-dim mt-1 tracking-wider">PROJECTS</div>
      </div>
      <div class="stat-box text-center">
        <div class="font-display text-2xl font-extrabold text-accent">고급</div>
        <div class="font-mono text-xs text-dim mt-1 tracking-wider">GRADE</div>
      </div>
    </div>

    <!-- Tech pills -->
    <div class="animate-fade-up flex flex-wrap gap-2 mt-10" style="animation-delay:0.5s">
      <span class="tag primary">Java</span>
      <span class="tag primary">Spring Boot</span>
      <span class="tag primary">RESTful API</span>
      <span class="tag">OAuth2</span>
      <span class="tag">Oracle</span>
      <span class="tag">MySQL</span>
      <span class="tag">Spring Batch</span>
      <span class="tag">Vue.js</span>
    </div>

  </div>

  <!-- Scroll hint -->
  <div class="absolute bottom-8 left-1/2 -translate-x-1/2 flex flex-col items-center gap-2 opacity-30">
    <div class="font-mono text-xs text-dim">scroll</div>
    <div class="w-px h-10 bg-gradient-to-b from-dim to-transparent"></div>
  </div>

</section>


<!-- ═══════════════════════════════════════════════════
     PROJECTS
════════════════════════════════════════════════════ -->
<section id="projects" class="py-28 px-6 md:px-16 lg:px-24" style="background: #0d0d0d;">
  <div class="max-w-5xl mx-auto">

    <!-- Header -->
    <div class="reveal flex items-end justify-between mb-12 flex-wrap gap-4">
      <div>
        <div class="section-label mb-3">02 / projects</div>
        <h2 class="font-display text-4xl md:text-5xl font-extrabold text-bright">주요 프로젝트</h2>
      </div>
      <!-- Filter buttons -->
      <div class="flex flex-wrap gap-2" id="filter-btns">
        <button class="filter-btn active" data-filter="all">All</button>
        <button class="filter-btn" data-filter="Backend">Backend</button>
        <button class="filter-btn" data-filter="Full-Stack">Full-Stack</button>
        <button class="filter-btn" data-filter="API">API</button>
        <button class="filter-btn" data-filter="Global">Global</button>
      </div>
    </div>

    <!-- Project list rendered by JS -->
    <div id="project-list" class="flex flex-col gap-px"></div>

    <!-- Count -->
    <div class="reveal mt-6 font-mono text-xs text-dim text-right">
      <span id="project-count"></span>
    </div>

  </div>
</section>


<!-- ═══════════════════════════════════════════════════
     TECH STACK
════════════════════════════════════════════════════ -->
<section id="stack" class="py-28 px-6 md:px-16 lg:px-24" style="background: #090909;">
  <div class="max-w-5xl mx-auto">

    <div class="reveal mb-12">
      <div class="section-label mb-3">03 / stack</div>
      <h2 class="font-display text-4xl md:text-5xl font-extrabold text-bright">Tech Stack</h2>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-px" id="stack-grid"></div>

  </div>
</section>


<!-- ═══════════════════════════════════════════════════
     CONTACT
════════════════════════════════════════════════════ -->
<section id="contact" class="py-28 px-6 md:px-16 lg:px-24" style="background: #0d0d0d;">
  <div class="max-w-5xl mx-auto">

    <div class="reveal mb-16">
      <div class="section-label mb-3">04 / contact</div>
      <h2 class="font-display text-4xl md:text-5xl font-extrabold text-bright">함께 일해요</h2>
      <p class="mt-4 text-subtle text-sm max-w-md">즉시 투입 가능한 상태입니다. 새로운 프로젝트 기회에 열려 있습니다.</p>
    </div>

    <div class="reveal grid grid-cols-1 md:grid-cols-2 gap-12">

      <!-- Contact links -->
      <div>
        <div class="font-mono text-xs text-dim tracking-widest mb-6">REACH OUT</div>
        <a href="tel:010-9199-4595" class="contact-link">
          <span class="text-accent font-mono">call</span>
          <span class="text-body">010-9199-4595</span>
          <span class="arrow ml-auto text-dim">→</span>
        </a>
        <a href="mailto:sungyeon99@hanmail.net" class="contact-link">
          <span class="text-accent font-mono">mail</span>
          <span class="text-body">sungyeon99@hanmail.net</span>
          <span class="arrow ml-auto text-dim">→</span>
        </a>
        <div class="contact-link" style="cursor:default;">
          <span class="text-accent font-mono">loc </span>
          <span class="text-body">서울시 강서구 등촌동</span>
        </div>
      </div>

      <!-- Status card -->
      <div class="box-glow relative border border-border p-8" style="background: #111;">
        <div class="font-mono text-xs text-dim tracking-widest mb-6">CURRENT STATUS</div>
        <div class="space-y-4">
          <div class="flex items-center gap-3">
            <span class="w-2 h-2 rounded-full bg-accent pulse-glow"></span>
            <span class="font-mono text-sm text-body">즉시 투입 가능</span>
          </div>
          <div class="flex items-center gap-3">
            <span class="w-2 h-2 rounded-full" style="background:#00e5a0;opacity:0.5;"></span>
            <span class="font-mono text-sm text-subtle">고급 개발자 등급</span>
          </div>
          <div class="flex items-center gap-3">
            <span class="w-2 h-2 rounded-full" style="background:#00e5a0;opacity:0.3;"></span>
            <span class="font-mono text-sm text-subtle">프리랜서 · SI 프로젝트 가능</span>
          </div>
        </div>
        <div class="mt-8 pt-6 border-t border-border">
          <div class="font-mono text-xs text-dim">Top Skills</div>
          <div class="flex flex-wrap gap-2 mt-3">
            <span class="tag primary">Spring Boot</span>
            <span class="tag primary">Java</span>
            <span class="tag primary">RESTful API</span>
            <span class="tag">Oracle</span>
            <span class="tag">MySQL</span>
          </div>
        </div>
      </div>
    </div>

  </div>
</section>


<!-- ═══════════════════════════════════════════════════
     FOOTER
════════════════════════════════════════════════════ -->
<footer class="border-t border-border px-6 md:px-16 lg:px-24 py-10 flex flex-col md:flex-row items-center justify-between gap-4" style="background:#090909;">
  <div>
    <span class="font-display text-xl font-extrabold text-bright">유성연</span>
    <span class="font-mono text-xs text-dim ml-4">BACKEND DEVELOPER · SINCE 2008</span>
  </div>
  <div class="font-mono text-xs text-dim">
    Built with <span class="text-accent">HTML + Tailwind CSS</span> · <span id="year"></span>
  </div>
</footer>


<!-- ═══════════════════════════════════════════════════
     DATA & SCRIPTS
════════════════════════════════════════════════════ -->
<script>
// ──────────────────────────────────────────────
// projects.json (inline)
// ──────────────────────────────────────────────
const projects = [
  {
    id: 1,
    period: "2026.02 ~ 2026.04",
    name: "LG BESTSHOP 홈페이지 리뉴얼",
    client: "LG전자 · 히든피겨스",
    desc: "LG BESTSHOP 홈페이지 Full-Stack 개발. 사용자 경험 향상을 위한 프론트엔드 및 백엔드 통합 구현.",
    tech: ["Spring Boot","Java","JSP","Mybatis","jQuery","MariaDB","Git"],
    role: "Full-Stack",
    category: ["Full-Stack"]
  },
  {
    id: 2,
    period: "2025.10 ~ 2026.01",
    name: "로컬웹할인 주차시스템",
    client: "나이스파크 · 제이픽",
    desc: "웹 할인 주차 시스템 클라우드 동기화 API 및 배치 개발. 실시간 데이터 동기화 처리.",
    tech: ["Spring Boot","Spring Batch","RESTful API","Java","DB2","Git"],
    role: "API/Batch",
    category: ["Backend","API"]
  },
  {
    id: 3,
    period: "2024.07 ~ 2024.12",
    name: "Global Purchasing 해외법인 구매시스템",
    client: "LG CNS · 디지털플러스",
    desc: "글로벌 해외법인 대상 구매 시스템 개발. API 및 배치 시스템 구현.",
    tech: ["Spring Boot","Java","JSP","Mybatis","MySQL","Git"],
    role: "Backend",
    category: ["Backend","Global"]
  },
  {
    id: 4,
    period: "2024.01 ~ 2024.06",
    name: "코나아이 그룹 플랫폼 관리 시스템",
    client: "코나아이 · YBM Net",
    desc: "코나아이 그룹 통합 플랫폼 관리 시스템 Full-Stack 개발.",
    tech: ["Spring Boot","Java","Vue.js","JPA","MySQL","Git"],
    role: "Full-Stack",
    category: ["Full-Stack"]
  },
  {
    id: 5,
    period: "2023.08 ~ 2024.05",
    name: "Mallpie.kr e-Commerce API 개발",
    client: "지니웍스",
    desc: "이커머스 플랫폼 사용자/관리자 API 설계 및 개발, 배치 공통 모듈 개발.",
    tech: ["Spring Boot","Java","IBatis","MySQL","Git"],
    role: "API Dev",
    category: ["Backend","API"]
  },
  {
    id: 6,
    period: "2021.06 ~ 2023.02",
    name: "Resello · Blud Point · Tmobi · GenieFun API",
    client: "지니웍스",
    desc: "전남 스마트 쇼핑관광 플랫폼 포함 다수 API 서비스 설계·개발. OAuth2 인증 구조 적용.",
    tech: ["OAuth2","Spring Boot","RESTful API","전자정부프레임","MySQL"],
    role: "설계/개발",
    category: ["Backend","API"]
  },
  {
    id: 7,
    period: "2020.09 ~ 2020.12",
    name: "키움닷컴 자산관리 고도화",
    client: "키움증권 · 필그림소프트",
    desc: "키움닷컴 자산관리 시스템 고도화. 카드인증(KCB) 연계 금융 시스템 개발.",
    tech: ["Spring Boot","Java","Mybatis","Oracle","jQuery"],
    role: "Full-Stack",
    category: ["Full-Stack","Backend"]
  },
  {
    id: 8,
    period: "2018.08 ~ 2018.11",
    name: "AMEX 고도화 (사내관리자 시스템)",
    client: "CJ올리브네트웍스 · CSPI",
    desc: "사내 관리자 시스템 Full-Stack 개발. Vue.js 프론트엔드 적용.",
    tech: ["Spring Boot","Java","Vue.js","Mybatis","Oracle"],
    role: "Full-Stack",
    category: ["Full-Stack"]
  },
  {
    id: 9,
    period: "2018.01 ~ 2018.04",
    name: "SK T Wi-Fi 광고 서비스 고도화",
    client: "SK Telecom · 크림하우스",
    desc: "T Wi-Fi 광고 서비스 분석/설계 및 공통 모듈 Full-Stack 개발. (2016년 1차 개발 이후 고도화)",
    tech: ["Spring Boot","Java","Mybatis","MySQL","JSP","jQuery"],
    role: "분석/설계",
    category: ["Full-Stack","Backend"]
  },
  {
    id: 10,
    period: "2016.12 ~ 2017.03",
    name: "Samsung SDS IoT RMS POC",
    client: "Samsung SDS America · 디포커스",
    desc: "IoT Resource Management System POC 프로젝트 Full-Stack 개발. 해외 글로벌 프로젝트.",
    tech: ["Spring","Struts","Java","Mybatis","PostgreSQL"],
    role: "Full-Stack",
    category: ["Full-Stack","Global"]
  },
  {
    id: 11,
    period: "2013 ~ 2016",
    name: "Samsung.com 글로벌 프로젝트 다수",
    client: "Samsung SDS America · 디포커스",
    desc: "Samsung.com B2B, Appstore, Samsung 837 Experience, SEA CSD SPSN Contents, Samsung Insider 등 다수의 글로벌 삼성 프로젝트 참여.",
    tech: ["Spring","Struts","Java","IBatis","Oracle","JSP"],
    role: "글로벌 SI",
    category: ["Full-Stack","Global"]
  },
  {
    id: 12,
    period: "2008 ~ 2012",
    name: "공공·금융·음원 시스템 (경력 시작)",
    client: "방위사업청 · 대한주택보증 · Melon.com",
    desc: "방위사업청 FMS 계약관리 · E-HRD 교육 시스템, 대한주택보증 회계 시스템, Melon.com 구매 파트 프론트엔드 개발.",
    tech: ["Java","MiPlatform","전자정부프레임","Oracle","JSP"],
    role: "Backend",
    category: ["Backend"]
  }
];

// ──────────────────────────────────────────────
// Tech stack data
// ──────────────────────────────────────────────
const techStack = [
  {
    label: "Backend · Core",
    items: [
      { name: "Java", primary: true },
      { name: "Spring Boot", primary: true },
      { name: "Spring Framework", primary: true },
      { name: "Spring Batch", primary: true },
      { name: "RESTful API", primary: true },
      { name: "OAuth2", primary: false },
      { name: "JPA / Hibernate", primary: false },
      { name: "MyBatis / IBatis", primary: false },
      { name: "Struts", primary: false },
    ]
  },
  {
    label: "Database",
    items: [
      { name: "Oracle", primary: true },
      { name: "MySQL", primary: true },
      { name: "MariaDB", primary: false },
      { name: "DB2", primary: false },
      { name: "PostgreSQL", primary: false },
    ]
  },
  {
    label: "Frontend · View",
    items: [
      { name: "Vue.js", primary: true },
      { name: "JSP", primary: false },
      { name: "Thymeleaf", primary: false },
      { name: "jQuery", primary: false },
      { name: "JavaScript", primary: false },
      { name: "Nexacro", primary: false },
      { name: "MiPlatform", primary: false },
    ]
  },
  {
    label: "Infra · DevOps",
    items: [
      { name: "Unix / Linux", primary: false },
      { name: "Git", primary: false },
      { name: "Cloud 환경", primary: false },
      { name: "WebSphere", primary: false },
    ]
  },
  {
    label: "Domain Expertise",
    items: [
      { name: "증권 / 금융", primary: true },
      { name: "e-Commerce", primary: true },
      { name: "통신 플랫폼", primary: false },
      { name: "항공 / 여행", primary: false },
      { name: "IoT", primary: false },
      { name: "글로벌 SI", primary: true },
      { name: "공공 시스템", primary: false },
    ]
  },
  {
    label: "Specialization",
    items: [
      { name: "API 설계", primary: true },
      { name: "Full-Stack 개발", primary: true },
      { name: "배치 시스템", primary: false },
      { name: "인증 시스템", primary: false },
      { name: "시스템 고도화", primary: false },
    ]
  }
];


// ──────────────────────────────────────────────
// Render projects
// ──────────────────────────────────────────────
let activeFilter = 'all';

function renderProjects(filter) {
  const list = document.getElementById('project-list');
  const countEl = document.getElementById('project-count');

  const filtered = filter === 'all'
    ? projects
    : projects.filter(p => p.category.includes(filter));

  list.innerHTML = '';

  filtered.forEach((p, i) => {
    const el = document.createElement('div');
    el.className = 'project-card reveal';
    el.style.animationDelay = `${i * 0.04}s`;
    el.innerHTML = `
      <div class="grid grid-cols-1 md:grid-cols-[160px_1fr_auto] items-stretch">

        <!-- Period -->
        <div class="px-6 py-6 border-b md:border-b-0 md:border-r border-border flex flex-col justify-center">
          <div class="font-mono text-xs text-dim leading-relaxed">${p.period.replace('~','<br>~<br>')}</div>
        </div>

        <!-- Body -->
        <div class="px-6 py-6">
          <div class="font-sans text-base font-semibold text-bright mb-1">${p.name}</div>
          <div class="font-mono text-xs text-accent tracking-wide mb-3">${p.client}</div>
          <div class="text-sm text-subtle leading-relaxed mb-4">${p.desc}</div>
          <div class="flex flex-wrap gap-1.5">
            ${p.tech.map(t => `<span class="tag">${t}</span>`).join('')}
          </div>
        </div>

        <!-- Role -->
        <div class="px-5 py-6 border-t md:border-t-0 md:border-l border-border flex items-center justify-end md:justify-center min-w-[110px]">
          <span class="font-mono text-xs text-accent tracking-wider uppercase whitespace-nowrap">${p.role}</span>
        </div>

      </div>
    `;
    list.appendChild(el);
  });

  countEl.textContent = `${filtered.length} / ${projects.length} projects`;

  // Re-observe reveals
  requestAnimationFrame(() => {
    list.querySelectorAll('.reveal').forEach(el => {
      revealObserver.observe(el);
    });
  });
}


// ──────────────────────────────────────────────
// Render tech stack
// ──────────────────────────────────────────────
function renderStack() {
  const grid = document.getElementById('stack-grid');
  techStack.forEach((cat, i) => {
    const el = document.createElement('div');
    el.className = 'tech-cell reveal p-6';
    el.style.transitionDelay = `${i * 0.06}s`;
    el.innerHTML = `
      <div class="font-mono text-xs tracking-widest text-accent uppercase mb-5 flex items-center gap-2">
        <span class="inline-block w-4 h-px bg-accent"></span>
        ${cat.label}
      </div>
      <div class="flex flex-wrap gap-2">
        ${cat.items.map(t => `<span class="tag ${t.primary ? 'primary' : ''}">${t.name}</span>`).join('')}
      </div>
    `;
    grid.appendChild(el);
  });
}


// ──────────────────────────────────────────────
// Filter buttons
// ──────────────────────────────────────────────
document.getElementById('filter-btns').addEventListener('click', (e) => {
  const btn = e.target.closest('.filter-btn');
  if (!btn) return;
  document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
  btn.classList.add('active');
  activeFilter = btn.dataset.filter;
  renderProjects(activeFilter);
});


// ──────────────────────────────────────────────
// Scroll reveal observer
// ──────────────────────────────────────────────
const revealObserver = new IntersectionObserver((entries) => {
  entries.forEach((entry, i) => {
    if (entry.isIntersecting) {
      setTimeout(() => entry.target.classList.add('visible'), i * 50);
      revealObserver.unobserve(entry.target);
    }
  });
}, { threshold: 0.06, rootMargin: '0px 0px -40px 0px' });


// ──────────────────────────────────────────────
// Nav active state on scroll
// ──────────────────────────────────────────────
const sections = document.querySelectorAll('section[id]');
const navLinks = document.querySelectorAll('.nav-link');

const navObserver = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      navLinks.forEach(l => l.classList.remove('active', 'text-accent'));
      const active = document.querySelector(`.nav-link[href="#${entry.target.id}"]`);
      if (active) {
        active.classList.add('active');
        active.style.color = '#00e5a0';
      }
    }
  });
}, { threshold: 0.4 });

sections.forEach(s => navObserver.observe(s));


// ──────────────────────────────────────────────
// Init
// ──────────────────────────────────────────────
document.getElementById('year').textContent = new Date().getFullYear();
renderProjects('all');
renderStack();

// Observe static reveals
document.querySelectorAll('.reveal').forEach(el => revealObserver.observe(el));
</script>

</body>
</html>
