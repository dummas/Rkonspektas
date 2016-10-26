
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Matricų sudarymas ir pagrindinės jų savybės.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2012-09-03 | 2013-05-06
#


# TURINYS -------------------------------

# 
#   1. Matricų sudarymas ir jų sąvybės:
#      * komanda matrix
#      * komanda mode 
#      * komanda class
#      * komanda dim
#      * komanda length
#      * komanda nrow ir ncol 
#      * komanda rownames ir colnames
#      * komanda dimnames
#      * operatorius [
#
#   2. Vektorių ir matricų apjungimas:
#      * komanda cbind
#      * komanda rbind 
#


# PASTABOS ------------------------------

#
# Ateityje pridėti skyrelį apie array duomenų struktūrą.
# Pastaba apie vieną dimensiją turinčio masyvo dimensijos panaikinimą su drop.
# Pridėti skyrelį apie funkciją str kintamojo struktūrai nustatyti.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuviška lokalė. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# Ištrinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# MATRICŲ SUDARYMAS                       #
# --------------------------------------- #

# R kalboje matrica yra dvimatis masyvas, kurio visos reikšmės yra vienodo tipo. 
# Matricos sudarymui naudojama funkcija matrix. Jos parametrai:
# 
#     data -- vektorius, kurio reikšmėmis užpildoma matrica,
#     nrow -- matricos eilučių skaičius,
#     ncol -- matricos stulpelių skaičius,
#    byrow -- pagal nutylėjimą FALSE, matrica užpildoma stulpeliais,
# dimnames -- eilučių ir stulpelių vardų sąrašas.


# Pirmiausia nurodome matricos reikšmių vektorių. Antras parametras yra eilučių 
# ir tada stulpelių skaičius. Pagal nutylėjimą reikšmės išdėstomos stulpeliais.

x <- 1:10
m <- matrix(data = x, nrow = 5, ncol = 2)
m

# Pakeitus parametro byrow reikšmę į TRUE, tą patį reikšmių vektorių matricoje 
# galima išdėlioti eilutėse.

m <- matrix(data = x, nrow = 5, ncol = 2, byrow = TRUE)
m

# Jei argumentai užrašomi ta pačia tvarka, parametrų pavadinimų galima nerašyti.
m <- matrix(x, 5, 2)
m

# Kadangi vektoriaus ilgis fiksuotas, tai iš jo sudarytą matricą pilnai galima
# nusakyti vien tik eilučių arba vien tik stulpelių skaičiumi. Bet nevisada!

matrix(x, nrow = 5)
matrix(x, ncol = 2)

# Jei matricos reikšmių vektorius per trumpas ir jo elementų neužtenka užpildyti 
# visai matricai, jis cikliškai pakartojamas. Šią savybę galima panaudoti sudarant 
# matricą, sudaryta iš vienodų reikšmių. Pvz., sudarysime 10 eilučių ir 3 stulpelių 
# matricą, kurios visi elementai lygūs nuliui.

y <- 0
n <- matrix(y, nrow = 10, ncol = 3)
n

# Matrica gali būti sudaryta iš bet kokio tipo vienodų reikšmių: skaičių, simbolių,
# loginių reikšmių ir t.t. Pvz., sudarysime matricą iš mėnesių pavadinimų.

y <- month.name
n <- matrix(y, ncol = 2)
n


# UŽDUOTIS ------------------------------ 

# 1. Užrašykite kiek įmanoma trumpesnę komandą, kuri sudarytų matricą iš 10 eilučių 
#    ir 2 stulpelių, kur visi pirmo stulpelio nariai lygūs 1, o antrojo lygus 2.
# 2. Sukurkite antros eilės kvadratinę matricą sudarytą iš praleistų reikšmių.


# Kaip ir vektoriaus, visi matricos elementai yra to paties tipo. Jį parodo funkcija 
# mode.

mode(x)     # vektoriaus elementų tipas 
mode(m)     # matricos elementų tipas

# Kintamojo klasė parodo, kokio tipo duomenų struktūrą sudaro kintamojo elementai.
# Kintamojo, kurio reikšmė yra vektorius, klasė sutampa su to vektoriaus reikšmių
# tipu (numeric, integer, character ir t.t.). Kintamojo, kurio reikšmė yra matrica, 
# klasė yra matrix.

class(x)    # kintamasis x yra (skaitinio tipo) vektorius
class(m)    # kintamasis m yra matrica

# Matrica nuo vektoriaus (iš kurio ji gali būti sudaryta) iš esmės skiriasi tuo, 
# kad matrica turi dimensijos atributą, šiuo atveju tai yra eilučių ir stulpelių 
# skaičius. 
attributes(m)

# Matricos dimensijos nustatymui naudojama funkcija dim. Pirmas gauto vektoriaus 
# skaičius yra matricos eilučių skaičius, antrasis -- stulpelių skaičius. 
dim(m)

# Matricos dimensiją, kaip ir bet kurį kitą atributą, galima pakeisti. Pvz., matricą
# galima paversti į matricą-eilutę. Tačiau tokia matrica-eilutė nėra vektorius!
dim(m) <- c(1, 10)
m

# Matricos dimensiją galima panaikinti, tada matrica pavirsta į vektorių, kurio 
# elementai išrikiuoti pagal stulpelius.
dim(m) <- NULL
m

