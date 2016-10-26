
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Grafiniai įrenginiai. Vektorinė ir rastrinė grafika.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2015-03-07 | 2015-04-09
#


# TURINYS -------------------------------

#
#   1. Trumpai apie grafinius įrenginius:
#      * Devices
#
#   2. Grafiko braižymas kompiuterio ekrane:
#      * windows
#      * x11
#      * X11
#      * win.graph
#      * win.metafile
#      * win.print
#
#   3. Grafiko išsaugojimas į vektorinės grafikos failą:
#      * pdf
#      * pdfFonts
#      * pdf.options
#      * postscript
#
#   4. Grafiko išsaugojimas į rastrinės grafikos failą:
#      * png
#      * bmp
#      * jpeg
#      * tiff
#


# PASTABOS ------------------------------

#
# Sugalvoti uždavinių.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuviška lokalė. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# Ištrinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# TRUMPAI APIE GRAFINIUS ĮRENGINIUS       #
# --------------------------------------- #

# Grafiko atvaizdavimui naudojamas grafinis įrenginys. Tai gali būti kompiuterio 
# ekranas, spausdintuvas arba kokio nors tipo grafinis failas, pvz., pdf, png ir 
# dar keletas kitų. Visų R kalboje naudojamų grafinių įrenginių sąrašas:

?Devices

# Jei nenurodyta kitaip, aukšto lygio grafinės f-jos grafiką atvaizduoja ekrane,
# o jį atitinkančio įrenginio pavadinimas priklauso nuo operacinės sistemos:
# 
#    windows -- MS Windows
#        X11 -- Unix arba Linux
#     quartz -- OS X


# Naudojant kitokius grafinius įrenginius, grafiką galima išsaugoti į failą. Tai 
# gali būti rastrinės arba vektorinės grafikos tipo failai:
#           ---------      ----------
#           bmp            pdf   
#           gif            postscript
#           jpeg           svg
#           tiff
#           png


# --------------------------------------- #
# GRAFIKO BRAIŽYMAS KOMPIUTERIO EKRANE    #
# --------------------------------------- #

# MS Windows operacinėje sistemoje grafinį langą kompiuterio ekrane atidaro f-ja
# windows. Pagrindiniai jos parametrai yra tokie:
#
#      width -- grafinio lango plotis coliais,
#     height -- grafinio lango aukštis coliais,
#    rescale -- taisyklė, pagal kurią nustatomas grafiko mastelis,
#  pointsize -- taško dydis, 
#         bg -- grafiko fono spalva,
#     canvas -- grafinio lango pagrindo spalva,
#       xpos -- pradinės lango pozicijos ekrane koordinatė x,
#       ypos -- pradinės lango pozicijos ekrane koordinatė y,
#      title -- grafinio lango pavadinimas,
#     family -- šrifto šeima,
#  antialias -- šrifto glodinimo metodas.


# Jeigu nenurodomas joks parametras, funkcija windows atidaro 7 x 7 colių dydžio
# standartinį grafinį langą. Tuo galima įsitikinti patikrinus grafinio parametro
# din reikšmę.

windows()
par("din")

# Grafinio lango dydis nustatomas per parametrus width ir height. Pvz, sukursime
# 8 x 4 colių dydžio grafinį langą ir jame nubraižysime f-jos y = sin(x) grafiką
# intervale [-3pi, 3pi].

windows(8, 4)
plot(sin, -3*pi, 3*pi)


# Parametras rescale nurodo, kaip turi būti atnaujinamas grafikas, kai keičiamas
# lango, kuriame jis nubraižytas, dydis. Galimos parametro reikšmės:
#
#        "R" -- nurodo, kad grafiko dydis sutampa su lango dydžiu,
#      "fit" -- grafikas perbraižomas išlaikant kraštinių santykį,
#     fixed" -- nurodo, kad grafiko dydis yra fiksuotas.

# Standartinė parametro reikšmė - "R", todėl, keičiant grafinio lango dydį (pvz., 
# su pele), jame nubraižyto grafiko dydis taip pat keičiasi, grafikas užima visą
# langą. Jei parametrui priskiriama reikšmė "fit", tada grafikas išlaiko pradinį 
# kraštinių santykį, tačiau, priklausomai nuo grafinio lango dydžio, keičiasi jo
# šrifto dydis.

