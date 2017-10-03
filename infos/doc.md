# Kurze Doku

Docu: EA ERM > EA DDL Export > Customize > Generate > StartBE > StartFE

Präsentieren:

[K]onfiguration- & [R]elease[M]anagment [A]utomatisierung

Karamdeep (-> Arbeiten und leuchten). Der Großonkel von Jenkins.

- KRMA: Eine Initiative mit 5 Kernzielen:
    1 ReleaseBuilder & Package Cockpit mittels Jenkins Orchestrierung
    2 KMDB & DevOps Repository u.a. für Applikations-, Service- & Systemkomponenten
    3 Stammdaten-Support für autom. Provisionierung, Zwei-Phasen Token Replacement & mehr
    4 Strategisches Dependency-, Configuration- & ReleaseNote-Management
    5 Tool Integration in einem neXt Lab DevOps Portal

- KRMA Building Blocks:
    Komponenten: ReleaseManager Web App, ERM Nodel <> KMDB H2/MySQL, KRMA Portal
    Schnittstellen: Jenkins, Jira, TMT, Zabbix, evt. Consul/Insight
    Vorgehen: Fullstack Forward Engineered MDA
    Delivery Models: Docker, JAR, plain Node- / Spring-Threads

- KRMA Stack:
    NodeJS, NPM, Angular, TypeScript, Material, PrimeNG, Swagger, Webpack
    Java 8, Maven, H2/MySQL, Spring, JPA, Docker (opt.)
    Sparx EA, Groovy, Python

- Aktueller Status:
    Datenmodel v0.9 mit Feedback aus RM, UM, KM, CI/CD, IQS erstellt
    MDA Flow angelegt und mehrfach durchlaufen
    Wireframe Prototyp erstellt und erstes Feedback eingearbeitet
    Stories für JIRA vorbereitet 
    RelaseManager App aufgeräumt und erstes Styling durchgeführt
    Package Übersichten für 0.5.3 und 0.5.6 erzeugt

- NeXt Steps:
    Jirafizierung aller Aufgaben (Epic / Feature vs. Tag-Management)
    ReleaseBuilder Big Buzzer: One Button Delivery on ITU
    Package Cockpit für Release Dokumentation
    Datenbewirtschaftung für Stammdaten läuft
    Dchnittstellen ausbauen
    KRMA Portal Beta
    Planung Token-Replacement
    Jenkins Jobs für Build, Test, Deployment, Start/Stop 