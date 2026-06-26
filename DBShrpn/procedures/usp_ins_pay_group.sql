USE DBShrpn
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID(N'dbo.usp_ins_pay_group', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.usp_ins_pay_group
    IF OBJECT_ID(N'dbo.usp_ins_pay_group') IS NOT NULL
        PRINT N'<<< FAILED DROPPING PROCEDURE dbo.usp_ins_pay_group >>>'
    ELSE
        PRINT N'<<< DROPPED PROCEDURE dbo.usp_ins_pay_group >>>'
END
GO

/*************************************************************************************
    SP Name:       usp_ins_pay_group

    Description:    Populates pay group on Employee Employment by creating a new effective dated record.

                    Table: DBShrpn.dbo.emp_employment

                    Field: pay_group_id


    Parameters:
        @p_user_id       =  User ID (i.e. 'DBS')
        @p_batchname     = Job Scheduler Batch Name (i.e. 'GHR')
        @p_qualifier     = Job Scheduler Qualifier (i.e. 'INTERFACES')
        @p_activity_date = Current System Date


    Example:
        EXEC DBShrpn.dbo.usp_ins_pay_group
              @p_user_id          = @w_userid
            , @p_batchname       = @v_PSC_BATCHNAME
            , @p_qualifier       = @w_PSC_QUALIFIER
            , @p_activity_date   = @w_activity_date


   Revision history:
   version  date        developer   SCR         description
   -------  ----------  ---------   -----       ------------------------------------
   1.0.00   08/27/2025  CJP                     - Cloned from GOG version
   1.0.01   05/18/2026  CJP                     - Commit Error
                                                    1) Fixed emp_employment update
                                                        - Changed where clause to use current emp_ployment effective date instead of new effective date
                                                    2) Added SmartStream audit table inserts for pay group change
            06/10/2026                              3) Added procedure usp_upd_emp_employment call to update SmartStream Employee Employment table

************************************************************************************/

CREATE PROCEDURE dbo.usp_ins_pay_group
    (
      @p_user_id                    varchar(30)
    , @p_batchname                  varchar(08)
    , @p_qualifier                  varchar(30)
    , @p_activity_date              datetime
    , @p_eempl_audit_tbl_ind        char(1)     -- Flag to determine whether to populate SmartStream audit table for employee employment table changes
    )
AS

BEGIN

    SET NOCOUNT ON

    DECLARE @v_step_position                varchar(255)        = 'Begin Procedure'

    DECLARE @v_END_OF_TIME_DATE             datetime            = '29991231'
    DECLARE @v_BAD_DATE_INDICATOR           datetime            = '99991231'    -- value used to populate datetime column with value from HCM that is not a valid date after conversion
    DECLARE @v_EMPTY_SPACE                  char(01)            = 'x'

    DECLARE @v_EVENT_ID_NEW_HIRE            char(2)             = '01'
    DECLARE @v_EVENT_ID_SALARY_CHANGE       char(2)             = '02'
    DECLARE @v_EVENT_ID_TRANSFER            char(2)             = '03'
    DECLARE @v_EVENT_ID_NAME_CHANGE         char(2)             = '04'
    DECLARE @v_EVENT_ID_STATUS_CHANGE       char(2)             = '05'
    DECLARE @v_EVENT_ID_PAY_ELE             char(2)             = '06'
    DECLARE @v_EVENT_ID_PAY_GROUP           char(2)             = '08'
    DECLARE @v_EVENT_ID_LABOR_GROUP         char(2)             = '09'
    DECLARE @v_EVENT_ID_POSITION_TITLE      char(2)             = '10'

    DECLARE @v_ACTIVITY_STATUS_GOOD         char(2)             = '00'
    DECLARE @v_ACTIVITY_STATUS_WARNING      char(2)             = '01'
    DECLARE @v_ACTIVITY_STATUS_BAD          char(2)             = '02'

    DECLARE @ErrorNumber                    varchar(10)
    DECLARE @ErrorMessage                   nvarchar(4000)
    DECLARE @ErrorSeverity                  int
    DECLARE @ErrorState                     int

    DECLARE @v_ret_val                      int = 0

    DECLARE @w_msg_text                     varchar(255)
    DECLARE @w_msg_text_2                   varchar(255)
    DECLARE @w_msg_text_3                   varchar(255)
    DECLARE @w_severity_cd                  tinyint
    DECLARE @w_fatal_error                  bit     = 0         --char(01)

    DECLARE @individual_id                  char(10)
    DECLARE @prior_last_name                char(30)

    DECLARE @maxx                           char(06)
    DECLARE @msg_id                         char(10)

    DECLARE @cur_empl_id                    char(10)
    DECLARE @cur_eempl_eff_date             datetime
    --DECLARE @cur_tax_entity_id              char(10)
    DECLARE @cur_pay_group_id               char(10)
    DECLARE @cur_stat_emp_status_code       char(01)
    --DECLARE @w_eff_date                     datetime

    -- This section declares the interface values from Global HR
    DECLARE @aud_id                         int             = 0
    DECLARE @emp_id                         char(15)        = 'x'
    DECLARE @eff_date                       datetime
    DECLARE @empl_id                        char(10)
    DECLARE @pay_group_id                   char(10)
    DECLARE @cur_labor_grp_code             char(05)
    DECLARE @file_source                    char(50)        -- 'SS VENUS' or 'SS GANYMEDE'
    DECLARE @w_status			            int


    CREATE TABLE #tbl_ghr_msg
        (
          msg_id                            char(15)            NOT NULL
        , msg_desc                          varchar(255)        NOT NULL
        )


    BEGIN TRY


        ---------------------------------------------------------------------------
        -- Loop through ghr_employee_events_temp to populate error message log entry
        ---------------------------------------------------------------------------
        SET @v_step_position = 'Declaring cursor crsrHR'

        DECLARE crsrHR CURSOR FAST_FORWARD FOR
        SELECT t.aud_id
             , t.emp_id
             , t.eff_date
             , t.empl_id
             , t.pay_group_id
             , t.file_source
        FROM #ghr_employee_events_temp t
        WHERE (event_id = @v_EVENT_ID_PAY_GROUP)

        SET @v_step_position = 'Opening cursor crsrHR'
        OPEN crsrHR

        SET @v_step_position = 'Fetching cursor crsrHR'
        FETCH crsrHR
        INTO  @aud_id
            , @emp_id
            , @eff_date
            , @empl_id
            , @pay_group_id
            , @file_source


        WHILE (@@FETCH_STATUS = 0)
        BEGIN

            BEGIN TRY

                SET @v_step_position = 'Begin crsrHR While Loop'

                SET @w_fatal_error = 0

                BEGIN TRAN

                ---------------------------------------------------------------------------
                ---------------------------------------------------------------------------
                --   This section will validate the interface data
                ---------------------------------------------------------------------------
                ---------------------------------------------------------------------------
                SET @v_step_position = 'Begin Validation'



                --Skip Record if associate also has New Hire, Transfer, Status Change
                IF EXISTS (
                            SELECT 1
                            FROM #ghr_employee_events_temp
                            WHERE (emp_id = @emp_id)
                            AND (event_id IN (
                                                @v_EVENT_ID_NEW_HIRE
                                             , @v_EVENT_ID_TRANSFER
                                            ))
                            UNION ALL
                            SELECT 1
                            FROM #ghr_employee_events_temp
                            WHERE (emp_id = @emp_id)
                            AND (event_id = @v_EVENT_ID_STATUS_CHANGE)
                            AND (emp_status_code = 'RH')
                          )
                BEGIN

                    SET @msg_id = 'U00119'  -- New code
                    SET @v_step_position = RTRIM(@msg_id) + 'Employee extract contains new hire, transfer, or rehire status change event records.'

                    INSERT INTO #tbl_ghr_msg
                    SELECT @msg_id      AS msg_id
                        , REPLACE(REPLACE(t.msg_text, '@1', 'pay group'), '@2', @emp_id) AS msg_desc
                    FROM DBSCOMMON.dbo.message_master t
                    WHERE (t.msg_id = @msg_id)

                    -- Historical Message for reporting purpose
                    EXEC DBShrpn.dbo.usp_ins_ghr_historical_message
                        @p_msg_id             = @msg_id
                        , @p_event_id           = @v_EVENT_ID_PAY_GROUP
                        , @p_emp_id             = @emp_id
                        , @p_eff_date           = @eff_date
                        , @p_pay_element_id     = @v_EMPTY_SPACE
                        , @p_msg_p1             = @v_EMPTY_SPACE
                        , @p_msg_p2             = @v_EMPTY_SPACE
                        , @p_msg_desc           = 'Bypassing pay group change due to the presence of either a new hire, transfer, or rehire status change event in this extract. The update would have been processed in one of those events.'
                        , @p_activity_status    = @v_ACTIVITY_STATUS_WARNING
                        , @p_activity_date      = @p_activity_date
                        , @p_audit_id           = @aud_id

                    -- Skip record and al other validations
                    -- since pay group will be processed in the other events
                    GOTO BYPASS_EMPLOYEE

                END


                ---------------------------------------------------------------------------
                -- Validate Effective Date
                ---------------------------------------------------------------------------
                -- Invalid date value from HCM, '@1', for employee, @2, and event id, @3.

                -- Effective Date
                IF (@eff_date = @v_BAD_DATE_INDICATOR)
                    BEGIN

                        SET @msg_id = 'U00102'  -- New code
                        SET @v_step_position = 'Validation Effective Date - ' + RTRIM(@msg_id)

                        INSERT INTO #tbl_ghr_msg
                        SELECT @msg_id AS msg_id
                            , REPLACE(REPLACE(REPLACE(t.msg_text, '@1', @eff_date), '@2', @emp_id), '@3', @v_EVENT_ID_PAY_GROUP) AS msg_desc
                        FROM DBSCOMMON.dbo.message_master t
                        WHERE (t.msg_id = @msg_id)

                        -- Historical Message for reporting purpose
                        EXEC DBShrpn.dbo.usp_ins_ghr_historical_message
                            @p_msg_id             = @msg_id
                            , @p_event_id           = @v_EVENT_ID_PAY_GROUP
                            , @p_emp_id             = @emp_id
                            , @p_eff_date           = @eff_date
                            , @p_pay_element_id     = @v_EMPTY_SPACE
                            , @p_msg_p1             = @v_EMPTY_SPACE
                            , @p_msg_p2             = @v_EMPTY_SPACE
                            , @p_msg_desc           = 'Invalid Effective Date'
                            , @p_activity_status    = @v_ACTIVITY_STATUS_BAD
                            , @p_activity_date      = @p_activity_date
                            , @p_audit_id           = @aud_id

                        SET @w_fatal_error = 1

                    END


                ---------------------------------------------------------------------------
                -- Check to see if the employee exists
                ---------------------------------------------------------------------------
                SET @msg_id = 'U00012'
                SET @v_step_position = 'Begin ' + RTRIM(@msg_id)

                SELECT @cur_eempl_eff_date           = eempl.eff_date
                    , @cur_pay_group_id             = eempl.pay_group_id
                    , @cur_labor_grp_code             = eempl.labor_grp_code
                    , @cur_stat_emp_status_code     = stat.emp_status_code
                FROM DBShrpn.dbo.employee emp
                JOIN DBShrpn.dbo.uvu_emp_employment_most_rec eempl ON
                    (emp.emp_id = eempl.emp_id)
                JOIN DBShrpn.dbo.uvu_emp_status_most_rec stat ON
                    (emp.emp_id = stat.emp_id)
                WHERE (emp.emp_id = @emp_id)

                IF (@@ROWCOUNT = 0)
                    BEGIN

                        INSERT INTO #tbl_ghr_msg
                        SELECT @msg_id As msg_id
                            , REPLACE(t.msg_text, '@1', @emp_id) AS msg_desc
                        FROM DBSCOMMON.dbo.message_master t
                        WHERE (t.msg_id = @msg_id)


                        -- Historical Message for reporting purpose
                        EXEC DBShrpn.dbo.usp_ins_ghr_historical_message
                              @p_msg_id             = @msg_id
                            , @p_event_id           = @v_EVENT_ID_PAY_GROUP
                            , @p_emp_id             = @emp_id
                            , @p_eff_date           = @eff_date
                            , @p_pay_element_id     = @v_EMPTY_SPACE
                            , @p_msg_p1             = @v_EMPTY_SPACE
                            , @p_msg_p2             = @v_EMPTY_SPACE
                            , @p_msg_desc           = 'Invalid employee id.'
                            , @p_activity_status    = @v_ACTIVITY_STATUS_BAD
                            , @p_activity_date      = @p_activity_date
                            , @p_audit_id           = @aud_id

                        SET @w_fatal_error = 1

                    END


                ---------------------------------------------------------------------------
                -- Is Associate Terminated in SmartStream
                ---------------------------------------------------------------------------
                SET @msg_id = 'U00120'
                SET @v_step_position = 'Begin ' + RTRIM(@msg_id)

                IF (@cur_stat_emp_status_code = 'T')
                    BEGIN

                        INSERT INTO #tbl_ghr_msg
                        SELECT @msg_id As msg_id
                            , REPLACE(REPLACE(t.msg_text, '@1', 'pay group'), '@2', @emp_id) AS msg_desc
                        FROM DBSCOMMON.dbo.message_master t
                        WHERE (t.msg_id = @msg_id)


                        -- Historical Message for reporting purpose
                        EXEC DBShrpn.dbo.usp_ins_ghr_historical_message
                            @p_msg_id             = @msg_id
                            , @p_event_id           = @v_EVENT_ID_POSITION_TITLE
                            , @p_emp_id             = @emp_id
                            , @p_eff_date           = @eff_date
                            , @p_pay_element_id     = @v_EMPTY_SPACE
                            , @p_msg_p1             = @pay_group_id
                            , @p_msg_p2             = @v_EMPTY_SPACE
                            , @p_msg_desc           = 'Employee is terminated in SmartStream - bypassing record.'
                            , @p_activity_status    = @v_ACTIVITY_STATUS_BAD
                            , @p_activity_date      = @p_activity_date
                            , @p_audit_id           = @aud_id


                        SET @w_fatal_error = 1

                    END


                ---------------------------------------------------------------------------
                -- Is new pay group same as old pay group?
                ---------------------------------------------------------------------------
                SET @msg_id = 'U00106'
                SET @v_step_position = 'Begin ' + RTRIM(@msg_id)

                IF (@pay_group_id = @cur_pay_group_id)
                    BEGIN

                        INSERT INTO #tbl_ghr_msg
                        SELECT @msg_id As msg_id
                            , REPLACE(REPLACE(t.msg_text, '@1', @pay_group_id), '@2', @emp_id) AS msg_desc
                        FROM DBSCOMMON.dbo.message_master t
                        WHERE (t.msg_id = @msg_id)


                        -- Historical Message for reporting purpose
                        EXEC DBShrpn.dbo.usp_ins_ghr_historical_message
                            @p_msg_id             = @msg_id
                            , @p_event_id           = @v_EVENT_ID_PAY_GROUP
                            , @p_emp_id             = @emp_id
                            , @p_eff_date           = @eff_date
                            , @p_pay_element_id     = @v_EMPTY_SPACE
                            , @p_msg_p1             = @pay_group_id
                            , @p_msg_p2             = @cur_pay_group_id
                            , @p_msg_desc           = 'New pay group is same as current pay group - bypassing record.'
                            , @p_activity_status    = @v_ACTIVITY_STATUS_BAD
                            , @p_activity_date      = @p_activity_date
                            , @p_audit_id           = @aud_id

                        SET @w_fatal_error = 1

                    END


                ---------------------------------------------------------------------------
                -- Check to see if new pay group id exists
                ---------------------------------------------------------------------------
                SET @msg_id = 'U00020'
                SET @v_step_position = 'Begin ' + RTRIM(@msg_id)

                IF NOT EXISTS(
                            SELECT 1
                            FROM DBShrpn.dbo.pay_group
                            WHERE (pay_group_id = @pay_group_id)
                            )
                    BEGIN

                        INSERT INTO #tbl_ghr_msg
                        SELECT @msg_id As msg_id
                            , REPLACE(REPLACE(t.msg_text, '@1', @pay_group_id), '@2', @emp_id) AS msg_desc
                        FROM DBSCOMMON.dbo.message_master t
                        WHERE (t.msg_id = @msg_id)


                        -- Historical Message for reporting purpose
                        EXEC DBShrpn.dbo.usp_ins_ghr_historical_message
                            @p_msg_id             = @msg_id
                            , @p_event_id           = @v_EVENT_ID_PAY_GROUP
                            , @p_emp_id             = @emp_id
                            , @p_eff_date           = @eff_date
                            , @p_pay_element_id     = @v_EMPTY_SPACE
                            , @p_msg_p1             = @emp_id
                            , @p_msg_p2             = @pay_group_id
                            , @p_msg_desc           = 'Invalid pay group id - defaulting to ''99999''.'
                            , @p_activity_status    = @v_ACTIVITY_STATUS_WARNING
                            , @p_activity_date      = @p_activity_date
                            , @p_audit_id           = @aud_id

                        --SET  @w_fatal_error = 1
                        SET @pay_group_id = '99999'  -- default pay group id if not found

                    END


                ---------------------------------------------------------------------------
                -- Effective date must be greater than current effective date
                ---------------------------------------------------------------------------
                SET @msg_id = 'U00027'
                SET @v_step_position = 'Begin ' + RTRIM(@msg_id)

                IF (@w_fatal_error = 0) AND
                (@eff_date <= @cur_eempl_eff_date)
                    BEGIN

                        -- Convert date to string for log table
                        SET @w_msg_text_2 = CONVERT(char(8), @cur_eempl_eff_date, 112)

                        INSERT INTO #tbl_ghr_msg
                        SELECT @msg_id As msg_id
                            , REPLACE(REPLACE(t.msg_text, '@1', @eff_date), '@2', @emp_id) AS msg_desc
                        FROM DBSCOMMON.dbo.message_master t
                        WHERE (t.msg_id = @msg_id)


                        -- Historical Message for reporting purpose
                        EXEC DBShrpn.dbo.usp_ins_ghr_historical_message
                            @p_msg_id             = @msg_id
                            , @p_event_id           = @v_EVENT_ID_LABOR_GROUP
                            , @p_emp_id             = @emp_id
                            , @p_eff_date           = @eff_date
                            , @p_pay_element_id     = @v_EMPTY_SPACE
                            , @p_msg_p1             = @w_msg_text_2
                            , @p_msg_p2             = @pay_group_id
                            , @p_msg_desc           = 'New effective date must be greater than current employee employment effective date.'
                            , @p_activity_status    = @v_ACTIVITY_STATUS_BAD
                            , @p_activity_date      = @p_activity_date
                            , @p_audit_id           = @aud_id

                        SET  @w_fatal_error = 1

                    END


                IF (@w_fatal_error = 1)
                    GOTO BYPASS_EMPLOYEE


                ---------------------------------------------------------------------------
                -- Update Employee Employment with new Pay Group
                ---------------------------------------------------------------------------
                EXEC @w_status = DBShrpn.dbo.usp_upd_emp_employment
                      @p_user_id                    = @p_user_id
                    , @p_activity_date              = @p_activity_date
                    , @p_emp_id                     = @emp_id
                    , @p_eff_date                   = @eff_date
                    , @p_cur_eempl_eff_date         = @cur_eempl_eff_date
                    , @p_labor_grp_code             = @cur_labor_grp_code
                    , @p_pay_group_id               = @pay_group_id
                    , @p_eempl_audit_tbl_ind        = @p_eempl_audit_tbl_ind



                ---------------------------------------------------------------------------
                -- Update Processed Flag after successful update
                ---------------------------------------------------------------------------
                IF (@w_status = 0)
                    UPDATE DBShrpn.dbo.ghr_employee_events_aud
                    SET proc_flag = 'Y'
                    WHERE (activity_date = @p_activity_date)
                      AND (aud_id        = @aud_id)


            END TRY
            BEGIN CATCH

                SELECT @ErrorNumber   = CAST(ERROR_NUMBER() AS varchar(10))
                    , @ErrorMessage  = @v_step_position + ' - ' + ERROR_MESSAGE()
                    , @ErrorSeverity = ERROR_SEVERITY()
                    , @ErrorState    = ERROR_STATE()

                IF (@@TRANCOUNT > 0)
                    ROLLBACK TRAN

                BEGIN TRAN

                -- Log error
                EXEC DBShrpn.dbo.usp_ins_ghr_historical_message
                      @p_msg_id             = @ErrorNumber
                    , @p_event_id           = @v_EVENT_ID_PAY_GROUP
                    , @p_emp_id             = @emp_id
                    , @p_eff_date           = @eff_date
                    , @p_pay_element_id     = @v_EMPTY_SPACE
                    , @p_msg_p1             = @v_EMPTY_SPACE
                    , @p_msg_p2             = @v_EMPTY_SPACE
                    , @p_msg_desc           = @ErrorMessage
                    , @p_activity_status    = @v_ACTIVITY_STATUS_BAD
                    , @p_activity_date      = @p_activity_date
                    , @p_audit_id           = @aud_id


            END CATCH


BYPASS_EMPLOYEE:

            IF (@@TRANCOUNT > 0)
                COMMIT TRAN

            FETCH crsrHR
            INTO  @aud_id
                , @emp_id
                , @eff_date
                , @empl_id
                , @pay_group_id
                , @file_source


        END -- end of while loop

        -- Cleanup Cursor
        CLOSE crsrHR
        DEALLOCATE crsrHR

        -- commit after every record
        IF (@@TRANCOUNT > 0)
            COMMIT TRAN


        ---------------------------------------------------------------------------
        -- Send notification of warning message U00013  -- < PAY GROUP SECTION (8) >
        ---------------------------------------------------------------------------
        SET @msg_id = 'U00104'
        SET @v_step_position = 'Log ' + @msg_id

        SELECT @w_msg_text    = msg_text
            , @w_msg_text_2  = msg_text_2
            , @w_msg_text_3  = msg_text_3
            , @w_severity_cd = severity_cd
        FROM DBSCOMMON.dbo.message_master
        WHERE (msg_id = @msg_id)

        EXEC DBSpscb.dbo.psp_ins_psc_putmsg_2
            @userid   = @p_user_id
            , @batch    = @p_batchname
            , @qual     = @p_qualifier
            , @msgno    = @msg_id
            , @severity = @w_severity_cd
            , @text     = @w_msg_text
            , @text_2   = @w_msg_text_2
            , @text_3   = @w_msg_text_3


        ---------------------------------------------------------------------------
        -- Send notification of warning message U00009  -- < BEGINING OF WARNING MESSAGES: >
        ---------------------------------------------------------------------------
        SET @msg_id = 'U00009'
        SET @v_step_position = 'Log ' + @msg_id

        SELECT @w_msg_text    = msg_text
            , @w_msg_text_2  = msg_text_2
            , @w_msg_text_3  = msg_text_3
            , @w_severity_cd = severity_cd
        FROM DBSCOMMON.dbo.message_master
        WHERE (msg_id = @msg_id)

        EXEC DBSpscb.dbo.psp_ins_psc_putmsg_2
            @userid   = @p_user_id
            , @batch    = @p_batchname
            , @qual     = @p_qualifier
            , @msgno    = @msg_id
            , @severity = @w_severity_cd
            , @text     = @w_msg_text
            , @text_2   = @w_msg_text_2
            , @text_3   = @w_msg_text_3


        ---------------------------------------------------------------------------
        -- Send notification of warning message U00011 -- Blank Line
        ---------------------------------------------------------------------------
        SET @msg_id = 'U00011'
        SET @v_step_position = 'Log ' + @msg_id

        SELECT @w_msg_text    = msg_text
            , @w_msg_text_2  = msg_text_2
            , @w_msg_text_3  = msg_text_3
            , @w_severity_cd = severity_cd
        FROM DBSCOMMON.dbo.message_master
        WHERE (msg_id = @msg_id)

        EXEC DBSpscb.dbo.psp_ins_psc_putmsg_2
            @userid   = @p_user_id
            , @batch    = @p_batchname
            , @qual     = @p_qualifier
            , @msgno    = @msg_id
            , @severity = @w_severity_cd
            , @text     = @w_msg_text
            , @text_2   = @w_msg_text_2
            , @text_3   = @w_msg_text_3


        ---------------------------------------------------------------------------
        -- Send notification of warning message U00105 - Total nbr of employees pay group changes
        ---------------------------------------------------------------------------
        SET @msg_id = 'U00105'
        SET @v_step_position = 'Log ' + @msg_id

        SELECT @msg_id        = msg_id
            , @w_msg_text    = msg_text
            , @w_msg_text_2  = msg_text_2
            , @w_msg_text_3  = msg_text_3
            , @w_severity_cd = severity_cd
        FROM DBSCOMMON.dbo.message_master
        WHERE (msg_id = @msg_id)

        -- Get total name records from HCM
        SELECT @maxx = CAST(COUNT(*) AS varchar(6))
        FROM #ghr_employee_events_temp
        WHERE (event_id =   @v_EVENT_ID_PAY_GROUP)

        IF (CHARINDEX('@1', @w_msg_text,1) > 0)
            SELECT @w_msg_text = REPLACE(@w_msg_text, '@1', @maxx)

        EXEC DBSpscb.dbo.psp_ins_psc_putmsg_2
            @userid   = @p_user_id
            , @batch    = @p_batchname
            , @qual     = @p_qualifier
            , @msgno    = @msg_id
            , @severity = @w_severity_cd
            , @text     = @w_msg_text
            , @text_2   = @w_msg_text_2
            , @text_3   = @w_msg_text_3


        ---------------------------------------------------------------------------
        -- Add log entries that contain employee details
        ---------------------------------------------------------------------------
        -- NOTE: log entries were created in validation section

        SET @v_step_position = 'Log Cursor'

        -- Loop through tbl_ghr_msg to populate error message log entry
        DECLARE crsrLog CURSOR FAST_FORWARD FOR
        SELECT msg.msg_id
            , msg.severity_cd
            , ghr.msg_desc
            , msg.msg_text_2
            , msg.msg_text_3
        FROM #tbl_ghr_msg ghr
        JOIN DBSCOMMON.dbo.message_master msg ON
            (ghr.msg_id = msg.msg_id)
        WHERE (msg.msg_text_2 = 'Y')

        OPEN crsrLog

        FETCH crsrLog
        INTO @msg_id
        , @w_severity_cd
        , @w_msg_text
        , @w_msg_text_2
        , @w_msg_text_3


        WHILE (@@FETCH_STATUS = 0)
        BEGIN
            -- Add entries to DBSpscb..ssw_psc_messages_work
            EXEC DBSpscb.dbo.psp_ins_psc_putmsg_2
                @userid   = @p_user_id
                , @batch    = @p_batchname
                , @qual     = @p_qualifier
                , @msgno    = @msg_id
                , @severity = @w_severity_cd
                , @text     = @w_msg_text
                , @text_2   = @w_msg_text_2
                , @text_3   = @w_msg_text_3

        FETCH crsrLog
        INTO @msg_id
        , @w_severity_cd
        , @w_msg_text
        , @w_msg_text_2
        , @w_msg_text_3

        END

        CLOSE crsrLog
        DEALLOCATE crsrLog



        ---------------------------------------------------------------------------
        -- Send notification of warning message U00011 -- Blank Line
        ---------------------------------------------------------------------------
        SET @msg_id = 'U00011'
        SET @v_step_position = 'Log ' + @msg_id

        SELECT @w_msg_text    = msg_text
            , @w_msg_text_2  = msg_text_2
            , @w_msg_text_3  = msg_text_3
            , @w_severity_cd = severity_cd
        FROM DBSCOMMON.dbo.message_master
        WHERE (msg_id = @msg_id)

        EXEC DBSpscb.dbo.psp_ins_psc_putmsg_2
            @userid   = @p_user_id
            , @batch    = @p_batchname
            , @qual     = @p_qualifier
            , @msgno    = @msg_id
            , @severity = @w_severity_cd
            , @text     = @w_msg_text
            , @text_2   = @w_msg_text_2
            , @text_3   = @w_msg_text_3



        ---------------------------------------------------------------------------
        -- Send notification of warning message U00010 -- <ENDING OF WARNING MESSAGES: >
        ---------------------------------------------------------------------------
        SET @msg_id = 'U00010'
        SET @v_step_position = 'Log ' + @msg_id

        SELECT @w_msg_text    = msg_text
            , @w_msg_text_2  = msg_text_2
            , @w_msg_text_3  = msg_text_3
            , @w_severity_cd = severity_cd
        FROM DBSCOMMON.dbo.message_master
        WHERE (msg_id = @msg_id)

        EXEC DBSpscb.dbo.psp_ins_psc_putmsg_2
            @userid   = @p_user_id
            , @batch    = @p_batchname
            , @qual     = @p_qualifier
            , @msgno    = @msg_id
            , @severity = @w_severity_cd
            , @text     = @w_msg_text
            , @text_2   = @w_msg_text_2
            , @text_3   = @w_msg_text_3


        ---------------------------------------------------------------------------
        -- Send notification of warning message U00011 -- Blank Line
        ---------------------------------------------------------------------------
        SET @msg_id = 'U00011'
        SET @v_step_position = 'Log ' + @msg_id

        SELECT @w_msg_text    = msg_text
            , @w_msg_text_2  = msg_text_2
            , @w_msg_text_3  = msg_text_3
            , @w_severity_cd = severity_cd
        FROM DBSCOMMON.dbo.message_master
        WHERE (msg_id = @msg_id)

        EXEC DBSpscb.dbo.psp_ins_psc_putmsg_2
            @userid   = @p_user_id
            , @batch    = @p_batchname
            , @qual     = @p_qualifier
            , @msgno    = @msg_id
            , @severity = @w_severity_cd
            , @text     = @w_msg_text
            , @text_2   = @w_msg_text_2
            , @text_3   = @w_msg_text_3

        SET @v_step_position = 'End Logging'

    END TRY
    BEGIN CATCH

        SELECT @ErrorNumber   = CAST(ERROR_NUMBER() AS varchar(10))
            , @ErrorMessage  = @v_step_position + ' - ' + ERROR_MESSAGE()
            , @ErrorSeverity = ERROR_SEVERITY()
            , @ErrorState    = ERROR_STATE()
            , @v_ret_val     = -1

        -- Handle cursors
        IF (CURSOR_STATUS('local', 'crsrHR') > 0)
        BEGIN
            CLOSE crsrHR
            DEALLOCATE crsrHR
        END

        IF (CURSOR_STATUS('local', 'crsrLog') > 0)
        BEGIN
            CLOSE crsrLog
            DEALLOCATE crsrLog
        END

        -- Historical Message for reporting purpose
        EXEC DBShrpn.dbo.usp_ins_ghr_historical_message
              @p_msg_id             = @ErrorNumber
            , @p_event_id           = @v_EVENT_ID_PAY_GROUP
            , @p_emp_id             = @emp_id
            , @p_eff_date           = @eff_date
            , @p_pay_element_id     = @v_EMPTY_SPACE
            , @p_msg_p1             = @v_EMPTY_SPACE
            , @p_msg_p2             = @v_EMPTY_SPACE
            , @p_msg_desc           = @ErrorMessage
            , @p_activity_status    = @v_ACTIVITY_STATUS_BAD
            , @p_activity_date      = @p_activity_date
            , @p_audit_id           = @aud_id

        -- send error back to calling procedure
        RAISERROR(
                   @ErrorMessage
                 , @ErrorSeverity
                 , @ErrorState
                 );

    END CATCH


    -- Cleanup temp tables
    DROP TABLE #tbl_ghr_msg


    RETURN @v_ret_val

END
GO

ALTER AUTHORIZATION ON dbo.usp_ins_pay_group TO  SCHEMA OWNER
GO

IF OBJECT_ID(N'dbo.usp_ins_pay_group', N'P') IS NOT NULL
    PRINT N'<<< CREATED PROCEDURE dbo.usp_ins_pay_group >>>'
ELSE
    PRINT N'<<< FAILED CREATING PROCEDURE dbo.usp_ins_pay_group >>>'
GO