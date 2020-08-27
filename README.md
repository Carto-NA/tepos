# Documentation technique de la base de données des territoires à énergie positive (TEPOS)

* Statut
  - [ ] à rédiger
  - [x] en cours de rédaction
  - [ ] relecture
  - [ ] finaliser
  - [ ] révision

----


### Présentation 
Les territoires à énergie positive (TEPOS) Nouvelle-Aquitaine sont issus de plusieurs appels à projet lancés par la Région et l’ADEME qui les accompagnent dans leurs démarches.

Les TEPOS sont des territoires pionniers de la transition énergétique. Ils expérimentent de nouvelles solutions techniques, financières et organisationnelles afin de réduire leurs besoins énergétiques au maximum et couvrir les besoins restants par la production d’énergies renouvelables locales. Ils définissent une stratégie dans la durée et mettent en œuvre des actions opérationnelles dont l'effet doit être mesurable et précisément évalué.

L’objectif de la Région Nouvelle-Aquitaine et de l’ADEME est double :

    - Tester et accompagner une démarche innovante conduite par des territoires pilotes, volontaires et moteurs ;
    - Au-delà, permettre d'alimenter l'ensemble des territoires dans leurs démarches de transition énergétique grâce aux nombreux retours d'expériences, méthodes et outils développés au sein du réseau TEPOS.
       

Les TEPOS Nouvelle-Aquitaine s'engagent à respecter les cinq principes de la « Charte des territoires TEPOS Nouvelle-Aquitaine » :

    --> Principe 1 - réduire les consommations énergétiques locales tout en répondant aux besoins de la population, notamment en luttant contre la précarité énergétique, par l'efficacité et la sobriété énergétique ;
    --> Principe 2 - limiter la dépendance aux ressources énergétiques extérieures (pétrole, gaz...) en favorisant les sources énergétiques locales et renouvelables, par l'adaptation des modes locaux de production aux différents besoins des usagers publics et privés ;
    --> Principe 3 - adapter les réseaux de transport-stockage-distribution d'énergie pour qu'ils correspondent au mieux aux modes locaux de consommation et de production d'énergie ;
    --> Principe 4 - mettre en place, pour et avec les habitants, une véritable démocratie énergétique locale pour favoriser la connaissance des enjeux, le partage de la prise de décision, les changements de comportements, les retombées économiques locales par l'implication dans des projets collectifs et citoyens ;
    --> Principe 5 - se doter des compétences indispensables et des outils adéquats pour la mise en œuvre d’une politique énergétique territoriale ambitieuse.

----

**Titre de la carte :**<br>
>Le réseau TEPOS en Nouvelle-Aquitaine

**Description :**<br>
>Les territoires à énergie positive (TEPOS) Nouvelle-Aquitaine sont issus de plusieurs appels à projet lancés par la Région et l’ADEME qui les accompagnent dans leurs démarches.

**Mots clés :**<br>
>tepos, territoire, nouvelle-aquitaine, donnees-ouvertes, climat, aménagement du territoire, énergie



## Base de données

### Alimentation de la base de données

La composition des territoires est récupérée soit sur le site http://www.territoires-energie-positive.fr/ ou bien des informations envoyées par Aurélien BERNIER (Chargé de mission climat-énergie - site de Poitiers).

Il n'y a pas de veille faite sur ces territoires, les mise à jours ou modifications sont faites une fois que le responsable fonctionnel en a informé notre service.


### Dictionnaire de donnée
| Table | Champ | Désignation | Type/Taille | Taille | Contrainte | Règle de calcul | Clé étrangère | Commentaire |
| :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: | :--: |
|  | numcom | Code INSEE de la commune | varchar(5) |  |  | numcom | numcom de la table d'appartenance des communes |
|  | zon_code | Code du territoire | varchar(80) |  | not null/unique |  |  |
|  | zon_nom | Nom du territoire | varchar(255) |  |  |  |  |
|  | nature_jur | Nature juridique du territoire | varchar(20) |  |  |  |  |
|  | commentaire | Commentaire | text |  |  |  |  |
|  | annee | Année de la données | varchar(10) |  |  |  |  |
|  | geom | Géométrie de l'objet | varchar(4) |  |  |  |  |
|  | src_geom | Code du référentiel géographique utilisé pour la saisie  | varchar(10) |  |  |  | référence à la table de valeur lt_src_geom |
|  | date_sai | Date d'import/ajout de la donnée dans la base | datetime |  |  |  |  |
|  | date_maj | Date de mise à jour de la donnée | datetime |  |  |  |  |


### Structure
|schéma | table | description | usage |
|:---|:---|:---|:---|   
|r_objet|lt_contrat|domaine de valeur des références de contrat sur les données gérées par les services|Gestion des accès aux prestataires|
|r_objet|lt_src_geom|domaine de valeur générique d'une table géographique|source du positionnement du PEI|
|r_administratif|an_geo|donnée de référence alphanumérique du découpage administratif |jointure insee commune<>siret epci|
|r_osm|geo_osm_commune|donnée de référence géographique du découpage communal OSM|nom de la commune|
|r_osm|geo_v_osm_commune_apc|vue de la donnée geo_osm_commune restreinte sur le secteur du compiégnois|insee + controle de saisie PEI à l'intérieur de ce périmètre|
|r_osm|geo_osm_epci|donnée de référence géographique du découpage epci OSM|nom de l'EPCI|



statut : engagement
etat : reconnu, 
date_signature : 
nature_juridique : Syndicat mixte, EPCI, autres
climagri : 0/1/2/...

src_geom : AdminExpress
src_annee : 2020


