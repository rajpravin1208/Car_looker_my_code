view: filters_alerts {

  measure: q1 {
    type: number
    hidden: yes
    sql: SUM(CASE WHEN ${TABLE}.Quarter = 'Q1' THEN ${TABLE}.amount ELSE 0 END) ;;
  }

  measure: q2 {
    type: number
    hidden: yes
    sql: SUM(CASE WHEN ${TABLE}.Quarter = 'Q2' THEN ${TABLE}.amount ELSE 0 END) ;;
  }

  measure: ebitda_percentage_difference {
    type: number
    hidden: no
    sql:((${q1} - ${q2}) / ${q2}) * 100;;
  }
}
