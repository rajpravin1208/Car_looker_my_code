include: "/features/dashboard_links.view.lkml"
include: "/features/important_dimensions.view.lkml"

view: fixed_consumer_bau {
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

        WHERE    metric_name IN (
            'Periodic Fixed RGU excl Mobile net adds partner network',
            'QTD Fixed RGU excl Mobile net adds partner network',
            'Periodic Fixed Customer excl mobile Net Adds partner network',
            'QTD Fixed Customer excl mobile Net Adds partner network',
            'Capex Support Other including mobile',
            'Capex New Build Support Capacity including mobile',
            'Capex New Build Support Baseline including mobile',
            'Capex New Build CPE including mobile',
            'Adjusted EBITDA new build including mobile own network/BAU',
            'Adjusted EBITDA Consumer own network/BAU',
            'Opex New Build including mobile own network/BAU',
            'Opex Consumer own network/BAU',
            'Gross profit Consumer own network/BAU',
            'COGS  New Build including mobile own network/BAU',
            'COGS Consumer own network/BAU',
            'Revenue New Build including mobile own network/BAU',
            'Revenue Consumer own network/BAU',
            'Capex Consumer partner network',
            'Adjusted EBITDA Consumer partner network',
            'Opex Consumer partner network',
            'Gross profit Consumer partner network',
            'COGS Consumer partner network',
            'Revenue Consumer partner network',
            'YTD Fixed RGU excl Mobile net adds partner network',
            'Fixed RGU Net Adds including mobile',
            'YTD Fixed Customer excl mobile Net Adds partner network',
            'Fixed Customer Net Adds o/w New Build including mobile',
            'Periodic Fixed RGUs excl Mobile FTTH',
            'Cumulative RGUs including mobile',
            'Fixed customer excl mobile partner networks',
            'Cumulative new build customers including mobile',
            'Cumulative homes constructed including mobile'
              )
            QUALIFY RANK() OVER (PARTITION BY year, view, entity, account ORDER BY timestamp DESC) = 1

    )

      SELECT * FROM all_data     ;;
  }

}
