USE [DBShrpn]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'hsp_upd_hrpn_02a_trn')
DROP PROCEDURE [dbo].[hsp_upd_hrpn_02a_trn]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[hsp_upd_hrpn_02a_trn] 
   (@p_emp_id                       char(15),
   @p_empl_id                       char(10),
   @p_new_empl_id                   char(10),
   @p_transfer_date                 datetime,
   @p_assign_to                     char(1),
   @p_job_or_pos_id                 char(10),
   @p_org_grp_id                    int,
   @p_org_chart_name                varchar(64),
   @p_org_unit_name                 varchar(245),
   @p_location                      char(10),
   @p_new_tax_entity_id             char(10),
   @p_old_tax_entity_id             char(10),
   @p_eff_date                      datetime,
   @p_pay_group                     char(10),
   @p_emp_info_change_reason        char(5),
   @p_job_position_end_date         datetime,
   @p_assignment_end_date           datetime,
   @p_xfer_different_taxing_cntry   char(1),
   @p_new_empl_taxing_country_cd    char(2),
   @p_new_empl_curr_code            char(3),
   @p_action_datetime               char(30),
   @p_use_policy_xfer_options       char(1) )    /* R6.1M-SSA#131067 */

AS
    declare @w_ret   int,
   @W_ACTION_DATETIME      char(30)

    -- execute @w_ret = sp_dbs_authenticate

  -- if @w_ret != 0
  --    return

/*   TRANSFER AN EMPLOYEE FROM ONE EMPLOYER TO ANOTHER
   (THIS SP PERFORMS ALL PROCESSING NECESSARY TO TABLES WITHIN 'HRPN') */
declare @w_empl_transfer_w_no_salary    char(1),
        @w_emp_id                       char(15),
        @w_empl_id                      char(10),
        @w_eff_date                     datetime,
        @w_next_eff_date                datetime,
        @w_pay_element_id               char(10),
        @w_start_date                   datetime,
        @w_prev_pay_element_id          char(10),
        @w_prev_start_date              datetime,
        @w_empl_xfer_opt_code           char(2),
        @w_return_to_prior_empl         char(1),
        @w_return_to_prior_tax_entity   char(1),
        @w_EOT                          datetime,
        @w_ben_plan_id                  char(15),
        @w_ben_plan_opt_id              char(8),
        @w_participant_id               char(15),
        @w_stop_date                    datetime,
        @w_limit_start_date             datetime,                   /* ssa# 23033, 23012 */
        @w_hold_datetime                datetime,                   /* ssa# 23033, 23012 */
        @w_tax_auth_complete_ret_cd     char(3)

select @w_EOT = '12/31/2999'

/*------ AUDIT SECTION ------*/

declare @W_MS   char(3), @W_ACTION_USER   char(30)

select @W_ACTION_USER = suser_sname()
select @W_ACTION_DATETIME = @p_action_datetime

/*-------------------*/

DELETE FROM #temp1
DELETE FROM #temp4
DELETE FROM #temp5
DELETE FROM #temp6

DELETE FROM #temp7 /* 29954 */
DELETE FROM #temp8 /* 29954 */
DELETE FROM #temp9 /* 29954 */


/*   SELECT EMPLOYEE'S ACTIVE PAY ELEMENTS W/ CURRENT EMPLOYER */
   DECLARE cursor1 cursor for
   SELECT  e.emp_id, e.empl_id,
      e.eff_date, e.next_eff_date,
      e.pay_element_id, e.start_date,
      p.empl_xfer_opt_code
   FROM    emp_pay_element e, pay_element p
   WHERE   e.emp_id   = @p_emp_id
   AND     e.empl_id   = @p_empl_id
   AND     e.eff_date   < @p_transfer_date
   AND  ((e.next_eff_date   >= @p_transfer_date AND e.next_eff_date   != @w_EOT)
         
    OR              (e.next_eff_date   = @w_EOT AND e.stop_date >= @p_transfer_date))
   AND     p.pay_element_id   = e.pay_element_id
   AND          (p.eff_date   <=      e.eff_date
    AND     p.next_eff_date      > e.eff_date)

   OPEN cursor1
   
   FETCH cursor1
   INTO    @w_emp_id, @w_empl_id, @w_eff_date, @w_next_eff_date,
      @w_pay_element_id, @w_start_date, @w_empl_xfer_opt_code

WHILE @@fetch_status = 0

BEGIN       /******  begin while loop for cursor1 *****/

/*   COPY CURRENT ACTIVE VERSION OF EMPLOYEE PAY ELEMENT TO NEW EMPLOYER */
if @p_xfer_different_taxing_cntry = 'N'
     if @w_empl_xfer_opt_code in ('02','03','04') 
        and @p_use_policy_xfer_options = 'Y'               /* R6.1M-SSA#131067 */

   BEGIN       /******  begin if @w_empl_xfer_opt_code in ('02','03','04') *****/
               /******           and @p_use_policy_xfer_options = 'Y'      *****/
   
