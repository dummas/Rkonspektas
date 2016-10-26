
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Pagrindiniai funkcijos plot metodai.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2014-03-07 | 2014-03-24
#


# TURINYS -------------------------------

#
#   1. Funkcijos plot metodai sklaidos diagramoms:
#      * plot.default
#      * plot.data.frame
#      * plot.formula
#
#   2. Metodas vieno kintamojo funkcijų grafikams:
#      * plot.function
#
#   3. Metodai dažnių lentelėms atvaizduoti:
#      * plot.table
#      * plot.factor
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
# FUNKCIJA PLOT IR JOS METODAI            #
# --------------------------------------- #

# Pagrindinė grafikų ir įvairių diagramų braižymo funkcija yra plot. Tai bendro 
# pobūdžio (generic) funkcija, kuri skirtingo tipo duomenims atvaizduoti naudoja 
# skirtingus metodus. Pavyzdžiui, kaip argumentą nurodžius du skaičių vektorius 
# x ir y, nubraižoma taškų su koordinatėmis (x, y) sklaidos diagrama, nurodžius 
# dažnių lentelę, nubraižoma stulpelinė diagrama, nurodžius bet kokios skaitinės
# R funkcijos pavadinimą arba užrašius jos išraišką, nubraižomas tos funkcijos 
# grafikas. Funkcija plot atpažįsta dažniausiai naudojamų statistinių procedūrų 
# rezultatų objektus ir jų atvaizdavimui naudoja specifinius metodus. Pavyzdžiui, 
# kaip argumentą nurodžius tiesinių modelių procedūros lm rezultatų objektą, bus 
# braižoma paklaidų sklaidos diagrama ir kiti diagnostiniai to modelio grafikai, 
# o nurodžius hierarchinio klasterizavimo procedūros hclust rezultatą, braižoma 
# dendrograma. Galima paminėti keletą dažniausiai naudojamų metodų:
# 
#   plot.default    --  skaitinių kintamųjų x ir y sklaidos diagramos braižymui,
#   plot.data.frame --  skaitinių duomenų lentelių atvaizdavimui,
#   plot.formula    --  duomenų pagal jų priklausomybės modelį atvaizdavimui,
#   plot.function   --  įvairių funkcijų grafikų bražymui,
#   plot.table      --  dažnių ir kryžminių dažnių lentelių atvaizdavimui,
#   plot.factor     --  kategorinių kintamųjų (faktorių) atvaizdavimui,
#   plot.histogram  --  histogramos braižymui,
#   plot.density    --  tankio funkcijos įverčio braižymui,
#   plot.ecdf       --  empirinės pasiskirstymo funkcijos braižymui,
#   plot.ts         --  laiko eilutės grafiko braižymui,
#   plot.dendrogram --  dendrogramos atvaizdavimui,
#   plot.lm         --  tiesinio modelio diagnostinių grafikų braižymui.

# Visus funkcijos plot metodus galima sužinoti naudojant funkciją methods.
methods(plot)


# --------------------------------------- #
# METODAI SKLAIDOS DIAGRAMOMS SUDARYTI    #
# --------------------------------------- #

# Pats paprasčiausias grafikas - taškų su koordinatėmis (x, y) sklaidos diagrama.
# Tokiu atveju funkcijai plot perduodami šių taškų koordinačių vektoriai x ir y.

x <- c(2.0, 1.6, 1.2, 1.0, 1.0, 1.3, 1.6, 2.0, 2.3, 2.8, 2.8, 3.0, 2.8, 2.4, 2.1)
y <- c(0.8, 1.1, 1.3, 1.6, 2.2, 2.5, 2.9, 3.1, 3.0, 2.8, 2.4, 1.8, 1.4, 1.0, 0.9)
z <- c(2.8, 6.1, 4.5, 8.0, 6.7, 9.0, 9.2, 9.3, 7.2, 9.6, 8.6, 8.4, 7.3, 6.1, 3.9)

d <- data.frame(x, y, z)
l <- list(x, y, z)

# Nubraižysime tris skirtingas šių kintamųjų sklaidos diagramas.

plot(x, y)
plot(x, z)
plot(y, z)

# Diagramoje pavaizduotų taškų koordinatės (x, y) gali būti apskaičiuotos. Tokiu 
# būdu galima nubraižyti įvairias kreives. Pavyzdžiui, nubraižysime gerai žinomą
# Lisažu kreivę, kuri užrašyta parametriniu pavidalu.

