
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Pagrindiniai grafiko braižymo etapai.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2015-03-05 | 2015-03-06
#


# TURINYS -------------------------------

#
#   1. Pagrindiniai sklaidos diagramos braižymo etapai:
#      * plot.new,
#      * plot.window
#      * xy.coords
#      * plot.xy
#      * plot.default
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
# PAGRINDINIAI GRAFIKO BRAIŽYMO ETAPAI    #
# --------------------------------------- #

# Bet kokio sudėtingumo grafiko braižymas susideda iš keletos pagrindinių etapų: 
# grafinio įrenginio atidarymo, koordinačių sistemos sudarymo, taškų arba linijų 
# koordinačių skaičiavimo ir jų atidėjimo grafiniame lange. Visus šiuos veiksmus 
# atlieka tokios funkcijos:
#
#     plot.new -- sustabdo grafiko braižymą viename lange ir sukuria naują,
#  plot.window -- grafiniame lange sukuria koordinačių sistemą,
#    xy.coords -- apskaičiuoja taškų grafiniame lange koordinates,
#      plot.xy -- grafiniame lange atideda taškus,
# plot.default -- bazinė aukšto lygio grafinė funkcija.


# Pagrindinė aukšto lygio grafinė funkcija -- plot, kuri turi keletą metodų. Jos
# rezultatas priklauso nuo argumento. Jei argumentas yra taškai su koordinatėmis 
# (x, y), tai grafiko braižymas perduodamas funkcijai plot.default, kuri taškams
# grafike atidėti naudoja funkciją plot.xy. Šios funkcijos argumentas -- sąrašas
# iš keturių elementų: taškų koordinatės x ir y ir koordinačių ašių pavadinimai.
# Tada taškai atidedami grafiniame lange su nustatyta koordinačių sistema. Tokiu 
# būdu susidaro tam tikra funkcijų seka, kuri atspindi grafiko braižymo etapus:
#
# plot(x, y)
#         |
#        plot.default(x, y)
#                        |
#                       plot.xy(xy.coords(x, y))
#                                             |
#                                            plot.window()
#                                                       |
#                                                      plot.new()


# Visos aukšto lygio grafinės funkcijos, tokios kaip plot, curve, hist ir kitos,
# grafiką braižo arba naujame grafiniame lange, arba anksčiau atidarytame lange,
# kuris prieš tai išvalomas. Šiuos veiksmus, prieš grafiko braižymą aukšto lygio
# grafine f-ja, automatiškai atlieka funkcija plot.new. 

# Pavyzdžiui, jeigu nėra nei vieno grafinio lango, funkcija plot.new jį atidaro. 

plot.new()

# Jeigu grafinis langas atidarytas, nepriklausomai nuo to, kas jame pavaizduota,
# funkcija plot.new jį išvalo.

curve(sin, -pi, pi)
plot.new()

# Funkcijos plot.new sukurtame grafiniame lange koordinačių ašių ribos yra nuo 0 
# iki 1. Tuo nesunku įsitikinti naujame grafiniame lange nubraižius ašis.

plot.new()
axis(1)
axis(2)


# Koordinačių sistemos sudarymui naudojama funkcija plot.window. Jos parametrai:
#
#       xlim -- ašies Ox ribos,
#       ylim -- ašies Oy ribos,
#        asp -- koordinačių santykis y/x.

# Pavyzdžiui, atidarysime naują grafinį langą ir jame nustatysime reikiamas ašių
# ribas: Ox intervalas [10, 20] ir Oy intervalas [0, 5].

plot.new()
plot.window(xlim = c(10, 20), ylim = c(0, 5))
axis(1)
axis(2)

# Taip galima pakeisti ir jau nubraižyto grafiko koordinačių sistemą. Pavyzdžiui,
# nubraižysime funkcijos y = sin(x) grafiką įprastoje koordinačių sistemoje, kur
# ašies Oy intervalas [-1, 1]. Pakeitus koordinačių sistemą tos pačios funkcijos 
# grafikas atrodo visiškai kitaip.

par(mar = c(4, 4, 4, 4), las = 1)
plot.new()

plot.window(xlim = c(-pi, pi), ylim = c(-1, 1))
axis(1)
axis(2)
curve(sin, add = TRUE)

plot.window(xlim = c(-2*pi, 2*pi), ylim = c(-3, 3))
axis(3)
axis(4)
curve(sin, add = TRUE)


