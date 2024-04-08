{#
    This macro returns the description of the payment_type 
#}

{% macro get_severity_type_descripition(severity) -%}

    case {{ dbt.safe_cast("severity", api.Column.translate_type("integer")) }}  
        when 1 then 'Minimal injury crash'
        when 2 then 'Minor injury crash'
        when 3 then 'Major injury crash'
        else 'Fatal injury crash'
    end

{%- endmacro %}