
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Pseudoatsitiktinių dydžių generavimo algoritmai.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2013-05-13 | 2016-03-16
#


# TURINYS -------------------------------

#
#   1. Pseudoatsitiktinių dydžių generavimo algoritmai:
#      * komanda RNGkind
#      * komanda set.seed
#      * standartiniai R algoritmai
#
#   2. Tiesinis kongruentinis generatorius ir jo atmainos:
#      * mišrus generatorius
#      * multiplikatyvinis
#      * standartiniai parametrai
#      * generatoriaus savybių tyrimas
#
#   3. Generavimas naudojant ats. dydžių transformaciją:
#      * eksponentinio dydžio generavimas
#


# PASTABOS ------------------------------

#
# Anyone who considers arithmetical methods of producing random digits is, of
# course, in a state of sin. -- John von Neumann
#


# NUSTATYMAI ----------------------------

# Nustatoma lietuviška lokalė. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# Ištrinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# STANDARTINIAI ATS. DYDŽIŲ GENERATORIAI  #
# --------------------------------------- #

# Pseudoatsitiktinių dydžių generatorius -- tai algoritmas, kuris generuoja seką
# tokių skaičių, kurių statistinės savybės panašios į tikrų ats. dydžių savybes.
# Tokiu būdu gauta skaičių seka iš tikro nėra atsitiktinė, kadangi sekos savybės
# priklauso nuo algoritmo parametrų, o pati seka visiškai priklauso nuo pradinės
# sekos reikšmės, kuri vadinama seed. Dėl šios priežasties skaičiai, sugeneruoti
# naudojant deterministinį algoritmą, ir vadinami pseudoatsitiktiniais.

# Tam tikrą pasiskirstymo dėsnį turinčių pseudoatsitiktinių dydžių generavimui R
# naudoja standartines funkcijas. Jų yra daug, paminėsime tik keletą, pavyzdžiui:
#
#     rbinom -- binominis,
#      rpois -- Puasono,
#      runif -- tolydusis,
#      rnorm -- normalusis,
#       rexp -- eksponentinis.


# Pvz., sugeneruosime tolygiai intervale [0, 1] pasiskirsčiusių ats. dydžių seką.

runif(10)

# Sugeneruosime 10 standartinį normalųjį pasiskirstymą turinčių ats. dydžių seką.

rnorm(10)


# Tolygiųjų ir normaliųjų pseudoatsitiktinių dydžių generatorius galima nurodyti 
# su komanda RNGkind. Ši komanda turi du parametrus:
#
#         kind -- tolygiųjų dydžių generatoriaus pavadinimas,
#  normal.kind -- normaliųjų dydžių generatoriaus pavadinimas.


# Tolygiojo atsitiktinio dydžio generavimui R galima naudoti šiuos standartinius 
# generatorius:
#
#         Wichmann-Hill -- periodas 6.9536*10^12
#  Marsaglia-Multicarry -- periodas 2^60
#           Super-Duper -- periodas 4.6*10^18
#      Knuth-TAOCP-2002 -- periodas 2^129
#         L'Ecuyer-CMRG -- periodas 2^191
#      Mersenne-Twister -- periodas 2^19937 - 1 

# Normaliųjų dydžių generavimui naudojami tokie generatoriai:
#
#      Kinderman-Ramage
#         Ahrens-Dieter
#            Box-Muller
#             Inversion


# Pagal nutylėjimą tolygiųjų dydžių generavimui naudojamas "Mersenne-Twister", o
# normaliųjų dydžių -- "Inversion" generatorius.

RNGkind()

# Tolygaus atsitiktinio dydžio generavimo algoritmą pakeisime į gerai žinomą bei
# praeityje plačiai paplitusį generatorių "Super-Duper" (Margsalia, 1972).

RNGkind(kind = "Super-Duper")
RNGkind()

set.seed(666)
runif(1)

# Pagal nutylėjimą tolygaus ats. dydžio generavimui R naudoja "Mersenne-Twister" 
# algoritmą. Grąžiname jį atgal.

RNGkind(kind = "default")
RNGkind()

set.seed(666)
runif(1)

# Matome, kad su ta pačia seed reikšme skirtingi algoritmai generuoja skirtingus
# dydžius.


# NAUDINGA ------------------------------

# Visiems pseudoatsitiktinių dydžių generatoriams reikia nustatyti pradinę sekos 
# reikšmę, kuri vadinama seed. Jei nenurodyta kitaip, seed reikšmė priklauso nuo 
# kompiuterio laiko, todėl kiekvieną kartą generuojama vis kita ats. dydžių seka.
# Pavyzdžiui, sugeneruosime 3 tolygiai pasiskirsčiusių atsitiktinių dydžių sekas.
# Visos trys bus skirtingos.