windows(rescale = "fit")
plot(sin, -pi, pi, main = "Grafinis langas su fiksuotu grafiko kraštinių santykiu")


# Parametras pointsize nustato taško dydį. Nuo jo priklauso teksto šrifto dydis.
# Standartinė parametro reikšmė 12. Pavyzdžiui, nubraižysime grafiką su 8 dydžio 
# šriftu.

windows(pointsize = 8)
plot(sin, -pi, pi, main = "Parametro pointsize reikšmė lygi 8")


# Šrifto, kuriuo rašomos grafiko ir ašių antraštės bei padalų pavadinimai, šeimą 
# nusako parametras family. Standartinė parametro reikšmė yra "", kiti variantai 
# tokie:
# 
#    "serif" -- lotyniškas šriftas, pvz., Times,
#     "sans" -- groteskinis šriftas, pvz., Aria, Helvetica,
#     "mono" -- pastovaus pločio šriftas, pvz., Courier.

# Pvz., nustatysime, kad naujai atidarytame grafiniame lange pagrindinis grafiko
# šriftas būtų iš "mono" šeimos.

windows(family = "mono")
plot(sin, -pi, pi)

# Galima priminti, kad grafike naudojamo šrifto šeima gali būti nustatoma ir per 
# grafinį parametrą family.

par(family = "mono")
plot(sin, -pi, pi)


# Parametras antialias nustato šriftų glodinimo metodą, nuo kurio priklauso kaip 
# jie atrodys ekrane. Pavyzdžiui, nubraižysime grafiką, kuriame surašyti mėnesių
# pavadinimai. Vienu atveju glodinimas nenaudojamas, kitu -- naudojamas.

windows(antialias = "none")
plot(0, 0, type = "n", main = "Šriftas nesuglodintas")
text(0, 0, paste(month.name, collapse = "\n"), cex = 2)

windows(antialias = "cleartype")
plot(0, 0, type = "n", main = "Šriftas suglodintas")
text(0, 0, paste(month.name, collapse = "\n"), cex = 2)


# Naujai atidarytam grafinim langui automatiškai priskiriamas eilės numeris, bet, 
# naudojant parametrą title, jam galima suteikti bet kokį pavadinimą. 

windows(title = "Trigonometrinės funkcijos grafikas")
plot(sin, -pi, pi)

# Parametrai xpos, ypos nustato naujo grafinio lango vietą ekrane. Taškas (0, 0) 
# atitinka viršutinį kairės pusės kampą. Standartinė lango pozicija - viršutinis 
# dešinės pusės kampas, kurį atitinka taškas (-25, 0). Neigiamos reikšmės nurodo, 
# kad langas atitraukiamas nuo dešinio ir apatinio ekrano krašto. 

windows(xpos = -10, ypos = -25)


# Parametrai bg ir canvas nustato grafiko fono ir grafinio lango pagrindo spalvą.
# Pagrindas matomas tik tada, jei fono spalva yra permatoma. Kadangi standartinė 
# parametro bg reikšmė yra "transparent", grafikuose matome baltą grafinio lango
# pagrindo spalvą. 

# Pavyzdžiui, nubraižysime grafikus su skirtingomis fono bei pagrindo spalvomis.

windows(bg = "skyblue")
plot(sin, -pi, pi)

windows(canvas = "red")
plot(sin, -pi, pi)

# Jeigu pagrindo ir fono spalvas nurodome kartu, grafike bus matoma fono spalva.
# Čia fono spalvą "skyblue" nurodome RGB kodu.

windows(canvas = "red", bg = rgb(0.53, 0.81, 0.92))
plot(sin, -pi, pi)

# Jeigu fono spalva permatoma (tai reguliuojama parametru alpha), grafike matosi 
# ir grafinio lango pagrindo spalva.

windows(canvas = "red", bg = rgb(0.53, 0.81, 0.92, alpha = 0.5))
plot(sin, -pi, pi)


