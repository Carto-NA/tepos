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
	membre_siren varchar(15),
	nature_juridique varchar(20),
	commentaires text,
	date_import date,
	date_maj date,
	CONSTRAINT t_appartenance_geo_com_tepos_pkey PRIMARY KEY (id),
	CONSTRAINT t_appartenance_geo_com_tepos_uniq UNIQUE (numcom,nature_juridique)
);

--
COMMENT ON TABLE ref_zonage.t_appartenance_geo_com_tepos IS 'Table d''appartenance des communes au territoire à énergie positive (TEPOS)';

--
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.id IS 'Identifiant';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.cog_annee IS 'Année COG de référence';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.zon_code IS 'Numéro SIREN du TEPOS';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.zon_nom IS 'Nom du TEPOS';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.numcom IS 'Code INSEE de la commune';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.nomcom IS 'Nom de la commune';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.numdep IS 'Numéro du département';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.nomdep IS 'Nom du département';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.numreg IS 'Numéro de la région';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.nomreg IS 'Nom de la régon';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.membre_siren IS 'SIREN du membre';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.nature_juridique IS 'Nature juridique du membre';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.commentaires IS 'Commentaires';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.date_import IS 'Date d''import de la donnée';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_tepos.date_maj IS 'Date de mise à jour de la donnée';

------------------------------------------------------------------
-- EPCI

--
INSERT INTO ref_zonage.t_appartenance_geo_com_tepos (
	cog_annee, zon_code, zon_nom, 
	numcom, nomcom, numdep, nomdep, numreg, nomreg, 
	membre_siren, nature_juridique, date_import, date_maj
)
SELECT 
	'2020', 'tepos_'||t1.code_epci, t2.nom_epci,
	t1.insee_com, null, t1.insee_dep, t1.nom_dep, t1.insee_reg, t1.nom_reg, 
	t1.code_epci, 'EPCI', '19/05/2020', null
FROM ref_adminexpress.r_admexp_commune_fr t1
inner join ref_adminexpress.r_admexp_epci_fr t2
on t1.code_epci = t2.code_epci and t2.code_epci in ('200067262','244000659','244000865',
'244000543','200035541','200068948','200069656','200036523','200068922','200029734','243300811','200041689','200071827','200070506'
,'200036473','241700624','241700434','200041499','247900798');

-- Est Creuse Développement
INSERT INTO ref_zonage.t_appartenance_geo_com_tepos (
	cog_annee, zon_code, zon_nom, 
	numcom, nomcom, numdep, nomdep, numreg, nomreg, 
	membre_siren, nature_juridique, date_import, date_maj
)
SELECT 
	'2020', 'tepos_na001', 'Est Creuse Développement',
	t1.insee_com, null, t1.insee_dep, t1.nom_dep, t1.insee_reg, t1.nom_reg, 
	t1.code_epci, 'EPCI', '19/05/2020', null
FROM ref_adminexpress.r_admexp_commune_fr t1
inner join ref_adminexpress.r_admexp_epci_fr t2
on t1.code_epci = t2.code_epci and t2.code_epci in ('200067544','200067593');

------------------------------------------------------------------
-- PETR 

-- Ruffecois
INSERT INTO ref_zonage.t_appartenance_geo_com_tepos (
	cog_annee, zon_code, zon_nom, 
	numcom, nomcom, numdep, nomdep, numreg, nomreg, 
	membre_siren, nature_juridique, date_import, date_maj
)
SELECT 
	'2020', 'tepos_'||t2.num_siren, t2.nom_groupement,
	t1.insee_com, t1.nom_com , t1.insee_dep, t1.nom_dep, t1.insee_reg, t1.nom_reg, 
	t1.code_epci, 'PETR', '19/05/2020', null
FROM ref_adminexpress.r_admexp_commune_fr t1
inner join (SELECT num_siren, nom_groupement, membre_siren 
FROM ref_banatic.r_bana_appartenance_com_interco_na
WHERE num_siren = '200050094') t2
on t1.code_epci = t2.membre_siren; 

------------------------------------------------------------------
-- PNR 

-- Millevaches en Limousin
INSERT INTO ref_zonage.t_appartenance_geo_com_tepos (
	cog_annee, zon_code, zon_nom, 
	numcom, nomcom, numdep, nomdep, numreg, nomreg, 
	membre_siren, nature_juridique, date_import, date_maj
)
SELECT 
	'2020', 'tepos_'||id_mnhn, nompnrna, 
	numcom, nomcom, numdep, null, numreg, null,
	id_mnhn, 'PNR', '19/05/2020', null
