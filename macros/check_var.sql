{% macro check_var(var_name) %}
    {%- set var_value = var(var_name) -%}
    {%- if var_value is none or var_value == '' -%}
        {%- do exceptions.raise_compiler_error("Variable '" ~ var_name ~ "' is not set or is empty. Please specify this variable in dbt_project.yml") -%}
    {%- else -%}
        {{ log("Variable '" ~ var_name ~ "' is set to: " ~ var_value, info=True) }}
    {%- endif -%}
{% endmacro %}