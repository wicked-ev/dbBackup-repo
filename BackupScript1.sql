BEGIN;


CREATE TABLE IF NOT EXISTS public.disease_meds
(
    medid bigint,
    diseaseid bigint
);

CREATE TABLE IF NOT EXISTS public.disease_record
(
    drid bigint NOT NULL,
    doi date NOT NULL,
    doc date,
    puidd bigint NOT NULL,
    idd bigint,
    CONSTRAINT disease_record_pkey PRIMARY KEY (drid)
);

CREATE TABLE IF NOT EXISTS public.diseases
(
    idd bigint NOT NULL,
    dname character varying(255) COLLATE pg_catalog."default",
    sname character varying(255) COLLATE pg_catalog."default",
    dtype character varying(255) COLLATE pg_catalog."default",
    dcategory character varying(255) COLLATE pg_catalog."default",
    cureid bigint,
    CONSTRAINT diseases_pkey PRIMARY KEY (idd)
);

CREATE TABLE IF NOT EXISTS public.heart_rate_record
(
    hrrid bigint NOT NULL,
    puidh bigint NOT NULL,
    timesr date NOT NULL,
    CONSTRAINT heart_rate_record_pkey PRIMARY KEY (hrrid)
);

CREATE TABLE IF NOT EXISTS public.med
(
    mid bigint NOT NULL,
    mname character varying(255) COLLATE pg_catalog."default",
    sname character varying(255) COLLATE pg_catalog."default",
    mtype character varying(255) COLLATE pg_catalog."default",
    mcategory character varying(255) COLLATE pg_catalog."default",
    cureid bigint,
    CONSTRAINT med_pkey PRIMARY KEY (mid)
);

CREATE TABLE IF NOT EXISTS public.med_record
(
    mrid bigint NOT NULL,
    dt date NOT NULL,
    dq date,
    puidm bigint NOT NULL,
    duid bigint NOT NULL,
    mid bigint,
    CONSTRAINT med_record_pkey PRIMARY KEY (mrid)
);

CREATE TABLE IF NOT EXISTS public.users
(
    uid bigint NOT NULL,
    ucd timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    cardid bigint NOT NULL,
    dateb date NOT NULL,
    dated date,
    name character varying(255) COLLATE pg_catalog."default",
    address character varying(255) COLLATE pg_catalog."default",
    urole character varying(50) COLLATE pg_catalog."default",
    mrid bigint,
    drid bigint,
    hrrid bigint,
    CONSTRAINT users_pkey PRIMARY KEY (uid)
);

ALTER TABLE IF EXISTS public.disease_meds
    ADD CONSTRAINT diseaseid FOREIGN KEY (diseaseid)
    REFERENCES public.diseases (idd) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.disease_meds
    ADD CONSTRAINT midid FOREIGN KEY (medid)
    REFERENCES public.med (mid) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.disease_record
    ADD CONSTRAINT disease_record_idd_fkey FOREIGN KEY (idd)
    REFERENCES public.diseases (idd) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.disease_record
    ADD CONSTRAINT disease_record_puidd_fkey FOREIGN KEY (puidd)
    REFERENCES public.users (uid) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.disease_record
    ADD CONSTRAINT puidd FOREIGN KEY (puidd)
    REFERENCES public.users (uid) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.diseases
    ADD CONSTRAINT diseases_cureid_fkey FOREIGN KEY (cureid)
    REFERENCES public.med (mid) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.heart_rate_record
    ADD CONSTRAINT puidh FOREIGN KEY (puidh)
    REFERENCES public.users (uid) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.med_record
    ADD CONSTRAINT duid FOREIGN KEY (duid)
    REFERENCES public.users (uid) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.med_record
    ADD CONSTRAINT puidm FOREIGN KEY (puidm)
    REFERENCES public.users (uid) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.users
    ADD CONSTRAINT drid FOREIGN KEY (drid)
    REFERENCES public.disease_record (drid) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.users
    ADD CONSTRAINT hrrid FOREIGN KEY (hrrid)
    REFERENCES public.heart_rate_record (hrrid) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.users
    ADD CONSTRAINT mrid FOREIGN KEY (mrid)
    REFERENCES public.med_record (mrid) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

END;