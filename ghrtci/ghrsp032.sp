USE [DBShrpn]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'hsp_upd_hrpn_04_trn')
DROP PROCEDURE [dbo].[hsp_upd_hrpn_04_trn]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[hsp_upd_hrpn_04_trn]

	( @p_emp_id                       char(15),
	  @p_empl_id                      char(10),
	  @p_new_empl_id                  char(10),
	  @p_old_tax_entity_id            char(10),
	  @p_new_tax_entity_id            char(10),
	  @p_new_empl_taxing_country_cd   char(03),
	  @w_us_authorities_complete	  char(01) output,
	  @w_tax_auth_complete_ret_cd     char(03) output )

AS

    declare @w_ret   int,
	    @W_ACTION_DATETIME      char(30)

 --   execute @w_ret = sp_dbs_authenticate

--    if @w_ret != 0
 --     return

    declare @w_emp_id                       char(15),
	    @w_tax_authority_id             char(10),
	    @w_dummy                        char(1),
	    @w_tax_entity_id_prev           char(10),
	    @w_tax_entity_id		    char(10),
	    @w_pct_of_time_worked           money,
	    @w_total_pct_of_time_worked     money,
	    @w_work_resident_status_code    char(1),
	    @w_no_of_resident_states        smallint,
	    @w_sui_st_ind                   char(1),
	    @w_sdi_status_code              char(1),
	    @w_no_of_sui_states		    smallint,
	    @w_no_of_sdi_states		    smallint,
	    @w_no_of_sui_territories	    smallint,
	    @w_no_of_sdi_territories	    smallint,
	    @w_emp_can_tax_auth_complete    char(1),
	    @w_validate_emp_territory       char(1),
	    @w_validate_emp_state	    char(1)
	
