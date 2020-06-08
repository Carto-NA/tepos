/* TEPOS V1.0 */
/* Creation des droits sur l'ensemble des objets */
/* tepos_99_droit.sql */
/* PostgreSQL/PostGIS */
/* Conseil régional Nouvelle-Aquitaine - https://cartographie.nouvelle-aquitaine.fr/ */
/* Auteur : Tony VINCENT */

------------------------------------------------------------------------ 
-- Grant : Droits des éléments
------------------------------------------------------------------------

--
GRANT ALL ON SCHEMA upload TO "pre-sig-usr";
GRANT ALL ON SCHEMA upload TO "pre-sig-ro";

--
GRANT ALL ON TABLE upload.media_bdd TO "pre-sig-usr";
GRANT ALL ON TABLE upload.media_bdd TO "pre-sig-ro";

GRANT ALL ON SEQUENCE upload.media_bdd_id_seq TO "pre-sig-usr";
GRANT ALL ON SEQUENCE upload.media_bdd_id_seq TO "pre-sig-ro";

--
GRANT ALL ON TABLE upload.media_rep TO "pre-sig-usr";
GRANT ALL ON TABLE upload.media_rep TO "pre-sig-ro";

--
GRANT ALL ON TABLE upload.media_signaletique TO "pre-sig-ro";
GRANT ALL ON SEQUENCE upload.media_signaletique_id_seq TO "pre-sig-ro";

--
GRANT ALL ON TABLE upload.media_dsi_localisation_site TO "pre-sig-ro";
GRANT ALL ON SEQUENCE upload.media_dsi_localisation_site_id_seq TO "pre-sig-ro";

-- Tables : upload.media_dsi_localisation_site
GRANT ALL ON TABLE upload.media_dsi_localisation_site TO "pre-sig-ro";
GRANT ALL ON SEQUENCE upload.media_dsi_localisation_site_id_seq TO "pre-sig-ro";


-- Tables : upload.media_terri_tepos
GRANT ALL ON TABLE upload.media_terri_tepos TO "pre-sig-ro";
GRANT ALL ON SEQUENCE upload.media_terri_tepos_id_seq TO "pre-sig-ro";
