/* ---------------------------------------------------- */
/*  Generated by Enterprise Architect Version 12.1 		*/
/*  Created On : 11-Sep-2017 19:48:31 				*/
/*  DBMS       : MySql 						*/
/* ---------------------------------------------------- */

/* sets a h2 db into mysql mode */
SET MODE MySQL
;

SET FOREIGN_KEY_CHECKS=0 
;

/* Drop Tables */

DROP TABLE IF EXISTS `CHECK` CASCADE
;

DROP TABLE IF EXISTS `CHECK_RESULT` CASCADE
;

DROP TABLE IF EXISTS `COMPONENT` CASCADE
;

DROP TABLE IF EXISTS `CONFIGURATION` CASCADE
;

DROP TABLE IF EXISTS `DEPENDENCY` CASCADE
;

DROP TABLE IF EXISTS `DEPLOYMENT` CASCADE
;

DROP TABLE IF EXISTS `EDIT` CASCADE
;

DROP TABLE IF EXISTS `EDITOR` CASCADE
;

DROP TABLE IF EXISTS `ENVIRONMENT` CASCADE
;

DROP TABLE IF EXISTS `HYPERLINK` CASCADE
;

DROP TABLE IF EXISTS `NOTE` CASCADE
;

DROP TABLE IF EXISTS `PACKAGE` CASCADE
;

DROP TABLE IF EXISTS `RELEASE` CASCADE
;

DROP TABLE IF EXISTS `RELEASE_PACKAGE` CASCADE
;

/* Create Tables */

CREATE TABLE `CHECK`
(
	`ID` DECIMAL(10,0) NOT NULL COMMENT 'GENERATED AS IDENTITY,',
	`SHORT` VARCHAR(10) 	 NULL COMMENT 'Kurzbezeichner der Pruefregel.',
	`NAME` VARCHAR(80) 	 NULL COMMENT 'Bezeichner der Pruefregel',
	`QUESTION` VARCHAR(255) 	 NULL COMMENT 'Zentrale Fragestgellung fuer die Pruefung.',
	`WHO` VARCHAR(255) 	 NULL COMMENT 'Wer ist fuer den Check verantwortlich?',
	`WHEN` VARCHAR(255) 	 NULL COMMENT 'Bis wann wird die Pruefung benoetigt.',
	`WHEREBY` VARCHAR(255) 	 NULL COMMENT 'Womit koennen die Ergebnisse ermittelt werden. Tools, Filetypes, SVN/Artifactory, etc. pp.',
	`DESCRIPTION` VARCHAR(2000) 	 NULL COMMENT 'Umfangreiche Beschreibung der Checks',
	CONSTRAINT `PK_Checks` PRIMARY KEY (`ID` ASC)
)
COMMENT='In dieser Tabelle werden alle Checkups fuer ein Release gespeichert.'

;

CREATE TABLE `CHECK_RESULT`
(
	`ID` DECIMAL(10,0) NOT NULL COMMENT 'GENERATED AS IDENTITY,',
	`CHECK_ID` DECIMAL(10,0) 	 NULL,
	`DEPLOYMENT_ID` DECIMAL(10,0) 	 NULL,
	`PACKAGE_ID` DECIMAL(10,0) 	 NULL COMMENT 'Relation zu einem Package im Artifactory',
	`COMPONENT_ID` DECIMAL(10,0) 	 NULL COMMENT 'Optional fuer ComponentCheckups (pre Artifactory)',
	`RESULT` DECIMAL(1,0) 	 NULL COMMENT 'Code: -1 = Not checked (default),  0 = Nicht OK, 1 = Teilweise OK, 2 = Voll OK, 99 = Nicht beruecksichtigt, 10 = Create, 20 = Read, 30 = Update, 40 = Delete',
	`REASON` VARCHAR(2000) 	 NULL COMMENT 'Begruendung fuer das Ergebnis. Optional fuer OK, Pflicht fuer Nicht OK.',
	CONSTRAINT `PK_CheckResults` PRIMARY KEY (`ID` ASC)
)
COMMENT='Hier werden die Pruefergebnisse der Checkups gespeichert.'