runif(10)
runif(10)
runif(10)

# Su ta pačia seed reikšme pseudoatsitiktinių dydžių generavimo algoritmas visad
# generuos tą pačią skaičių seką. Tai reiškia, kad eksperimentą galima atkartoti 
# visiškai tiksliai. Kartais tokia galimybė labai reikalinga. Norint gauti tokią 
# pačią pseudoatsitiktinių dydžių seką, kiekvieną kartą reikia nurodyti tą pačią 
# seed reikšmę. 

# Pradinės reikšmės nustatymui naudojama komanda set.seed, kurios argumentas yra 
# bet koks sveikasis skaičius, kuris ir yra seed reikšmė. Pvz., nustatysime seed
# reikšmę, sugeneruosime normaliųjų ats. dydžių seką ir, naudodami tą pačią seed
# reikšmę, dar kartą sugeneruosime tokią pačią ats. dydžių seką.

set.seed(1234)
rnorm(10)

set.seed(1234)
rnorm(10)


# --------------------------------------- #
# MIŠRUS KONGRUENTINIS GENERATORIUS       #
# --------------------------------------- #

# Egzistuoja keletas skirtingų metodų pseudoatsitiktinių dydžių generavimui. Čia
# aptarsime vieną plačiai paplitusį algoritmą, kuris turi keletą modifikacijų ir 
# naudojamas iki šiol.

# Tarkime, kad X -- atsitiktinis dydis. Tiesinis kongruentinis algoritmas dydžių 
# X seką generuoja pasinaudojant tokiu rekurentiniu sąryšiu:
#
#      X := (aX + c) mod m, kur
# 
#   daugiklis a >= 0,
#  prieauglis c >= 0,
#     modulis m > a, m > c.


# Kongruentiniams pseudoatsitiktinių dydžių generavimo algoritmams būdingas tam
# tikras generuojamos skaičių sekos periodas T. Tai reiškia, kad sekos elementai
# pradeda kartotis. Kad pseudoatsitiktiniai dydžiai būtų panašūs į atsitiktinius 
# dydžius, jie turi būtų neprognozuojami ir bent jau nesikartoti. Sekos periodas 
# priklauso nuo algoritmo parametrų, tačiau visada T < m. Kad priklausomybė tarp 
# generuojamų dydžių būtų kuo silpnesnė, parametras m turi būti didelis, nors ir
# tai negarantuoja dydžių nepriklausomumo, nes periodas T gali būti mažas net ir 
# prie didelės parametro m reikšmės. Be to, didelis periodas T negarantuoja, kad 
# skaičių seka bus atsitiktinė. Pavyzdžiui, jeigu parametrai a = c = 1, tada bus
# gaunama maksimalaus ilgio, bet visai neatsitiktinė seka, kurioje visi skaičiai 
# nuo 0 iki m-1 išsidėsto tam tikra tvarka, tačiau paskui vėl kartojasi ta pačia 
# tvarka. Tiesinių kongruentinių algoritmų teorija gerai išnagrinėta, ir žinomos
# sąlygos, kokie turi būti parametrai, kad sekos periodas būtų maksimalus.

# TEOREMA (Greenberger, 1961, Hull-Dobell, 1966). Sekos periodas T maksimalus ir 
# lygus m tada ir tik tada, kai išpildytos sąlygos:
#
#    -- c ir m yra tarpusavyje pirminiai,
#    -- a-1 yra visų parametro m pirminių daliklių kartotinis,
#    -- a-1 yra skaičiaus 4 kartotinis, jei ir m yra 4 kartotinis.


# Praktikoje parametras m paprastai lygus didžiausiam teigiamam skaičiui w, koks 
# telpa į vieną mašininį žodį. Pavyzdžiui, jei vienam skaičiui skiriama 32 bitai, 
# tai w = 2^31 - 1. R šį skaičių galima sužinoti su komanda .Machine

.Machine$integer.max   # tai ir yra skaičius w = 2^31 - 1

# Kita dažnai parenkama parametro m reikšmė -- tai didžiausias pirminis skaičius
# mažesnis už skaičių w. Šiuo atveju taip sutampa, kad m = 2^31 - 1 yra pirminis
# Merseno skaičius.


