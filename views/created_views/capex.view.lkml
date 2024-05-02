include: "/features/dashboard_links.view.lkml"
include: "/features/important_dimensions.view.lkml"

view: capex {
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
                      'Capex Tangible task lines',
                      'Capex baseline Mobile old based on Account',
                      'Capex baseline Mobile new based on C3',
                      'Capex baseline Technology old based on Account',
                      'Capex baseline Technology new based on C3',
                      'Capex baseline Tech Facilities old based on Account',
                      'Capex baseline Tech Facilities new based on C3',
                      'Capex baseline PFF old based on Account',
                      'Capex baseline PFF new based on C3',
                      'Capex baseline Access old based on Account',
                      'Capex baseline Access new based on C3',
                      'Capex baseline Core old based on Account',
                      'Capex baseline Core new based on C3',
                      'Capex baseline IT old based on Account',
                      'Capex baseline IT new based on C3',
                      'Capex baseline intangibles',
                      'Capex baseline unallocated taskline',
                      'Capex baseline',
                      'Capex Enablers elim double C1-C3',
                      'Capex Enablers old mobile based on C1',
                      'Capex Enablers new mobile based on C3',
                      'Capex Enablers Access',
                      'Capex Enablers Core',
                      'Capex Enablers Technology',
                      'Capex Enablers Security',
                      'Capex Enablers IT',
                      'Capex Enablers Customer experience',
                      'Capex Product Development B2B elim double C1-C3',
                      'Capex Product Development old B2B based on C1',
                      'Capex Product Development new B2B based on C3',
                      'Capex Product Development elim double C1-C3',
                      'Capex Product Development old mobile based on C1',
                      'Capex Product Development new mobile based on C3',
                      'Capex Product Development Connectivity',
                      'Capex Product Development Entertainment',
                      'Capex Capacity mobile capacity access old',
                      'Capex Capacity mobile capacity access C3',
                      'Capex Capacity Node splits',
                      'Capex Capacity Spectrum',
                      'Capex Capacity CMTS',
                      'Capex Capacity Core old',
                      'Capex Capacity Core C3',
                      'Capex special build',
                      'Capex New Build and Upgrades B2B',
                      'Capex Consumer incl Mobile upgrade',
                      'Capex Consumer incl Mobile new build',
                      'Capex non CPE installations',
                      'Capex CPE excluding non-CPE installation B2B',
                      'Capex CPE excluding non-CPE installation Consumer incl Mobile external labour',
                      'Capex CPE excluding non-CPE installation Consumer incl Mobile internal labour',
                      'Capex CPE excluding non-CPE installation Consumer incl Mobile',
                      'Capex CPE excluding non-CPE installation'
                       )
                      QUALIFY RANK() OVER (PARTITION BY year, view, entity, account ORDER BY timestamp DESC) = 1

        )

        SELECT * FROM all_data
        ;;
  }
}