# Funkcijos windows, win.graph, x11 ir X11 yra tos pačios funkcijos realizacijos.
# Jos reikalingos dėl suderinamumo su kitomis operacinėmis sistemomis, nes Linux
# bei Unix sistemoje tas pats įrenginys vadinasi X11. Funkcijos x11 bei X11 turi 
# mažiau parametrų, tačiau jie, galima sakyti, yra esminiai:
#
#      width -- grafinio lango plotis coliais,
#     height -- grafinio lango aukštis coliais,
#  pointsize -- taško dydis, 
#         bg -- grafiko fono spalva,
#       xpos -- pradinės lango pozicijos ekrane koordinatė x,
#       ypos -- pradinės lango pozicijos ekrane koordinatė y,
#      title -- grafinio lango pavadinimas.

x11(8, 6, pointsize = 11, bg = "skyblue", title = "x11 langas")
plot(sin, -pi, pi)


# MS Windows operacinėje sistemoje už grafinių objektų atvaizdavimą skirtinguose 
# grafiniuose įrenginiuose, tokiuose kaip monitorius ar spausdintuvas, atsakinga 
# GDI (Graphics Device Interface). Tai leidžia gauti praktiškai tokį patį vaizdą 
# monitoriuje, faile arba spausdintuve. Tam R gali būti naudojamos šios f-jos:
#
#        win.graph
#        win.metafile 
#        win.print

# Pavyzdžiui, naudodami šias funkcijas, tą patį grafiką atvaizduosime ekrane, jį
# išsaugosime į Windows Metafile (wmf) tipo failą ir nukreipsime į spausdintuvą.

win.graph()
plot(sin, -pi, pi, main = "Grafikas ekrane")
dev.off()

win.metafile(file = "grafikas.wmf")
plot(sin, -pi, pi, main = "Grafikas faile")
dev.off()

win.print(printer = "")
plot(sin, -pi, pi, main = "Grafikas spausdinimui")
dev.off()


# NAUDINGA ------------------------------

# Taškų tankį colyje (pixels per inch, PPI) nustato parametrai xpinch ir ypinch. 
# Standartinės šių parametrų reikšmės priklauso nuo ekrano skiriamosios gebos ir 
# apskaičiuojamos automatiškai. Pavyzdžiui, jei PPI = 96, tai 7 x 7 dydžio lange
# nubraižytas grafikas yra 672 x 672 taškų dydžio. Spaudoje naudojamas PPI = 300.

# Jeigu parametrų xpinch ir ypinch reikšmės skiriasi, grafinis langas ekrane yra
# ištempiamas. Pavyzdžiui, tegu parametro xpinch reikšmė bus dvigubai didesnė už
# ypinch reikšmę. Ekrane toks grafikas ištemptas horizontaliai, tačiau formaliai
# jis išliko kvadratinis. Jeigu spausdinant būtų atsižvelgiama į skirtingą taškų 
# tankį, grafikas ant popieriaus taip pat būtų kvadratinis. Tai rodo ir grafinio 
# parametro din reikšmė. 

windows(7, 7, xpinch = 160, ypinch = 80)
plot(sin, -pi, pi, main = "Kvadratinis grafikas")
par("din")

# Pavyzdžiui, jei grafikas turi būti 900 x 600 dydžio, tai, žinant, kad PPI = 96,
# grafinio lango dydis turi būti 900/96 = 9.375 pločio ir 6.25 aukščio (coliais).

windows(width = 9.38, height = 6.25, xpinch = 96, ypinch = 96)
plot(sin, -pi, pi, main = "900 x 600 taškų dydžio grafikas")

# Jei standartiniame 7 x 7 colių grafiniame lange nubraižytas grafikas turi būti
# 700 x 700 taškų dydžio, tai PPI turi būti 100.

windows(7, 7, xpinch = 100, ypinch = 100)
plot(sin, -pi, pi, main = "700 x 700 taškų dydžio grafikas")


# UŽDUOTIS ------------------------------ 

# 1. 
#    
# 2. 
#    


# --------------------------------------- #
# VEKTORINĖ GRAFIKA                       #
# --------------------------------------- #

# Šiuo metu labiausiai paplitę du nuo operacinės sistemos ir programinės įrangos
# nepriklausantys elektroninių dokumentų formatai:
#
#         ps -- PostScript,
#        pdf -- Portable Document Format.
#
# PostScript ir PDF tipo dokumentai plačiai naudojami elektroninėje leidyboje ir
# spaudoje, kur reikalinga aukšta poligrafinė teksto ir grafikos kokybė.

