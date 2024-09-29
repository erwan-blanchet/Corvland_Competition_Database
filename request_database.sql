/*
****************************************************
*   -----            -----         -----           *
*      BOISSERIE Estelle & BLANCHET Erwan TP1H     *
*    ------         REQUÊTES SQL       ------      *
*					 -----						   *
****************************************************
*/

/*Donne le rôle de Monsieur SCHOONHERRE*/
SELECT MEMBRE.NomMembre, MEMBRE.PrenomMembre, Membre.Role
FROM MEMBRE
WHERE MEMBRE.NomMembre='Schoonheere'

/*Affiche les membres ayant quitté l'association avant 2021*/
SELECT MEMBRE.NomMembre, MEMBRE.PrenomMembre, MEMBRE.DateDebutAdhesion, MEMBRE.DateFinAdhesion
FROM MEMBRE
WHERE MEMBRE.DateFinAdhesion<'01/01/2021'

/*Affiche les membres n'ayant pas de role*/
SELECT MEMBRE.NomMembre, MEMBRE.PrenomMembre
FROM MEMBRE
WHERE MEMBRE.Role is NULL

/*Affiche les mécanicien*/
SELECT MEMBRE.NomMembre, MEMBRE.PrenomMembre, MEMBRE.Role
FROM MEMBRE
WHERE MEMBRE.Role='Mecanicien'

/*Affiche les membres n'habitant pas en France*/
SELECT MEMBRE.NomMembre, MEMBRE.PrenomMembre, ADRESSE.SuffixeAdresse, ADRESSE.Rue, ADRESSE.Ville, ADRESSE.CodePostal, ADRESSE.Pays
FROM MEMBRE
INNER JOIN ADRESSE
ON MEMBRE.AdresseMembre = ADRESSE.idAdresse
WHERE ADRESSE.Pays != 'France'

/*Affiche le prix du journal*/
SELECT DISTINCT VEHICULE.PrixJournal
FROM VEHICULE

/*Affiche les véhicules créer après 2010*/
SELECT VEHICULE.MarqueVehicule, VEHICULE.AnneeCreation
FROM VEHICULE
WHERE VEHICULE.AnneeCreation>'2010'

/*Affiche les courses où CORVLAND COMPETITION est arrivé première*/
SELECT HISTORIQUECOURSE.NomCourse, HISTORIQUECOURSE.ResultatCourse
FROM HISTORIQUECOURSE
WHERE HISTORIQUECOURSE.ResultatCourse = 1

/*Affiche la moyenne des débits et la moyennes des crédits*/
SELECT AVG(COMPTABILITE.Credit)ArgentGagne, AVG(COMPTABILITE.Debit)AgentDepense
FROM COMPTABILITE

/*Affiche les pièces consommable*/
SELECT PIECE.NomPiece
FROM PIECE
INNER JOIN TYPEPIECE
ON PIECE.PieceType=TYPEPIECE.idTypePiece
WHERE TYPEPIECE.PieceConsommable = 'oui'

/*Affiche les pièces dont le prix est inferieur à 60€*/
SELECT PIECE.NomPiece, PIECE.PrixPiece
FROM PIECE
WHERE PIECE.PrixPiece<60

/*Affcihe les informations de contact du fournisseur STAP*/
SELECT FOURNISSEUR.EmailFournisseur, FOURNISSEUR.TelephoneFournisseur, ADRESSE.SuffixeAdresse, ADRESSE.Rue, ADRESSE.Ville, ADRESSE.CodePostal, ADRESSE.Pays
FROM FOURNISSEUR
INNER JOIN ADRESSE
ON FOURNISSEUR.AdresseFournisseur=ADRESSE.idAdresse
WHERE FOURNISSEUR.NomFournisseur='STAP'

/*Affiche le nombre d'outil en stock*/
SELECT STOCK.NbDisponible
FROM OUTIL
INNER JOIN STOCK
ON OUTIL.OutilEnStock=STOCK.idStock
WHERE OUTIL.NomOutil='Cric'

/*Affiche les noms des pièces n'étant pas plus de quatre dans le stock*/
SELECT PIECE.NomPiece, STOCK.NbDisponible
FROM PIECE
INNER JOIN STOCK
ON PIECE.PieceStock= STOCK.idStock
WHERE STOCK.NbDisponible<=4

/*Affiche le nombre de sponsors ayant été unvité neuf fois à des courses.*/
SELECT COUNT(SPONSOR.idSponsor)nbsponsortinvite9fois
FROM SPONSOR
INNER JOIN HISTORIQUEINVITE
ON SPONSOR.idSponsor=HISTORIQUEINVITE.idInvite
WHERE HISTORIQUEINVITE.nbFoisInvite = 9

