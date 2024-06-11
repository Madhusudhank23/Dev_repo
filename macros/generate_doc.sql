{% macro generate_doc(table_names,model_name,model_desc) %}
    {%- set query = "select COLUMN_NAME, DESCRIPTION from " ~ ref('create_test')  ~ " where table_name = '" ~table_names~ "'" -%}
    {%- set results = run_query(query) -%}
    {%- if execute -%}
        {{- "version: 2\n" -}}
        {{- "models:\n" -}}
        {{- "    name: " ~ model_name ~ " \n" -}}
        {{- "    description: '" ~ model_desc ~ " '\n" -}}
        {{- "    columns: \n" -}}
        {%- for i in range(results.columns[0].values()|length) -%}
            {{- "      - name: " ~ results.columns[0].values()[i] ~ "\n" -}}
            {{- "        description: '{{ doc(" ~ results.columns[1].values()[i] ~ ") }}'\n" -}}
            
            
        {%- endfor -%}
    {%- endif -%}

{%- endmacro -%}