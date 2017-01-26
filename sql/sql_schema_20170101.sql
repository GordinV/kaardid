--
-- PostgreSQL database dump
--

-- Dumped from database version 8.4.5
-- Dumped by pg_dump version 9.4.0
-- Started on 2017-01-26 23:29:30

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 1816 (class 1262 OID 16455)
-- Name: kaardid; Type: DATABASE; Schema: -; Owner: vlad
--

CREATE DATABASE kaardid WITH TEMPLATE = template0 ENCODING = 'SQL_ASCII' LC_COLLATE = 'Estonian_Estonia.1257' LC_CTYPE = 'Estonian_Estonia.1257';


ALTER DATABASE kaardid OWNER TO vlad;

\connect kaardid

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 469 (class 2612 OID 54653)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE OR REPLACE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- TOC entry 177 (class 1255 OID 54654)
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
-- TOC entry 156 (class 1255 OID 54655)
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
-- TOC entry 178 (class 1255 OID 54656)
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
-- TOC entry 179 (class 1255 OID 54657)
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
-- TOC entry 172 (class 1255 OID 54658)
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
-- TOC entry 173 (class 1255 OID 54659)
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
-- TOC entry 175 (class 1255 OID 54663)
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
-- TOC entry 169 (class 1255 OID 54662)
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
-- TOC entry 168 (class 1255 OID 54661)
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
-- TOC entry 174 (class 1255 OID 54660)
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
-- TOC entry 176 (class 1255 OID 54664)
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
-- TOC entry 165 (class 1255 OID 54666)
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
-- TOC entry 166 (class 1255 OID 54667)
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
-- TOC entry 167 (class 1255 OID 54668)
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
-- TOC entry 164 (class 1255 OID 54665)
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
-- TOC entry 170 (class 1255 OID 54669)
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
-- TOC entry 171 (class 1255 OID 54670)
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
-- TOC entry 160 (class 1255 OID 54671)
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
-- TOC entry 161 (class 1255 OID 54672)
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
-- TOC entry 180 (class 1255 OID 54673)
-- Name: plpgsql_call_handler(); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION plpgsql_call_handler() RETURNS language_handler
    LANGUAGE c
    AS '$libdir/plpgsql', 'plpgsql_call_handler';


ALTER FUNCTION public.plpgsql_call_handler() OWNER TO vlad;

--
-- TOC entry 162 (class 1255 OID 54674)
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

