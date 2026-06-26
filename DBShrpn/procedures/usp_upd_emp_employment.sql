USE DBShrpn
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'dbo.usp_upd_emp_employment', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.usp_upd_emp_employment
    IF OBJECT_ID(N'dbo.usp_upd_emp_employment') IS NOT NULL
        PRINT N'<<< FAILED DROPPING PROCEDURE dbo.usp_upd_emp_employment >>>'
    ELSE
        PRINT N'<<< DROPPED PROCEDURE dbo.usp_upd_emp_employment >>>'
END
GO

/*************************************************************************************
    SP Name:       usp_upd_emp_employment

    Description:    Updates SmartStream table DBShrpn.dbo.emp_employment



    Parameters:
        @p_user_id             =  User ID (i.e. 'DBS')
        @p_activity_date       = Current System Date
        @p_emp_id              = Employee ID
        @p_eff_date            = Effective Date
        @p_cur_eempl_eff_date  = Current Employee Employment Effective Date
        @p_labor_grp_code      = Labor Group Code
        @p_pay_group_id        = Pay Group ID
        @p_eempl_audit_tbl_ind = Employee Employment Audit Table Indicator ('Y' or 'N')

    Example:
        EXEC DBShrpn.dbo.usp_upd_emp_employment
                      @p_user_id                    = 'DBS'
                    , @p_activity_date              = '2026-06-08 12:26:36.570'
                    , @p_emp_id                     = '14514'
                    , @p_eff_date                   = '2026-06-08'
                    , @p_cur_eempl_eff_date         = '2025-06-01'
                    , @p_labor_grp_code             = 'LBR01'
                    , @p_pay_group_id               = 'PAY01'
                    , @p_eempl_audit_tbl_ind        = 'Y'


   Revision history:
   version  date        developer   SCR         description
   -------  ----------  ---------   -----       ------------------------------------
   1.0.00   06/09/2025  CJP                     - Created procedure

************************************************************************************/

CREATE PROCEDURE dbo.usp_upd_emp_employment
    (
      @p_user_id                    char(10)
    , @p_activity_date              datetime
    , @p_emp_id                     char(15)
    , @p_eff_date                   datetime
    , @p_cur_eempl_eff_date         datetime
    , @p_labor_grp_code             char(5)
    , @p_pay_group_id               char(10)
    , @p_eempl_audit_tbl_ind        char(1)
    )
AS

