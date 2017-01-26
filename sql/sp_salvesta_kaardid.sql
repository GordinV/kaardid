-- Function: sp_salvesta_pv_oper(integer, integer, integer, integer, integer, date, numeric, text, character varying, character varying, character varying, character varying, character varying, character varying, character varying, integer, character varying, character varying)

-- DROP FUNCTION sp_salvesta_pv_oper(integer, integer, integer, integer, integer, date, numeric, text, character varying, character varying, character varying, character varying, character varying, character varying, character varying, integer, character varying, character varying);

CREATE OR REPLACE FUNCTION sp_salvesta_kaardid(integer, date, character varying, text, character varying, character varying)
  RETURNS integer AS
$BODY$

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
end;$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
ALTER FUNCTION sp_salvesta_kaardid(integer, date, character varying, text, character varying, character varying) OWNER TO vlad;
GRANT EXECUTE ON FUNCTION sp_salvesta_kaardid(integer, date, character varying, text, character varying, character varying) TO bs2;
