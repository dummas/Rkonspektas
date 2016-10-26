
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Funkcija plot ir pagrindiniai jos parametrai.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2014-02-26 | 2014-03-09 | 2014-06-18
#


# TURINYS -------------------------------

#
#   1. Funkcija plot ir pagrindiniai jos parametrai:
#      * parametrai x ir y 
#      * parametras type 
#      * parametras pch 
#      * parametras cex 
#      * parametras lty 
#      * parametras lwd 
#      * parametras col 
#
#   2. Papildomi funkcijos plot parametrai:
#      * parametrai main ir sub 
#      * parametrai xlab ir ylab
#      * parametrai xlim ir ylim
#      * parametras asp 
#      * parametras ann 
#      * parametras frame 
#      * parametrai xaxt ir yaxt
#      * parametras axes 
#


# PASTABOS ------------------------------

#
# Jokių pastabų nėra.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuviška lokalė. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# Ištrinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# FUNKCIJA PLOT IR JOS PARAMETRAI         #
# --------------------------------------- #

# Pagrindinė grafikų ir įvairių diagramų braižymo funkcija yra plot. Tai bendro 
# pobūdžio (generic) funkcija, kuri skirtingo tipo duomenims atvaizduoti naudoja 
# skirtingus metodus. Susipažinsime su plot.default medodu, kuris naudojamas tuo 
# atveju, kai sudaroma taškų su koordinatėmis x ir y sklaidos diagrama. Esminiai 
# funkcijos plot parametrai:
# 
#      x -- x reikšmių vektorius (abscisė),
#      y -- y reikšmių vektorius (ordinatė).
#
# Diagramos išvaizdą galima pakeisti nurodant kitas grafinių parametrų reikšmes. 
# Dažniausiai naudojami šie parametrai:
#
#   type -- sklaidos diagramos tipas,
#    pch -- taško simbolis,
#    cex -- taško simbolio dydis,
#    lty -- linijos tipas,
#    lwd -- linijos storis,
#    col -- taško arba linijos spalva.


# Nubraižysime paprastą taškų (x, y) sklaidos diagramą. Šiuo atveju vektoriaus y 
# elementai yra tam tikros funkcijos y = f(x) reikšmės taškuose x.

x <- -5:15
y <- x^3 - 10*x^2 - 10*x + 3

# Parametrams x ir y priskirsime kintamuosius x ir y. Jei parametrų pavadinimai
# nurodomi, reikšmes jiems galima priskirti bet kokiu eiliškumu.

plot(x = x, y = y)
plot(y = y, x = x)

# Jei parametrai surašomi nustatyta tvarka, tai jų pavadinimų galima ir nerašyti. 

plot(x, y)


# Pademonstruosime, kaip, keičiant parametro type reikšmę, gaunami kiti sklaidos
# diagramos variantai. Vienas nuo kito jie skiriasi taškų (x, y) atvaizdavimo ir 
# jų sujungimo būdais.

plot(x, y, type = "p")       # diagramoje atidedami nesujungti taškai
plot(x, y, type = "l")       # nubraižoma taškus jungianti laužtė
plot(x, y, type = "b")       # taškai sujungiami tiesės atkarpomis
plot(x, y, type = "o")       # braižomi ir taškai, ir juos jungianti laužtė
plot(x, y, type = "s")       # braižoma laiptuota laužtė I
plot(x, y, type = "S")       # braižoma laiptuota laužtė II
plot(x, y, type = "h")       # taškuose x atidedami y aukščio stulpeliai

plot(x, y, type = "n")       # suformuojamas grafikas be taškų


# Keičiant parametro pch reikšmę, galima nurodyti, kokiu simboliu šioje sklaidos 
# diagramoje bus vaizduojamas taškas. Sveikieji skaičiai nuo 0 iki 25 žymi spec.
# daugiausiai naudojamus simbolius, skaičiai nuo 32 iki 127 žymi ASCII simbolius.
# Be to, parametro pch reikšmė gali būti ir bet koks kabutėse įrašytas tekstinis 
# simbolis.

plot(x, y)

