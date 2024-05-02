include: "/features/dashboard_links.view.lkml"
include: "/features/important_dimensions.view.lkml"

view: fixed_customer_arpu {
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

       WHERE   metric_name IN (
            'Periodic Avg Fixed and Business excl Mobile RGU Customer Balance',
            'QTD Avg Fixed and Business excl Mobile RGU Customer Balance',
            'Subscription revenue out of bundle equipment sales',
            'Subscription revenue out of bundle usage cancellation revenue',
            'Subscription revenue out of bundle usage late payment fees',
            'Subscription revenue out of bundle usage installation fees',
            'Subscription revenue out of bundle usage carriage fees',
            'Subscription revenue out of bundle usage fixed interconnect',
            'Subscription revenue out of bundle usage',
            'Subscription revenue rental revenue',
            'Subscription revenue other discounts',
            'Subscription revenue CPE discounts',
            'Subscription revenue other recurring discounts',
            'Subscription revenue Retention TLD',
            'Subscription revenue promotional TLD',
            'Gross subscription revenue amortised install/equipment',
            'Gross subscription revenue EBT SOHO',
            'Gross subscription revenue EBT DTH',
            'Gross subscription revenue EBT DTV',
            'Gross subscription revenue EBT CATV',
            'Gross subscription revenue SVOD SOHO',
            'Gross subscription revenue SVOD Consumer',
            'Gross subscription revenue Premium SOHO',
            'Gross subscription revenue Premium DTH',
            'Gross subscription revenue Premium DTV'
            )
            QUALIFY RANK() OVER (PARTITION BY year, view, entity, account ORDER BY timestamp DESC) = 1

    )

      SELECT * FROM all_data;;
  }
}
