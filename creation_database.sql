/*BLANCHET Erwan &amp; BOISSERIE Estelle, TP1H.
-------------Tables principales-------------
*/

/*Création de la table VEHICULE qui permet d'enregistrer les véhicules*/
CREATE TABLE VEHICULE (
	idVehicule INTEGER NOT NULL,
	MarqueVehicule  TEXT,
	AnneeCreation NUMERIC,  
	PrixJournal NUMERIC,
	CONSTRAINT KeyVEHICULE PRIMARY KEY (idVehicule),
	CONSTRAINT CoherencePrixJournal CHECK (PrixJournal=20)
);

/*Création de la table HISTORIQUEINVITE permttant d'enregidtrer le nombre de fois où un sponsor ai été invité à une course*/
CREATE TABLE HISTORIQUEINVITE (
    idInvite INTEGER NOT NULL,
    nbFoisInvite INTEGER,
    CONSTRAINT KeyHISTORIQUEINVITE PRIMARY KEY (idInvite),
	CONSTRAINT CoherencenbFoisInvite CHECK (nbFoisInvite>=0)
);

/*Création de la table SPONSOR donne accès aux données des sponsors*/
CREATE TABLE SPONSOR (
	idSponsor INTEGER NOT NULL,
	NomSponsor TEXT,
	DateDebutSponsoring NUMERIC NOT NULL,
	DateFinSponsoring NUMERIC,
	SiteWeb TEXT,
	TelephoneSponsor NUMERIC,
	DonnationValide TEXT,
	SponsorVenu INTEGER NOT NULL,
	AdresseSponsor INTEGER NOT NULL,
	CONSTRAINT KeySPONSOR PRIMARY KEY (idSponsor),
    CONSTRAINT ForeignHISTORIQUEINVITE FOREIGN KEY (SponsorVenu) REFERENCES HISTORIQUEINVITE,
	CONSTRAINT ForeignADRESSE FOREIGN KEY (AdresseSponsor) REFERENCES ADRESSE
);

/*Création de la table MEMBRE contient les informations sur chaque membre*/
CREATE TABLE MEMBRE (
	idMembre INTEGER NOT NULL,
	NomMembre TEXT,
	PrenomMembre TEXT,
	EmailMembre TEXT,
	TelephoneMembre INTEGER,
	DateDebutAdhesion NUMERIC NOT NULL,
	DateFinAdhesion NUMERIC,
	DonnationMembre INTEGER,
	Role TEXT,  
	AdresseMembre INTEGER NOT NULL,
	CONSTRAINT KeyMembre PRIMARY KEY (idMembre),
	CONSTRAINT ForeignADRESSE FOREIGN KEY (AdresseMembre) REFERENCES ADRESSE,
	CONSTRAINT CoherenceDonnationMembre CHECK (DonnationMembre=15)
);

/*Création de la table HISTORIQUECOURSE permet de suivre l'historique de course de chaque véhicule*/
CREATE TABLE HISTORIQUECOURSE (
	idHistoriqueCourse INTEGER NOT NULL,
	NomCourse TEXT,
	DateDebutCourse NUMERIC,
	DateFinCourse NUMERIC,
	ResultatCourse NUMERIC,
	CONSTRAINT KeyHISTORIQUECOURSE PRIMARY KEY (idHistoriqueCourse),
	CONSTRAINT CoherenceResultat CHECK (ResultatCourse > 0)
);

/*Création de la table COMPTABILITE rend disponible le suivie financier des véhicules*/
CREATE TABLE COMPTABILITE (
	idComptabilite INTEGER NOT NULL,
	Fond NUMERIC,
	Credit NUMERIC,
	Debit NUMERIC,
	Resultat NUMERIC,
	DepenseVehicule INTEGER NOT NULL,
	CONSTRAINT KeyCOMPATBILITE PRIMARY KEY (idComptabilite),
	CONSTRAINT ForeignVEHICULE FOREIGN KEY (DepenseVehicule) REFERENCES VEHICULE,
	CONSTRAINT CoherenceFond CHECK (Fond > 0),
	CONSTRAINT CoherenceCredit CHECK (Credit > 0),
	CONSTRAINT CoherenceDebit CHECK (Debit > 0),
	CONSTRAINT CoherenceResultat CHECK (Resultat > 0)
);

/*Création de la table NORME enregistre les normes que doivent respecter les pièces*/
CREATE TABLE NORME (
	idNorme INTEGER NOT NULL,
	DescriptionNorme TEXT,
	CONSTRAINT KeyNORME PRIMARY KEY (idNorme)
);