-- THIS MEANS THERE IS A VERSION WHICH IS EFFECTIVE ON THE TRANSFER DATE SO SKIP IT 

   if @w_next_eff_date = @p_transfer_date
      goto next_section
   else
      BEGIN
         INSERT INTO  #temp1
        /* r71m-578919 in 576240 begin */
	SELECT  emp_id,  	
		empl_id,
		pay_element_id,
		eff_date,
		prior_eff_date,
		next_eff_date,
		inactivated_by_pay_element_ind,
		start_date,
		stop_date,
		change_reason_code,
		pay_element_pay_pd_sched_code,
		calc_meth_code,
		standard_calc_factor_1,
		standard_calc_factor_2,
		special_calc_factor_1,
		special_calc_factor_2,
		special_calc_factor_3,
		special_calc_factor_4,
		rate_tbl_id,
		rate_code,
		payee_name,
		payee_pmt_sched_code,
		payee_bank_transit_nbr,
		payee_bank_acct_nbr,
		pmt_ref_nbr,
		pmt_ref_name,
		vendor_id,
		limit_amt,
		guaranteed_net_pay_amt,
		start_after_pay_element_id,
		indiv_addr_type_to_print_code,
		bank_id,
		direct_deposit_bank_acct_nbr,
		bank_acct_type_code,
		pay_pd_arrears_rec_fixed_amt,
		pay_pd_arrears_rec_fixed_pct,
		min_pay_pd_recovery_amt,
		user_amt_1,
		user_amt_2,
		user_monetary_amt_1,
		user_monetary_amt_2,
		user_monetary_curr_code,
		user_code_1,
		user_code_2,
		user_date_1,
		user_date_2,
		user_ind_1,
		user_ind_2,
		user_text_1,
		user_text_2,
		pension_tot_distn_ind,
		pension_distn_code_1,
		pension_distn_code_2,
	        pre_1990_rpp_ctrb_type_cd,
		chgstamp,
	        ISNULL(first_roth_ctrb, @w_EOT),
        /* r71m-578919 in 576240 end */    
        ISNULL(ira_sep_simple_ind, "N"),            /* r71m-581591 in 582025 */
        ISNULL(taxable_amt_not_determined_ind, "N") /* r71m-581591 in 582025 */    
         FROM    emp_pay_element
         WHERE   emp_id      = @w_emp_id
         AND     empl_id      = @w_empl_id
         AND     pay_element_id   = @w_pay_element_id
         AND     eff_date      = @w_eff_date

         UPDATE #temp1
         SET     empl_id      = @p_new_empl_id,
            start_date      = @p_transfer_date,
            eff_date       = @p_transfer_date,
            prior_eff_date   = @w_EOT
         WHERE   emp_id      = @w_emp_id
         AND     empl_id      = @w_empl_id
         AND     pay_element_id   = @w_pay_element_id
         AND     eff_date   = @w_eff_date
      END
/*   COPY FIRST FUTURE DATED EMPLOYEE PAY ELEMENT VERSION TO NEW EMPLOYER */
next_section:

   INSERT INTO  #temp1
        /* r71m-578919 in 576240 begin */
	SELECT  emp_id,  	
		empl_id,
		pay_element_id,
		eff_date,
		prior_eff_date,
		next_eff_date,
		inactivated_by_pay_element_ind,
		start_date,
		stop_date,
		change_reason_code,
		pay_element_pay_pd_sched_code,
		calc_meth_code,
		standard_calc_factor_1,
		standard_calc_factor_2,
		special_calc_factor_1,
		special_calc_factor_2,
		special_calc_factor_3,
		special_calc_factor_4,
		rate_tbl_id,
		rate_code,
		payee_name,
		payee_pmt_sched_code,
		payee_bank_transit_nbr,
		payee_bank_acct_nbr,
		pmt_ref_nbr,
		pmt_ref_name,
		vendor_id,
		limit_amt,
		guaranteed_net_pay_amt,
		start_after_pay_element_id,
		indiv_addr_type_to_print_code,
		bank_id,
		direct_deposit_bank_acct_nbr,
		bank_acct_type_code,
		pay_pd_arrears_rec_fixed_amt,
		pay_pd_arrears_rec_fixed_pct,
		min_pay_pd_recovery_amt,
		user_amt_1,
		user_amt_2,
		user_monetary_amt_1,
		user_monetary_amt_2,
		user_monetary_curr_code,
		user_code_1,
		user_code_2,
		user_date_1,
		user_date_2,
		user_ind_1,
		user_ind_2,
		user_text_1,
		user_text_2,
		pension_tot_distn_ind,
		pension_distn_code_1,
		pension_distn_code_2,
	        pre_1990_rpp_ctrb_type_cd,
		chgstamp,
	        ISNULL(first_roth_ctrb, @w_EOT), 
        /* r71m-578919 in 576240 end */
        ISNULL(ira_sep_simple_ind, "N"),            /* r71m-581591 in 582025 */
        ISNULL(taxable_amt_not_determined_ind, "N") /* r71m-581591 in 582025 */ 
   FROM    emp_pay_element
   WHERE   emp_id         = @w_emp_id
   AND     empl_id         = @w_empl_id
   AND     pay_element_id   = @w_pay_element_id
   AND     eff_date      = @w_next_eff_date

   if @w_next_eff_date = @p_transfer_date   -- THIS IS THE VERSION WHICH IS 
                                            -- EFFECTIVE ON THE TRANSFER DATE
      UPDATE #temp1
      SET empl_id           = @p_new_empl_id,
          start_date        = @p_transfer_date,
          prior_eff_date    = @w_EOT
      WHERE   emp_id        = @w_emp_id
      AND     empl_id       = @w_empl_id
      AND     pay_element_id= @w_pay_element_id
       AND     eff_date      = @w_next_eff_date
   else
      UPDATE #temp1
      SET     empl_id      = @p_new_empl_id,
         start_date      = @p_transfer_date,
         prior_eff_date   = @p_transfer_date
      WHERE   emp_id      = @w_emp_id
      AND     empl_id      = @w_empl_id
      AND     pay_element_id   = @w_pay_element_id
       AND     eff_date   = @w_next_eff_date
