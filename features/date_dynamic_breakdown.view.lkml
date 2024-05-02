view: date_dynamic_breakdown {
  extension: required

# This view file contains the parameters and dimensions enable users to group key metrics in dashboards by varying dimensions.
# For example, a user may wish to see the results of a measure in a dashboard broken down by Department Name. Then, by switching the parameter, they can see the same visualisation broken down by Cost Category.
# This view file is marked as "Extension Required", which means that users will not be able to create an explore directly using this view file.
# This view file will be extended into other views. At the top of some view files, a parameter called "Extends" will be created, where this view file will be referenced.

  dimension: year {
    hidden: yes
    type: string
    sql: case when ${TABLE}.year="2022" then "2023" else ${TABLE}.year end  ;;
  }

  dimension_group: date {
    label: ""
    hidden: no
    type: time
    timeframes: [raw, month, month_name, month_num, quarter,quarter_of_year, year, day_of_year]
    sql: TIMESTAMP(CONCAT(${year},"-",${data_period},"-01")) ;;
  }

  parameter: choose_breakdown {
    label: "Select Quarter/Month"
    view_label: "Dynamic Grouping"
    type: unquoted
    default_value: "quarter"
    allowed_value: {label: "Month" value: "month"}
    allowed_value: {label: "Quarter" value: "quarter"}
    allowed_value: {label: "Year" value: "year"}
  }

  dimension: pop_row  {
    view_label: "Dynamic Grouping"
    label: "Selected Quarter/Month"
    label_from_parameter: choose_breakdown
    type: string
    order_by_field: sort_by_1
    sql:
      {% if choose_breakdown._parameter_value == 'quarter' %} ${date_quarter_of_year}
      {% elsif choose_breakdown._parameter_value == 'month' %} FORMAT_DATETIME("%h", DATETIME(${date_raw}))
      {% elsif choose_breakdown._parameter_value == 'year' %} cast(${date_year} as string)
      {% else %}  null
      {% endif %};;
  }

  dimension: sort_by_1 {
    hidden: yes
    type: number
    sql:
     {% if choose_breakdown._parameter_value == 'quarter' %} (CASE WHEN ${date_quarter_of_year}="Q1" THEN 1 WHEN ${date_quarter_of_year}="Q2" THEN 2
    WHEN ${date_quarter_of_year}="Q3" THEN 3 WHEN ${date_quarter_of_year}="Q4" THEN 4 END)
      {% elsif choose_breakdown._parameter_value == 'month' %} ${date_month_num}
      {% elsif choose_breakdown._parameter_value == 'year' %} ${date_year}
      {% else %}  null
      {% endif %};;
  }

  dimension: scenario {
    hidden: yes
    type: string
    sql: ${TABLE}.scenario ;;
  }

  dimension: scenario_name {
    group_label: "Measure Type"
    description: "Roll /  Budget / Prior Year"
    type: string
    sql:
    CASE WHEN ${scenario} = "ActualPY_FX_Restated" THEN "Prior Year"
    WHEN ${scenario} = "Budget_FX_Restated" THEN "Budget"
    ELSE ${scenario} END
    ;;
    order_by_field: scenario
  }

}
