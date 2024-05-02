include: "/features/dashboard_links.view.lkml"
include: "/features/important_dimensions.view.lkml"

view: executive_summary {
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

      WHERE  metric_name IN (
          'Accrued short-term interest intercompany',
          'Equity Additional paid in capital - intercompany',
          'Capex tangible costs to capture',
          'Opex costs to capture',
          'Capex'
          )
          QUALIFY RANK() OVER (PARTITION BY year, view, entity, account ORDER BY timestamp DESC) = 1

    )

    SELECT * FROM all_data    ;;
}
}
