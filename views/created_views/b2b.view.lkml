include: "/features/dashboard_links.view.lkml"
include: "/features/important_dimensions.view.lkml"


view: b2b {
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
          'Periodic Avg customers SOHO excl mobile',
          'QTD Avg customers SOHO excl mobile',
          'Periodic Net adds SOHO Customers',
          'QTD Net adds SOHO Customers',
          'QTD Business RGUs excl Mobile ARPU',
          'QTD Business RGUs excl mobile',
          'Capex allocated central B2B',
          'Capex tangible B2B',
          'Adjusted EBITDA B2B',
          'Capex tangible B2B Wholesale',
          'Adjusted EBITDA (incl Mobile) Wholesale',
          'Gross profit B2B (incl Mobile) Wholesale',
          'Capex tangible B2B Large Enterprise',
          'Adjusted EBITDA (incl Mobile) Large Enterprise',
          'Gross profit B2B (incl Mobile) Large Enterprise',
          'Capex tangible B2B SME',
          'Adjusted EBITDA (incl Mobile) SME',
          'Gross profit B2B (incl Mobile) SME',
          'Capex tangible B2B SOHO',
          'Adjusted EBITDA B2B (incl Mobile) SOHO',
          'Gross profit B2B (incl Mobile) SOHO',
          'YTD Avg customers SOHO excl mobile',
          'Revenue SOHO excl mobile',
          'YTD Net adds SOHO Customers',
          'YTD Business RGUs excl Mobile ARPU',
          'YTD Business RGUs excl mobile'
          )
            QUALIFY RANK() OVER (PARTITION BY year, view, entity, account ORDER BY timestamp DESC) = 1
)

SELECT * FROM all_data
      ;;
  }
}
