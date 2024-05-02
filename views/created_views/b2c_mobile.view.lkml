include: "/features/dashboard_links.view.lkml"
include: "/features/important_dimensions.view.lkml"

view: b2c_mobile {
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
          'Periodic Avg RGU OB mobile postpay',
          'QTD Avg RGU OB mobile postpay',
          'Periodic churn postpay disconnects',
          'QTD churn postpay disconnects',
          'QTD mobile ARPU incl IX',
          'QTD prepay ARPU incl IX',
          'Periodic Prepay RGUs',
          'QTD Prepay RGUs',
          'Periodic Prepay Mobile Net Adds',
          'QTD Prepay Mobile Net Adds',
          'Capex allocated central mobile',
          'Capex tangible Mobile',
          'Adjusted EBITDA before recharge mobile',
          'Adjusted EBITDA mobile',
          'Opex allocated central mobile',
          'Tasklines direct costs equipment',
          'Tasklines direct costs',
          'COGS mobile old MNO license fees',
          'COGS mobile radio access network',
          'COGS mobile IX calls voice interconnect',
          'COGS mobile IX calls data interconnect',
          'COGS mobile IX calls mobile IC',
          'COGS mobile IX calls MMS TP',
          'COGS mobile IX calls mobile calls and porting TP',
          'COGS mobile IX calls SMS TP',
          'COGS mobile IX calls roaming TP',
          'COGS mobile IX data termination',
          'COGS Mobile',
          'Revenue mobile insurance revenue mobile device',
          'Revenue mobile o/w accessory',
          'Revenue mobile handsets o/w dongle',
          'Revenue mobile handsets o/w handset split contract model',
          'Revenue mobile handsets o/w other mobile device related',
          'Revenue mobile handsets o/w sale of equipment',
          'Revenue mobile handsets o/w standalone device',
          'Revenue mobile Other VAS placeholder',
          'Revenue mobile Other VAS oikoi subs',
          'Revenue mobile Other VAS IoT subs',
          'Revenue mobile Other VAS late charges',
          'Revenue mobile Other VAS handset',
          'Revenue mobile Other VAS service total',
          'Revenue mobile prepay service o/w interconnect',
          'Revenue mobile prepay handset',
          'Revenue mobile prepay',
          'Revenue mobile postpay handset o/w other service o/w reminder fees',
          'Revenue mobile postpay handset o/w other service o/w discounts',
          'Revenue mobile postpay handset o/w interconnect',
          'Revenue mobile postpay handset o/w out of bundle usage',
          'Revenue mobile postpay handset',
          'Revenue mobile postpay',
          'YTD Avg RGU OB mobile postpay',
          'YTD churn postpay disconnects',
          'YTD mobile ARPU incl IX',
          'YTD prepay ARPU incl IX',
          'YTD Prepay RGUs',
          'YTD Prepay Mobile Net Adds'
          )
      QUALIFY RANK() OVER (PARTITION BY year, view, entity, account ORDER BY timestamp DESC) = 1

)

SELECT * FROM all_data
      ;;
  }
}
