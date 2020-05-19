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
	cog_annee character varying(4),
	zon_code  character varying(80),
	zon_nom character varying(255),
	numcom varchar(5) NOT NULL,
	nomcom varchar(50),
	nomcom_m varchar(50),
	numdep varchar(3),
	nomdep varchar(30),
	numreg varchar(2),
	nomreg varchar(35),
	code_nature_juridique varchar(15),
	nature_juridique varchar(20),
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
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.cog_annee IS 'Année COG de référence';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.zon_code IS 'Code région du TEPOS';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.zon_nom IS 'Nom du TEPOS';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.numcom IS 'Code INSEE de la commune';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.nomcom IS 'Nom de la commune';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.numdep IS 'Numéro du département';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.nomdep IS 'Nom du département';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.numreg IS 'Numéro de la région';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.nomreg IS 'Nom de la régon';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.code_nature_juridique IS 'Code de la nature juridique';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.nature_juridique IS 'Nom de la nature juridique';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.commentaires IS 'Commentaires';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.date_import IS 'Date d''import de la donnée';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.date_maj IS 'Date de mise à jour de la donnée';

--
INSERT INTO ref_zonage.t_appartenance_geo_com_tepos (
	cog_annee, zon_code, zon_nom, 
	numcom, nomcom, numdep, nomdep, numreg, nomreg, 
	code_nature_juridique, nature_juridique, date_import, date_maj
)
SELECT 
	'2020', 'tepos_'||t1.code_epci, t2.nom_epci,
	t1.insee_com, null, t1.insee_dep, t1.nom_dep, t1.insee_reg, t1.nom_reg, 
	t1.code_epci, 'EPCI', '19/05/2020', null
FROM ref_adminexpress.r_admexp_commune_fr t1
inner join ref_adminexpress.r_admexp_epci_fr t2
on t1.code_epci = t2.code_epci and t2.code_epci in ('200067262','244000659','244000865',
'244000543','200035541','200068948','200069656','200036523','200068922','200029734','243300811','200041689','200071827','200070506'
,'200036473','241700624','241700434','200041499','247900798')

-- Est Creuse Développement
INSERT INTO ref_zonage.t_appartenance_geo_com_tepos (
	cog_annee, zon_code, zon_nom, 
	numcom, nomcom, numdep, nomdep, numreg, nomreg, 
	code_nature_juridique, nature_juridique, date_import, date_maj
)
SELECT 
	'2020', 'tepos_na001', 'Est Creuse Développement',
	t1.insee_com, null, t1.insee_dep, t1.nom_dep, t1.insee_reg, t1.nom_reg, 
	t1.code_epci, 'EPCI', '19/05/2020', null
FROM ref_adminexpress.r_admexp_commune_fr t1
inner join ref_adminexpress.r_admexp_epci_fr t2
on t1.code_epci = t2.code_epci and t2.code_epci in ('200067544','200067593')


------------------------------------------------------------------------
-- Table: met_zon.m_zon_tepos_na_geo

-- DROP TABLE met_zon.m_zon_tepos_na_geo;
CREATE TABLE met_zon.m_zon_tepos_na_geo (
	id serial NOT NULL,
	zon_code varchar(20) NOT NULL,
	zon_nom varchar(254) NOT NULL,
	statut varchar(50),
	etat varchar(50),
	date_signature date,
	code_nature_juridique varchar(15),
	nature_juridique varchar(20),
	gestionnaire varchar(254),
	climagri varchar(5),	
	commentaires text NULL,
	date_import date NULL,
	date_maj date NULL,
	srce_geom varchar(50),
	srce_annee varchar(4),
	geom geometry(MULTIPOLYGON, 2154) NULL,
	CONSTRAINT m_zon_tepos_na_geo_pkey PRIMARY KEY (id),
	CONSTRAINT m_zon_tepos_na_geo_uniq UNIQUE (zon_code)
);

--
COMMENT ON TABLE met_zon.m_zon_tepos_na_geo  IS 'Zonage des territoires à énergie positive (TEPOS)';
--  
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.id IS 'Identifiant';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.zon_code IS 'Code région du TEPOS';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.zon_nom IS 'Nom du TEPOS';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.statut IS 'Statut du TEPOS';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.etat IS 'Etat du TEPOS';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.date_signature IS 'Date de signature';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.code_nature_juridique IS 'Code de la nature juridique';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.nature_juridique IS 'Nom de la nature juridique';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.commentaires IS 'Commentaires';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.date_import IS 'Date d''import de la donnée';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.date_maj IS 'Date de mise à jour de la donnée';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.srce_geom IS 'Référentiel utilisé pour construire la géométrie';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.srce_annee IS 'Année du référentiel géometrque';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.geom IS 'Géometrie';
