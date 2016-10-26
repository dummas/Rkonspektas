
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Funkcijos perskaičiavimas keičiant ir nekeičiant parametrų.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2013-08-29 | 2013-09-07
#


# TURINYS -------------------------------

#
#   1. Ciklas per funkcijos parametrų vektorių:
#      * funkcija mapply
#
#   2. Funkcijų ir kitų išraiškų pakartojimas:
#      * funkcija replicate
#


# PASTABOS ------------------------------

#
# Pastabų nėra.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuviška lokalė. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# Ištrinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# FUNKCIJA MAPPLY                         #
# --------------------------------------- #

# Funkcijos apply, lapply arba sapply perbėga per duomenų rinkinio elementus ir 
# kaip argumentus juos perduoda kitai funkcijai. Tas duomenų rinkinys gali būti
# ir funkcijos kokio nors vieno parametro reikšmių vektorius. Tokiu būdu galima
# reguliuoti funkcijos veikimą.

# Pavyzdžiui, užrašysime funkciją, kuri kiekvieną vektoriaus elementą pakartoja 
# po k kartų. Čia parametras k yra sveikasis skaičius, kurio reikšmė kinta nuo 1 
# iki m = 4.

m <- 4
w <- c("A", "B", "C")

sapply(1:m, function(k) rep(w, each = k))


# Tuo atveju, kai funkcijai reikia perduoti iš karto kelių parametrų reikšmes, 
# naudojama funkcija mapply. Jos parametrai:
#
#      FUN -- funkcijos pavadinimas arba išraiška,
#      ... -- funkcijai perduodami parametrai,
# MoreArgs -- nekintančių funkcijos parametrų sąrašas.

# Pavyzdžiui, naudodami standartinę funkciją seq, intervalą [0, 1] padalinsime į 
# 10, 50 ir 100 vienodų dalių. Taškų, kurių reikia intervalą padalinti į k lygių
# dalių, yra k + 1, o jų skaičių nusako funkcijos seq parametras length.out. Čia
# parametrų from ir to reikšmės fiksuotos, nes dalinamas tas pats intervalas. 

mapply(seq, from = 0, to = 1, length.out = c(11, 51, 101))

# Nekintančius funkcijos parametrus ar jai reikalingus duomenis galima perduoti
# per parametrą MoreArgs. Pavyzdžiui, perrašysime tą pačią funkciją taip, kad
# fiksuoti parametrai from ir to būtų perduodami atskiru sąrašu.

mapply(seq, length.out = c(11, 51, 101), MoreArgs = list(from = 0, to = 1))

# Šiuo atveju keičiasi tik vieno parametro reikšmė, todėl funkcija mapply nėra
# pilnai išnaudojama. Pvz., tą patį rezultatą galima gauti naudojant sapply.

sapply(c(11, 51, 101), function(k) seq(0, 1, length.out = k))


# Užrašysime paprastą funkciją, kuri iš ilgos simbolių sekos iškarpo trumpesnes
# sekas. Šios f-jos argumentai yra trumpesnių sekų pradžios ir pabaigos indeksų
# vektoriai. Kadangi funkcijos duomenys - ilgoji seka - nesikeičia, ją įrašome į
# fiksuotų parametrų sąrašą MoreArgs. Galutinis rezultatas yra kelių trumpesnių 
# sekų sąrašas.

s <- c("G", "C", "T", "T", "T", "T", "C", "A", "T", "T", "C", "T", "G", "A", "C")

a <- c(1, 5, 8)
b <- c(7, 10, 15)

mapply(function(seka, i, j) seka[i:j], i = a, j = b, MoreArgs = list(seka = s))

# Jei tokia funkcija skirta visada tos pačios sekos karpymui, jos vardą galima 
# įrašyti tiesiai į funkciją ir tokiu būdu atsisakyti vieno parametro.

mapply(function(i, j) s[i:j], i = a, j = b)


# NAUDINGA ------------------------------

# Funkcija mapply dažnai naudojama atsitiktinių dydžių su skirtingais skirstinio
# parametrais generavimui. Pavyzdžiui, normalusis ats. dydis turi du parametrus: 
# vidurkį ir standartinį nuokrypį. Tokio dydžio generavimui naudojama funkcija
# rnorm, kuri turi tris parametrus: imties tūrį n, vidurkį mean ir std. nuokrypį 
# sd. Sugeneruosime tris normaliasias imtis, kurios skiriasi abiem parametrais. 

vid <- c(A = 9, B = 5, C = 1)    # ats. dydžio vidurkių vektorius
std <- c(a = 1, b = 2, c = 3)    # standartinių nuokrypių vektorius

# Užrašome funkciją, kuri turi du parametrus - vidurkio ir nuokrypių vektorius.
# Imties tūris įrašytas tiesiai į funkciją. Galutinis rezultatas yra matrica su
# sugeneruotomis imtimis stulpeliuose, kurią priskirsim kintamajam.

rnd <- mapply(function(m, s) rnorm(20, mean = m, sd = s), m = vid, s = std)
rnd

# Kaip ir kitose funkcijose, jei parametrai rašomi nustatyta tvarka, jų vardų 
# galima nerašyti visai. Taip funkcijos išraiška tampa trumpesnė ir aiškesnė.

rnd <- mapply(function(m, s) rnorm(20, m, s), vid, std)
rnd


# Šią funkciją galima supaprastinti, generavimo funkcijai parametrus perduodant
# tiesiogiai.

rnd <- mapply(rnorm, n = 20, mean = vid, sd = std)
rnd

# Nerašant parametrų vardų, gaunama labai kompaktiška išraiška!

rnd <- mapply(rnorm, 20, vid, std)
rnd