# Kad vektorius nuo matricos skiriasi tik dimensija, galima nesunkiai parodyti.
# Naudodami funkciją dim, vektoriui m priskirkime dimensiją. Taip pakeistas 
# vektorius vėl bus matrica.
dim(m) <- c(5, 2)
m

# Matricos elementų skaičiui apskaičiuoti naudojama ta pati funkcija length.
length(m)

# Matricos eilučių ir stulpelių skaičiui surasti naudojamos funkcijos nrow ir ncol.
nrow(m)
ncol(m)

# Matricos eilučių ir stulpelių pavadinimams nustatyti ar pakeisti naudojamos 
# funkcijos rownames ir colnames. Pavyzdžiui., matricos stulpelius pavadinsime X 
# ir Y, o eilutes -- mažosiomis abėcėlės raidėmis.

rownames(m) <- letters[1:5]
colnames(m) <- c("X", "Y")
m

rownames(m)
colnames(m)

# Eilučių arba stulpelių vardus galima pakeisti arba ir visai panaikinti. 
rownames(m) <- NULL
m

# Funkcija dimnames naudojama iš karto abiejų dimensijų vardams parodyti ar jiems 
# pakeisti. Šios funkcijos rezultatas yra sąrašas, kurio pirmas elementas yra 
# eilučių vardų vektorius, o antras -- stulpelių vardų vektorius.
dimnames(m)
m


# UŽDUOTIS ------------------------------ 

# 1. Naudojant funkciją dim parašykite tokią komandą, kuri transponuotų matricą.


# Bet kuris matricos elementas pasiekiamas nurodant eilutės ir stulpelio numerį.
m[1, 1]

# Kaip ir vektoriams, galima nurodyti matricos eilučių ir stulpelių indeksų aibę.
# Pvz., iš matricos m išskirsime pirmas dvi eilutes ir pirmus du stulpelius.
i <- c(1, 2)
j <- c(1, 2)
m[i, j]

# Tokią pat indeksų aibę galima nurodyti ir labai kompaktišku pavidalu.
m[1:2, 1:2]


# Iš matricos galima išskirti bet kurią pasirinktą eilutę ar stulpelį.
i <- 2
m[i, ]  # taip gaunama i-oji matricos eilutė, trumpiau taip: m[2, ]

j <- 1
m[, j]  # taip išskiriamas j-asis stulpelis,  trumpiau taip: m[, 1]

# Galima išskirti kelias matricos eilutes ar stulpelius, pvz., pirmas 3 eilutes.
i <- c(1, 2, 3)
m[i, ]

# Jei matricos eilutės arba stulpeliai turi vardus, juos galima panaudoti nurodant
# konkrečias eilutes arba stulpelius.
m[, "Y"]


# UŽDUOTIS ------------------------------ 

# 1. Užrašykite komandą, kuri matricos m stulpelius sukeistų vietomis.
# 2. Užrašykite komandą, kuri išskirtų pirmus tris Y stulpelio elementus.
# 3. Užrašykite komandą, kuri iš matricos m išskirtų nelyginius pirmo stulpelio
#    narius išdėstytus mažėjančia tvarka.


# --------------------------------------- #
# VEKTORIŲ IR MATRICŲ APJUNGIMAS          #
# --------------------------------------- #

# Jei vektorių apjungimui į vektorių naudojama funkcija c, tai vektorių ir matricų 
# apjungimui į matricą naudojamos komandos cbind ir rbind. Funkcija cbind vektorius
# sujungia kaip matricos stulpelius, funkcija rbind -- kaip eilutes.

x <- c(2.6, 4.8, 6.3,  8.1, 11.0, 13.0, 14.2, 16.8, 18.4, 20.2, 22.4, 24.2)
y <- c(3.5, 2.9, 6.2, 18.9, 31.5, 14.1, 26.9, 32.6, 35.3, 28.3, 40.5, 46.0)


# Vektorius x ir y apjungiame į matricą su dviem stulpeliais. Gauname matricą, 
# kurios stulpelių pavadinimai sutampa su vektorių vardais.
m <- cbind(x, y)
m

dim(m)
colnames(m)

# Panašiai, kaip vektoriaus elementams, vardus matricos stulpeliams galima suteikti
# matricos sudarymo metu.
m <- cbind(X = x, Y = y)
m

dim(m)
colnames(m)

# Naudojant funkciją rbind, tuos pačius vektorius x ir y apjungiame į matricą su 
# dviem eilutėmis, kurioms suteikiami nauji vardai.
d <- rbind(A = x, B = y)
d

dim(d)
rownames(d)

# Jei apjungiamų vektorių ilgis nesutampa, trumpesnis yra cikliškai pratęsiamas.
cbind(1, 1:10) 

# Su funkcijomis cbind ir rbind galima apjungti ne tik vektorius, bet ir kitas 
# matricas. Atkreipkite dėmesį -- stulpelių vardai gali kartotis! Tokiu atveju 
# stulpelį parenkant pagal vardą, bus išrenkamas pirmas pasikartojantį vardą 
# turintis stulpelis, bet ne visi.

cbind(m, m)


# UŽDUOTIS ------------------------------ 

# 1. Naudojant cbind parašykite kiek įmanomą trumpesnę komandą, kuri sukurtų 10 
#    eilučių matricą, kurios pirmojo stulpelio visi elementai būtų lygūs 1, 
#    antrojo lygūs 2 ir trečiojo -- 3.
# 2. Užrašykite komandą, kuri iš vektorių x ir y sudarytų matricą iš 4 nesikartojančių 
#    stulpelių.
