/* TEPOS V1.0 */
/* Creation des droits sur l'ensemble des objets */
/* tepos_99_droit.sql */
/* PostgreSQL/PostGIS */
/* Conseil régional Nouvelle-Aquitaine - https://cartographie.nouvelle-aquitaine.fr/ */
/* Auteur : Tony VINCENT */

------------------------------------------------------------------------ 
-- Grant : Droits des éléments
------------------------------------------------------------------------

-- Tables : ref_zonage.t_appartenance_geo_com_tepos
GRANT ALL ON TABLE ref_zonage.t_appartenance_geo_com_tepos TO "pre-sig-usr";
GRANT SELECT ON TABLE ref_zonage.t_appartenance_geo_com_tepos TO "pre-sig-ro";

-- Tables : met_zon.m_zon_tepos_na_geo
GRANT ALL ON TABLE met_zon.m_zon_tepos_na_geo TO "pre-sig-usr";
GRANT SELECT ON TABLE met_zon.m_zon_tepos_na_geo TO "pre-sig-ro";