# PostScript yra aukšto lygio programavimo kalba, kuri skirta teksto ir grafikos
# tuščiame puslapyje aprašymui. Galima sakyti, kad PostScript dokumentas tai yra 
# tokia programa, kuri spausdintuvui nurodo, kaip atvaizduoti dokumente aprašytą
# puslapį. Paprastai dokumentą su PostScript programa generuoja kitos programos. 
# Norint pažiūrėti, kaip atrodys PostScript dokumentas, reikia turėti PostScript
# kalbos interpretatorių. Pvz., tam galima naudoti programą Ghostscript.

# PDF yra PostScript kalbos pagrindu sukurtas elektroninio dokumento formatas. Į
# tokį failą galima įtraukti tekstą kartu su jam reikalingais šriftais, rastrinę
# ir vektorinę grafiką. Dokumentą PDF formatu gali išsaugoti grafiniai ar teksto
# redaktoriai. PDF dokumentui peržiūrėti reikia specialios programos, pavyzdžiui, 
# SumatraPDF.


# Grafikų išsaugojimui PostScript ar PDF formatu naudojamos f-jos postscript bei 
# pdf. Čia plačiau aptarsime tik funkciją pdf, kurios pagrindiniai parametrai ir
# jų standartinės reikšmės yra tokie patys kaip ir funkcijos windows, tačiau kai 
# kurie iš jų yra specifiniai PDF dokumentams:
#
#       file -- pdf failo pavadinimas,
#      width -- grafinio lango plotis coliais,
#     height -- grafinio lango aukštis coliais,
#  pointsize -- taško dydis,
#         bg -- grafiko fono spalva,
#         fg -- grafiko taškų ir linijų spalva,
#      title -- į pdf failą įrašomas grafiko pavadinimas,
#     family -- grafike naudojamo šrifto šeima,
#   encoding -- šrifto koduotė,
#    onefile -- nurodo, ar faile galima braižyti kelis grafikus,
#      paper -- popieriaus lapo dydis,
# pagecentre -- nurodo, ar grafiką atvaizduoti puslapio centre.


# Paprasčiausiu atveju užtenka nurodyti pdf dokumento, į kurį bus atvaizduojamas 
# grafikas, vardą. Jeigu prieš tai, naudojant funkciją setwd, nurodomas darbinis 
# katalogas, failo vardas gali būti trumpas, priešingu atveju -- reikia nurodyti 
# pilną kelią iki failo. Nubraižius grafiką, rašymas į pdf failą nutraukiamas, o
# grafinis įrenginys uždaromas. Tam naudojama speciali funkcija dev.off().

# Pavyzdžiui, nubraižysime paprastą funkcijos y = sin(x) grafiką ir įrašysime jį 
# į failą "grafikas.pdf", kuris bus sukurtas darbiniame kataloge. Pasitikslinti,
# kuris katalogas yra darbinis, galima naudojant funkciją getwd().

pdf(file = "grafikas.pdf")
  plot(sin, -pi, pi, main = "Funkcijos y = sin(x) grafikas")
dev.off()


# Labai dažnai grafikui nubraižyti reikia keletos grafinių funkcijų ir papildomų
# skaičiavimų. Tokiu atveju visos grafinės f-jos rašomos tarp pdf() ir dev.off().

pdf(file = "grafikas.pdf")

  # nubraižome funkcijos grafiką be Ox ašies ir rėmelio
  plot(sin, -pi, pi, las = 1, xaxt = "n", frame = FALSE)

  # apskaičiuojame Ox ašies padalas ir sudarome jų pavadinimus
  Ox <- seq(-pi, pi, by = pi/2)
  Lx <- expression(-pi, -pi/2, 0, pi/2, pi)

  # ant grafiko uždedame Ox ašį
  axis(1, at = Ox, labels = Lx)

  # uždedame prie Ox ašies padalų priderintą tinklelį
  abline(v = Ox, h = -2:2/2, lty = "dotted", col = "gray80")

  # užrašome pagrindinę grafiko antraštę
  title(main = "Funkcijos y = sin(x) grafikas")

dev.off()


