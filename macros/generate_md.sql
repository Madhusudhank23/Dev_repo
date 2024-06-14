{% macro generate_md(table_names) %}

    {%- set tables = "select distinct TABLE_NAME from " ~ ref('create_test')   -%}
    {%- set tab_results = run_query(tables) -%}
    {%- if execute -%}
    {%- for j in range(tab_results.columns[0].values()|length) -%}
        {%- set query = "select COLUMN_NAME, DESCRIPTION from " ~ ref('create_test')  ~ " where table_name = '" ~tab_results.columns[0].values()[j]~ "'" -%}
        {%- set results = run_query(query) -%}
        {{- "======================docs for table " ~tab_results.columns[0].values()[j]~ "===========================\n" -}}
        {%- for i in range(results.columns[0].values()|length) -%}
                {{- "{% docs " ~ results.columns[0].values()[i] ~ " %}\n" -}}
                {{- "    "~results.columns[1].values()[i] | replace('"',"")~ "\n" -}}
                {{- "{% enddocs %}\n\n"}}
        {%- endfor -%}
    {%- endfor -%}
    {%- endif -%}

{%- endmacro -%}
