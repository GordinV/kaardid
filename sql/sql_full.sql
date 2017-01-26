
SET statement_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

CREATE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- TOC entry 44 (class 1255 OID 35286)
-- Dependencies: 6 388
-- Name: char_add(character, character); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION char_add(character, character) RETURNS character
    LANGUAGE plpgsql
    AS $_$
begin
         return  $1||$2;
end; 
$_$;


ALTER FUNCTION public.char_add(character, character) OWNER TO vlad;

--
-- TOC entry 45 (class 1255 OID 35287)
-- Dependencies: 6 388
-- Name: date(); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION date() RETURNS date
    LANGUAGE plpgsql
    AS $$
begin
         return  current_date;
end; 
$$;


ALTER FUNCTION public.date() OWNER TO vlad;

--
-- TOC entry 46 (class 1255 OID 35288)
-- Dependencies: 6 388
-- Name: date(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION date(integer, integer, integer) RETURNS date
    LANGUAGE plpgsql
    AS $_$

declare 

	tnYear alias for $1;

	tnMonth alias for $2;

	tnDay alias for $3;
	lcYear varchar(4);

	lcMonth varchar(2);

	lcDay varchar(2);

begin
	if tnYear = 0 or tnMonth = 0 or tnDay = 0 then
		return null;
	end if;


	lcYear := str(tnYear,4);

	if tnMonth < 10 then

		lcMonth := '0'+str(tnMonth,1);

	else

		lcMonth:= str(tnMonth,2);

	end if;

	if tnDay < 10 then

		lcDay := '0'+str(tnDay,1);

	else

		lcDay:= str(tnday,2);

	end if;

         return  to_date(lcYear+lcMonth+lcDay,'YYYYMMDD');
end; 
$_$;


ALTER FUNCTION public.date(integer, integer, integer) OWNER TO vlad;

--
-- TOC entry 47 (class 1255 OID 35289)
-- Dependencies: 6 388
-- Name: day(date); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION day(date) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
begin
         return  datepart("day",$1)
end; 
$_$;


ALTER FUNCTION public.day(date) OWNER TO vlad;

--
-- TOC entry 48 (class 1255 OID 35290)
-- Dependencies: 6 388
-- Name: dow(date); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION dow(date) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
begin
         return  date_part ('DOW', $1);
end; 
$_$;


ALTER FUNCTION public.dow(date) OWNER TO vlad;

--
-- TOC entry 49 (class 1255 OID 35291)
-- Dependencies: 6 388
-- Name: dtoc(date); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION dtoc(date) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
declare
       lcString varchar;
begin
     return to_char($1,'DD.MM.YYYY')::varchar;
end;
$_$;


ALTER FUNCTION public.dtoc(date) OWNER TO vlad;

--
-- TOC entry 50 (class 1255 OID 35292)
-- Dependencies: 6 388
-- Name: empty(numeric); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION empty(numeric) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
begin
	if $1 is null or $1 = 0 then
		return true;
	else
		return false;
	end if;
end;
$_$;


ALTER FUNCTION public.empty(numeric) OWNER TO vlad;

--
-- TOC entry 51 (class 1255 OID 35293)
-- Dependencies: 6 388
-- Name: empty(integer); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION empty(integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
begin
	if $1 is null or $1 = 0 then
		return true;
	else
		return false;
	end if;
end;
$_$;


ALTER FUNCTION public.empty(integer) OWNER TO vlad;

--
-- TOC entry 52 (class 1255 OID 35294)
-- Dependencies: 6 388
-- Name: empty(date); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION empty(date) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
begin
	if $1 is null or $1 <  year (now()::date)-100 then
		return true;
	else
		return false;
	end if;
end;
$_$;


ALTER FUNCTION public.empty(date) OWNER TO vlad;

--
-- TOC entry 53 (class 1255 OID 35295)
-- Dependencies: 6 388
-- Name: empty(character varying); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION empty(character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $_$
begin
	if $1 is null or len(ltrim(rtrim($1))) < 1 then
		return true;
	else
		return false;
	end if;
end;
$_$;


ALTER FUNCTION public.empty(character varying) OWNER TO vlad;

--
-- TOC entry 54 (class 1255 OID 35296)
-- Dependencies: 6 388
-- Name: gomonth(date, integer); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION gomonth(date, integer) RETURNS date
    LANGUAGE plpgsql
    AS $_$
declare
	tdKpv alias for $1;
	tnPeriod alias for $2;
	lnYear int;
	lnMonth int;
	lnDay int;
	lnCount int2;
begin
	lnDay := day(tdKpv);
	lnMonth := month(tdKpv) + tnPeriod;
	if lnMonth > 12 then
		lnCount:= lnMonth / 12 ::int2;
		lnMonth := lnMonth - 12 * lnCount;
		lnYear := YEAR(tdKpv) + lnCount;
	else
		lnYear := YEAR(tdKpv);
	end if;
         return  date(lnYear,lnMonth,lnDay);
end; 
$_$;


ALTER FUNCTION public.gomonth(date, integer) OWNER TO vlad;

--
-- TOC entry 55 (class 1255 OID 35297)
-- Dependencies: 6 388
-- Name: ifnull(numeric, numeric); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION ifnull(numeric, numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
begin
	if $1 isnull then
		 return  $2;
	else
		return $1;
	end if;
end; 
$_$;


ALTER FUNCTION public.ifnull(numeric, numeric) OWNER TO vlad;

--
-- TOC entry 56 (class 1255 OID 35298)
-- Dependencies: 6 388
-- Name: ifnull(character, character); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION ifnull(character, character) RETURNS character
    LANGUAGE plpgsql
    AS $_$
begin
	if $1 is null then
		 return  $2;
	else
		 return  $1;
			
	end if;
end; 
$_$;


ALTER FUNCTION public.ifnull(character, character) OWNER TO vlad;

--
-- TOC entry 57 (class 1255 OID 35299)
-- Dependencies: 6 388
-- Name: ifnull(date, date); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION ifnull(date, date) RETURNS date
    LANGUAGE plpgsql
    AS $_$
begin
	if $1 is null then
		 return  $2;
	else
		 return  $1;
	end if;
end; 
$_$;


ALTER FUNCTION public.ifnull(date, date) OWNER TO vlad;

--
-- TOC entry 58 (class 1255 OID 35300)
-- Dependencies: 6 388
-- Name: ifnull(integer, integer); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION ifnull(integer, integer) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
begin
	if $1 isnull then
		 return  $2;
	else
		return $1;
	end if;
end; 
$_$;


ALTER FUNCTION public.ifnull(integer, integer) OWNER TO vlad;

--
-- TOC entry 59 (class 1255 OID 35301)
-- Dependencies: 6 388
-- Name: left(character, integer); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION "left"(character, integer) RETURNS character
    LANGUAGE plpgsql
    AS $_$
begin
         return  lpad($1,$2);
end; 
$_$;


ALTER FUNCTION public."left"(character, integer) OWNER TO vlad;

--
-- TOC entry 60 (class 1255 OID 35302)
-- Dependencies: 388 6
-- Name: len(character varying); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION len(character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
begin
		return char_length($1);
end; 
$_$;


ALTER FUNCTION public.len(character varying) OWNER TO vlad;

--
-- TOC entry 61 (class 1255 OID 35303)
-- Dependencies: 388 6
-- Name: ltrim(character); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION ltrim(character) RETURNS character
    LANGUAGE plpgsql
    AS $_$
begin
         return  trim(leading chr(32) from $1);
end; 
$_$;


ALTER FUNCTION public.ltrim(character) OWNER TO vlad;

--
-- TOC entry 62 (class 1255 OID 35304)
-- Dependencies: 6 388
-- Name: month(date); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION month(date) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
begin
         return  datepart("month",$1)
end; 
$_$;


ALTER FUNCTION public.month(date) OWNER TO vlad;

--
-- TOC entry 63 (class 1255 OID 35305)
-- Dependencies: 6
-- Name: plpgsql_call_handler(); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION plpgsql_call_handler() RETURNS language_handler
    LANGUAGE c
    AS '$libdir/plpgsql', 'plpgsql_call_handler';


ALTER FUNCTION public.plpgsql_call_handler() OWNER TO vlad;

--
-- TOC entry 64 (class 1255 OID 35306)
-- Dependencies: 6 388
-- Name: rtrim(character); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION rtrim(character) RETURNS character
    LANGUAGE plpgsql
    AS $_$
begin
         return  trim(trailing chr(32) from $1);
end; 
$_$;


ALTER FUNCTION public.rtrim(character) OWNER TO vlad;


CREATE FUNCTION space(integer) RETURNS character
    LANGUAGE plpgsql
    AS $_$
begin
         return  lpad(chr(32),$1);
end; 
$_$;


ALTER FUNCTION public.space(integer) OWNER TO vlad;

--
-- TOC entry 83 (class 1255 OID 35325)
-- Dependencies: 6 388
-- Name: str(integer); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION str(integer) RETURNS character
    LANGUAGE plpgsql
    AS $_$
begin
         return  to_char($1);
end; 
$_$;


ALTER FUNCTION public.str(integer) OWNER TO vlad;

--
-- TOC entry 84 (class 1255 OID 35326)
-- Dependencies: 6 388
-- Name: str(integer, integer); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION str(integer, integer) RETURNS character
    LANGUAGE plpgsql
    AS $_$
begin
         return  left(ltrim(rtrim(cast($1 as bpchar))),$2);
end; 
$_$;


ALTER FUNCTION public.str(integer, integer) OWNER TO vlad;

--
-- TOC entry 20 (class 1255 OID 35327)
-- Dependencies: 388 6
-- Name: trigd1_isik_after(); Type: FUNCTION; Schema: public; Owner: vlad
--


CREATE FUNCTION val(character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
begin
         return  ltrim($1)::int;
end; 
$_$;


ALTER FUNCTION public.val(character varying) OWNER TO vlad;

--
-- TOC entry 86 (class 1255 OID 35352)
-- Dependencies: 388 6
-- Name: year(date); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION year(date) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
begin
     
         return  cast(extract(year from $1) as int);
end; 
$_$;


ALTER FUNCTION public.year(date) OWNER TO vlad;

--
-- TOC entry 1091 (class 2617 OID 35353)
-- Dependencies: 44 6
-- Name: +; Type: OPERATOR; Schema: public; Owner: vlad
--

CREATE OPERATOR + (
    PROCEDURE = char_add,
    LEFTARG = character,
    RIGHTARG = character,
    COMMUTATOR = +
);


ALTER OPERATOR public.+ (character, character) OWNER TO vlad;

SET default_tablespace = '';

SET default_with_oids = true;



CREATE TABLE kaardid
(
  id serial NOT NULL,
  kpv date default current_date,
  luno character(20) NOT NULL DEFAULT 'FRX00000',
  kasutaja character(254) NOT NULL DEFAULT CURRENT_USER::VARCHAR,
  uleantud date,
  vastuvotja character(254),
  muud text,
  timestamp timestamp without time zone default current_timestamp,
  CONSTRAINT kaardid_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE kaardid OWNER TO vlad;
GRANT ALL ON TABLE kaardid TO vlad;
--GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE kaardid TO GROUP BS2;


CREATE INDEX kaardid_luno
  ON kaardid
  USING btree
  (luno);

-- Index: konto

-- DROP INDEX konto;

CREATE INDEX kaardid_kpv
  ON kaardid
  USING btree
  (kpv);



