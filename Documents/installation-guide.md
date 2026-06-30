# Installation Guide

## Prerequisites
- Azure subscription
- Azure Data Factory
- ADLS Gen2
- Azure SQL Database
- Power BI Desktop
- Python 3.10+

## Steps
1. Clone/download the project.
2. Create Azure resources (as listed in `environment-matrix.md`).
3. Execute SQL scripts in `SQL/README.md` order.
4. Run dataset generator and upload CSV files to ADLS raw path.
5. Import ADF artifacts and configure linked services.
6. Publish pipelines and enable trigger.
7. Connect Power BI to SQL views and refresh.
