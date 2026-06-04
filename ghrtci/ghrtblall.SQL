
USE [DBShrpn]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_current_temp2' )
   DROP TABLE [dbo].[ghr_current_temp2]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_current_temp2](
	[Employee_Number] [char](15) NOT NULL,
	[First_Name] [char](25) NOT NULL,
	[Middle_Name] [char](25) NOT NULL,
	[Last_Name] [char](30) NOT NULL,
	[Employer] [char](10) NOT NULL,
	[National_Id_Type] [char](5) NOT NULL,
	[National_Id_Nbr] [char](20) NOT NULL,
	[Position Title] [char](50) NOT NULL,
	[rganization_Unit_name] [varchar](240) NOT NULL,
	[Annual_Salary] [money] NOT NULL,
	[Time_Reporting_Method] [char](1) NOT NULL,
	[Pay_Element_Ctrl_Group] [char](10) NOT NULL,
	[Pay_Group] [char](10) NOT NULL,
	[Pay_Status] [char](1) NOT NULL,
	[Pay_Through_Date] [datetime] NOT NULL,
	[Hire_Date] [datetime] NOT NULL,
	[Original Job_Position_Title] [char](80) NULL,
	[Employee Status] [char](1) NOT NULL
) ON [PRIMARY]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_current_temp1' )
   DROP TABLE [dbo].[ghr_current_temp1]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_current_temp1](
	[Employee_Number] [char](15) NOT NULL,
	[First_Name] [char](25) NOT NULL,
	[Middle_Name] [char](25) NOT NULL,
	[Last_Name] [char](30) NOT NULL,
	[Employer] [char](10) NOT NULL,
	[National_Id_Type] [char](5) NOT NULL,
	[National_Id_Nbr] [char](20) NOT NULL,
	[Position Title] [char](50) NOT NULL,
	[rganization_Unit_name] [varchar](240) NOT NULL,
	[Annual_Salary] [money] NOT NULL,
	[Time_Reporting_Method] [char](1) NOT NULL,
	[Pay_Element_Ctrl_Group] [char](10) NOT NULL,
	[Pay_Group] [char](10) NOT NULL,
	[Pay_Status] [char](1) NOT NULL,
	[Pay_Through_Date] [datetime] NOT NULL,
	[Hire_Date] [datetime] NOT NULL,
	[Original Job_Position_Title] [char](80) NULL,
	[Employee Status] [char](1) NOT NULL
) ON [PRIMARY]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_message_temp_5' )
   DROP TABLE [dbo].[ghr_message_temp_5]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_message_temp_5](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[msg_id] [char](15) NOT NULL,
	[msg_p1] [char](15) NOT NULL,
	[msg_p2] [char](15) NOT NULL,
	[msg_desc] [char](255) NOT NULL
) ON [PRIMARY]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_employee_events_temp5' )
   DROP TABLE [dbo].[ghr_employee_events_temp5]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_employee_events_temp5](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[event_id_01] [char](2) NULL,
	[emp_id_01] [char](15) NULL,
	[eff_date_01] [char](10) NULL,
	[first_name_01] [char](25) NULL,
	[first_middle_name_01] [char](25) NULL,
	[last_name_01] [char](30) NULL,
	[empl_id_01] [char](10) NULL,
	[national_id_1_type_code_01] [char](5) NULL,
	[national_id_1_01] [char](20) NULL,
	[organization_group_id_01] [char](5) NULL,
	[organization_chart_name_01] [varchar](64) NULL,
	[organization_unit_name_01] [varchar](240) NULL,
	[emp_status_classn_code_01] [char](2) NULL,
	[position_title_01] [char](60) NULL,
	[employment_type_code_01] [char](5) NULL,
	[annual_salary_amt_01] [char](15) NULL,
	[begin_date_02] [char](10) NULL,
	[end_date_02] [char](10) NULL,
	[pay_status_code_03] [char](1) NULL,
	[pay_group_id_03] [char](10) NULL,
	[pay_element_ctrl_grp_id_03] [char](10) NULL,
	[time_reporting_meth_code_03] [char](1) NULL,
	[employment_info_chg_reason_cd_03] [char](5) NULL,
	[emp_location_code_03] [char](10) NULL,
	[emp_status_code_5] [char](2) NULL,
	[reason_code_5] [char](2) NULL,
	[emp_expected_return_date_5] [char](10) NULL,
	[pay_through_date_5] [char](10) NULL,
	[emp_death_date_5] [char](10) NULL,
	[consider_for_rehire_ind_5] [char](1) NULL,
	[pay_element_desc_06] [char](20) NULL,
	[emp_calculation_06] [char](15) NULL
) ON [PRIMARY]
GO


IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_email_report' )
   DROP TABLE [dbo].[ghr_email_report]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_email_report](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[event_id_01] [char](2) NULL,
	[emp_id_01] [char](15) NULL,
	[eff_date_01] [char](10) NULL,
	[pay_element_desc_06] [char](20) NULL,
	[first_name_01] [char](25) NULL,
	[last_name_01] [char](30) NULL,
	[empl_id_01] [char](10) NULL,
	[emp_status_code_5] [char](2) NULL,
	[emp_calculation_06] [char](15) NULL
) ON [PRIMARY]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_message_temp_4' )
   DROP TABLE [dbo].[ghr_message_temp_4]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_message_temp_4](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[msg_id] [char](15) NOT NULL,
	[msg_p1] [char](15) NOT NULL,
	[msg_p2] [char](15) NOT NULL,
	[msg_desc] [char](255) NOT NULL
) ON [PRIMARY]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_bankinfo_events_temp7' )
   DROP TABLE [dbo].[ghr_bankinfo_events_temp7]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_bankinfo_events_temp7](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[event_id_01] [char](2) NULL,
	[emp_id_01] [char](15) NULL,
	[eff_date_01] [char](10) NULL,
	[first_name_01] [char](25) NULL,
	[first_middle_name_01] [char](25) NULL,
	[last_name_01] [char](30) NULL,
	[empl_id_01] [char](10) NULL,
	[national_id_1_type_code_01] [char](5) NULL,
	[national_id_1_01] [char](20) NULL,
	[organization_group_id_01] [char](5) NULL,
	[organization_chart_name_01] [varchar](64) NULL,
	[organization_unit_name_01] [varchar](240) NULL,
	[emp_status_classn_code_01] [char](2) NULL,
	[position_title_01] [char](60) NULL,
	[employment_type_code_01] [char](5) NULL,
	[annual_salary_amt_01] [char](15) NULL,
	[begin_date_02] [char](10) NULL,
	[end_date_02] [char](10) NULL,
	[pay_status_code_03] [char](1) NULL,
	[pay_group_id_03] [char](10) NULL,
	[pay_element_ctrl_grp_id_03] [char](10) NULL,
	[time_reporting_meth_code_03] [char](1) NULL,
	[employment_info_chg_reason_cd_03] [char](5) NULL,
	[emp_location_code_03] [char](10) NULL,
	[emp_status_code_5] [char](2) NULL,
	[reason_code_5] [char](2) NULL,
	[emp_expected_return_date_5] [char](10) NULL,
	[pay_through_date_5] [char](10) NULL,
	[emp_death_date_5] [char](10) NULL,
	[consider_for_rehire_ind_5] [char](1) NULL,
	[pay_element_desc_06] [char](20) NULL,
	[emp_calculation_06] [char](15) NULL,
	[bank_id_07] [char](11) NULL,
	[direct_deposit_bank_acct_nbr_07] [char](17) NULL,
	[bank_acct_type_code_07] [char](1) NULL
) ON [PRIMARY]
GO


IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_message_temp_3' )
   DROP TABLE [dbo].[ghr_message_temp_3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_message_temp_3](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[msg_id] [char](15) NOT NULL,
	[msg_p1] [char](15) NOT NULL,
	[msg_p2] [char](15) NOT NULL,
	[msg_desc] [char](255) NOT NULL
) ON [PRIMARY]
GO


IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_employee_events_temp3' )
   DROP TABLE [dbo].[ghr_employee_events_temp3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_employee_events_temp3](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[event_id_01] [char](2) NULL,
	[emp_id_01] [char](15) NULL,
	[eff_date_01] [char](10) NULL,
	[first_name_01] [char](25) NULL,
	[first_middle_name_01] [char](25) NULL,
	[last_name_01] [char](30) NULL,
	[empl_id_01] [char](10) NULL,
	[national_id_1_type_code_01] [char](5) NULL,
	[national_id_1_01] [char](20) NULL,
	[organization_group_id_01] [char](5) NULL,
	[organization_chart_name_01] [varchar](64) NULL,
	[organization_unit_name_01] [varchar](240) NULL,
	[emp_status_classn_code_01] [char](2) NULL,
	[position_title_01] [char](60) NULL,
	[employment_type_code_01] [char](5) NULL,
	[annual_salary_amt_01] [char](15) NULL,
	[begin_date_02] [char](10) NULL,
	[end_date_02] [char](10) NULL,
	[pay_status_code_03] [char](1) NULL,
	[pay_group_id_03] [char](10) NULL,
	[pay_element_ctrl_grp_id_03] [char](10) NULL,
	[time_reporting_meth_code_03] [char](1) NULL,
	[employment_info_chg_reason_cd_03] [char](5) NULL,
	[emp_location_code_03] [char](10) NULL,
	[emp_status_code_5] [char](2) NULL,
	[reason_code_5] [char](2) NULL,
	[emp_expected_return_date_5] [char](10) NULL,
	[pay_through_date_5] [char](10) NULL,
	[emp_death_date_5] [char](10) NULL,
	[consider_for_rehire_ind_5] [char](1) NULL,
	[pay_element_desc_06] [char](20) NULL,
	[emp_calculation_06] [char](15) NULL
) ON [PRIMARY]
GO


IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_message_temp_2' )
   DROP TABLE [dbo].[ghr_message_temp_2]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_message_temp_2](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[msg_id] [char](15) NOT NULL,
	[msg_p1] [char](15) NOT NULL,
	[msg_p2] [char](15) NOT NULL,
	[msg_desc] [char](255) NOT NULL
) ON [PRIMARY]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_employee_events_temp2' )
   DROP TABLE [dbo].[ghr_employee_events_temp2]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_employee_events_temp2](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[event_id_01] [char](2) NULL,
	[emp_id_01] [char](15) NULL,
	[eff_date_01] [char](10) NULL,
	[first_name_01] [char](25) NULL,
	[first_middle_name_01] [char](25) NULL,
	[last_name_01] [char](30) NULL,
	[empl_id_01] [char](10) NULL,
	[national_id_1_type_code_01] [char](5) NULL,
	[national_id_1_01] [char](20) NULL,
	[organization_group_id_01] [char](5) NULL,
	[organization_chart_name_01] [varchar](64) NULL,
	[organization_unit_name_01] [varchar](240) NULL,
	[emp_status_classn_code_01] [char](2) NULL,
	[position_title_01] [char](60) NULL,
	[employment_type_code_01] [char](5) NULL,
	[annual_salary_amt_01] [char](15) NULL,
	[begin_date_02] [char](10) NULL,
	[end_date_02] [char](10) NULL,
	[pay_status_code_03] [char](1) NULL,
	[pay_group_id_03] [char](10) NULL,
	[pay_element_ctrl_grp_id_03] [char](10) NULL,
	[time_reporting_meth_code_03] [char](1) NULL,
	[employment_info_chg_reason_cd_03] [char](5) NULL,
	[emp_location_code_03] [char](10) NULL,
	[emp_status_code_5] [char](2) NULL,
	[reason_code_5] [char](2) NULL,
	[emp_expected_return_date_5] [char](10) NULL,
	[pay_through_date_5] [char](10) NULL,
	[emp_death_date_5] [char](10) NULL,
	[consider_for_rehire_ind_5] [char](1) NULL,
	[pay_element_desc_06] [char](20) NULL,
	[emp_calculation_06] [char](15) NULL
) ON [PRIMARY]
GO


IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_message_temp_1' )
   DROP TABLE [dbo].[ghr_message_temp_1]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_message_temp_1](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[msg_id] [char](15) NOT NULL,
	[msg_p1] [char](15) NOT NULL,
	[msg_p2] [char](15) NOT NULL,
	[msg_desc] [char](255) NOT NULL
) ON [PRIMARY]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_employee_events_temp1' )
   DROP TABLE [dbo].[ghr_employee_events_temp1]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_employee_events_temp1](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[event_id_01] [char](2) NULL,
	[emp_id_01] [char](15) NULL,
	[eff_date_01] [char](10) NULL,
	[first_name_01] [char](25) NULL,
	[first_middle_name_01] [char](25) NULL,
	[last_name_01] [char](30) NULL,
	[empl_id_01] [char](10) NULL,
	[national_id_1_type_code_01] [char](5) NULL,
	[national_id_1_01] [char](20) NULL,
	[organization_group_id_01] [char](5) NULL,
	[organization_chart_name_01] [varchar](64) NULL,
	[organization_unit_name_01] [varchar](240) NULL,
	[emp_status_classn_code_01] [char](2) NULL,
	[position_title_01] [char](60) NULL,
	[employment_type_code_01] [char](5) NULL,
	[annual_salary_amt_01] [char](15) NULL,
	[begin_date_02] [char](10) NULL,
	[end_date_02] [char](10) NULL,
	[pay_status_code_03] [char](1) NULL,
	[pay_group_id_03] [char](10) NULL,
	[pay_element_ctrl_grp_id_03] [char](10) NULL,
	[time_reporting_meth_code_03] [char](1) NULL,
	[employment_info_chg_reason_cd_03] [char](5) NULL,
	[emp_location_code_03] [char](10) NULL,
	[emp_status_code_5] [char](2) NULL,
	[reason_code_5] [char](2) NULL,
	[emp_expected_return_date_5] [char](10) NULL,
	[pay_through_date_5] [char](10) NULL,
	[emp_death_date_5] [char](10) NULL,
	[consider_for_rehire_ind_5] [char](1) NULL,
	[pay_element_desc_06] [char](20) NULL,
	[emp_calculation_06] [char](15) NULL
) ON [PRIMARY]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_bankinfo_events' )
   DROP TABLE [dbo].[ghr_bankinfo_events]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_bankinfo_events](
	[event_id_01] [varchar](2) NOT NULL,
	[emp_id_01] [char](15) NULL,
	[eff_date_01] [char](10) NULL,
	[first_name_01] [char](25) NULL,
	[first_middle_name_01] [char](25) NULL,
	[last_name_01] [char](30) NULL,
	[empl_id_01] [char](10) NULL,
	[national_id_1_type_code_01] [char](5) NULL,
	[national_id_1_01] [char](20) NULL,
	[organization_group_id_01] [char](5) NULL,
	[organization_chart_name_01] [varchar](64) NULL,
	[organization_unit_name_01] [varchar](240) NULL,
	[emp_status_classn_code_01] [char](2) NULL,
	[position_title_01] [char](60) NULL,
	[employment_type_code_01] [char](5) NULL,
	[annual_salary_amt_01] [char](15) NULL,
	[begin_date_02] [char](10) NULL,
	[end_date_02] [char](10) NULL,
	[pay_status_code_03] [char](1) NULL,
	[pay_group_id_03] [char](10) NULL,
	[pay_element_ctrl_grp_id_03] [char](10) NULL,
	[time_reporting_meth_code_03] [char](1) NULL,
	[employment_info_chg_reason_cd_03] [char](5) NULL,
	[emp_location_code_03] [char](10) NULL,
	[emp_status_code_5] [char](2) NULL,
	[reason_code_5] [char](2) NULL,
	[emp_expected_return_date_5] [char](10) NULL,
	[pay_through_date_5] [char](10) NULL,
	[emp_death_date_5] [char](10) NULL,
	[consider_for_rehire_ind_5] [char](1) NULL,
	[pay_element_desc_06] [char](20) NULL,
	[emp_calculation_06] [char](15) NULL,
	[bank_id_07] [char](11) NULL,
	[direct_deposit_bank_acct_nbr_07] [char](17) NULL,
	[bank_acct_type_code_07] [char](1) NULL
) ON [PRIMARY]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_bankinfo_events_aud' )
   DROP TABLE [dbo].[ghr_bankinfo_events_aud]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_bankinfo_events_aud](
	[event_id_01] [varchar](2) NOT NULL,
	[emp_id_01] [char](15) NULL,
	[eff_date_01] [char](10) NULL,
	[first_name_01] [char](25) NULL,
	[first_middle_name_01] [char](25) NULL,
	[last_name_01] [char](30) NULL,
	[empl_id_01] [char](10) NULL,
	[national_id_1_type_code_01] [char](5) NULL,
	[national_id_1_01] [char](20) NULL,
	[organization_group_id_01] [char](5) NULL,
	[organization_chart_name_01] [varchar](64) NULL,
	[organization_unit_name_01] [varchar](240) NULL,
	[emp_status_classn_code_01] [char](2) NULL,
	[position_title_01] [char](60) NULL,
	[employment_type_code_01] [char](5) NULL,
	[annual_salary_amt_01] [char](15) NULL,
	[begin_date_02] [char](10) NULL,
	[end_date_02] [char](10) NULL,
	[pay_status_code_03] [char](1) NULL,
	[pay_group_id_03] [char](10) NULL,
	[pay_element_ctrl_grp_id_03] [char](10) NULL,
	[time_reporting_meth_code_03] [char](1) NULL,
	[employment_info_chg_reason_cd_03] [char](5) NULL,
	[emp_location_code_03] [char](10) NULL,
	[emp_status_code_5] [char](2) NULL,
	[reason_code_5] [char](2) NULL,
	[emp_expected_return_date_5] [char](10) NULL,
	[pay_through_date_5] [char](10) NULL,
	[emp_death_date_5] [char](10) NULL,
	[consider_for_rehire_ind_5] [char](1) NULL,
	[pay_element_desc_06] [char](20) NULL,
	[emp_calculation_06] [char](15) NULL,
	[bank_id_07] [char](11) NULL,
	[direct_deposit_bank_acct_nbr_07] [char](17) NULL,
	[bank_acct_type_code_07] [char](1) NULL,
	[activity_date] [datetime] NULL,
	[activity_user] [varchar](30) NULL,
	[activity_status] [char](2) NULL
) ON [PRIMARY]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_bank_current_data' )
   DROP TABLE [dbo].[ghr_bank_current_data]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_bank_current_data](
	[emp_id] [char](15) NOT NULL,
	[pay_element_id] [char](10) NOT NULL,
	[bank_id] [char](11) NOT NULL,
	[direct_deposit_bank_acct_nbr] [char](17) NOT NULL,
	[bank_acct_type_code] [char](1) NOT NULL
) ON [PRIMARY]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_employee_events_aud' )
   DROP TABLE [dbo].[ghr_employee_events_aud]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_employee_events_aud](
	[event_id_01] [char](2) NULL,
	[emp_id_01] [char](15) NULL,
	[eff_date_01] [char](10) NULL,
	[first_name_01] [char](25) NULL,
	[first_middle_name_01] [char](25) NULL,
	[last_name_01] [char](30) NULL,
	[empl_id_01] [char](10) NULL,
	[national_id_1_type_code_01] [char](5) NULL,
	[national_id_1_01] [char](20) NULL,
	[organization_group_id_01] [char](5) NULL,
	[organization_chart_name_01] [varchar](64) NULL,
	[organization_unit_name_01] [varchar](240) NULL,
	[emp_status_classn_code_01] [char](2) NULL,
	[position_title_01] [char](60) NULL,
	[employment_type_code_01] [char](5) NULL,
	[annual_salary_amt_01] [char](15) NULL,
	[begin_date_02] [char](10) NULL,
	[end_date_02] [char](10) NULL,
	[pay_status_code_03] [char](1) NULL,
	[pay_group_id_03] [char](10) NULL,
	[pay_element_ctrl_grp_id_03] [char](10) NULL,
	[time_reporting_meth_code_03] [char](1) NULL,
	[employment_info_chg_reason_cd_03] [char](5) NULL,
	[emp_location_code_03] [char](10) NULL,
	[emp_status_code_5] [char](2) NULL,
	[reason_code_5] [char](2) NULL,
	[emp_expected_return_date_5] [char](10) NULL,
	[pay_through_date_5] [char](10) NULL,
	[emp_death_date_5] [char](10) NULL,
	[consider_for_rehire_ind_5] [char](1) NULL,
	[pay_element_desc_06] [char](20) NULL,
	[emp_calculation_06] [char](15) NULL,
	[activity_date] [datetime] NULL,
	[activity_user] [char](30) NULL,
	[activity_status] [char](2) NULL
) ON [PRIMARY]
GO