/*Affiche les adresses ayant renseigner qu'un pays et a qui elles correspondent*/
SELECT SPONSOR.NomSponsor, ADRESSE.Pays
FROM ADRESSE
INNER JOIN SPONSOR
ON ADRESSE.idAdresse=SPONSOR.AdresseSponsor
WHERE ADRESSE.SuffixeAdresse is NULL
AND ADRESSE.CodePostal is NULL
AND ADRESSE.Rue is NULL
AND ADRESSE.Ville is NULL

/*Affcihe les sponsors sponsorisant le véhicule numéro 1*/
SELECT SPONSOR.NomSponsor
FROM SPONSOR
INNER JOIN sponsorise
ON SPONSOR.idSponsor=sponsorise.idSponsor
INNER JOIN VEHICULE
ON VEHICULE.idVehicule=sponsorise.idVehicule
WHERE sponsorise.idVehicule=1
GROUP BY SPONSOR.NomSponsor

/*Affiche le fournisseur de marteau*/
SELECT FOURNISSEUR.NomFournisseur
FROM FOURNISSEUR
INNER JOIN achete_a
ON FOURNISSEUR.idFournisseur=achete_a.idFournisseur
INNER JOIN OUTIL
ON OUTIL.idOutil=achete_a.idOutil
WHERE achete_a.idOutil=1

/*Affiche les outils selon le véhicule qui les utilise*/
SELECT OUTIL.NomOutil
FROM VEHICULE
INNER JOIN utilise
ON utilise.idVehicule=utilise.idVehicule
INNER JOIN OUTIL
ON OUTIL.idOutil=utilise.idOutil
GROUP BY OUTIL.NomOutil

/*Affiche les pieces fournit par Vornado Realty*/
SELECT PIECE.NomPiece
FROM PIECE
INNER JOIN fournit
ON PIECE.idPiece=fournit.idPiece
INNER JOIN FOURNISSEUR
ON FOURNISSEUR.idFournisseur=fournit.idFournisseur
WHERE FOURNISSEUR.NomFournisseur='Vornado Realty'

/*Affiche les piece qui respect des normes et lesquelles*/
SELECT PIECE.NomPiece, NORME.DescriptionNorme
FROM PIECE
INNER JOIN soumit
ON soumit.idPiece=PIECE.idPiece
INNER JOIN NORME
ON NORME.idNorme=soumit.idNorme
WHERE soumit.RespectNorme='oui'

/*Affiche les pièce composant un vehicule selon les pièces*/
SELECT VEHICULE.MarqueVehicule, PIECE.NomPiece
FROM PIECE
INNER JOIN compose
ON PIECE.idPiece=compose.idPiece
INNER JOIN VEHICULE
ON VEHICULE.idVehicule=compose.idVehicule
WHERE compose.idVehicule=1
GROUP BY VEHICULE.MarqueVehicule, PIECE.NomPiece

/*Affiche les pièces qui compose le véhicule numéro deux*/
SELECT PIECE.NomPiece
FROM PIECE
INNER JOIN compose
ON PIECE.idPiece=compose.idPiece
INNER JOIN VEHICULE
ON VEHICULE.idVehicule=compose.idVehicule
WHERE compose.idVehicule=2

/*Affiche les courses auquelles à participer le véhicule numéro 2*/
SELECT HISTORIQUECOURSE.NomCourse, HISTORIQUECOURSE.DateDebutCourse, HISTORIQUECOURSE.DateFinCourse
FROM HISTORIQUECOURSE
INNER JOIN a_participe
ON HISTORIQUECOURSE.idHistoriqueCourse=a_participe.idHistoriqueCourse
INNER JOIN VEHICULE
ON a_participe.idVehicule=VEHICULE.idVehicule
WHERE a_participe.idVehicule=2

/*Affiche le temps qu'a passe Angélique BERTIN dans l'association*/
SELECT MEMBRE.NomMembre, MEMBRE.PrenomMembre, COUNT(MEMBRE.DateFinAdhesion-MEMBRE.DateDebutAdhesion)NbAnneDAdhesion
FROM MEMBRE
WHERE MEMBRE.NomMembre='Bertin'
AND MEMBRE.PrenomMembre='Angélique'

/*Somme des résultats*/
SELECT SUM(COMPTABILITE.Resultat)TotalResultat
FROM COMPTABILITE

/*Affiche la durée maximum d'une durée de vie d'une pièce et le minimum*/
SELECT MIN(PIECE.DureeDeViePiece)DureeMinimumPiece, MAX(PIECE.DureeDeViePiece)DureeMaximumPiece
FROM PIECE

/*Donne les membres s'occupant du véhicule numéro 1*/
SELECT MEMBRE.NomMembre, MEMBRE.PrenomMembre
FROM MEMBRE
INNER JOIN s_occupe
ON MEMBRE.idMembre=s_occupe.idMembre
INNER JOIN VEHICULE
ON s_occupe.idVehicule=VEHICULE.idVehicule
WHERE VEHICULE.idVehicule=1