/*   COPY OTHER FUTURE DATED EMPLOYEE PAY ELEMENT VERSIONS TO NEW EMPLOYER */
   INSERT INTO  #temp1
        /* r71m-578919 in 576240 begin */
	SELECT  emp_id,  	
		empl_id,
		pay_element_id,
		eff_date,
		prior_eff_date,
		next_eff_date,
		inactivated_by_pay_element_ind,
		start_date,
		stop_date,
		change_reason_code,
		pay_element_pay_pd_sched_code,
		calc_meth_code,
		standard_calc_factor_1,
		standard_calc_factor_2,
		special_calc_factor_1,
		special_calc_factor_2,
		special_calc_factor_3,
		special_calc_factor_4,
		rate_tbl_id,
		rate_code,
		payee_name,
		payee_pmt_sched_code,
		payee_bank_transit_nbr,
		payee_bank_acct_nbr,
		pmt_ref_nbr,
		pmt_ref_name,
		vendor_id,
		limit_amt,
		guaranteed_net_pay_amt,
		start_after_pay_element_id,
		indiv_addr_type_to_print_code,
		bank_id,
		direct_deposit_bank_acct_nbr,
		bank_acct_type_code,
		pay_pd_arrears_rec_fixed_amt,
		pay_pd_arrears_rec_fixed_pct,
		min_pay_pd_recovery_amt,
		user_amt_1,
		user_amt_2,
		user_monetary_amt_1,
		user_monetary_amt_2,
		user_monetary_curr_code,
		user_code_1,
		user_code_2,
		user_date_1,
		user_date_2,
		user_ind_1,
		user_ind_2,
		user_text_1,
		user_text_2,
		pension_tot_distn_ind,
		pension_distn_code_1,
		pension_distn_code_2,
	        pre_1990_rpp_ctrb_type_cd,
		chgstamp,
	        ISNULL(first_roth_ctrb, @w_EOT), 
        /* r71m-578919 in 576240 end */
        ISNULL(ira_sep_simple_ind, "N"),            /* r71m-581591 in 582025 */
        ISNULL(taxable_amt_not_determined_ind, "N") /* r71m-581591 in 582025 */ 
   FROM    emp_pay_element
   WHERE   emp_id   = @w_emp_id
   AND     empl_id   = @w_empl_id
   AND      pay_element_id   = @w_pay_element_id
   AND     eff_date   >= @p_transfer_date
   AND      eff_date   != @w_next_eff_date      -- YOU DON'T WANT TO SELECT THE VERSION
                                                -- YOU JUST GOT ABOVE
   UPDATE #temp1
   SET     empl_id   = @p_new_empl_id,
      start_date   = @p_transfer_date
   WHERE   emp_id   = @w_emp_id
   AND     empl_id   = @w_empl_id
   AND      pay_element_id   = @w_pay_element_id
   AND     eff_date   >= @p_transfer_date
   AND      eff_date   != @w_next_eff_date

   INSERT INTO emp_pay_element
   SELECT * FROM   #temp1 t1
   WHERE not exists (SELECT 1 FROM emp_pay_element t2
					 WHERE t2.emp_id		= t1.emp_id 	
					   AND t2.empl_id		= t1.empl_id
					   AND t2.pay_element_id= t1.pay_element_id
					   AND t2.eff_date		= t1.eff_date)



    /*******************************************************/
    /*  Chain previous versions if the transfer is back    */
    /*  to a previous employer                             */
    /*******************************************************/
    if  exists (select * from emp_pay_element
                   WHERE emp_id         = @w_emp_id
                     AND empl_id        = @p_new_empl_id
                     AND pay_element_id = @w_pay_element_id
                     AND eff_date       < @p_transfer_date
                     AND next_eff_date  = @w_EOT)
    begin

        select  @w_hold_datetime = (
                select eff_date
                  from emp_pay_element
                 WHERE emp_id         = @w_emp_id
                   AND empl_id        = @p_new_empl_id
                   AND pay_element_id = @w_pay_element_id
                   AND eff_date       < @p_transfer_date
                   AND next_eff_date  = @w_EOT)
                   
        update emp_pay_element
           set prior_eff_date = @w_hold_datetime
         WHERE emp_id         = @w_emp_id
           AND empl_id        = @p_new_empl_id
           AND pay_element_id = @w_pay_element_id
           AND eff_date       = @p_transfer_date

        update emp_pay_element
            set next_eff_date  = @p_transfer_date
         WHERE emp_id         = @w_emp_id
           AND empl_id        = @p_new_empl_id
           AND pay_element_id = @w_pay_element_id
           AND eff_date       = @w_hold_datetime
           AND next_eff_date  = @w_EOT
    end

/* ===AUDIT SECTION ===*/
   INSERT work_emp_pay_element_aud
   SELECT @W_ACTION_USER,'ERXFERPECP',@W_ACTION_DATETIME,emp_id, empl_id,pay_element_id,eff_date,prior_eff_date,next_eff_date,'','',''
   FROM #temp1

   DELETE   work_emp_pay_element_aud
   WHERE   user_id = @W_ACTION_USER
   AND   activity_action_code = 'ERXFERPECP'
   AND   action_date = @W_ACTION_DATETIME

   DELETE FROM #temp1
