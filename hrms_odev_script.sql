CREATE TABLE public.users(
	id INT GENERATED BY DEFAULT AS IDENTITY (INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1),
	email CHARACTER VARYING(320) NOT NULL,
	password CHARACTER  VARYING(25) NOT NULL,
	CONSTRAINT pk_users PRIMARY KEY(id),
	CONSTRAINT uc_users_email UNIQUE(email)
);

CREATE TABLE public.employees(
	id INT NOT NULL,
	first_name CHARACTER VARYING(50) NOT NULL,
	last_name CHARACTER  VARYING(50) NOT NULL,
	CONSTRAINT pk_employees PRIMARY KEY(id),
	CONSTRAINT fk_employees_users FOREIGN KEY(id) REFERENCES public.users(id)
);

CREATE TABLE public.candidates(
	id INT NOT NULL,
	first_name CHARACTER VARYING(50) NOT NULL,
	last_name CHARACTER  VARYING(50) NOT NULL,
	tc_identity_number CHARACTER  VARYING(11) NOT NULL,
	birth_year INT NOT NULL,
	CONSTRAINT pk_candidates PRIMARY KEY(id),
	CONSTRAINT fk_candidates_users FOREIGN KEY(id) REFERENCES public.users(id),
	CONSTRAINT uc_candidates_tc_identity_number UNIQUE(tc_identity_number)
	);

CREATE TABLE public.employers(
	id INT NOT NULL,
	company_name CHARACTER VARYING(255) NOT NULL,
	web_address CHARACTER  VARYING(50) NOT NULL,
	CONSTRAINT pk_employers PRIMARY KEY(id),
	CONSTRAINT fk_employers_users FOREIGN KEY(id) REFERENCES public.users(id)
	);

CREATE TABLE public.verification_codes(
	id INT GENERATED BY DEFAULT AS IDENTITY (INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1),
	code CHARACTER VARYING(38) NOT NULL,
	is_verified BOOLEAN NOT NULL,
	verification_date DATE,
	CONSTRAINT pk_verification_codes PRIMARY KEY(id),
	CONSTRAINT uc_verification_codes_code UNIQUE(code)
);

CREATE TABLE public.verification_code_candidates(
	id INT NOT NULL,
	candidate_id INT NOT NULL,
	CONSTRAINT pk_verification_code_candidates PRIMARY KEY(id),
	CONSTRAINT fk_verification_code_candidates_candidates FOREIGN KEY(candidate_id) REFERENCES public.candidates(id),
	CONSTRAINT fk_verification_code_candidates_verification_codes FOREIGN KEY(id) 
	REFERENCES public.verification_codes(id)
);

CREATE TABLE public.verification_code_employers(
	id INT NOT NULL,
	employer_id INT NOT NULL,
	CONSTRAINT pk_verification_code_employers PRIMARY KEY(id),
	CONSTRAINT fk_verification_code_employers_employers FOREIGN KEY(employer_id) REFERENCES public.employers(id),
	CONSTRAINT fk_verification_code_employers_verification_codes FOREIGN KEY(id) 
	REFERENCES public.verification_codes(id)
);

CREATE TABLE public.employee_confirms(
	id INT GENERATED BY DEFAULT AS IDENTITY (INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
	employee_id INT NOT NULL,
	is_confirmed BOOLEAN NOT NULL,
	confirm_date DATE,
	CONSTRAINT pk_employee_confirms PRIMARY KEY(id),
	CONSTRAINT fk_employee_confirms_employee FOREIGN KEY(employee_id) REFERENCES public.employees(id)
);

CREATE TABLE public.employee_confirms_employers(
    id INT NOT NULL,
	employer_id INT NOT NULL,
	CONSTRAINT pk_employee_confirms_employers PRIMARY KEY(id),
	CONSTRAINT fk_employee_confirms_employers_employee_confirms FOREIGN KEY(id) REFERENCES public.employee_confirms(id),
	CONSTRAINT fk_employee_confirms_employers_employers  FOREIGN KEY(employer_id) REFERENCES public.employers(id)
);

CREATE TABLE public.job_titles(
   id INT GENERATED BY DEFAULT AS IDENTITY (INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
   title CHARACTER VARYING(255),
   CONSTRAINT pk_job_titles PRIMARY KEY(id),
   CONSTRAINT uc_job_titles_title UNIQUE(title)
);