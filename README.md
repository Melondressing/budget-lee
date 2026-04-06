# Budget-Lee Clean Bundle

Desktop용으로 다시 정리하기 쉽게 필요한 파일만 추린 경량 프로젝트입니다.

포함된 항목:
- `src/`
- `public/`
- `migrations/`
- `package.json`
- `package-lock.json`
- `tsconfig.json`
- `vite.config.ts`
- `wrangler.jsonc`
- `fix-routes.js`
- `.gitignore`

정리 기준:
- Cloudflare Pages 프로젝트명은 `budget-lee`로 통일했습니다.
- PWA 이름과 기본 HTML 타이틀도 `Budget Lee`로 맞췄습니다.
- 실제 D1 데이터베이스 이름 `webapp-production`은 운영 DB 연속성을 위해 유지했습니다.

기본 명령:
```bash
npm install
npm run build
npm run deploy:prod
```

배포 대상:
- Pages 프로젝트: `budget-lee`
- 예상 프로덕션 도메인: `https://budget-lee.pages.dev`