BEGIN

    SET NOCOUNT ON

    DECLARE @v_step_position                varchar(255)        = 'Begin Procedure'

    DECLARE @v_END_OF_TIME_DATE             datetime            = '29991231'
    DECLARE @v_EMPTY_SPACE                  char(01)            = ''

    DECLARE @ErrorNumber                    varchar(10)
    DECLARE @ErrorMessage                   nvarchar(4000)
    DECLARE @ErrorSeverity                  int
    DECLARE @ErrorState                     int

    DECLARE @v_ret_val                      int                 = 0
    DECLARE @w_audit_tbl_ind                char(1)             = 'Y'             -- Flag to determine whether to audit employee emmployment table changes for labor group changes



    -- work table for emp employment insert
    CREATE TABLE #temp14
        (
          emp_id                            char(15)            NOT NULL
        , eff_date                          datetime            NOT NULL
        , next_eff_date                     datetime            NOT NULL
        , prior_eff_date                    datetime            NOT NULL
        , employment_type_code              char(5)             NOT NULL
        , work_tm_code                      char(1)             NOT NULL
        , official_title_code               char(5)             NOT NULL
        , official_title_date               datetime            NOT NULL
        , mgr_ind                           char(1)             NOT NULL
        , recruiter_ind                     char(1)             NOT NULL
        , pensioner_indicator               char(1)             NOT NULL
        , payroll_company_code              char(5)             NOT NULL
        , pmt_ctrl_code                     char(5)             NOT NULL
        , us_federal_tax_meth_code          char(1)             NOT NULL
        , us_federal_tax_amt                money               NOT NULL
        , us_federal_tax_pct                money               NOT NULL
        , us_federal_marital_status_code    char(1)             NOT NULL
        , us_federal_exemp_nbr              tinyint             NOT NULL
        , us_work_st_code                   char(2)             NOT NULL
        , canadian_work_province_code       char(2)             NOT NULL
        , ipp_payroll_id                    char(5)             NOT NULL
        , ipp_max_pay_level_amt             money               NOT NULL
        , pay_through_date                  datetime            NOT NULL
        , empl_id                           char(10)            NOT NULL
        , tax_entity_id                     char(10)            NOT NULL
        , pay_status_code                   char(1)             NOT NULL
        , clock_nbr                         char(10)            NOT NULL
        , provided_i_9_ind                  char(1)             NOT NULL
        , time_reporting_meth_code          char(1)             NOT NULL
        , regular_hrs_tracked_code          char(1)             NOT NULL
        , pay_element_ctrl_grp_id           char(10)            NOT NULL
        , pay_group_id                      char(10)            NOT NULL
        , us_pension_ind                    char(1)             NOT NULL
        , professional_cat_code             char(5)             NOT NULL
        , corporate_officer_ind             char(1)             NOT NULL
        , prim_disbursal_loc_code           char(10)            NOT NULL
        , alternate_disbursal_loc_code      char(10)            NOT NULL
        , labor_grp_code                    char(5)             NOT NULL
        , employment_info_chg_reason_cd     char(5)             NOT NULL
        , highly_compensated_emp_ind        char(1)             NOT NULL
        , nbr_of_dependent_children         tinyint             NOT NULL
        , canadian_federal_tax_meth_cd      char(1)             NOT NULL
        , canadian_federal_tax_amt          money               NOT NULL
        , canadian_federal_tax_pct          money               NOT NULL
        , canadian_federal_claim_amt        money               NOT NULL
        , canadian_province_claim_amt       money               NOT NULL
        , tax_unit_code                     char(5)             NOT NULL
        , requires_tm_card_ind              char(1)             NOT NULL
        , xfer_type_code                    char(1)             NOT NULL
        , tax_clear_code                    char(1)             NOT NULL
        , pay_type_code                     char(1)             NOT NULL
        , labor_distn_code                  char(14)            NOT NULL
        , labor_distn_ext_code              char(30)            NOT NULL
        , us_fui_status_code                char(1)             NOT NULL
        , us_fica_status_code               char(1)             NOT NULL
        , payable_through_bank_id           char(11)            NOT NULL
        , disbursal_seq_nbr_1               char(30)            NOT NULL
        , disbursal_seq_nbr_2               char(30)            NOT NULL
        , non_employee_indicator            char(1)             NOT NULL
        , excluded_from_payroll_ind         char(1)             NOT NULL
        , emp_info_source_code              char(1)             NOT NULL
        , user_amt_1                        float               NOT NULL
        , user_amt_2                        float               NOT NULL
        , user_monetary_amt_1               money               NOT NULL
        , user_monetary_amt_2               money               NOT NULL
        , user_monetary_curr_code           char(3)             NOT NULL
        , user_code_1                       char(5)             NOT NULL
        , user_code_2                       char(5)             NOT NULL
        , user_date_1                       datetime            NOT NULL
        , user_date_2                       datetime            NOT NULL
        , user_ind_1                        char(1)             NOT NULL
        , user_ind_2                        char(1)             NOT NULL
        , user_text_1                       char(50)            NOT NULL
        , user_text_2                       char(50)            NOT NULL
        , t4_employ_code                    char(2)             NOT NULL
        , chgstamp                          smallint            NOT NULL
        )


    BEGIN TRY

        -- If pay group change event in current transaction then update current emp employment record
        IF (@p_eff_date = @p_cur_eempl_eff_date)
            BEGIN

                -- Update existing record
                UPDATE DBShrpn.dbo.emp_employment
                SET labor_grp_code = @p_labor_grp_code
                WHERE (emp_id = @p_emp_id)
                    AND (eff_date = @p_eff_date)


                ---------------------------------------------------------------------------
                -- Add record to employment audit table
                ---------------------------------------------------------------------------
                IF (@p_eempl_audit_tbl_ind = 'Y')
                    BEGIN

                        INSERT INTO work_emp_employment_aud
                            (
                            user_id
                            , activity_action_code
                            , action_date
                            , emp_id
                            , eff_date
                            , next_eff_date
                            , prior_eff_date
                            , new_eff_date
                            , new_empl_id
                            , new_tax_entity_id
                            , xfer_date
                            , pay_through_date
                            )
                        VALUES
                            (
                                @p_user_id                    -- user_id
                            , 'CHGEMPEQ'                    -- activity_action_code
                            , @p_activity_date              -- action_date
                            , @p_emp_id                     -- emp_id
                            , @p_eff_date                   -- eff_date
                            , @v_END_OF_TIME_DATE           -- next_eff_date
                            , @v_END_OF_TIME_DATE           -- prior_eff_date
                            , @v_END_OF_TIME_DATE           -- new_eff_date
                            , @v_EMPTY_SPACE                -- new_empl_id
                            , @v_EMPTY_SPACE                -- new_tax_entity_id
                            , @v_END_OF_TIME_DATE           -- xfer_date
                            , @v_END_OF_TIME_DATE           -- pay_through_date
                            )

                        DELETE work_emp_employment_aud
                        WHERE (user_id              = @p_user_id)
                        AND (activity_action_code = 'CHGEMPEQ')
                        AND (emp_id               = @p_emp_id)

                    END

            END
        ELSE -- Create new record
            BEGIN

                ---------------------------------------------------------------------------
                -- Update Employee Employment with new Pay Group and Labor Group
                ---------------------------------------------------------------------------

                -- Update current record date pointers
                UPDATE DBShrpn.dbo.emp_employment
                SET next_eff_date = @p_eff_date
                WHERE (emp_id   = @p_emp_id)
                    AND (eff_date = @p_cur_eempl_eff_date)


                -- Create new record
                INSERT INTO #temp14
                SELECT emp_id
                    , @p_eff_date                      -- eff_date
                    , @v_END_OF_TIME_DATE              -- next_eff_date
                    , @p_cur_eempl_eff_date              -- prior_eff_date
                    , employment_type_code
                    , work_tm_code
                    , official_title_code
                    , official_title_date
                    , mgr_ind
                    , recruiter_ind
                    , pensioner_indicator
                    , payroll_company_code
                    , pmt_ctrl_code
                    , us_federal_tax_meth_code
                    , us_federal_tax_amt
                    , us_federal_tax_pct
                    , us_federal_marital_status_code
                    , us_federal_exemp_nbr
                    , us_work_st_code
                    , canadian_work_province_code
                    , ipp_payroll_id
                    , ipp_max_pay_level_amt
                    , pay_through_date
                    , empl_id
                    , tax_entity_id
                    , pay_status_code
                    , clock_nbr
                    , provided_i_9_ind
                    , time_reporting_meth_code
                    , regular_hrs_tracked_code
                    , pay_element_ctrl_grp_id
                    ---------------------------------------------------------------------------
                    , @p_pay_group_id                  -- pay_group_id
                    ---------------------------------------------------------------------------
                    , us_pension_ind
                    , professional_cat_code
                    , corporate_officer_ind
                    , prim_disbursal_loc_code
                    , alternate_disbursal_loc_code
                    ---------------------------------------------------------------------------
                    , @p_labor_grp_code                  -- labor_grp_code
                    ---------------------------------------------------------------------------
                    , employment_info_chg_reason_cd
                    , highly_compensated_emp_ind
                    , nbr_of_dependent_children
                    , canadian_federal_tax_meth_cd
                    , canadian_federal_tax_amt
                    , canadian_federal_tax_pct
                    , canadian_federal_claim_amt
                    , canadian_province_claim_amt
                    , tax_unit_code
                    , requires_tm_card_ind
                    , xfer_type_code
                    , tax_clear_code
                    , pay_type_code
                    , labor_distn_code
                    , labor_distn_ext_code
                    , us_fui_status_code
                    , us_fica_status_code
                    , payable_through_bank_id
                    , disbursal_seq_nbr_1
                    , disbursal_seq_nbr_2
                    , non_employee_indicator
                    , excluded_from_payroll_ind
                    , emp_info_source_code
                    , user_amt_1
                    , user_amt_2
                    , user_monetary_amt_1
                    , user_monetary_amt_2
                    , user_monetary_curr_code
                    , user_code_1
                    , user_code_2
                    , user_date_1
                    , user_date_2
                    , user_ind_1
                    , user_ind_2
                    , user_text_1
                    , user_text_2
                    , t4_employ_code
                    , chgstamp
                FROM DBShrpn.dbo.emp_employment
                WHERE (emp_id   = @p_emp_id)
                AND (eff_date = @p_cur_eempl_eff_date)


                INSERT INTO emp_employment
                SELECT emp_id
                    , eff_date
                    , next_eff_date
                    , prior_eff_date
                    , employment_type_code
                    , work_tm_code
                    , official_title_code
                    , official_title_date
                    , mgr_ind
                    , recruiter_ind
                    , pensioner_indicator
                    , payroll_company_code
                    , pmt_ctrl_code
                    , us_federal_tax_meth_code
                    , us_federal_tax_amt
                    , us_federal_tax_pct
                    , us_federal_marital_status_code
                    , us_federal_exemp_nbr
                    , us_work_st_code
                    , canadian_work_province_code
                    , ipp_payroll_id
                    , ipp_max_pay_level_amt
                    , pay_through_date
                    , empl_id
                    , tax_entity_id
                    , pay_status_code
                    , clock_nbr
                    , provided_i_9_ind
                    , time_reporting_meth_code
                    , regular_hrs_tracked_code
                    , pay_element_ctrl_grp_id
                    ---------------------------------------------------------------------------
                    , pay_group_id
                    ---------------------------------------------------------------------------
                    , us_pension_ind
                    , professional_cat_code
                    , corporate_officer_ind
                    , prim_disbursal_loc_code
                    , alternate_disbursal_loc_code
                    ---------------------------------------------------------------------------
                    , labor_grp_code
                    ---------------------------------------------------------------------------
                    , employment_info_chg_reason_cd
                    , highly_compensated_emp_ind
                    , nbr_of_dependent_children
                    , canadian_federal_tax_meth_cd
                    , canadian_federal_tax_amt
                    , canadian_federal_tax_pct
                    , canadian_federal_claim_amt
                    , canadian_province_claim_amt
                    , tax_unit_code
                    , requires_tm_card_ind
                    , xfer_type_code
                    , tax_clear_code
                    , pay_type_code
                    , labor_distn_code
                    , labor_distn_ext_code
                    , us_fui_status_code
                    , us_fica_status_code
                    , payable_through_bank_id
                    , disbursal_seq_nbr_1
                    , disbursal_seq_nbr_2
                    , non_employee_indicator
                    , excluded_from_payroll_ind
                    , emp_info_source_code
                    , user_amt_1
                    , user_amt_2
                    , user_monetary_amt_1
                    , user_monetary_amt_2
                    , user_monetary_curr_code
                    , user_code_1
                    , user_code_2
                    , user_date_1
                    , user_date_2
                    , user_ind_1
                    , user_ind_2
                    , user_text_1
                    , user_text_2
                    , t4_employ_code
                    , chgstamp
                FROM #temp14 t14
                WHERE NOT EXISTS (
                                SELECT 1
                                FROM DBShrpn.dbo.emp_employment t2
                                WHERE (t2.emp_id   = t14.emp_id)
                                    AND (t2.eff_date = @p_eff_date)
                                )



                ---------------------------------------------------------------------------
                -- Add record to employment audit table
                ---------------------------------------------------------------------------
                IF (@p_eempl_audit_tbl_ind = 'Y')
                    BEGIN

                        INSERT INTO work_emp_employment_aud
                            (
                            user_id
                            , activity_action_code
                            , action_date
                            , emp_id
                            , eff_date
                            , next_eff_date
                            , prior_eff_date
                            , new_eff_date
                            , new_empl_id
                            , new_tax_entity_id
                            , xfer_date
                            , pay_through_date
                            )
                        VALUES
                            (
                                @p_user_id                -- user_id
                            , 'CHGEMPNE'                -- activity_action_code
                            , @p_activity_date          -- action_date
                            , @p_emp_id                 -- emp_id
                            , @p_cur_eempl_eff_date       -- eff_date
                            , @v_END_OF_TIME_DATE       -- next_eff_date
                            , @v_END_OF_TIME_DATE       -- prior_eff_date
                            , @p_eff_date               -- new_eff_date
                            , @v_EMPTY_SPACE            -- new_empl_id
                            , @v_EMPTY_SPACE            -- new_tax_entity_id
                            , @v_END_OF_TIME_DATE       -- xfer_date
                            , @v_END_OF_TIME_DATE       -- pay_through_date
                            )


                        DELETE work_emp_employment_aud
                        WHERE (user_id              = @p_user_id)
                            AND (activity_action_code = 'CHGEMPNE')
                            AND (emp_id               = @p_emp_id)

                    END

        END
    END TRY
    BEGIN CATCH

        SELECT
              @ErrorNumber   = ERROR_NUMBER()
            , @ErrorMessage  = ERROR_MESSAGE()
            , @ErrorSeverity = ERROR_SEVERITY()
            , @ErrorState    = ERROR_STATE()

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)

        SET @v_ret_val = -1

    END CATCH

    -- Cleanup temp table
    DROP TABLE #temp14


    RETURN @v_ret_val

END
GO

ALTER AUTHORIZATION ON dbo.usp_upd_emp_employment TO  SCHEMA OWNER
GO

IF OBJECT_ID(N'dbo.usp_upd_emp_employment', N'P') IS NOT NULL
    PRINT N'<<< CREATED PROCEDURE dbo.usp_upd_emp_employment >>>'
ELSE
    PRINT N'<<< FAILED CREATING PROCEDURE dbo.usp_upd_emp_employment >>>'
GO