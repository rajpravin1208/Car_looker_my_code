view: dl_car_reports_data_metadata_raw_ireland_cable {
  sql_table_name: `oracle_hfm.dl_car_reports_data_metadata_raw_Ireland_Cable` ;;

  dimension: duplicate_row {
    type: number
    sql: ${TABLE}.duplicate_row ;;
  }
  dimension: file_name {
    type: string
    sql: ${TABLE}.file_name ;;
  }
  dimension: invalid_data_type_rows {
    type: number
    sql: ${TABLE}.invalid_data_type_rows ;;
  }
  dimension: nr_of_columns {
    type: number
    sql: ${TABLE}.nr_of_columns ;;
  }
  dimension: nr_of_rows {
    type: number
    sql: ${TABLE}.nr_of_rows ;;
  }
  dimension_group: timestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.timestamp ;;
  }
  measure: count {
    type: count
    drill_fields: [file_name]
  }
}