;

CREATE TABLE `COMPONENT`
(
	`ID` DECIMAL(10,0) NOT NULL COMMENT 'GENERATED AS IDENTITY,',
	`PARENT_ID` DECIMAL(10,0) 	 NULL,
	`SHORT` VARCHAR(8) 	 NULL COMMENT 'Kurzbezeichner',
	`NAME` VARCHAR(80) 	 NULL,
	`PATH` VARCHAR(500) 	 NULL COMMENT 'SVN Pfad',
	`TECHNOLOGY` VARCHAR(80) 	 NULL COMMENT 'CPP, Smalltalk, C, Angular, TIBCO, ...',
	CONSTRAINT `PK_Components` PRIMARY KEY (`ID` ASC)
)
COMMENT='Komponenten werden von UE entwickelt und als Sourcecode in SVN gespeichert.'

;

CREATE TABLE `CONFIGURATION`
(
	`ID` DECIMAL(10,0) NOT NULL COMMENT 'GENERATED AS IDENTITY,',
	`PARENT_ID` DECIMAL(10,0) 	 NULL COMMENT 'Zu welcher Konfigurationseinheit gehoert dieser Eintrag. Beispiel: Ein Key/Value gehoert zu einer Gruppe, eine Gruppe ist Teil einer Datei eine Datei liegt in einem Folder, ein Folder ist Teil eines Dateisystems, eine Dateisystem gehoert zu einem Rechner, ...',
	`KEY` VARCHAR(80) 	 NULL COMMENT 'Attributbezeichner',
	`VALUE` VARCHAR(2000) 	 NULL COMMENT 'Attributwert',
	`TYPE` VARCHAR(80) 	 NULL COMMENT 'Attributtyp',
	`TOKEN` VARCHAR(80) 	 NULL COMMENT 'Tokenbezeichner',
	`DESCRIPTION` VARCHAR(2000) 	 NULL COMMENT 'Beschreibung des Key / Value Paares',
	CONSTRAINT `PK_Configurations` PRIMARY KEY (`ID` ASC)
)

;

CREATE TABLE `DEPENDENCY`
(
	`ID` DECIMAL(10,0) NOT NULL COMMENT 'GENERATED AS IDENTITY,',
	`PACKAGE_ID_SOURCE` DECIMAL(10,0) 	 NULL,
	`PACKAGE_ID_TARGET` DECIMAL(10,0) 	 NULL,
	`TYPE` VARCHAR(50) 	 NULL COMMENT 'Definiert den Beziehungstyp zwischen Source und Target.',
	CONSTRAINT `PK_Dependencies` PRIMARY KEY (`ID` ASC)
)

;

CREATE TABLE `DEPLOYMENT`
(
	`ID` DECIMAL(10,0) NOT NULL COMMENT 'GENERATED AS IDENTITY,',
	`DUE` DATETIME 	 NULL COMMENT 'Zieltermin einer Lieferung',
	`STATE` VARCHAR(50) 	 NULL COMMENT 'Status einer Lieferung: Planned, Done',
	`RELEASE_ID` DECIMAL(10,0) 	 NULL COMMENT 'Relation zu einem Release',
	`ENVIRONMENT_ID` DECIMAL(10,0) 	 NULL COMMENT 'Relation zu einer Umgebung',
	CONSTRAINT `PK_Deployments` PRIMARY KEY (`ID` ASC)
)
COMMENT='Ein Deployment bringt ein Release auf eine Umgebung.'

;