FROM ref_zonage.t_appartenance_geo_com_pnr_na
where id_mnhn = 'FR8000045';
	 
------------------------------------------------------------------
-- Communes

-- Buxerolles
INSERT INTO ref_zonage.t_appartenance_geo_com_tepos (
	cog_annee, zon_code, zon_nom, 
	numcom, nomcom, numdep, nomdep, numreg, nomreg, 
	membre_siren, nature_juridique, date_import, date_maj
)
SELECT 
	'2020', 'tepos_'||insee_com, t1.nom_com ,
	t1.insee_com, t1.nom_com , t1.insee_dep, t1.nom_dep, t1.insee_reg, t1.nom_reg, 
	t1.insee_com, 'Commune', '19/05/2020', null
FROM ref_adminexpress.r_admexp_commune_fr t1
inner join ref_adminexpress.r_admexp_epci_fr t2
on t1.insee_com = '86041' and t1.code_epci = t2.code_epci;
	 

------------------------------------------------------------------------
-- Table: met_zon.m_zon_tepos_na_geo

-- DROP TABLE met_zon.m_zon_tepos_na_geo;
CREATE TABLE met_zon.m_zon_tepos_na_geo (
	id serial NOT NULL,
	zon_code varchar(20) NOT NULL,
	zon_nom varchar(254) NOT NULL,
	population numeric,
	nb_commune numeric,
	numdep varchar(2),
	statut varchar(50),
	etat varchar(50),
	date_signature date,
	num_siren varchar(15),
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
	CONSTRAINT m_zon_tepos_na_geo_uniq UNIQUE (zon_code, srce_annee)
);

--
COMMENT ON TABLE met_zon.m_zon_tepos_na_geo  IS 'Zonage des territoires à énergie positive (TEPOS)';
--  
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.id IS 'Identifiant';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.zon_code IS 'Numéro SIREN du TEPOS';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.zon_nom IS 'Nom du TEPOS';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.population IS 'Population du TEPOS';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.nb_commune IS 'Nombre de commune qui constitue le TEPOS';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.numdep IS 'Département du TEPOS';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.statut IS 'Statut du TEPOS';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.etat IS 'Etat du TEPOS';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.date_signature IS 'Date de signature';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.nature_juridique IS 'Nom de la nature juridique';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.commentaires IS 'Commentaires';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.date_import IS 'Date d''import de la donnée';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.date_maj IS 'Date de mise à jour de la donnée';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.srce_geom IS 'Référentiel utilisé pour construire la géométrie';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.srce_annee IS 'Année du référentiel géometrque';
COMMENT ON COLUMN met_zon.m_zon_tepos_na_geo.geom IS 'Géometrie';

--
INSERT INTO met_zon.m_zon_tepos_na_geo (
	zon_code, zon_nom, population, nb_commune, statut, etat, date_signature, num_siren, nature_juridique, 
	commentaires, date_import, date_maj, srce_geom, srce_annee, geom
)
SELECT 
	t1.zon_code, t1.zon_nom, sum(population) as population, count(numcom) as nb_commune, null, null, null, substring(zon_code,7,27) as num_siren, nature_juridique,
	commentaires, date_import, date_maj, 'BD IGN - AdminExpress' as srce_geom, '2020' as srce_annee, ST_Multi(ST_Union(t2.geom)) as geom
FROM ref_zonage.t_appartenance_geo_com_tepos t1
inner join ref_adminexpress.r_admexp_commune_fr t2
on t1.numcom = t2.insee_com 
group by t1.zon_code, t1.zon_nom, num_siren, t1.nature_juridique, t1.commentaires, t1.date_import,
t1.date_maj, srce_geom, srce_annee;

-- Ajout des numéros de département
UPDATE met_zon.m_zon_tepos_na_geo t1
SET numdep = t2.insee_dep 
from (
	SELECT zon_code, t2.insee_dep
	FROM ref_zonage.t_appartenance_geo_com_tepos t1
	inner join ref_adminexpress.r_admexp_commune_fr t2
	on t1.numcom = t2.insee_com and t1.date_import >= '2020-01-01' and zon_code != 'tepos_FR8000045'
	group by t1.zon_code, t1.zon_nom, t2.insee_dep 
) t2
WHERE t1.zon_code=t2.zon_code ;

															   
------------------------------------------------------------------------
-- Table: ref_zonage.t_appartenance_geo_com_pcaet

