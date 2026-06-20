# SPSearch — Agent Tracking

## Project Overview

SQL Server schema search tool. Find which tables have the columns you need without using SQL Profiler. Minimalist UI, .NET 10 backend.

## Tech Stack

- **Backend**: .NET 10, ASP.NET Core Web API, Microsoft.Data.SqlClient
- **Frontend**: jQuery 3.7, Bootstrap 5.3, vanilla CSS (Minimalist)
- **Architecture**: Monolith (standalone ASP.NET serves static client files)

## Decisions Log

| Date | Decision | Rationale |
|------|----------|-----------|
| 2026-06-20 | Single database dropdown (not checklist) | User clarity — focus search |
| 2026-06-20 | Per-database table filter | Narrow search within a DB |
| 2026-06-20 | Log saved to server folder | Persistent history |
| 2026-06-20 | LIKE %search% matching | Column names often differ from user expectations |
| 2026-06-20 | OR logic across columns | Return any table matching at least one column |
| 2026-06-20 | Credentials sent per API call | No session management needed, stateless |
| 2026-06-20 | Standalone ASP.NET | Single deploy target, no CORS headaches |
| 2026-06-20 | Minimalist design (was NEO-Brutalism) | Cleaner UX, better readability, faster rendering |
| 2026-06-20 | Windows Auth + SQL Auth toggle | Support both trusted connection and SQL login |
| 2026-06-20 | Trust Server Certificate toggle | User opt-in for self-signed certs (local/dev servers) |

## API Endpoints

| Method | Route | Purpose |
|--------|-------|---------|
| POST | /api/search/connect | Validate SQL connection |
| POST | /api/search/databases | List databases |
| POST | /api/search/tables | List tables per database |
| POST | /api/search/execute | Search columns (LIKE OR) |
| GET | /api/search/log/{filename} | Download log file |

## Security Rules

- Only INFORMATION_SCHEMA and sys. views — no direct table access
- All user input parameterized
- Connection string built server-side per request, never persisted
- No CREATE, UPDATE, DELETE — enforced in code

## Pages

1. **index.html** — Server credentials form → SIGN
2. **page2.html** — Database/table select + dynamic column inputs → SEARCH
3. **page3.html** — Results table + log download + new search