t <- seq(0, 2*pi, length = 1000)
x.i <- sin(3*t + pi/8)
y.i <- cos(4*t)

plot(x.i, y.i, pch = ".", main = "Lissajous kreivė")


# Tokiu pačiu būdu galima braižyti įvairių funkcijų grafikus. Pvz., nubraižysime 
# racionalios trupmenos y = P(x)/Q(x) grafiką intervale [-5, 5].

x <- seq(-5, 5, length = 100)
y <- x/(x^2 + x + 1)

plot(x, y, type = "l")


# Jei funkcijai plot kaip argumentas nurodoma data.frame tipo lentelė, sudaromas
# grafikas, kuriame atvaizduojamos visų tokios lentelės skaitinių kintamųjų porų 
# sklaidos diagramos. Pavyzdžiui, atvaizduosime anksčiau sudarytos lentelės visų 
# trijų kintamųjų porų sklaidos diagramas.

plot(d)

# Lentelėje iris yra 3 rūšių gėlių žiedlapių matavimai. Pirmi keturi kintamieji 
# yra skaitiniai, paskutinis yra kategorinis ir nurodo, kuriai rūšiai priklauso 
# stebiniai. Nubraižysime šių kintamųjų sklaidos diagramas.

plot(iris)

# Kategorinį lentelės kintamąjį galima panaudoti sklaidos diagramos taškų spalvai 
# nustatyti. Tokiu būdu tuos pačius duomenis galima nagrinėti įvairiais pjūviais.

plot(iris[, 1:4], col = iris[, 5])


# NAUDINGA ------------------------------

# Dviejų kintamųjų sklaidos diagrama yra vienas iš būdų pastebėti statistinę šių
# kintamųjų priklausomybę. Ši priklausomybė yra akivaizdi, kai taškų koordinates
# (x, y) sieja ryšys y = f(x). Nagrinėjant atsitiktinių dydžių priklausomybę yra
# rašomas statistinis modelis, kuris R kalboje išreiškiamas per formulę. Kairėje
# jos pusėje rašomas kintamasis, kuris atitinka koordinatę y, o dešinėje pusėje
# užrašomas kintamasis x. Funkcija plot, naudodama metodą plot.formula, pagal šį
# modelį sudaro dviejų kintamųjų sklaidos diagramą.

modelis <- y ~ x
modelis

# Pavyzdžiui, sudarysime duomenų lentelės d kintamųjų x ir y sklaidos diagramą.
# Funkcijai plot kaip parametrą perduodame kintamųjų sąryšio modelį ir nurodome 
# duomenų lentelę, iš kurios ir paimami modelyje įrašyti kintamieji x ir y.

plot(modelis, data = d)

# Jeigu modelis, pagal kurį braižoma sklaidos diagrama, nesikeičia, jo išraišką 
# galima įrašyti tiesiai į funkciją plot.

plot(y ~ x, data = d)

# Formulėje įrašyti kintamieji nebūtinai turi būti duomenų lentelėje. Pavyzdžiui,
# nubraižysime sąrašo l kintamųjų x ir y sklaidos diagramą.

plot(y ~ x, data = l)

# Pastaba. Nenurodžius nei duomenų lentelės, nei sąrašo pavadinimo, bus braižoma 
# tokius pat pavadinimus turinčių kintamųjų (jei tokie yra) sklaidos diagrama.
# Šiuo atveju kintamieji x ir y aprašo aukščiau paminėtos rac. trumpenos taškus.

plot(y ~ x)

# Naudojant modelį, galima užrašyti labai įvairias tų pačių kintamųjų tarpusavio
# priklausomybes. Užrašysime keletą dažniausiai pasitaikančių modelių:
# 
#   y ~ x         -- taškų su koordinatėmis (x, y) sklaidos diagrama,
#   y ~ 1         -- taškų (i, y.i) diagrama, kai i -- y elementų eilės numeris, 
#     ~ x         -- taškų su koordinatėmis (x, 1) išsidėstymo tiesėje diagrama,
#     ~ x + y     -- ta pati taškų (x, y) sklaidos diagrama,
#     ~ x + y + z -- trijų kintamųjų x, y ir z porų sklaidos diagramos.

# Naudodami duomenų lentelės d kintamuosius, pagal šiuos modelius nubraižysime 
# visas šias sklaidos diagramas.