/*******************************************/
/*   COPY EMPLOYEE PAY ELEMENT NON DATED   */
/*******************************************/
    if exists (SELECT * FROM    emp_pay_element_non_dtd         
                  WHERE   emp_id         = @w_emp_id         
                  AND     empl_id        = @w_empl_id        
                  AND     pay_element_id  = @w_pay_element_id)/* ssa# 23033, 23012 */
    begin                                                     /* ssa# 23033, 23012 */
   INSERT INTO  #temp4
   SELECT *
   FROM    emp_pay_element_non_dtd
   WHERE   emp_id         = @w_emp_id
   AND     empl_id         = @w_empl_id
   AND     pay_element_id   = @w_pay_element_id

   UPDATE #temp4
   SET     empl_id   = @p_new_empl_id
   
    delete from emp_pay_element_non_dtd                         /* ssa# 23033, 23012 */
     WHERE emp_id         = @w_emp_id                           /* ssa# 23033, 23012 */
       AND empl_id        = @p_new_empl_id                      /* ssa# 23033, 23012 */
       AND pay_element_id = @w_pay_element_id                   /* ssa# 23033, 23012 */
                     
   INSERT INTO emp_pay_element_non_dtd
   SELECT *
   FROM   #temp4

   DELETE FROM #temp4
    end /* udpate of emp_pay_element_non_dtd */                 /* ssa# 23033, 23012 */

/*******************************************/
/*   COPY EMPLOYEE PAY ELEMENT LIMIT       */
/*******************************************/
   if  exists (SELECT * FROM emp_pay_element_limit            
                   WHERE emp_id          = @w_emp_id           
                   AND   empl_id         = @w_empl_id          
                   AND   pay_element_id  = @w_pay_element_id)   /* ssa# 23033, 23012 */
    begin                                                       /* ssa# 23033, 23012 */

    SELECT  @w_limit_start_date = (select max(start_date)      
      FROM   emp_pay_element_limit                             
     WHERE   emp_id           = @w_emp_id                      
       AND   empl_id          = @w_empl_id                     
       AND   pay_element_id   = @w_pay_element_id)              /* ssa# 23033, 23012 */    

   INSERT INTO  #temp5
   SELECT *
   FROM    emp_pay_element_limit
   WHERE   emp_id   = @w_emp_id
   AND     empl_id   = @w_empl_id
   AND     pay_element_id   = @w_pay_element_id
   AND     start_date      = @w_limit_start_date               /* ssa# 23033, 23012 */

   UPDATE #temp5
   SET     empl_id    = @p_new_empl_id,
           start_date = @p_transfer_date                        /* R6.1M-SSA#131067 */
   
    delete from emp_pay_element_limit                           /* ssa# 23033, 23012 */
     WHERE emp_id         = @w_emp_id                           /* ssa# 23033, 23012 */
       AND empl_id        = @p_new_empl_id                      /* ssa# 23033, 23012 */
       AND pay_element_id = @w_pay_element_id                   /* ssa# 23033, 23012 */
       AND start_date     = @w_limit_start_date                 /* ssa# 23033, 23012 */
   
   INSERT INTO emp_pay_element_limit
   select *
   FROM   #temp5

   DELETE FROM #temp5
    end /* udpate of emp_pay_element_limit */                   /* ssa# 23033, 23012 */

/*******************************************/
/*   emp_pay_element_comnt                 */
/*******************************************/
   if  exists (SELECT * FROM emp_pay_element_comnt             
                   WHERE emp_id          = @w_emp_id            
                   AND   empl_id         = @w_empl_id           
                   AND   pay_element_id  = @w_pay_element_id    
                   AND   start_date      = @w_start_date)       /* ssa# 23033, 23012 */
    begin                                                       /* ssa# 23033, 23012 */
   INSERT INTO  #temp6
   SELECT *
   FROM    emp_pay_element_comnt
   WHERE   emp_id   = @w_emp_id
   AND     empl_id   = @w_empl_id
   AND     pay_element_id   = @w_pay_element_id
   AND     start_date   = @w_start_date

   UPDATE #temp6
   SET     empl_id    = @p_new_empl_id,
           start_date = @p_transfer_date                       /* ssa# 23033, 23012 */
   
    delete from emp_pay_element_comnt                           /* ssa# 23033, 23012 */
     WHERE emp_id         = @w_emp_id                           /* ssa# 23033, 23012 */
       AND empl_id        = @p_new_empl_id                      /* ssa# 23033, 23012 */
       AND pay_element_id = @w_pay_element_id                   /* ssa# 23033, 23012 */
       AND start_date     = @p_transfer_date                    /* ssa# 23033, 23012 */
   
   INSERT INTO emp_pay_element_comnt
   select *
   FROM   #temp6

   DELETE FROM #temp6      
    end /* udpate of emp_pay_element_comnt */                   /* ssa# 23033, 23012 */

        /**************************************************************/
   END  /******  end if @w_empl_xfer_opt_code in ('02','03','04') *****/
        /******         and @p_use_policy_xfer_options = 'Y'      *****/
        /**************************************************************/