# Grafiko dydį nustato parametrai width ir height. Jeigu nenurodyta kitaip, tada
# standartinio grafiko dydis yra 7 x 7 colio. Parametras pointsize nustato taško 
# dydį, nuo kurio priklauso teksto šrifto dydis. Pvz., nubraižysime 6 x 4 dydžio
# grafiką su 8 dydžio šriftu.

pdf(file = "grafikas.pdf", width = 6, height = 4, pointsize = 8)
  plot(Nile)
dev.off()


# Puslapio, kuriame atvaizduojamas grafikas, dydis priklauso nuo parametro paper. 
# Standartinė jo reikšmė "special" nurodo, kad puslapio dydis sutampa su grafiko
# dydžiu, tačiau puslapis gali turėti savo formatą. Kitos parametro reikšmės yra 
# tokios:
# 
#       "a4" -- 8.27 x 11.7 in (210.0 x 297.0 mm),
#   "letter" -- 8.50 x 11.0 in (215.9 x 279.4 mm),
#    "legal" -- 8.50 x 14.0 in (215.9 x 355.6 mm),
#
#      "a4r" -- pasuktas A4 formatas,
#      "USr" -- pasuktas Legal formatas.

# Standartiškai grafikas vaizduojamas puslapio centre. Tai priklauso nuo loginio 
# parametro pagecentre. Jam priskyrus reikšmę FALSE, grafikas bus atvaizduojamas
# viename puslapio kampe.

# Pavyzdžiui, ant pasukto A4 formato puslapio nubraižysime iš karto du grafikus.
# Kadangi standartinė parametro pagecenter reikšmė lygi TRUE, grafikas braižomas 
# puslapio centre.

pdf(file = "grafikas.pdf", width = 11, height = 6, paper = "a4r")
  par(mfrow = c(1, 2))
  plot(Nile, frame = FALSE)
  hist(Nile, main = "")
dev.off()


# PDF dokumente naudojamo šrifto šeimą nustato parametras family. Problema tame,
# kad standartinės reikšmės "serif", "sans" arba "mono" PDF dokumentuose reiškia
# tam tikrą konkretų šriftą, pavyzdžiui:
#
#    "serif" -- "Times"
#     "sans" -- "Helvetica"
#     "mono" -- "Courier"

# Ryšį tarp standartinėje R grafikoje naudojamos šriftų šeimos ir konkretaus PDF 
# dokumento šrifto nusako funkcija pdfFonts.

pdfFonts("serif")
pdfFonts("sans")
pdfFonts("mono")

# Be to, PDF dokumente galima naudoti ir kitus šriftus. Pavyzdžiui, gausime visą 
# jų sąrašą.

names(pdfFonts())


# Tai, kokiu ženklu bus atvaizduota raidė (tiksliau - raidę atitinkantis kodas), 
# priklauso nuo koduotės. Lotyniškos abėcėlės pagrindu sudaryta ASCII koduotė iš
# viso koduoja 256 simbolius. Kodai nuo 0 iki 127 koduoja skaitmenis, didžiąsias 
# ir mažąsias lotyniškos abėcėlės raides, skyrybos ženklus ir specialius valdymo 
# simbolius. Likę 128 kodai naudojami papildomiems simboliams, tarp jų gali būti 
# ir nacionalinių abėcėlių simboliai. Priklausomai nuo to, kokiais simboliais ši
# lentelė papildoma, gaunama viena ar kita koduotė.

# Vakarų Europos kalboms, kurios naudoja lotynišką abėcėlę, naudojama ISO 8859-1 
# koduotė, kuri dar vadinama Latin-1. MS Windows operacinėje sistemoje ją beveik 
# visiškai atitinka Windows-1252 (CP-1252) koduotė. Savo koduotes turi Centrinės
# ir Rytų Europos kalbos, baltų kalbos, taip pat graikų kalba bei kalbos, kurios 
# savo raštui naudoja kirilicą.

# PDF dokumento koduotė priklauso nuo parametro encoding reikšmės. Paprastai yra
# naudojamos tokios koduotės:
#
#  "WinAnsi" -- Western European,
#   "CP1250" -- Central European,
#   "CP1251" -- Cyrillic,
#   "CP1253" -- Greek,
#   "CP1257" -- Baltic.

