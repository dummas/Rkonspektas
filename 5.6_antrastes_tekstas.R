
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Grafiko antraštės ir kitas papildomas tekstas.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2014-06-10 | 2014-06-29
#


# TURINYS -------------------------------

#
#   1. Grafiko antraštės formavimo funkcijos:
#      * funkcija title
#      * funkcija expression
#      * funkcija substitute
#
#   2. Papildomo teksto ant grafiko uždėjimas:
#      * funkcija text
#      * funkcija mtext
#


# PASTABOS ------------------------------

#
# Parašyti apie funkciją symbols.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuviška lokalė. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# Ištrinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# DIAGRAMOS ANTRAŠČIŲ FORMAVIMAS          #
# --------------------------------------- #

# Funkcija plot ir kitos aukšto lygio grafinės funkcijos turi standartinius ašių
# ir pagrindinės grafiko antraštės nustatymo parametrus: xlab, ylab ir main. Bet
# kartais ašių ir viso grafiko antraščių formavimui gali būti naudojama speciali 
# funkcija title. Pagrindiniai jos parametrai yra tokie:
#
#       main -- pagrindinės antraštės tekstas,
#        sub -- pagalbinės antraštės tekstas,
#       xlab -- ašies Ox antrašės pavadinimas,
#       ylab -- ašies Oy antrašės pavadinimas.

# Pavyzdžiui, naudojant funkciją curve nubraižysime funkcijos y = sin(x) grafiką. 
# Matome, kad grafike yra abiejų ašių antraštės, tačiau nėra pagrindinės grafiko 
# antraštės. 

curve(sin, -pi, pi)

# Diagramos antraštę ant jau sudaryto grafiko uždedame naudojant funkciją title.

title(main = "Funkcijos y = sin(x) grafikas")


# Lygiai taip pat ant jau sudaryto grafiko uždedamos ašių antraštės. Pavyzdžiui,
# braižant funkcijos grafiką, uždrausime ašies Oy antraštę, o vėliau ją uždėsime 
# naudojant funkciją title ir jos parametrą ylab.

curve(sin, -pi, pi, ylab = "")
title(main = "Funkcijos y = sin(x) grafikas")
title(ylab = "y = sin(x)")


# Jei dėl kokių nors priežasčių visas grafiko antraštes reikia uždrausti, tokiam
# tikslui naudojamas loginis parametras ann. Ant tokio grafiko antraštę uždedame
# naudojant funkciją title.

curve(sin, -pi, pi, ann = FALSE)
title(main = "Funkcijos y = sin(x) grafikas", xlab = "x", ylab = "f(x)")


# Funkcija title dažniausiai naudojama tokiais atvejais, kai antraštės yra labai
# ilgos, turi specialių matematinių simbolių ar priklauso nuo kažkokių papildomų 
# duomenų. Kartais antraštę tenka sudaryti iš kelių atskirų dalių. Išnagrinėsime 
# keletą tipinių situacijų.


# Antraštės tekste gali būti įvairių matematinių simbolių. Tai graikiškos raidės, 
# indeksai, laipsniai, šaknies, sumos, integralo ir kiti specialūs simboliai. Jų
# užrašymo sintaksė šiek tiek primena LaTeX taisykles:
 
?plotmath

# Tokio užrašymo būdo galimybių demonstracija:

demo(plotmath)

# Norint į antraštės tekstą įrašyti matematinius simbolius, reikia kad funkcijos
# title parametrui būtų priskirta R išraiška. Tam naudojama funkcija expression.
# Pavyzdžiui, nubraižysime funkcijos y = sin(x) grafiką, bet antraštėse vietoje 
# argumento x įrašysime alpha.

curve(sin, -pi, pi, xlab = "", ylab = "")
title(xlab = expression(alpha), ylab = expression(sin ~ alpha))

# Ant to paties grafiko uždėsime bendrą antraštę. Šiuo atveju antraštė susideda 
# iš teksto ir viduryje esančios formulės. Tokiu būdu gauname tris dalis: žodis,
# formulė ir vėl žodis. Šias tris dalis į išraišką sujungsime naudojant funkciją 
# paste. Čia simbolis ~ nurodo tarpą tarp žodžių, o == reiškia formulėje esančią
# lygybę.

curve(sin, -pi, pi, xlab = expression(alpha), ylab = expression(sin ~ alpha))
title(main = expression(paste("Funkcijos ", y == sin ~ alpha, " grafikas")))

