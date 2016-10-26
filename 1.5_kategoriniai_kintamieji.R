
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Kategoriniai kintamieji -- faktoriai.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2013-03-18 | 2013-05-06
#


# TURINYS -------------------------------

# 
#   1. Faktorių sudarymas ir jų sąvybės:
#      * komanda factor
#      * komanda class
#      * komanda mode
#      * komanda levels
#      * komanda nlevels
#      * komanda length
#      * komanda attributes
#      * komanda str
#      * komanda is.ordered
#      * komanda gl
#
#   2. Faktorių reikšmų keitimas:
#      * komanda relevel
#      * komanda droplevels
#      * operatorius [
#      * komanda ordered
#


# PASTABOS ------------------------------

#
# Parašyti apie funkcijos reorder taikymą.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuviška lokalė. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# Ištrinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# FAKTORIAI IR JŲ SAVYBĖS                 #
# --------------------------------------- #

# Programavimo kalboje R faktoriais vadinami vardų arba rangų skalės kintamieji,
# kurie įgyja baigtinį skaičių skirtingų reikšmių. Statistikoje tokie kintamieji
# vadinami kategoriniais. Kategorinių kintamųjų reikšmės dažnai būna užkoduotos 
# simboliais, žodžiais, pavadinimais ar skaičiais. Jei faktorius sudarytas iš 
# vardų skalėje išmatuoto kategorinio kintamojo, tai jo reikšmių išrikiavimas 
# neturi jokios prasmės. Jei tai ranginis kintamasis, tai rango didėjimo tvarka 
# išrikiuotos reikšmės turi tam tikrą prasmę.

# Tokiems kintamiesiems sukurti R naudojama funkcija factor. Jos parametrai:
# 
#        x -- kategorinio kintamojo reikšmių vektorius,
#   levels -- skirtingų kategorinio kintamojo reikšmių vektorius,
#   labels -- kintamojo reikšmių pavadinimų vektorius,
#  ordered -- loginė reikšmė, jei TRUE, tai nurodo, kad kintamasis yra ranginis.


# Turime vektorių, kurio reikšmės nurodo pvz. anketą pildančių žmonių lytį.
# Pagal nutylėjimą galimos faktoriaus reikšmės bus išrikiuotos pagal abėcėlę.

x <- c("Vyras", "Moteris", "Vyras", "Moteris", "Moteris", "Moteris", "Vyras")
f <- factor(x)
f


# Faktorius kaip duomenų struktūra yra specialaus factor tipo.
class(f)

# Nepriklausomai nuo to, kokias reikšmes įgyja kategorinis kintamasis, faktorius
# yra sveikųjų skaičių 1, 2, ... , k vektorius, kur k yra skirtingų kintamojo 
# reikšmių skaičius, o kiekvienam jo nariui priskirtas pavadinimas -- kategorinio 
# kintamojo reikšmė. Todėl funkcija mode nurodo, kad faktoriaus kaip vektoriaus 
# reikšmės yra numeric tipo.

mode(f)


# Kokias skirtingas reikšmes turi kategorinis kintamasis parodo funkcija levels.
levels(f)

# Kiek skirtingų reikšmių turi kategorinis kintamasis parodo funkcija nlevels.
nlevels(f)

# Kaip ir kiekvieno vektoriaus, faktoriaus ilgis reiškia visų jo elementų skaičių.
length(f)


# Faktorius kaip R kintamasis turi keletą pagrindinių atributų: tai yra kintamojo 
# reikšmių vektorius ir faktoriaus kaip duomenų struktūros klasė.
attributes(f)

# Faktoriaus struktūrą galima pamatyti naudojant funkciją str. Matosi, kad faktorius 
# yra tam tikrą skirtingų reikšmių skaičių turintis sveikųjų skaičių vektorius.
str(f)


# Funkcija is.ordered nurodo, ar faktorius yra ranginis kintamasis, šiuo atveju ne.
is.ordered(f)


# Tam tikra iš anksto nustatyta tvarka išdėstytų faktorių seka generuojama su 
# funkcija gl. Jos parametrai:
# 
#       n -- kintamojo įgyjamų reikšmių skaičius,
#       k -- reikšmių pakartojimų skaičius,
#  length -- bendras faktoriaus elementų skaičius,
#  labels -- faktoriaus įgyjamų reikšmių pavadinimų vektorius,
# ordered -- loginis kintamasis, nurodantis ar faktorius yra ranginis.


