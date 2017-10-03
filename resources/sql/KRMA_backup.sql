/* ---------------------------------------------------- */
/*  Generated by Enterprise Architect Version 12.1 		*/
/*  Created On : 01-Okt-2017 19:25:06 				*/
/*  DBMS       : MySql 						*/
/* ---------------------------------------------------- */

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

DROP TABLE IF EXISTS `NOTE_ENTRY` CASCADE
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
	`ID` int not null IDENTITY,
	`SHORT` VARCHAR(10) NULL COMMENT 'Kurzbezeichner der Pruefregel.',
	`NAME` VARCHAR(80) 	 NULL COMMENT 'Bezeichner der Pruefregel',
	`QUESTION` VARCHAR(255) 	 NULL COMMENT 'Zentrale Fragestgellung fuer die Pruefung.',
	`WHO` VARCHAR(255) 	 NULL COMMENT 'Wer fuehrt den Check durch, wer nimmt ihn ab.',
	`WHOM` VARCHAR(255) 	 NULL COMMENT 'Wer nimmt den Check ab.',
	`WHEN` VARCHAR(255) 	 NULL COMMENT 'Bis wann wird die Pruefung benoetigt.',
	`WHEREBY` VARCHAR(255) 	 NULL COMMENT 'Womit koennen die Ergebnisse ermittelt werden. Tools, Filetypes, SVN/Artifactory, etc. pp.',
	`DESCRIPTION` VARCHAR(2000) 	 NULL COMMENT 'Umfangreiche Beschreibung der Checks',
	CONSTRAINT `PK_Checks` PRIMARY KEY (`ID` ASC)
)
COMMENT='In dieser Tabelle werden alle Checkups fuer ein Release gespeichert.'

;

CREATE TABLE `CHECK_RESULT`
(
	`ID` int not null IDENTITY,
	`CHECK_ID` DECIMAL(10,0) 	 NULL,
	`DEPLOYMENT_ID` DECIMAL(10,0) 	 NULL,
	`RELEASE_ID` DECIMAL(10,0) 	 NULL,
	`COMPONENT_ID` DECIMAL(10,0) 	 NULL COMMENT 'Optional fuer ComponentCheckups (pre Artifactory)',
	`RESULT` DECIMAL(1,0) 	 NULL COMMENT 'Code: -1 = Not checked (default),  0 = Nicht OK, 1 = Teilweise OK, 2 = Voll OK, 99 = Nicht beruecksichtigt, 10 = Create, 20 = Read, 30 = Update, 40 = Delete',
	`REASON` VARCHAR(2000) 	 NULL COMMENT 'Begruendung fuer das Ergebnis. Optional fuer OK, Pflicht fuer Nicht OK.',
	CONSTRAINT `PK_CheckResults` PRIMARY KEY (`ID` ASC)
)
COMMENT='Hier werden die Pruefergebnisse der Checkups gespeichert.'

;

CREATE TABLE `COMPONENT`
(
	`ID` int not null IDENTITY,
	`PARENT_ID` DECIMAL(10,0) 	 NULL COMMENT 'Uebergeordnete Komponente',
	`SHORT` VARCHAR(8) 	 NULL COMMENT 'Kurzbezeichner',
	`NAME` VARCHAR(80) NOT NULL,
	`PATH` VARCHAR(500) 	 NULL COMMENT 'SVN Pfad',
	`TECHNOLOGY` VARCHAR(80) 	 NULL COMMENT 'CPP, Smalltalk, C, Angular, TIBCO, ...',
	`TYPE` VARCHAR(30) 	 NULL COMMENT 'Welche Art von Komponente liegt vor. Application- oder Service- oder System-Komponente.',
	CONSTRAINT `PK_Components` PRIMARY KEY (`ID` ASC)
)
COMMENT='Applikations-Komponenten werden von UE entwickelt und als Sourcecode in SVN gespeichert. System- und Service-Komponenten werden vom UM bereitgestellt.'

;

CREATE TABLE `CONFIGURATION`
(
	`ID` int not null IDENTITY,
	`PARENT_ID` DECIMAL(10,0) 	 NULL COMMENT 'Uebergeordnetes Element.',
	`COMPONENT_ID` DECIMAL(10,0) 	 NULL,
	`ENVIRONMENT_ID` DECIMAL(10,0) 	 NULL,
	`KEY` VARCHAR(80) 	 NULL COMMENT 'Attributbezeichner',
	`VALUE` VARCHAR(2000) 	 NULL COMMENT 'Attributwert',
	`TOKEN` VARCHAR(80) 	 NULL COMMENT 'Tokenbezeichner',
	`DESCRIPTION` VARCHAR(2000) 	 NULL COMMENT 'Beschreibung des Key / Value Paares',
	`TYPE` VARCHAR(30) 	 NULL COMMENT 'Attributtyp',
	CONSTRAINT `PK_Configurations` PRIMARY KEY (`ID` ASC)
)