# Nubraižysime dar vieną grafiką, kurio antraštėse bus keli specialūs simboliai. 
# Tai bus natūraliųjų skaičių sumos diagrama. Jos antraštėse panaudosime apatinį 
# indeksą ir sumos ženklą.

plot(cumsum(1:100), type = "h", ann = F)
title(xlab = "n", ylab = expression(S[n]))
title(main = expression(paste("Sumos ", S[n] == sum(k, k==1, n), " grafikas")))


# Kita dažnai pasitaikanti situacija, kada grafiko antraštėje reikia įrašyti tam
# tikro kintamojo reikšmę. Pavyzdžiui, tai gali būti kreivės parametrų reikšmės,
# grafiko eilės numeris ir pan. Tokiu atveju naudojama funkcija substitute, kuri 
# išraiškoje esančiam kintamajam priskiria tam tikrą reikšmę. Pagrindiniai f-jos
# parametrai tokie:
#
#       expr -- R išraiška,
#        env -- išraiškoje esančių kintamųjų reikšmių sąrašas.

# Pavyzdžiui, nubraižysime funkcijos y = sin(kx) grafiką ir uždėsime antraštę su
# konkrečia parametro k reikšme.

k <- 5
curve(sin(k*x), -pi, pi, xlab = "x", ylab = "y")
title(substitute(paste("Funkcijos ", y == sin(m*x), " grafikas"), list(m = k)))

# Naudojant funkciją substitute, galima perduoti kelių parametrų reikšmes. Pvz.,
# nubraižysime tiesės y = b_0 + b_1*x grafiką, o tiesės lygtį su tokių parametrų 
# reikšmėmis užrašysime antraštėje. Šiuo atveju reikės perduoti parametrų b_0 ir 
# b_1 reikšmes.

b.0 <- 5.12
b.1 <- 0.53

curve(b.0 + b.1*x, 0, 10, ann = F, asp = 1)

title(xlab = "x", ylab = expression(y == beta[0] + beta[1]*x))
title(substitute(paste("Tiesė ", y == a + b*x), list(a = b.0, b = b.1)))


# Nubraižysime chi-kvadrat skirstinio tankio funkcijos grafiką ir užrašysime jam
# antraštę, kurioje įrašomas skirstinio parametro -- laisvės laipsnių skaičius k.

k <- 5
curve(dchisq(x, df = k), 0, 20, xlab = "x", ylab = "p(x)")

# Kadangi antraštės tekstas gana ilgas, jį galima išskaidyti į atskiras dalis ir,
# naudojant funkciją paste, į vientisą sakinį sudėti funkcijos substitute viduje. 
# Tokiu atveju teksto dalys taip pat yra kintamieji, todėl jiems reikšmes reikia 
# priskirti.

t.1 <- " skirstinio su "
t.2 <- " laisvės l. tankio funkcijos grafikas"
title(main = substitute(paste(chi^2, a, b, c), list(a = t.1, b = k, c = t.2)))


# NAUDINGA ------------------------------

# Grafiko braižymo funkcijas galima įdėti į ciklą. Jei tokių funkcijų parametrai
# priklauso nuo ciklo kintamojo, gauname laikei besikeičiantį grafiką, animaciją.
# Tam, kad būtų galima sekti funkcijų parametrų reikšmes arba tam tikras duomenų 
# statistikas, jas galima nurodyti grafiko antraštėje.

# Pavyzdžiui, nubraižysime funkcijos y = sin(x) grafiką, kuriame vienas po kito
# uždedami sinusoidę sudarantys taškai. Antraštėje nurodysime k-ojo taško numerį.

n <- 1000
x <- seq(-2*pi, 2*pi, length.out = n)
y <- sin(x)

for (i in 1:n) {
  plot(x, y, type = "p", pch = ".", col = x <= x[i])
  title(main = substitute(k == nr, list(nr = i)))
}


# Čia matome, kad kiekvienos iteracijos metu braižomas tas pats grafikas, tačiau
# dalis taškų yra baltos spalvos, ir todėl jų nesimato. Taip gaunamas animacijos
# efektas. Nubraižysime dar vieną animuotą grafiką. Čia pavaizduosime normaliojo 
# dėsnio su besikeičiančiu vidurkiu, tačiau pastovia dispersija tankio funkcijos 
# grafiką. Antraštėje užrašysime skirstinio parametro, t. y. vidurkio reikšmę.

