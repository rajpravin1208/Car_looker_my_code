include: "/features/dashboard_links.view.lkml"
include: "/features/important_dimensions.view.lkml"

view: sales_and_mktg {
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
            'Periodic Mobile Net Adds Disconnects',
            'QTD Mobile Net Adds Disconnects',
            'Periodic Fixed RGU Net Adds Disconnects',
            'QTD Fixed RGU Net Adds Disconnects',
            'Periodic Avg Mobile RGUs',
            'QTD Avg Mobile RGUs',
            'Periodic Avg Basic RGUs',
            'QTD Avg Basic RGUs',
            'Periodic Avg Consumer RGUs',
            'QTD Avg Consumer RGUs',
            'Periodic Fixed excl Mobile RGU Net Adds Gross Adds',
            'QTD Fixed excl Mobile RGU Net Adds Gross Adds',
            'Periodic Avg RGU OB mobile',
            'QTD Avg RGU OB mobile',
            'Periodic Avg Fixed RGU OB excluding mobile',
            'QTD Avg Fixed RGU OB excluding mobile',
            'Periodic RGUs Data/internet gross adds',
            'QTD RGUs Data/internet gross adds',
            'Periodic Postpay RGUs gross adds',
            'QTD Postpay RGUs gross adds',
            'YTD Mobile Net Adds Disconnects',
            'YTD Fixed RGU Net Adds Disconnects',
            'YTD Avg RGU OB mobile',
            'YTD Avg Fixed RGU OB excluding mobile',
            'Revenue mobile handsets alternate',
            'Revenue subscription mobile postpay',
            'Revenue subscription Fixed Consumer basic',
            'YTD Avg Mobile RGUs',
            'YTD Avg Basic RGUs',
            'YTD Avg Consumer RGUs',
            'YTD RGUs Data/internet gross adds',
            'YTD RGUs video gross adds',
            'Capex hardware data IC AccDepn Consumer incl Mobile',
            'Capex hardware data IC gross Consumer incl Mobile',
            'Capex hardware data Consumer incl Mobile',
            'CPE tangible CPE capex data',
            'CPE installations used data',
            'CPE installations new data',
            'Capex hardware video IC AccDepn Consumer incl Mobile',
            'Capex hardware video IC gross Consumer incl Mobile',
            'Capex hardware video Consumer incl Mobile',
            'CPE tangible CPE capex video',
            'CPE installations used video',
            'CPE installations new video',
            'YTD Postpay RGUs gross adds',
            'YTD Fixed excl Mobile RGU Net Adds Gross Adds',
            'Revenue cancellation mobile',
            'Revenue installation mobile',
            'Revenue non-subscription fixed cancellation Fixed Consumer',
            'Revenue non-subscription fixed amortisation install Fixed Consumer',
            'Opex Sales and marketing SAC Promotional TLD',
            'Opex Sales and marketing SAC Labour E2E marketing',
            'Opex Sales and marketing SAC Labour E2E sales',
            'Opex Sales and marketing SAC Facilities and fleet',
            'Opex Sales and marketing SAC Sales commissions',
            'Opex Sales and marketing SAC Direct Communications',
            'Opex Sales and marketing Other marketing Other marketing spend and overhead',
            'Opex Sales and marketing Other marketing Total CRM and digital other',
            'Opex Sales and marketing Other marketing Market research',
            'Opex Sales and marketing Other marketing Sponsorships',
            'Opex Sales and marketing Above the line Media Creative and production',
            'Opex Sales and marketing Above the line Media Events, brand activation and promotions',
            'Opex Sales and marketing Above the line Media advertising',
            'Opex Sales and marketing B2B',
            'Opex Sales and marketing Consumer incl Mobile'
            )
        QUALIFY RANK() OVER (PARTITION BY year, view, entity, account ORDER BY timestamp DESC) = 1
)

SELECT * FROM all_data
;;
  }

}
