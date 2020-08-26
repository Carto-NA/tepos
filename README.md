# Documentation technique de la base de données des territoires à énergie positive (TEPOS)


Territoire TEPOS
Notre territoire à énergie positive
En Nouvelle-Aquitaine


id
zon_code
zon_nom


statut : engagement
etat : reconnu, 
date_signature : 
nature_juridique : Syndicat mixte, EPCI, autres
climagri : 0/1/2/...

src_geom : geofla, AdminExpress
src_annee : 



Mots clés :
tepos, territoire, nouvelle-aquitaine, donnees-ouvertes, 
CLIMAT, AMENAGEMENT DU TERRITOIRE, MOBILITE, BATIMENT, ENERGIE

## Base de données

### Alimentation de la base de données

La composition des territoires
http://www.territoires-energie-positive.fr/
et/ou
Aurélien BERNIER ( - site de Poitiers)


### Structure
|schéma | table | description | usage |
|:---|:---|:---|:---|   
|r_objet|lt_contrat|domaine de valeur des références de contrat sur les données gérées par les services|Gestion des accès aux prestataires|
|r_objet|lt_src_geom|domaine de valeur générique d'une table géographique|source du positionnement du PEI|
|r_administratif|an_geo|donnée de référence alphanumérique du découpage administratif |jointure insee commune<>siret epci|
|r_osm|geo_osm_commune|donnée de référence géographique du découpage communal OSM|nom de la commune|
|r_osm|geo_v_osm_commune_apc|vue de la donnée geo_osm_commune restreinte sur le secteur du compiégnois|insee + controle de saisie PEI à l'intérieur de ce périmètre|
|r_osm|geo_osm_epci|donnée de référence géographique du découpage epci OSM|nom de l'EPCI|


### Dictionnaire de donnée
| Table | Champ | Désignation | Type/Taille | Taille | Contrainte | Règle de calcul | Clé étrangère | Commentaire |
| :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: |
|  | numcom | Code INSEE de la commune | varchar(5) |  |  | numcom | numcom de la table d'appartenance des communes |
|  | zon_code | Code du territoire | varchar(80) | unique |  |  |  |
|  | zon_nom | Nom du territoire | varchar(255) |  |  |  |  |
|  | nature_jur | Nature juridique du territoire | varchar(20) |  |  |  |  |
|  | commentaire | Commentaire | text |  |  |  |  |
|  | annee | Année de la données | varchar(10) |  |  |  |  |
|  | geom | Géométrie de l'objet | varchar(4) |  |  |  |  |
|  | src_geom | Code du référentiel géographique utilisé pour la saisie  | varchar(10) |  |  |  | référence à la table de valeur lt_src_geom |
|  | date_sai | Date d'import/ajout de la donnée dans la base | datetime |  |  |  |  |
|  | date_maj | Date de mise à jour de la donnée | datetime |  |  |  |  |