IF @p_new_empl_taxing_country_cd = 'US'
   BEGIN
     /*   COPY EMPLOYEE'S U.S. TAX AUTHORITIES THAT ARE NOT VALID W/ NEW TAX ENTITY */
     /*   SELECT EMPLOYEE'S ACTIVE US TAX AUTHORITIES W/ CURRENT TAX ENTITY */
     DECLARE cursor1 cursor for
     SELECT emp_id, tax_authority_id
     FROM   emp_us_tax_authority
     WHERE  emp_id        = @p_emp_id
     AND    tax_entity_id = @p_old_tax_entity_id

     OPEN cursor1
	
     FETCH cursor1
     	INTO    @w_emp_id, @w_tax_authority_id

     WHILE @@fetch_status = 0
       BEGIN
	if @w_tax_authority_id = 'USFED'
	   /*   COPY OR UPDATE EMPLOYEE'S US FEDERAL TAX AUTHORITY */
	   BEGIN
		SELECT	@w_dummy	= emp_id
		FROM    emp_us_tax_authority
		WHERE   emp_id		 = @p_emp_id
		AND     tax_entity_id	 = @p_new_tax_entity_id
		AND     tax_authority_id = 'USFED'
	
		if @@rowcount > 0
			UPDATE emp_us_tax_authority
			SET    emp_us_tax_authority_status_cd = '1'
			WHERE  emp_id           = @p_emp_id
			AND    tax_entity_id    = @p_new_tax_entity_id
			AND    tax_authority_id = 'USFED'
		else
		  BEGIN
			INSERT INTO  #temp12
			SELECT *
			FROM    emp_us_tax_authority
			WHERE   emp_id		 = @p_emp_id
			AND     tax_entity_id	 = @p_old_tax_entity_id
			AND     tax_authority_id = 'USFED'

			UPDATE #temp12
			SET     tax_entity_id = @p_new_tax_entity_id

			INSERT INTO emp_us_tax_authority
			SELECT *
			FROM   #temp12

			DELETE FROM #temp12
		END
	   END
	else
	  /*   DETERMINE IF EMPLOYEE'S TAX AUTHORITY IS VALID W/ NEW TAX ENTITY */
	  BEGIN
		SELECT  @w_dummy  = empl_id
		FROM    empl_tax_entity_us_tax_auth
		WHERE   empl_id				= @p_new_empl_id
		AND     tax_entity_id			= @p_new_tax_entity_id
		AND     tax_authority_id		= @w_tax_authority_id
		AND     tax_entity_us_tax_auth_stat_cd 	= '1'

		if @@rowcount > 0
		   /*   COPY OR UPDATE EMPLOYEE'S STATE, TERRITORY & LOCAL TAX AUTHORITIES */
		   BEGIN
		     if exists (SELECT *
				FROM    emp_us_tax_authority
				WHERE   emp_id		 = @p_emp_id
				AND     tax_entity_id	 = @p_new_tax_entity_id
				AND     tax_authority_id = @w_tax_authority_id)
		  	begin
				UPDATE emp_us_tax_authority
				SET    emp_us_tax_authority_status_cd = '1'
				WHERE   emp_id           = @p_emp_id
				AND     tax_entity_id    = @p_new_tax_entity_id
				AND     tax_authority_id = @w_tax_authority_id
		  	end
		     else
			BEGIN
				INSERT INTO  #temp12
				SELECT *
				FROM    emp_us_tax_authority
				WHERE   emp_id		 = @p_emp_id
				AND     tax_entity_id	 = @p_old_tax_entity_id
				AND     tax_authority_id = @w_tax_authority_id

				UPDATE #temp12
				SET     tax_entity_id = @p_new_tax_entity_id
		
				INSERT INTO emp_us_tax_authority
				SELECT *
				FROM   #temp12
	
				DELETE FROM #temp12
			END
		   END
	  end /* else */

	FETCH cursor1
	INTO    @w_emp_id, @w_tax_authority_id
       END

     CLOSE cursor1
     deallocate cursor1

     /*   VALIDATE EMPLOYEE'S US TAX AUTHORITIES FOR COMPLETENESS */
     DECLARE cursor2 cursor for
     SELECT  DISTINCT tax_entity_id
     FROM    emp_us_tax_authority
     WHERE   emp_id        = @p_emp_id
	
     OPEN cursor2
	
     FETCH cursor2
	INTO    @w_tax_entity_id

     SELECT @w_us_authorities_complete = 'Y',
	    @w_tax_auth_complete_ret_cd = '0'

     IF @@fetch_status <> 0
	Begin
		SELECT @w_us_authorities_complete = 'N',
	               @w_tax_auth_complete_ret_cd = '300'	
	End

     WHILE @@fetch_status = 0 AND @w_tax_auth_complete_ret_cd = '0'
	   BEGIN
		SELECT @w_validate_emp_territory   = 'N',
	    	       @w_validate_emp_state	= 'N'

     		IF EXISTS (SELECT *
		  	   FROM emp_us_tax_authority EUSTA,
		                us_tax_authority USTA
		 	   WHERE EUSTA.emp_id = @p_emp_id
		   	   AND EUSTA.tax_entity_id = @w_tax_entity_id
		   	   AND EUSTA.emp_us_tax_authority_status_cd = '1'
		   	   AND USTA.tax_authority_id = EUSTA.tax_authority_id
		   	   AND USTA.tax_authority_type_code = '4')
	
			IF EXISTS (SELECT *
		     		   FROM emp_us_tax_authority EUSTA,
			  		us_tax_authority USTA
		    		   WHERE EUSTA.emp_id = @p_emp_id
		      		   AND EUSTA.tax_entity_id = @w_tax_entity_id
		      		   AND EUSTA.emp_us_tax_authority_status_cd = '1'
		      		   AND USTA.tax_authority_id = EUSTA.tax_authority_id
		      		   AND USTA.tax_authority_type_code = '2')
		
				SELECT @w_us_authorities_complete = 'N',
		       		       @w_tax_auth_complete_ret_cd = '200'

		        ELSE
	   		  /* PERFORM TERRITORY VALIDATION SINCE EMP ONLY HAS ACTIVE
	      		     TERRITORIES WITH A PERCENTAGE > 0 */
	    		  SELECT @w_validate_emp_territory = 'Y'

     		ELSE
		  /* PERFORM STATE VALIDATION SINCE EMP DOES NOT HAVE ANY ACTIVE
	             TERRITORIES WITH A PERCENTAGE > 0 */
		  SELECT @w_validate_emp_state = 'Y'


   		IF @w_validate_emp_territory = 'Y'
		   BEGIN
			SELECT 	@w_total_pct_of_time_worked = 0,
	       			@w_no_of_sui_territories    = 0,
	       			@w_no_of_sdi_territories    = 0

			/*  VALIDATE EMPLOYEE'S TERRITORY TAX AUTHORITIES FOR COMPLETENESS */
       			DECLARE cursor3 cursor for
	  		SELECT  tm_worked_pct, work_resident_status_code,
		  		sui_st_ind, sdi_status_code
	  		FROM    emp_us_tax_authority e, us_tax_authority u
	  		WHERE   e.emp_id 			 = @p_emp_id
	  		AND     e.tax_entity_id 		 = @w_tax_entity_id
	  		AND     e.emp_us_tax_authority_status_cd = '1'
	  		AND     e.tax_authority_id 		 = u.tax_authority_id
	  		AND     u.tax_authority_type_code 	 = '4'
	
			OPEN cursor3

			FETCH cursor3
				INTO  @w_pct_of_time_worked,
	      			      @w_work_resident_status_code, @w_sui_st_ind, @w_sdi_status_code

			IF @@fetch_status <> 0
			   Begin	
	  			SELECT 	@w_us_authorities_complete = 'N',
		  			@w_tax_auth_complete_ret_cd = '400'	
	   			goto CLOSE_CSR
			   End

			WHILE @@fetch_status = 0
			  BEGIN
				SELECT @w_total_pct_of_time_worked = @w_total_pct_of_time_worked + @w_pct_of_time_worked

				IF @w_sui_st_ind = 'Y'
	   				SELECT @w_no_of_sui_territories = @w_no_of_sui_territories + 1

				IF @w_sdi_status_code = '2'
	   				SELECT @w_no_of_sdi_territories = @w_no_of_sdi_territories + 1

	 			FETCH cursor3
	  				INTO  @w_pct_of_time_worked, @w_work_resident_status_code,
	        			      @w_sui_st_ind,  @w_sdi_status_code
			  END

			IF(@w_total_pct_of_time_worked = 100
	   			AND @w_no_of_sui_territories = 1
	   			AND (@w_no_of_sdi_territories = 0 or @w_no_of_sdi_territories = 1))
	   				SELECT @w_dummy = ''
			ELSE
	   			SELECT 	@w_us_authorities_complete = 'N',
		  			@w_tax_auth_complete_ret_cd = '400'