-- DROP TABLE ref_zonage.t_appartenance_geo_com_pcaet;
CREATE TABLE ref_zonage.t_appartenance_geo_com_pcaet (
	id serial,
	cog_annee character varying(4),
	numcom varchar(5) NOT NULL,
	nomcom varchar(50),
	population integer,
	numdep varchar(3),
	numreg varchar(2),
	zon_code  character varying(80),
	zon_nom character varying(255),
	zon_type character varying(50),
	commentaires text,
	date_import date,
	date_maj date,
	CONSTRAINT t_appartenance_geo_com_pcaet_pkey PRIMARY KEY (id),
	CONSTRAINT t_appartenance_geo_com_pcaet_uniq UNIQUE (numcom)
);
															   
COMMENT ON TABLE ref_zonage.t_appartenance_geo_com_pcaet IS 'Table d''appartenance des communes au plan climat-air-énergie territorial (PCAET)';

--
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.id IS 'Identifiant';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.cog_annee IS 'Année COG de référence';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.numcom IS 'Code INSEE de la commune';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.nomcom IS 'Nom de la commune';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.population IS 'Population de la commune';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.numdep IS 'Numéro du département';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.numreg IS 'Numéro de la région';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.zon_code IS 'Code du territoire (pcaet_[SIREN ou autre])';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.zon_nom IS 'Nom du territoire';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.zon_type IS 'Type du territoire';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.commentaires IS 'Commentaires';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.date_import IS 'Date d''import de la donnée';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.date_maj IS 'Date de mise à jour de la donnée';
															   
/*CREATE TABLE ref_zonage.t_appartenance_geo_com_pcaet (
	id serial,
	cog_annee character varying(4),
	zon_code  character varying(80),
	zon_nom character varying(255),
	zon_type character varying(50),
	mbr_nature_juridique varchar(20),
	mbr_siren varchar(15),
	mbr_nom varchar(255),
	numcom varchar(5) NOT NULL,
	nomcom varchar(50),
	population integer,
	numdep varchar(3),
	numreg varchar(2),
	commentaires text,
	date_import date,
	date_maj date,
	CONSTRAINT t_appartenance_geo_com_pcaet_pkey PRIMARY KEY (id),
	CONSTRAINT t_appartenance_geo_com_pcaet_uniq UNIQUE (numcom,mbr_nature_juridique)
);

--
COMMENT ON TABLE ref_zonage.t_appartenance_geo_com_pcaet IS 'Table d''appartenance des communes au plan climat-air-énergie territorial (PCAET)';

--
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.id IS 'Identifiant';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.cog_annee IS 'Année COG de référence';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.zon_code IS 'Code du territoire (pcaet_[SIREN ou autre])';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.zon_nom IS 'Nom du territoire';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.zon_type IS 'Type du territoire';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.mbr_nature_juridique IS 'Nature juridique du membre';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.mbr_siren IS 'SIREN du membre';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.mbr_nom IS 'Nom du membre';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.numcom IS 'Code INSEE de la commune';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.nomcom IS 'Nom de la commune';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.population IS 'Population de la commune';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.numdep IS 'Numéro du département';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.numreg IS 'Numéro de la région';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.commentaires IS 'Commentaires';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.date_import IS 'Date d''import de la donnée';
COMMENT ON COLUMN ref_zonage.t_appartenance_geo_com_pcaet.date_maj IS 'Date de mise à jour de la donnée';															   
*/
															   
---------------------------------------------------------------------------------------------
-- Intégration des données
															   
-- EPCI
--
INSERT INTO ref_zonage.t_appartenance_geo_com_pcaet(
	cog_annee, zon_code, zon_nom, zon_type,
	numcom, nomcom, population, numdep, numreg, commentaires, date_import, date_maj
)
SELECT 
	'2021', t1.code_epci, t3.nom_epci, t3.type_epci,
	t1.insee_com, t1.nom_com, t1.population, t1.insee_dep, t1.insee_reg, null, '03/03/2021', null
FROM ref_adminexpress.r_admexp_commune_fr t1
inner join z_maj."20210204_Suivi_PCAET_resume" t2
on t2."type de membre" = 'EPCI' and t1.code_epci = t2."code du membre"
inner join ref_adminexpress.r_admexp_epci_fr t3
on t2."code du membre" = t3.code_epci;
															   

