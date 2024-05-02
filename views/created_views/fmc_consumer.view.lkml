include: "/features/dashboard_links.view.lkml"
include: "/features/important_dimensions.view.lkml"

view: fmc_consumer {
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
        'Periodic mobile consumer bundling Avg customer balance',
        'QTD mobile consumer bundling Avg customer balance',
        'Periodic fixed consumer bundling Avg customer balance',
        'QTD fixed consumer bundling Avg customer balance',
        'Periodic FMC consumer bundling Avg customer balance',
        'QTD FMC consumer bundling Avg customer balance',
        'Periodic Postpay RGUs',
        'QTD Postpay RGUs',
        'QTD RGUs Data/internet',
        'Periodic Bundle net adds o/w single play mobile',
        'QTD Bundle net adds o/w single play mobile',
        'Periodic Bundle net adds single play',
        'QTD Bundle net adds single play',
        'Periodic Bundle net adds dual play',
        'QTD Bundle net adds dual play',
        'Periodic Bundle net adds triple play',
        'QTD Bundle net adds triple play',
        'Periodic Bundle net adds quad play',
        'QTD Bundle net adds quad play',
        'Periodic Churn Mobile only customer Avg OB',
        'QTD Churn Mobile only customer Avg OB',
        'Periodic Churn Mobile only disconnects',
        'QTD Churn Mobile only disconnects',
        'Periodic Churn Fixed only customer Avg OB',
        'QTD Churn Fixed only customer Avg OB',
        'Periodic Churn Fixed only disconnects',
        'QTD Churn Fixed only disconnects',
        'Periodic Churn FMC customer Avg OB',
        'QTD Churn FMC customer Avg OB',
        'Periodic Churn FMC disconnects',
        'QTD Churn FMC disconnects',
        'Periodic net adds o/w Mobile only',
        'QTD net adds o/w Mobile only',
        'Periodic net adds o/w Fixed only',
        'QTD net adds o/w Fixed only',
        'Periodic net adds o/w FMC',
        'QTD net adds o/w FMC',
        'Periodic net adds',
        'QTD net adds',
        'YTD net adds',
        'Capex allocated central Consumer incl Mobile',
        'Capex tangible Consumer incl Mobile',
        'Adjusted EBITDA before recharge Consumer incl Mobile',
        'Adjusted EBITDA Consumer incl Mobile',
        'Allocated Central TandI Opex Consumer incl Mobile',
        'Opex Consumer incl mobile',
        'Opex Consumer incl Mobile integration',
        'Opex Consumer incl Mobile dedicated opex',
        'Gross profit Consumer incl Mobile  o/w Mobile only',
        'Gross profit Consumer incl Mobile  o/w Fixed only',
        'Gross profit Consumer incl Mobile  o/w FMC',
        'Gross profit Consumer incl Mobile',
        'COGS Consumer incl Mobile Taskline',
        'COGS mobile Handset Costs',
        'COGS Consumer incl Mobile Interconnect',
        'COGS Programming Other Encoding & Materials',
        'COGS Programming Other EPG',
        'COGS Programming Owned and Operated',
        'COGS Programming Other Content TVOD',
        'COGS Programming Other Content SVOD',
        'COGS Programming Premium Content',
        'COGS Programming Copyrights',
        'COGS Programming DC_VD_PR o/w Total Content',
        'COGS Consumer incl Mobile',
        'Revenue consumer incl Mobile o/w Mobile',
        'Revenue consumer incl Mobile o/w Fixed',
        'Revenue consumer incl Mobile o/w FMC',
        'Revenue consumer incl Mobile',
        'YTD mobile consumer bundling Avg customer balance',
        'Mobile Subscription revenue',
        'YTD fixed consumer bundling Avg customer balance',
        'Fixed Subscription revenue',
        'YTD FMC consumer bundling Avg customer balance',
        'FMC Subscription revenue',
        'YTD Postpay RGUs',
        'YTD RGUs Data/internet',
        'YTD Bundle net adds o/w single play mobile',
        'YTD Bundle net adds single play',
        'YTD Bundle net adds dual play',
        'YTD Bundle net adds triple play',
        'YTD Bundle net adds quad play',
        'Customers o/w mobile only',
        'Customers o/w Fixed only',
        'Customers o/w FMC',
        'Customers',
        'YTD Churn Mobile only customer Avg OB',
        'YTD Churn Mobile only disconnects',
        'YTD Churn Fixed only customer Avg OB',
        'YTD Churn Fixed only disconnects',
        'YTD Churn FMC customer Avg OB',
        'YTD Churn FMC disconnects',
        'YTD net adds o/w Mobile only',
        'YTD net adds o/w Fixed only',
        'YTD net adds o/w FMC'
        )
        QUALIFY RANK() OVER (PARTITION BY year, view, entity, account ORDER BY timestamp DESC) = 1

)

  SELECT * FROM all_data
    ;;
  }
}