plot(x, y, pch = 1)          # pagal nutylėjimą naudojamas tuščias taškas
plot(x, y, pch = 19)         # tokio pat dydžio, tačiau užpildytas taškas
plot(x, y, pch = "*")        # taško simbolis gali būti nurodomas kabutėse
plot(x, y, pch = ".")        # taško simbolis gali būti ir paprastas taškas


# Diagramos taško simbolio dydis priklauso nuo mastelio parametro cex reikšmės. 
# Pagal nutylėjimą ši reikšmė lygi 1 ir tai atitinka standartinį simbolio dydį.

plot(x, y, cex = 1)          # standartinis bet kokio taško simbolio dydis
plot(x, y, cex = 2)          # du kartus padidintas taškas
plot(x, y, cex = 0.5)        # du kartus sumažintas taškas


# Keičiant parametro lty reikšmę, galima keisti taškus jungiančios linijos tipą:
# "blank", "solid", "dashed", "dotted", "dotdash", "longdash", "twodash". Šiuos
# linijos tipus atitinka sveikieji skaičiai nuo 0 iki 6.

plot(x, y, type = "l", lty = 1)   # taškai jungiami ištisine linija
plot(x, y, type = "l", lty = 2)   # taškai jungiami punktyrine linija
plot(x, y, type = "l", lty = 3)   # taškai sujungiami taškine linija


# Keičiant parametro lwd reikšmę, keičiamas diagramos taškus jungiančios linijos 
# storis. Pagal nutylėjimą šio parametro reikšmė lygi 1.

plot(x, y, type = "l", lwd = 1)   # standartinis linijos storis
plot(x, y, type = "l", lwd = 2)   # dvigubas linijos storis


# Diagramos taškų ir juos jungiančių linijų spalva nustatoma naudojant parametrą
# col, kurio reikšmė yra spalvos pavadinimas. Standartinių R spalvų sąrašas toks: 

colors()

# Vietoje spalvų pavadinimų galima naudoti spalvų numerius tam tikroje paletėje. 
# Pagal nutylėjimą naudojama paletė turi 8 pagrindines spalvas, todėl parametro
# col reikšmė 1 šioje paletėje atitinka spalvą "black", reikšmė 2 - spalvą "red" 
# ir t.t. Kitoje spalvų paletėje tie patys numeriai gali reikšti kitas spalvas!

palette()

plot(x, y, col = "black")
plot(x, y, col = "red")

plot(x, y, col = 1)
plot(x, y, col = 2)


# Naudojant parametrą bg, simboliams su numeriais nuo 21 iki 25 galima nurodyti 
# užpildymo spalvą. Kaip ir anksčiau, tam galima naudoti spalvos numerį paletėje.

plot(x, y, pch = 21, col = 2)     # simbolio kontūro spalva
plot(x, y, pch = 21,  bg = 2)     # simbolio užpildymo spalva


# NAUDINGA ------------------------------

# Sklaidos diagramoje kiekvienas taškas gali būti vaizduojamas vis kitu simboliu.
# Tam parametrui pch reikia nurodyti simbolių vektorių. Jei jo elementų skaičius
# mažesnis negu diagramos taškų skaičius, taško simboliai cikliškai pakartojami. 
# Pavyzdžiui, nubraižysime sklaidos diagramą naudojant du pasikartojančius taško 
# simbolius.

plot(x, y, pch = 1:2)

# Taško simbolius nurodantys numeriai nebūtinai turi eiti iš eilės, todėl galima
# sudaryti bet kokį parametro reikšmių vektorių.

plot(x, y, pch = c(1, 13))

# Taškus sklaidos diagramoje galima pavaizduoti net ir raidėmis.

plot(x, y, pch = letters)


# Keletos reikšmių vektorių galima nurodyti ir kitiems parametrams. Pavyzdžiui,
# visi diagramos taškai gali būti skirtingų dydžių ir spalvų. Vienu metu galima 
# keisti iš karto kelių parametrų reikšmes.

plot(x, y, pch = 22, cex = 1:3, col = 1:3)
plot(x, y, pch = 22, cex = 1:3,  bg = 1:3)


