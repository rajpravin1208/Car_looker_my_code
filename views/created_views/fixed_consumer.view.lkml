include: "/features/dashboard_links.view.lkml"
include: "/features/important_dimensions.view.lkml"


view: fixed_consumer {
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
            'Periodic Avg video RGUs',
            'QTD Avg video RGUs',
            'QTD Fixed Consumer RGU ARPU',
            'Periodic Fixed RGU excl Mobile net adds',
            'QTD Fixed RGU excl Mobile net adds',
            'Periodic Fixed customer excl mobile Avg customers residential',
            'QTD Fixed customer excl mobile Avg customers',
            'Periodic Fixed customer excl mobile net adds',
            'QTD Fixed customer excl mobile net adds',
            'Capex allocated central Fixed Consumer',
            'Capex tangible fixed consumer',
            'Adjusted EBITDA before recharge Fixed Consumer',
            'Adjusted EBITDA Fixed Consumer',
            'Allocated Central TandI Opex Fixed consumer',
            'COGS taskline fixed consumer',
            'COGS Interconnect fixed consumer',
            'YTD Avg video RGUs',
            'COGS fixed consumer',
            'Fixed consumer other revenue construction',
            'Fixed consumer other revenue partner network',
            'Fixed consumer other revenue offnet',
            'Fixed consumer other revenue AVAD',
            'Fixed consumer other revenue programming revenue',
            'Revenue non-subscription installation fees Fixed Consumer',
            'Revenue subscription Fixed Consumer video',
            'Revenue subscription Fixed Consumer voice',
            'Revenue subscription Fixed Consumer data',
            'Revenue subscription Fixed Consumer',
            'YTD Fixed Consumer RGU ARPU',
            'YTD Fixed RGU excl Mobile net adds',
            'Periodic Fixed RGUs excl Mobile',
            'YTD Fixed customer excl mobile Avg customers residential',
            'Subscription revenue residential',
            'YTD Fixed customer excl mobile net adds',
            'Fixed customer excl mobile'
            )
            QUALIFY RANK() OVER (PARTITION BY year, view, entity, account ORDER BY timestamp DESC) = 1

    )

      SELECT * FROM all_data;
      ;;
  }
}