m <- seq(20, 80, by = 0.05)

for (i in m) {
  curve(dnorm(x, mean = i, sd = 5), 0, 100, ylim = c(0, 0.1), ylab = "p(x)")
  abline(v = i, col = "red")
  title(main = substitute(paste("Vidurkis ", mu == v), list(v = i)), adj = 0)
}


# UŽDUOTIS ------------------------------ 

# 1. Nubraižykite f-jos y = x^3 - 10*x^2 - 10*x + 10 grafiką intervale [-10, 20]. 
#    Grafiko antraštėje užrašykite matematinę šios funkcijos formulę, o ašies Oy
#    užrašą pakeiskite į y.
# 2. Nubraižykite trupmenų 1/2^k sumos, kai k - sveikieji skaičiai nuo 0 iki 10,
#    grafiką. Grafiko antraštėje užrašykite sumos matematinę išraišką.
# 3. Sudarykite programą, kuri pasirinktame taške (x, y) nubraižytų R spindulio 
#    apskritimą. Grafiko antraštėje turi būti nurodytos centro koordinatės ir R
#    reikšmė.
# 4. Sudarykite programą, kuri nubraižytų normaliojo pasiskirstymo su pasirinktu
#    vidurkiu ir dispersija tankio funkcijos grafiką. Abiejų parametrų reikšmės 
#    turi būti automatiškai užrašomos grafiko antraštėje.
# 5. Sudarykite animuotą grafiką, kuriame pavaizduokite, kaip nuosekliai taškas 
#    po taško nubraižomas apskritimas. Grafiko antraštėje nurodykite taško eilės
#    numerį. Apskritimą sudarančių taškų skaičių n galima pasirinkti laisvai.
# 6. Sudarykite animuotą grafiką, kuriame pavaizduota, kaip keičiasi chi-kvadrat
#    skirstinio tankio funkcija, kai laisvės laipsnių skaičius k kinta nuo 1 iki
#    100. Grafiko antraštėje turi būti rodoma besikeičianti k reikšmė.


# --------------------------------------- #
# PAPILDOMO TEKSTO ANT GRAFIKO UŽDĖJIMAS  #
# --------------------------------------- #

# Teksto ant grafiko uždėjimui taškuose (x, y) naudojama cpeciali funkcija text. 
# Pagrindiniai jos parametrai tokie:
#
#          x -- taško, kuriame uždedamas tekstas, abscisė,
#          y -- taško, kuriame uždedamas tekstas, ordinatė,
#     labels -- taškuose (x, y) uždedamas tekstų vektorius,
#        pos -- taško pusė, kurioje atidedamas tekstas, 1, 2 3 arba 4,
#     offset -- uždedamo teksto postūmis nuo taško (x, y),
#        cex -- uždedamo teksto dydis,
#        col -- uždedamo teksto spalva,
#       font -- šrifto tipas,
#        srt -- kampas, kuriuo pasukamas tekstas.

# Iš pradžių nubraižysime paprastą keletos taškų sklaidos diagramą. Kintamasis x 
# yra planetos pusiaujo skersmuo kilometrais, o y --- vidutinis tankis gramais į 
# kubinį centimetrą.

x <- c(5.427, 5.24, 5.5153, 3.934)
y <- c(4879.4, 12103.7, 12756.274, 6804.9)
t <- c("Merkurijus", "Venera", "Žemė", "Marsas")

plot(x, y, xlim = c(3, 6), ylim = c(4000, 14000), pch = 19, ann = FALSE)

title(xlab = expression(paste("Tankis, ", g/cm^3)))
title(ylab = "Pusiaujo skersmuo, km")


# Tarkime, kad tuos taškus plokštumoje reikia tam tikru būdu identifikuoti. Pats
# paprasčiausias būdas juos atskirti -- pagal eilės numerį, kurį užrašysime prie
# kiekvieno taško. Pasinaudosime funkcija text. Jei funkcijai text nurodome vien
# tik taškų (x, y) koordinates, pagal nutylėjimą ant taškų užrašomas jų numeris.

plot(x, y, xlim = c(3, 6), ylim = c(4000, 14000), pch = 19, ann = FALSE)
text(x, y)

# Tam, kad tekstas būtų uždedamas šalia taško (x, y), naudojamas parametras pos. 
# Jei jam priskiriama reikšmė 1, tekstas uždedamas žemiau taško, jei 2 - kairėje 
# pusėje ir t.t.

