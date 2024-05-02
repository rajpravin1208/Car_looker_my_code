include: "/features/dashboard_links.view.lkml"

view: dl_car_reports_data_extracts_raw {
  sql_table_name: `oracle_hfm.dl_car_reports_data_extracts_raw` ;;

  dimension: account {
    type: string
    sql: ${TABLE}.account ;;
  }
  dimension: amount {
    type: number
    sql: ${TABLE}.amount ;;
  }
  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }
  dimension: custom1 {
    type: string
    sql: ${TABLE}.custom1 ;;
  }
  dimension: custom2 {
    type: string
    sql: ${TABLE}.custom2 ;;
  }
  dimension: custom3 {
    type: string
    sql: ${TABLE}.custom3 ;;
  }
  dimension: custom4 {
    type: string
    sql: ${TABLE}.custom4 ;;
  }
  dimension: entity {
    type: string
    sql: ${TABLE}.entity ;;
  }
  dimension: filename {
    type: string
    sql: ${TABLE}.filename ;;
  }
  dimension: inter_company {
    type: string
    sql: ${TABLE}.inter_company ;;
  }
  dimension: period {
    type: string
    sql: ${TABLE}.period ;;
  }
  dimension: scenario {
    type: string
    sql: ${TABLE}.scenario ;;
  }
  dimension_group: timestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.timestamp ;;
  }
  dimension: view {
    type: string
    sql: ${TABLE}.view ;;
  }
  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }
  measure: count {
    type: count
    drill_fields: [filename]
  }
}