# Standartinė parametro reikšmė "default" gali reikšti bet kurią iš šių koduočių.
# Tai priklauso nuo to, kokia koduotė naudojama R aplinkoje, bet dažniausiai tai
# yra "WinAnsi" (kuri iš tikro turi būti vadinama Windows-1252).

# Pavyzdžiui, tą patį grafiką atvaizduosime į PDF failą naudodami dvi skirtingas 
# koduotes. Galima pastebėti, kad į Windows-1252 koduotę iš 9 lietuviškų raidžių
# patenka tik š ir ž, o likusios atvaizduojamos nekorektiškai.

pdf(file = "grafikas.pdf", encoding = "WinAnsi")
  plot(0, 0, type = "n", frame = FALSE, main = "WinAnsi, Western European")
  text(0, 0, "Lietuviškos raidės\n ąęėįųūčšž\n arba matosi, arba ne.", cex = 3)
dev.off()

pdf(file = "grafikas.pdf", encoding = "CP1257")
  plot(0, 0, type = "n", frame = FALSE, main = "CP-1257, Baltic")
  text(0, 0, "Lietuviškos raidės\n ąęėįųūčšž\n arba matosi, arba ne.", cex = 3)
dev.off()


# NAUDINGA ------------------------------

# Peržiūrėti PDF dokumento parametrų reikšmes galima naudojant f-ją pdf.options.

pdf.options()

# Šią funkciją galima panaudoti tuo atveju, kai reikia nubraižyti iš karto kelis 
# grafikus su vienodomis PDF parametrų reikšmėmis. Nustačius visiems dokumentams
# bendrų parametrų reikšmes, funkcijai pdf užtenka nurodyti tik failo vardą.

pdf.options(width = 6, height = 4, pointsize = 8, encoding = "CP1257")

pdf(file = "grafikas-1.pdf")
  plot(Nile)
dev.off()

pdf(file = "grafikas-2.pdf")
  hist(Nile)
dev.off()

pdf(file = "grafikas-3.pdf")
  boxplot(Nile)
dev.off()


# Naudojant šią funkciją, galima atstatyti standartines visų parametrų reikšmes.

pdf.options(reset = TRUE)


# UŽDUOTIS ------------------------------ 

# 1. 
#    
# 2. 
#    


# --------------------------------------- #
# RASTRINĖ GRAFIKA                        #
# --------------------------------------- #

# Rastrinės grafikos paveiksle vaizdas sudarytas iš daug taškų, kurių kiekvienas 
# yra tam tikros spalvos ir užima tam tikrą vietą. Svarbiausios charakteristikos
# tai paveikslo dydis taškais ir spalvų skaičius. Dydis dažniausiai išreiškiamas
# pikselių skaičiumi į plotį ir aukštį, spalvų skaičius nusakomas bitų skaičiumi.
# Pvz., jei spalvoms koduoti skiriami 8 bitai, tada tokiame paveiksle naudojamos
# 256 spalvos. 

# Kadangi kiekvienas taškas gali būti skirtingos spalvos, rastrinė grafika labai
# gerai tinka fotografijai bei kitiems sudėtingiems vaizdams fiksuoti ir saugoti, 
# tačiau rastriniu formatu saugomas vaizdas užima daugiau vietos negu vektoriniu.
# Be to, keičiant mastelį arba atliekant kitas geometrines transformacijas, pvz., 
# pasukant, prarandama vaizdo kokybė.

# Daugeliui įrenginių rastrinė grafika yra natūralus būdas atvaizduoti tam tikrą
# vaizdą: tai skaitmeninė fotokamera, kompiuterio ekranas, spausdintuvas ir t.t. 
# Labiausiai paplitę šie rastrinės grafikos failų formatai:
#
#        png -- Portable Network Graphics,
#        bmp -- Bitmap Image File,
#       jpeg -- Joint Photographic Experts Group,
#       tiff -- Tagged Image File Format.