plot(y ~ x, data = d)

plot(x ~ 1, data = d)
plot(y ~ 1, data = d)

plot( ~ x, data = d)
plot( ~ y, data = d)
plot( ~ z, data = d)

plot( ~ x + y,     data = d)
plot( ~ x + y + z, data = d)


# UŽDUOTIS ------------------------------ 

# 1. Naudojant funkciją plot, nubraižykite brėžinį, kur 10 x 10 dydžio kvadrate
#    būtų pažymėti visi taškai, kurių koordinatės yra natūriniai skaičiai.
# 2. Nubraižykite apskritimą su centru taške (2, 2) ir spinduliu R=2. Apskritimo
#    taškai turi būti sujungti ištisine raudona linija. Kad apskritimo grafikas
#    vizualiai nepavirstų į elipsės grafiką, naudojant parametrą asp nurodykite 
#    fiksuotą 1:1 kraštinių santykį.
# 3. Nubraižykite elipsės su centru koordinačių pradžioje grafiką. Tegul ilgoji
#    elipsės pusašė lygi 5, o trumpoji -- 3.
# 4. Apskaičiuokite Archimedo spiralės 1000 taškų koordinates, nubraižykite jos
#    grafiką. Braižant grafiką, reikia nurodyti fiksuotą 1:1 kraštinių santykį.
# 5. Lentelėje cars yra automobilio greičio ir stabdymo kelio matavimų duomenys.
#    Sudarykite stabdymo kelio ir automobilio greičio tarpusavio priklausomybės 
#    modelį ir nubraižykite jį atitinkantį kintamųjų sklaidos diagramą.


# --------------------------------------- #
# METODAS FUNKCIJOS GRAFIKUI NUBRAIŽYTI   #
# --------------------------------------- #

# Funkcija plot turi metodą vieno kintamojo funkcijų y = f(x) grafikams braižyti.
# Pagrindiniai parametrai:
#
#       x -- funkcijos f(x) pavadinimas arba jos išraiška,
#    from -- intervalo [a, b] reikšmė a,
#      to -- intervalo [a, b] reikšmė b,
#       n -- taškų skaičius intervale [a, b].
#
# Sudarant funkcijos f(x) intervale [a, b] grafiką, šis intervalas padalinamas į 
# 100 lygių dalių, kurias viena nuo kitos atskiria n = 101 taškų. Tuose taškuose
# skaičiuojamos funkcijos y = f(x) reikšmės ir gaunamos taškų (x, y) koordinatės.

# Pavyzdžiui, sudarysime tos pačios racionalios trupmenos y = P(x)/Q(x) grafiką. 
# Pirmiausia jos išraišką užrašysime kaip R funkciją.

fx <- function(x) {
  y <- x/(x^2 + x + 1)
  return(y)
}

plot(fx)


# Be papildomų nustatymų nubraižomas funkcijos intervale [0, 1] grafikas, tačiau 
# intervalo ribas galima pakeisti.

plot(fx, from = -5, to = 5)

# Jei parametrų reikšmės priskiriamos nustatyta tvarka, tai parametrų pavadinimų 
# galima ir nerašyti.

plot(fx, -5, 5)

# Taškų (x, y), iš kurių sudaromas funkcijos grafikas, skaičių galima pakeisti.

plot(fx, -5, 5, n = 10)
plot(fx, -5, 5, n = 1000)


# Kartais gali būti naudinga galimybė išsaugoti taškų (x, y), iš kurių sudarytas 
# funkcijos y = f(x) grafikas, koordinates. 

xy.list <- plot(fx, -5, 5)
xy.list

plot(xy.list)


# Gana dažnai reikalingas kokios nors standartinės funkcijos grafikas. Jį galimą
# nubraižyti net keliais būdais. Pavyzdžiui, nubraižysime standartinio normaliojo
# pasiskirstymo tankio funkcijos grafiką.

# Pirmas būdas. Galima apskaičiuoti tankio funkcijos y = p(x) reikšmes taškuose 
# x ir taškus (x, y) atidėti plokštumoje.

x <- seq(-3, 3, len = 100)
y <- 1/sqrt(2*pi)*exp(-x^2/2)

plot(x, y, type = "l")


# Antras būdas. Reikiamos funkcijos išraišką galima užrašyti kaip R funkciją ir 
# nubrėžti jos grafiką.

norm.tankis <- function(x) {
  y <- 1/sqrt(2*pi)*exp(-x^2/2)
  return(y)
}