plot(x, y, xlim = c(3, 6), ylim = c(4000, 14000), pch = 19, ann = FALSE)
text(x, y, pos = 2)

# Dažniausiai taškų numeriai patys savaime nieko nereiškia, todėl vien tik pagal 
# stebinio numerį negalima pasakyti kuo vienas taškas skiriasi nuo kito. Tokiais
# atvejais taškams galima priskirti kokį nors kitą požymį. Šiuo atveju naudosime
# naują kintamąjį -- planetos pavadinimų vektorių t.

plot(x, y, xlim = c(3, 6), ylim = c(4000, 14000), pch = 19, ann = FALSE)
text(x, y, pos = 2, labels = t)

# Toje pačioje pozicijoje galima uždėti kelis skirtingus tekstus. Tam, kad naują
# uždedamą tekstą būtų galima pastumti į šoną, naudojamas parametras offset.

text(x, y, pos = 2, offset = -1)

# Žinoma, nebūtina prisirišti prie duomenų taškų. Tekstą galima uždėti ir kitoje
# grafiko vietoje. Pvz., ant sklaidos grafiko taške (4, 10000) užrašysime tekstą.

plot(x, y, xlim = c(3, 6), ylim = c(4000, 14000), pch = 19, ann = FALSE)
text(4, 10000, labels = "Planetų išsidėstymas pagal skersmenį ir tankį")


# Parametrais galima reguliuoti uždedamo teksto dydį, spalvą, šrifto tipą ir pan.
# Pvz., taškų numerius padidinsime, naudosime pastorintą šriftą ir kiekvienam iš
# jų suteiksime vis kitą spalvą.

plot(x, y, xlim = c(3, 6), ylim = c(4000, 14000), pch = 19, ann = FALSE)
text(x, y, pos = 1, cex = 3, font = 2, col = 1:4)

# Jei tekstą reikia pasukti tam tikru kampu, naudojamas grafinis parametras srt.

plot(x, y, xlim = c(3, 6), ylim = c(4000, 14000), pch = 19, ann = FALSE)
text(x, y, pos = 1, srt = 45)


# Grafikas paprastai turi pagrindinę antrašę ir ašių antraštes. Teksto užrašymui 
# grafiko paraštėse naudojama funkcija mtext. Jos parametrai:
#
#       text -- tekstas arba išraiška,
#       side -- taško pusė, kurioje atidedamas tekstas, 1, 2 3 arba 4,
#       line -- paraštės eilutės, kurioje užrašomas tekstas numeris, 
#         at -- koordinatė, ties kuria paraštėje atidedamas tekstas,
#        adj -- skaičius iš [0, 1], nurodo, pagal kurią pusę lygiuoti tekstą,
#        cex -- uždedamo teksto dydis,
#        col -- uždedamo teksto spalva,
#       font -- šrifto tipas.

# Dar kartą nubraižysim planetų išsidėstymo grafiką, kuriame taškas proporcingas
# planetos dydžiui. Suformuosime grafiko ašis bei paraštėse užrašysime papildomą
# informaciją.

plot(x, y, xlim = c(3, 6), ylim = c(4000, 14000), ann = F, fra = F, cex = y/2000)

title(main = "Žemės tipo planetų išsidėstymas pagal tankį ir diametrą")
title(xlab = expression(paste("Tankis, ", g/cm^3)))
title(ylab = "Pusiaujo skersmuo, km")

text(x, y, labels = t, pos = 2, offset = 2)
text(x, y, labels = x, pos = 1, offset = 1.5, cex = 0.7)

# Grafiko paraštėse užrašysime papildomą informaciją: dešinėje nurodytas duomenų
# šaltinis, apačioje dešinėje užrašoma grafiko sudarymo data.

informacija <- "Duomenys apie planetas paimti iš wikipedijos"

mtext(text = informacija, side = 4, at = 4000, adj = 0.0, cex = 0.8, col = 8)
mtext(Sys.Date(), side = 1, line = 3, adj = 1, font = 11, cex = 0.8, col = 8)


# NAUDINGA ------------------------------

# Papildomi užrašai prie taškų --- gana savotiškas būdas plokštumoje atvaizduoti 
# daugiamačius duomenis. Pavyzdžiui, paimsime keturių šalių 2011-2013 m. nedarbo 
# ir infliacijos lygio duomenis. Čia tokie kintamieji: šalis, metai, nedarbas ir 
# infliacijos lygis.