# Grafinius diagramos taško parametrus galima kontroliuoti panaudojant papildomą
# kintamąjį. Tokiu būdu kiekvieno taško dydis arba spalva keisis proporcingai to
# kintamojo reikšmėms. Jei tas papildomas kintamasis yra kategorinis, tai galima 
# vizualiai atskirti skirtingas to kintamojo reikšmes atitinkančius taškus.

# Pavyzdžiui, nubraižysime diagramą, kur neigiamą y koordinatę turintys taškai
# bus atvaizduojami kita spalva. Tam sukursime papildomą kategorinį kintamąjį ir
# jį priskirsime spalvos parametrui col.

plot(x, y, pch = 20, col = factor(y < 0))


# UŽDUOTIS ------------------------------ 

# 1. Nubraižykite funkcijos v = sin(u) grafiką intervale [-pi, pi]. Grafike turi
#    būti pavaizduoti: a) nesujungti taškai (u, v), b) ištisinė linija be taškų, 
#    c) taškai ir juos jungianti mėlyna punktyrinė linija.
# 2. Nubraižykite taškų su koordinatėmis (x, y) sklaidos diagramą, kurioje taško 
#    simbolio dydis būtų proporcingas koordinatės x reikšmei. Proporcingumo koef.
#    galima pasirinkti laisvai.
# 3. Nubraižykite tokią taškų su koordinatėmis (x, y) sklaidos diagramą, kurioje
#    ant visus taškus jungiančios kreivės būtų pavaizduoti tik tie taškai, kurių  
#    koordinatė y < 0.
# 4. Iš failo "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/lent_1b.dat" 
#    nuskaitykite duomenų lentelę. Nubraižykite: a) šios lentelės kintamųjų x ir 
#    y sklaidos diagramą, b) diagramą, kurioje taškų (x, y) spalva priklauso nuo
#    tos pačios lentelės kintamojo z reikšmės.


# --------------------------------------- #
# PAPILDOMI FUNKCIJOS PLOT PARAMETRAI     #
# --------------------------------------- #

# Funkcija plot turi papildomų parametrų, kurie nustato diagramos ašių ir bendrą
# grafiko antraštę, nustato atskirų ašių atraštes, keičia ašių ribas arba kitaip
# formuoja grafiko išvaizdą. Čia dažniausiai naudojami tokie parametrai:
#
#   main -- bendra diagramos antraštė, 
#    sub -- papildoma antraštė,
#   xlab -- ašies Ox antraštė,
#   ylab -- ašies Oy antraštė,
#   xlim -- ašies Ox reikšmių kitimo ribos, vektorius c(x1, x2),
#   ylim -- ašies Oy reikšmių kitimo ribos, vektorius c(y1, y2),
#    asp -- nustatomas grafiko y/x kraštinių santykis,
#  frame -- jei FALSE, grafikas braižomas be rėmelio,
#   axes -- jei FALSE, grafikas braižomas be ašių,
#    ann -- jei FALSE, grafikas rodomas be antraščių,
#   xaxt -- jei "n", Ox ašis nebraižoma,
#   yaxt -- jei "n", Oy ašis nebraižoma.


# Pagrindinė grafiko antraštė suformuojama naudojant parametrą main. Jo reikšmė
# yra į kabutes įrašytas antraštės tekstas, kuris užrašomas viršutinėje grafiko 
# dalyje. Parametrui galima priskirti ir kintamąjį su antraštės tekstu.

plot(x, y, main = "Kintamųjų x ir y sklaidos diagrama")

# Naudojant naujos eilutės simbolį \n, labai ilgą antraštę galima užrašyti per
# kelias eilutes. Šiuo atveju antraštės tekstas priskirtas atskiram kintamajam.

antraštė <- "Per dvi eilutes užrašytas\n labai ilgas grafiko pavadinimas"
plot(x, y, main = antraštė)

# Parametras sub naudojamas papildomai antraštei, kuri rašoma grafiko apačioje.

plot(x, y, sub = "Papildoma antraštė")


# Be papildomų nustatymų ašių Ox ir Oy pavadinimai sutampa su parametrams x ir y 
# priskirtų kintamųjų vardais. Jiems pakeisti naudojami parametrai xlab ir ylab. 

plot(x, y)

plot(x, y, xlab = "x", ylab = "y = f(x)")