# Sukursime faktorių turintį dvi kategorijas, kurios pakartotos po penktis kartus.
# Kadangi kategorijų vardai nenurodyti, juos atstoja kategorijų numeriai: 1 ir 2.
g <- gl(n = 2, k = 5)
g

# Galima sukurti dvi periodiškai pasikartojančias kategorijas turintį faktorių.
g <- gl(n = 2, k = 1, length = 10)
g

# Kategorijoms galima suteikti vardus, kurie nebūtinai turi būti žodis ar skaičius.
g <- gl(2, 1, 10, labels = c("Mėsa", "><(((°>"))
g

table(g)


# NAUDINGA ------------------------------

# Tą patį rezultatą galima gauti ir nenaudojant procedūros gl, tačiau komanda 
# gaunasi ne tokia kompaktiška: su funkcija rep generuojame pasikartojančią seką,
# kurią vėliau paverčiame į faktorių ir priskiriame kategorijoms pavadinimus.
g <- rep(1:2, length = 10)
g <- factor(g, labels = c("Mėsa", "><(((°>"))
g


# UŽDUOTIS ------------------------------ 

# 1. Sugeneruokite faktorių h, kuris turėtų po 5 kartus pasikartojančias tris 
#    kategorijas, ir suteikite joms vardus "I lygis", "II lygis" ir "III lygis".
# 2. Faktorių h su tokiais pat kategorijų pavadinimais sudarykite naudodami 
#    funkcijas rep ir factor.
# 3. Sugeneruokite faktorių d, kuris reikštų visas vieno mėnesio savaitės dienas.
#    Tarkime, kad mėnuo turi 30 dienų, o savaitės dienas pradedame skaičiuoti nuo
#    pirmadienio. Savaitės dienoms suteikite pilnus vardus.


# --------------------------------------- #
# FAKTORIŲ REIKŠMIŲ KEITIMAS              #
# --------------------------------------- #

# Išvedant faktorių į ekraną, užrašomi visi skirtingi kintamojo reikšmių variantai 
# (levels). Jei kategorinis kintamasis buvo užrašytas kaip tekstinių arba simbolinių 
# reikšmių vektorius, tai faktoriuje tos reikšmės bus išrikiuotos abėcėlės tvarka, 
# jei kintamojo reikšmių vektorius buvo iš skaičių -- tada išrikiuotos jų didėjimo 
# tvarka. Tačiau tokia tvarka dar nereiškia, kad faktorius yra ranginis kintamasis!

# Faktoriaus visų galimų reikšmių vektorių ir jo elementų išdėstymo tvarką parodo 
# funkcija levels. Pavyzdžiui, kintamojo reikšmės "Moteris" ir "Vyras" yra tekstinės,
# todėl pagal nutylėjimą faktoriuje jos išrikiuotos pagal abėcėlę.
levels(f)


# Naudojant funkciją levels, jau sukurto faktoriaus įgyjamų reikšmių vektorių galima 
# pervadinti. Čia svarbu išlaikyti tą pačią reikšmių tvarką: ("Moteris", "Vyras"), o
# naujas reikšmių vektorius gali būti pvz., ("Mot", "Vyr"), ("M", "V") ar panašiai.

levels(f) <- c("Mot", "Vyr")
levels(f)
f


# Su funkcija levels atliekamas faktoriaus įgyjamų reikšmių išdėstymo pakeitimas 
# yra nekorektiškas! Pavyzdžiui, pakeitus faktoriaus reikšmių "Moteris" ir "Vyras" 
# išdėstymo tvarką, į priešingas pasikeičia ir visų faktoriaus reikšmių prasmės!
# Padarius tokią klaidą, visos statistinės išvados apie kintamąjį bus neteisingos.

levels(f) <- c("Vyras", "Moteris")
levels(f)
f


# Pagal nutylėjimą abėcėlės tvarka išdėstytą kategorinio kintamojo įgyjamų reikšmių 
# vektorių galima pakeisti faktoriaus sudarymo metu nurodant reikiamą tų reikšmių 
# išdėstymo vektorių levels. 

f <- factor(x, levels = c("Vyras", "Moteris"))
levels(f)
f

