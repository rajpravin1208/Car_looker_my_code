include: "/features/dashboard_links.view.lkml"
include: "/features/important_dimensions.view.lkml"

view: labour {
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
          'FTEs Avg contingent labour YTD',
          'FTEs Avg active on payroll YTD',
          'FTEs Avg opex',
          'FTEs incl BPO',
          'FTEs intercompany',
          'FTEs BPO outsourced',
          'FTEs capex - contingent labour',
          'FTEs opex - contingent labour',
          'FTEs opex - payroll',
          'FTEs opex',
          'Opex Outsourced Labour Commissions Third Party',
          'Opex Outsourced Labour Outsourced Call Centre',
          'Opex Business Services BPO Finance',
          'Opex Core NW and IT BPO IT',
          'Opex Labour incl Bonus',
          'Opex Contingent Labour def contingent labour',
          'Opex Contingent Labour Intercompany',
          'Opex Contingent Labour Capitalised Labour',
          'Opex Contingent Labour CapLabour gross-up',
          'Opex Contingent Labour Temporary Personnel',
          'Opex Contingent Labour Specialists',
          'Opex Contingent Labour',
          'Opex Net Internal Labour Intercompany',
          'Opex Net Internal Labour Capitalised Labour',
          'Opex Net Internal Labour Payroll Payroll Taxes',
          'Opex Net Internal Labour Payroll Commissions',
          'Opex Net Internal Labour Payroll Salary',
          'Opex Net Internal Labour Payroll',
          'Opex Net Internal Labour'
            )
    QUALIFY RANK() OVER (PARTITION BY year, view, entity, account ORDER BY timestamp DESC) = 1

)

SELECT * FROM all_data
     ;;
  }
}
