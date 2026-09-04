select distinct ea.annual_salary_amt
, ea.pay_basis_code
, ea.pd_salary_tm_pd_id
, ea.hourly_pay_rate
, ea.work_tm_code
, ea.pay_on_reported_hrs_ind
, ea.standard_work_hrs
, ea.standard_work_pd_id

from DBShrpn.dbo.uvu_emp_status_most_rec stat
join DBShrpn.dbo.uvu_emp_assignment_most_rec ea ON
	(stat.emp_id = ea.emp_id)

where stat.emp_status_code IN ('A', 'I')

