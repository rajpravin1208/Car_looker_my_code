include: "/features/dashboard_links.view.lkml"
include: "/features/important_dimensions.view.lkml"

view: revenue {
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
            'Revenue B2B (incl Mobile)o/w Subscription B2B o/w Large enterprise',
            'Revenue B2B (incl Mobile)o/w Subscription B2B o/w SME',
            'Revenue B2B (incl Mobile)o/w Subscription B2B o/w SOHO',
            'Revenue B2B (incl Mobile)Regulated wholesale',
            'Revenue B2B (incl Mobile)excl Regulated wholesale',
            'Revenue B2B (incl Mobile)wholesale',
            'Revenue B2B (incl Mobile)Large Enterprise',
            'Revenue B2B (incl Mobile)SME',
            'Revenue B2B (incl Mobile) SOHO',
            'Revenue mobile o/w Subscription',
            'Revenue mobile construction sales',
            'Revenue mobile service interconnect',
            'Revenue mobile service out of bundle usage',
            'Revenue mobile handsets',
            'Revenue consumer other central',
            'Revenue consumer other programming',
            'Revenue consumer excluding other',
            'Revenue non-subscription consumer late payment fees',
            'Revenue non-subscription consumer carriage fees',
            'Revenue non-subscription consumer fixed interconnect',
            'Revenue Consumer Broadband subscription revenue video premium',
            'Revenue Consumer Broadband subscription revenue video TVOD',
            'Revenue Consumer Broadband subscription revenue video',
            'Revenue Consumer Broadband subscription revenue voice out of bundle usage',
            'Revenue Consumer Broadband subscription revenue voice',
            'Revenue Consumer Broadband subscription revenue data',
            'Revenue Consumer Broadband subscription revenue'
             )
            QUALIFY RANK() OVER (PARTITION BY year, view, entity, account ORDER BY timestamp DESC) = 1
    )

      SELECT * FROM all_data

      ;;
  }
}