/********************R6.1M-SSA#131067- begin: MOVED to outside cursor1 loop
/* ===AUDIT SECTION ===*/
   INSERT into work_emp_pay_element_aud
   SELECT @W_ACTION_USER,'ERXFERPEDV',@W_ACTION_DATETIME,emp_id,empl_id,pay_element_id,eff_date,prior_eff_date,next_eff_date,'','',''
   FROM emp_pay_element
   WHERE   emp_id   = @w_emp_id
   AND   empl_id   = @w_empl_id
   AND   pay_element_id   = @w_pay_element_id
   AND   eff_date   >= @p_transfer_date

   DELETE work_emp_pay_element_aud
   WHERE user_id = @W_ACTION_USER
   AND activity_action_code = 'ERXFERPEDV'
   AND action_date = @W_ACTION_DATETIME
/*   DELETE FUTURE DATED EMPLOYEE PAY ELEMENT VERSIONS W/ CURRENT EMPLOYER */
   DELETE  emp_pay_element
   FROM    emp_pay_element
   WHERE   emp_id          = @w_emp_id
   AND     empl_id         = @w_empl_id
   AND     pay_element_id  = @w_pay_element_id
   AND     eff_date        >= @p_transfer_date
*********************R6.1M-SSA#131067- end: MOVED to outside cursor1 loop */

/* ===AUDIT SECTION ===*/
   declare @audit_stop_date    datetime
   select @audit_stop_date = dateadd(day, -1,@p_transfer_date)

   INSERT into work_emp_pay_element_aud
   SELECT @W_ACTION_USER,'ERXFERPESP',@W_ACTION_DATETIME,emp_id,empl_id,pay_element_id,eff_date,prior_eff_date,next_eff_date,@audit_stop_date,'',''
   FROM emp_pay_element
   WHERE   emp_id   = @w_emp_id
   AND   empl_id   = @w_empl_id
   AND   pay_element_id   = @w_pay_element_id
   AND   eff_date   = @w_eff_date

   DELETE   work_emp_pay_element_aud
   WHERE   user_id = @W_ACTION_USER
   AND   activity_action_code = 'ERXFERPESP'
   AND   action_date = @W_ACTION_DATETIME

/*   STOP EMPLOYEE'S ACTIVE PAY ELEMENTS W/ CURRENT EMPLOYER */
   UPDATE  emp_pay_element
   SET     stop_date               = dateadd(day, -1,@p_transfer_date),
      next_eff_date                = @w_EOT
   WHERE   emp_id                  = @w_emp_id
   AND     empl_id                 = @w_empl_id
   AND     pay_element_id          = @w_pay_element_id
   AND     eff_date                = @w_eff_date

   FETCH cursor1
   INTO    @w_emp_id, @w_empl_id, @w_eff_date, @w_next_eff_date,
      @w_pay_element_id, @w_start_date, @w_empl_xfer_opt_code

          /******************************************/
END       /******  end   while loop for cursor1 *****/
          /******************************************/

CLOSE cursor1
deallocate  cursor1

/*   FOR EACH EMPLOYEE PAY ELEMENT BEING STOPPED AS A RESULT OF AN EMPLOYEE
   TRANSFERRING TO ANOTHER EMPLOYER IT IS NECESSARY TO STOP ANY ASSOCIATED
   BENEFIT PLAN OPTIONS THE PARTICIPANT MAY HAVE IN EFFECT */

   /*************************************************************
   Sol 557736 - Begin
   **************************************************************/
   select @w_participant_id   = participant_id
     from participant
    where emp_id  = @p_emp_id
   /*************************************************************
   Sol 557736 - end
   **************************************************************/

   DECLARE cursor1A cursor for
   SELECT  e.pay_element_id,
         e.start_date,
         e.stop_date,
         p.ben_plan_id,       /* 22954 */
         p.empl_xfer_opt_code /* 22954 */
   FROM    emp_pay_element e, pay_element p
   WHERE   e.emp_id            = @p_emp_id
   AND     e.empl_id           = @p_empl_id
   AND     e.stop_date         = dateadd(day,-1,@p_transfer_date)
   AND     e.pay_element_id    = p.pay_element_id
   AND     p.next_eff_date     = @w_EOT

   OPEN cursor1A
   
   FETCH cursor1A
   INTO    @w_pay_element_id, @w_start_date, @w_stop_date, @w_ben_plan_id, @w_empl_xfer_opt_code /* 22954 */

declare @w_hold_stop_date  datetime /* 29954 br */
declare @w_ben_plan_opt_stop_date  datetime /* 29954 br */


WHILE @@fetch_status = 0

BEGIN       /******  begin while loop for cursor1A *****/

