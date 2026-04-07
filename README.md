# Budget Lee

Cloudflare Pages + Hono + D1 기반의 웹 가계부 앱입니다.

현재 기준 기능:
- 개인 거래, 월별/주별 통계, 달력
- 고정지출 스케줄과 리마인더 흐름
- 저축 목표 및 저축 계좌
- 공유지갑 멀티 구조
가족, 연인, 팀, 모임별로 여러 공유지갑을 만들고, 지갑별 계좌/잔액/이체/저축목표/사용 내역을 관리
- 영수증, 채무, 투자, 리포트
- 세션 로그인 + Google OAuth 혼합 인증

배포 정보:
- Cloudflare Pages 프로젝트: `budget-lee`
- 프로덕션 URL: [https://budget-lee.pages.dev](https://budget-lee.pages.dev)
- D1 데이터베이스: `webapp-production`

기술 스택:
- Hono Worker backend
- 정적 프런트엔드 (`public/static`)
- Cloudflare Pages Functions/Worker 번들
- Cloudflare D1

중요한 데이터 모델:
- 개인 거래: `transactions`, `savings_accounts`, `fixed_expenses`
- 공유지갑: `shared_wallets`, `shared_wallet_members`, `shared_wallet_accounts`, `shared_wallet_transactions`
- 공유지갑 이체: `shared_wallet_transfers`

개발 명령:
```bash
npm install
npm run build
npm run deploy:prod
```

DB 관련 명령:
```bash
npm run db:migrate:local
npm run db:migrate:prod
```

프로젝트 기준 원칙:
- Cloudflare에 올라간 운영 코드와 이 폴더의 코드를 동일 기준으로 유지
- 로컬 `migrations/`는 운영 D1 이력(`d1_migrations`)과 맞춰 관리
- 공유지갑은 기존 운영 스키마(`shared_wallet_*`)를 기준으로 확장

주의:
- 브라우저 서비스워커 캐시 때문에 배포 직후 구버전 화면이 남을 수 있습니다.
- 시크릿 모드 또는 강력 새로고침으로 새 배포를 확인하는 것이 가장 정확합니다.
