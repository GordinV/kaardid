--
-- PostgreSQL database dump
--

-- Started on 2010-09-04 00:54:43

SET statement_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 521 (class 2612 OID 16386)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- TOC entry 387 (class 0 OID 0)
-- Name: intbig_gkey; Type: SHELL TYPE; Schema: public; Owner: vlad
--

CREATE TYPE intbig_gkey;


--
-- TOC entry 19 (class 1255 OID 64287)
-- Dependencies: 6 387
-- Name: _intbig_in(cstring); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION _intbig_in(cstring) RETURNS intbig_gkey
    LANGUAGE c STRICT
    AS '$libdir/_int', '_intbig_in';


ALTER FUNCTION public._intbig_in(cstring) OWNER TO vlad;

--
-- TOC entry 20 (class 1255 OID 64288)
-- Dependencies: 6 387
-- Name: _intbig_out(intbig_gkey); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION _intbig_out(intbig_gkey) RETURNS cstring
    LANGUAGE c STRICT
    AS '$libdir/_int', '_intbig_out';


ALTER FUNCTION public._intbig_out(intbig_gkey) OWNER TO vlad;

--
-- TOC entry 386 (class 1247 OID 64286)
-- Dependencies: 20 19 6
-- Name: intbig_gkey; Type: TYPE; Schema: public; Owner: vlad
--

