{% macro grant(role) %}

    {% set sql %}
      GRANT USAGE ON SCHEMA {{ schema }} TO {{ role }};
      GRANT SELECT ON ALL tables in SCHEMA {{ schema }} TO {{ role }};
    {% endset %}

    {% set table = run_query(sql) %}

{% endmacro %}