/*
-- SCOT
--
INSERT INTO ref_zonage.t_appartenance_geo_com_pcaet(
	cog_annee, zon_code, zon_nom, 
	mbr_nature_juridique, mbr_siren, mbr_nom, 
	numcom, nomcom, population, numdep, numreg, commentaires, date_import, date_maj
)
SELECT 
	'2021', 'pcaet_'||t1.code_ets_scot, null,
	'SCOT', t1.code_ets_scot, null,
	t1.numcom, t1.nomcom, null, t1.numdep, t1.numreg, null, '02/03/2021', null
FROM ref_zonage.t_appartenance_geo_com_scot t1
INNER JOIN z_maj."20210204_Suivi_PCAET_resume" t2
ON t2."type de membre" = 'SCOT' AND t1.code_ets_scot = t2."code du membre";

-- Mise à jour de la population
UPDATE ref_zonage.t_appartenance_geo_com_pcaet  SET population = t2.population 
FROM ref_adminexpress.r_admexp_commune_fr t2 WHERE numcom = t2.insee_com;
									

-- PETR
--
INSERT INTO ref_zonage.t_appartenance_geo_com_pcaet(
	cog_annee, zon_code, zon_nom, 
	--zon_type, 
	mbr_nature_juridique, mbr_siren, mbr_nom, 
	numcom, nomcom, population, numdep, numreg, commentaires, date_import, date_maj
)
SELECT 
	'2021', 'pcaet_'||t2.num_siren, t2.nom_groupement,
	'PETR', t2.membre_siren, t2.membre_nom,
	t1.insee_com, t1.nom_com , null, t1.insee_dep, t1.insee_reg, null, '02/03/2021', null
FROM ref_adminexpress.r_admexp_commune_fr t1
inner join (SELECT num_siren, nom_groupement, membre_siren, membre_nom
FROM ref_banatic.r_bana_appartenance_com_interco_na
WHERE num_siren = '200072189') t2
on t1.code_epci = t2.membre_siren; 	*/														   
															   
------------------------------------------------------------------------
-- Table: met_zon.m_zon_pcaet_na_geo

-- DROP TABLE met_zon.m_zon_pcaet_na_geo;
CREATE TABLE met_zon.m_zon_pcaet_na_geo (
	id serial NOT NULL,
	zon_code varchar(20) NOT NULL,
	zon_nom varchar(254) NOT NULL,
	zon_type character varying(50),
	population integer,
	nb_commune integer,
	numdep varchar(2),
	commentaires text NULL,
	date_import date NULL,
	date_maj date NULL,
	srce_geom varchar(50),
	srce_annee varchar(4),
	geom geometry(MULTIPOLYGON, 2154) NULL,
	CONSTRAINT m_zon_pcaet_na_geo_pkey PRIMARY KEY (id),
	CONSTRAINT m_zon_pcaet_na_geo_uniq UNIQUE (zon_code, srce_annee)
);

--
COMMENT ON TABLE met_zon.m_zon_pcaet_na_geo  IS 'Zonage du plan Climat-Air-Energie territorial (PCAET)';
--  
COMMENT ON COLUMN met_zon.m_zon_pcaet_na_geo.id IS 'Identifiant';
COMMENT ON COLUMN met_zon.m_zon_pcaet_na_geo.zon_code IS 'Code du PCAET';
COMMENT ON COLUMN met_zon.m_zon_pcaet_na_geo.zon_nom IS 'Nom du PCAET';
COMMENT ON COLUMN met_zon.m_zon_pcaet_na_geo.zon_type IS 'Type du PCAET';
COMMENT ON COLUMN met_zon.m_zon_pcaet_na_geo.population IS 'Population du PCAET';
COMMENT ON COLUMN met_zon.m_zon_pcaet_na_geo.nb_commune IS 'Nombre de commune qui constitue le PCAET';
COMMENT ON COLUMN met_zon.m_zon_pcaet_na_geo.numdep IS 'Département du PCAET';
COMMENT ON COLUMN met_zon.m_zon_pcaet_na_geo.commentaires IS 'Commentaires';
COMMENT ON COLUMN met_zon.m_zon_pcaet_na_geo.date_import IS 'Date d''import de la donnée';
COMMENT ON COLUMN met_zon.m_zon_pcaet_na_geo.date_maj IS 'Date de mise à jour de la donnée';
COMMENT ON COLUMN met_zon.m_zon_pcaet_na_geo.srce_geom IS 'Référentiel utilisé pour construire la géométrie';
COMMENT ON COLUMN met_zon.m_zon_pcaet_na_geo.srce_annee IS 'Année du référentiel géometrique';
COMMENT ON COLUMN met_zon.m_zon_pcaet_na_geo.geom IS 'Géometrie';

