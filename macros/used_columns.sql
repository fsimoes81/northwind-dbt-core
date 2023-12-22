{% macro get_columns(model_name) %}
    {% if model_name == "categories" %}
        {{
            return ('
                category_id, 
                category_name, 
                description
            ')
        }}
    {% endif %}
{% endmacro %}