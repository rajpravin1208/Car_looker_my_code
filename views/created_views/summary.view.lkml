include: "/features/dashboard_links.view.lkml"
include: "/features/important_dimensions.view.lkml"
include: "/features/filters_alerts.view.lkml"

view: summary {
  extends: [dashboard_links,important_dimensions,filters_alerts]

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

      WHERE
       metric_name IN
      ('QTD Broadband Net Adds', 'Periodic Broadband Net Adds', 'QTD Broadband Internet', 'Periodic Broadband Internet', 'QTD Broadband Voice Net Adds', 'Periodic Broadband Voice Net Adds',
      'QTD Broadband Video Net Adds', 'Periodic Broadband Video Net Adds', 'QTD Broadband Net Adds o/w SOHO', 'Periodic Broadband Net Adds o/w SOHO', 'QTD Postpaid Mobile Net Adds',
      'Periodic Postpaid Mobile Net Adds', 'QTD Postpaid ARPU incl IX', 'QTD Fixed Customer incl SOHO excl Mobile Net Adds', 'Periodic Fixed Customer incl SOHO excl Mobile Net Adds',
      'QTD Fixed Customer incl SOHO excl Mobile Avg customers', 'Periodic Fixed Customer incl SOHO excl Mobile Avg customers', 'SOHO Customers on Resi', 'QTD Bundles Internet + Mobile',
      'Periodic Bundles Internet + Mobile', 'QTD Internet RGUs', 'Periodic Internet RGUs', 'COGS Affiliates', 'Gross Profit Regulated Wholesale', 'CF checks', 'YTD Broadband Net Adds',
      'YTD Broadband Internet Net Adds', 'YTD Broadband Voice Net Adds', 'YTD Broadband Video Net Adds', 'YTD Broadband Net Adds o/w SOHO', 'YTD Postpaid Mobile Net Adds', 'YTD Postpay ARPU incl IX',
      'YTD Fixed Customer incl SOHO excl Mobile Net Adds', 'Fixed Customer Net Adds o/w New Build', 'Revenue subscription', 'YTD Fixed Customer incl SOHO excl Mobile Avg customers',
      'Periodic SOHO Customers', 'SOHO Market Size', 'YTD Bundles Internet + Mobile', 'YTD Internet RGUs', 'Revenue', 'Revenue Consumer', 'Revenue New Build', 'Revenue mobile',
      'Revenue B2B (incl Mobile)', 'COGS', 'COGS Programming DC_VD_PR', 'COGS Interconnect', 'Gross Profit', 'Gross Profit Consumer', 'Gross Profit mobile', 'Gross Profit B2B (incl Mobile)',
      'Opex', 'Opex Technology and Innovation', 'Opex Commercial', 'Opex Billing and Collection', 'Opex Finance', 'Opex Shared Services', 'Opex Bonus', 'Opex LG Ventures',
      'Opex Unallocated Tasks and Other', 'Opex SSC Credit', 'Opex Net Internal Labour including Contingent labour excl Bonus', 'Opex Net Bonus', 'Opex Sales and marketing',
      'Opex Other External Spend', 'Opex Task lines', 'OCF (Pre Allocation)', 'Allocated TandI Opex', 'Adjusted EBITDA', 'Depreciation and Interest (Fin Lease)', 'EBITDAaL',
      'Capex incl intangibles', 'Capex o/w CapLease Additions', 'Capex CPE', 'Capex New Build and Upgrades', 'Capex Capacity', 'Capex Product Development', 'Capex Enablers',
      'Capex Non-CPE Acct, CPE C3', 'Capex allocated central', 'OFCF (Post Allocation)', 'Rebasing Adj', 'OFCFaL', 'Interest Expense', 'Derivatives', 'Interest Allocation',
      'Interest Income', 'Tax', 'Dividends', 'Shareholder distribution', 'TWC Customer', 'TWC Supplier', 'TWC VAT', 'TWC Personnel', 'External working capital CC', 'External working capital',
      'IC Cap Creds CF_CapCredIC', 'IC Cap Creds CF_CapexAccrualsIC', 'Operational IC Trading', 'Operational Finance', 'Capital Leases (non VF)', 'Direct Acquisition Costs', 'Restructuring', 'SBC',
      'Non OCF 3rd party', 'Current restricted cash', 'Long term restricted cash', 'Current Portion of Debt', 'Long term debt'
      )
      QUALIFY RANK() OVER (PARTITION BY year, view, entity, account ORDER BY timestamp DESC) = 1)

Select * from all_data;;
  }

}
