# Naming Conventions
This document outlines the naming conventions used for the schemas, tables, views, columns, and other objects in this project.

## General Principles
- **Naming conventions**: Use snake_case, with lowercase letters and underscores (`_`) to separate words.
- **Language**: Use English for all names.
- **Words to avoid**: Avoid using SQL reserved words as object names.

## Table Naming Conventions
### Rules for Bronze Layer
- All table names must start with the source system name, followed by an underscore and the table's original name.
- `<sourcesystem>_<entity>`  
  - `<sourcesystem>`: Name of the source system (e.g., `crm`, `erp`).  
  - `<entity>`: Original table name from the source system.
  - Example: `crm_customer_info`

### Rules for Silver Layer
- Similar to the bronze layer, all table names must start with the source system name, follow by an underscore and the table's original name.
- `<sourcesystem>_<entity>`  
  - `<sourcesystem>`: Name of the source system (e.g., `crm`, `erp`).  
  - `<entity>`: Original table name from the source system.  
  - Example: `crm_customer_info`

### Rules for Gold Layer
- All table names must use business & user-friendly names, starting with the category prefix.
- `<category>_<entity>`  
  - `<category>`: Describes the role of the table – `dim` (dimension table) or `fact` (fact table).  
  - `<entity>`: Descriptive name of the table, aligned with the business entity (e.g., `customers`, `products`, `sales`).  
  - Examples:
    - `dim_customers`
    - `fact_sales`

#### Category Prefixes

| Prefix  | Meaning         | Examples                        |
| ------- | --------------- | ------------------------------- |
| `dim_`  | Dimension table | `dim_customers`, `dim_products` |
| `fact_` | Fact table      | `fact_sales`                    |

## Column Naming Conventions

### Technical Columns
- All technical columns must start with the prefix `dwh_`, followed by a descriptive name of the column's purpose.
- `dwh_<column_name>`  
  - `dwh`: Prefix exclusively for metadata.  
  - `<column_name>`: Descriptive name indicating the column's purpose.  
  - Example: `dwh_load_date`

### Surrogate Keys  
- All primary keys in dimension tables must end with `_key`.
- `<table_name>_key`
  - `<table_name>`: Refers to the name of the table.
  - `_key`: A suffix indicating that a column is a surrogate key.  
  - Example: `customer_key`

## Stored Procedure
- All stored procedures used for loading data must follow the naming pattern below:
- `load_<layer>`
  - `<layer>`: Refers to the layer being loaded (`bronze`, `silver`, or `gold`).
  - Examples:
    - `load_bronze`
    - `load_silver`