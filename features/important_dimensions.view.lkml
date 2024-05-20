view: important_dimensions {

 dimensions that are necessary for all the views

  dimension: base_entity {
    type: string
    sql: ${TABLE}.entity ;;
    case: {
      when: {
        sql: ${TABLE}.entity = 'RED' ;;
        label: "RED"
      }
      when: {
        sql: ${TABLE}.entity = 'YELLOW' ;;
        label: "YELLOW"
      }
      when: {
        sql: ${TABLE}.entity = 'PINK' ;;
        label: "PINK"
      }
      when: {
        sql: ${TABLE}.entity = 'GREEN' ;;
        label: "GREEN"
      }
      when: {
        sql: ${TABLE}.entity = 'ORANGE' ;;
        label: "ORANGE"
      }
      when: {
        sql: ${TABLE}.entity = 'PURPLE' ;;
        label: "PURPLE"
      }
      when: {
        sql: ${TABLE}.entity = 'BLUE' ;;
        label: "BLUE"
      }
    }
  }


  dimension: period {
    type: string
    sql: ${TABLE}.period ;;
    case: {
      when: {
        sql: ${TABLE}.period = 'Jan' ;;
        label: "January"
      }
      when: {
        sql: ${TABLE}.period = 'Feb' ;;
        label: "February"
      }
      when: {
        sql: ${TABLE}.period = 'Mar' ;;
        label: "March"
      }
      when: {
        sql: ${TABLE}.period = 'Apr' ;;
        label: "April"
      }
      when: {
        sql: ${TABLE}.period = 'May' ;;
        label: "May"
      }
      when: {
        sql: ${TABLE}.period = 'Jun' ;;
        label: "June"
      }
      when: {
        sql: ${TABLE}.period = 'Jul' ;;
        label: "July"
      }
      when: {
        sql: ${TABLE}.period = 'Aug' ;;
        label: "August"
      }
      when: {
        sql: ${TABLE}.period = 'Sep' ;;
        label: "September"
      }
      when: {
        sql: ${TABLE}.period = 'Oct' ;;
        label: "October"
      }
      when: {
        sql: ${TABLE}.period = 'Nov' ;;
        label: "November"
      }
      when: {
        sql: ${TABLE}.period = 'Dec' ;;
        label: "December"
      }
    }
  }

  dimension: scenario {
    type: string
    sql: ${TABLE}.scenario ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  dimension: Quarter {
    type: string
    sql: ${TABLE}.Quarter ;;
  }

  dimension: metric_name {
    type: string
    sql: ${TABLE}.metric_name ;;
  }

 measure: amount {
   description: "Sum of amount"
   hidden: no
   type: sum
   sql: ${TABLE}.amount ;;
 }

  measure: Periodic {
    description: "Sum of amount (in millions), rounded to 2 decimal places, for actual scenarios"
    hidden: no
    type: number
    sql: ROUND(SUM(CASE WHEN ${TABLE}.scenario = 'Actual' AND ${TABLE}.view = 'Periodic' THEN ${TABLE}.amount ELSE 0 END) / 1, 0)
      ;;
  }

  measure: YTD {
    description: "Sum of amount (in millions), rounded to 2 decimal places, for actual scenarios"
    hidden: no
    type: number
    sql: ROUND(SUM(CASE WHEN ${TABLE}.scenario = 'Actual' AND ${TABLE}.view = 'YTD' THEN ${TABLE}.amount ELSE 0 END) / 1, 0)
      ;;
  }

  measure: QTD {
    description: "Sum of amount (in millions), rounded to 2 decimal places, for actual scenarios"
    hidden: no
    type: number
    sql: ROUND(SUM(CASE WHEN ${TABLE}.scenario = 'Actual' AND ${TABLE}.view = 'QTD' THEN ${TABLE}.amount ELSE 0 END) / 1, 0)
      ;;
  }





 measure: Roll12_Periodic {
   description: "Sum of amount (in millions), rounded to 2 decimal places, for actual scenarios"
   hidden: no
   type: number
   sql: ROUND(SUM(CASE WHEN ${TABLE}.scenario = 'Roll12' AND ${TABLE}.view = 'Periodic' THEN ${TABLE}.amount ELSE 0 END) / 1, 0)
     ;;
 }

 measure: Roll12_YTD {
   description: "Sum of amount (in millions), rounded to 2 decimal places, for actual scenarios"
   hidden: no
   type: number
   sql: ROUND(SUM(CASE WHEN ${TABLE}.scenario = 'Roll12' AND ${TABLE}.view = 'YTD' THEN ${TABLE}.amount ELSE 0 END) / 1, 0)
     ;;
 }

 measure: Roll12_QTD {
   description: "Sum of amount (in millions), rounded to 2 decimal places, for actual scenarios"
   hidden: no
   type: number
   sql: ROUND(SUM(CASE WHEN ${TABLE}.scenario = 'Roll12' AND ${TABLE}.view = 'QTD' THEN ${TABLE}.amount ELSE 0 END) / 1, 0)
     ;;
 }


 measure: budget {
   description: "Sum of amount (in millions), rounded to 2 decimal places, for budget scenarios"
   hidden: no
   type: number
   sql: ROUND(SUM(CASE WHEN ${TABLE}.scenario = 'Budget' THEN ${TABLE}.amount ELSE 0 END) / 1000000, 0) ;;
 }

 measure: Overall_Year {
   type: number
   sql: SUM(amount)/1000000 ;;
   value_format_name: decimal_2
   }

  }