# Gautas atsitiktinių dydžių imtis galima perduoti įvairioms kitoms funkcijoms.
# Pvz., apskaičiuosime imčių vidurkius ir nubraižysime jų sklaidos grafikus.

apply(rnd, 2, mean)
boxplot(rnd)


# UŽDUOTIS ------------------------------ 

# 1. Derinių skaičiui apskaičiuoti naudojama R funkcija choose. Naudodami mapply, 
#    užrašykite funkciją iš karto keletos derinių skaičiaus radimui, kai dydžiai
#    n ir k yra keletą reikšmių turintys vektoriai. Pavyzdžiui, tegu n = (5, 10), 
#    o k = (2, 3). Šiuo atveju reikia gauti derinių skaičių iš 5 po 2 ir derinių
#    skaičių iš 10 po 3.
# 2. Siekiant eliminuoti išsiskiriančių stebinių įtaką, vietoje vidurkio kartais
#    skaičiuojamas nukirstas vidurkis (truncated mean). Tai vidurkis skaičiuotas
#    imčiai, iš kurios atmesta k*100% didžiausių ir mažiausių reikšmių. Vidurkio
#    funkcija mean turi tam skirtą parametrą trim, reikšmė iš intervalo [0, 0.5]. 
#    Naudojant mapply, užrašykite funkciją, kuri apskaičiuotų 0.10, 0.15, 0.20 
#    lygio "nukirstus" vidurkius. Tokią pačią funkciją užrašykite su f-ja sapply.
# 3. Naudodami funkciją mapply, sugeneruokite tris tolygiai intervaluose [0, 1], 
#    [0, 5] ir [-1, 1] pasiskirsčiusių dydžių imtis po 100 elementų kiekvienoje. 
#    Tolygų pasiskirstymą turinčio ats. dydžio generavimui naudojama standartinė 
#    funkcija runif.


# --------------------------------------- #
# FUNKCIJA REPLICATE                      #
# --------------------------------------- #

# Atliekant tikimybinį modeliavimą, eksperimentą labai dažnai reikia pakartoti 
# daug kartų. Tokiais atvejais galima naudoti funkciją replicate. Jos parametrai:
#
#        n -- pakartojimų skaičius,
#     expr -- funkcija ar bet kokia kita išraiška, kurią reikia pakartoti,
# simplify -- loginis parametras nurodantis, kad rezultatas turi būti vektorius.

# Pavyzdžiui, sumodeliuosime n = 10 normaliųjų imčių po 50 elementų kiekvienoje. 
# Tegul atsitiktinio dydžio vidurkis lygus 20, o standartinis nuokrypis lygus 5.
# Rezultatas yra matrica, kurios stulpeliuose yra ats. dydžių imtys.

replicate(10, rnorm(50, mean = 20, sd = 5))

# Parametro simplify reikšmę pakeitus į FALSE, vietoje matricos gaunamas sąrašas, 
# kurio elementai yra atsitiktinių dydžių imtys.

replicate(10, rnorm(50, 20, 5), simplify = F)

# Kaip visada, tokį sąrašą galima perduoti kitoms skaičiavimų funkcijoms. Pvz.,
# apskaičiuosime tokių sugeneruotų imčių vidurkius. Pirmu atveju naudosime f-ją
# apply ir skaičiuosime vidurkius stulpeliuose, antru atveju naudosime funkciją
# sapply.

apply(replicate(10, rnorm(50, 20, 5)), 2, mean)

sapply(replicate(10, rnorm(50, 20, 5), simplify = F), mean)


# Pavyzdžiui, sumodeliuosime monetos mėtymo eksperimentą, kur moneta metama 1000
# kartų. Atliksime 10 tokių eksperimentų ir apskaičiuosime, kiek vienos serijos
# metu atsivertė herbų ir skaičių.

# Vienos monetos mėtymo eksperimentą galima užrašyti naudojant funkciją sample.
sample(c("H", "S"), 1000, replace = TRUE)

# Šią išraišką įstačius į funkciją replicate, gaunama 1000 x 10 dydžio matrica, 
# kurios stulpeliuose yra bandymų serijos.
replicate(10, sample(c("H", "S"), 1000, TRUE))

# Naudojant funkciją apply, kiekvienam eksperimentų matricos stulpeliui sudaroma 
# herbų ir skaičių dažnių lentelė. Galima pastebėti, kad herbų ir skaičių dažnis
# apytiksliai lygus, koks ir turi būti mėtant simetrišką monetą.
apply(replicate(10, sample(c("H", "S"), 1000, TRUE)), 2, table)


# Žinoma, funkciją replicate naudojama ne tik atsitiktinių dydžių generavimui ar 
# tikimybiniam modeliavimui. Pavyzdžiui, sudarysime 10x10 dydžio matricą, kurios 
# pirmos eilutės elementai lygūs 1, antros lygūs 2 ir t.t. Visi tokios matricos 
# stulpeliai yra vienodi, todėl reikia sugeneruoti 10 vienodų vektorių, kurių
# elementai kinta nuo 1 iki 10. 

replicate(10, 1:10)


# UŽDUOTIS ------------------------------ 

# 1. Naudojant f-jas replicate ir sample, sudarykite 10 atsitiktinių kodų sąrašą. 
#    Vienas kodas gaunamas iš vektoriaus LETTERS atsitiktine tvarka išrenkant po
#    tris raides ir, naudojant f-ją paste su parametru collapse = "", apjungiant
#    jas į vieną simbolių seką.
# 2. Naudodami funkciją replicate, sugeneruokite tris tolygiai intervale [0, 10]
#    pasiskirsčiusio atsitiktinio dydžio imtis po n = 100 elementų. Sugalvokite, 
#    kaip tokias imtis gauti nenaudojant funkcijos replicate.