# Kiekvienas failo formatas turi savo pritaikymo sritį. Pavyzdžiui, BMP formatas 
# naudojamas nesuspaustiems rastriniams vaizdams saugoti ir yra natūtali Windows
# OS grafinės sistemos dalis. JPEG tai rastrinių vaizdų saugojimo bei suspaudimo 
# metodas. Jis dažniausiai naudojamas skaitmetinėje fotografijoje ir žemėlapiams
# atvaizduoti. Vaizdo suspaudimo laipsnį galima nustatyti, tačiau čia prarandama
# informacija, todėl nukenčia paveikslo kokybė. Dėl tos priežasties JPEG netinka 
# brėžiniams bei diagramoms vaizduoti. PNG formate vaizdo suspaudimas atliekamas 
# be informacijos praradimo. PGN formatas naudojat tik RGB spalvų sistemą, todėl
# netinka spaudai, bet grafikams, diagramoms ir brėžiniams tinka geriau nei JPEG.
# Spaudoje plačiai naudojamas TIFF formatas, kuriame suspaudimas gali būti ir be 
# informacijos praradimo, ir su praradimu, o spalvoms naudojamos ir RGB, ir CMYK
# sistemos.

# Grafikams išsaugoti rastriniu formatu R turi funkcijas bmp, jpeg, png ir tiff. 
# Beveik visi šių funkcijų parametrai yra tie patys, svarbiausi iš jų yra tokie:
#
#       file -- failo pavadinimas,
#      width -- grafiko plotis,
#     height -- grafiko aukštis,
#      units -- grafiko išmatavimo vienetai, px, in,
#        res -- taškų tankis, 
#  pointsize -- taško dydis,
#         bg -- grafiko fono spalva,
#     family -- grafike naudojamo šrifto šeima,
#       type -- grafikos tipas, standartinis Windows GDI arba Cairo,
#  antialias -- glodinimo metodas.

# Jei grafikas išsaugomas JPEG formatu, vaizdo suspaudimo laipnis yra nustatomas 
# naudojant parametrą quality, jei TIFF formatu, naudojant parametrą compression
# nustatomas vaizdo suspaudimo algoritmas, kurių yra keletas.


# Jeigu grafikas bus peržiūrimas kompiuterio ekrane arba naudojamas publikavimui
# internete, tai jam išsaugoti geriausiai tinka PNG formatas. Pvz., nubraižysime 
# paprastą 800 x 600 px dydžio grafiką ir išsaugosime jį PNG formatu.

png(file = "grafikas-800x600.png", 800, 600)
  plot(sin, -3*pi, 3*pi)
dev.off()


# JPEG formatu saugomo vaizdo kokybė labai priklauso nuo jo suspaudimo laipsnio.
# Pavyzdžiui, nubraižysime tam tikros vietovės žemėlapį su aukščio izolinijomis, 
# kurį pradžioje išsaugosime JPEG formatu su dideliu suspaudimo laipsniu, o tada
# dar kartą išsaugosime išlaikant beveik maksimalią vaizdo kokybę. Jai nustatyti
# naudojamas funkcijos jpeg parametras quality. Galima pastebėti, kad 

jpeg(file = "zemelapis-jpg-15proc.jpg", 800, 600, quality = 15)
  filled.contour(volcano, color = terrain.colors, nlevels = 20, 
  	                  plot.axes = contour(volcano, n = 20, add = TRUE))
dev.off()

jpeg(file = "zemelapis-jpg-95proc.jpg", 800, 600, quality = 95)
  filled.contour(volcano, color = terrain.colors, nlevels = 20, 
  	                  plot.axes = contour(volcano, n = 20, add = TRUE))
dev.off()

# Nesunkiai galima pastebėti spalvos netolygumus, neryškias linijas ir kitus dėl 
# didelio vaizdo suspaudimo atsiradusius artefaktus. Didelės kokybės faile tokie
# artefaktai vizualiai nematomi, tačiau toks failas užima žymiai daugiau vietos.
# Palyginimui tą patį grafiką išssaugosime PNG formatu. Galima pastebėti, kad to
# paties dydžio ir vizualiai tos pačios vaizdo kokybės JPEG failas užima daugiau 
# vietos diske negu PNG formato failas.

png(file = "zemelapis-png.png", 800, 600)
  filled.contour(volcano, color = terrain.colors, nlevels = 20, 
  	                  plot.axes = contour(volcano, n = 20, add = TRUE))
dev.off()


