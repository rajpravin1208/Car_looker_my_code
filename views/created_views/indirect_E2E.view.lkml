include: "/features/dashboard_links.view.lkml"
include: "/features/important_dimensions.view.lkml"

view: indirect_e2e {
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
          'Opex alternate support',
          'Opex alternate commercial',
          'Opex alternate technology and innovation',
          'Opex unallocated central budget',
          'Opex unallocated other',
          'Opex unallocated tasking',
          'Opex Bonus Finance',
          'Opex Bonus Shared Services',
          'Opex Bonus Billing and Collection',
          'Opex Bonus Commercial',
          'Opex Bonus Technology and Innovation',
          'Opex management and support people',
          'Opex management and support legal',
          'Opex Billing and Collection bad debt provision',
          'Opex Finance excl PFF specialist groups',
          'Opex Finance excl PFF accounting and reporting',
          'Opex Finance excl PFF risk and compliance',
          'Opex Finance excl PFF procurement',
          'Opex Finance excl PFF control and capital allocation',
          'Opex Finance excl PFF',
          'Opex PFF network property taxes',
          'Opex PFF fleet',
          'Opex PFF facility management',
          'Opex PFF real estate',
          'Opex PFF',
          'Opex Commercial Customer Care',
          'Opex Commercial Sales',
          'Opex Commercial Customer Field Ops',
          'Opex Commercial Marketing',
          'Opex Technology and Innovation Supply Chain',
          'Opex Technology and Innovation GDO, IT and PM',
          'Opex Technology and Innovation Core and Access'
          )
      QUALIFY RANK() OVER (PARTITION BY year, view, entity, account ORDER BY timestamp DESC) = 1

)

SELECT * FROM all_data
 ;;
}
}
