-- Table: public.departments

-- DROP TABLE public.departments;

CREATE TABLE public.departments
(
    dept_no character varying(20) COLLATE pg_catalog."default" NOT NULL,
    dept_name character varying(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (dept_no)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.departments
    OWNER to postgres;