# Rastrinės grafikos paveiksliuko dydis išreiškiamas taškų skaičiumi - paprastai
# nurodomas plotis ir aukštis. Realus paveikslo dydis ekrane arba ant popieriaus 
# priklauso nuo taškų tankio; kuo taškų tankis didesnis, tuo paveikslas mažesnis. 
# Taškų tankis ekrane nurodomas PPI (points per inch), o spausdinto paveiksliuko 
# taškų tankis nurodomas DPI (dots per inch) vienetais. Kompiuterio ekrane taškų 
# tankis standartiškai yra 72 ppi. Spaudoje, kur reikalinga aukšta vaizdo kokybė, 
# paveiksliukas gali būti 300 arba net ir 600 dpi.

# Rastrinės grafikos funkcijose taškų tankis nustatomas naudojant parametrą res. 
# Tarkime, kad atspausdintas 200 ppi paveiksliukas turi būti 8 x 6 colių dydžio. 
# Tokį grafiką išsaugosime PNG formatu. Nesunku apskaičiuoti, kad paveikslas bus 
# 1600 x 1200 pikselių dydžio.

png(file = "zemelapis-8x6-200ppi.png", 8, 6, units = "in", res = 200)
  filled.contour(volcano, color = terrain.colors, nlevels = 20, 
  	                  plot.axes = contour(volcano, n = 20, add = TRUE))
dev.off()


# NAUDINGA ------------------------------

# Gana dažnai pasitaiko situacija, kada reikia nubraižyti ir išsaugoti keletą to 
# paties tipo grafikų. Tipinė situacija -- analogiškų skaičiavimų su skirtingais
# duomenimis rezultatų atvaizdavimas ir jų palyginimas. 

# Pavyzdžiui, turime matricą su 25 stulpeliais. Reikia nubraižyti visų kintamųjų
# histogramas ir išsaugoti jas PNG formato failuose su skirtingais pavadinimais.
# Čia panaudosime modeliuotus duomenis.

duomenys <- replicate(25, rnorm(200, sample(20, 1)))

# Paprasčiausias būdas atlikti šią užduotį -- histogramos braižymo funkciją hist 
# įdėti į ciklą, kurio indeksas perbėga per matricos stulpelius. Kadangi grafiką
# reikia išsaugoti vis kitame faile, failo vardus sudarome kiekvienos iteracijos 
# metu. Paprasčiausia prie failo vardo pridėti numerį, tam naudojame f-ją paste.

for (i in 1:25) {

  failas <- paste("histograma-", i, ".png", sep = "")

  png(file = failas, 800, 600)
    hist(duomenys[, i])
  dev.off()
}

# Peržiūrint gautas histogramas, iš karto išryškėja keletas trūkumų. Pvz., failų 
# numeracija teisinga, bet jų išdėstymo tvarka 1, 10, 11, ..., 19, 2, 20 ir t.t.
# yra nepatogi. Visų histogramų antraštės yra vienodos. Histogramos iš skirtingų
# failų tarpusavyje nepalyginamos, kadangi visų jų ašių ribos yra skirtingos. Šį 
# grafikų braižymo algoritmą galima patobulinti ir ištaisyti pastebėtus trūkumus:
#
#   1. failo vardus numeruoti pradedant nuo 01, 02 ir t.t.;
#   2. kiekvienam grafikui uždėti individualią antraštę;
#   3. nustatyti bendras visiems grafikams ašių kitimo ribas;
#   4. visoms histogramoms nustatyti vienodą stulpelių skaičių;
#   5. automatiškai nustatyti iteracijų skaičių.


# Pirmiausia nustatome, kokiose ribose kinta visų lentelės kintamųjų reikšmės, o
# tada jas šiek tiek išplečiame ir suapvaliname iki sveikų reikšmių. Histogramos
# stulpelių maksimalus aukštis parenkamas bandymų keliu.

xx <- round(range(duomenys) + c(-0.5, 0.5)) 
yy <- c(0, 60)


for (i in 1:ncol(duomenys)) {

  nr <- sprintf("%02d", i)
  failas   <- paste("histograma-", nr, ".png", sep = "")
  antraštė <- paste("Histogramos numeris", nr)    

  png(file = failas, 800, 600)
    hist(duomenys[, i], breaks = 10, xlim = xx, ylim = yy, ann = FALSE)
    title(main = antraštė, xlab = "x")
  dev.off()
}


# UŽDUOTIS ------------------------------ 

# 1. 
#    
# 2. 
#    
