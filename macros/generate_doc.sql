{% macro generate_doc(table_names,model_desc) %}
    
    {%- set tables = "select distinct TABLE_NAME from " ~ ref('create_test')   -%}
    {%- set tab_results = run_query(tables) -%}
    {%- if execute -%}
    {%- for j in range(tab_results.columns[0].values()|length) -%}
        {%- set query = "select COLUMN_NAME, DESCRIPTION from " ~ ref('create_test')  ~ " where table_name = '" ~tab_results.columns[0].values()[j]~ "'" -%}
        {%- set results = run_query(query) -%}
            {{- "version: 2\n" -}}
            {{- "models:\n" -}}
            {{- "    name: " ~ tab_results.columns[0].values()[j] ~ " \n" -}}
            {{- "    description: '" ~ model_desc ~ " '\n" -}}
            {{- "    columns: \n" -}}
            {%- for i in range(results.columns[0].values()|length) -%}
                {{- "      - name: " ~ results.columns[0].values()[i] ~ "\n" -}}
                {{- "        description: '{{ doc(" ~ results.columns[1].values()[i] ~ ") }}'\n" -}}
            {%- endfor -%}
    {%- endfor -%}
    {%- endif -%}

{%- endmacro -%}