/*   FIND THE PLAN OPTION (IF ANY) THAT USES THE PAY ELEMENT */
   if      @w_ben_plan_id != '' and @w_ben_plan_id != null
     BEGIN

       SELECT  @w_ben_plan_id     = ben_plan_id,
              @w_ben_plan_opt_id = ben_plan_opt_id,
               @w_ben_plan_opt_stop_date  = stop_date  /* 29954 br */
       FROM    ben_plan_opt
       WHERE   ben_plan_id               = @w_ben_plan_id
       AND     (deduction_pay_element_id = @w_pay_element_id
       OR      accrued_tm_pay_element_id = @w_pay_element_id
       OR      empl_cost_pay_element_id  = @w_pay_element_id
       OR      earning_pay_element_id    = @w_pay_element_id)
       AND     eff_date                 <= @w_start_date
       AND     next_eff_date             > @w_start_date
       /*************************************************************
       Sol 557736 - Begin
                    This query needed to have the refinement below
                    added so that ben plans with multiple options, that
                    use the same pay element, will not return multiple 
                    rows.  At any given point in time, the employee can
                    have only one option that uses one of the pay elements.
                    By going against the ben_plan_ptcp_opt table we will
                    get only the active option that uses one of the 
                    above pay elements.
       **************************************************************/
       and     (ben_plan_opt.ben_plan_opt_id = 
                   (select ben_plan_ptcp_opt.ben_plan_opt_id 
                     from ben_plan_ptcp_opt 
                     where participant_id   = @w_participant_id
                       and ben_plan_id      = @w_ben_plan_id
                       and ben_plan_ptcp_opt.ben_plan_opt_id  = ben_plan_opt.ben_plan_opt_id
                       and start_date       = @w_start_date
                       and eff_date         < @p_transfer_date
                       and ((next_eff_date >= @p_transfer_date and next_eff_date  != @w_EOT)
                                OR (next_eff_date = @w_EOT AND stop_date  >= @p_transfer_date))))       
       /*************************************************************
       Sol 557736 - End
       **************************************************************/


       if @@rowcount > 0
         BEGIN
           /********************/
           /*SSA#29954 - Begin */
           /********************/

           /********************************************************
           *  Since there are 4 possible pay elements for a        *
           *  single option, only do the subsequent process one    *
           *  time per option.  The following edit checks for the  *
           *  existence of the inserted option.  If present, go    *
           *  to the end of the cursor1a loop and proceed to the   *
           *  next pay element.                       29954 br     *
           *********************************************************/
            if  exists( select * from ben_plan_ptcp_opt              /* 29954 br */
                       WHERE   participant_id   = @w_participant_id /* 29954 br */
                       AND     ben_plan_id      = @w_ben_plan_id    /* 29954 br */
                       AND     ben_plan_opt_id  = @w_ben_plan_opt_id/* 29954 br */
                       AND     eff_date         = @p_transfer_date  /* 29954 br */
                       AND     start_date       = @p_transfer_date) /* 29954 br */
               goto next_cursor1a_fetch                             /* 29954 br */

           /********************************************************
           *  If no ben_plan_ptcp_opt row exists for this          *
           *  date criteria, go to the end of the cursor1a loop    *
           *  and proceed to the next pay element.                 *
           *********************************************************/
           if  not exists( select * from ben_plan_ptcp_opt          /* 29954 br */
                       WHERE   participant_id   = @w_participant_id /* 29954 br */
                       AND     ben_plan_id      = @w_ben_plan_id    /* 29954 br */
                       AND     ben_plan_opt_id  = @w_ben_plan_opt_id/* 29954 br */
                       AND     start_date       = @w_start_date     /* 29954 br */
                       AND     eff_date         < @p_transfer_date  /* 29954 br */
                       AND   ((next_eff_date   >= @p_transfer_date  /* 29954 br */
                                  AND next_eff_date != @w_EOT)      /* 29954 br */
                               OR  (next_eff_date  = @w_EOT         /* 29954 br */
                               AND stop_date >= @p_transfer_date))) /* 29954 br */
               goto next_cursor1a_fetch                             /* 29954 br */

           select @w_hold_stop_date = @w_ben_plan_opt_stop_date    /* 29954 br */

           select @w_hold_stop_date = stop_date                    /* 29954 br */
               FROM ben_plan_ptcp_opt                              /* 29954 br */
               WHERE   participant_id   = @w_participant_id        /* 29954 br */
               AND     ben_plan_id      = @w_ben_plan_id           /* 29954 br */
               AND     ben_plan_opt_id  = @w_ben_plan_opt_id       /* 29954 br */
               AND     start_date       = @w_start_date            /* 29954 br */
               AND     eff_date         < @p_transfer_date         /* 29954 br */
               AND   ((next_eff_date   >= @p_transfer_date         /* 29954 br */
                           AND next_eff_date != @w_EOT)            /* 29954 br */
                       OR  (next_eff_date  = @w_EOT                /* 29954 br */
                               AND stop_date >= @p_transfer_date)) /* 29954 br */

           UPDATE  ben_plan_ptcp_opt /*new stop_date set */
           SET     stop_date = @w_stop_date
           WHERE   participant_id   = @w_participant_id
           AND     ben_plan_id      = @w_ben_plan_id
           AND     ben_plan_opt_id  = @w_ben_plan_opt_id
           AND     start_date       = @w_start_date
           AND     eff_date         < @p_transfer_date
           AND   ((next_eff_date    >= @p_transfer_date AND next_eff_date  != @w_EOT)
           OR    (next_eff_date      = @w_EOT AND stop_date  >= @p_transfer_date))
