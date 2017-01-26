
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


