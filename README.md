# Healthcare Management System
## SQL Server T-SQL Project
### CCS Global Tech | Yashraj Kadam

## Project Overview
A Healthcare Management System database built using Microsoft SQL Server T-SQL.
The project simulates a real world data engineering scenario where requirements
come in as sprints and are implemented incrementally.

## Tech Stack
- Microsoft SQL Server 2019
- T-SQL
- SSMS

## Sprint Summary
| Sprint | Description | Concepts |
|--------|-------------|----------|
| Sprint 1 | Database setup and schema design | DDL, Normalization, FK constraints |
| Sprint 2 | Initial data load | DML, Insert order for FK |
| Sprint 3 | Clinical and pharmacy reporting views | Views |
| Sprint 4 | Patient prescription lookup | Inline TVF |
| Sprint 5 | Management flexible visit report | SP, Dynamic SQL, sp_executesql |
| Sprint 6 | Monthly department summary | Table variable, Temp table |
| Sprint 7 | Top patients per department ranking | CTE, Window functions |
| Sprint 8 | Doctor hierarchy and referral chain | Recursive CTE |
| Sprint 9 | Staff salary grade and domain lookup | Scalar UDF, MSTVF |
| Sprint 10 | Smart patient search with validation | Control flow, IF/ELSE, WHILE |
| Sprint 11 | Performance complaints as data grows | Indexes, Columnstore |
| Sprint 12 | Index health monitoring | Fragmentation, Reorganize, Rebuild |

## How to Run
1. Open SSMS and connect to your SQL Server instance
2. Run scripts in sprint order starting from Sprint 1
3. Each sprint folder contains one SQL file