# Kartu su vektoriumi levels nurodžius jį atitinkantį vektorių labels, faktoriaus
# sudarymo metu kategorinio kintamojo įgyjamas reikšmes galima pervadinti. 

f <- factor(x, levels = c("Vyras", "Moteris"), labels = c("Vyr", "Mot"))
levels(f)
f


# Tuo atveju, kai reikia nustatyti arba pakeisti bazinę (reference) jau sudaryto 
# faktoriaus reikšmę, naudojama funkcija relevel. Čia reikšmę "Mot" vėl padarysime 
# bazine.

f <- relevel(f, ref = "Mot")
levels(f)
f


# NAUDINGA ------------------------------

# Gana dažnai pasitaiko situacija, kad dėl patogumo kategorinio kintamojo reikšmės 
# koduojamos skaičiais. Pavyzdžiui, įvedus pažymėjimą "Vyras" = 0, "Moteris" = 1, 
# tą patį vektorių x buvo galima užrašyti taip: (0, 1, 0, 1, 1, 1, 0). Sudarant 
# faktorių, tų kodų reikšmes galima atstatyti užrašant pavadinimų vektorių labels.

z <- c(0, 1, 0, 1, 1, 1, 0)
f <- factor(z, levels = c(0, 1), labels = c("Vyras", "Moteris"))
f


# UŽDUOTIS ------------------------------ 

# 1. Tarkime, kad vektoriaus c(1, -1, 0, -1, -1, 1, -1, 0, 1, 1, -1, 0, 1, 1, 0) 
#    reikšmės reiškia atsakymus į testo klausimus. Sudarykite faktorių a ir jo 
#    reikšmėms priskirkite tokius pavadinimus: 1 = Taip, -1 = Ne ir 0 = Nežinau.
# 2. Naudodami funkciją levels, pakeiskite anksčiau sugeneruoto faktoriaus h 
#    įgyjamų reikšmių vardus į "Pirmas", "Antras", "Trečias".
# 3. Naudodami funkciją factor, pakeiskite jau sudaryto faktoriaus h įgyjamų 
#    reikšmių tvarką į priešingą: "Trečias", "Antras", "Pirmas".


# Kartais kategorinis kintamasis įgyja tik dalį visų galimų reikšmių. Tokiu atveju
# galima sudaryti faktorių, kurio galimų reikšmių vektorius levels bus didesnis, 
# nei atitinkamo kategorinio kintamojo reikšmių aibė. 

# Pavyzdžiui, turime apklausoje dalyvaujančių gyventojų miestų vektorių.
m <- c("Vilnius", "Vilnius", "Kaunas", "Vilnius", "Kaunas", "Vilnius", "Kaunas")

# Jei tyrimas buvo atliekamas apklausiant didžiųjų miestų gyventojus, nepriklausomai
# nuo to, kokias reikšmes įgijo kintamojo elementai, galimos kintamojo reikšmės 
# yra "Vilnius", "Kaunas" ir "Klaipėda". Sukuriame faktorių su tokiomis reikšmėmis.

f <- factor(m, levels = c("Vilnius", "Kaunas", "Klaipėda"))
f

# Nors kategorinis kintamasis turi dvi skirtingas reikšmes, tačiau iš jo sudarytas
# faktorius iš viso turi tris galimas reikšmes.

unique(f)   # visos skirtingos faktoriaus reikšmės
nlevels(f)  # viso galimos faktoriaus reikšmės


# Sudarant tokio kintamojo dažnių lentelę, bus įtraukiamos ir tos reikšmės, kurių
# kintamajame nepasitaikė. Tokiu būdu dažnių lentelė sudaroma ne iš tų reikšmių,
# kurias įgijo kintamasis, bet iš tų, kurias galėjo įgyti -- kartais tai svarbu.

table(m)    # pradinio kintamojo dažnių lentelė    --   dvi reikšmės
table(f)    # kategorinio kintamojo dažnių lentelė -- visos reikšmės


# Tuo atveju, kai nenaudojamos faktoriaus reikšmės yra nereikalingos, jas galima
# pašalinti naudojant funkciją droplevels. Pvz., iš faktoriaus f pašalinsime 
# nenaudojamą kintamojo kategoriją "Klaipėda", bet pats kintamasis nepasikeis.

f <- droplevels(f)
nlevels(f)
f


