  view: dashboard_links {

# This view file contains the dashboard links that are used as buttons on the dashboards for users to navigate the recharge user journey.
# Where the measure name finishes with "Current Page", this indicates that the measure will be used on the dashboard that matches the measure name.
# There are two measures for each dashboard, with the colour made different based on if the tab is on the active dashboard page.


#### -----  Hyperlinks { ----- ####

    dimension: welcome_link {
      hidden: no
      description: "This links to the Welcome dashboard."
      group_label: "Html links"
      sql: 1 ;;
      html: <div style = '
          font-size: 20px;'
          ><a
      href="https://lssdataservices.cloud.looker.com/dashboards/9"
      style = "color:#243347"
      >
       Welcome</a> ;;
    }


    dimension: All_views {
      hidden: no
      description: "This links to the Welcome dashboard."
      group_label: "Html links"
      sql: 1 ;;
      html: <div style = '
          font-size: 20px;'
          ><a
      href="https://lssdataservices.cloud.looker.com/dashboards/42"
      style = "color:#243347"
      >
       All Views</a> ;;
    }

    dimension: Summary_link {
      hidden: no
      description: "This links to the Welcome dashboard Summary tab"
      group_label: "Html links"
      sql: 1 ;;
      html: <div style = '
          font-size: 20px;'
          ><a
      href="https://lssdataservices.cloud.looker.com/dashboards/15?Year=&Period=&Quarter=&Entity="
      style = "color:#243347"
      >
       Summary </a> ;;
    }

    dimension: New_Build_link {
      hidden: no
      description: "This links to the Welcome dashboard New build tab ."
      group_label: "Html links"
      sql: 1 ;;
      html: <div style = '
          font-size: 20px;'
          ><a
      href=""
      style = "color:#243347"
      >
       New Build</a> ;;
    }

    dimension: Open_E2E_link{
      hidden: no
      description: "This links to the welcome dashboard E2E."
      group_label: "Html links"
      sql: 1 ;;
      html: <div style = '
          font-size: 20px;'
          ><a
      href=""
      style = "color:#243347"
      >
       Opex E2E </a> ;;
    }

    dimension: Capex_link {
      hidden: no
      description: "This links to the welcome dashboard capex tab."
      group_label: "Html links"
      sql: 1 ;;
      html: <div style = '
          font-size: 20px;'
          ><a
      href=""
      style = "color:#243347"
      >
      Capex </a> ;;
    }

    dimension: Profitability_link {
      hidden: no
      description: "This links to the welcome dashboard Profitability tab."
      group_label: "Html links"
      sql: 1 ;;
      html: <div style = '
          font-size: 20px;'
          ><a
      href=""
      style = "color:#243347"
      >
      Profitability </a> ;;
    }


    dimension: KPi_link {
      hidden: no
      description: "This links to the welcome dashboard KPI Tab."
      group_label: "Html links"
      sql: 1 ;;
      html: <div style = '
          font-size: 20px;'
          ><a
      href=""
      style = "color:#243347"
      >
      KPI's </a> ;;
    }

    dimension: Spend_cube_link {
      hidden: no
      description: "This links to the welcome dashboard Spend Cube tab."
      group_label: "Html links"
      sql: 1 ;;
      html: <div style = '
          font-size: 20px;'
          ><a
      href=""
      style = "color:#243347"
      >
      Spend Cube </a> ;;
    }

    dimension: FCF_link {
      hidden: no
      description: "This links to the welcoome dashboard FCF tab."
      group_label: "Html links"
      sql: 1 ;;
      html: <div style = '
          font-size: 20px;'
          ><a
      href=""
      style = "color:#243347"
      >
      FCF </a> ;;
    }

    dimension: Rebase_link {
      hidden: no
      description: "This links to the welcome dashboard Rebase tab."
      group_label: "Html links"
      sql: 1 ;;
      html: <div style = '
          font-size: 20px;'
          ><a
      href=""
      style = "color:#243347"
      >
      Rebase </a> ;;
    }

    #### -----  Hyperlinks } ----- ####

  }
