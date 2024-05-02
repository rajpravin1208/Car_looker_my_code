include: "/features/dashboard_links.view.lkml"
include: "/features/important_dimensions.view.lkml"

view: new_build {
  extends: [dashboard_links,important_dimensions]


  derived_table: {
    sql:

WITH query  as
    (SELECT * from `prj-lg-n-lss-car-dev.oracle_hfm_metric.dl_car_reports_data_extracts_metric_Actual`
    UNION ALL
    SELECT * from `prj-lg-n-lss-car-dev.oracle_hfm_metric.dl_car_reports_data_extracts_metric_Roll12`),

all_data as
      (SELECT *,
        CASE
        WHEN period IN ('Jan', 'Feb', 'Mar') THEN 'Q1'
        WHEN period IN ('Apr', 'May', 'Jun') THEN 'Q2'
        WHEN period IN ('Jul', 'Aug', 'Sep') THEN 'Q3'
        WHEN period IN ('Oct', 'Nov', 'Dec') THEN 'Q4'
        END AS Quarter

      FROM query
        WHERE
               metric_name IN (
                  'Capex taskline soho',
                  'Capex taskline consumer',
                  'Capex non-construction other new build',
                  'Capex non-construction soho new build',
                  'Capex non-construction resi new build',
                  'Capex construction WIP',
                  'Capex construction other adjustment',
                  'Capex construction inventory adjustment',
                  'Capex construction wayleave conversion adjustment',
                  'Capex construction planning adjustment',
                  'Capex construction',
                  'Customer gross adds',
                  'Cumulative RGUs',
                  'Homes constructed other adjustment',
                  'Homes constructed WIP'
                  )

             QUALIFY RANK() OVER (PARTITION BY year, view, entity, account ORDER BY timestamp DESC) = 1

    )

      SELECT * FROM all_data
      ;;
  }
}