# Kai parametras c = 0, tai algoritmas vadinamas multiplikatyviniu kongruentiniu 
# generatoriumi (Lehmer, 1949). Dėl supaprastėjusių skaičiavimų, tokia algoritmo 
# modifikacija veikia šiek tiek greičiau, bet maksimalus periodas T yra mažesnis 
# nei m. Periodo T ilgį ir parametrų parinkimo sąlygas nusako Carmichael teorema
# iš kurios seka, kad multiplikatyvinio kongruentinio generatoriaus generuojamos 
# sekos periodas T lygus m-1 tada ir tik tada, kai išpildytos sąlygos:
#
#    -- m yra pirminis,
#    -- a yra primityvusis m elementas.

# Paskutinę sąlygą galima performuluoti taip: kiekvienam pirminiui m-1 dalikliui 
# p skaičius a^(m-1)/p - 1 nesidalina iš m. 


# --------------------------------------- #
# GENERATORIAUS PARAMETRŲ RINKINIAI       #
# --------------------------------------- #

# Naudojama daug tiesinio kongruentinio algoritmo parametrų rinkinių. Pateiksime 
# keletą labiausiai paplitusių generatorių, kurių savybės gerai ištirtos, o kai 
# kurie iš jų yra tarp standartinių R generatorių.

# Plačiai paplitęs generatorius MINSTD (Lewis et al., 1969), kuris dar vadinamas 
# minimaliu standartiniu generatoriumi (Park, Miller, 1988). Čia naudojamas toks 
# parametrų rinkinys: 

a <- 7^5                        # kai a = 48271 arba 69621 generatorius geresnis
c <- 0
m <- 2^31 - 1

# Šio generatoriaus versija su parametru a = 397204094 buvo naudojama programoje
# SAS/IML.


# Plačiai buvo paplitęs generatorius SUPER-DUPER (Margsalia, 1972). Jo parametrų
# reikšmės tokios:

a <- 69069
c <- 1                          # kartais naudojama versija su parametru c = 0
m <- 2^32


# Iš naujesnių generatorių Fortran kalboje buvo naudojamas generatorius NAG, kur 
# parametrų reikšmės tokios:

a <- 13^13
c <- 0                
m <- 2^59
X <- 123456789*(2^32 + 1)       # tokia naudojama seed reikšmė


# Maple programoje buvo naudojamas multiplikatyvinis kongruentinis generatorius 
# su tokiais parametrais:

a <- 427419669081
c <- 0                
m <- 10^12 - 11

# Čia m yra pirminis skaičius, o parametro a reikšmė yra primityvusis elementas, 
# todėl pagal Carmichael teorema, šis generatorius turi maksimalų periodą.


# Šiuo metu R, Python, C++, Ruby ir daugelyje kitų programavimo kalbų naudojamas 
# "Mersenne-Twister" algoritmas (Matsumoto, Nishimura, 1998). Tai iš esmės visai
# kitokio tipo generatorius, kurio periodas lygus net 2^19937 - 1.


# --------------------------------------- #
# PAPRASTAS GENERATORIAUS SAVYBIŲ TYRIMAS #
# --------------------------------------- #

# Ne visi atsitiktinių dydžių generatoriai vienodai geri, todėl generuojamų sekų 
# savybėms patikrinti naudojami įvairūs statistiniai testai. Pavyzdžiui, Diehard
# testas apima seriją iš keletos skirtingų testų, kurie patikrina vis kitą sekos
# savybę: atstumų tarp skaičių sekoje pasiskirstymą, kelių skaitmenų kombinacijų 
# pasiskirstymą, ats. dydžių sumų normališkumą ir t.t. Čia apsiribosime vizualiu 
# sekos narių pasiskirstymo ir tarpusavio priklausomybės įvertinimu.

# Nustatome algoritmo parametrus.

a <- 21
c <- 1
m <- 2048

# Nustatome ats. dydžių sekos X elementų skaičių n ir sukuriame sveikųjų skaičių 
# vektorių, kuris vėliau ir bus užpildytas atsitiktiniais dydžiais.

n <- 2000
X <- integer(n)

# Nustatome pradinę atsitiktinių dydžių sekos X reikšmę -- seed.

seed <- 1
X[1] <- seed

for (i in 2:n) {
  X[i] <- (a*X[i-1] + c) %% m
}

X

# Algoritmo parametrai parinkti taip, kad sekos periodas T maksimalus ir lygus m. 
# Sekos ilgis n < T, todėl visi sekos elementai be pasikartojimų sutelpa į vieną 
# periodą ir papildomos priklausomybės tarp tolimų sekos narių nėra. Patikriname
# ar sekoje yra pasikartojančių narių.

anyDuplicated(X)

# Jei kongruentinio algoritmo sugeneruotos sekos narius padalintume iš parametro 
# m, gautume tolygiai intervale (0, 1] pasiskirsčiusį atsitiktinį dydį.

