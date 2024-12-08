# StoneERP

Proyecto para almacenar todoslos objetos de la base de datos StoneERP.

La estructura de directorios para el trabajo del proyecto es la siguiente:
```
StoneERP
└───dbo
│   └───Data
│   │   │   BranchOffice.sql
│   │   │   Company.sql
│   │   │   CostCenter.sql
│   │   │   EntityCatalog.sql
│   │   │   PermiRole.sql
│   │   │   PermiRoleRecord.sql
│   │   │   Permission.sql
│   │   │   PermiUser.sql
│   │   │   PermiUserRecord.sql
│   │   │   Role.sql
│   │   │   User.sql
│   │   │   UserCompany.sql
│   │   │   UserRole.sql
│   │   │   ...
│   │   └
│   └───Functions
│   │   └───Scalar
│   │   │   │   CUDSecurity.sql
│   │   │   │   ...
│   │   │   └
│   │   └───Table Functions
│   │   │   │   RowLevelSecurity.sql
│   │   │   │   ...
│   │   │   └
│   │   │   ...
│   │   └    
│	└───Triggers
│   │   │   IDBranchOffice.sql
│   │   │   IIBranchOffice.sql
│   │   │   IUBranchOffice.sql
│   │   │   ...
│   │   └
│   │   ...
│   └
└───scripts_para_crear_tablas
│   │   branch_office.sql
│   │   company.sql
│   │   cost_center.sql
│   │   entity_catalog.sql
│   │   permi_role.sql
│   │   permi_role_record.sql
│   │   permi_user.sql
│   │   permi_user_record.sql
│   │   permission.sql
│   │   role.sql
│   │   user.sql
│   │   user_company.sql
│   │   UserRole.sql
│   │   ...
│   └
└───Security
│   └───Logins
│   │   │   TestUser.sql
│   │   │   ...
│   │   └
│   └───Policies
│   │   └───dbo
│   │   │   │   RowLevelSecurityBranchOffice.sql
│   │   │   │   ...
│   │   │   └
│   │   │   ...
│   │   └
│	└───Schemas
│   │   │   History.sql
│   │   │   ...
│   │   └
│   └───Users
│   │   │   TestUser.sql
│   │   │   ...
│   │   └
│   │   ...
│   └
└───sys
│   └───Views
│   │   └───messages
│   │   │   │   51001.sql
│   │   │   │   51002.sql
│   │   │   │   ...
│   │   │   └
│   │   │   ...
│   │   └
│   │   ...
│   └
└───Tests
│   └───dbo
│   │   └───Functions
│   │   │   └───Table
│   │   │   │   └───RowLevelSecurity
│   │   │   │   │   │   testRowLevelSecurity.sql
│   │   │   │   │   │   testRowLevelSecurityUserIsAdmin.sql
│   │   │   │   │   │   ...
│   │   │   │   │   └
│   │   │   │   │   ...
│   │   │   │   └
│   │   │   │   ...
│   │   │   └
│   │   │   ...
│   │   └
│   │   ...
│   └
└───TSQLt
│   │   ...
│   └
└───Versions
│   └───00.00.00
│   │   │   Database.sql
│   │   │   Main.sql
│   │   │   ...
│   │   └
│   └───00.00.01
│   │   └───Rollback
│   │   │   │   ...
│   │   │   └
│   │   └───Scripts
│   │       │   ...
│   │       └
│   │   ...
│   └
│   .gitignore
│   README.md
│   StoneERP.ssmssln
│   StoneERP.ssmssqlproj
│   ...
└
```
## Inicio
1. Prerrequisitos
    1. Microsoft SQL Server 2022 Versión 16.0.1135.2
    2. Microsoft SQL Server Management Studio 20.2 Versión 20.2.30.0
    3. tSQLt Versión V1.0.8083.3529
## Construcción y pruebas
1. Clone el proyecto.
2. Modifique la ruta de los archivos de la base de datos en el archivo Database.sql.
3. Modifique la ruta del proyecto en el archivo Main.sql.
4. Copie los archivos de instalación de tSQLt en la carpeta TSQLt.
5. Ejecute el archivo Main.sql.
## Mejoras
Para cada mejora debe abrir una rama nueva en el repositorio.
## ToDo
1. Crear el desencadenador "dbo"."IDCompany"
2. Crear el desencadenador "dbo"."IICompany"
3. Crear el desencadenador "dbo"."IUCompany"
4. Crear el desencadenador "dbo"."IDCostCenter"
5. Crear el desencadenador "dbo"."IICostCenter"
6. Crear el desencadenador "dbo"."IUCostCenter"
7. Crear el desencadenador "dbo"."IDEntityCatalog"
8. Crear el desencadenador "dbo"."IIEntityCatalog"
9. Crear el desencadenador "dbo"."IUEntityCatalog"
10. Crear los demás escenarios de las pruebas automatizadas de la función  "dbo"."RowLevelSecurity"
11. Crear las pruebas automatizadas de la función  "dbo"."CUDSecurity"
12. Crear las pruebas automatizadas del desencadenador "dbo"."IDBranchOffice"
13. Crear las pruebas automatizadas del desencadenador "dbo"."IIBranchOffice"
14. Crear las pruebas automatizadas del desencadenador "dbo"."IUBranchOffice"
12. Crear las pruebas automatizadas del desencadenador "dbo"."IDCompany"
13. Crear las pruebas automatizadas del desencadenador "dbo"."IICompany"
14. Crear las pruebas automatizadas del desencadenador "dbo"."IUCompany"
15. Crear las pruebas automatizadas del desencadenador "dbo"."IDCostCenter"
16. Crear las pruebas automatizadas del desencadenador "dbo"."IICostCenter"
17. Crear las pruebas automatizadas del desencadenador "dbo"."IUCostCenter"
18. Crear las pruebas automatizadas del desencadenador "dbo"."IDEntityCatalog"
19. Crear las pruebas automatizadas del desencadenador "dbo"."IIEntityCatalog"
20. Crear las pruebas automatizadas del desencadenador "dbo"."IUEntityCatalog"
21. Evaluar qué otras tablas requieren validación de permisos de insersión, actualización y eliminación y crear los desencadenadores.