CREATE TYPE intbig_gkey (
    INTERNALLENGTH = variable,
    INPUT = _intbig_in,
    OUTPUT = _intbig_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.intbig_gkey OWNER TO vlad;

--
-- TOC entry 393 (class 1247 OID 64300)
-- Dependencies: 6
-- Name: lo; Type: DOMAIN; Schema: public; Owner: vlad
--

CREATE DOMAIN lo AS oid;


ALTER DOMAIN public.lo OWNER TO vlad;

--
-- TOC entry 391 (class 0 OID 0)
-- Name: query_int; Type: SHELL TYPE; Schema: public; Owner: vlad
--

CREATE TYPE query_int;


--
-- TOC entry 21 (class 1255 OID 64291)
-- Dependencies: 6 391
-- Name: bqarr_in(cstring); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION bqarr_in(cstring) RETURNS query_int
    LANGUAGE c STRICT
    AS '$libdir/_int', 'bqarr_in';


ALTER FUNCTION public.bqarr_in(cstring) OWNER TO vlad;

--
-- TOC entry 22 (class 1255 OID 64292)
-- Dependencies: 6 391
-- Name: bqarr_out(query_int); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION bqarr_out(query_int) RETURNS cstring
    LANGUAGE c STRICT
    AS '$libdir/_int', 'bqarr_out';


ALTER FUNCTION public.bqarr_out(query_int) OWNER TO vlad;

--
-- TOC entry 390 (class 1247 OID 64290)
-- Dependencies: 22 21 6
-- Name: query_int; Type: TYPE; Schema: public; Owner: vlad
--

CREATE TYPE query_int (
    INTERNALLENGTH = variable,
    INPUT = bqarr_in,
    OUTPUT = bqarr_out,
    ALIGNMENT = int4,
    STORAGE = plain
);


ALTER TYPE public.query_int OWNER TO vlad;

--
-- TOC entry 394 (class 1247 OID 64303)
-- Dependencies: 6 1732
-- Name: statinfo; Type: TYPE; Schema: public; Owner: vlad
--

CREATE TYPE statinfo AS (
	word text,
	ndoc integer,
	nentry integer
);


ALTER TYPE public.statinfo OWNER TO vlad;

--
-- TOC entry 396 (class 1247 OID 64306)
-- Dependencies: 6 1733
-- Name: tokenout; Type: TYPE; Schema: public; Owner: vlad
--

CREATE TYPE tokenout AS (
	tokid integer,
	token text
);


ALTER TYPE public.tokenout OWNER TO vlad;

--
-- TOC entry 398 (class 1247 OID 64309)
-- Dependencies: 6 1734
-- Name: tokentype; Type: TYPE; Schema: public; Owner: vlad
--

CREATE TYPE tokentype AS (
	tokid integer,
	alias text,
	descr text
);


ALTER TYPE public.tokentype OWNER TO vlad;

--
-- TOC entry 400 (class 1247 OID 64312)
-- Dependencies: 6 1735
-- Name: tsdebug; Type: TYPE; Schema: public; Owner: vlad
--

CREATE TYPE tsdebug AS (
	ts_name text,
	tok_type text,
	description text,
	token text,
	dict_name text[],
	tsvector tsvector
);


ALTER TYPE public.tsdebug OWNER TO vlad;

--
-- TOC entry 23 (class 1255 OID 64313)
-- Dependencies: 6
-- Name: _get_parser_from_curcfg(); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION _get_parser_from_curcfg() RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$ select prs_name from pg_ts_cfg where oid = show_curcfg() $$;


ALTER FUNCTION public._get_parser_from_curcfg() OWNER TO vlad;

--
-- TOC entry 24 (class 1255 OID 64314)
-- Dependencies: 6
-- Name: _int_contained(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION _int_contained(integer[], integer[]) RETURNS boolean
    LANGUAGE c STRICT
    AS '$libdir/_int', '_int_contained';


ALTER FUNCTION public._int_contained(integer[], integer[]) OWNER TO vlad;

--
-- TOC entry 2302 (class 0 OID 0)
-- Dependencies: 24
-- Name: FUNCTION _int_contained(integer[], integer[]); Type: COMMENT; Schema: public; Owner: vlad
--

COMMENT ON FUNCTION _int_contained(integer[], integer[]) IS 'contained in';


--
-- TOC entry 25 (class 1255 OID 64315)
-- Dependencies: 6
-- Name: _int_contains(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION _int_contains(integer[], integer[]) RETURNS boolean
    LANGUAGE c STRICT
    AS '$libdir/_int', '_int_contains';


ALTER FUNCTION public._int_contains(integer[], integer[]) OWNER TO vlad;

--
-- TOC entry 2303 (class 0 OID 0)
-- Dependencies: 25
-- Name: FUNCTION _int_contains(integer[], integer[]); Type: COMMENT; Schema: public; Owner: vlad
--

COMMENT ON FUNCTION _int_contains(integer[], integer[]) IS 'contains';


--
-- TOC entry 26 (class 1255 OID 64316)
-- Dependencies: 6
-- Name: _int_different(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION _int_different(integer[], integer[]) RETURNS boolean
    LANGUAGE c STRICT
    AS '$libdir/_int', '_int_different';


ALTER FUNCTION public._int_different(integer[], integer[]) OWNER TO vlad;

--
-- TOC entry 2304 (class 0 OID 0)
-- Dependencies: 26
-- Name: FUNCTION _int_different(integer[], integer[]); Type: COMMENT; Schema: public; Owner: vlad
--

COMMENT ON FUNCTION _int_different(integer[], integer[]) IS 'different';


--
-- TOC entry 27 (class 1255 OID 64317)
-- Dependencies: 6
-- Name: _int_inter(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION _int_inter(integer[], integer[]) RETURNS integer[]
    LANGUAGE c STRICT
    AS '$libdir/_int', '_int_inter';


ALTER FUNCTION public._int_inter(integer[], integer[]) OWNER TO vlad;

--
-- TOC entry 28 (class 1255 OID 64318)
-- Dependencies: 6
-- Name: _int_overlap(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION _int_overlap(integer[], integer[]) RETURNS boolean
    LANGUAGE c STRICT
    AS '$libdir/_int', '_int_overlap';


ALTER FUNCTION public._int_overlap(integer[], integer[]) OWNER TO vlad;

--
-- TOC entry 2305 (class 0 OID 0)
-- Dependencies: 28
-- Name: FUNCTION _int_overlap(integer[], integer[]); Type: COMMENT; Schema: public; Owner: vlad
--

COMMENT ON FUNCTION _int_overlap(integer[], integer[]) IS 'overlaps';


--
-- TOC entry 29 (class 1255 OID 64319)
-- Dependencies: 6
-- Name: _int_same(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION _int_same(integer[], integer[]) RETURNS boolean
    LANGUAGE c STRICT
    AS '$libdir/_int', '_int_same';


ALTER FUNCTION public._int_same(integer[], integer[]) OWNER TO vlad;

--
-- TOC entry 2306 (class 0 OID 0)
-- Dependencies: 29
-- Name: FUNCTION _int_same(integer[], integer[]); Type: COMMENT; Schema: public; Owner: vlad
--

COMMENT ON FUNCTION _int_same(integer[], integer[]) IS 'same as';


--
-- TOC entry 30 (class 1255 OID 64320)
-- Dependencies: 6
-- Name: _int_union(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION _int_union(integer[], integer[]) RETURNS integer[]
    LANGUAGE c STRICT
    AS '$libdir/_int', '_int_union';


ALTER FUNCTION public._int_union(integer[], integer[]) OWNER TO vlad;

--
-- TOC entry 31 (class 1255 OID 64321)
-- Dependencies: 6
-- Name: armor(bytea); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION armor(bytea) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_armor';


ALTER FUNCTION public.armor(bytea) OWNER TO vlad;

--
-- TOC entry 32 (class 1255 OID 64322)
-- Dependencies: 6
-- Name: autoinc(); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION autoinc() RETURNS trigger
    LANGUAGE c
    AS '$libdir/autoinc', 'autoinc';


ALTER FUNCTION public.autoinc() OWNER TO vlad;

--
-- TOC entry 33 (class 1255 OID 64323)
-- Dependencies: 6 390
-- Name: boolop(integer[], query_int); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION boolop(integer[], query_int) RETURNS boolean
    LANGUAGE c STRICT
    AS '$libdir/_int', 'boolop';


ALTER FUNCTION public.boolop(integer[], query_int) OWNER TO vlad;

--
-- TOC entry 2307 (class 0 OID 0)
-- Dependencies: 33
-- Name: FUNCTION boolop(integer[], query_int); Type: COMMENT; Schema: public; Owner: vlad
--

COMMENT ON FUNCTION boolop(integer[], query_int) IS 'boolean operation with array';


--
-- TOC entry 34 (class 1255 OID 64326)
-- Dependencies: 6
-- Name: crypt(text, text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION crypt(text, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_crypt';


ALTER FUNCTION public.crypt(text, text) OWNER TO vlad;

--
-- TOC entry 90 (class 1255 OID 167076)
-- Dependencies: 521 6
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
-- TOC entry 35 (class 1255 OID 64327)
-- Dependencies: 6
-- Name: dearmor(text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION dearmor(text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_dearmor';


ALTER FUNCTION public.dearmor(text) OWNER TO vlad;

--
-- TOC entry 36 (class 1255 OID 64328)
-- Dependencies: 6
-- Name: decrypt(bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION decrypt(bytea, bytea, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_decrypt';


ALTER FUNCTION public.decrypt(bytea, bytea, text) OWNER TO vlad;

--
-- TOC entry 37 (class 1255 OID 64329)
-- Dependencies: 6
-- Name: decrypt_iv(bytea, bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION decrypt_iv(bytea, bytea, bytea, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_decrypt_iv';


ALTER FUNCTION public.decrypt_iv(bytea, bytea, bytea, text) OWNER TO vlad;

--
-- TOC entry 38 (class 1255 OID 64332)
-- Dependencies: 6
-- Name: digest(text, text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION digest(text, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_digest';


ALTER FUNCTION public.digest(text, text) OWNER TO vlad;

--
-- TOC entry 39 (class 1255 OID 64333)
-- Dependencies: 6
-- Name: digest(bytea, text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION digest(bytea, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_digest';


ALTER FUNCTION public.digest(bytea, text) OWNER TO vlad;

--
-- TOC entry 40 (class 1255 OID 64335)
-- Dependencies: 6
-- Name: encrypt(bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION encrypt(bytea, bytea, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_encrypt';


ALTER FUNCTION public.encrypt(bytea, bytea, text) OWNER TO vlad;

--
-- TOC entry 41 (class 1255 OID 64336)
-- Dependencies: 6
-- Name: encrypt_iv(bytea, bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION encrypt_iv(bytea, bytea, bytea, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_encrypt_iv';


ALTER FUNCTION public.encrypt_iv(bytea, bytea, bytea, text) OWNER TO vlad;

--
-- TOC entry 42 (class 1255 OID 64339)
-- Dependencies: 6
-- Name: g_int_compress(internal); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION g_int_compress(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/_int', 'g_int_compress';


ALTER FUNCTION public.g_int_compress(internal) OWNER TO vlad;

--
-- TOC entry 43 (class 1255 OID 64340)
-- Dependencies: 6
-- Name: g_int_consistent(internal, integer[], integer); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION g_int_consistent(internal, integer[], integer) RETURNS boolean
    LANGUAGE c
    AS '$libdir/_int', 'g_int_consistent';


ALTER FUNCTION public.g_int_consistent(internal, integer[], integer) OWNER TO vlad;

--
-- TOC entry 44 (class 1255 OID 64341)
-- Dependencies: 6
-- Name: g_int_decompress(internal); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION g_int_decompress(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/_int', 'g_int_decompress';


ALTER FUNCTION public.g_int_decompress(internal) OWNER TO vlad;

--
-- TOC entry 45 (class 1255 OID 64342)
-- Dependencies: 6
-- Name: g_int_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION g_int_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c STRICT
    AS '$libdir/_int', 'g_int_penalty';


ALTER FUNCTION public.g_int_penalty(internal, internal, internal) OWNER TO vlad;

--
-- TOC entry 46 (class 1255 OID 64343)
-- Dependencies: 6
-- Name: g_int_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION g_int_picksplit(internal, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/_int', 'g_int_picksplit';


ALTER FUNCTION public.g_int_picksplit(internal, internal) OWNER TO vlad;

--
-- TOC entry 47 (class 1255 OID 64344)
-- Dependencies: 6
-- Name: g_int_same(integer[], integer[], internal); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION g_int_same(integer[], integer[], internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/_int', 'g_int_same';


ALTER FUNCTION public.g_int_same(integer[], integer[], internal) OWNER TO vlad;

--
-- TOC entry 48 (class 1255 OID 64345)
-- Dependencies: 6
-- Name: g_int_union(internal, internal); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION g_int_union(internal, internal) RETURNS integer[]
    LANGUAGE c
    AS '$libdir/_int', 'g_int_union';


ALTER FUNCTION public.g_int_union(internal, internal) OWNER TO vlad;

--
-- TOC entry 49 (class 1255 OID 64346)
-- Dependencies: 6
-- Name: g_intbig_compress(internal); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION g_intbig_compress(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/_int', 'g_intbig_compress';


ALTER FUNCTION public.g_intbig_compress(internal) OWNER TO vlad;

--
-- TOC entry 50 (class 1255 OID 64347)
-- Dependencies: 6
-- Name: g_intbig_consistent(internal, internal, integer); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION g_intbig_consistent(internal, internal, integer) RETURNS boolean
    LANGUAGE c
    AS '$libdir/_int', 'g_intbig_consistent';


ALTER FUNCTION public.g_intbig_consistent(internal, internal, integer) OWNER TO vlad;

--
-- TOC entry 51 (class 1255 OID 64348)
-- Dependencies: 6
-- Name: g_intbig_decompress(internal); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION g_intbig_decompress(internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/_int', 'g_intbig_decompress';


ALTER FUNCTION public.g_intbig_decompress(internal) OWNER TO vlad;

--
-- TOC entry 52 (class 1255 OID 64349)
-- Dependencies: 6
-- Name: g_intbig_penalty(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION g_intbig_penalty(internal, internal, internal) RETURNS internal
    LANGUAGE c STRICT
    AS '$libdir/_int', 'g_intbig_penalty';


ALTER FUNCTION public.g_intbig_penalty(internal, internal, internal) OWNER TO vlad;

--
-- TOC entry 53 (class 1255 OID 64350)
-- Dependencies: 6
-- Name: g_intbig_picksplit(internal, internal); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION g_intbig_picksplit(internal, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/_int', 'g_intbig_picksplit';


ALTER FUNCTION public.g_intbig_picksplit(internal, internal) OWNER TO vlad;

--
-- TOC entry 54 (class 1255 OID 64351)
-- Dependencies: 6
-- Name: g_intbig_same(internal, internal, internal); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION g_intbig_same(internal, internal, internal) RETURNS internal
    LANGUAGE c
    AS '$libdir/_int', 'g_intbig_same';


ALTER FUNCTION public.g_intbig_same(internal, internal, internal) OWNER TO vlad;

--
-- TOC entry 55 (class 1255 OID 64352)
-- Dependencies: 6
-- Name: g_intbig_union(internal, internal); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION g_intbig_union(internal, internal) RETURNS integer[]
    LANGUAGE c
    AS '$libdir/_int', 'g_intbig_union';


ALTER FUNCTION public.g_intbig_union(internal, internal) OWNER TO vlad;

--
-- TOC entry 56 (class 1255 OID 64353)
-- Dependencies: 6
-- Name: gen_salt(text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION gen_salt(text) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pg_gen_salt';


ALTER FUNCTION public.gen_salt(text) OWNER TO vlad;

--
-- TOC entry 57 (class 1255 OID 64354)
-- Dependencies: 6
-- Name: gen_salt(text, integer); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION gen_salt(text, integer) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pg_gen_salt_rounds';


ALTER FUNCTION public.gen_salt(text, integer) OWNER TO vlad;

--
-- TOC entry 58 (class 1255 OID 64369)
-- Dependencies: 6
-- Name: hmac(text, text, text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION hmac(text, text, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_hmac';


ALTER FUNCTION public.hmac(text, text, text) OWNER TO vlad;

--
-- TOC entry 59 (class 1255 OID 64370)
-- Dependencies: 6
-- Name: hmac(bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION hmac(bytea, bytea, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pg_hmac';


ALTER FUNCTION public.hmac(bytea, bytea, text) OWNER TO vlad;

--
-- TOC entry 60 (class 1255 OID 64372)
-- Dependencies: 6
-- Name: icount(integer[]); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION icount(integer[]) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'icount';


ALTER FUNCTION public.icount(integer[]) OWNER TO vlad;

--
-- TOC entry 61 (class 1255 OID 64373)
-- Dependencies: 6
-- Name: idx(integer[], integer); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION idx(integer[], integer) RETURNS integer
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'idx';


ALTER FUNCTION public.idx(integer[], integer) OWNER TO vlad;

--
-- TOC entry 62 (class 1255 OID 64374)
-- Dependencies: 6
-- Name: insert_username(); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION insert_username() RETURNS trigger
    LANGUAGE c
    AS '$libdir/insert_username', 'insert_username';


ALTER FUNCTION public.insert_username() OWNER TO vlad;

--
-- TOC entry 63 (class 1255 OID 64378)
-- Dependencies: 6
-- Name: intarray_del_elem(integer[], integer); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION intarray_del_elem(integer[], integer) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'intarray_del_elem';


ALTER FUNCTION public.intarray_del_elem(integer[], integer) OWNER TO vlad;

--
-- TOC entry 64 (class 1255 OID 64379)
-- Dependencies: 6
-- Name: intarray_push_array(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION intarray_push_array(integer[], integer[]) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'intarray_push_array';


ALTER FUNCTION public.intarray_push_array(integer[], integer[]) OWNER TO vlad;

--
-- TOC entry 65 (class 1255 OID 64380)
-- Dependencies: 6
-- Name: intarray_push_elem(integer[], integer); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION intarray_push_elem(integer[], integer) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'intarray_push_elem';


ALTER FUNCTION public.intarray_push_elem(integer[], integer) OWNER TO vlad;

--
-- TOC entry 66 (class 1255 OID 64381)
-- Dependencies: 6
-- Name: intset(integer); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION intset(integer) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'intset';


ALTER FUNCTION public.intset(integer) OWNER TO vlad;

--
-- TOC entry 67 (class 1255 OID 64382)
-- Dependencies: 6
-- Name: intset_subtract(integer[], integer[]); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION intset_subtract(integer[], integer[]) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'intset_subtract';


ALTER FUNCTION public.intset_subtract(integer[], integer[]) OWNER TO vlad;

--
-- TOC entry 68 (class 1255 OID 64383)
-- Dependencies: 6
-- Name: intset_union_elem(integer[], integer); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION intset_union_elem(integer[], integer) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'intset_union_elem';


ALTER FUNCTION public.intset_union_elem(integer[], integer) OWNER TO vlad;

--
-- TOC entry 69 (class 1255 OID 64388)
-- Dependencies: 6
-- Name: lo_manage(); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION lo_manage() RETURNS trigger
    LANGUAGE c
    AS '$libdir/lo', 'lo_manage';


ALTER FUNCTION public.lo_manage() OWNER TO vlad;

--
-- TOC entry 70 (class 1255 OID 64389)
-- Dependencies: 393 6
-- Name: lo_oid(lo); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION lo_oid(lo) RETURNS oid
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$SELECT $1::pg_catalog.oid$_$;


ALTER FUNCTION public.lo_oid(lo) OWNER TO vlad;

--
-- TOC entry 71 (class 1255 OID 64393)
-- Dependencies: 6
-- Name: pgp_key_id(bytea); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION pgp_key_id(bytea) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_key_id_w';


ALTER FUNCTION public.pgp_key_id(bytea) OWNER TO vlad;

--
-- TOC entry 72 (class 1255 OID 64394)
-- Dependencies: 6
-- Name: pgp_pub_decrypt(bytea, bytea); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION pgp_pub_decrypt(bytea, bytea) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_decrypt_text';


ALTER FUNCTION public.pgp_pub_decrypt(bytea, bytea) OWNER TO vlad;

--
-- TOC entry 73 (class 1255 OID 64395)
-- Dependencies: 6
-- Name: pgp_pub_decrypt(bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION pgp_pub_decrypt(bytea, bytea, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_decrypt_text';


ALTER FUNCTION public.pgp_pub_decrypt(bytea, bytea, text) OWNER TO vlad;

--
-- TOC entry 74 (class 1255 OID 64396)
-- Dependencies: 6
-- Name: pgp_pub_decrypt(bytea, bytea, text, text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION pgp_pub_decrypt(bytea, bytea, text, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_decrypt_text';


ALTER FUNCTION public.pgp_pub_decrypt(bytea, bytea, text, text) OWNER TO vlad;

--
-- TOC entry 75 (class 1255 OID 64397)
-- Dependencies: 6
-- Name: pgp_pub_decrypt_bytea(bytea, bytea); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION pgp_pub_decrypt_bytea(bytea, bytea) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_decrypt_bytea';


ALTER FUNCTION public.pgp_pub_decrypt_bytea(bytea, bytea) OWNER TO vlad;

--
-- TOC entry 76 (class 1255 OID 64398)
-- Dependencies: 6
-- Name: pgp_pub_decrypt_bytea(bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_decrypt_bytea';


ALTER FUNCTION public.pgp_pub_decrypt_bytea(bytea, bytea, text) OWNER TO vlad;

--
-- TOC entry 77 (class 1255 OID 64399)
-- Dependencies: 6
-- Name: pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_decrypt_bytea';


ALTER FUNCTION public.pgp_pub_decrypt_bytea(bytea, bytea, text, text) OWNER TO vlad;

--
-- TOC entry 78 (class 1255 OID 64400)
-- Dependencies: 6
-- Name: pgp_pub_encrypt(text, bytea); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION pgp_pub_encrypt(text, bytea) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_encrypt_text';


ALTER FUNCTION public.pgp_pub_encrypt(text, bytea) OWNER TO vlad;

--
-- TOC entry 79 (class 1255 OID 64401)
-- Dependencies: 6
-- Name: pgp_pub_encrypt(text, bytea, text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION pgp_pub_encrypt(text, bytea, text) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_encrypt_text';


ALTER FUNCTION public.pgp_pub_encrypt(text, bytea, text) OWNER TO vlad;

--
-- TOC entry 80 (class 1255 OID 64402)
-- Dependencies: 6
-- Name: pgp_pub_encrypt_bytea(bytea, bytea); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION pgp_pub_encrypt_bytea(bytea, bytea) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_encrypt_bytea';


ALTER FUNCTION public.pgp_pub_encrypt_bytea(bytea, bytea) OWNER TO vlad;

--
-- TOC entry 81 (class 1255 OID 64403)
-- Dependencies: 6
-- Name: pgp_pub_encrypt_bytea(bytea, bytea, text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pgp_pub_encrypt_bytea';


ALTER FUNCTION public.pgp_pub_encrypt_bytea(bytea, bytea, text) OWNER TO vlad;

--
-- TOC entry 82 (class 1255 OID 64404)
-- Dependencies: 6
-- Name: pgp_sym_decrypt(bytea, text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION pgp_sym_decrypt(bytea, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_sym_decrypt_text';


ALTER FUNCTION public.pgp_sym_decrypt(bytea, text) OWNER TO vlad;

--
-- TOC entry 83 (class 1255 OID 64405)
-- Dependencies: 6
-- Name: pgp_sym_decrypt(bytea, text, text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION pgp_sym_decrypt(bytea, text, text) RETURNS text
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_sym_decrypt_text';


ALTER FUNCTION public.pgp_sym_decrypt(bytea, text, text) OWNER TO vlad;

--
-- TOC entry 84 (class 1255 OID 64406)
-- Dependencies: 6
-- Name: pgp_sym_decrypt_bytea(bytea, text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION pgp_sym_decrypt_bytea(bytea, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_sym_decrypt_bytea';


ALTER FUNCTION public.pgp_sym_decrypt_bytea(bytea, text) OWNER TO vlad;

--
-- TOC entry 85 (class 1255 OID 64407)
-- Dependencies: 6
-- Name: pgp_sym_decrypt_bytea(bytea, text, text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION pgp_sym_decrypt_bytea(bytea, text, text) RETURNS bytea
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/pgcrypto', 'pgp_sym_decrypt_bytea';


ALTER FUNCTION public.pgp_sym_decrypt_bytea(bytea, text, text) OWNER TO vlad;

--
-- TOC entry 86 (class 1255 OID 64408)
-- Dependencies: 6
-- Name: pgp_sym_encrypt(text, text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION pgp_sym_encrypt(text, text) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pgp_sym_encrypt_text';


ALTER FUNCTION public.pgp_sym_encrypt(text, text) OWNER TO vlad;

--
-- TOC entry 87 (class 1255 OID 64409)
-- Dependencies: 6
-- Name: pgp_sym_encrypt(text, text, text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION pgp_sym_encrypt(text, text, text) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pgp_sym_encrypt_text';


ALTER FUNCTION public.pgp_sym_encrypt(text, text, text) OWNER TO vlad;

--
-- TOC entry 88 (class 1255 OID 64410)
-- Dependencies: 6
-- Name: pgp_sym_encrypt_bytea(bytea, text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION pgp_sym_encrypt_bytea(bytea, text) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pgp_sym_encrypt_bytea';


ALTER FUNCTION public.pgp_sym_encrypt_bytea(bytea, text) OWNER TO vlad;

--
-- TOC entry 89 (class 1255 OID 64411)
-- Dependencies: 6
-- Name: pgp_sym_encrypt_bytea(bytea, text, text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION pgp_sym_encrypt_bytea(bytea, text, text) RETURNS bytea
    LANGUAGE c STRICT
    AS '$libdir/pgcrypto', 'pgp_sym_encrypt_bytea';


ALTER FUNCTION public.pgp_sym_encrypt_bytea(bytea, text, text) OWNER TO vlad;

--
-- TOC entry 101 (class 1255 OID 64412)
-- Dependencies: 6
-- Name: plpgsql_call_handler(); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION plpgsql_call_handler() RETURNS language_handler
    LANGUAGE c
    AS '$libdir/plpgsql', 'plpgsql_call_handler';


ALTER FUNCTION public.plpgsql_call_handler() OWNER TO vlad;

--
-- TOC entry 91 (class 1255 OID 64418)
-- Dependencies: 390 6
-- Name: querytree(query_int); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION querytree(query_int) RETURNS text
    LANGUAGE c STRICT
    AS '$libdir/_int', 'querytree';


ALTER FUNCTION public.querytree(query_int) OWNER TO vlad;

--
-- TOC entry 92 (class 1255 OID 64428)
-- Dependencies: 6 390
-- Name: rboolop(query_int, integer[]); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION rboolop(query_int, integer[]) RETURNS boolean
    LANGUAGE c STRICT
    AS '$libdir/_int', 'rboolop';


ALTER FUNCTION public.rboolop(query_int, integer[]) OWNER TO vlad;

--
-- TOC entry 2310 (class 0 OID 0)
-- Dependencies: 92
-- Name: FUNCTION rboolop(query_int, integer[]); Type: COMMENT; Schema: public; Owner: vlad
--

COMMENT ON FUNCTION rboolop(query_int, integer[]) IS 'boolean operation with array';


--
-- TOC entry 93 (class 1255 OID 64442)
-- Dependencies: 6
-- Name: sort(integer[], text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION sort(integer[], text) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'sort';


ALTER FUNCTION public.sort(integer[], text) OWNER TO vlad;

--
-- TOC entry 94 (class 1255 OID 64443)
-- Dependencies: 6
-- Name: sort(integer[]); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION sort(integer[]) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'sort';


ALTER FUNCTION public.sort(integer[]) OWNER TO vlad;

--
-- TOC entry 95 (class 1255 OID 64444)
-- Dependencies: 6
-- Name: sort_asc(integer[]); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION sort_asc(integer[]) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'sort_asc';


ALTER FUNCTION public.sort_asc(integer[]) OWNER TO vlad;

--
-- TOC entry 96 (class 1255 OID 64445)
-- Dependencies: 6
-- Name: sort_desc(integer[]); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION sort_desc(integer[]) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'sort_desc';


ALTER FUNCTION public.sort_desc(integer[]) OWNER TO vlad;

--
-- TOC entry 97 (class 1255 OID 64451)
-- Dependencies: 6
-- Name: subarray(integer[], integer, integer); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION subarray(integer[], integer, integer) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'subarray';


ALTER FUNCTION public.subarray(integer[], integer, integer) OWNER TO vlad;

--
-- TOC entry 98 (class 1255 OID 64452)
-- Dependencies: 6
-- Name: subarray(integer[], integer); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION subarray(integer[], integer) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'subarray';


ALTER FUNCTION public.subarray(integer[], integer) OWNER TO vlad;

--
-- TOC entry 99 (class 1255 OID 64464)
-- Dependencies: 400 6
-- Name: ts_debug(text); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION ts_debug(text) RETURNS SETOF tsdebug
    LANGUAGE sql STRICT
    AS $_$
select 
        m.ts_name,
        t.alias as tok_type,
        t.descr as description,
        p.token,
        m.dict_name,
        strip(to_tsvector(p.token)) as tsvector
from
        parse( _get_parser_from_curcfg(), $1 ) as p,
        token_type() as t,
        pg_ts_cfgmap as m,
        pg_ts_cfg as c
where
        t.tokid=p.tokid and
        t.alias = m.tok_alias and 
        m.ts_name=c.ts_name and 
        c.oid=show_curcfg() 
$_$;


ALTER FUNCTION public.ts_debug(text) OWNER TO vlad;

--
-- TOC entry 100 (class 1255 OID 64473)
-- Dependencies: 6
-- Name: uniq(integer[]); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION uniq(integer[]) RETURNS integer[]
    LANGUAGE c IMMUTABLE STRICT
    AS '$libdir/_int', 'uniq';


ALTER FUNCTION public.uniq(integer[]) OWNER TO vlad;

--
-- TOC entry 1226 (class 2617 OID 64474)
-- Dependencies: 6 60
-- Name: #; Type: OPERATOR; Schema: public; Owner: vlad
--

CREATE OPERATOR # (
    PROCEDURE = icount,
    RIGHTARG = integer[]
);


ALTER OPERATOR public.# (NONE, integer[]) OWNER TO vlad;

--
-- TOC entry 1227 (class 2617 OID 64475)
-- Dependencies: 6 61
-- Name: #; Type: OPERATOR; Schema: public; Owner: vlad
--

CREATE OPERATOR # (
    PROCEDURE = idx,
    LEFTARG = integer[],
    RIGHTARG = integer
);


ALTER OPERATOR public.# (integer[], integer) OWNER TO vlad;

--
-- TOC entry 1229 (class 2617 OID 64476)
-- Dependencies: 27 6
-- Name: &; Type: OPERATOR; Schema: public; Owner: vlad
--

CREATE OPERATOR & (
    PROCEDURE = _int_inter,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = &
);


ALTER OPERATOR public.& (integer[], integer[]) OWNER TO vlad;

--
-- TOC entry 1228 (class 2617 OID 64477)
-- Dependencies: 28 6
-- Name: &&; Type: OPERATOR; Schema: public; Owner: vlad
--

CREATE OPERATOR && (
    PROCEDURE = _int_overlap,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = &&,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.&& (integer[], integer[]) OWNER TO vlad;

--
-- TOC entry 1230 (class 2617 OID 64478)
-- Dependencies: 6 65
-- Name: +; Type: OPERATOR; Schema: public; Owner: vlad
--

CREATE OPERATOR + (
    PROCEDURE = intarray_push_elem,
    LEFTARG = integer[],
    RIGHTARG = integer
);


ALTER OPERATOR public.+ (integer[], integer) OWNER TO vlad;

--
-- TOC entry 1232 (class 2617 OID 64479)
-- Dependencies: 64 6
-- Name: +; Type: OPERATOR; Schema: public; Owner: vlad
--

CREATE OPERATOR + (
    PROCEDURE = intarray_push_array,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = +
);


ALTER OPERATOR public.+ (integer[], integer[]) OWNER TO vlad;

--
-- TOC entry 1231 (class 2617 OID 64480)
-- Dependencies: 6 63
-- Name: -; Type: OPERATOR; Schema: public; Owner: vlad
--

CREATE OPERATOR - (
    PROCEDURE = intarray_del_elem,
    LEFTARG = integer[],
    RIGHTARG = integer
);


ALTER OPERATOR public.- (integer[], integer) OWNER TO vlad;

--
-- TOC entry 1233 (class 2617 OID 64481)
-- Dependencies: 67 6
-- Name: -; Type: OPERATOR; Schema: public; Owner: vlad
--

CREATE OPERATOR - (
    PROCEDURE = intset_subtract,
    LEFTARG = integer[],
    RIGHTARG = integer[]
);


ALTER OPERATOR public.- (integer[], integer[]) OWNER TO vlad;

--
-- TOC entry 1234 (class 2617 OID 64482)
-- Dependencies: 6
-- Name: <; Type: OPERATOR; Schema: public; Owner: vlad
--

CREATE OPERATOR < (
    PROCEDURE = tsvector_lt,
    LEFTARG = tsvector,
    RIGHTARG = tsvector,
    COMMUTATOR = OPERATOR(pg_catalog.>),
    NEGATOR = OPERATOR(pg_catalog.>=),
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.< (tsvector, tsvector) OWNER TO vlad;

--
-- TOC entry 1235 (class 2617 OID 64483)
-- Dependencies: 6
-- Name: <=; Type: OPERATOR; Schema: public; Owner: vlad
--

CREATE OPERATOR <= (
    PROCEDURE = tsvector_le,
    LEFTARG = tsvector,
    RIGHTARG = tsvector,
    COMMUTATOR = OPERATOR(pg_catalog.>=),
    NEGATOR = OPERATOR(pg_catalog.>),
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.<= (tsvector, tsvector) OWNER TO vlad;

--
-- TOC entry 1236 (class 2617 OID 64484)
-- Dependencies: 6
-- Name: <>; Type: OPERATOR; Schema: public; Owner: vlad
--

CREATE OPERATOR <> (
    PROCEDURE = tsvector_ne,
    LEFTARG = tsvector,
    RIGHTARG = tsvector,
    COMMUTATOR = OPERATOR(pg_catalog.<>),
    NEGATOR = OPERATOR(pg_catalog.=),
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);


ALTER OPERATOR public.<> (tsvector, tsvector) OWNER TO vlad;

--
-- TOC entry 1237 (class 2617 OID 64485)
-- Dependencies: 6
-- Name: =; Type: OPERATOR; Schema: public; Owner: vlad
--

CREATE OPERATOR = (
    PROCEDURE = tsvector_eq,
    LEFTARG = tsvector,
    RIGHTARG = tsvector,
    COMMUTATOR = OPERATOR(pg_catalog.=),
    NEGATOR = <>,
    MERGES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);


ALTER OPERATOR public.= (tsvector, tsvector) OWNER TO vlad;

--
-- TOC entry 1238 (class 2617 OID 64486)
-- Dependencies: 6
-- Name: >; Type: OPERATOR; Schema: public; Owner: vlad
--

CREATE OPERATOR > (
    PROCEDURE = tsvector_gt,
    LEFTARG = tsvector,
    RIGHTARG = tsvector,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.> (tsvector, tsvector) OWNER TO vlad;

--
-- TOC entry 1239 (class 2617 OID 64487)
-- Dependencies: 6
-- Name: >=; Type: OPERATOR; Schema: public; Owner: vlad
--

CREATE OPERATOR >= (
    PROCEDURE = tsvector_ge,
    LEFTARG = tsvector,
    RIGHTARG = tsvector,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.>= (tsvector, tsvector) OWNER TO vlad;

--
-- TOC entry 1240 (class 2617 OID 64489)
-- Dependencies: 6 25
-- Name: @; Type: OPERATOR; Schema: public; Owner: vlad
--

CREATE OPERATOR @ (
    PROCEDURE = _int_contains,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = ~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@ (integer[], integer[]) OWNER TO vlad;

--
-- TOC entry 1241 (class 2617 OID 64491)
-- Dependencies: 6 390 33
-- Name: @@; Type: OPERATOR; Schema: public; Owner: vlad
--

CREATE OPERATOR @@ (
    PROCEDURE = boolop,
    LEFTARG = integer[],
    RIGHTARG = query_int,
    COMMUTATOR = ~~,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.@@ (integer[], query_int) OWNER TO vlad;

--
-- TOC entry 1242 (class 2617 OID 64492)
-- Dependencies: 6 68
-- Name: |; Type: OPERATOR; Schema: public; Owner: vlad
--

CREATE OPERATOR | (
    PROCEDURE = intset_union_elem,
    LEFTARG = integer[],
    RIGHTARG = integer
);


ALTER OPERATOR public.| (integer[], integer) OWNER TO vlad;

--
-- TOC entry 1243 (class 2617 OID 64493)
-- Dependencies: 6 30
-- Name: |; Type: OPERATOR; Schema: public; Owner: vlad
--

CREATE OPERATOR | (
    PROCEDURE = _int_union,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = |
);


ALTER OPERATOR public.| (integer[], integer[]) OWNER TO vlad;

--
-- TOC entry 1244 (class 2617 OID 64488)
-- Dependencies: 24 6
-- Name: ~; Type: OPERATOR; Schema: public; Owner: vlad
--

CREATE OPERATOR ~ (
    PROCEDURE = _int_contained,
    LEFTARG = integer[],
    RIGHTARG = integer[],
    COMMUTATOR = @,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~ (integer[], integer[]) OWNER TO vlad;

--
-- TOC entry 1245 (class 2617 OID 64490)
-- Dependencies: 390 6 92
-- Name: ~~; Type: OPERATOR; Schema: public; Owner: vlad
--

CREATE OPERATOR ~~ (
    PROCEDURE = rboolop,
    LEFTARG = query_int,
    RIGHTARG = integer[],
    COMMUTATOR = @@,
    RESTRICT = contsel,
    JOIN = contjoinsel
);


ALTER OPERATOR public.~~ (query_int, integer[]) OWNER TO vlad;

--
-- TOC entry 1465 (class 2753 OID 64494)
-- Dependencies: 6
-- Name: gist__int_ops; Type: OPERATOR FAMILY; Schema: public; Owner: postgres
--

CREATE OPERATOR FAMILY gist__int_ops USING gist;


ALTER OPERATOR FAMILY public.gist__int_ops USING gist OWNER TO postgres;

--
-- TOC entry 1357 (class 2616 OID 64495)
-- Dependencies: 6 1465
-- Name: gist__int_ops; Type: OPERATOR CLASS; Schema: public; Owner: vlad
--

CREATE OPERATOR CLASS gist__int_ops
    DEFAULT FOR TYPE integer[] USING gist AS
    OPERATOR 3 &&(integer[],integer[]) ,
    OPERATOR 6 =(anyarray,anyarray) ,
    OPERATOR 7 @(integer[],integer[]) ,
    OPERATOR 8 ~(integer[],integer[]) ,
    OPERATOR 20 @@(integer[],query_int) ,
    FUNCTION 1 g_int_consistent(internal,integer[],integer) ,
    FUNCTION 2 g_int_union(internal,internal) ,
    FUNCTION 3 g_int_compress(internal) ,
    FUNCTION 4 g_int_decompress(internal) ,
    FUNCTION 5 g_int_penalty(internal,internal,internal) ,
    FUNCTION 6 g_int_picksplit(internal,internal) ,
    FUNCTION 7 g_int_same(integer[],integer[],internal);


ALTER OPERATOR CLASS public.gist__int_ops USING gist OWNER TO vlad;

--
-- TOC entry 1466 (class 2753 OID 64508)
-- Dependencies: 6
-- Name: gist__intbig_ops; Type: OPERATOR FAMILY; Schema: public; Owner: postgres
--

CREATE OPERATOR FAMILY gist__intbig_ops USING gist;


ALTER OPERATOR FAMILY public.gist__intbig_ops USING gist OWNER TO postgres;

--
-- TOC entry 1358 (class 2616 OID 64509)
-- Dependencies: 6 1466 386
-- Name: gist__intbig_ops; Type: OPERATOR CLASS; Schema: public; Owner: vlad
--

CREATE OPERATOR CLASS gist__intbig_ops
    FOR TYPE integer[] USING gist AS
    STORAGE intbig_gkey ,
    OPERATOR 3 &&(integer[],integer[]) ,
    OPERATOR 6 =(anyarray,anyarray) ,
    OPERATOR 7 @(integer[],integer[]) ,
    OPERATOR 8 ~(integer[],integer[]) ,
    OPERATOR 20 @@(integer[],query_int) ,
    FUNCTION 1 g_intbig_consistent(internal,internal,integer) ,
    FUNCTION 2 g_intbig_union(internal,internal) ,
    FUNCTION 3 g_intbig_compress(internal) ,
    FUNCTION 4 g_intbig_decompress(internal) ,
    FUNCTION 5 g_intbig_penalty(internal,internal,internal) ,
    FUNCTION 6 g_intbig_picksplit(internal,internal) ,
    FUNCTION 7 g_intbig_same(internal,internal,internal);


ALTER OPERATOR CLASS public.gist__intbig_ops USING gist OWNER TO vlad;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1737 (class 1259 OID 64526)
-- Dependencies: 2071 6
-- Name: avans3; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE avans3 (
    id integer NOT NULL,
    parentid integer NOT NULL,
    dokid integer NOT NULL,
    liik integer DEFAULT 1 NOT NULL,
    muud text
);


ALTER TABLE public.avans3 OWNER TO vlad;

--
-- TOC entry 1736 (class 1259 OID 64524)
-- Dependencies: 1737 6
-- Name: avans3_id_seq; Type: SEQUENCE; Schema: public; Owner: vlad
--

CREATE SEQUENCE avans3_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.avans3_id_seq OWNER TO vlad;

--
-- TOC entry 2312 (class 0 OID 0)
-- Dependencies: 1736
-- Name: avans3_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vlad
--

ALTER SEQUENCE avans3_id_seq OWNED BY avans3.id;


--
-- TOC entry 2313 (class 0 OID 0)
-- Dependencies: 1736
-- Name: avans3_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vlad
--

SELECT pg_catalog.setval('avans3_id_seq', 1, false);


--
-- TOC entry 1739 (class 1259 OID 64536)
-- Dependencies: 2073 2074 2075 2076 2077 2078 2079 2080 6
-- Name: ladu_jaak; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE ladu_jaak (
    id integer NOT NULL,
    rekvid integer NOT NULL,
    dokitemid integer DEFAULT 0 NOT NULL,
    nomid integer DEFAULT 0 NOT NULL,
    userid integer DEFAULT 0 NOT NULL,
    kpv date DEFAULT ('now'::text)::date NOT NULL,
    hind numeric(12,4) DEFAULT 0 NOT NULL,
    kogus numeric(18,3) DEFAULT 0 NOT NULL,
    maha numeric(18,3) DEFAULT 0 NOT NULL,
    jaak numeric(18,3) DEFAULT 0 NOT NULL
);


ALTER TABLE public.ladu_jaak OWNER TO vlad;

--
-- TOC entry 1740 (class 1259 OID 64548)
-- Dependencies: 1878 6
-- Name: curnomjaak; Type: VIEW; Schema: public; Owner: vlad
--

CREATE VIEW curnomjaak AS
    SELECT ladu_jaak.nomid, sum(ladu_jaak.jaak) AS kogus FROM ladu_jaak GROUP BY ladu_jaak.nomid;


ALTER TABLE public.curnomjaak OWNER TO vlad;

--
-- TOC entry 1742 (class 1259 OID 64554)
-- Dependencies: 2082 2083 6
-- Name: dbase; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE dbase (
    id integer NOT NULL,
    alias character(50) NOT NULL,
    lastnum integer DEFAULT 0 NOT NULL,
    doknum integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.dbase OWNER TO vlad;

--
-- TOC entry 1741 (class 1259 OID 64552)
-- Dependencies: 1742 6
-- Name: dbase_id_seq; Type: SEQUENCE; Schema: public; Owner: vlad
--

CREATE SEQUENCE dbase_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.dbase_id_seq OWNER TO vlad;

--
-- TOC entry 2318 (class 0 OID 0)
-- Dependencies: 1741
-- Name: dbase_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vlad
--

ALTER SEQUENCE dbase_id_seq OWNED BY dbase.id;


--
-- TOC entry 2319 (class 0 OID 0)
-- Dependencies: 1741
-- Name: dbase_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vlad
--

SELECT pg_catalog.setval('dbase_id_seq', 1, false);


--
-- TOC entry 1744 (class 1259 OID 64562)
-- Dependencies: 2085 2086 6
-- Name: eel_config; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE eel_config (
    id integer NOT NULL,
    rekvid integer NOT NULL,
    kontrol smallint DEFAULT 0 NOT NULL,
    reserv1 text,
    reserv2 text,
    reserv3 text,
    valklassif integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.eel_config OWNER TO vlad;

--
-- TOC entry 1743 (class 1259 OID 64560)
-- Dependencies: 6 1744
-- Name: eel_config_id_seq; Type: SEQUENCE; Schema: public; Owner: vlad
--

CREATE SEQUENCE eel_config_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.eel_config_id_seq OWNER TO vlad;

--
-- TOC entry 2322 (class 0 OID 0)
-- Dependencies: 1743
-- Name: eel_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vlad
--

ALTER SEQUENCE eel_config_id_seq OWNED BY eel_config.id;


--
-- TOC entry 2323 (class 0 OID 0)
-- Dependencies: 1743
-- Name: eel_config_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vlad
--

SELECT pg_catalog.setval('eel_config_id_seq', 1, false);


--
-- TOC entry 1746 (class 1259 OID 64573)
-- Dependencies: 2088 2089 2090 2091 2092 6
-- Name: eelarveinf; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE eelarveinf (
    id integer NOT NULL,
    allikadid integer DEFAULT 0 NOT NULL,
    rahavooid integer DEFAULT 0 NOT NULL,
    kontoid integer DEFAULT 0 NOT NULL,
    rekvid integer DEFAULT 0 NOT NULL,
    algsaldo numeric(12,4) DEFAULT 0 NOT NULL,
    muud text
);


ALTER TABLE public.eelarveinf OWNER TO vlad;

--
-- TOC entry 1745 (class 1259 OID 64571)
-- Dependencies: 1746 6
-- Name: eelarveinf_id_seq; Type: SEQUENCE; Schema: public; Owner: vlad
--

CREATE SEQUENCE eelarveinf_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.eelarveinf_id_seq OWNER TO vlad;

--
-- TOC entry 2326 (class 0 OID 0)
-- Dependencies: 1745
-- Name: eelarveinf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vlad
--

ALTER SEQUENCE eelarveinf_id_seq OWNED BY eelarveinf.id;


--
-- TOC entry 2327 (class 0 OID 0)
-- Dependencies: 1745
-- Name: eelarveinf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vlad
--

SELECT pg_catalog.setval('eelarveinf_id_seq', 1, false);


--
-- TOC entry 1790 (class 1259 OID 167059)
-- Dependencies: 2165 2166 2167 2168 6
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
    number character varying(19) NOT NULL,
    omanik character varying(254) NOT NULL
);


ALTER TABLE public.kaardid OWNER TO vlad;

--
-- TOC entry 1791 (class 1259 OID 167069)
-- Dependencies: 6 1790
-- Name: kaardid_id_seq; Type: SEQUENCE; Schema: public; Owner: vlad
--

CREATE SEQUENCE kaardid_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.kaardid_id_seq OWNER TO vlad;

--
-- TOC entry 2329 (class 0 OID 0)
-- Dependencies: 1791
-- Name: kaardid_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vlad
--

ALTER SEQUENCE kaardid_id_seq OWNED BY kaardid.id;


--
-- TOC entry 2330 (class 0 OID 0)
-- Dependencies: 1791
-- Name: kaardid_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vlad
--

SELECT pg_catalog.setval('kaardid_id_seq', 1, false);


--
-- TOC entry 1748 (class 1259 OID 64587)
-- Dependencies: 2094 6
-- Name: ladu_config; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE ladu_config (
    id integer NOT NULL,
    rekvid integer NOT NULL,
    liik integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.ladu_config OWNER TO vlad;

--
-- TOC entry 1747 (class 1259 OID 64585)
-- Dependencies: 6 1748
-- Name: ladu_config_id_seq; Type: SEQUENCE; Schema: public; Owner: vlad
--

CREATE SEQUENCE ladu_config_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.ladu_config_id_seq OWNER TO vlad;

--
-- TOC entry 2332 (class 0 OID 0)
-- Dependencies: 1747
-- Name: ladu_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vlad
--

ALTER SEQUENCE ladu_config_id_seq OWNED BY ladu_config.id;


--
-- TOC entry 2333 (class 0 OID 0)
-- Dependencies: 1747
-- Name: ladu_config_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vlad
--

SELECT pg_catalog.setval('ladu_config_id_seq', 1, false);


--
-- TOC entry 1750 (class 1259 OID 64594)
-- Dependencies: 2096 6
-- Name: ladu_grupp; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE ladu_grupp (
    id integer NOT NULL,
    parentid integer NOT NULL,
    nomid integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.ladu_grupp OWNER TO vlad;

--
-- TOC entry 1749 (class 1259 OID 64592)
-- Dependencies: 6 1750
-- Name: ladu_grupp_id_seq; Type: SEQUENCE; Schema: public; Owner: vlad
--

CREATE SEQUENCE ladu_grupp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.ladu_grupp_id_seq OWNER TO vlad;

--
-- TOC entry 2336 (class 0 OID 0)
-- Dependencies: 1749
-- Name: ladu_grupp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vlad
--

ALTER SEQUENCE ladu_grupp_id_seq OWNED BY ladu_grupp.id;


--
-- TOC entry 2337 (class 0 OID 0)
-- Dependencies: 1749
-- Name: ladu_grupp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vlad
--

SELECT pg_catalog.setval('ladu_grupp_id_seq', 1, false);


--
-- TOC entry 1738 (class 1259 OID 64534)
-- Dependencies: 6 1739
-- Name: ladu_jaak_id_seq; Type: SEQUENCE; Schema: public; Owner: vlad
--

CREATE SEQUENCE ladu_jaak_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.ladu_jaak_id_seq OWNER TO vlad;

--
-- TOC entry 2339 (class 0 OID 0)
-- Dependencies: 1738
-- Name: ladu_jaak_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vlad
--

ALTER SEQUENCE ladu_jaak_id_seq OWNED BY ladu_jaak.id;


--
-- TOC entry 2340 (class 0 OID 0)
-- Dependencies: 1738
-- Name: ladu_jaak_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vlad
--

SELECT pg_catalog.setval('ladu_jaak_id_seq', 1, false);


--
-- TOC entry 1751 (class 1259 OID 64599)
-- Dependencies: 6
-- Name: lcdbkonto; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE lcdbkonto (
    kood character(20)
);


ALTER TABLE public.lcdbkonto OWNER TO vlad;

--
-- TOC entry 1753 (class 1259 OID 64604)
-- Dependencies: 2098 2099 2100 6
-- Name: leping3; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE leping3 (
    id integer NOT NULL,
    parentid integer NOT NULL,
    kpv date DEFAULT ('now'::text)::date NOT NULL,
    algkogus numeric(18,5) DEFAULT 0 NOT NULL,
    loppkogus numeric(18,5) DEFAULT 0 NOT NULL,
    muud text
);


ALTER TABLE public.leping3 OWNER TO vlad;

--
-- TOC entry 1752 (class 1259 OID 64602)
-- Dependencies: 1753 6
-- Name: leping3_id_seq; Type: SEQUENCE; Schema: public; Owner: vlad
--

CREATE SEQUENCE leping3_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.leping3_id_seq OWNER TO vlad;

--
-- TOC entry 2343 (class 0 OID 0)
-- Dependencies: 1752
-- Name: leping3_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vlad
--

ALTER SEQUENCE leping3_id_seq OWNED BY leping3.id;


--
-- TOC entry 2344 (class 0 OID 0)
-- Dependencies: 1752
-- Name: leping3_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vlad
--

SELECT pg_catalog.setval('leping3_id_seq', 1, false);


--
-- TOC entry 1754 (class 1259 OID 64614)
-- Dependencies: 6
-- Name: lnarvjaak; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE lnarvjaak (
    "?column?" numeric
);


ALTER TABLE public.lnarvjaak OWNER TO vlad;

--
-- TOC entry 1756 (class 1259 OID 64622)
-- Dependencies: 2102 2103 2104 2105 2106 2107 6
-- Name: palk_asutus; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE palk_asutus (
    id integer NOT NULL,
    rekvid integer NOT NULL,
    osakondid integer DEFAULT 0 NOT NULL,
    ametid integer DEFAULT 0 NOT NULL,
    kogus numeric(18,2) DEFAULT 0 NOT NULL,
    vaba numeric(18,2) DEFAULT 0 NOT NULL,
    palgamaar integer DEFAULT 0 NOT NULL,
    muud text,
    tunnusid bigint DEFAULT 0 NOT NULL,
    vanaid integer
);


ALTER TABLE public.palk_asutus OWNER TO vlad;

--
-- TOC entry 1755 (class 1259 OID 64620)
-- Dependencies: 6 1756
-- Name: palk_asutus_id_seq; Type: SEQUENCE; Schema: public; Owner: vlad
--

CREATE SEQUENCE palk_asutus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.palk_asutus_id_seq OWNER TO vlad;

--
-- TOC entry 2347 (class 0 OID 0)
-- Dependencies: 1755
-- Name: palk_asutus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vlad
--

ALTER SEQUENCE palk_asutus_id_seq OWNED BY palk_asutus.id;


--
-- TOC entry 2348 (class 0 OID 0)
-- Dependencies: 1755
-- Name: palk_asutus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vlad
--

SELECT pg_catalog.setval('palk_asutus_id_seq', 1, false);


--
-- TOC entry 1758 (class 1259 OID 64637)
-- Dependencies: 2109 2110 2111 2112 2113 2114 6
-- Name: palk_config; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE palk_config (
    id integer NOT NULL,
    rekvid integer NOT NULL,
    minpalk numeric(12,4) DEFAULT 0 NOT NULL,
    tulubaas numeric(12,4) DEFAULT 0 NOT NULL,
    round numeric(12,4) DEFAULT 0.01 NOT NULL,
    jaak smallint DEFAULT 0 NOT NULL,
    genlausend integer DEFAULT 1,
    suurasu integer DEFAULT 0
);


ALTER TABLE public.palk_config OWNER TO vlad;

--
-- TOC entry 1757 (class 1259 OID 64635)
-- Dependencies: 1758 6
-- Name: palk_config_id_seq; Type: SEQUENCE; Schema: public; Owner: vlad
--

CREATE SEQUENCE palk_config_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.palk_config_id_seq OWNER TO vlad;

--
-- TOC entry 2351 (class 0 OID 0)
-- Dependencies: 1757
-- Name: palk_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vlad
--

ALTER SEQUENCE palk_config_id_seq OWNED BY palk_config.id;


--
-- TOC entry 2352 (class 0 OID 0)
-- Dependencies: 1757
-- Name: palk_config_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vlad
--

SELECT pg_catalog.setval('palk_config_id_seq', 1, false);


--
-- TOC entry 1760 (class 1259 OID 64649)
-- Dependencies: 2116 2117 2118 2119 2120 2121 2122 2123 2124 6
-- Name: palk_kaart; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE palk_kaart (
    id integer NOT NULL,
    parentid integer NOT NULL,
    lepingid integer DEFAULT 0 NOT NULL,
    libid integer DEFAULT 0 NOT NULL,
    summa numeric(12,4) DEFAULT 0 NOT NULL,
    percent_ smallint DEFAULT 1 NOT NULL,
    tulumaks smallint DEFAULT 1 NOT NULL,
    tulumaar smallint DEFAULT 26 NOT NULL,
    status smallint DEFAULT 1 NOT NULL,
    muud text,
    alimentid integer DEFAULT 0 NOT NULL,
    tunnusid bigint DEFAULT 0 NOT NULL,
    vanaid integer
);


ALTER TABLE public.palk_kaart OWNER TO vlad;

--
-- TOC entry 1759 (class 1259 OID 64647)
-- Dependencies: 1760 6
-- Name: palk_kaart_id_seq; Type: SEQUENCE; Schema: public; Owner: vlad
--

CREATE SEQUENCE palk_kaart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.palk_kaart_id_seq OWNER TO vlad;

--
-- TOC entry 2355 (class 0 OID 0)
-- Dependencies: 1759
-- Name: palk_kaart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vlad
--

ALTER SEQUENCE palk_kaart_id_seq OWNED BY palk_kaart.id;


--
-- TOC entry 2356 (class 0 OID 0)
-- Dependencies: 1759
-- Name: palk_kaart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vlad
--

SELECT pg_catalog.setval('palk_kaart_id_seq', 1, false);


--
-- TOC entry 1762 (class 1259 OID 64667)
-- Dependencies: 2126 2127 2128 2129 2130 2131 6
-- Name: palk_taabel2; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE palk_taabel2 (
    id integer NOT NULL,
    parentid integer NOT NULL,
    kpv date DEFAULT ('now'::text)::date NOT NULL,
    too smallint DEFAULT 0 NOT NULL,
    paev smallint DEFAULT 0 NOT NULL,
    ohtu smallint DEFAULT 0 NOT NULL,
    puhkepaev smallint DEFAULT 0 NOT NULL,
    kas_puhkus smallint DEFAULT 0 NOT NULL,
    muud text
);


ALTER TABLE public.palk_taabel2 OWNER TO vlad;

--
-- TOC entry 1761 (class 1259 OID 64665)
-- Dependencies: 6 1762
-- Name: palk_taabel2_id_seq; Type: SEQUENCE; Schema: public; Owner: vlad
--

CREATE SEQUENCE palk_taabel2_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.palk_taabel2_id_seq OWNER TO vlad;

--
-- TOC entry 2359 (class 0 OID 0)
-- Dependencies: 1761
-- Name: palk_taabel2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vlad
--

ALTER SEQUENCE palk_taabel2_id_seq OWNED BY palk_taabel2.id;


--
-- TOC entry 2360 (class 0 OID 0)
-- Dependencies: 1761
-- Name: palk_taabel2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vlad
--

SELECT pg_catalog.setval('palk_taabel2_id_seq', 1, false);


--
-- TOC entry 1764 (class 1259 OID 64682)
-- Dependencies: 2133 2134 2135 2136 2137 6
-- Name: palk_tmpl; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE palk_tmpl (
    id integer NOT NULL,
    parentid integer NOT NULL,
    libid integer NOT NULL,
    percent_ integer DEFAULT 0 NOT NULL,
    summa numeric(12,4) DEFAULT 0 NOT NULL,
    tulumaar integer DEFAULT 26 NOT NULL,
    tulumaks integer DEFAULT 0 NOT NULL,
    tunnusid integer DEFAULT 0 NOT NULL,
    vanaid integer
);


ALTER TABLE public.palk_tmpl OWNER TO vlad;

--
-- TOC entry 1763 (class 1259 OID 64680)
-- Dependencies: 6 1764
-- Name: palk_tmpl_id_seq; Type: SEQUENCE; Schema: public; Owner: vlad
--

CREATE SEQUENCE palk_tmpl_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.palk_tmpl_id_seq OWNER TO vlad;

--
-- TOC entry 2363 (class 0 OID 0)
-- Dependencies: 1763
-- Name: palk_tmpl_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vlad
--

ALTER SEQUENCE palk_tmpl_id_seq OWNED BY palk_tmpl.id;


--
-- TOC entry 2364 (class 0 OID 0)
-- Dependencies: 1763
-- Name: palk_tmpl_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vlad
--

SELECT pg_catalog.setval('palk_tmpl_id_seq', 1, false);


SET default_with_oids = true;

--
-- TOC entry 1765 (class 1259 OID 64691)
-- Dependencies: 6
-- Name: pg_ts_cfg; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE pg_ts_cfg (
    ts_name text NOT NULL,
    prs_name text NOT NULL,
    locale text
);


ALTER TABLE public.pg_ts_cfg OWNER TO vlad;

--
-- TOC entry 1766 (class 1259 OID 64697)
-- Dependencies: 6
-- Name: pg_ts_cfgmap; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE pg_ts_cfgmap (
    ts_name text NOT NULL,
    tok_alias text NOT NULL,
    dict_name text[]
);


ALTER TABLE public.pg_ts_cfgmap OWNER TO vlad;

--
-- TOC entry 1767 (class 1259 OID 64703)
-- Dependencies: 6
-- Name: pg_ts_dict; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE pg_ts_dict (
    dict_name text NOT NULL,
    dict_init regprocedure,
    dict_initoption text,
    dict_lexize regprocedure NOT NULL,
    dict_comment text
);


ALTER TABLE public.pg_ts_dict OWNER TO vlad;

--
-- TOC entry 1768 (class 1259 OID 64710)
-- Dependencies: 6
-- Name: pg_ts_parser; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE pg_ts_parser (
    prs_name text NOT NULL,
    prs_start regprocedure NOT NULL,
    prs_nexttoken regprocedure NOT NULL,
    prs_end regprocedure NOT NULL,
    prs_headline regprocedure NOT NULL,
    prs_lextype regprocedure NOT NULL,
    prs_comment text
);


ALTER TABLE public.pg_ts_parser OWNER TO vlad;

SET default_with_oids = false;

--
-- TOC entry 1769 (class 1259 OID 64716)
-- Dependencies: 6
-- Name: pga_diagrams; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE pga_diagrams (
    diagramname character varying(64) NOT NULL,
    diagramtables text,
    diagramlinks text
);


ALTER TABLE public.pga_diagrams OWNER TO vlad;

--
-- TOC entry 1770 (class 1259 OID 64722)
-- Dependencies: 6
-- Name: pga_forms; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE pga_forms (
    formname character varying(64) NOT NULL,
    formsource text
);


ALTER TABLE public.pga_forms OWNER TO vlad;

--
-- TOC entry 1771 (class 1259 OID 64728)
-- Dependencies: 6
-- Name: pga_graphs; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE pga_graphs (
    graphname character varying(64) NOT NULL,
    graphsource text,
    graphcode text
);


ALTER TABLE public.pga_graphs OWNER TO vlad;

--
-- TOC entry 1772 (class 1259 OID 64734)
-- Dependencies: 6
-- Name: pga_images; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE pga_images (
    imagename character varying(64) NOT NULL,
    imagesource text
);


ALTER TABLE public.pga_images OWNER TO vlad;

--
-- TOC entry 1773 (class 1259 OID 64740)
-- Dependencies: 6
-- Name: pga_layout; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE pga_layout (
    tablename character varying(64) NOT NULL,
    nrcols smallint,
    colnames text,
    colwidth text
);


ALTER TABLE public.pga_layout OWNER TO vlad;

--
-- TOC entry 1774 (class 1259 OID 64746)
-- Dependencies: 6
-- Name: pga_queries; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE pga_queries (
    queryname character varying(64) NOT NULL,
    querytype character(1),
    querycommand text,
    querytables text,
    querylinks text,
    queryresults text,
    querycomments text
);


ALTER TABLE public.pga_queries OWNER TO vlad;

--
-- TOC entry 1775 (class 1259 OID 64752)
-- Dependencies: 6
-- Name: pga_reports; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE pga_reports (
    reportname character varying(64) NOT NULL,
    reportsource text,
    reportbody text,
    reportprocs text,
    reportoptions text
);


ALTER TABLE public.pga_reports OWNER TO vlad;

--
-- TOC entry 1776 (class 1259 OID 64758)
-- Dependencies: 6
-- Name: pga_scripts; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE pga_scripts (
    scriptname character varying(64) NOT NULL,
    scriptsource text
);


ALTER TABLE public.pga_scripts OWNER TO vlad;

--
-- TOC entry 1778 (class 1259 OID 64766)
-- Dependencies: 2139 2140 2141 2142 2143 2144 2145 6
-- Name: puudumine; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE puudumine (
    id integer NOT NULL,
    kpv1 date DEFAULT ('now'::text)::date NOT NULL,
    kpv2 date DEFAULT ('now'::text)::date NOT NULL,
    paevad integer DEFAULT 0 NOT NULL,
    summa numeric(12,4) DEFAULT 0 NOT NULL,
    tunnus integer DEFAULT 0 NOT NULL,
    tyyp integer DEFAULT 0 NOT NULL,
    muud text,
    libid integer DEFAULT 0,
    lepingid integer
);


ALTER TABLE public.puudumine OWNER TO vlad;

--
-- TOC entry 1777 (class 1259 OID 64764)
-- Dependencies: 1778 6
-- Name: puudumine_id_seq; Type: SEQUENCE; Schema: public; Owner: vlad
--

CREATE SEQUENCE puudumine_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.puudumine_id_seq OWNER TO vlad;

--
-- TOC entry 2367 (class 0 OID 0)
-- Dependencies: 1777
-- Name: puudumine_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vlad
--

ALTER SEQUENCE puudumine_id_seq OWNED BY puudumine.id;


--
-- TOC entry 2368 (class 0 OID 0)
-- Dependencies: 1777
-- Name: puudumine_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vlad
--

SELECT pg_catalog.setval('puudumine_id_seq', 1, false);


--
-- TOC entry 1780 (class 1259 OID 64784)
-- Dependencies: 2147 2148 2149 2150 2151 2152 2153 2154 6
-- Name: tulud1; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE tulud1 (
    id integer NOT NULL,
    rekvid integer NOT NULL,
    kpv date DEFAULT ('now'::text)::date NOT NULL,
    journalid integer DEFAULT 0 NOT NULL,
    summa numeric(12,4) DEFAULT 0 NOT NULL,
    dokpropid integer DEFAULT 0 NOT NULL,
    muud text,
    konto character varying(20) DEFAULT '100100'::character varying,
    liik smallint DEFAULT 1,
    userid integer DEFAULT 0,
    opt integer DEFAULT 1
);


ALTER TABLE public.tulud1 OWNER TO vlad;

--
-- TOC entry 1779 (class 1259 OID 64782)
-- Dependencies: 6 1780
-- Name: tulud1_id_seq; Type: SEQUENCE; Schema: public; Owner: vlad
--

CREATE SEQUENCE tulud1_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.tulud1_id_seq OWNER TO vlad;

--
-- TOC entry 2371 (class 0 OID 0)
-- Dependencies: 1779
-- Name: tulud1_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vlad
--

ALTER SEQUENCE tulud1_id_seq OWNED BY tulud1.id;


--
-- TOC entry 2372 (class 0 OID 0)
-- Dependencies: 1779
-- Name: tulud1_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vlad
--

SELECT pg_catalog.setval('tulud1_id_seq', 1, false);


--
-- TOC entry 1782 (class 1259 OID 64802)
-- Dependencies: 2156 6
-- Name: tunnusinf; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE tunnusinf (
    id integer NOT NULL,
    tunnusid integer NOT NULL,
    kontoid integer NOT NULL,
    rekvid integer NOT NULL,
    algsaldo numeric(12,4) DEFAULT 0 NOT NULL,
    muud text
);


ALTER TABLE public.tunnusinf OWNER TO vlad;

--
-- TOC entry 1781 (class 1259 OID 64800)
-- Dependencies: 1782 6
-- Name: tunnusinf_id_seq; Type: SEQUENCE; Schema: public; Owner: vlad
--

CREATE SEQUENCE tunnusinf_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.tunnusinf_id_seq OWNER TO vlad;

--
-- TOC entry 2375 (class 0 OID 0)
-- Dependencies: 1781
-- Name: tunnusinf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vlad
--

ALTER SEQUENCE tunnusinf_id_seq OWNED BY tunnusinf.id;


--
-- TOC entry 2376 (class 0 OID 0)
-- Dependencies: 1781
-- Name: tunnusinf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vlad
--

SELECT pg_catalog.setval('tunnusinf_id_seq', 1, false);


--
-- TOC entry 1783 (class 1259 OID 64810)
-- Dependencies: 6
-- Name: v_aa; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE v_aa (
    id integer,
    parentid integer,
    arve character(20),
    nimetus character(254),
    saldo numeric(12,4),
    default_ smallint,
    kassa integer,
    pank integer,
    konto character(20),
    muud text,
    tp character varying(20)
);


ALTER TABLE public.v_aa OWNER TO vlad;

--
-- TOC entry 1784 (class 1259 OID 64816)
-- Dependencies: 6
-- Name: v_userid; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE v_userid (
    id integer,
    rekvid integer,
    kasutaja character(50),
    ametnik character(254),
    parool text,
    kasutaja_ integer,
    peakasutaja_ integer,
    admin integer,
    muud text
);


ALTER TABLE public.v_userid OWNER TO vlad;

--
-- TOC entry 1785 (class 1259 OID 64822)
-- Dependencies: 6
-- Name: v_vanemsaldo; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE v_vanemsaldo (
    kassa numeric,
    fakt numeric
);


ALTER TABLE public.v_vanemsaldo OWNER TO vlad;

--
-- TOC entry 1787 (class 1259 OID 64830)
-- Dependencies: 2158 2159 2160 2161 2162 2163 6
-- Name: vanemtasu6; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE vanemtasu6 (
    id integer NOT NULL,
    parentid integer DEFAULT 0 NOT NULL,
    nomid integer DEFAULT 0 NOT NULL,
    arvereaid integer DEFAULT 0 NOT NULL,
    hind numeric(14,2) DEFAULT 0 NOT NULL,
    kogus numeric(14,4) DEFAULT 0 NOT NULL,
    summa numeric(14,2) DEFAULT 0 NOT NULL,
    muud text
);


ALTER TABLE public.vanemtasu6 OWNER TO vlad;

--
-- TOC entry 1786 (class 1259 OID 64828)
-- Dependencies: 1787 6
-- Name: vanemtasu6_id_seq; Type: SEQUENCE; Schema: public; Owner: vlad
--

CREATE SEQUENCE vanemtasu6_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.vanemtasu6_id_seq OWNER TO vlad;

--
-- TOC entry 2379 (class 0 OID 0)
-- Dependencies: 1786
-- Name: vanemtasu6_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vlad
--

ALTER SEQUENCE vanemtasu6_id_seq OWNED BY vanemtasu6.id;


--
-- TOC entry 2380 (class 0 OID 0)
-- Dependencies: 1786
-- Name: vanemtasu6_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vlad
--

SELECT pg_catalog.setval('vanemtasu6_id_seq', 1, false);


--
-- TOC entry 1789 (class 1259 OID 64845)
-- Dependencies: 6
-- Name: vastisikud; Type: TABLE; Schema: public; Owner: vlad; Tablespace: 
--

CREATE TABLE vastisikud (
    id integer NOT NULL,
    isikid integer NOT NULL
);


ALTER TABLE public.vastisikud OWNER TO vlad;

--
-- TOC entry 1788 (class 1259 OID 64843)
-- Dependencies: 6 1789
-- Name: vastisikud_id_seq; Type: SEQUENCE; Schema: public; Owner: vlad
--

CREATE SEQUENCE vastisikud_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.vastisikud_id_seq OWNER TO vlad;

--
-- TOC entry 2382 (class 0 OID 0)
-- Dependencies: 1788
-- Name: vastisikud_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vlad
--

ALTER SEQUENCE vastisikud_id_seq OWNED BY vastisikud.id;


--
-- TOC entry 2383 (class 0 OID 0)
-- Dependencies: 1788
-- Name: vastisikud_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vlad
--

SELECT pg_catalog.setval('vastisikud_id_seq', 1, false);


--
-- TOC entry 2070 (class 2604 OID 64529)
-- Dependencies: 1737 1736 1737
-- Name: id; Type: DEFAULT; Schema: public; Owner: vlad
--

ALTER TABLE avans3 ALTER COLUMN id SET DEFAULT nextval('avans3_id_seq'::regclass);


--
-- TOC entry 2081 (class 2604 OID 64557)
-- Dependencies: 1741 1742 1742
-- Name: id; Type: DEFAULT; Schema: public; Owner: vlad
--

ALTER TABLE dbase ALTER COLUMN id SET DEFAULT nextval('dbase_id_seq'::regclass);


--
-- TOC entry 2084 (class 2604 OID 64565)
-- Dependencies: 1743 1744 1744
-- Name: id; Type: DEFAULT; Schema: public; Owner: vlad
--

ALTER TABLE eel_config ALTER COLUMN id SET DEFAULT nextval('eel_config_id_seq'::regclass);


--
-- TOC entry 2087 (class 2604 OID 64576)
-- Dependencies: 1745 1746 1746
-- Name: id; Type: DEFAULT; Schema: public; Owner: vlad
--

ALTER TABLE eelarveinf ALTER COLUMN id SET DEFAULT nextval('eelarveinf_id_seq'::regclass);


--
-- TOC entry 2169 (class 2604 OID 167071)
-- Dependencies: 1791 1790
-- Name: id; Type: DEFAULT; Schema: public; Owner: vlad
--

ALTER TABLE kaardid ALTER COLUMN id SET DEFAULT nextval('kaardid_id_seq'::regclass);


--
-- TOC entry 2093 (class 2604 OID 64590)
-- Dependencies: 1748 1747 1748
-- Name: id; Type: DEFAULT; Schema: public; Owner: vlad
--

ALTER TABLE ladu_config ALTER COLUMN id SET DEFAULT nextval('ladu_config_id_seq'::regclass);


--
-- TOC entry 2095 (class 2604 OID 64597)
-- Dependencies: 1749 1750 1750
-- Name: id; Type: DEFAULT; Schema: public; Owner: vlad
--

ALTER TABLE ladu_grupp ALTER COLUMN id SET DEFAULT nextval('ladu_grupp_id_seq'::regclass);


--
-- TOC entry 2072 (class 2604 OID 64539)
-- Dependencies: 1739 1738 1739
-- Name: id; Type: DEFAULT; Schema: public; Owner: vlad
--

ALTER TABLE ladu_jaak ALTER COLUMN id SET DEFAULT nextval('ladu_jaak_id_seq'::regclass);


--
-- TOC entry 2097 (class 2604 OID 64607)
-- Dependencies: 1753 1752 1753
-- Name: id; Type: DEFAULT; Schema: public; Owner: vlad
--

ALTER TABLE leping3 ALTER COLUMN id SET DEFAULT nextval('leping3_id_seq'::regclass);


--
-- TOC entry 2101 (class 2604 OID 64625)
-- Dependencies: 1756 1755 1756
-- Name: id; Type: DEFAULT; Schema: public; Owner: vlad
--

ALTER TABLE palk_asutus ALTER COLUMN id SET DEFAULT nextval('palk_asutus_id_seq'::regclass);


--
-- TOC entry 2108 (class 2604 OID 64640)
-- Dependencies: 1758 1757 1758
-- Name: id; Type: DEFAULT; Schema: public; Owner: vlad
--

ALTER TABLE palk_config ALTER COLUMN id SET DEFAULT nextval('palk_config_id_seq'::regclass);


--
-- TOC entry 2115 (class 2604 OID 64652)
-- Dependencies: 1759 1760 1760
-- Name: id; Type: DEFAULT; Schema: public; Owner: vlad
--

ALTER TABLE palk_kaart ALTER COLUMN id SET DEFAULT nextval('palk_kaart_id_seq'::regclass);


--
-- TOC entry 2125 (class 2604 OID 64670)
-- Dependencies: 1762 1761 1762
-- Name: id; Type: DEFAULT; Schema: public; Owner: vlad
--

ALTER TABLE palk_taabel2 ALTER COLUMN id SET DEFAULT nextval('palk_taabel2_id_seq'::regclass);


--
-- TOC entry 2132 (class 2604 OID 64685)
-- Dependencies: 1763 1764 1764
-- Name: id; Type: DEFAULT; Schema: public; Owner: vlad
--

ALTER TABLE palk_tmpl ALTER COLUMN id SET DEFAULT nextval('palk_tmpl_id_seq'::regclass);


--
-- TOC entry 2138 (class 2604 OID 64769)
-- Dependencies: 1778 1777 1778
-- Name: id; Type: DEFAULT; Schema: public; Owner: vlad
--

ALTER TABLE puudumine ALTER COLUMN id SET DEFAULT nextval('puudumine_id_seq'::regclass);


--
-- TOC entry 2146 (class 2604 OID 64787)
-- Dependencies: 1779 1780 1780
-- Name: id; Type: DEFAULT; Schema: public; Owner: vlad
--

ALTER TABLE tulud1 ALTER COLUMN id SET DEFAULT nextval('tulud1_id_seq'::regclass);


--
-- TOC entry 2155 (class 2604 OID 64805)
-- Dependencies: 1782 1781 1782
-- Name: id; Type: DEFAULT; Schema: public; Owner: vlad
--

ALTER TABLE tunnusinf ALTER COLUMN id SET DEFAULT nextval('tunnusinf_id_seq'::regclass);


--
-- TOC entry 2157 (class 2604 OID 64833)
-- Dependencies: 1787 1786 1787
-- Name: id; Type: DEFAULT; Schema: public; Owner: vlad
--

ALTER TABLE vanemtasu6 ALTER COLUMN id SET DEFAULT nextval('vanemtasu6_id_seq'::regclass);


--
-- TOC entry 2164 (class 2604 OID 64848)
-- Dependencies: 1789 1788 1789
-- Name: id; Type: DEFAULT; Schema: public; Owner: vlad
--

ALTER TABLE vastisikud ALTER COLUMN id SET DEFAULT nextval('vastisikud_id_seq'::regclass);


--
-- TOC entry 2261 (class 0 OID 64526)
-- Dependencies: 1737
-- Data for Name: avans3; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY avans3 (id, parentid, dokid, liik, muud) FROM stdin;
\.


--
-- TOC entry 2263 (class 0 OID 64554)
-- Dependencies: 1742
-- Data for Name: dbase; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY dbase (id, alias, lastnum, doknum) FROM stdin;
1	1ASUTUS2006                                       	24	0
\.


--
-- TOC entry 2264 (class 0 OID 64562)
-- Dependencies: 1744
-- Data for Name: eel_config; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY eel_config (id, rekvid, kontrol, reserv1, reserv2, reserv3, valklassif) FROM stdin;
1	1	0				0
\.


--
-- TOC entry 2265 (class 0 OID 64573)
-- Dependencies: 1746
-- Data for Name: eelarveinf; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY eelarveinf (id, allikadid, rahavooid, kontoid, rekvid, algsaldo, muud) FROM stdin;
\.


--
-- TOC entry 2296 (class 0 OID 167059)
-- Dependencies: 1790
-- Data for Name: kaardid; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY kaardid (id, kpv, luno, kasutaja, uleantud, vastuvotja, muud, "timestamp", number, omanik) FROM stdin;
\.


--
-- TOC entry 2266 (class 0 OID 64587)
-- Dependencies: 1748
-- Data for Name: ladu_config; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY ladu_config (id, rekvid, liik) FROM stdin;
1	1	1
\.


--
-- TOC entry 2267 (class 0 OID 64594)
-- Dependencies: 1750
-- Data for Name: ladu_grupp; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY ladu_grupp (id, parentid, nomid) FROM stdin;
1	275	11
\.


--
-- TOC entry 2262 (class 0 OID 64536)
-- Dependencies: 1739
-- Data for Name: ladu_jaak; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY ladu_jaak (id, rekvid, dokitemid, nomid, userid, kpv, hind, kogus, maha, jaak) FROM stdin;
158	1	2	1	1	2006-03-10	100.0000	1.000	0.000	1.000
159	1	5	11	1	2006-03-13	1.0000	3.000	0.000	3.000
160	1	3	11	1	2006-03-13	1.0000	1.000	0.000	1.000
161	1	5	11	1	2006-03-13	1.0000	3.000	0.000	3.000
162	1	3	11	1	2006-03-13	1.0000	1.000	0.000	1.000
\.


--
-- TOC entry 2268 (class 0 OID 64599)
-- Dependencies: 1751
-- Data for Name: lcdbkonto; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY lcdbkonto (kood) FROM stdin;
\.


--
-- TOC entry 2269 (class 0 OID 64604)
-- Dependencies: 1753
-- Data for Name: leping3; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY leping3 (id, parentid, kpv, algkogus, loppkogus, muud) FROM stdin;
\.


--
-- TOC entry 2270 (class 0 OID 64614)
-- Dependencies: 1754
-- Data for Name: lnarvjaak; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY lnarvjaak ("?column?") FROM stdin;
\.


--
-- TOC entry 2271 (class 0 OID 64622)
-- Dependencies: 1756
-- Data for Name: palk_asutus; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY palk_asutus (id, rekvid, osakondid, ametid, kogus, vaba, palgamaar, muud, tunnusid, vanaid) FROM stdin;
2	1	248	413	1.00	0.00	0		0	\N
3	1	246	414	1.00	0.00	0		0	\N
1	1	247	412	1.00	0.00	0		0	\N
\.


--
-- TOC entry 2272 (class 0 OID 64637)
-- Dependencies: 1758
-- Data for Name: palk_config; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY palk_config (id, rekvid, minpalk, tulubaas, round, jaak, genlausend, suurasu) FROM stdin;
1	1	0.0000	0.0000	0.0000	0	1	0
\.


--
-- TOC entry 2273 (class 0 OID 64649)
-- Dependencies: 1760
-- Data for Name: palk_kaart; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY palk_kaart (id, parentid, lepingid, libid, summa, percent_, tulumaks, tulumaar, status, muud, alimentid, tunnusid, vanaid) FROM stdin;
1	2	1	415	100.0000	1	1	1	1		0	0	\N
2	2	1	421	2.0000	1	1	1	1		0	0	\N
3	2	1	416	33.0000	1	0	1	1		0	0	\N
4	2	1	420	100.0000	1	0	1	1		0	0	\N
5	2	1	418	0.3000	1	0	1	1		0	0	\N
6	2	1	419	0.6000	1	1	1	1		0	0	\N
\.


--
-- TOC entry 2274 (class 0 OID 64667)
-- Dependencies: 1762
-- Data for Name: palk_taabel2; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY palk_taabel2 (id, parentid, kpv, too, paev, ohtu, puhkepaev, kas_puhkus, muud) FROM stdin;
\.


--
-- TOC entry 2275 (class 0 OID 64682)
-- Dependencies: 1764
-- Data for Name: palk_tmpl; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY palk_tmpl (id, parentid, libid, percent_, summa, tulumaar, tulumaks, tunnusid, vanaid) FROM stdin;
1	412	415	1	100.0000	1	1	0	\N
5	412	418	1	0.3000	1	0	0	\N
3	412	416	1	33.0000	1	0	0	\N
4	412	420	1	100.0000	1	0	0	\N
2	412	421	1	2.0000	1	1	0	\N
6	412	419	1	0.6000	1	1	0	\N
1	412	415	1	100.0000	1	1	0	\N
5	412	418	1	0.3000	1	0	0	\N
3	412	416	1	33.0000	1	0	0	\N
4	412	420	1	100.0000	1	0	0	\N
2	412	421	1	2.0000	1	1	0	\N
6	412	419	1	0.6000	1	1	0	\N
\.


--
-- TOC entry 2276 (class 0 OID 64691)
-- Dependencies: 1765
-- Data for Name: pg_ts_cfg; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY pg_ts_cfg (ts_name, prs_name, locale) FROM stdin;
default	default	C
default_russian	default	ru_RU.KOI8-R
simple	default	\N
\.


--
-- TOC entry 2277 (class 0 OID 64697)
-- Dependencies: 1766
-- Data for Name: pg_ts_cfgmap; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY pg_ts_cfgmap (ts_name, tok_alias, dict_name) FROM stdin;
default	lword	{en_stem}
default	nlword	{simple}
default	word	{simple}
default	email	{simple}
default	url	{simple}
default	host	{simple}
default	sfloat	{simple}
default	version	{simple}
default	part_hword	{simple}
default	nlpart_hword	{simple}
default	lpart_hword	{en_stem}
default	hword	{simple}
default	lhword	{en_stem}
default	nlhword	{simple}
default	uri	{simple}
default	file	{simple}
default	float	{simple}
default	int	{simple}
default	uint	{simple}
default_russian	lword	{en_stem}
default_russian	nlword	{ru_stem}
default_russian	word	{ru_stem}
default_russian	email	{simple}
default_russian	url	{simple}
default_russian	host	{simple}
default_russian	sfloat	{simple}
default_russian	version	{simple}
default_russian	part_hword	{simple}
default_russian	nlpart_hword	{ru_stem}
default_russian	lpart_hword	{en_stem}
default_russian	hword	{ru_stem}
default_russian	lhword	{en_stem}
default_russian	nlhword	{ru_stem}
default_russian	uri	{simple}
default_russian	file	{simple}
default_russian	float	{simple}
default_russian	int	{simple}
default_russian	uint	{simple}
simple	lword	{simple}
simple	nlword	{simple}
simple	word	{simple}
simple	email	{simple}
simple	url	{simple}
simple	host	{simple}
simple	sfloat	{simple}
simple	version	{simple}
simple	part_hword	{simple}
simple	nlpart_hword	{simple}
simple	lpart_hword	{simple}
simple	hword	{simple}
simple	lhword	{simple}
simple	nlhword	{simple}
simple	uri	{simple}
simple	file	{simple}
simple	float	{simple}
simple	int	{simple}
simple	uint	{simple}
\.


--
-- TOC entry 2278 (class 0 OID 64703)
-- Dependencies: 1767
-- Data for Name: pg_ts_dict; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY pg_ts_dict (dict_name, dict_init, dict_initoption, dict_lexize, dict_comment) FROM stdin;
\.


--
-- TOC entry 2279 (class 0 OID 64710)
-- Dependencies: 1768
-- Data for Name: pg_ts_parser; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY pg_ts_parser (prs_name, prs_start, prs_nexttoken, prs_end, prs_headline, prs_lextype, prs_comment) FROM stdin;
\.


--
-- TOC entry 2280 (class 0 OID 64716)
-- Dependencies: 1769
-- Data for Name: pga_diagrams; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY pga_diagrams (diagramname, diagramtables, diagramlinks) FROM stdin;
\.


--
-- TOC entry 2281 (class 0 OID 64722)
-- Dependencies: 1770
-- Data for Name: pga_forms; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY pga_forms (formname, formsource) FROM stdin;
\.


--
-- TOC entry 2282 (class 0 OID 64728)
-- Dependencies: 1771
-- Data for Name: pga_graphs; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY pga_graphs (graphname, graphsource, graphcode) FROM stdin;
\.


--
-- TOC entry 2283 (class 0 OID 64734)
-- Dependencies: 1772
-- Data for Name: pga_images; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY pga_images (imagename, imagesource) FROM stdin;
\.


--
-- TOC entry 2284 (class 0 OID 64740)
-- Dependencies: 1773
-- Data for Name: pga_layout; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY pga_layout (tablename, nrcols, colnames, colwidth) FROM stdin;
\.


--
-- TOC entry 2285 (class 0 OID 64746)
-- Dependencies: 1774
-- Data for Name: pga_queries; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY pga_queries (queryname, querytype, querycommand, querytables, querylinks, queryresults, querycomments) FROM stdin;
\.


--
-- TOC entry 2286 (class 0 OID 64752)
-- Dependencies: 1775
-- Data for Name: pga_reports; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY pga_reports (reportname, reportsource, reportbody, reportprocs, reportoptions) FROM stdin;
\.


--
-- TOC entry 2287 (class 0 OID 64758)
-- Dependencies: 1776
-- Data for Name: pga_scripts; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY pga_scripts (scriptname, scriptsource) FROM stdin;
\.


--
-- TOC entry 2288 (class 0 OID 64766)
-- Dependencies: 1778
-- Data for Name: puudumine; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY puudumine (id, kpv1, kpv2, paevad, summa, tunnus, tyyp, muud, libid, lepingid) FROM stdin;
1	2006-03-13	2006-03-19	7	0.0000	1	1		0	1
\.


--
-- TOC entry 2289 (class 0 OID 64784)
-- Dependencies: 1780
-- Data for Name: tulud1; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY tulud1 (id, rekvid, kpv, journalid, summa, dokpropid, muud, konto, liik, userid, opt) FROM stdin;
\.


--
-- TOC entry 2290 (class 0 OID 64802)
-- Dependencies: 1782
-- Data for Name: tunnusinf; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY tunnusinf (id, tunnusid, kontoid, rekvid, algsaldo, muud) FROM stdin;
1	267	14	1	0.0000	\N
2	267	13	1	0.0000	\N
3	267	150	1	0.0000	\N
4	267	16	1	0.0000	\N
5	267	139	1	0.0000	\N
6	267	7	1	0.0000	\N
7	267	6	1	0.0000	\N
8	267	9	1	0.0000	\N
9	267	3	1	0.0000	\N
10	267	1	1	0.0000	\N
11	267	42	1	0.0000	\N
12	267	39	1	0.0000	\N
13	267	38	1	0.0000	\N
14	267	159	1	0.0000	\N
15	267	29	1	0.0000	\N
16	267	158	1	0.0000	\N
17	267	26	1	0.0000	\N
18	267	157	1	0.0000	\N
19	267	156	1	0.0000	\N
20	267	155	1	0.0000	\N
21	267	22	1	0.0000	\N
22	267	154	1	0.0000	\N
23	267	20	1	0.0000	\N
24	267	19	1	0.0000	\N
25	267	18	1	0.0000	\N
26	267	17	1	0.0000	\N
27	267	153	1	0.0000	\N
28	267	152	1	0.0000	\N
29	267	151	1	0.0000	\N
30	267	15	1	0.0000	\N
31	267	149	1	0.0000	\N
32	267	173	1	0.0000	\N
33	267	49	1	0.0000	\N
34	267	147	1	0.0000	\N
35	267	48	1	0.0000	\N
36	267	172	1	0.0000	\N
37	267	47	1	0.0000	\N
38	267	171	1	0.0000	\N
39	267	170	1	0.0000	\N
40	267	169	1	0.0000	\N
41	267	46	1	0.0000	\N
42	267	168	1	0.0000	\N
43	267	45	1	0.0000	\N
44	267	167	1	0.0000	\N
45	267	166	1	0.0000	\N
46	267	165	1	0.0000	\N
47	267	164	1	0.0000	\N
48	267	163	1	0.0000	\N
49	267	162	1	0.0000	\N
50	267	161	1	0.0000	\N
51	267	160	1	0.0000	\N
52	267	188	1	0.0000	\N
53	267	187	1	0.0000	\N
54	267	185	1	0.0000	\N
55	267	184	1	0.0000	\N
56	267	183	1	0.0000	\N
57	267	182	1	0.0000	\N
58	267	181	1	0.0000	\N
59	267	180	1	0.0000	\N
60	267	179	1	0.0000	\N
61	267	178	1	0.0000	\N
62	267	177	1	0.0000	\N
63	267	176	1	0.0000	\N
64	267	53	1	0.0000	\N
65	267	52	1	0.0000	\N
66	267	175	1	0.0000	\N
67	267	174	1	0.0000	\N
68	267	204	1	0.0000	\N
69	267	203	1	0.0000	\N
70	267	202	1	0.0000	\N
71	267	201	1	0.0000	\N
72	267	60	1	0.0000	\N
73	267	200	1	0.0000	\N
74	267	199	1	0.0000	\N
75	267	198	1	0.0000	\N
76	267	197	1	0.0000	\N
77	267	196	1	0.0000	\N
78	267	195	1	0.0000	\N
79	267	194	1	0.0000	\N
80	267	193	1	0.0000	\N
81	267	192	1	0.0000	\N
82	267	191	1	0.0000	\N
83	267	190	1	0.0000	\N
84	267	189	1	0.0000	\N
85	267	245	1	0.0000	\N
86	267	56	1	0.0000	\N
87	267	217	1	0.0000	\N
88	267	216	1	0.0000	\N
89	267	215	1	0.0000	\N
90	267	214	1	0.0000	\N
91	267	213	1	0.0000	\N
92	267	209	1	0.0000	\N
93	267	208	1	0.0000	\N
94	267	100	1	0.0000	\N
95	267	211	1	0.0000	\N
96	267	210	1	0.0000	\N
97	267	212	1	0.0000	\N
98	267	207	1	0.0000	\N
99	267	206	1	0.0000	\N
100	267	205	1	0.0000	\N
101	267	232	1	0.0000	\N
102	267	231	1	0.0000	\N
103	267	230	1	0.0000	\N
104	267	229	1	0.0000	\N
105	267	227	1	0.0000	\N
106	267	244	1	0.0000	\N
107	267	228	1	0.0000	\N
108	267	226	1	0.0000	\N
109	267	225	1	0.0000	\N
110	267	224	1	0.0000	\N
111	267	223	1	0.0000	\N
112	267	222	1	0.0000	\N
113	267	220	1	0.0000	\N
114	267	221	1	0.0000	\N
115	267	219	1	0.0000	\N
116	267	218	1	0.0000	\N
117	267	235	1	0.0000	\N
118	267	234	1	0.0000	\N
119	267	233	1	0.0000	\N
120	267	138	1	0.0000	\N
121	267	141	1	0.0000	\N
122	267	2	1	0.0000	\N
123	267	410	1	0.0000	\N
\.


--
-- TOC entry 2291 (class 0 OID 64810)
-- Dependencies: 1783
-- Data for Name: v_aa; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY v_aa (id, parentid, arve, nimetus, saldo, default_, kassa, pank, konto, muud, tp) FROM stdin;
\.


--
-- TOC entry 2292 (class 0 OID 64816)
-- Dependencies: 1784
-- Data for Name: v_userid; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY v_userid (id, rekvid, kasutaja, ametnik, parool, kasutaja_, peakasutaja_, admin, muud) FROM stdin;
\.


--
-- TOC entry 2293 (class 0 OID 64822)
-- Dependencies: 1785
-- Data for Name: v_vanemsaldo; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY v_vanemsaldo (kassa, fakt) FROM stdin;
\.


--
-- TOC entry 2294 (class 0 OID 64830)
-- Dependencies: 1787
-- Data for Name: vanemtasu6; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY vanemtasu6 (id, parentid, nomid, arvereaid, hind, kogus, summa, muud) FROM stdin;
\.


--
-- TOC entry 2295 (class 0 OID 64845)
-- Dependencies: 1789
-- Data for Name: vastisikud; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY vastisikud (id, isikid) FROM stdin;
\.


--
-- TOC entry 2173 (class 2606 OID 64910)
-- Dependencies: 1737 1737
-- Name: avans3_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY avans3
    ADD CONSTRAINT avans3_pkey PRIMARY KEY (id);


--
-- TOC entry 2182 (class 2606 OID 64915)
-- Dependencies: 1742 1742
-- Name: dbase_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY dbase
    ADD CONSTRAINT dbase_pkey PRIMARY KEY (id);


--
-- TOC entry 2184 (class 2606 OID 64917)
-- Dependencies: 1744 1744
-- Name: eel_config_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY eel_config
    ADD CONSTRAINT eel_config_pkey PRIMARY KEY (id);


--
-- TOC entry 2187 (class 2606 OID 64919)
-- Dependencies: 1746 1746
-- Name: eelarveinf_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY eelarveinf
    ADD CONSTRAINT eelarveinf_pkey PRIMARY KEY (id);


--
-- TOC entry 2260 (class 2606 OID 167073)
-- Dependencies: 1790 1790
-- Name: kaardid_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY kaardid
    ADD CONSTRAINT kaardid_pkey PRIMARY KEY (id);


--
-- TOC entry 2190 (class 2606 OID 64921)
-- Dependencies: 1748 1748
-- Name: ladu_config_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY ladu_config
    ADD CONSTRAINT ladu_config_pkey PRIMARY KEY (id);


--
-- TOC entry 2194 (class 2606 OID 64923)
-- Dependencies: 1750 1750
-- Name: ladu_grupp_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY ladu_grupp
    ADD CONSTRAINT ladu_grupp_pkey PRIMARY KEY (id);


--
-- TOC entry 2179 (class 2606 OID 64925)
-- Dependencies: 1739 1739
-- Name: ladu_jaak_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY ladu_jaak
    ADD CONSTRAINT ladu_jaak_pkey PRIMARY KEY (id);


--
-- TOC entry 2197 (class 2606 OID 64927)
-- Dependencies: 1753 1753
-- Name: leping3_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY leping3
    ADD CONSTRAINT leping3_pkey PRIMARY KEY (id);


--
-- TOC entry 2200 (class 2606 OID 64929)
-- Dependencies: 1756 1756
-- Name: palk_asutus_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY palk_asutus
    ADD CONSTRAINT palk_asutus_pkey PRIMARY KEY (id);


--
-- TOC entry 2203 (class 2606 OID 64932)
-- Dependencies: 1758 1758
-- Name: palk_config_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY palk_config
    ADD CONSTRAINT palk_config_pkey PRIMARY KEY (id);


--
-- TOC entry 2207 (class 2606 OID 64934)
-- Dependencies: 1760 1760
-- Name: palk_kaart_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY palk_kaart
    ADD CONSTRAINT palk_kaart_pkey PRIMARY KEY (id);


--
-- TOC entry 2211 (class 2606 OID 64936)
-- Dependencies: 1762 1762
-- Name: palk_taabel2_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY palk_taabel2
    ADD CONSTRAINT palk_taabel2_pkey PRIMARY KEY (id);


--
-- TOC entry 2214 (class 2606 OID 64938)
-- Dependencies: 1765 1765
-- Name: pg_ts_cfg_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY pg_ts_cfg
    ADD CONSTRAINT pg_ts_cfg_pkey PRIMARY KEY (ts_name);


--
-- TOC entry 2216 (class 2606 OID 64940)
-- Dependencies: 1766 1766 1766
-- Name: pg_ts_cfgmap_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY pg_ts_cfgmap
    ADD CONSTRAINT pg_ts_cfgmap_pkey PRIMARY KEY (ts_name, tok_alias);


--
-- TOC entry 2218 (class 2606 OID 64942)
-- Dependencies: 1767 1767
-- Name: pg_ts_dict_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY pg_ts_dict
    ADD CONSTRAINT pg_ts_dict_pkey PRIMARY KEY (dict_name);


--
-- TOC entry 2220 (class 2606 OID 64944)
-- Dependencies: 1768 1768
-- Name: pg_ts_parser_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY pg_ts_parser
    ADD CONSTRAINT pg_ts_parser_pkey PRIMARY KEY (prs_name);


--
-- TOC entry 2222 (class 2606 OID 64946)
-- Dependencies: 1769 1769
-- Name: pga_diagrams_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY pga_diagrams
    ADD CONSTRAINT pga_diagrams_pkey PRIMARY KEY (diagramname);


--
-- TOC entry 2224 (class 2606 OID 64948)
-- Dependencies: 1770 1770
-- Name: pga_forms_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY pga_forms
    ADD CONSTRAINT pga_forms_pkey PRIMARY KEY (formname);


--
-- TOC entry 2226 (class 2606 OID 64950)
-- Dependencies: 1771 1771
-- Name: pga_graphs_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY pga_graphs
    ADD CONSTRAINT pga_graphs_pkey PRIMARY KEY (graphname);


--
-- TOC entry 2228 (class 2606 OID 64952)
-- Dependencies: 1772 1772
-- Name: pga_images_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY pga_images
    ADD CONSTRAINT pga_images_pkey PRIMARY KEY (imagename);


--
-- TOC entry 2230 (class 2606 OID 64954)
-- Dependencies: 1773 1773
-- Name: pga_layout_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY pga_layout
    ADD CONSTRAINT pga_layout_pkey PRIMARY KEY (tablename);


--
-- TOC entry 2232 (class 2606 OID 64956)
-- Dependencies: 1774 1774
-- Name: pga_queries_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY pga_queries
    ADD CONSTRAINT pga_queries_pkey PRIMARY KEY (queryname);


--
-- TOC entry 2234 (class 2606 OID 64958)
-- Dependencies: 1775 1775
-- Name: pga_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY pga_reports
    ADD CONSTRAINT pga_reports_pkey PRIMARY KEY (reportname);


--
-- TOC entry 2236 (class 2606 OID 64960)
-- Dependencies: 1776 1776
-- Name: pga_scripts_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY pga_scripts
    ADD CONSTRAINT pga_scripts_pkey PRIMARY KEY (scriptname);


--
-- TOC entry 2239 (class 2606 OID 64962)
-- Dependencies: 1778 1778
-- Name: puudumine_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY puudumine
    ADD CONSTRAINT puudumine_pkey PRIMARY KEY (id);


--
-- TOC entry 2244 (class 2606 OID 64964)
-- Dependencies: 1780 1780
-- Name: tulud1_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY tulud1
    ADD CONSTRAINT tulud1_pkey PRIMARY KEY (id);


--
-- TOC entry 2248 (class 2606 OID 64966)
-- Dependencies: 1782 1782
-- Name: tunnusinf_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY tunnusinf
    ADD CONSTRAINT tunnusinf_pkey PRIMARY KEY (id);


--
-- TOC entry 2254 (class 2606 OID 64968)
-- Dependencies: 1787 1787
-- Name: vanemtasu6_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY vanemtasu6
    ADD CONSTRAINT vanemtasu6_pkey PRIMARY KEY (id);


--
-- TOC entry 2256 (class 2606 OID 64970)
-- Dependencies: 1789 1789
-- Name: vastisikud_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad; Tablespace: 
--

ALTER TABLE ONLY vastisikud
    ADD CONSTRAINT vastisikud_pkey PRIMARY KEY (id);


--
-- TOC entry 2170 (class 1259 OID 64971)
-- Dependencies: 1737
-- Name: avans3_idx1; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX avans3_idx1 ON avans3 USING btree (parentid);

ALTER TABLE avans3 CLUSTER ON avans3_idx1;


--
-- TOC entry 2171 (class 1259 OID 64972)
-- Dependencies: 1737 1737
-- Name: avans3_idx2; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX avans3_idx2 ON avans3 USING btree (dokid, liik);


--
-- TOC entry 2180 (class 1259 OID 64973)
-- Dependencies: 1742
-- Name: dbase_alias; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX dbase_alias ON dbase USING hash (alias);


--
-- TOC entry 2188 (class 1259 OID 64974)
-- Dependencies: 1746 1746
-- Name: eelarveinf_rekvid; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX eelarveinf_rekvid ON eelarveinf USING btree (rekvid, kontoid);

ALTER TABLE eelarveinf CLUSTER ON eelarveinf_rekvid;


--
-- TOC entry 2185 (class 1259 OID 64975)
-- Dependencies: 1744
-- Name: ix_eel_config; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX ix_eel_config ON eel_config USING btree (rekvid);


--
-- TOC entry 2191 (class 1259 OID 64976)
-- Dependencies: 1750
-- Name: ix_ladu_grupp; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX ix_ladu_grupp ON ladu_grupp USING btree (parentid);


--
-- TOC entry 2192 (class 1259 OID 64977)
-- Dependencies: 1750
-- Name: ix_ladu_grupp_1; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX ix_ladu_grupp_1 ON ladu_grupp USING btree (nomid);


--
-- TOC entry 2174 (class 1259 OID 64978)
-- Dependencies: 1739
-- Name: ix_ladu_jaak; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX ix_ladu_jaak ON ladu_jaak USING btree (nomid);


--
-- TOC entry 2175 (class 1259 OID 64979)
-- Dependencies: 1739
-- Name: ix_ladu_jaak_1; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX ix_ladu_jaak_1 ON ladu_jaak USING btree (kpv);


--
-- TOC entry 2176 (class 1259 OID 64980)
-- Dependencies: 1739
-- Name: ix_ladu_jaak_2; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX ix_ladu_jaak_2 ON ladu_jaak USING btree (dokitemid);


--
-- TOC entry 2177 (class 1259 OID 64981)
-- Dependencies: 1739
-- Name: ix_ladu_jaak_3; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX ix_ladu_jaak_3 ON ladu_jaak USING btree (rekvid);


--
-- TOC entry 2195 (class 1259 OID 64982)
-- Dependencies: 1753
-- Name: ix_leping3; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX ix_leping3 ON leping3 USING btree (parentid);


--
-- TOC entry 2201 (class 1259 OID 64983)
-- Dependencies: 1758
-- Name: ix_palk_config; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX ix_palk_config ON palk_config USING btree (rekvid);


--
-- TOC entry 2208 (class 1259 OID 64984)
-- Dependencies: 1762
-- Name: ix_palk_taabel2; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX ix_palk_taabel2 ON palk_taabel2 USING btree (parentid);


--
-- TOC entry 2209 (class 1259 OID 64985)
-- Dependencies: 1762
-- Name: ix_palk_taabel2_1; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX ix_palk_taabel2_1 ON palk_taabel2 USING btree (kpv);


--
-- TOC entry 2257 (class 1259 OID 167074)
-- Dependencies: 1790
-- Name: kaardid_kpv; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX kaardid_kpv ON kaardid USING btree (kpv);


--
-- TOC entry 2258 (class 1259 OID 167075)
-- Dependencies: 1790
-- Name: kaardid_luno; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX kaardid_luno ON kaardid USING btree (luno);


--
-- TOC entry 2198 (class 1259 OID 64986)
-- Dependencies: 1756 1756 1756
-- Name: paalk_asutus_ametid_idx; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX paalk_asutus_ametid_idx ON palk_asutus USING btree (rekvid, osakondid, ametid);


--
-- TOC entry 2204 (class 1259 OID 64987)
-- Dependencies: 1760 1760
-- Name: palk_kaart_lepingId_idx; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX "palk_kaart_lepingId_idx" ON palk_kaart USING btree (lepingid, libid);


--
-- TOC entry 2205 (class 1259 OID 64988)
-- Dependencies: 1760
-- Name: palk_kaart_parentid_idx; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX palk_kaart_parentid_idx ON palk_kaart USING btree (parentid);


--
-- TOC entry 2212 (class 1259 OID 64989)
-- Dependencies: 1764
-- Name: palk_tmpl_ametid; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX palk_tmpl_ametid ON palk_tmpl USING btree (parentid);

ALTER TABLE palk_tmpl CLUSTER ON palk_tmpl_ametid;


--
-- TOC entry 2237 (class 1259 OID 64990)
-- Dependencies: 1778 1778 1778
-- Name: puudumine_lepingid_idx; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX puudumine_lepingid_idx ON puudumine USING btree (lepingid, kpv1, kpv2);


--
-- TOC entry 2240 (class 1259 OID 64991)
-- Dependencies: 1780
-- Name: tulud1_dokpropid; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX tulud1_dokpropid ON tulud1 USING btree (dokpropid);


--
-- TOC entry 2241 (class 1259 OID 64992)
-- Dependencies: 1780
-- Name: tulud1_journalid; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX tulud1_journalid ON tulud1 USING btree (journalid);


--
-- TOC entry 2242 (class 1259 OID 64993)
-- Dependencies: 1780
-- Name: tulud1_kpv; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX tulud1_kpv ON tulud1 USING btree (kpv);


--
-- TOC entry 2245 (class 1259 OID 64994)
-- Dependencies: 1780
-- Name: tulud1_rekvid; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX tulud1_rekvid ON tulud1 USING btree (rekvid);


--
-- TOC entry 2246 (class 1259 OID 64995)
-- Dependencies: 1782
-- Name: tunnusinf_kontoid; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX tunnusinf_kontoid ON tunnusinf USING btree (kontoid);


--
-- TOC entry 2249 (class 1259 OID 64996)
-- Dependencies: 1782
-- Name: tunnusinf_rekvid; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX tunnusinf_rekvid ON tunnusinf USING btree (rekvid);


--
-- TOC entry 2250 (class 1259 OID 64997)
-- Dependencies: 1782
-- Name: tunnusinf_tunnusid; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX tunnusinf_tunnusid ON tunnusinf USING btree (tunnusid);


--
-- TOC entry 2251 (class 1259 OID 64998)
-- Dependencies: 1787
-- Name: vanemtasu6_nomid; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX vanemtasu6_nomid ON vanemtasu6 USING btree (nomid);


--
-- TOC entry 2252 (class 1259 OID 64999)
-- Dependencies: 1787
-- Name: vanemtasu6_parentid; Type: INDEX; Schema: public; Owner: vlad; Tablespace: 
--

CREATE INDEX vanemtasu6_parentid ON vanemtasu6 USING btree (parentid);


--
-- TOC entry 2301 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO vlad;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 2308 (class 0 OID 0)
-- Dependencies: 90
-- Name: date(integer, integer, integer); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION date(integer, integer, integer) FROM PUBLIC;
REVOKE ALL ON FUNCTION date(integer, integer, integer) FROM vlad;
GRANT ALL ON FUNCTION date(integer, integer, integer) TO vlad;
GRANT ALL ON FUNCTION date(integer, integer, integer) TO PUBLIC;


--
-- TOC entry 2309 (class 0 OID 0)
-- Dependencies: 101
-- Name: plpgsql_call_handler(); Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON FUNCTION plpgsql_call_handler() FROM PUBLIC;
REVOKE ALL ON FUNCTION plpgsql_call_handler() FROM vlad;
GRANT ALL ON FUNCTION plpgsql_call_handler() TO vlad;
GRANT ALL ON FUNCTION plpgsql_call_handler() TO PUBLIC;


--
-- TOC entry 2311 (class 0 OID 0)
-- Dependencies: 1737
-- Name: avans3; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON TABLE avans3 FROM PUBLIC;
REVOKE ALL ON TABLE avans3 FROM vlad;
GRANT ALL ON TABLE avans3 TO vlad;


--
-- TOC entry 2314 (class 0 OID 0)
-- Dependencies: 1736
-- Name: avans3_id_seq; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON SEQUENCE avans3_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE avans3_id_seq FROM vlad;
GRANT ALL ON SEQUENCE avans3_id_seq TO vlad;


--
-- TOC entry 2315 (class 0 OID 0)
-- Dependencies: 1739
-- Name: ladu_jaak; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON TABLE ladu_jaak FROM PUBLIC;
REVOKE ALL ON TABLE ladu_jaak FROM vlad;
GRANT ALL ON TABLE ladu_jaak TO vlad;


--
-- TOC entry 2316 (class 0 OID 0)
-- Dependencies: 1740
-- Name: curnomjaak; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON TABLE curnomjaak FROM PUBLIC;
REVOKE ALL ON TABLE curnomjaak FROM vlad;
GRANT ALL ON TABLE curnomjaak TO vlad;


--
-- TOC entry 2317 (class 0 OID 0)
-- Dependencies: 1742
-- Name: dbase; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON TABLE dbase FROM PUBLIC;
REVOKE ALL ON TABLE dbase FROM vlad;
GRANT ALL ON TABLE dbase TO vlad;


--
-- TOC entry 2320 (class 0 OID 0)
-- Dependencies: 1741
-- Name: dbase_id_seq; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON SEQUENCE dbase_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE dbase_id_seq FROM vlad;
GRANT ALL ON SEQUENCE dbase_id_seq TO vlad;


--
-- TOC entry 2321 (class 0 OID 0)
-- Dependencies: 1744
-- Name: eel_config; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON TABLE eel_config FROM PUBLIC;
REVOKE ALL ON TABLE eel_config FROM vlad;
GRANT ALL ON TABLE eel_config TO vlad;


--
-- TOC entry 2324 (class 0 OID 0)
-- Dependencies: 1743
-- Name: eel_config_id_seq; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON SEQUENCE eel_config_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE eel_config_id_seq FROM vlad;
GRANT ALL ON SEQUENCE eel_config_id_seq TO vlad;


--
-- TOC entry 2325 (class 0 OID 0)
-- Dependencies: 1746
-- Name: eelarveinf; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON TABLE eelarveinf FROM PUBLIC;
REVOKE ALL ON TABLE eelarveinf FROM vlad;
GRANT ALL ON TABLE eelarveinf TO vlad;


--
-- TOC entry 2328 (class 0 OID 0)
-- Dependencies: 1790
-- Name: kaardid; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON TABLE kaardid FROM PUBLIC;
REVOKE ALL ON TABLE kaardid FROM vlad;
GRANT ALL ON TABLE kaardid TO vlad;


--
-- TOC entry 2331 (class 0 OID 0)
-- Dependencies: 1748
-- Name: ladu_config; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON TABLE ladu_config FROM PUBLIC;
REVOKE ALL ON TABLE ladu_config FROM vlad;
GRANT ALL ON TABLE ladu_config TO vlad;


--
-- TOC entry 2334 (class 0 OID 0)
-- Dependencies: 1747
-- Name: ladu_config_id_seq; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON SEQUENCE ladu_config_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE ladu_config_id_seq FROM vlad;
GRANT ALL ON SEQUENCE ladu_config_id_seq TO vlad;


--
-- TOC entry 2335 (class 0 OID 0)
-- Dependencies: 1750
-- Name: ladu_grupp; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON TABLE ladu_grupp FROM PUBLIC;
REVOKE ALL ON TABLE ladu_grupp FROM vlad;
GRANT ALL ON TABLE ladu_grupp TO vlad;


--
-- TOC entry 2338 (class 0 OID 0)
-- Dependencies: 1749
-- Name: ladu_grupp_id_seq; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON SEQUENCE ladu_grupp_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE ladu_grupp_id_seq FROM vlad;
GRANT ALL ON SEQUENCE ladu_grupp_id_seq TO vlad;


--
-- TOC entry 2341 (class 0 OID 0)
-- Dependencies: 1738
-- Name: ladu_jaak_id_seq; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON SEQUENCE ladu_jaak_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE ladu_jaak_id_seq FROM vlad;
GRANT ALL ON SEQUENCE ladu_jaak_id_seq TO vlad;


--
-- TOC entry 2342 (class 0 OID 0)
-- Dependencies: 1753
-- Name: leping3; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON TABLE leping3 FROM PUBLIC;
REVOKE ALL ON TABLE leping3 FROM vlad;
GRANT ALL ON TABLE leping3 TO vlad;


--
-- TOC entry 2345 (class 0 OID 0)
-- Dependencies: 1752
-- Name: leping3_id_seq; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON SEQUENCE leping3_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE leping3_id_seq FROM vlad;
GRANT ALL ON SEQUENCE leping3_id_seq TO vlad;


--
-- TOC entry 2346 (class 0 OID 0)
-- Dependencies: 1756
-- Name: palk_asutus; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON TABLE palk_asutus FROM PUBLIC;
REVOKE ALL ON TABLE palk_asutus FROM vlad;
GRANT ALL ON TABLE palk_asutus TO vlad;


--
-- TOC entry 2349 (class 0 OID 0)
-- Dependencies: 1755
-- Name: palk_asutus_id_seq; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON SEQUENCE palk_asutus_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE palk_asutus_id_seq FROM vlad;
GRANT ALL ON SEQUENCE palk_asutus_id_seq TO vlad;


--
-- TOC entry 2350 (class 0 OID 0)
-- Dependencies: 1758
-- Name: palk_config; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON TABLE palk_config FROM PUBLIC;
REVOKE ALL ON TABLE palk_config FROM vlad;
GRANT ALL ON TABLE palk_config TO vlad;


--
-- TOC entry 2353 (class 0 OID 0)
-- Dependencies: 1757
-- Name: palk_config_id_seq; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON SEQUENCE palk_config_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE palk_config_id_seq FROM vlad;
GRANT ALL ON SEQUENCE palk_config_id_seq TO vlad;


--
-- TOC entry 2354 (class 0 OID 0)
-- Dependencies: 1760
-- Name: palk_kaart; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON TABLE palk_kaart FROM PUBLIC;
REVOKE ALL ON TABLE palk_kaart FROM vlad;
GRANT ALL ON TABLE palk_kaart TO vlad;


--
-- TOC entry 2357 (class 0 OID 0)
-- Dependencies: 1759
-- Name: palk_kaart_id_seq; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON SEQUENCE palk_kaart_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE palk_kaart_id_seq FROM vlad;
GRANT ALL ON SEQUENCE palk_kaart_id_seq TO vlad;


--
-- TOC entry 2358 (class 0 OID 0)
-- Dependencies: 1762
-- Name: palk_taabel2; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON TABLE palk_taabel2 FROM PUBLIC;
REVOKE ALL ON TABLE palk_taabel2 FROM vlad;
GRANT ALL ON TABLE palk_taabel2 TO vlad;


--
-- TOC entry 2361 (class 0 OID 0)
-- Dependencies: 1761
-- Name: palk_taabel2_id_seq; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON SEQUENCE palk_taabel2_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE palk_taabel2_id_seq FROM vlad;
GRANT ALL ON SEQUENCE palk_taabel2_id_seq TO vlad;


--
-- TOC entry 2362 (class 0 OID 0)
-- Dependencies: 1764
-- Name: palk_tmpl; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON TABLE palk_tmpl FROM PUBLIC;
REVOKE ALL ON TABLE palk_tmpl FROM vlad;
GRANT ALL ON TABLE palk_tmpl TO vlad;


--
-- TOC entry 2365 (class 0 OID 0)
-- Dependencies: 1763
-- Name: palk_tmpl_id_seq; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON SEQUENCE palk_tmpl_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE palk_tmpl_id_seq FROM vlad;
GRANT ALL ON SEQUENCE palk_tmpl_id_seq TO vlad;


--
-- TOC entry 2366 (class 0 OID 0)
-- Dependencies: 1778
-- Name: puudumine; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON TABLE puudumine FROM PUBLIC;
REVOKE ALL ON TABLE puudumine FROM vlad;
GRANT ALL ON TABLE puudumine TO vlad;


--
-- TOC entry 2369 (class 0 OID 0)
-- Dependencies: 1777
-- Name: puudumine_id_seq; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON SEQUENCE puudumine_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE puudumine_id_seq FROM vlad;
GRANT ALL ON SEQUENCE puudumine_id_seq TO vlad;


--
-- TOC entry 2370 (class 0 OID 0)
-- Dependencies: 1780
-- Name: tulud1; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON TABLE tulud1 FROM PUBLIC;
REVOKE ALL ON TABLE tulud1 FROM vlad;
GRANT ALL ON TABLE tulud1 TO vlad;


--
-- TOC entry 2373 (class 0 OID 0)
-- Dependencies: 1779
-- Name: tulud1_id_seq; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON SEQUENCE tulud1_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE tulud1_id_seq FROM vlad;
GRANT ALL ON SEQUENCE tulud1_id_seq TO vlad;


--
-- TOC entry 2374 (class 0 OID 0)
-- Dependencies: 1782
-- Name: tunnusinf; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON TABLE tunnusinf FROM PUBLIC;
REVOKE ALL ON TABLE tunnusinf FROM vlad;
GRANT ALL ON TABLE tunnusinf TO vlad;


--
-- TOC entry 2377 (class 0 OID 0)
-- Dependencies: 1781
-- Name: tunnusinf_id_seq; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON SEQUENCE tunnusinf_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE tunnusinf_id_seq FROM vlad;
GRANT ALL ON SEQUENCE tunnusinf_id_seq TO vlad;


--
-- TOC entry 2378 (class 0 OID 0)
-- Dependencies: 1787
-- Name: vanemtasu6; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON TABLE vanemtasu6 FROM PUBLIC;
REVOKE ALL ON TABLE vanemtasu6 FROM vlad;
GRANT ALL ON TABLE vanemtasu6 TO vlad;


--
-- TOC entry 2381 (class 0 OID 0)
-- Dependencies: 1789
-- Name: vastisikud; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON TABLE vastisikud FROM PUBLIC;
REVOKE ALL ON TABLE vastisikud FROM vlad;
GRANT ALL ON TABLE vastisikud TO vlad;


--
-- TOC entry 2384 (class 0 OID 0)
-- Dependencies: 1788
-- Name: vastisikud_id_seq; Type: ACL; Schema: public; Owner: vlad
--

REVOKE ALL ON SEQUENCE vastisikud_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE vastisikud_id_seq FROM vlad;
GRANT ALL ON SEQUENCE vastisikud_id_seq TO vlad;


-- Completed on 2010-09-04 00:57:05

--
-- PostgreSQL database dump complete
--