CREATE TABLE `EDIT`
(
	`ID` DECIMAL(10,0) NOT NULL COMMENT 'GENERATED AS IDENTITY,',
	`REF_ID` DECIMAL(10,0) 	 NULL COMMENT 'Zeile in einer anderen Tabelle (REF_ENTITY).',
	`REF_ENTITY` VARCHAR(50) 	 NULL COMMENT 'Auf welche Tabelle bezieht sich die REF_ID.',
	`FIRST_EDIT` DATETIME(6) 	 NULL COMMENT 'Wann wurde der Datensatz erstmalig angelegt.',
	`FIRST_EDITOR_ID` DECIMAL(10,0) 	 NULL COMMENT 'Wer hat den Datensatz erstmalig angelegt',
	`LAST_EDIT` DATETIME(6) 	 NULL COMMENT 'Wann wurde der Datensatz zuletzt geaendert.',
	`LAST_EDITOR_ID` DECIMAL(10,0) 	 NULL COMMENT 'Von wem wurde der Datensatz zuletzt geaendert.',
	CONSTRAINT `PK_Edits` PRIMARY KEY (`ID` ASC)
)
COMMENT='Eine minimal Historien-Verwaltung der Datensaetze.'

;

CREATE TABLE `EDITOR`
(
	`ID` DECIMAL(10,0) NOT NULL COMMENT 'GENERATED AS IDENTITY,',
	`NAME` VARCHAR(8) 	 NULL,
	`SURNAME` VARCHAR(255) 	 NULL,
	`EMAIL` VARCHAR(255) 	 NULL,
	`BIRTHDAY` DATETIME 	 NULL COMMENT 'Einfacher Login mit Email und Geburtstag.',
	CONSTRAINT `PK_Editors` PRIMARY KEY (`ID` ASC)
)
COMMENT='Basis-Tabelle fuer ein User-Management. Wird weiterhin ueber das Jaxio Beispiel ausgepraegt.'

;

CREATE TABLE `ENVIRONMENT`
(
	`ID` DECIMAL(10,0) NOT NULL COMMENT 'GENERATED AS IDENTITY,',
	`SHORT` VARCHAR(8) 	 NULL COMMENT 'Kurzbezeichnung der Umgebung, z.b. EU, IEU, ITU, ABN, PRD, ...',
	`NAME` VARCHAR(255) 	 NULL COMMENT 'Ausfuehrliche Bezeichnung z.b. Integrierte Testumgebung.',
	CONSTRAINT `PK_Environments` PRIMARY KEY (`ID` ASC)
)
COMMENT='Eine Umgebung stellt eine logische Einheit fuer einen bestimmten Zweck dar. Zum Beispiel: IEU ist eine integrierte Entwicklungsumgebung, waehrend eine ITU eine integrierte Testumgebung darstellt.'

;

CREATE TABLE `HYPERLINK`
(
	`ID` DECIMAL(10,0) NOT NULL COMMENT 'GENERATED AS IDENTITY,',
	`REF_ID` DECIMAL(10,0) 	 NULL COMMENT 'Referenz fuer diesen Hyperlink',
	`REF_ENTITY` VARCHAR(50) 	 NULL COMMENT 'Auf welche Entitaet (z.b. Environments, Deployments) bezieht sich die Ref_ID',
	`TITLE` VARCHAR(80) 	 NULL COMMENT 'Titel der angezeigt wird.',
	`URL` VARCHAR(255) 	 NULL,
	`DESCRIPTION` VARCHAR(255) 	 NULL COMMENT 'Text fuer z.b. Tooltips',
	CONSTRAINT `PK_Hyperlinks` PRIMARY KEY (`ID` ASC)
)
COMMENT='Hiermit koennen beliebig viele Hyperlinks an jeder beliebigen Zeile in jeder beliebigen Tabelle verwalten werden.'

;

CREATE TABLE `NOTE`
(
	`ID` DECIMAL(10,0) NOT NULL COMMENT 'GENERATED AS IDENTITY,',
	`RELEASE_ID` DECIMAL(10,0) 	 NULL,
	`NOTE` VARCHAR(4000) 	 NULL,
	CONSTRAINT `PK_Notes` PRIMARY KEY (`ID` ASC)
)

