<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml">
  <xsl:output method="html" encoding="UTF-8" omit-xml-declaration="yes" indent="yes" />
  <xsl:template match="/">

    <html lang="it">
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>
          <xsl:value-of select="//tei:titleStmt/tei:title[@type='main']" /> - <xsl:value-of select="//tei:titleStmt/tei:title[@type='sub']" />
        </title>
        <link href="style.css" rel="stylesheet" type="text/css" />
        <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/6957/6957020.png" />
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.5.1/css/all.css" />
        <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
      </head>

      <body>

        <header>
          <i class="fa-solid fa-bars fa-2x" id="hamburger"> MENU</i>
          <ul id="navbar">
            <li>
              <a href="#" title="Torna alla home">
                <i class="fa-solid fa-home"></i>
              </a>
            </li>
            <li>
              <a href="#descrizione" title="Leggi la descrizione">Descrizione</a>
            </li>
            <li id="dropdown">
              <a href="#" title="Scegli la giornata desiderata">Giornate <i class="fa-solid fa-angle-down"></i></a>
              <div>
                <a href="#10_feb">10 febbraio 1944</a>
                <a href="#23_feb">23 febbraio 1944</a>
              </div>
            </li>
            <li>
              <a href="#approfondimenti" title="Leggi gli approfondimenti">Approfondimenti</a>
            </li>
            <li>
              <a href="#bibliografia" title="Leggi la bibliografia">Bibliografia</a>
            </li>
            <li>
              <a href="#riferimenti" title="Leggi i riferimenti del progetto">Riferimenti</a>
            </li>
          </ul>
        </header>

        <section id="title">
          <img src="https://upload.wikimedia.org/wikipedia/it/1/1b/Emanuele_Artom.jpg" alt="author_img" title="Emanuele Artom" />
          <div>
            <h1>
              <xsl:value-of select="//tei:titleStmt/tei:title[@type='main']" />
            </h1>
            <h3>
              <i>
                <xsl:value-of select="//tei:titleStmt/tei:title[@type='sub']" />
              </i>
            </h3>
          </div>
        </section>

        <main>
          <section id="descrizione">
            <div class="row">
              <xsl:apply-templates select="//tei:sourceDesc" />
            </div>

            <div class="row">
              <xsl:apply-templates select="//tei:physDesc" />
              <div>
                <img src="img/scheda_CDEC.png" alt="Scheda CDEC" width="90%" title="Scheda del C.D.E.C. intestata al partigiano Emanuele Artom. La scheda è stata compilata dalla madre"/>
              </div>
            </div>
          </section>

          <section id="giornate">
            <h2 class="styled">10 febbraio 1944</h2>
            <section class="row" id="10_feb">
              <figure class="slideshow-container">
                <!-- Stampa solo le prime tre pagine -->
                <xsl:apply-templates select="(//tei:surface)[position() &lt;= 3]" />
              </figure>

              <div id="pagine_10Feb">
                <xsl:for-each select="//tei:ab[position() &lt;= 3]">
                  <div id="pagina{position() + 154}" class="pagine">
                    <h1>PAGINA <xsl:value-of select="@n" /></h1>
                    <xsl:apply-templates select="." />
                  </div>
                </xsl:for-each>
              </div>

              <a class="prev">
                <i class="fa-solid fa-angle-left"></i>
              </a>
              <a class="next">
                <i class="fa-solid fa-angle-right"></i>
              </a>
            </section>

            <h2 class="styled">23 febbraio 1944</h2>
            <section class="row" id="23_feb">
              <figure class="slideshow-container" >
                <!-- Stampa solo le ultime due pagine -->
                <xsl:apply-templates select="//tei:surface[position() >= last() - 1]" />
              </figure>

              <div id="pagine_23Feb">
                <xsl:for-each select="//tei:ab[position() >= last() - 1]">
                  <div id="pagina{position() + 172}" class="pagine">
                    <h1>PAGINA <xsl:value-of select="@n" /></h1>
                    <xsl:apply-templates select="." />
                  </div>
                </xsl:for-each>
              </div>

              <a class="prev" title="Vai alla pagina precedente">
                <i class="fa-solid fa-angle-left"></i>
              </a>
              <a class="next" title="Vai alla pagina successiva">
                <i class="fa-solid fa-angle-right"></i>
              </a>
            </section>
          </section>

          <button id="mostra_pulsanti" type="button" title="Mostra/Nascondi Navigazione">
            <i class="fa-solid fa-ellipsis-vertical"></i>
          </button>
          <nav id="pulsanti_legenda">
            <button id="cancellature" type="button">Cancellature</button>
            <button id="correzioni" type="button">Correzioni</button>
            <button id="abbreviazioni" type="button">Abbreviazioni</button>
            <button id="normalizzazioni" type="button">Normalizzazioni</button>
            <button id="aggiunte" type="button">Aggiunte</button>
            <button id="persone" type="button">Persone</button>
            <button id="luoghi" type="button">Luoghi</button>
            <button id="organizzazioni" type="button">Organizzazioni</button>
          </nav>
          
          <!-- Approfondimenti -->
          <h2 class="styled">Approfondimenti</h2>
          <section id="approfondimenti">
            <div id="listPerson" class="list_flex">
              <xsl:apply-templates select="//tei:back/tei:listPerson" />
              <div class="note_persona">
                <xsl:apply-templates select="//tei:person/tei:note" />
              </div>
            </div>

            <div id="listPlace" class="list_flex">
              <xsl:apply-templates select="//tei:back/tei:listPlace" />
              <div class="note_luogo">
                <xsl:apply-templates select="//tei:place/tei:desc" />
              </div>
            </div>

            <div id="listOrg" class="list_flex">
              <xsl:apply-templates select="//tei:back/tei:listOrg" />
              <div class="note_organizzazione">
                <xsl:apply-templates select="//tei:org/tei:desc" />
              </div>
            </div>
          </section>

          <!-- Bibliografia -->
          <section id="bibliografia">
            <xsl:apply-templates select="//tei:listBibl" />
          </section>

        </main>

        <footer id="riferimenti">
          <xsl:apply-templates select="//tei:editionStmt" />
        </footer>

        <a id="scroll_top" onclick="window.scroll(0, 0)">
          <i class="fa fa-arrow-circle-up fa-3x"></i>
        </a>

      </body>
      <script src="script.js"></script>
    </html>
  </xsl:template>

  <!-- Caratteristiche e storia del diario -->
  <xsl:template match="tei:sourceDesc">
    <div>
      <h2 class="styled">Caratteristiche e storia del diario</h2>
      <div>
        <b>Storia del diario:</b>
        <p>
          <xsl:value-of select="//tei:history/tei:origin" />
        </p>
      </div>
      <div>
        <b>Acquisizione:</b>
        <p>
          <xsl:value-of select="//tei:history/tei:acquisition" />
        </p>
      </div>
      <div>
        <b>Luogo di conservazione:</b>
        <p> È possibile consultare il manoscritto codificato presso l'archivio online dell'<xsl:value-of select="//tei:publicationStmt/tei:publisher/tei:orgName" />.</p>
      </div>
      <div>
        <b>Titolo:</b>
        <p>
          <xsl:text> </xsl:text>
          <xsl:value-of select="//tei:bibl/tei:title[@type='main']" />
        </p>
      </div>
      <div>
        <b>Autore:</b>
        <p>
          <xsl:text> </xsl:text>
          <xsl:value-of select="//tei:titleStmt//tei:author" />
        </p>
      </div>
      <div>
        <b>Data:</b>
        <p>
          <xsl:text> </xsl:text>
          <xsl:value-of select="//tei:msDesc/tei:msContents/tei:msItem/tei:docDate/tei:date" />
        </p>
      </div>
      <div>
        <b>Luogo:</b>
        <p>
          <xsl:text> </xsl:text>
          <xsl:value-of select="//tei:msDesc/tei:msIdentifier/tei:settlement" />, <xsl:value-of select="//tei:msDesc/tei:msIdentifier/tei:country" />
        </p>
      </div>
      <div>
        <b>Conservazione:</b>
        <p>
          <xsl:text> </xsl:text>
          <xsl:value-of select="//tei:msDesc/tei:msIdentifier/tei:institution//tei:expan"/>, <xsl:value-of select="//tei:msDesc/tei:msIdentifier/tei:collection" />
        </p>
      </div>
      <div>
        <b>Codice documento:</b>
        <p>
          <xsl:text> </xsl:text>
          <xsl:value-of select="//tei:msDesc/tei:msIdentifier/tei:idno" />
        </p>
      </div>
      <div>
        <b>Fruizione:</b>
        <p>
          <xsl:text> </xsl:text>
          <xsl:value-of select="//tei:publicationStmt/tei:availability" />
        </p>
      </div>
      <div>
        <b>Lingua:</b>
        <p>
          <xsl:text> </xsl:text>
          <xsl:value-of select="//tei:textLang" />
        </p>
      </div>
    </div>
  </xsl:template>

  <!-- Descrizione fisica -->
  <xsl:template match="tei:physDesc">
    <div>
      <h2 class="styled">Descrizione fisica</h2>
      <div>
        <b>Supporto:</b>
        <p>
          <xsl:text> </xsl:text>
          <xsl:value-of select="//tei:objectDesc/tei:supportDesc/tei:support" />
        </p>
      </div>
      <div>
        <b>Numero di fogli:</b>
        <p>
          <xsl:value-of select="//tei:objectDesc/tei:supportDesc//tei:measure" />
        </p>
      </div>
      <div>
        <b>Caratteri:</b>
        <p>
          <xsl:text> </xsl:text>
          <xsl:value-of select="//tei:typeDesc" />
        </p>
      </div>
      <div>
        <b>Lunghezza:</b>
        <p>
          <xsl:value-of select="//tei:layoutDesc" />
        </p>
      </div>
      <div>
        <b>Scrittura:</b>
        <p>
          <xsl:value-of select="//tei:handDesc" />
        </p>
      </div>
      <div>
        <b>Condizioni:</b>
        <p>
          <xsl:value-of select="//tei:objectDesc/tei:supportDesc/tei:condition" />
        </p>
      </div>
    </div>
  </xsl:template>

  <!-- Inizio riga -->
  <xsl:template match="tei:lb">
    <xsl:if test="@n != 1">
      <br />
    </xsl:if>
    <xsl:element name="span">
      <xsl:attribute name="id">
        <xsl:value-of select="@facs" />
      </xsl:attribute>
      <xsl:attribute name="class">numeroRiga</xsl:attribute>
      <xsl:value-of select="@n" />
    </xsl:element>
  </xsl:template>
  
  <!-- Immagini del diario -->
  <xsl:template match="tei:surface">
    <xsl:element name="img">
      <xsl:attribute name="class">imgDiario</xsl:attribute>
      <xsl:attribute name="title">Immagine pagina <xsl:value-of select="@xml:id" /></xsl:attribute>
      <xsl:attribute name="alt">Immagine pagina <xsl:value-of select="@xml:id" /></xsl:attribute>
      <xsl:attribute name="src">
        <xsl:apply-templates select="tei:graphic/@url" />
      </xsl:attribute>
      <xsl:attribute name="usemap">#<xsl:value-of select="@xml:id" /></xsl:attribute>
    </xsl:element>
    <xsl:element name="map">
      <xsl:attribute name="name">
        <xsl:value-of select="@xml:id" />
      </xsl:attribute>
      <xsl:for-each select="tei:zone">
        <xsl:element name="area">
          <xsl:attribute name="id">
            <xsl:value-of select="@xml:id" />
          </xsl:attribute>
          <xsl:attribute name="class">areaRiga</xsl:attribute>
          <xsl:attribute name="coords">
            <xsl:value-of select="@points" />
          </xsl:attribute>
          <xsl:attribute name="shape">poly</xsl:attribute>
        </xsl:element>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <!-- Cancellature -->
  <xsl:template match="tei:del">
    <span class="del" hidden="hidden">
      <xsl:apply-templates />
    </span>
  </xsl:template>

  <!-- Correzioni - Corretti -->
  <xsl:template match="tei:corr">
    <span class="corr">
      <xsl:value-of select="." />
    </span>
  </xsl:template>

  <!-- Correzioni - Errori -->
  <xsl:template match="tei:sic">
    <span class="sic" hidden="hidden">
      <xsl:value-of select="." />
    </span>
  </xsl:template>

  <!-- Abbreviazioni - Forme abbreviate -->
  <xsl:template match="tei:abbr">
    <span class="abbr">
      <xsl:value-of select="." />
    </span>
  </xsl:template>

  <!-- Abbreviazioni - Forme espanse -->
  <xsl:template match="tei:expan">
    <span class="expan" hidden="hidden">
      <xsl:value-of select="." />
    </span>
  </xsl:template>

  <!-- Normalizzazioni - Correzioni -->
  <xsl:template match="tei:reg">
    <span class="reg">
      <xsl:value-of select="." />
    </span>
  </xsl:template>

  <!-- Normalizzazioni - Originali -->
  <xsl:template match="tei:orig">
    <span class="orig" hidden="hidden">
      <xsl:value-of select="." />
    </span>
  </xsl:template>

  <!-- Aggiunte codificatore -->
  <xsl:template match="tei:supplied">
    <span class="supplied">
      <xsl:value-of select="." />
    </span>
  </xsl:template>

  <!-- Persone -->
  <xsl:template match="tei:persName">
    <span class="persName">
      <xsl:apply-templates />
    </span>
  </xsl:template>

  <!-- Luoghi -->
  <xsl:template match="tei:placeName">
    <span class="placeName">
      <xsl:apply-templates />
    </span>
  </xsl:template>
  
  <!-- Organizzazioni -->
  <xsl:template match="tei:orgName">
    <span class="orgName">
      <xsl:apply-templates />
    </span>
  </xsl:template>
  
  <!-- APPROFONDIMENTI -->
  <!-- Persone -->
  <xsl:template match="tei:listPerson">
    <h2>Persone</h2>
    <xsl:element name="ul">

      <!-- Stampa tutte le persone tranne studenti e professori -->
      <xsl:for-each select="tei:person[not(@xml:id = 'AMDG' or @xml:id = 'MP' or @xml:id = 'ISF')]">
        <xsl:element name="li">
          <span class="persona">
            <b>
              <xsl:value-of select="tei:persName/tei:forename" />
              <xsl:text> </xsl:text>
              <xsl:value-of select="tei:persName/tei:surname" />
            </b>

            <!-- Se non è presente nome e cognome stampa solo il nome aggiuntivo -->
            <xsl:if test="not(tei:persName/tei:forename) and not(tei:persName/tei:surname)">
              <b><xsl:value-of select="tei:persName/tei:addName" /></b>
            </xsl:if>

            <!-- Se è presente il nome e l'addName stampa l'addName fra parentesi -->
            <xsl:if test="tei:persName/tei:forename and tei:persName/tei:addName">
              (<xsl:value-of select="tei:persName/tei:addName" />)
            </xsl:if>

            <i class="fa-solid fa-angle-down"></i>
          </span>
        </xsl:element>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <!-- Note persone -->
  <xsl:template match="//tei:person/tei:note">
    <span class="note_p">
      <xsl:apply-templates />
    </span>
  </xsl:template>

  <!-- Luoghi -->
  <xsl:template match="tei:listPlace">
    <h2>Luoghi</h2>
    <xsl:element name="ul">
      <xsl:for-each select="tei:place">
        <xsl:element name="li">
          <span class="luogo">
            <b><xsl:value-of select="tei:placeName" /></b>,
            <xsl:text> </xsl:text>
            <xsl:value-of select="tei:country" />
            <i class="fa-solid fa-angle-down"></i>
          </span>
        </xsl:element>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <!-- Note luogo -->
  <xsl:template match="//tei:place/tei:desc">
    <span class="note_l">
      <xsl:apply-templates />
    </span>
  </xsl:template>

  <!-- Organizzazioni -->
  <xsl:template match="tei:listOrg">
    <h2>Organizzazioni</h2>
    <xsl:element name="ul">
      <xsl:for-each select="tei:org">
        <xsl:element name="li">
          <span class="organizzazione">
            <b><xsl:value-of select="tei:orgName" /></b>
            <i class="fa-solid fa-angle-down"></i>
          </span>
        </xsl:element>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <!-- Note organizzazione -->
  <xsl:template match="//tei:org/tei:desc">
    <span class="note_o">
      <xsl:apply-templates />
    </span>
  </xsl:template>


  <!-- Bibliografia -->
  <xsl:template match="tei:listBibl">
    <h2>Bibliografia</h2>
    <xsl:element name="ul">
      <xsl:for-each select="//tei:listBibl/tei:bibl">
        <xsl:element name="li">
          <b>
            <xsl:value-of select="tei:title[@type='full']" />
          </b>
            <xsl:text> </xsl:text>
            <xsl:value-of select="tei:title[@type='sub']" />
            <xsl:text>, </xsl:text>
            <xsl:for-each select="tei:author/tei:persName">
              <i>
                <xsl:value-of select="tei:forename" />
                <xsl:text> </xsl:text>
                <xsl:value-of select="tei:surname" />
              </i>
              <xsl:text>, </xsl:text>
            </xsl:for-each>
            <xsl:for-each select="tei:editor/tei:persName">
              <i>
                <xsl:value-of select="tei:forename" />
                <xsl:text> </xsl:text>
                <xsl:value-of select="tei:surname" />
              </i>
              <xsl:text>, </xsl:text>
            </xsl:for-each>
            <xsl:for-each select="tei:pubPlace/tei:placeName">
              <xsl:value-of select="." />,
            </xsl:for-each>
            <xsl:value-of select="tei:publisher/tei:orgName" />
            <xsl:if test="tei:publisher/tei:orgName">
              <xsl:text>, </xsl:text>
            </xsl:if>
            <xsl:value-of select="tei:date" />
        </xsl:element>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <!-- Footer -->
  <xsl:template match="tei:editionStmt">
    <h2>Riferimenti</h2>
    <h3>
      <xsl:value-of select="tei:edition" />
    </h3>
    <xsl:for-each select="tei:respStmt">
      <div>
        <b>
          <xsl:value-of select="tei:resp" />
        </b>
        <xsl:for-each select="tei:name">
          <p>
            <xsl:text> </xsl:text>
            <xsl:choose>
              <xsl:when test="position() = last()">
                <xsl:value-of select="." />
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="concat(., ' e ')" />
              </xsl:otherwise>
            </xsl:choose>
          </p>
        </xsl:for-each>
      </div>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>