;

CREATE TABLE `DEPENDENCY`
(
	`ID` int not null IDENTITY,
	`PACKAGE_ID` DECIMAL(10,0) 	 NULL,
	`TYPE` VARCHAR(30) 	 NULL COMMENT 'Definiert den Beziehungstyp zwischen Source und Target.',
	CONSTRAINT `PK_Dependencies` PRIMARY KEY (`ID` ASC)
)

;

CREATE TABLE `DEPLOYMENT`
(
	`ID` int not null IDENTITY,
	`RELEASE_ID` DECIMAL(10,0) 	 NULL COMMENT 'Relation zu einem Release',
	`ENVIRONMENT_ID` DECIMAL(10,0) 	 NULL COMMENT 'Relation zu einer Umgebung',
	`DUE` DATETIME 	 NULL COMMENT 'Zieltermin einer Lieferung',
	`STATE` VARCHAR(30) 	 NULL COMMENT 'Status einer Lieferung: Planned, Done',
	`TYPE` VARCHAR(30) 	 NULL COMMENT 'Automatisch, Manuell',
	CONSTRAINT `PK_Deployments` PRIMARY KEY (`ID` ASC)
)
COMMENT='Ein Deployment bringt ein Release auf eine Umgebung.'

;

CREATE TABLE `EDIT`
(
	`ID` int not null IDENTITY,
	`REF_ID` DECIMAL(10,0) 	 NULL COMMENT 'Zeile in einer anderen Tabelle (REF_ENTITY).',
	`REF_ENTITY` VARCHAR(50) 	 NULL COMMENT 'Auf welche Tabelle bezieht sich die REF_ID.',
	`FIRST_EDIT` DATETIME(6) 	 NULL COMMENT 'Wann wurde der Datensatz erstmalig angelegt.',
	`FIRST_EDITOR_ID` DECIMAL(10,0) 	 NULL COMMENT 'Wer hat den Datensatz erstmalig angelegt',
	`LAST_EDIT` DATETIME(6) 	 NULL COMMENT 'Wann wurde der Datensatz zuletzt geaendert.',
	`LAST_EDITOR_ID` DECIMAL(10,0) 	 NULL COMMENT 'Von wem wurde der Datensatz zuletzt geaendert.',
	CONSTRAINT `PK_Edits` PRIMARY KEY (`ID` ASC)
)
COMMENT='Eine minimale Historien-Verwaltung der Datensaetze. Die Relationen werden im MDA Prozess erzeugt.'

;

CREATE TABLE `EDITOR`
(
	`ID` int not null IDENTITY,
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
	`ID` int not null IDENTITY,
	`SHORT` VARCHAR(8) NOT NULL COMMENT 'Kurzbezeichnung der Umgebung, z.b. EU, IEU, ITU, ABN, PRD, ...',
	`NAME` VARCHAR(80) NOT NULL COMMENT 'Ausfuehrliche Bezeichnung z.b. Integrierte Testumgebung.',
	`STATE` VARCHAR(30) 	 NULL COMMENT 'Status der Umgebung: active, inactive',
	`TYPE` VARCHAR(30) 	 NULL COMMENT 'Typ der Umgebung: Bare Metal, VM, Docker, AMI, ...',
	CONSTRAINT `PK_Environments` PRIMARY KEY (`ID` ASC)
)
COMMENT='Eine Umgebung stellt eine logische Einheit fuer einen bestimmten Zweck dar. Zum Beispiel: IEU ist eine integrierte Entwicklungsumgebung, waehrend eine ITU eine integrierte Testumgebung darstellt.'

;

CREATE TABLE `HYPERLINK`
(
	`ID` int not null IDENTITY,
	`REF_ID` DECIMAL(10,0) 	 NULL COMMENT 'Referenz fuer diesen Hyperlink',
	`REF_ENTITY` VARCHAR(50) 	 NULL COMMENT 'Auf welche Entitaet (z.b. Environments, Deployments) bezieht sich die Ref_ID',
	`TITLE` VARCHAR(80) 	 NULL COMMENT 'Titel der angezeigt wird.',
	`URL` VARCHAR(255) 	 NULL,
	`DESCRIPTION` VARCHAR(255) 	 NULL COMMENT 'Text fuer z.b. Tooltips',
	CONSTRAINT `PK_Hyperlinks` PRIMARY KEY (`ID` ASC)
)
COMMENT='Hiermit koennen beliebig viele Hyperlinks an jeder beliebigen Zeile in jeder beliebigen Tabelle verwalten werden. Relationen werden im MDA Prozess erzeugt.'