t <- textConnection("
Šalis    Metai  N     I
Lietuva  2011   15.3  4.1
Latvija  2011   16.2  4.4
Estija   2011   12.5  5.0
Švedija  2011   7.8   3.0
Lietuva  2012   13.2  3.1
Latvija  2012   15.0  2.3
Estija   2012   10.2  3.9
Švedija  2012   8.0   0.9
Lietuva  2013   11.5  1.5
Latvija  2013   11.6  0.4
Estija   2013   8.9   3.3
Švedija  2013   8.1   0.2")

d <- read.table(file = t, header = TRUE)
d

# Pradžioje nubraižysime paprastą infliacijos ir nedarbo lygio sklaidos diagramą.

plot(d$N, d$I, xlim = c(6, 17), ylim = c(0, 6), ann = FALSE)
title(xlab = "Nedarbo lygis, %", ylab = "Infliacija, %")

# Kadangi taškai diagramoje niekaip neatskiriami, be papildomų paaiškinimų tokia
# diagrama nieko neparodo. Todėl prie kiekvieno taško prirašysime, kuriai šaliai
# ir kuriems metams jis priklauso.

text(d$N, d$I, labels = d$Šalis, pos = 3)
text(d$N, d$I, labels = d$Metai, pos = 1, cex = 0.5, col = d$Metai - 2010)

points(d$N, d$I, col = d$Metai - 2010, pch = 19)


# Tą patį grafiką galima perbraižyti dar kitaip. Sujungsime linijomis tos pačios
# šalies skirtingų metų taškus. Taip gausime jų judėjimo laike trajektoriją. Čia
# sklaidos grafiką nubraižysime naudojant kintamųjų priklausomybės formulę. Toks
# užrašymo būdas yra patogesnis, kai iš duomenų lentelės reikia išskirti atskirų 
# šalių stebinius, tada galima pasinaudoti parametru subset.

plot(I ~ N, data = d, xlim = c(6, 17), ann = FALSE)
title(xlab = "Nedarbo lygis, %", ylab = "Infliacija, %")

text(I ~ N, data = d, labels = d$Metai, pos = 2, cex = .8, col = d$Metai - 2010)
points(I ~ N, data = d, col = d$Metai - 2010, pch = 19)

lines(I ~ N, data = d, subset = Šalis == "Lietuva", type = "b", lty = 3)
lines(I ~ N, data = d, subset = Šalis == "Latvija", type = "b", lty = 3)
lines(I ~ N, data = d, subset = Šalis == "Estija",  type = "b", lty = 3)
lines(I ~ N, data = d, subset = Šalis == "Švedija", type = "b", lty = 3)

text(I ~ N, data = d, subset = Metai == 2012, 
	labels = d$Šalis, pos = 4, offset = 1, font = 2)


# UŽDUOTIS ------------------------------ 

# 1. Nubraižykite parabolės x^2 + 2x - 15 grafiką. Grafike šalia taškų, kuriuose
#    parabolė kerta Ox ašį, uždėkite tekstą su šaknų x_1 ir x_2 reikšmėmis. Čia
#    indeksams 1 ir 2 užrašyti naudokite expression.
# 2. Nubraižykite laiko eilutės Nile grafiką. Ties didžiausia ir mažiausia laiko
#    eilutės reikšme uždėkite tekstus su atitinkamo stebinio numeriu ir eilutės 
#    reikšme.
# 3. Nubraižykite duomenų lentelės airquality kintamojo Temp reikšmių histogramą.
#    F-jos hist parametrui labels priskyrus reikšmę TRUE, dažnių reikšmes galima 
#    užrašyti ant stulpelių viršaus. Sugalvokite, kaip, naudojant funkciją text, 
#    tuos pačius dažnius būtų galima užrašyti stulpelio viduryje.
# 4. Naudojant planetų skersmens ir tankio duomenis, sudarykite grafiką, kuriame
#    vietoje planetas atitinkančių taškų būtų pavaizduotas planetos pavadinimas.
# 5. Naudojant infliacijos ir nedarbo lygio duomenų lentelę d, nubraižykite 2013 
#    metų infliacijos ir nedarbo lygio sklaidos diagramą. Greta taškų užrašykite
#    šalies pavadinimą. Apatinėje grafiko paraštėje užrašykite infliacijos lygio
#    vidurkį, kuris turi būti apskaičiuojamas automatiškai.
