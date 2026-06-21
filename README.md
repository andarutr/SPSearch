# SPSearch

Search SQL Server schemas and stored procedures without SQL Profiler.

## Goals

- Quickly find which tables contain the columns you need across any database
- Search stored procedure definitions for keywords
- Avoid expensive third-party tools and profiler traces
- Support multiple authentication modes (Windows Auth / SQL Auth)

## Features

- **Multi-database search** — select any database on a server, explore tables and procedures
- **Column search** (LIKE %) — find tables by column name pattern across all or selected tables
- **Table name filter** — narrow results by table name patterns (OR between patterns, AND with column filter)
- **Stored procedure search** — search procedure definitions (name + first 200 chars) for keywords
- **Select2 multi-select** — searchable, scrollable multi-select for tables and stored procedures
- **Schema modal** — click a result row to view full column list + TOP 3 sample records
- **Account suggestions** — saved credentials in localStorage, auto-fill on re-login
- **Step-based UI** — 3-step wizard (Sign → Search → Result) with state preservation on back navigation
- **Downloadable logs** — search history saved to server-side logs

## Screenshots

| | |
|---|---|
| ![Sign In](client/images/ss_1.png) | **Sign In** — Enter server credentials with Windows Auth / SQL Auth toggle, account suggestions from localStorage, and optional Trust Server Certificate setting |
| ![Define Search](client/images/ss_2.png) | **Define Search** — Pick a database, select tables and stored procedures via Select2 multi-select, then configure search filters |
| ![Table & Column Filters](client/images/ss_3.png) | **Filters** — Add table name patterns (OR logic) and column name patterns (LIKE %) to pinpoint results |
| ![Table Results](client/images/ss_4.png) | **Table Results** — Scrollable card list of matching tables with highlighted columns; click any row for a schema modal with sample data |
| ![Procedure Results](client/images/ss_5.png) | **Procedure Results** — Matching stored procedures showing name and truncated definition body |
| ![Download Log](client/images/ss_6.png) | **Download Log** — Full search history available as downloadable server-side log files |

## Folder Structure

```
SPSearch/
├── client/                  # Static frontend
│   ├── css/
│   │   └── style.css
│   ├── images/
│   │   ├── logo.png
│   │   ├── ss_1.png–ss_6.png
│   ├── js/
│   │   └── app.js
│   ├── sign.html            # Step 1: credentials
│   ├── search.html          # Step 2: database, tables, columns, procedures
│   └── result.html          # Step 3: results, schema modal, logs
├── server/                  # .NET 10 Web API
│   ├── Controllers/
│   │   └── SearchController.cs
│   ├── Models/
│   │   ├── ConnectionRequest.cs
│   │   ├── DatabaseInfo.cs
│   │   ├── SearchRequest.cs
│   │   └── SearchResult.cs
│   ├── Services/
│   │   └── SchemaSearchService.cs
│   ├── Program.cs
│   └── appsettings.json
├── sql/                     # Seed data scripts
│   ├── TABLE/
│   │   ├── HealthDB.sql     (50 tables)
│   │   ├── ShoppingDB.sql   (134 tables)
│   │   └── TicketingDB.sql  (25 tables)
│   ├── SP/                  # 209 SELECT-only stored procedures
│   │   ├── SP_HealthDB_Get*.sql
│   │   ├── SP_ShoppingDB_Get*.sql
│   │   └── SP_TicketingDB_Get*.sql
│   ├── health_database.sql
│   ├── health_database_50_tables.sql
│   ├── shopping_database_100_tables.sql
│   └── ticketing_database_gp_style.sql
├── AGENTS.md                # Agent decision log
├── SPSearch.slnx            # Solution file
└── README.md
```

## Tech Stack

- **Backend**: .NET 10, ASP.NET Core Web API, Microsoft.Data.SqlClient
- **Frontend**: jQuery 3.7, Bootstrap 5.3, Select2 4.1, vanilla CSS
- **Architecture**: Monolith (ASP.NET serves static client files)

## API Endpoints

| Method | Route | Purpose |
|--------|-------|---------|
| POST | /api/search/connect | Validate SQL connection |
| POST | /api/search/databases | List databases |
| POST | /api/search/tables | List tables per database |
| POST | /api/search/procedures | List stored procedures per database |
| POST | /api/search/execute | Search columns + table name patterns + stored procedures |
| POST | /api/search/schema | Get table schema + sample records |
| GET | /api/search/log/{filename} | Download log file |