/**/
           if @p_xfer_different_taxing_cntry = 'N'
              AND @w_empl_xfer_opt_code in ('02', '03', '04')
              AND @p_use_policy_xfer_options = 'Y'              /* R6.1M-SSA#131067 */
             BEGIN

               INSERT INTO #temp7
               SELECT *
               FROM ben_plan_ptcp_opt
               WHERE  ben_plan_id     = @w_ben_plan_id
               AND    participant_id  = @w_participant_id
               AND    ben_plan_opt_id = @w_ben_plan_opt_id
               AND    start_date      = @w_start_date
               AND    stop_date       = @w_stop_date
      
               SELECT @w_eff_date = eff_date, 
                       @w_next_eff_date = next_eff_date
               FROM #temp7

               if @w_next_eff_date != @p_transfer_date
                 BEGIN
                   UPDATE #temp7
                   SET start_date     = @p_transfer_date,
                       eff_date       = @p_transfer_date,
                       stop_date      = @w_hold_stop_date,         /* 29954 br */
                       prior_eff_date = @w_EOT

                   INSERT INTO ben_plan_ptcp_opt
                   SELECT *
                   FROM #temp7

                   INSERT INTO #temp8
                   SELECT *
                   FROM ben_plan_ptcp_opt_alloc
                   WHERE	ben_plan_id	= @w_ben_plan_id
                   AND	participant_id	= @w_participant_id
                   AND	ben_plan_opt_id	= @w_ben_plan_opt_id
                   AND	eff_date	= @w_eff_date
	      
                   UPDATE #temp8
                   SET	eff_date = @p_transfer_date

                   INSERT ben_plan_ptcp_opt_alloc
                   SELECT *
                   FROM #temp8
		
                   DELETE FROM #temp8		

                   INSERT INTO #temp9
                   SELECT *
                   FROM ben_plan_ptcp_opt_comnt
                   WHERE	ben_plan_id	= @w_ben_plan_id
                   AND	participant_id	= @w_participant_id
                   AND	ben_plan_opt_id	= @w_ben_plan_opt_id
                   AND	start_date	= @w_start_date
	      
                   UPDATE #temp9
                   SET	start_date = @p_transfer_date

                   INSERT INTO ben_plan_ptcp_opt_comnt
                   SELECT *
                   FROM #temp9

                   DELETE FROM #temp9
                 END /* end if @w_next_eff_date != @p_transfer_date */
                 
               DELETE FROM #temp7

              if @w_next_eff_date = @p_transfer_date
                 UPDATE ben_plan_ptcp_opt
 		            SET	start_date 	    = @p_transfer_date,
                        prior_eff_date	= @w_EOT
                 WHERE	participant_id	= @w_participant_id
                 AND	ben_plan_id	= @w_ben_plan_id
                 AND	ben_plan_opt_id	= @w_ben_plan_opt_id
                 AND	eff_date	= @w_next_eff_date
               else
                 UPDATE ben_plan_ptcp_opt
                   SET	start_date 	= @p_transfer_date,
                   prior_eff_date	= @p_transfer_date
                 WHERE	participant_id	= @w_participant_id
                 AND	ben_plan_id	= @w_ben_plan_id
                 AND	ben_plan_opt_id	= @w_ben_plan_opt_id
                 AND	eff_date	= @w_next_eff_date


               UPDATE ben_plan_ptcp_opt
                   SET	start_date	= @p_transfer_date
                 WHERE	participant_id	= @w_participant_id
                 AND	ben_plan_id	= @w_ben_plan_id
                 AND	ben_plan_opt_id	= @w_ben_plan_opt_id
                 AND	eff_date	>= @p_transfer_date
                 AND	eff_date	!= @w_next_eff_date
             END
           else       
             BEGIN    
/*versions exist*/
/* delete versions of ben plan option that are eff dated on or after the transfer date */
               DELETE FROM ben_plan_ptcp_opt   
                WHERE	participant_id	= @w_participant_id
                AND	ben_plan_id	= @w_ben_plan_id
                AND	ben_plan_opt_id	= @w_ben_plan_opt_id
                AND	start_date	= @w_start_date
                AND	eff_date	>= @p_transfer_date

               DELETE FROM ben_plan_ptcp_opt_comnt     	     
                WHERE	participant_id	= @w_participant_id
                AND	ben_plan_id	= @w_ben_plan_id
                AND	ben_plan_opt_id	= @w_ben_plan_opt_id
                AND	start_date	= @w_start_date
	 
               DELETE FROM ben_plan_ptcp_opt_alloc     	     
                WHERE	participant_id	= @w_participant_id
                AND	ben_plan_id	= @w_ben_plan_id
                AND	ben_plan_opt_id	= @w_ben_plan_opt_id
                AND	eff_date	= @p_transfer_date
     
             END   /* end if @p_xfer_different_taxing_cntry = 'N'         */
                   /*     AND @w_empl_xfer_opt_code in ('02', '03', '04') */
                   /*     AND @p_use_policy_xfer_options = 'Y'     else   */

             /* R6.1M-SSA#131067 begin add */
             /* Update the next_eff_date so that the workbench options and */
             /* emp pay element versions show up correctly.                */
             UPDATE ben_plan_ptcp_opt
                SET next_eff_date = @w_EOT
              WHERE participant_id = @w_participant_id
                AND ben_plan_id = @w_ben_plan_id
                AND ben_plan_opt_id = @w_ben_plan_opt_id
                AND start_date = @w_start_date
                AND stop_date < next_eff_date
                AND next_eff_date != @w_EOT
             /* R6.1M-SSA#131067 end add */


         END /* end if @@rowcount > 0 */
         
     END /* end if @w_ben_plan_id != '' and @w_ben_plan_id != null */

                            /*#######################################*/
next_cursor1a_fetch:        /*##  Label for "next_cursor1a_fetch"  ##*/ /* 29954 br */
                            /*#######################################*/

/********************/
/*SSA#29954 End     */
/********************/

   FETCH cursor1A
   INTO    @w_pay_element_id, @w_start_date, @w_stop_date, @w_ben_plan_id, @w_empl_xfer_opt_code /* 22954 */

          /*******************************************/
END       /******  end   while loop for cursor1A *****/
          /*******************************************/

