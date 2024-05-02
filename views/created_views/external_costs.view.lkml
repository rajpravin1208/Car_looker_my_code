include: "/features/dashboard_links.view.lkml"
include: "/features/important_dimensions.view.lkml"


view: external_costs {
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
              'Opex inactive accounts',
              'Opex other Opex other expenses',
              'Opex other Opex intercompany expenses',
              'Opex other Opex aircraft expenses',
              'Opex other Opex regulatory fees',
              'Opex other Opex charitable contributions',
              'Opex other Opex franchise fees/taxes',
              'Opex other opex bad debt provision',
              'Opex other opex payment processing',
              'Opex other opex insurance',
              'Opex other opex',
              'Opex Business Services People Services',
              'Opex Business Services Travel and Entertainment',
              'Opex Business Services Fleet',
              'Opex Business Services Energy',
              'Opex Business Services Consultancy and Professional Services',
              'Opex Business Services',
              'Opex Customer Services Supply Chain',
              'Opex Customer Services Contact Centres',
              'Opex Customer Services',
              'Opex Access Contracted Labour',
              'Opex Access',
              'Opex Core NW and IT Security',
              'Opex Core NW and IT IT professional services',
              'Opex Core NW and IT Software and hardware',
              'Opex Core NW and IT Leased bandwidth and data',
              'Opex Core NW and IT Data Centers and NOC',
              'Opex Core NW and IT Core',
              'Opex Core NW and IT',
              'Opex service delivery platform cloud / head-end',
              'Opex service delivery platform mobile',
              'Opex service delivery platform'
                )
              QUALIFY RANK() OVER (PARTITION BY year, view, entity, account ORDER BY timestamp DESC) = 1

)

SELECT * FROM all_data    ;;
}
}