;

CREATE TABLE `NOTE`
(
	`ID` int not null IDENTITY,
	`RELEASE_ID` DECIMAL(10,0) 	 NULL,
	`COMPONENT_ID` DECIMAL(10,0) 	 NULL,
	`ARTEFACT_NAME` VARCHAR(80) 	 NULL,
	`ARTEFACT_TYPE` VARCHAR(30) 	 NULL,
	`ARTEFACT_VERSION` VARCHAR(30) 	 NULL,
	`DESCRIPTION` VARCHAR(4000) 	 NULL,
	CONSTRAINT `PK_NOTE` PRIMARY KEY (`ID` ASC)
)
COMMENT='Master Entitaet fuer eine Relese Note'

;

CREATE TABLE `NOTE_ENTRY`
(
	`ID` int not null IDENTITY,
	`NOTE_ID` DECIMAL(10,0) NOT NULL,
	`DESCRIPTION` VARCHAR(2000) 	 NULL,
	`TICKET` VARCHAR(80) 	 NULL,
	`TYPE` VARCHAR(30) 	 NULL COMMENT 'Story,Bugfix,Limitation',
	CONSTRAINT `PK_Notes` PRIMARY KEY (`ID` ASC)
)

;

CREATE TABLE `PACKAGE`
(
	`ID` int not null IDENTITY,
	`COMPONENT_ID` DECIMAL(10,0) 	 NULL,
	`VERSION` VARCHAR(30) NOT NULL COMMENT 'Die Package Version wird aus der Component-Version plus Jenkins Build-ID zusammengesetzt.',
	`PATH` VARCHAR(255) 	 NULL COMMENT 'Artifactory Path',
	`TYPE` VARCHAR(30) 	 NULL COMMENT 'Zum Beispiel: RPM, NPM, JAR, JMOD',
	CONSTRAINT `PK_Packages` PRIMARY KEY (`ID` ASC)
)
COMMENT='Packete werden ueber eine CI Pipeline erzeugt und in Artifactory gespeichert.'

;

CREATE TABLE `RELEASE`
(
	`ID` int not null IDENTITY,
	`NAME` VARCHAR(80) NOT NULL,
	`STATE` VARCHAR(30) 	 NULL COMMENT 'Status eines Release, z.b. Created, Assigned, Checked, Approved, Delivered, Live, Postponed, ...',
	`TYPE` VARCHAR(30) 	 NULL COMMENT 'Hotfix, Release',
	CONSTRAINT `PK_Releases` PRIMARY KEY (`ID` ASC)
)
COMMENT='Ein Release wird im Laufe eines PI in einem ART auf eine Umgebung gebracht.'

;

CREATE TABLE `RELEASE_PACKAGE`
(
	`ID` int not null IDENTITY,
	`PACKAGE_ID` DECIMAL(10,0) 	 NULL,
	`RELEASE_ID` DECIMAL(10,0) 	 NULL,
	`STATE` VARCHAR(30) 	 NULL COMMENT 'Status eines ReleasePackage, z.b.: Assigned, Deployed, Retired',
	CONSTRAINT `PK_ReleasePackages` PRIMARY KEY (`ID` ASC)
)
COMMENT='Diese Tabelle enthaellt die Beziehung zwischen Paketen und Release.'

;

/* Create Primary Keys, Indexes, Uniques, Checks */

ALTER TABLE `ENVIRONMENT` 
 ADD CONSTRAINT `UQ_SHORT` UNIQUE (`SHORT` ASC)
;

ALTER TABLE `RELEASE` 
 ADD CONSTRAINT `UQ_NAME` UNIQUE (`NAME` ASC)
;

/* Create Foreign Key Constraints */