# Parametrams xlab ir ylab priskyrus kabutėse įrašytą tarpo simbolį, pavadinimai
# ant ašių bus nematomi. 

plot(x, y, xlab = "", ylab = "")


# Pagal nutylėjimą ašių Ox ir Oy ribos nustatomos automatiškai ir jos parenkamos 
# taip, kad diagramoje būtų atvaizduoti visi taškai (x, y). Jei tas ribas reikia
# padidinti arba sumažinti, naudojami parametrai xlim ir ylim. Pavyzdžiui, jeigu
# ašies Ox reikšmių kitimo ribos turi būti [a, b], tai parametrui xlim nurodomas
# vektorius c(a, b).

# Iš pradžių nustatysime, kokiose ribose kinta taškų (x, y) koordinatės x ir y. 
# Vektoriaus elementų įgyjamų reikšmių ribos nustatomos naudojant komandą range.

range(x)
range(y)

# Galima parodyti, kad parametrams xlim ir ylim nustačius tokias ribas, gaunamas
# grafikas nesiskiria nuo automatiškai sudaromo grafiko. 

plot(x, y)
plot(x, y, xlim = range(x), ylim = range(y))

# Parametrams xlim ir ylim nurodomos ribos gali būti ir platesnės, ir siauresnės. 
# Tokiu būdu ašies reikšmių ribas galima apriboti ir parodyti tik dalį diagramos 
# taškų. Pavyzdžiui, diagramoje nerodysime taškų (x, y), kurių koordinatė y < 0.

plot(x, y, ylim = c(0, 1000), type = "b")

# Pavyzdžiui, išplėsime ašies Ox reikšmių ribas nuo [-5, 15] iki [-10, 30].

plot(x, y, xlim = c(-10, 30))

# Jeigu parametrui nurodomos tokios ribos [a, b], kad a > b, tai atitinkama ašis 
# grafike nukreipiama į priešingą pusę. Pavyzdžiui, diagramoje apsuksime ašį Ox.

plot(x, y, xlim = c(30, -10))


# Bet kokios diagramos ar funkcijos grafiko išvaizda priklauso nuo ašių Ox ir Oy 
# mastelio. Keičiant grafinio lango dydį, keičiasi ir grafiko kraštinių santykis,
# todėl ištemptas ar suspaustas grafikas atrodo skirtingai. Naudojant parametrą 
# asp, kraštinių santykį y/x galima užfiksuoti.

plot(x, y)
plot(x, y, asp = 1/50)
plot(x, y, asp = 1/200)


# Naudojant loginį parametrą frame.plot, galima uždrausti grafiko rėmelį.

plot(x, y, frame.plot = FALSE)

# Naudojant parametrą axes, galima nurodyti, kad grafikas būtų braižomas be ašių.
# Tokiu atveju nelieka ir rėmelio, tačiau išlieka grafiko ašių pavadinimai.

plot(x, y, axes = FALSE)


# NAUDINGA ------------------------------

# Pačias bendriausias grafikų braižymo taisykles reguliuoja specialūs grafiniai
# parametrai.

# Naudojant parametrą ann, galima uždrausti rodyti visas diagramos antraštes iš 
# karto, net jei jos ir yra nustatytos atitinkamais parametrais.

plot(x, y, main = "Diagramos antraštė", xlab = "x", ylab = "f(x)")
plot(x, y, main = "Diagramos antraštė", xlab = "x", ylab = "f(x)", ann = FALSE)


# Parametrams xaxt arba yaxt nurodžius reikšmę "n", galima uždrausti ašies Ox ar 
# Oy braižymą. Tokiu atveju grafiko rėmelis išlieka.

plot(x, y, xaxt = "n")


# UŽDUOTIS ------------------------------ 

# 1. Užrašykite komandą, kuri taškų (x, y) sklaidos diagramoje ašies Ox ribas 
#    automatiškai praplėstų: a) po 10 vnt. į abi puses, b) po 10 % į abi puses.
# 2. Nubraižykite taškų (x, y) sklaidos diagramą, kurioje būtų atvaizduoti tik
#    patys taškai, bet nebūtų nei ašių, nei ašių pavadinimų, nei kitų antraščių. 