USE [DBShrpn]
GO

SET ANSI_PADDING ON
GO

CREATE UNIQUE CLUSTERED INDEX [employee_events_idx] ON [dbo].[ghr_employee_events_aud]
(
	[event_id_01] ASC,
	[emp_id_01] ASC,
	[eff_date_01] ASC,
	[emp_status_code_5] ASC,
	[pay_element_desc_06] ASC,
	[activity_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_employee_events' )
   DROP TABLE [dbo].[ghr_employee_events]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_employee_events](
	[event_id_01] [char](2) NULL,
	[emp_id_01] [char](15) NULL,
	[eff_date_01] [char](10) NULL,
	[first_name_01] [char](25) NULL,
	[first_middle_name_01] [char](25) NULL,
	[last_name_01] [char](30) NULL,
	[empl_id_01] [char](10) NULL,
	[national_id_1_type_code_01] [char](5) NULL,
	[national_id_1_01] [char](20) NULL,
	[organization_group_id_01] [char](5) NULL,
	[organization_chart_name_01] [varchar](64) NULL,
	[organization_unit_name_01] [varchar](240) NULL,
	[emp_status_classn_code_01] [char](2) NULL,
	[position_title_01] [char](60) NULL,
	[employment_type_code_01] [char](5) NULL,
	[annual_salary_amt_01] [char](15) NULL,
	[begin_date_02] [char](10) NULL,
	[end_date_02] [char](10) NULL,
	[pay_status_code_03] [char](1) NULL,
	[pay_group_id_03] [char](10) NULL,
	[pay_element_ctrl_grp_id_03] [char](10) NULL,
	[time_reporting_meth_code_03] [char](1) NULL,
	[employment_info_chg_reason_cd_03] [char](5) NULL,
	[emp_location_code_03] [char](10) NULL,
	[emp_status_code_5] [char](2) NULL,
	[reason_code_5] [char](2) NULL,
	[emp_expected_return_date_5] [char](10) NULL,
	[pay_through_date_5] [char](10) NULL,
	[emp_death_date_5] [char](10) NULL,
	[consider_for_rehire_ind_5] [char](1) NULL,
	[pay_element_desc_06] [char](20) NULL,
	[emp_calculation_06] [char](15) NULL
) ON [PRIMARY]
GO

USE [DBShrpn]
GO

SET ANSI_PADDING ON
GO

CREATE UNIQUE CLUSTERED INDEX [employee_events_idx] ON [dbo].[ghr_employee_events]
(
	[event_id_01] ASC,
	[emp_id_01] ASC,
	[eff_date_01] ASC,
	[emp_status_code_5] ASC,
	[pay_element_desc_06] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_rename_temp' )
   DROP TABLE [dbo].[ghr_rename_temp]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_rename_temp](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[new_emp_id_01] [char](15) NULL,
	[old_emp_id_01] [char](15) NULL
) ON [PRIMARY]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_msg_tbl' )
   DROP TABLE [dbo].[ghr_msg_tbl]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_msg_tbl](
	[msg_id] [char](15) NOT NULL,
	[msg_p1] [char](15) NOT NULL,
	[msg_p2] [char](15) NOT NULL,
	[msg_desc] [char](255) NOT NULL
) ON [PRIMARY]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_message_temp_6' )
   DROP TABLE [dbo].[ghr_message_temp_6]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_message_temp_6](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[msg_id] [char](15) NOT NULL,
	[msg_p1] [char](15) NOT NULL,
	[msg_p2] [char](15) NOT NULL,
	[msg_desc] [char](255) NOT NULL
) ON [PRIMARY]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_message_temp' )
   DROP TABLE [dbo].[ghr_message_temp]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_message_temp](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[msg_id] [char](15) NOT NULL,
	[msg_p1] [char](15) NOT NULL,
	[msg_p2] [char](15) NOT NULL,
	[msg_desc] [char](255) NOT NULL
) ON [PRIMARY]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_historical_message' )
   DROP TABLE [dbo].[ghr_historical_message]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_historical_message](
	[msg_id] [varchar](15) NOT NULL,
	[event_id] [varchar](2) NOT NULL,
	[emp_id] [varchar](15) NOT NULL,
	[eff_date] [varchar](10) NOT NULL,
	[pay_element_desc_06] [varchar](20) NOT NULL,
	[msg_p1] [varchar](15) NOT NULL,
	[msg_p2] [varchar](15) NOT NULL,
	[msg_desc] [varchar](255) NOT NULL,
	[activity_date] [datetime] NULL
) ON [PRIMARY]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_events' )
   DROP TABLE [dbo].[ghr_events]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_events](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[desc] [char](255) NULL,
	[status_flag] [char](1) NULL
) ON [PRIMARY]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_employee_events_temp6' )
   DROP TABLE [dbo].[ghr_employee_events_temp6]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_employee_events_temp6](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[event_id_01] [char](2) NULL,
	[emp_id_01] [char](15) NULL,
	[eff_date_01] [char](10) NULL,
	[first_name_01] [char](25) NULL,
	[first_middle_name_01] [char](25) NULL,
	[last_name_01] [char](30) NULL,
	[empl_id_01] [char](10) NULL,
	[national_id_1_type_code_01] [char](5) NULL,
	[national_id_1_01] [char](20) NULL,
	[organization_group_id_01] [char](5) NULL,
	[organization_chart_name_01] [varchar](64) NULL,
	[organization_unit_name_01] [varchar](240) NULL,
	[emp_status_classn_code_01] [char](2) NULL,
	[position_title_01] [char](60) NULL,
	[employment_type_code_01] [char](5) NULL,
	[annual_salary_amt_01] [char](15) NULL,
	[begin_date_02] [char](10) NULL,
	[end_date_02] [char](10) NULL,
	[pay_status_code_03] [char](1) NULL,
	[pay_group_id_03] [char](10) NULL,
	[pay_element_ctrl_grp_id_03] [char](10) NULL,
	[time_reporting_meth_code_03] [char](1) NULL,
	[employment_info_chg_reason_cd_03] [char](5) NULL,
	[emp_location_code_03] [char](10) NULL,
	[emp_status_code_5] [char](2) NULL,
	[reason_code_5] [char](2) NULL,
	[emp_expected_return_date_5] [char](10) NULL,
	[pay_through_date_5] [char](10) NULL,
	[emp_death_date_5] [char](10) NULL,
	[consider_for_rehire_ind_5] [char](1) NULL,
	[pay_element_desc_06] [char](20) NULL,
	[emp_calculation_06] [char](15) NULL
) ON [PRIMARY]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_employee_events_temp4' )
   DROP TABLE [dbo].[ghr_employee_events_temp4]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_employee_events_temp4](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[event_id_01] [char](2) NULL,
	[emp_id_01] [char](15) NULL,
	[eff_date_01] [char](10) NULL,
	[first_name_01] [char](25) NULL,
	[first_middle_name_01] [char](25) NULL,
	[last_name_01] [char](30) NULL,
	[empl_id_01] [char](10) NULL,
	[national_id_1_type_code_01] [char](5) NULL,
	[national_id_1_01] [char](20) NULL,
	[organization_group_id_01] [char](5) NULL,
	[organization_chart_name_01] [varchar](64) NULL,
	[organization_unit_name_01] [varchar](240) NULL,
	[emp_status_classn_code_01] [char](2) NULL,
	[position_title_01] [char](60) NULL,
	[employment_type_code_01] [char](5) NULL,
	[annual_salary_amt_01] [char](15) NULL,
	[begin_date_02] [char](10) NULL,
	[end_date_02] [char](10) NULL,
	[pay_status_code_03] [char](1) NULL,
	[pay_group_id_03] [char](10) NULL,
	[pay_element_ctrl_grp_id_03] [char](10) NULL,
	[time_reporting_meth_code_03] [char](1) NULL,
	[employment_info_chg_reason_cd_03] [char](5) NULL,
	[emp_location_code_03] [char](10) NULL,
	[emp_status_code_5] [char](2) NULL,
	[reason_code_5] [char](2) NULL,
	[emp_expected_return_date_5] [char](10) NULL,
	[pay_through_date_5] [char](10) NULL,
	[emp_death_date_5] [char](10) NULL,
	[consider_for_rehire_ind_5] [char](1) NULL,
	[pay_element_desc_06] [char](20) NULL,
	[emp_calculation_06] [char](15) NULL
) ON [PRIMARY]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_emp_pmt_sumn_temp' )
   DROP TABLE [dbo].[ghr_emp_pmt_sumn_temp]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_emp_pmt_sumn_temp](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[emp_id] [varchar](15) NOT NULL,
	[last_name] [varchar](25) NOT NULL,
	[first_name] [varchar](25) NOT NULL,
	[emp_name_ext] [varchar](100) NOT NULL,
	[emp_name] [varchar](45) NOT NULL,
	[payroll_run_type_id] [varchar](10) NOT NULL,
	[pay_pd_id] [varchar](10) NOT NULL,
	[pmt_seq_nbr] [int] NOT NULL,
	[deposit_check_code] [char](1) NOT NULL,
	[title] [varchar](80) NOT NULL,
	[empl_id] [varchar](10) NOT NULL,
	[empl_name] [varchar](45) NOT NULL,
	[empl_bank_id] [char](11) NOT NULL,
	[bank_name] [varchar](30) NOT NULL,
	[branch_name] [varchar](70) NOT NULL,
	[bank_nbr] [varchar](17) NOT NULL,
	[organization_unit_name] [varchar](20) NOT NULL,
	[org_unit_desc] [varchar](50) NOT NULL,
	[empl_bank_account] [char](10) NOT NULL,
	[check_nbr] [char](9) NOT NULL,
	[check_date] [datetime] NOT NULL,
	[pay_area] [varchar](4) NOT NULL,
	[pay_group_id] [varchar](10) NOT NULL,
	[pay_pd_begin_date] [datetime] NOT NULL,
	[pay_pd_end_date] [datetime] NOT NULL,
	[pmt_next_eff_date] [datetime] NOT NULL,
	[pmt_pay_grade_code] [varchar](6) NOT NULL,
	[pmt_check_amt] [money] NOT NULL,
	[pmt_annual_salary] [money] NOT NULL,
	[pmt_tot_salary_and_taxable] [money] NOT NULL,
	[pmt_tot_non_taxable] [money] NOT NULL,
	[pmt_tot_deductions_wh_amt] [money] NOT NULL,
	[pmt_net_pay_amt] [money] NOT NULL,
	[pmt_direct_deposits] [money] NOT NULL,
	[pmt_ytd_tot_gross_pay_amt] [money] NOT NULL,
	[pmt_ytd_tot_deductions_wh_amt] [money] NOT NULL,
	[pmt_ytd_net_pay_amt] [money] NOT NULL,
	[pmt_1st_tot_gross_pay_amt] [money] NOT NULL,
	[pmt_1st_taxable_pay_to_date] [money] NOT NULL,
	[pmt_1st_tax_deducted_to_date] [money] NOT NULL
) ON [PRIMARY]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_earnings_temp' )
   DROP TABLE [dbo].[ghr_earnings_temp]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_earnings_temp](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[HROrganization] [varchar](3) NOT NULL,
	[Employee] [varchar](15) NOT NULL,
	[CheckDate] [char](30) NULL,
	[CheckID] [char](9) NOT NULL,
	[CheckEarning] [varchar](1) NOT NULL,
	[earningsdescp] [varchar](35) NOT NULL,
	[Hours] [varchar](1) NOT NULL,
	[EarningsAmount] [char](10) NULL,
	[PayPeriodDateRangeBegin] [char](30) NULL,
	[PayPeriodDateRangeEnd] [char](30) NULL,
	[YearToDateEarningsAmount] [char](10) NULL,
	[YearToDateHours] [varchar](1) NOT NULL,
	[EffectiveDate] [char](30) NULL
) ON [PRIMARY]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_deduction_temp' )
   DROP TABLE [dbo].[ghr_deduction_temp]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_deduction_temp](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EffectiveDate] [char](30) NULL,
	[HROrganization] [varchar](3) NOT NULL,
	[Employee] [varchar](15) NOT NULL,
	[CheckDate] [char](30) NULL,
	[CheckID] [char](10) NOT NULL,
	[Deduction] [varchar](1) NOT NULL,
	[DeductionCode] [varchar](15) NOT NULL,
	[DeductionCodeDescription] [varchar](35) NOT NULL,
	[DeductionAmount] [char](10) NULL,
	[YearToDateDeductionAmount] [char](10) NULL
) ON [PRIMARY]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_current_temp4' )
   DROP TABLE [dbo].[ghr_current_temp4]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_current_temp4](
	[Employee_Number] [char](15) NOT NULL,
	[First_Name] [char](25) NOT NULL,
	[Middle_Name] [char](25) NOT NULL,
	[Last_Name] [char](30) NOT NULL,
	[Employer] [char](10) NOT NULL,
	[National_Id_Type] [char](5) NOT NULL,
	[National_Id_Nbr] [char](20) NOT NULL,
	[Position Title] [char](50) NOT NULL,
	[rganization_Unit_name] [varchar](240) NOT NULL,
	[Annual_Salary] [money] NOT NULL,
	[Time_Reporting_Method] [char](1) NOT NULL,
	[Pay_Element_Ctrl_Group] [char](10) NOT NULL,
	[Pay_Group] [char](10) NOT NULL,
	[Pay_Status] [char](1) NOT NULL,
	[Pay_Through_Date] [datetime] NOT NULL,
	[Hire_Date] [datetime] NOT NULL,
	[Original Job_Position_Title] [char](80) NULL,
	[Employee Status] [char](1) NOT NULL
) ON [PRIMARY]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'ghr_current_temp3' )
   DROP TABLE [dbo].[ghr_current_temp3]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ghr_current_temp3](
	[Employee_Number] [char](15) NOT NULL,
	[First_Name] [char](25) NOT NULL,
	[Middle_Name] [char](25) NOT NULL,
	[Last_Name] [char](30) NOT NULL,
	[Employer] [char](10) NOT NULL,
	[National_Id_Type] [char](5) NOT NULL,
	[National_Id_Nbr] [char](20) NOT NULL,
	[Position Title] [char](50) NOT NULL,
	[rganization_Unit_name] [varchar](240) NOT NULL,
	[Annual_Salary] [money] NOT NULL,
	[Time_Reporting_Method] [char](1) NOT NULL,
	[Pay_Element_Ctrl_Group] [char](10) NOT NULL,
	[Pay_Group] [char](10) NOT NULL,
	[Pay_Status] [char](1) NOT NULL,
	[Pay_Through_Date] [datetime] NOT NULL,
	[Hire_Date] [datetime] NOT NULL,
	[Original Job_Position_Title] [char](80) NULL,
	[Employee Status] [char](1) NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ghr_events] ADD  DEFAULT ('N') FOR [status_flag]
GO


