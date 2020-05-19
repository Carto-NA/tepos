/* TEPOS V1.0 */
/* Creation de la structure des données (tables, séquences, triggers,...) */
/* tepos_10_structure.sql */
/* PostgreSQL/PostGIS */
/* Conseil régional Nouvelle-Aquitaine - https://cartographie.nouvelle-aquitaine.fr/ */
/* Auteur : Tony VINCENT */


------------------------------------------------------------------------
-- Table: ref_zonage.t_appartenance_geo_com_tepos

-- DROP TABLE ref_zonage.t_appartenance_geo_com_tepos;
CREATE TABLE ref_zonage.t_appartenance_geo_com_tepos (
	id serial,
	numcom varchar(5) NOT NULL,
	nomcom varchar(50),
	nomcom_m varchar(50),
	numdep varchar(3),
	nomdep varchar(30),
	numreg varchar(2),
	nomreg varchar(35),
	numepci varchar(9),
	code_region  character varying(80),
	nom_gal_leader character varying(255),
	nom_gal_leader_2 character varying(255), 
	cog_annee character varying(4),
	commentaires text,
	date_import date,
	date_maj date,
	CONSTRAINT t_appartenance_geo_com_tepos_pkey PRIMARY KEY (id),
	CONSTRAINT t_appartenance_geo_com_tepos_uniq UNIQUE (numcom)
);

--
COMMENT ON TABLE ref_zonage.t_appartenance_geo_com_tepos IS 'Table d''appartenance des communes au territoire à énergie positive (TEPOS)';

--
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.id IS 'Identifiant';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.numcom IS 'Code INSEE de la commune';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.nomcom IS 'Nom de la commune';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.numdep IS 'Numéro du département';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.nomdep IS 'Nom du département';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.numreg IS 'Numéro de la région';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.nomreg IS 'Nom de la régon';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.numepci IS 'Numéro de l''EPCI';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.zon_code IS 'Code région du TEPOS';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.zon_nom IS 'Nom du TEPOS';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.cog_annee IS 'Année COG de référence';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.commentaires IS 'Commentaires';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.date_import IS 'Date d''import de la donnée';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.date_maj IS 'Date de mise à jour de la donnée';


------------------------------------------------------------------------
-- Table: met_zon.m_zon_tepos_na_geo

-- DROP TABLE met_zon.m_zon_tepos_na_geo;
CREATE TABLE met_zon.m_zon_tepos_na_geo (
	id serial NOT NULL,
	zon_code varchar(20) NOT NULL,
	commentaires text NULL,
	date_import date NULL,
	date_maj date NULL,
	geom geometry(MULTIPOLYGON, 2154) NULL,
	CONSTRAINT m_zon_tepos_na_geo_pkey PRIMARY KEY (id),
	CONSTRAINT m_zon_tepos_na_geo_uniq UNIQUE (code_region)
);

--
COMMENT ON TABLE met_zon.m_zon_tepos_na_geo  IS 'Zonage des territoires à énergie positive (TEPOS)';
--  
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.id IS 'Identifiant';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.zon_code IS 'Code région du TEPOS';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.commentaires IS 'Commentaires';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.date_import IS 'Date d''import de la donnée';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.date_maj IS 'Date de mise à jour de la donnée';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.geom IS 'Géometrie';
