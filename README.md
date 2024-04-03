# Progetto di Codifica di Testi a.a. 22/23

Il progetto è stato realizzato da [Marco Petrucci](https://github.com/marco00petrucci) e [Irene Sofia Franco](https://github.com/isfranco) per il corso di **Codifica di testi** del professor [Angelo Mario Del Grosso](https://github.com/angelodel80/), nell'anno accademico 2022-2023, all'interno del CdL di **Informatica Umanistica**.
Sono state codificate cinque pagine dei "Diari" di Emanuele Artom, in particolare le giornate del 10 e 23 febbraio 1944.

## Comando per la validazione XML tramite Xerces

>java -cp "xerces/*" dom.Counter -v index.xml

## Comando per la generazione del documento HTML di output tramite il processore XSLT Saxon

>java -jar saxon/saxon-he-10.3.jar -s:index.xml -xsl:index.xsl -o:out.html