--
INSERT INTO met_zon.m_zon_pcaet_na_geo (
	zon_code, zon_nom, zon_type, population, nb_commune, numdep, 
	commentaires, date_import, date_maj, srce_geom, srce_annee, geom
)
SELECT 
	t1.zon_code, t1.zon_nom, t1.zon_type, sum(t1.population) as population, count(numcom) as nb_commune, null, 
	commentaires, date_import, date_maj, 'BD IGN - AdminExpress' as srce_geom, '2021' as srce_annee, ST_Multi(ST_Union(t2.geom)) as geom
FROM ref_zonage.t_appartenance_geo_com_pcaet t1
inner join ref_adminexpress.r_admexp_commune_fr t2
on t1.numcom = t2.insee_com 
group by t1.zon_code, t1.zon_nom, t1.zon_type, t1.commentaires, t1.date_import,
t1.date_maj, srce_geom, srce_annee;
															   
-- Ajout des numéros de département
UPDATE met_zon.m_zon_pcaet_na_geo t1
SET numdep = t2.insee_dep 
from (
	SELECT zon_code, t2.insee_dep
	FROM ref_zonage.t_appartenance_geo_com_pcaet t1
	inner join ref_adminexpress.r_admexp_commune_fr t2
	on t1.numcom = t2.insee_com 
	--and t1.date_import >= '2020-01-01' and zon_code != 'tepos_FR8000045'
	group by t1.zon_code, t1.zon_nom, t2.insee_dep 
) t2
WHERE t1.zon_code=t2.zon_code ;															   
															   
------------------------------------------------------------------------
-- Table: met_env.m_env_pcaet

-- DROP TABLE met_env.m_env_pcaet;
CREATE TABLE met_env.m_env_pcaet (
	id serial NOT NULL,
	zon_code varchar(20) NOT NULL,
	decision_elaboration varchar(50),
	statut varchar(50),
	etape varchar(255),
	avancement varchar(255),
	site_web varchar(255),
	commentaires text NULL,
	date_import date NULL,
	date_maj date NULL,
	srce_annee varchar(4),
	CONSTRAINT m_env_pcaet_pkey PRIMARY KEY (id),
	CONSTRAINT m_env_pcaet_uniq UNIQUE (zon_code, srce_annee)
);															   
		
--
COMMENT ON TABLE met_env.m_env_pcaet  IS 'Table contenant les éléments de suivi du plan Climat-Air-Energie territorial (PCAET)';
--  
COMMENT ON COLUMN met_env.m_env_pcaet.id IS 'Identifiant';
COMMENT ON COLUMN met_env.m_env_pcaet.zon_code IS 'Code du PCAET';
COMMENT ON COLUMN met_env.m_env_pcaet.decision_elaboration IS 'Date de la décision d''élaboration';
COMMENT ON COLUMN met_env.m_env_pcaet.statut IS 'Statut du PCAET (obligé/volontaire/autres/Non renseigné)';
COMMENT ON COLUMN met_env.m_env_pcaet.etape IS 'Etape en cours (0: pas démarré/abandon; 1: délibération; 2: diagnostic réalisé; 3: stratégie réalisé; 4: plan d''action; 5: consultation/approbation)';
COMMENT ON COLUMN met_env.m_env_pcaet.avancement IS 'Date et élément majeur d''avancement';														   
COMMENT ON COLUMN met_env.m_env_pcaet.site_web IS 'Lien vers le territoire';
COMMENT ON COLUMN met_env.m_env_pcaet.commentaires IS 'Commentaires';
COMMENT ON COLUMN met_env.m_env_pcaet.date_import IS 'Date d''import de la donnée';
COMMENT ON COLUMN met_env.m_env_pcaet.date_maj IS 'Date de mise à jour de la donnée';
COMMENT ON COLUMN met_env.m_env_pcaet.srce_annee IS 'Année du référentiel géometrique';

--															   
INSERT INTO met_env.m_env_pcaet(
	zon_code, decision_elaboration, statut, etape, avancement, 
	site_web, commentaires, date_import, date_maj, srce_annee
)
SELECT 
	"code du membre", "décision élaboration", "obligé/volontaire", "etape en cours", avancement, 
	lien, null, '02/03/2021', null, '2021'
FROM z_maj."20210204_Suivi_PCAET_resume" 
WHERE "type de membre" = 'EPCI';

															   
															   
====================
_*A faire :*_
*Il faut faire un trigger/fonction qui permet de mettre à jour la table met_zon.m_zon_tepos_na_geo et ref_zonage.t_appartenance_geo_com_tepos concernant la modification du libellé des zonages.
Parce que celui-ci peut-être mise à jour directement par l'utilisateur via l'interface dynamique.*