ALTER TABLE `CHECK_RESULT` 
 ADD CONSTRAINT `FK_CHECK_RESULT_RELEASE`
	FOREIGN KEY (`RELEASE_ID`) REFERENCES `RELEASE` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `CHECK_RESULT` 
 ADD CONSTRAINT `FK_CHECKRESULTS_CHECKS`
	FOREIGN KEY (`CHECK_ID`) REFERENCES `CHECK` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `CHECK_RESULT` 
 ADD CONSTRAINT `FK_CHECKRESULTS_COMPONENTS`
	FOREIGN KEY (`COMPONENT_ID`) REFERENCES `COMPONENT` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `CHECK_RESULT` 
 ADD CONSTRAINT `FK_CheckResults_Deployments`
	FOREIGN KEY (`DEPLOYMENT_ID`) REFERENCES `DEPLOYMENT` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `COMPONENT` 
 ADD CONSTRAINT `FK_COMPONENT_COMPONENT`
	FOREIGN KEY (`PARENT_ID`) REFERENCES `COMPONENT` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `CONFIGURATION` 
 ADD CONSTRAINT `FK_CONFIGURATION_COMPONENT`
	FOREIGN KEY (`COMPONENT_ID`) REFERENCES `COMPONENT` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `CONFIGURATION` 
 ADD CONSTRAINT `FK_CONFIGURATION_CONFIGURATION`
	FOREIGN KEY (`PARENT_ID`) REFERENCES `CONFIGURATION` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `CONFIGURATION` 
 ADD CONSTRAINT `FK_CONFIGURATION_ENVIRONMENT`
	FOREIGN KEY (`ENVIRONMENT_ID`) REFERENCES `ENVIRONMENT` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `DEPENDENCY` 
 ADD CONSTRAINT `FK_DEPENDENCY_PACKAGE`
	FOREIGN KEY (`PACKAGE_ID`) REFERENCES `PACKAGE` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `DEPLOYMENT` 
 ADD CONSTRAINT `FK_Deployments_Environments`
	FOREIGN KEY (`ENVIRONMENT_ID`) REFERENCES `ENVIRONMENT` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `DEPLOYMENT` 
 ADD CONSTRAINT `FK_DEPLOYMENTS_RELEASES`
	FOREIGN KEY (`RELEASE_ID`) REFERENCES `RELEASE` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `EDIT` 
 ADD CONSTRAINT `FK_Edits_Editors`
	FOREIGN KEY (`ID`) REFERENCES `EDITOR` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `NOTE` 
 ADD CONSTRAINT `FK_NOTE_COMPONENT`
	FOREIGN KEY (`COMPONENT_ID`) REFERENCES `COMPONENT` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `NOTE` 
 ADD CONSTRAINT `FK_NOTE_RELEASE`
	FOREIGN KEY (`RELEASE_ID`) REFERENCES `RELEASE` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `NOTE_ENTRY` 
 ADD CONSTRAINT `FK_NOTE_ENTRY_NOTE`
	FOREIGN KEY (`NOTE_ID`) REFERENCES `NOTE` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `RELEASE_PACKAGE` 
 ADD CONSTRAINT `FK_RELEASE_PACKAGES_PACKAGES`
	FOREIGN KEY (`ID`) REFERENCES `PACKAGE` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `RELEASE_PACKAGE` 
 ADD CONSTRAINT `FK_RELEASE_PACKAGES_RELEASES`
	FOREIGN KEY (`ID`) REFERENCES `RELEASE` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `HYPERLINK` 
 ADD CONSTRAINT `FK_HYPERLINK_COMPONENT`
	FOREIGN KEY (`REF_ID`) REFERENCES `COMPONENT` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `HYPERLINK` 
 ADD CONSTRAINT `FK_HYPERLINK_ENVIRONMENT`
	FOREIGN KEY (`REF_ID`) REFERENCES `ENVIRONMENT` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `HYPERLINK` 
 ADD CONSTRAINT `FK_HYPERLINK_PACKAGE`
	FOREIGN KEY (`REF_ID`) REFERENCES `PACKAGE` (`ID`) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE `HYPERLINK` 
 ADD CONSTRAINT `FK_HYPERLINK_RELEASE`
	FOREIGN KEY (`REF_ID`) REFERENCES `RELEASE` (`ID`) ON DELETE No Action ON UPDATE No Action
;


-- ALTER TABLE `HYPERLINK` ADD CONSTRAINT `FK_HYPERLINK_RELEASE` FOREIGN KEY (`REF_ID`) REFERENCES `RELEASE` (`ID`) ON DELETE No Action ON UPDATE No Action;
-- ALTER TABLE `HYPERLINK` ADD CONSTRAINT `FK_HYPERLINK_COMPONENT` FOREIGN KEY (`REF_ID`) REFERENCES `COMPONENT` (`ID`) ON DELETE No Action ON UPDATE No Action;
-- ALTER TABLE `HYPERLINK` ADD CONSTRAINT `FK_HYPERLINK_PACKAGE` FOREIGN KEY (`REF_ID`) REFERENCES `PACKAGE` (`ID`) ON DELETE No Action ON UPDATE No Action;
-- ALTER TABLE `HYPERLINK` ADD CONSTRAINT `FK_HYPERLINK_DEPLOYMENT` FOREIGN KEY (`REF_ID`) REFERENCES `DEPLOYMENT` (`ID`) ON DELETE No Action ON UPDATE No Action;
-- ALTER TABLE `HYPERLINK` ADD CONSTRAINT `FK_HYPERLINK_ENVIRONMENT` FOREIGN KEY (`REF_ID`) REFERENCES `ENVIRONMENT` (`ID`) ON DELETE No Action ON UPDATE No Action;

SET FOREIGN_KEY_CHECKS=1 
;