# Kadangi faktorius tuo pačiu yra ir vektorius, iš jo galima išskirti tam tikrus
# elementus. Tokiu būdu gautas faktorius nebūtinai turi turėti visas pradines
# kintamojo reikšmes, todėl kai kurios faktoriaus reikšmės taip pat gali būti 
# nereikalingos. Reikšmių iš faktoriaus išskyrimui naudojant operatorių [, yra
# galimybė per parametrą drop pašalinti nereikalingas kintamojo kategorijas.

# Atskiru atveju, nenurodžius faktoriaus indeksų aibės, gausime tą patį faktorių, 
# tačiau be nenaudojamų kategorijų.

f <- f[ , drop = TRUE]
nlevels(f)
f


# UŽDUOTIS ------------------------------ 

# 1. Naudodami funkciją factor, jau sudarytam faktoriui f pridėkite anksčiau 
#    pašalintą kategoriją "Klaipėda".
# 2. Naudodami operatorių [, iš faktoriaus f išskirkite tik tuos elementus, kurie 
#    atitinka reikšmę "Vilnius". Pašalinkite neegzistuojančias naujo faktoriaus 
#    kategorijas "Kaunas" ir "Klaipėda".
# 3. Iš faktoriaus d į naują faktorių išskirkite darbo dienas ir pašalinkite 
#    nebereikalingas savaitgalio dienas atitinkančias reikšmes.


# Jei kategorinis kintamasis yra ranginis, tai jo reikšmes galima išrikiuoti rango
# didėjimo tvarka ir sudaryti ordered tipo faktorių. Pavyzdžiui, pagal nutylėjimą
# faktoriaus reikšmės išrikiuojamos abėcėlės tvarka, kuri šiuo atveju nenatūrali.

y <- c("Pirmas", "Trečias", "Antras", "Trečias", "Pirmas", "Pirmas", "Antras")
r <- factor(y)
r

# Sukurdami faktorių galime išrašyti reikšmes jų didėjimo tvarka ir nurodyti, kad
# jos sudaro tam tikrą rangų sistemą.

r <- factor(y, levels = c("Trečias", "Antras", "Pirmas"), ordered = TRUE)
r


# Tokį patį ranginį kintamąjį galima sudaryti naudojant funkciją ordered.
# Nenurodžius reikšmių išdėstymo tvarkos, jos bus išrikiuotos pagal abėcėlę.
r <- ordered(y, levels = c("Trečias", "Antras", "Pirmas"))
r

# Taip sudarytas faktorius yra ranginis kintamasis, kurio reikšmės turi tvarką.
is.ordered(r)


# UŽDUOTIS ------------------------------ 

# 1. Faktoriaus a reikšmes išrikiuokite tokia tvarka: "Ne", "Nežinau", "Taip" ir 
#    sukurkite naują ranginį kintamąjį -- faktorių t.
# 2. Iš faktoriaus t išskirkite tik reikšmes "Ne", "Taip" ir taip sukurkite naują
#    ranginį kintamąjį.


# NAUDINGA ------------------------------

# Kartais faktoriai panaudojami gana įdomiose situacijose. Pvz., funkcija cut 
# tolydų kintamąjį suskaido į tam tikrus intervalus. Rezultatas yra tokio pat 
# ilgio vektorius, kur vietoj pradinio vektoriaus reikšmės yra intervalas, į 
# kurį ta reikšmė patenka.

# Sugeneruosime 100 standartinių normaliųjų dydžių ir suskirstysime į vienodo 
# pločio intervalus (-3, -2], (-2, -1], ... (2, 3]. Suskaičiuosime, kiek reikšmių 
# patenka į šiuos intervalus.

r <- rnorm(100)
t <- cut(r, breaks = -3:3)
t

# Toks kintamasis yra kategorinis, o visas jo reikšmes gauname su komanda levels.
class(t)
levels(t)

# Sudarome duomenų lentelę, kurioje pirmas kintamasis yra anksčiau sunegeneruotas
# skaičius, o antrasis kintamasis nurodo intervalą, į kurį tas skaičius patenka.
m <- data.frame(skaičius = r, intervalas = t)
head(m)

# Suskaičiuodami skirtingus intervalus, sužinome, po kiek reikšmių patenka į 
# kiekvieną intervalą. Gautą dažnių lentelę galima atvaizduoti kaip histogramą.
table(t)
plot(t)
