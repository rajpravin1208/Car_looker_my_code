include: "/views/created_views/*.view.lkml"  # include all views in the views/ folder in this project
include: "/dashboards/*.lookml"

explore: summary {
  group_label: "CAR Reporting Development"
  label: "Summary"
  description: "View of Summary Data"
}


explore: fmc_consumer {
  group_label: "CAR Reporting Development"
  label: "FMC Consumer"
  description: "View of FMC Consumer Data"
}

explore: fixed_consumer {
  group_label: "CAR Reporting Development"
  label: "Fixed Consumer"
  description: "View of fixed_consumer Data"
}

explore: fixed_consumer_bau {
  group_label: "CAR Reporting Development"
  label: "Fixed Consumer BAU"
  description: "View of Fixed Consumer BAU Data"
}


explore: fixed_customer_arpu {
  group_label: "CAR Reporting Development"
  label: "Fixed Customer ARPU"
  description: "View of Fixed Customer ARPU Data"
}


explore: key_stats {
  group_label: "CAR Reporting Development"
  label: "Key Statistics"
  description: "View of Key Statistics Data"
}

explore: new_build {
  group_label: "CAR Reporting Development"
  label: "New Build"
  description: "View of New Build Data"
}

explore: revenue {
  group_label: "CAR Reporting Development"
  label: "Revenue"
  description: "View of Revenue Data"
}

explore: summary_ex_nb {
  group_label: "CAR Reporting Development"
  label: "Summary Ex NB"
  description: "View of Summary Ex NB Data"
}

# explore: vs_prior_role {
#   group_label: "CAR Reporting Development"
#   label: "Changes since Prior Roll"
#   description: "View of Changes since Prior Roll Data"
# }


explore: b2b {
  group_label: "CAR Reporting Development"
  label: "B2B"
  description: "View of B2B Data"
}

explore: b2c_mobile{
  group_label: "CAR Reporting Development"
  label: "Consumer Mobile"
  description: "View of Consumer Mobile Data"
}

explore: indirect_e2e {
  group_label: "CAR Reporting Development"
  label: "Indirect E2E"
  description: "View of Indirect E2E Data"
}

explore: labour {
  group_label: "CAR Reporting Development"
  label: "Labour Costs"
  description: "View of Labour Costs Data"
}

explore: sales_and_mktg {
  group_label: "CAR Reporting Development"
  label: "Sales & Marketing"
  description: "View of Sales & Marketing Data"
}

explore: external_costs {
  group_label: "CAR Reporting Development"
  label: "Other External Spend"
  description: "View of Other External Spend Data"
}

explore: capex {
  group_label: "CAR Reporting Development"
  label: "Capex"
  description: "View of capex Data"
}

explore: ext_labour {
  group_label: "CAR Reporting Development"
  label: "External Labour"
  description: "View of External Labour Data"
}

explore: gross_profit_cogs_gp_ {
  group_label: "CAR Reporting Development"
  label: "Gross Profit"
  description: "View of Gross Profit Data"
}

explore: executive_summary {
  group_label: "CAR Reporting Development"
  label: "Executive Summary"
  description: "View of Executive Summary Data"
}

explore: all_views {
  group_label: "CAR Reporting Development"
  label: "All Views"
  description: "View of All  Data"
}

# explore: summary_mtd_and_fy_vs_pr {
#   group_label: "CAR Reporting Development"
#   label: "Summary MTD and FY vs Prior Roll"
#   description: "View of Summary MTD and FY vs Prior Roll Data"
# }

# explore: vs_pr_per_q {
#   group_label: "CAR Reporting Development"
#   label: "Quarter vs Prior Roll"
#   description: "View of Quarter vs Prior Roll Data"
# }