--
-- TOC entry 163 (class 1255 OID 54675)
-- Name: sp_salvesta_kaardid(integer, date, character varying, text, character varying, character varying); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION sp_salvesta_kaardid(integer, date, character varying, text, character varying, character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $_$

declare
	tnid alias for $1;
	tdkpv alias for $2;
	tcLuno alias for $3;
	ttmuud alias for $4;
	tcNumber alias for $5;
	tcOmanik alias for $6;

	lnId int; 

begin

if tnId = 0 then
	-- uus kiri
	insert into kaardid (kpv, luno, number, omanik, muud) 
		values (tdkpv, tcluno, tcnumber, tcomanik, ttmuud);

	lnId:= cast(CURRVAL('public.kaardid_id_seq') as int4);

end if;



         return  lnId;
end;$_$;


ALTER FUNCTION public.sp_salvesta_kaardid(integer, date, character varying, text, character varying, character varying) OWNER TO vlad;

--
-- TOC entry 154 (class 1255 OID 54676)
-- Name: space(integer); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION space(integer) RETURNS character
    LANGUAGE plpgsql
    AS $_$
begin
         return  lpad(chr(32),$1);
end; 
$_$;


ALTER FUNCTION public.space(integer) OWNER TO vlad;

--
-- TOC entry 155 (class 1255 OID 54677)
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
-- TOC entry 157 (class 1255 OID 54678)
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
-- TOC entry 158 (class 1255 OID 54679)
-- Name: val(character varying); Type: FUNCTION; Schema: public; Owner: vlad
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
-- TOC entry 159 (class 1255 OID 54680)
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
-- TOC entry 1174 (class 2617 OID 54681)
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

SET default_with_oids = false;

--
-- TOC entry 140 (class 1259 OID 54682)
-- Name: kaardid; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE kaardid (
    id integer NOT NULL,
    kpv date DEFAULT ('now'::text)::date,
    luno character(20) DEFAULT 'FRX00000'::bpchar NOT NULL,
    kasutaja character(254) DEFAULT ("current_user"())::character varying NOT NULL,
    uleantud date,
    vastuvotja character(254),
    muud text,
    "timestamp" timestamp without time zone DEFAULT now(),
    number character varying(40),
    omanik character varying(254) NOT NULL
);


ALTER TABLE kaardid OWNER TO vlad;

--
-- TOC entry 141 (class 1259 OID 54692)
-- Name: kaardid_id_seq; Type: SEQUENCE; Schema: public; Owner: vlad
--

CREATE SEQUENCE kaardid_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE kaardid_id_seq OWNER TO vlad;

--
-- TOC entry 1846 (class 0 OID 0)
-- Dependencies: 141
-- Name: kaardid_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vlad
--

ALTER SEQUENCE kaardid_id_seq OWNED BY kaardid.id;


--
-- TOC entry 1719 (class 2604 OID 54694)
-- Name: id; Type: DEFAULT; Schema: public; Owner: vlad
--

ALTER TABLE ONLY kaardid ALTER COLUMN id SET DEFAULT nextval('kaardid_id_seq'::regclass);


--
-- TOC entry 1725 (class 2606 OID 54696)
-- Name: kaardid_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY kaardid
    ADD CONSTRAINT kaardid_pkey PRIMARY KEY (id);


--
-- TOC entry 1720 (class 1259 OID 3942614)
-- Name: idx_ule; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX idx_ule ON kaardid USING btree (uleantud);


--
-- TOC entry 1721 (class 1259 OID 3942620)
-- Name: idx_user; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX idx_user ON kaardid USING btree (kasutaja);


--
-- TOC entry 1722 (class 1259 OID 54697)
-- Name: kaardid_kpv; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX kaardid_kpv ON kaardid USING btree (kpv);


--
-- TOC entry 1723 (class 1259 OID 54698)
-- Name: kaardid_luno; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX kaardid_luno ON kaardid USING btree (luno);


--
-- TOC entry 1818 (class 0 OID 0)
-- Dependencies: 3
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 1819 (class 0 OID 0)
-- Dependencies: 177
-- Name: char_add(character, character); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION char_add(character, character) FROM PUBLIC;
REVOKE ALL ON FUNCTION char_add(character, character) FROM vlad;
GRANT ALL ON FUNCTION char_add(character, character) TO vlad;
GRANT ALL ON FUNCTION char_add(character, character) TO PUBLIC;
GRANT ALL ON FUNCTION char_add(character, character) TO "BS2";


--
-- TOC entry 1820 (class 0 OID 0)
-- Dependencies: 156
-- Name: date(); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION date() FROM PUBLIC;
REVOKE ALL ON FUNCTION date() FROM vlad;
GRANT ALL ON FUNCTION date() TO vlad;
GRANT ALL ON FUNCTION date() TO PUBLIC;
GRANT ALL ON FUNCTION date() TO "BS2";


--
-- TOC entry 1821 (class 0 OID 0)
-- Dependencies: 178
-- Name: date(integer, integer, integer); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION date(integer, integer, integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION date(integer, integer, integer) FROM vlad;
GRANT ALL ON FUNCTION date(integer, integer, integer) TO vlad;
GRANT ALL ON FUNCTION date(integer, integer, integer) TO PUBLIC;
GRANT ALL ON FUNCTION date(integer, integer, integer) TO "BS2";


--
-- TOC entry 1822 (class 0 OID 0)
-- Dependencies: 179
-- Name: day(date); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION day(date) FROM PUBLIC;
REVOKE ALL ON FUNCTION day(date) FROM vlad;
GRANT ALL ON FUNCTION day(date) TO vlad;
GRANT ALL ON FUNCTION day(date) TO PUBLIC;
GRANT ALL ON FUNCTION day(date) TO "BS2";


--
-- TOC entry 1823 (class 0 OID 0)
-- Dependencies: 172
-- Name: dow(date); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION dow(date) FROM PUBLIC;
REVOKE ALL ON FUNCTION dow(date) FROM vlad;
GRANT ALL ON FUNCTION dow(date) TO vlad;
GRANT ALL ON FUNCTION dow(date) TO PUBLIC;
GRANT ALL ON FUNCTION dow(date) TO "BS2";


--
-- TOC entry 1824 (class 0 OID 0)
-- Dependencies: 173
-- Name: dtoc(date); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION dtoc(date) FROM PUBLIC;
REVOKE ALL ON FUNCTION dtoc(date) FROM vlad;
GRANT ALL ON FUNCTION dtoc(date) TO vlad;
GRANT ALL ON FUNCTION dtoc(date) TO PUBLIC;
GRANT ALL ON FUNCTION dtoc(date) TO "BS2";


--
-- TOC entry 1825 (class 0 OID 0)
-- Dependencies: 175
-- Name: empty(character varying); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION empty(character varying) FROM PUBLIC;
REVOKE ALL ON FUNCTION empty(character varying) FROM vlad;
GRANT ALL ON FUNCTION empty(character varying) TO vlad;
GRANT ALL ON FUNCTION empty(character varying) TO PUBLIC;
GRANT ALL ON FUNCTION empty(character varying) TO "BS2";


--
-- TOC entry 1826 (class 0 OID 0)
-- Dependencies: 169
-- Name: empty(date); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION empty(date) FROM PUBLIC;
REVOKE ALL ON FUNCTION empty(date) FROM vlad;
GRANT ALL ON FUNCTION empty(date) TO vlad;
GRANT ALL ON FUNCTION empty(date) TO PUBLIC;
GRANT ALL ON FUNCTION empty(date) TO "BS2";


--
-- TOC entry 1827 (class 0 OID 0)
-- Dependencies: 168
-- Name: empty(integer); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION empty(integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION empty(integer) FROM vlad;
GRANT ALL ON FUNCTION empty(integer) TO vlad;
GRANT ALL ON FUNCTION empty(integer) TO PUBLIC;
GRANT ALL ON FUNCTION empty(integer) TO "BS2";


--
-- TOC entry 1828 (class 0 OID 0)
-- Dependencies: 174
-- Name: empty(numeric); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION empty(numeric) FROM PUBLIC;
REVOKE ALL ON FUNCTION empty(numeric) FROM vlad;
GRANT ALL ON FUNCTION empty(numeric) TO vlad;
GRANT ALL ON FUNCTION empty(numeric) TO PUBLIC;
GRANT ALL ON FUNCTION empty(numeric) TO "BS2";


--
-- TOC entry 1829 (class 0 OID 0)
-- Dependencies: 176
-- Name: gomonth(date, integer); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION gomonth(date, integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION gomonth(date, integer) FROM vlad;
GRANT ALL ON FUNCTION gomonth(date, integer) TO vlad;
GRANT ALL ON FUNCTION gomonth(date, integer) TO PUBLIC;
GRANT ALL ON FUNCTION gomonth(date, integer) TO "BS2";


--
-- TOC entry 1830 (class 0 OID 0)
-- Dependencies: 165
-- Name: ifnull(character, character); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION ifnull(character, character) FROM PUBLIC;
REVOKE ALL ON FUNCTION ifnull(character, character) FROM vlad;
GRANT ALL ON FUNCTION ifnull(character, character) TO vlad;
GRANT ALL ON FUNCTION ifnull(character, character) TO PUBLIC;
GRANT ALL ON FUNCTION ifnull(character, character) TO "BS2";


--
-- TOC entry 1831 (class 0 OID 0)
-- Dependencies: 166
-- Name: ifnull(date, date); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION ifnull(date, date) FROM PUBLIC;
REVOKE ALL ON FUNCTION ifnull(date, date) FROM vlad;
GRANT ALL ON FUNCTION ifnull(date, date) TO vlad;
GRANT ALL ON FUNCTION ifnull(date, date) TO PUBLIC;
GRANT ALL ON FUNCTION ifnull(date, date) TO "BS2";


--
-- TOC entry 1832 (class 0 OID 0)
-- Dependencies: 167
-- Name: ifnull(integer, integer); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION ifnull(integer, integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION ifnull(integer, integer) FROM vlad;
GRANT ALL ON FUNCTION ifnull(integer, integer) TO vlad;
GRANT ALL ON FUNCTION ifnull(integer, integer) TO PUBLIC;
GRANT ALL ON FUNCTION ifnull(integer, integer) TO "BS2";


--
-- TOC entry 1833 (class 0 OID 0)
-- Dependencies: 164
-- Name: ifnull(numeric, numeric); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION ifnull(numeric, numeric) FROM PUBLIC;
REVOKE ALL ON FUNCTION ifnull(numeric, numeric) FROM vlad;
GRANT ALL ON FUNCTION ifnull(numeric, numeric) TO vlad;
GRANT ALL ON FUNCTION ifnull(numeric, numeric) TO PUBLIC;
GRANT ALL ON FUNCTION ifnull(numeric, numeric) TO "BS2";


--
-- TOC entry 1834 (class 0 OID 0)
-- Dependencies: 170
-- Name: left(character, integer); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION "left"(character, integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION "left"(character, integer) FROM vlad;
GRANT ALL ON FUNCTION "left"(character, integer) TO vlad;
GRANT ALL ON FUNCTION "left"(character, integer) TO PUBLIC;
GRANT ALL ON FUNCTION "left"(character, integer) TO "BS2";


--
-- TOC entry 1835 (class 0 OID 0)
-- Dependencies: 171
-- Name: len(character varying); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION len(character varying) FROM PUBLIC;
REVOKE ALL ON FUNCTION len(character varying) FROM vlad;
GRANT ALL ON FUNCTION len(character varying) TO vlad;
GRANT ALL ON FUNCTION len(character varying) TO PUBLIC;
GRANT ALL ON FUNCTION len(character varying) TO "BS2";


--
-- TOC entry 1836 (class 0 OID 0)
-- Dependencies: 160
-- Name: ltrim(character); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION ltrim(character) FROM PUBLIC;
REVOKE ALL ON FUNCTION ltrim(character) FROM vlad;
GRANT ALL ON FUNCTION ltrim(character) TO vlad;
GRANT ALL ON FUNCTION ltrim(character) TO PUBLIC;
GRANT ALL ON FUNCTION ltrim(character) TO "BS2";


--
-- TOC entry 1837 (class 0 OID 0)
-- Dependencies: 161
-- Name: month(date); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION month(date) FROM PUBLIC;
REVOKE ALL ON FUNCTION month(date) FROM vlad;
GRANT ALL ON FUNCTION month(date) TO vlad;
GRANT ALL ON FUNCTION month(date) TO PUBLIC;
GRANT ALL ON FUNCTION month(date) TO "BS2";


--
-- TOC entry 1838 (class 0 OID 0)
-- Dependencies: 162
-- Name: rtrim(character); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION rtrim(character) FROM PUBLIC;
REVOKE ALL ON FUNCTION rtrim(character) FROM vlad;
GRANT ALL ON FUNCTION rtrim(character) TO vlad;
GRANT ALL ON FUNCTION rtrim(character) TO PUBLIC;
GRANT ALL ON FUNCTION rtrim(character) TO "BS2";


--
-- TOC entry 1839 (class 0 OID 0)
-- Dependencies: 163
-- Name: sp_salvesta_kaardid(integer, date, character varying, text, character varying, character varying); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION sp_salvesta_kaardid(integer, date, character varying, text, character varying, character varying) FROM PUBLIC;
REVOKE ALL ON FUNCTION sp_salvesta_kaardid(integer, date, character varying, text, character varying, character varying) FROM vlad;
GRANT ALL ON FUNCTION sp_salvesta_kaardid(integer, date, character varying, text, character varying, character varying) TO vlad;
GRANT ALL ON FUNCTION sp_salvesta_kaardid(integer, date, character varying, text, character varying, character varying) TO PUBLIC;
GRANT ALL ON FUNCTION sp_salvesta_kaardid(integer, date, character varying, text, character varying, character varying) TO "BS2";


--
-- TOC entry 1840 (class 0 OID 0)
-- Dependencies: 154
-- Name: space(integer); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION space(integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION space(integer) FROM vlad;
GRANT ALL ON FUNCTION space(integer) TO vlad;
GRANT ALL ON FUNCTION space(integer) TO PUBLIC;
GRANT ALL ON FUNCTION space(integer) TO "BS2";


--
-- TOC entry 1841 (class 0 OID 0)
-- Dependencies: 155
-- Name: str(integer); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION str(integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION str(integer) FROM vlad;
GRANT ALL ON FUNCTION str(integer) TO vlad;
GRANT ALL ON FUNCTION str(integer) TO PUBLIC;
GRANT ALL ON FUNCTION str(integer) TO "BS2";


--
-- TOC entry 1842 (class 0 OID 0)
-- Dependencies: 157
-- Name: str(integer, integer); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION str(integer, integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION str(integer, integer) FROM vlad;
GRANT ALL ON FUNCTION str(integer, integer) TO vlad;
GRANT ALL ON FUNCTION str(integer, integer) TO PUBLIC;
GRANT ALL ON FUNCTION str(integer, integer) TO "BS2";


--
-- TOC entry 1843 (class 0 OID 0)
-- Dependencies: 158
-- Name: val(character varying); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION val(character varying) FROM PUBLIC;
REVOKE ALL ON FUNCTION val(character varying) FROM vlad;
GRANT ALL ON FUNCTION val(character varying) TO vlad;
GRANT ALL ON FUNCTION val(character varying) TO PUBLIC;
GRANT ALL ON FUNCTION val(character varying) TO "BS2";


--
-- TOC entry 1844 (class 0 OID 0)
-- Dependencies: 159
-- Name: year(date); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION year(date) FROM PUBLIC;
REVOKE ALL ON FUNCTION year(date) FROM vlad;
GRANT ALL ON FUNCTION year(date) TO vlad;
GRANT ALL ON FUNCTION year(date) TO PUBLIC;
GRANT ALL ON FUNCTION year(date) TO "BS2";


--
-- TOC entry 1845 (class 0 OID 0)
-- Dependencies: 140
-- Name: kaardid; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON TABLE kaardid FROM PUBLIC;
REVOKE ALL ON TABLE kaardid FROM vlad;
GRANT ALL ON TABLE kaardid TO vlad;
GRANT ALL ON TABLE kaardid TO "BS2";


--
-- TOC entry 1847 (class 0 OID 0)
-- Dependencies: 141
-- Name: kaardid_id_seq; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON SEQUENCE kaardid_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE kaardid_id_seq FROM vlad;
GRANT ALL ON SEQUENCE kaardid_id_seq TO vlad;
GRANT ALL ON SEQUENCE kaardid_id_seq TO "BS2";


-- Completed on 2017-01-26 23:29:41

--
-- PostgreSQL database dump complete
--