/*Création de la table TYPEPIECE qui renseigne le type d'une pièce*/
CREATE TABLE TYPEPIECE (
	idTypePiece INTEGER NOT NULL,
	PieceConsommable TEXT,
	PieceNonConsommable TEXT,
	CONSTRAINT KeyTYPEPIECE PRIMARY KEY(idTypePiece)
	CONSTRAINT CoherencePieceConsommable CHECK ((PieceConsommable='oui') or (PieceConsommable='non')),
	CONSTRAINT CoherencePieceNonConsommable CHECK ((PieceNonConsommable='oui') or (PieceNonConsommable='non'))
);

/*Création de la table FOURNISSEUR stockant les données des différent fournisseurs*/
CREATE TABLE FOURNISSEUR (
	idFournisseur INTEGER NOT NULL,
	NomFournisseur TEXT,
	EmailFournisseur TEXT,
	TelephoneFournisseur INTEGER,
	AdresseFournisseur INTEGER NOT NULL,
	CONSTRAINT KeyFOURNISSEUR PRIMARY KEY (idFournisseur),
	CONSTRAINT ForeignADRESSE FOREIGN KEY (AdresseFournisseur) REFERENCES ADRESSE
);

/*Création de la table PIECE retraçant chaque profil de pièce*/
CREATE TABLE PIECE (
	idPiece INTEGER NOT NULL,
	NomPiece TEXT,
	PrixPiece NUMERIC,
	DatePose NUMERIC,
	DateDepose NUMERIC,
	DureeDeViePiece NUMERIC,
	PieceStock INTEGER NOT NULL,
	PieceType INTEGER NOT NULL,
	CONSTRAINT KeyPIECE PRIMARY KEY (idPiece),
	CONSTRAINT ForeignSTOCK FOREIGN KEY (PieceStock) REFERENCES STOCK,
	CONSTRAINT ForeignTYPEPIECE FOREIGN KEY (PieceType) REFERENCES TYPEPIECE,
	CONSTRAINT CoherencePrix CHECK (PrixPiece >= 0),
	CONSTRAINT CoherenceDureeDeViePiece CHECK (DureeDeViePiece >= 0),
	CONSTRAINT CoherencePieceStock CHECK (PieceStock >= 0)
);

/*Création de la table STOCK qui suit le nombre disponible de chauqe pièce et outil*/
CREATE TABLE STOCK (
	idStock INTEGER NOT NULL,
	NbDisponible NUMERIC,
	CONSTRAINT KeySTOCK PRIMARY KEY (idStock),
	CONSTRAINT CoherenceNbDisponible CHECK (NbDisponible >= 0)
);

/*Création de la table OUTIL enregistrant les outils possédés*/
CREATE TABLE OUTIL (
	idOutil INTEGER NOT NULL,
	NomOutil TEXT,
	OutilEnStock INTEGER NOT NULL,
	CONSTRAINT KeyOUTIL PRIMARY KEY (idOutil),
	CONSTRAINT ForeignSTOCK FOREIGN KEY (OutilEnStock) REFERENCES STOCK,
	CONSTRAINT CoherenceOutilEnStock CHECK (OutilEnStock >= 0)
);

/*Création de la table COURSE contenant les courses à venir*/
CREATE TABLE COURSE (
	idCourse INTEGER NOT NULL,
	NomCourse TEXT,
	PremierJour NUMERIC,
	DernierJour NUMERIC,
	CONSTRAINT KeyCOURSE PRIMARY KEY (idCourse)
);

/*Création de la table ADRESSE contenant toute les adresses de la base de données*/
CREATE TABLE ADRESSE (
	idAdresse INTEGER NOT NULL,
	SuffixeAdresse NUMERIC,
	Rue TEXT,
	Ville TEXT,
	CodePostal NUMERIC,
	Pays TEXT NOT NULL,
	CONSTRAINT KeyADRESSE PRIMARY KEY (idAdresse)
);


/*------table de liaison------*/
/*Création de la table sponsorise qui relie la table VEHICULE et SPONSOR*/
CREATE TABLE sponsorise (
	idVehicule INTEGER NOT NULL,
	idSponsor INTEGER NOT NULL, 
	CONSTRAINT KeySPONSORING PRIMARY KEY (idVehicule, idSponsor),
	CONSTRAINT ForeignVEHICULE FOREIGN KEY (idVehicule) REFERENCES VEHICULE,
    CONSTRAINT ForeignSPONSOR FOREIGN KEY (idSponsor) REFERENCES SPONSOR
);