plot(norm.tankis)
plot(norm.tankis, -3, 3)


# R turi daug praktikoje reikalingų ir dažnai naudojamų funkcijų ir atskirai jų 
# užrašinėti nereikia -- užtenka žinoti jų pavadinimus. Standartinio normalinio 
# dydžio tankio funkcija yra dnorm, o tikimybių pasiskirstymo funkcija -- pnorm.

plot(dnorm, -3, 3)
plot(pnorm, -3, 3)

plot(sqrt)
plot(log)
plot(exp)

plot(sin, -pi/2, pi/2)

# Standartines R funkcijas galima panaudoti kitų funkcijų sudarymui. Pavyzdžiui,
# R turi funkciją y = sin(x), tačiau neturi funkcijos y = sin(2x). Jos išraišką 
# kaip argumentą galima įrašyti tiesiai į funkciją plot.

plot(function(x) sin(2*x), -pi/2, pi/2)


# UŽDUOTIS ------------------------------ 

# 1. Panaudojant standartinę R funkciją, nubraižykite funkcijos y = |x| grafiką 
#    intervale [-1, 1].
# 2. Naudodami standartines trigonometrines R funkcijas, nubraižykite funkcijos
#    y = arcsin(sin(x)) grafiką intervale [-2pi, 2pi].
# 3. Nubraižykite normaliojo skirstinio su vidurkiu 10 ir standartiniu nuokrypiu 
#    lygiu 3 tankio funkcijos grafiką. Intervalą parinkite taip, kad funkcijos
#    reikšmės galuose būtų labai artimos nuliui.
# 4. Panaudojant funkciją plot, nubraižykite chi-kvadrat skirstinio su 5 laisvės 
#    laipsniais tankio funkcijos grafiką intervale [0, 20]. Chi-kvadrat tankio
#    funkcijos pavadinimas dchisq.


# --------------------------------------- #
# METODAI DAŽNIŲ LENTELĖMS IR FAKTORIAMS  #
# --------------------------------------- #

# Funkcija plot gali atvaizduoti dažnių lenteles. Vieno kintamojo dažnių lentelė
# atvaizduojama kaip stulpelinė diagrama, kurioje kintamojo reikšmę atitinkančio 
# stulpelio aukštis lygus tos reikšmės pasikartojimų skaičiui -- dažniui.

# Pavyzdžiui, turime vektorių, kurio elementai yra didžiosios raidės. Sudarysime 
# šio vektoriaus raidžių dažnių lentelę ir ją atvaizduosime.

g <- c("A", "B", "D", "A", "C", "C", "C", "C", "C", "C", "A", "A", "D", "B", "B")

t <- table(g)
t

plot(t)
plot(t, main = "Dažnių pasiskirstymas grupėse", xlab = "Grupė", ylab = "")


# Jei funkcijos plot argumentas yra kategorinis kintamasis (faktorius), sudaroma
# to kintamojo dažnių lentelę atitinkanti stulpelinė diagrama.

# Pavyzdžiui, kintamąjį g paversime į faktorių ir sudarysime tą pačią stulpelinę 
# diagramą neskaičiuodami tarpinės dažnių lentelės.
 
g <- factor(g)
g

plot(g)

# Vienas iš funkcijos plot argumentų gali būti kategorinis, o kitas -- skaitinis.
# Priklausomai nuo to, kokio tipo kintamasis bus priskirtas parametrui x, o koks
# parametrui y, funkcija plot sudarys du skirtingus grafikus. Abiem atvejais tai
# bus skaitinio kintamojo sklaidos diagramos atskirose grupėse pagal kategorinio
# kintamojo reikšmes. Skiriasi tik atvaizdavimo būdas.

s <- c(0.6, 3.4, 6.1, 0.7, 5.2, 1.4, 2.3, 3.4, 2.5, 9.4, 2.7, 4.1, 2.9, 0.1, 7.5)
k <- c("T", "N", "N", "T", "T", "T", "N", "T", "T", "N", "T", "N", "T", "T", "N")

k <- factor(k, levels = c("T", "N"), labels = c("Taip", "Ne"))

plot(k)

# Jei funkcijos plot parametrui x priskiriamas skaitinis vektorius, o parametrui 
# y -- kategorinis (faktorius), tai skirtingoms grupėms priklausančios skaitinio 
# kintamojo reikšmės išdėstomos ant tas grupes atitinkančių horizontalių tiesių. 
# Tokiu būdu gaunamos vienmatės sklaidos diagramos.

