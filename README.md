## 

The goal of the dbt part of my project is to 

- retrieve historical info about run performance from the elementary tables
- transform this info and prepare it such that the python part of my tool can use it directly

Note that I still need to make sure that my dbt code runs AFTER the stuff from elementary, this is not implemented yet