/*Création de la table s_occupe faisant le lien entre la table VEHICULE et MEMBRE*/
CREATE TABLE s_occupe (
	idVehicule INTEGER NOT NULL,
	idMembre INTEGER NOT NULL,
	CONSTRAINT KeyS_OCCUPE PRIMARY KEY (idVehicule,idMembre),
	CONSTRAINT ForeignVEHICULE FOREIGN KEY (idVehicule) REFERENCES VEHICULE,
	CONSTRAINT ForeignMEMBRE FOREIGN KEY (idMembre) REFERENCES MEMBRE
);

/*Création de la table compose reliant la table VEHICULE et PIECE*/
CREATE TABLE compose (
	idVehicule INTEGER NOT NULL,
	idPiece INTEGER NOT NULL,
	CONSTRAINT KeyCOMPOSE PRIMARY KEY (idVehicule,idPiece)
	CONSTRAINT ForeingVEHICULE FOREIGN KEY (idVehicule) REFERENCES VEHICULE,
	CONSTRAINT ForeingPIECE FOREIGN KEY (idPiece) REFERENCES PIECE
);

/*Création de la table soumit associant la table NORME et PIECE*/
CREATE TABLE soumit (
	idNorme INTEGER NOT NULL,
	idPiece INTEGER NOT NULL,
	RespectNorme TEXT NOT NULL,
	CONSTRAINT KeySOUMIT PRIMARY KEY (idNorme,idPiece)
	CONSTRAINT ForeingNORME FOREIGN KEY (idNorme) REFERENCES NORME,
	CONSTRAINT ForeingPIECE FOREIGN KEY (idPiece) REFERENCES PIECE,
	CONSTRAINT CoherenceRespectNorme CHECK ((RespectNorme='oui') or (RespectNorme='non'))
);

/*Création de la table fournit faisant le lien entre la table FOURNISSEUR et PIECE*/
CREATE TABLE fournit (
	idFournisseur INTEGER NOT NULL,
	idPiece INTEGER NOT NULL,
	CONSTRAINT KeyCOMPOSE PRIMARY KEY (idFournisseur,idPiece)
	CONSTRAINT ForeingFOURNISSEUR FOREIGN KEY (idFournisseur) REFERENCES FOURNISSEUR,
	CONSTRAINT ForeingPIECE FOREIGN KEY (idPiece) REFERENCES PIECE
);

/*Création de la table achete_a reliant la table FOURNISSEUR et OUTIL*/
CREATE TABLE achete_a (
	idFournisseur INTEGER NOT NULL,
	idOutil INTEGER NOT NULL,
	CONSTRAINT KeyACHETE_A PRIMARY KEY (idFournisseur,idOutil)
	CONSTRAINT ForeingFOURNISSEUR FOREIGN KEY (idFournisseur) REFERENCES FOURNISSEUR,
	CONSTRAINT ForeingOUTIL FOREIGN KEY (idOutil) REFERENCES OUTIL
);

/*Création de la table utilise qui associe la table VEHICULE et OUTIL*/
CREATE TABLE utilise (
	idVehicule INTEGER NOT NULL,
	idOutil INTEGER NOT NULL,
	CONSTRAINT KeyUTILISE PRIMARY KEY (idVehicule,idOutil)
	CONSTRAINT ForeingVEHICULE FOREIGN KEY (idVehicule) REFERENCES VEHICULE,
	CONSTRAINT ForeingOUTIL	FOREIGN KEY (idOutil) REFERENCES OUTIL
);

/*Création de la table va_participer permettant l'association entre la table VEHICULE et COURSE*/
CREATE TABLE va_participer (
	idVehicule INTEGER NOT NULL,
	idCOURSE INTEGER NOT NULL,
	CONSTRAINT KeyVA_PARTICIPER PRIMARY KEY (idVehicule,idCourse)
	CONSTRAINT ForeingVEHICULE FOREIGN KEY (idVehicule) REFERENCES VEHICULE,
	CONSTRAINT ForeingCOURSE FOREIGN KEY (idCourse) REFERENCES COURSE
);

/*Création de la table a_participe permettant l'association entre HISTORIQUECOURSE et VEHICULE*/
CREATE TABLE a_participe (
	idVehicule INTEGER NOT NULL,
	idHistoriqueCourse INTEGER NOT NULL,
	CONSTRAINT KeyVA_PARTICIPER PRIMARY KEY (idVehicule,idHistoriqueCourse)
	CONSTRAINT ForeingVEHICULE FOREIGN KEY (idVehicule) REFERENCES VEHICULE,
	CONSTRAINT ForeingCOURSE FOREIGN KEY (idHistoriqueCourse) REFERENCES HISTORIQUECOURSE
);