CLOSE_CSR:
			CLOSE cursor3
			deallocate cursor3
			
		   END  /* if @w_validate_emp_territory = 'Y' */

		/*   VALIDATE EMPLOYEE'S STATE TAX AUTHORITIES FOR COMPLETENESS */
  		IF @w_validate_emp_state = 'Y'
  		   BEGIN
			SELECT 	@w_total_pct_of_time_worked = 0,
	       			@w_no_of_resident_states    = 0,
	       			@w_no_of_sui_states	    = 0,
	       			@w_no_of_sdi_states	    = 0
	
			DECLARE cursor4 cursor for
			SELECT  tm_worked_pct, work_resident_status_code,
				sui_st_ind, sdi_status_code
			FROM    emp_us_tax_authority e, us_tax_authority u
			WHERE   e.emp_id 			 = @p_emp_id
			AND     e.tax_entity_id 		 = @w_tax_entity_id
			AND     e.emp_us_tax_authority_status_cd = '1'
			AND     e.tax_authority_id		 = u.tax_authority_id
			AND     u.tax_authority_type_code	 = '2'
	
			OPEN cursor4

			FETCH cursor4
				INTO  @w_pct_of_time_worked, @w_work_resident_status_code,
	      			      @w_sui_st_ind, @w_sdi_status_code

			WHILE @@fetch_status = 0
			  BEGIN
				SELECT @w_total_pct_of_time_worked = @w_total_pct_of_time_worked + @w_pct_of_time_worked

				IF @w_sui_st_ind = 'Y'
	   				SELECT @w_no_of_sui_states = @w_no_of_sui_states + 1

				IF @w_work_resident_status_code = '1'OR @w_work_resident_status_code = '3'
	      				SELECT @w_no_of_resident_states = @w_no_of_resident_states + 1
	
        			IF @w_sdi_status_code = '2' OR @w_sdi_status_code = '3'
	      				SELECT @w_no_of_sdi_states = @w_no_of_sdi_states + 1

				FETCH cursor4
					INTO  @w_pct_of_time_worked, @w_work_resident_status_code,
	      				      @w_sui_st_ind,  @w_sdi_status_code

			  END

			IF (@w_total_pct_of_time_worked = 100
	    			AND @w_no_of_sui_states = 1
	    			AND @w_no_of_resident_states = 1
	    			AND (@w_no_of_sdi_states = 0 or @w_no_of_sdi_states = 1))
	    				SELECT @w_dummy = ''
			ELSE
	    				SELECT 	@w_us_authorities_complete = 'N',
		   				@w_tax_auth_complete_ret_cd = '300'

