include: "/features/dashboard_links.view.lkml"
include: "/features/important_dimensions.view.lkml"

view: summary_ex_nb {
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
            'Periodic Total Fixed and Business excl Mobile RGU Net Adds',
            'QTD Total Fixed and Business excl Mobile RGU Net Adds',
            'Capex Support Other',
            'Capex New Build Support Capacity',
            'Capex New Build Support Baseline',
            'Capex New Build old structure',
            'Capex New Build SOHO',
            'Capex New Build Resi',
            'Capex New Build CPE',
            'Capex Non-CPE inventory movement',
            'Capex CPE inventory movement',
            'Capex Tangible',
            'Opex Estimated New Build',
            'Opex New Build Sales and Marketing',
            'Opex New Build Other Costs',
            'Gross profit B2B estimated New Build',
            'Gross profit estimated New Build',
            'COGS estimated New Build',
            'New Build Other Revenue',
            'New Build Revenue Discounts',
            'New Build Subscription Revenue',
            'Cumulative new build customers excluding mobile',
            'Fixed Customer incl SOHO excl Mobile',
            'Fixed RGU Net Adds excluding mobile',
            'YTD Total Fixed and Business excl Mobile RGU Net Adds',
            'Cumulative homes constructed excluding mobile',
            'Total Homes Passed CH',
            'Total Homes Passed'
            )
          QUALIFY RANK() OVER (PARTITION BY year, view, entity, account ORDER BY timestamp DESC) = 1
    )

      SELECT * FROM all_data

      ;;
  }

}
