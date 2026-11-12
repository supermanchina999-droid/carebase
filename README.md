# CareBase — Play Therapy App Builder

> 一人公司项目 | Solo Founder | $0 启动成本
> Niche: Play Therapy (游戏治疗)

## 产品定位

HIPAA-compliant 的 app builder，专为 Play Therapist 设计。
核心功能：**Play Session Notes** — 2 分钟记录一个 play session，而不是 15 分钟手写。

## 为什么是 Play Therapy

- Play Therapist 每天做 4-8 个 sessions
- SimplePractice/TherapyNotes 的 notes 模板是 talk therapy 格式，无法记录 play behaviors
- "2 分钟 vs 15 分钟" 是可感知的质变
- APT (Association for Play Therapy) ~6,000 会员 = 精准获客渠道

## 核心功能 (MVP)

1. **Play Session Notes**: 选 child -> 选 toy(s) -> 选 play behavior -> 选 emotional response -> AI 生成 structured note -> 关联 developmental milestone
2. **Parent Report**: 一键生成 parent-friendly progress report
3. **Toy Inventory**: 追踪玩具使用频率
4. **Intake Form**: Play therapy 专用 intake (developmental history, play preferences)

## 技术栈

- Frontend: React + Tailwind CSS
- Backend: Supabase (BAA included, HIPAA-compliant)
- Hosting: Vercel (free tier)
- AI: OpenAI/Claude API (session note generation)

## 项目结构

```
carebase/
├── README.md
├── src/
│   ├── components/
│   │   └── PlaySessionNotes.jsx    # 核心：Play Session Notes 组件
│   ├── lib/
│   │   └── supabase.js             # Supabase 客户端
│   └── App.jsx
├── supabase/
│   └── schema.sql                  # 数据库 schema (HIPAA RLS)
├── web/
│   └── index.html                  # 落地页
└── docs/
    ├── usage.md
    └── marketing.md
```

## $0 成本

- Supabase Free (BAA included)
- Vercel Free
- GitHub Free
- OpenAI API (pay-per-use, ~$0.01/session)

## 来源

- IndieRadar: therapists 是 2026 Top 5 高价值 niche
- SolopreneurPage: Voice-to-SOAP Notes $59/月 solo
- APT (Association for Play Therapy): ~6,000 会员

## License

MIT