plot(s, k)

# Jei parametrui x priskiriamas kategorinis kintamasis (faktorius), o parametrui 
# y --- skaitinis, tada iš skirtingoms grupėms priklausančių skaitinio kintamojo 
# reikšmių sudaromos atskiros tų kategorijų boxplot diagramos, kurios išdėstomos 
# ant x ašies.

plot(k, s)

# Jei iš karto abiems funkcijos plot parametrams x ir y priskiriami kategoriniai 
# kintamieji, nubraižoma specifinė stulpelinė diagrama, kuri vadinama spineplot. 
# Šioje diagramoje ant Ox ašies išdėstomi skirtingas pirmojo kintamojo reikšmes 
# atitinkantys vienetinio aukščio stulpeliai. Kiekvienas stulpelis padalinamas į
# tiek dalių, kiek skirtingų antrojo kintamojo reikšmių yra atitinkamoje pirmojo
# kintamojo grupėje, o kiekvienos dalies dydis proporcingas tų reikšmių dažniui.

plot(k, g)
plot(g, k)


# NAUDINGA ------------------------------

# Į kintamųjų ryšius aprašantį modelį galima įtraukti kategorinius kintamuosius.
# Tokiu atveju dešinėje modelio pusėje įrašytas kategorinis kintamasis grupuoja
# kairės pusės kintamojo stebinius. Diagramos pavidalas priklauso nuo to, kokio
# tipo kintamieji yra vienoje ir kitoje modelio pusėje. Tarkime, kad kintamasis 
# x yra skaitinis, o kintamieji k ir g -- kategoriniai (faktoriai). Tokiu atveju
# galima užrašyti dažniausiai naudojamus modelius:
# 
#     ~ k     -- kategorinio kintamojo k stulpelinė dažnių diagrama,
#   x ~ k     -- skaitinio kintamojo x boxplot diagrama kintamojo k grupėse,
#     ~ k + x -- skaitinio kintamojo x boxplot diagrama kintamojo k grupėse,
#   g ~ k     -- kategorinio kintamojo g spineplot diagrama grupėse pagal k,
#     ~ k + g -- kategorinio kintamojo g spineplot diagrama grupėse pagal k.

# Nubraižysime skaitinio kintamojo s boxplot diagramas grupėse suformuotas pagal 
# skirtingas kintamojo k reikšmes.

plot(s ~ k)

# Naudojant modelį, nubraižysime kategorinio kintamojo g dažnių diagramą.

plot( ~ g)

# Dviejų kategorinių kintamųjų spineplot diagramą galima nubraižyti užrašant du 
# ekvivalenčius jų priklausomybės modelius. Galima atkreipti dėmesį, kad pirmas
# kintamasis dešinėje visada yra grupuojantis. Šiuo atveju tai yra kintamasis g.

plot(k ~ g)
plot(  ~ g + k)


# UŽDUOTIS ------------------------------ 

# 1. Sudarykite vektorių iš šios užduoties pirmojo sakinio raidžių. Visos raidės
#    vektoriuje turi būti vienodos: arba mažosios, arba didžiosios. Sudarykite
#    raidžių dažnių lentelę ir atvaizduokite ją kaip stulpelinę diagramą.
# 2. Pirmoje užduotyje sudarytą raidžių vektorių paverskite į faktorių. Gaukite
#    tokią pačią raidžių pasikartojimo dažnių stulpelinę diagramą a) nenaudojant
#    kategorinio kintamojo sklaidos modelio, b) naudojant modelį.
# 3. Naudojant pirmoje užduotyje sudarytą raidžių vektorių, sudarykite papildomą
#    vektorių, kurio elementams priskiriama reikšmė "B", jei raidė yra balsė, ir
#    reikšmė "P", jei raidė yra priebalsė. Paverskite šį vektorių į kategorinį 
#    kintamąjį. Atvaizduokite balsių ir priebalsių dažnių diagramą ir atsakykite,
#    kokių raidžių yra daugiau?
# 4. Užrašykite tokį kintamųjų sąryšio modelį, kad pagal jį būtų galima nubrėžti
#    duomenų lentelės iris kintamojo Sepal.Length boxplot diagramas atskirai 
#    kiekvienai kategorinio kintamojo Species grupei.
