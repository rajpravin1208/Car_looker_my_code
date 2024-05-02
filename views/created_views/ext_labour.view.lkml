include: "/features/dashboard_links.view.lkml"
include: "/features/important_dimensions.view.lkml"

view: ext_labour {
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
                  'Direct Acquisition and disposition Costs',
                  'Opex Business Services Consultancy and Professional Services Finance',
                  'Opex Business Services Consultancy and Professional Services Shared services',
                  'Opex Business Services Consultancy and Professional Services Billing and Collection',
                  'Opex Business Services Consultancy and Professional Services Commercial',
                  'Opex Business Services Consultancy and Professional Services Technology and innovation',
                  'Opex Business Services Consultancy and Professional Services inactive other audit or legal fees',
                  'Opex Business Services Consultancy and Professional Services Corporate responsibility',
                  'Opex Business Services Consultancy and Professional Services Audit fees',
                  'Opex Business Services Consultancy and Professional Services Advisory Tax',
                  'Opex Business Services Consultancy and Professional Services Advisory Legal',
                  'Opex Business Services Consultancy and Professional Services Accounting Services',
                  'Opex Business Services Consultancy and Professional Services Consultancy/advisory (top 16)',
                  'Opex Business Services Consultancy and Professional Services Other IT',
                  'Opex Business Services Consultancy and Professional Services Other'
                    )
                  QUALIFY RANK() OVER (PARTITION BY year, view, entity, account ORDER BY timestamp DESC) = 1

)

      SELECT * FROM all_data     ;;
  }
}
