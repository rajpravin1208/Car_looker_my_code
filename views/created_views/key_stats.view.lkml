include: "/features/dashboard_links.view.lkml"
include: "/features/important_dimensions.view.lkml"

view: key_stats {
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
        WHERE metric_name IN (
            'QTD Fixed RGU ARPU',
            'Periodic Periodic Fixed and Business excl Mobile RGU Net Adds Gross Adds New Build Connects',
            'QTD Fixed and Business excl Mobile RGU Net Adds Gross Adds New Build Connects',
            'Fixed customer incl SOHO excl mobile 2',
            'Fixed customer incl SOHO excl mobile 1',
            'Periodic Fixed Customer incl SOHO excl Mobile Avg OB',
            'QTD Fixed Customer incl SOHO excl Mobile Avg OB',
            'Periodic Fixed Customer incl SOHO excl Mobile Net Adds Disconnects',
            'QTD Fixed Customer incl SOHO excl Mobile Net Adds Disconnects',
            'Periodic Fixed Customer incl SOHO excl Mobile Net Adds Gross Adds',
            'QTD Fixed Customer incl SOHO excl Mobile Net Adds Gross Adds',
            'Wholesale Mobile Connections',
            'Wholesale Total Connections',
            'Periodic Broadband Video DTH Net Adds',
            'QTD Broadband Video DTH Net Adds',
            'Periodic Broadband Video Enhanced Video Net Adds',
            'QTD Broadband Video Enhanced Video Net Adds',
            'Periodic Broadband Video Basic Video Net Adds',
            'QTD Broadband Video Basic Video Net Adds',
            'Periodic Avg Fixed and Business excl Mobile RGU OB',
            'QTD Avg Fixed and Business excl Mobile RGU OB',
            'Periodic Fixed and Business excl Mobile RGU Net Adds Disconnects',
            'QTD Fixed and Business excl Mobile RGU Net Adds Disconnects',
            'Periodic Fixed and Business excl Mobile RGU Net Adds Gross Adds',
            'QTD Fixed and Business excl Mobile RGU Net Adds Gross Adds',
            'YTD Fixed RGU ARPU',
            'YTD Avg Fixed and Business excl Mobile RGU Customer Balance',
            'Full ARPU Revenue',
            'Homes Built (in period)',
            'Partner Networks & FTTH',
            'Homes Passed o/w FTTH',
            'YTD Fixed Customer incl SOHO excl Mobile Avg OB',
            'YTD Fixed Customer incl SOHO excl Mobile Net Adds Disconnects',
            'YTD Fixed Customer incl SOHO excl Mobile Net Adds Gross Adds',
            'Total Customers Single Play Mobile',
            'Total Customers',
            'YTD Broadband Video DTH Net Adds',
            'YTD Broadband Video Enhanced Video Net Adds',
            'YTD Broadband Video Basic Video Net Adds',
            'YTD Avg Fixed and Business excl Mobile RGU OB',
            'YTD Fixed and Business excl Mobile RGU Net Adds Gross Adds New Build Connects',
            'YTD Fixed and Business excl Mobile RGU Net Adds Disconnects',
            'YTD Fixed and Business excl Mobile RGU Net Adds Gross Adds',
            'Total RGUS',
            'Mobile RGUs',
            'Periodic Fixed and Business excl Mobile RGU',
            'RGUs Video DTH',
            'RGUs Video Enhanced Video',
            'RGUs Video Basic Video',
            'RGUs Video',
            'Periodic Business RGUs excl mobile',
            'RGUs Voice',
            'Periodic RGUs Data/internet'
              )
        QUALIFY RANK() OVER (PARTITION BY year, view, entity, account ORDER BY timestamp DESC) = 1

    )

      SELECT * FROM all_data
      ;;
  }
}
