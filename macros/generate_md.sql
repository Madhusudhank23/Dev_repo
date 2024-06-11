{% macro generate_md(table_names) %}
    {%- set query = "select COLUMN_NAME, DESCRIPTION from " ~ ref('create_test')  ~ " where table_name = '" ~table_names~ "'" -%}
    {%- set results = run_query(query) -%}
    {%- if execute -%}

        {%- for i in range(results.columns[0].values()|length) -%}
                {{- "{% docs " ~ results.columns[0].values()[i] ~ " %}\n" -}}
                {{-        results.columns[1].values()[i] ~ "\n" -}}
                {{- "{% enddocs %}/n/n"}}
        {%- endfor -%}
    {%- endif -%}

{%- endmacro -%}