CLOSE cursor1A
deallocate  cursor1A

/********************************************/
/*SSA#131067 Begin delete future dated rows */
/********************************************/

/* Approximately 340 lines of commented out code was deleted at this point. */
/* SSA#131067                                                               */

/* R6.1M-SSA#131067 - begin: add block */
/* Need to delete future dated benefit plan participant option related */
/* information associated with the old employer.                       */

DECLARE cursor2 cursor for
 SELECT  e.pay_element_id,
         p.ben_plan_id        
  FROM   emp_pay_element e, pay_element p
 WHERE   e.emp_id            = @p_emp_id
   AND   e.empl_id           = @p_empl_id
   AND   e.start_date       >= @p_transfer_date
   AND   e.pay_element_id    = p.pay_element_id

OPEN cursor2
   
FETCH cursor2
 INTO    @w_pay_element_id, @w_ben_plan_id

WHILE @@fetch_status = 0
  BEGIN
    if @w_ben_plan_id != '' and @w_ben_plan_id != null
      BEGIN
        SELECT  DISTINCT  /* This returns the ben_plan_id and the plan_opt_id */
                @w_ben_plan_id = bpo.ben_plan_id,
                @w_ben_plan_opt_id = bpo.ben_plan_opt_id
           FROM  ben_plan_opt bpo, ben_plan_ptcp_opt bppo
         WHERE  bpo.ben_plan_id               = @w_ben_plan_id
           AND  (bpo.deduction_pay_element_id = @w_pay_element_id
            OR  bpo.accrued_tm_pay_element_id = @w_pay_element_id
            OR  bpo.empl_cost_pay_element_id  = @w_pay_element_id
            OR  bpo.earning_pay_element_id    = @w_pay_element_id)
           AND  bpo.ben_plan_id               = bppo.ben_plan_id
           AND  bpo.ben_plan_opt_id           = bppo.ben_plan_opt_id
           AND  bppo.eff_date                >= @p_transfer_date   
   
        if @@rowcount > 0
          BEGIN
            SELECT  @w_participant_id   = participant_id
              FROM  participant
             WHERE  emp_id  = @p_emp_id   

            DELETE FROM ben_plan_ptcp_opt /* delete options on or after transfer date */
             WHERE participant_id  = @w_participant_id
               AND ben_plan_id     = @w_ben_plan_id
               AND ben_plan_opt_id = @w_ben_plan_opt_id
               AND eff_date       >= @p_transfer_date
		

            DELETE FROM ben_plan_ptcp_opt_comnt     	     
             WHERE participant_id  = @w_participant_id
               AND ben_plan_id     = @w_ben_plan_id
               AND ben_plan_opt_id = @w_ben_plan_opt_id
               AND start_date     >= @p_transfer_date
	 
            DELETE FROM ben_plan_ptcp_opt_alloc     	     
             WHERE participant_id  = @w_participant_id
               AND ben_plan_id     = @w_ben_plan_id
               AND ben_plan_opt_id = @w_ben_plan_opt_id
               AND eff_date       >= @p_transfer_date
 
                  
	      END /* end if @@rowcount > 0 */
          
      END /* end if @w_ben_plan_id != '' and @w_ben_plan_id != null */

    FETCH cursor2
     INTO @w_pay_element_id, @w_ben_plan_id

  END /* end cursor2 while loop */
      
close cursor2
deallocate  cursor2

/* R6.1M-SSA#131067 - end: add block */
    
/* Need to delete future dated employee pay element information */
/* associated with the old employer.                            */

/* R6.1M-SSA#131067- begin: MOVED From inside cursor1 loop */
/* ===AUDIT SECTION ===*/
   INSERT into work_emp_pay_element_aud
   SELECT @W_ACTION_USER,'ERXFERPEDV',@W_ACTION_DATETIME,emp_id,empl_id,pay_element_id,eff_date,prior_eff_date,next_eff_date,'','',''
   FROM emp_pay_element
   WHERE   emp_id   = @p_emp_id
   AND   empl_id   = @p_empl_id
/* AND   pay_element_id   = @w_pay_element_id */ /* R6.1M-SSA#131067 */
   AND   eff_date   >= @p_transfer_date

   DELETE work_emp_pay_element_aud
   WHERE user_id = @W_ACTION_USER
   AND activity_action_code = 'ERXFERPEDV'
   AND action_date = @W_ACTION_DATETIME
/*   DELETE FUTURE DATED EMPLOYEE PAY ELEMENT VERSIONS W/ CURRENT EMPLOYER */
delete from emp_pay_element
 WHERE   emp_id          = @p_emp_id
   AND   empl_id         = @p_empl_id
/* AND   pay_element_id  = @w_pay_element_id */ /* R6.1M-SSA#131067 */
   AND   eff_date       >= @p_transfer_date
/* R6.1M-SSA#131067- end: MOVED From inside cursor1 loop */

/* R6.1M-SSA#131067 - begin: block add */
delete from emp_pay_element_limit                           
 WHERE emp_id         = @p_emp_id                           
   AND empl_id        = @p_empl_id                     
   AND start_date    >= @p_transfer_date

delete from emp_pay_element_comnt                           
 WHERE emp_id         = @p_emp_id                           
   AND empl_id        = @p_empl_id 
   AND start_date    >= @p_transfer_date
/* R6.1M-SSA#131067 - end: block add */

/******************************************/
/*SSA#131067 End delete future dated rows */
/******************************************/

return 0

 
GO