X <- X/m
X

# Nubraižome histogramą ir matome, kad atsitiktinis dydis X tikrai gana tolygiai 
# pasiskirstęs intervale (0, 1].

hist(X, main = "Histograma", ylab = "Dažnis")

# Patikrinsime, kaip gretimos sekos X reikšmės pasiskirsčiusios plokštumoje. Tam 
# nubraižysime taškų (x, y) sklaidos diagramą, o koordinatės x ir y yra gretimos 
# sekos X reikšmės.

x <- X[seq(1, n-1, by = 2)]
y <- X[seq(2, n-0, by = 2)]

plot(x, y, xlab = "x", ylab = "y", main = "Sklaidos diagrama")

# Diagramoje matome, kad taškai gana tolygiai užpildo vienetinį kvadratą, tačiau 
# jų išsidėstymas yra dėsningas! Tai parodo, kad vien tik tolygaus pasiskirstymo 
# ant tiesės neužtenka.

# Panaši gretimų sekos narių priklausomybė išryškėja nubraižius jų pasiskirstymą 
# trimatėje erdvėje.

x <- X[seq(1, n-2, by = 3)]
y <- X[seq(2, n-1, by = 3)]
z <- X[seq(3, n-0, by = 3)]

require(lattice)
cloud(z ~ x*y, main = "Atsitiktinių dydžių sklaidos diagrama") 

# Kad būtų aiškiau, galima sudaryti taškų su koordinatėmis (x, y, z) projekcijas
# į atskiras plokštumas.

par(mfrow=c(1, 3), mar = c(2, 2, 1, 1))

plot(x, y, xlab = "x", ylab = "y", main = "")
plot(x, z, xlab = "x", ylab = "z", main = "")
plot(y, z, xlab = "y", ylab = "z", main = "")


# UŽDUOTIS ------------------------------ 

# 1. Tarkime, kad parametras m = 1024. Parinkite tokias parametrų a, c reikšmes,
#    kad gauta atsitiktinių dydžių seka būtų kaip galima tolygiau pasiskirsčiusi
#    ant tiesės ir plokštumoje.


# --------------------------------------- #
# GENERAVIMAS NAUDOJANT TRANSFORMACIJĄ    #
# --------------------------------------- #

# Yra keletas būdų, kaip gauti kitą pasiskirstymo dėsnį turintį atsitiktinį dydį
# Y. Vienas iš jų -- transformuoti tolygiai intervale pasiskirsčiusį atsitiktinį
# dydį X. Pavyzdžiui, standartinių normaliųjų dydžių poros generavimui naudojama
# Box-Muller transformacija. Žinoma, yra ir kitų būdų.

# Jeigu tolydus atsitiktinis dydis Y turi griežtai monotoninę pasiskirstymo f-ją
# F(y), tai ats. dydis X = F(Y) yra pasiskirstęs tolygiai intervale [0, 1]. Tokį
# rezultatą galima išnaudoti ats. dydžių su norima pasiskirstymo f-ja sudarymui.
# Tarkim, kad funkcija G yra pasiskirstymo f-jos F atvirkštinė, o X yra tolygiai
# intervale [0, 1] pasiskirstęs ats. dydis. Tada Y = G(X) yra atsitiktinis dydis
# su norima pasiskirstymo funkcija F.

# Pvz., sugeneruosime eksponentinį pasiskirstymo dėsnį turinčių ats. dydžių seką. 
# Tikimybių pasiskirstymo funkcija F(y) = 1 - exp(-lambda*y), o atvirkštinė f-ja
# G(x) = -log(1-x)/lambda. Čia lambda yra pasiskirstymo dėsnio parametras. Tegul

lambda = 0.5

# Tolygiai pasiskirsčiusių atsitiktinių dydžių generavimui naudosime standartinę 
# funkciją runif.

X <- runif(1000)
Y <- -log(1-X)/lambda

# Nubraižome santykinių dažnių histogramą ir teorinę eksponentinio dydžio tankio
# funkciją.

hist(Y, freq = FALSE)
curve(dexp(x, lambda), add = TRUE)


# UŽDUOTIS ------------------------------ 

# 1. Jeigu nenurodomi papildomi parametrai, standartinė funkcija runif generuoja
#    tolygiai intervale [0, 1] pasiskirsčiusį atsitiktinį dydį X. Trumpai rašoma
#    X ~ U(0, 1). Turint dydžių X seką ir naudojant atvirkštinės transformacijos 
#    metodą, sugeneruokite atsitiktinį dydį Y ~ U(-1, 1).