;

CREATE TABLE `PACKAGE`
(
	`ID` DECIMAL(10,0) NOT NULL COMMENT 'GENERATED AS IDENTITY,',
	`COMPONENTE_ID` DECIMAL(10,0) 	 NULL,
	`VERSION` VARCHAR(20) 	 NULL COMMENT 'Die Package Version wird aus der Component-Version plus Jenkins Build-ID zusammengesetzt.',
	`PATH` VARCHAR(255) 	 NULL COMMENT 'Artifactory Path',
	CONSTRAINT `PK_Packages` PRIMARY KEY (`ID` ASC)
)
COMMENT='Packete werden ueber eine CI Pipeline erzeugt und in Artifactory gespeichert.'

;

CREATE TABLE `RELEASE`
(
	`ID` DECIMAL(10,0) NOT NULL COMMENT 'GENERATED AS IDENTITY,',
	`NAME` VARCHAR(80) 	 NULL,
	`VERSION` VARCHAR(20) 	 NULL COMMENT 'PRD.PI.SP-Hotfix Hotfix A,B,C...',
	`STATE` VARCHAR(20) 	 NULL COMMENT 'Status eines Release, z.b. Created, Assigned, Checked, Delivered, Live, Postponed, ...',
	CONSTRAINT `PK_Releases` PRIMARY KEY (`ID` ASC)
)
COMMENT='Eine Release wird im Laufe eines PI in einem ART entwickelt. pro Sprint soll eine weitere Version des Release entstehen.'

;

CREATE TABLE `RELEASE_PACKAGE`
(
	`ID` DECIMAL(10,0) NOT NULL COMMENT 'GENERATED AS IDENTITY,',
	`PACKAGE_ID` DECIMAL(10,0) 	 NULL,
	`RELEASE_ID` DECIMAL(10,0) 	 NULL,
	CONSTRAINT `PK_ReleasePackages` PRIMARY KEY (`ID` ASC)
)
COMMENT='Diese Tabelle enthaellt die Beziehung zwischen Paketen und Release.'

;

/* Create Foreign Key Constraints */

ALTER TABLE `CHECK_RESULT` 
 ADD CONSTRAINT `FK_CHECKRESULTS_CHECKS`
	FOREIGN KEY (`ID`) REFERENCES `CHECK` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `CHECK_RESULT` 
 ADD CONSTRAINT `FK_CHECKRESULTS_COMPONENTS`
	FOREIGN KEY (`ID`) REFERENCES `COMPONENT` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `CHECK_RESULT` 
 ADD CONSTRAINT `FK_CheckResults_Deployments`
	FOREIGN KEY (`ID`) REFERENCES `DEPLOYMENT` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `CHECK_RESULT` 
 ADD CONSTRAINT `FK_CheckResults_Packages`
	FOREIGN KEY (`ID`) REFERENCES `PACKAGE` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `DEPLOYMENT` 
 ADD CONSTRAINT `FK_Deployments_Environments`
	FOREIGN KEY (`ID`) REFERENCES `ENVIRONMENT` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `DEPLOYMENT` 
 ADD CONSTRAINT `FK_DEPLOYMENTS_RELEASES`
	FOREIGN KEY (`ID`) REFERENCES `RELEASE` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `EDIT` 
 ADD CONSTRAINT `FK_Edits_Editors`
	FOREIGN KEY (`ID`) REFERENCES `EDITOR` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `RELEASE_PACKAGE` 
 ADD CONSTRAINT `FK_RELEASE_PACKAGES_PACKAGES`
	FOREIGN KEY (`ID`) REFERENCES `PACKAGE` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `RELEASE_PACKAGE` 
 ADD CONSTRAINT `FK_RELEASE_PACKAGES_RELEASES`
	FOREIGN KEY (`ID`) REFERENCES `RELEASE` (`ID`) ON DELETE No Action ON UPDATE No Action
;

SET FOREIGN_KEY_CHECKS=1 
;