CLOSE_CURSOR:
			CLOSE cursor4
			deallocate cursor4
		   END

   		FETCH cursor2
			INTO    @w_tax_entity_id
	   END

     CLOSE cursor2
     deallocate cursor2

     /*   UPDATE EMPLOYEE STATE TAX AUTHORITIES COMPLETE INDICATOR */
     if @w_us_authorities_complete	= 'Y'
	UPDATE  employee
	SET     us_tax_auths_compl_ind	= 'Y'
	WHERE   emp_id	= @p_emp_id
     else
  	UPDATE  employee
	SET     us_tax_auths_compl_ind	= 'N'
	WHERE   emp_id	= @p_emp_id
   END
ELSE IF @p_new_empl_taxing_country_cd = 'CA'
   BEGIN
     /* UPDATE ANY EXISTING CANADIAN TAX AUTHORITIES THE EMPLOYEE HAS */
     /* WITH THEIR NEW EMPLOYER					     */
     UPDATE emp_can_tax_authority
     SET    primary_province_ind = 'N'
     WHERE  emp_id = @p_emp_id
     AND    empl_id = @p_new_empl_id
     AND    tax_authority_id IN (SELECT tax_authority_id
				 FROM   canadian_tax_authority
				 WHERE  tax_authority_type_code = '2')

     /*   SELECT EMPLOYEE'S ACTIVE CANADIAN TAX AUTHORITIES W/ CURRENT EMPLOYER */
     DECLARE cursor5 cursor for
     SELECT  emp_id, tax_authority_id
     FROM    emp_can_tax_authority
     WHERE   emp_id  = @p_emp_id
     AND     empl_id = @p_empl_id
     AND     emp_can_tax_auth_status_cd = '1'  /* Active */

     OPEN cursor5
	
     FETCH cursor5
	INTO    @w_emp_id, @w_tax_authority_id

     WHILE @@fetch_status = 0
	BEGIN
	  if @w_tax_authority_id = 'CANFED'
	     /*   COPY OR UPDATE EMPLOYEE'S CANADIAN FEDERAL TAX AUTHORITY */
	     BEGIN
		SELECT  @w_dummy	= emp_id
		FROM    emp_can_tax_authority
		WHERE   emp_id		 = @p_emp_id
		AND     empl_id		 = @p_new_empl_id
		AND     tax_authority_id = 'CANFED'
	
		if @@rowcount > 0
			UPDATE emp_can_tax_authority
			SET    emp_can_tax_auth_status_cd = '1'
			WHERE  emp_id           = @p_emp_id
			AND    empl_id    	= @p_new_empl_id
			AND    tax_authority_id = 'CANFED'
		else
		  BEGIN
			INSERT INTO  #temp15
			SELECT *
			FROM    emp_can_tax_authority
			WHERE   emp_id			= @p_emp_id
			AND     empl_id	= @p_empl_id
			AND     tax_authority_id= 'CANFED'

			UPDATE #temp15
			SET     empl_id = @p_new_empl_id

			INSERT INTO emp_can_tax_authority
			SELECT *
			FROM   #temp15

			DELETE FROM #temp15
		  END
	     END
	  else
             /*   DETERMINE IF EMPLOYEE'S PROVINCIAL TAX AUTHORITY IS VALID W/ NEW EMPLOYER */
	     BEGIN
		SELECT  @w_dummy  = empl_id
		FROM    empl_canadian_tax_authority
		WHERE   empl_id			= @p_new_empl_id
		AND     tax_authority_id= @w_tax_authority_id
		AND     empl_can_tax_auth_status_cd = '1'

		if @@rowcount > 0
		   /*   COPY OR UPDATE EMPLOYEE'S CANADIAN TAX AUTHORITIES */
		   BEGIN
			if exists (SELECT *
				   FROM  emp_can_tax_authority
				   WHERE emp_id           = @p_emp_id
				   AND   empl_id          = @p_new_empl_id
				   AND   tax_authority_id = @w_tax_authority_id)
		  	   begin
				UPDATE emp_can_tax_authority
				SET    emp_can_tax_auth_status_cd = '1'
				WHERE  emp_id    = @p_emp_id
				AND    empl_id   = @p_new_empl_id
				AND    tax_authority_id= @w_tax_authority_id
		  	   end
			else
			   BEGIN
				INSERT INTO  #temp15
				SELECT *
				FROM   emp_can_tax_authority
				WHERE  emp_id	= @p_emp_id
				AND    empl_id	= @p_empl_id
				AND    tax_authority_id = @w_tax_authority_id

				UPDATE #temp15
				SET     empl_id = @p_new_empl_id
		
				INSERT INTO emp_can_tax_authority
				SELECT *
				FROM   #temp15
	
				DELETE FROM #temp15
			   END
		   END
	     end
	  FETCH cursor5
		INTO    @w_emp_id, @w_tax_authority_id
        END

     CLOSE cursor5
     deallocate cursor5

     /* VALIDATE EMPLOYEE'S PROVINCIAL TAX AUTHORITIES FOR COMPLETENESS */
     SELECT @w_dummy = eecta.emp_id
     FROM   emp_can_tax_authority eecta,
	    canadian_tax_authority cta
     WHERE  eecta.emp_id                     = @p_emp_id
     AND    eecta.empl_id                    = @p_new_empl_id
     AND    eecta.emp_can_tax_auth_status_cd = '1'
     AND    eecta.primary_province_ind 	     = 'Y'
     AND    cta.tax_authority_id 	     = eecta.tax_authority_id
     AND    cta.tax_authority_type_code      = '2'

     IF @@rowcount = 1
     	SELECT @w_emp_can_tax_auth_complete = 'Y'
     ELSE
     	SELECT 	@w_emp_can_tax_auth_complete = 'N',
	    	@w_tax_auth_complete_ret_cd = '500'

     UPDATE employee
     SET canadian_tax_auth_compl_ind = @w_emp_can_tax_auth_complete
     WHERE emp_id = @p_emp_id
   END

 
GO


