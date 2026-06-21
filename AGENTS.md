# SPSearch — Agent Tracking

## Project Overview

SQL Server schema search tool. Find which tables have the columns you need without using SQL Profiler. Minimalist UI, .NET 10 backend.

## Database Scripts

- **`sql/health_database.sql`** — Original schema (Patients, Doctors, Departments)
- **`sql/health_database_50_tables.sql`** — Full 50-table schema with ROWID PKs, dex_row_id, FK relationships, 3 sample records each
- **`sql/shopping_database_100_tables.sql`** — 134-table e-commerce schema (ShoppingDB), ROWID PKs, dex_row_id, 169 FK constraints, 3 records each (DEX001–DEX402)
- **`sql/ticketing_database_gp_style.sql`** — 25-table ticketing schema (Microsoft Dynamics GP naming: XXnnnss), ROWID PKs, dex_row_id, 38 FK constraints, 3 records each (DEX001–DEX075)

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
| 2026-06-21 | ROWID PK + dex_row_id convention | Consistent primary key pattern across all tables |
| 2026-06-21 | 50-table health DB seed script | Sample data for development and testing |
| 2026-06-21 | 134-table e-commerce seed script | Realistic shopping schema with payments, analytics, and marketing |
| 2026-06-21 | 25-table ticketing DB (GP naming) | Dynamics GP style XXnnnss naming convention for seed data |
| 2026-06-21 | Select2 multi-select for tables | Searchable, scrollable multi-select replaces single-dropdown — choose multiple tables or leave empty for all |
| 2026-06-21 | Select2 for database dropdown | Searchable dropdown for databases with many entries |
| 2026-06-21 | `tables` param as array (was `table` string) | Frontend sends `tables: string[]` for multi-table support |
| 2026-06-21 | State restoration on back navigation | Page 3 "Back to Search" preserves database, table selections, and column inputs via sessionStorage |
| 2026-06-21 | Select All / Deselect All for tables | Toggle link to quickly select or clear all table options |

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
2. **page2.html** — Database/table select (Select2 multi-select) + dynamic column inputs → SEARCH
3. **page3.html** — Results table + log download + back to search (state preserved)