# Funkcija xy.coords sudaro sąrašą su taškų koordinatėmis (x, y) bei koordinačių
# ašių pavadinimais: x, y, xlab ir ylab. Šis sąrašas naudojamas taškų atidėjimui
# grafike, kurį atlieka bazinė taškų ir linijų braižymo funkcija plot.xy, tačiau
# prieš tai aptarsime f-jos xy.coords parametrus:
#
#          x -- taškų x koordinačių vektorius,
#          y -- taškų y koordinačių vektorius,
#       xlab -- Ox ašies pavadinimas,
#       ylab -- Oy ašies pavadinimas,
#        log -- nurodo, kuri ašis logaritminėje skalėje,
#    recycle -- nurodo, ar trumpesnį koordinačių vektorių cikliškai pratęsti.

# Pavyzdžiui, turėdami taškų koordinačių vektorius, sukursime tų taškų braižymui
# reikalinga sąrašą su taškų koordinatėmis ir koordinačių ašių pavadinimais.

x <- seq(-pi, pi, length = 100)
y <- sin(x)

xy.coords(x, y, xlab = "x", ylab = "sin(x)")

# Koordinačių vektorius galima susieti per formulę y ~ x.

xy.coords(y ~ x, xlab = "x", ylab = "sin(x)")

# Loginiam parametrui recycle priskiriant reikšmę TRUE, nustatome, kad trumpesnį
# koordinačių vektorių galima cikliškai pratęsti ir tokiu būdu juos suvienodinti.

xy.coords(1:10, 1:2, xlab = "x", ylab = "y", recycle = TRUE)


# Naudojant funkcijos xy.coords sudarytą sąrašą, funkcija plot.xy atideda taškus
# grafiniame lange su nustatyta koordinačių sistema. Pagrindiniai jos parametrai:
#
#         xy -- sąrašas su taškų koordinatėmis ir ašių pavadinimais,
#       type -- diagramos tipas,
#        pch -- taško simbolis arba jo numeris,
#        lty -- linijos tipas,
#        lwd -- linijos storis,
#        col -- linijos arba taško spalva,
#        cex -- taško mastelio koeficientas.

# Pavyzdžiui, sudarysime taškų koordinačių sąrašą ir, naudojant funkciją plot.xy 
# nubraižysime taškų sklaidos diagramą iš anksto atidarytame grafiniame lange su 
# nustatyta koordinačių sistema.

x <- c(2.0, 1.6, 1.2, 0.9, 1.0, 1.3, 1.6, 2.0, 2.3, 2.8, 2.9, 3.0, 2.8, 2.4, 2.1)
y <- c(0.8, 1.1, 1.3, 1.6, 2.2, 2.5, 2.9, 3.1, 3.0, 2.8, 2.4, 1.8, 1.4, 1.0, 0.9)

xy <- xy.coords(x, y, xlab = "x", ylab = "y")
xy

plot.new()
plot.window(xlim = c(0.8, 3.2), ylim = c(0.8, 3.2))
plot.xy(xy, type = "p")

# Funkcija plot.xy nėra aukšto lygio grafinė funkcija, todėl taškus ant anksčiau
# nubraižyto grafiko atideda jo neištrynusi. Pvz., tuos pačius taškus sujungsime
# tiesės atkarpomis, tam užtenka pakeisti parametro type reikšmę.

plot.xy(xy, type = "b", pch = 20, col = "red")
plot.xy(xy, type = "S")
plot.xy(xy, type = "s")


# Visą tokiam grafikui nubraižyti reikalingą funkcijų seką pakeičia viena aukšto
# lygio grafinė funkcija. Šiuo atveju tai funkcija plot. Ji turi metodą sklaidos 
# diagramoms braižyti ir tam naudoja funkciją plot.default. Pavyzdžiui, tą pačią
# taškų (x, y) sklaidos diagramą gausime naudojant tam skirtą f-ją plot.default.

plot.default(x, y, type = "b")

# Žinoma, toks pat rezultatas gaunamas diagramą braižant su aukšto lygio grafine 
# funkcija plot, kuri taškų atvaizdavimui ir naudoja f-ją plot.default.

plot(x, y, type = "b")


# UŽDUOTIS ------------------------------ 

# 1. 
#    
# 2. 
#    
