
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Funkcijų užrašymas.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2013-08-16 | 2013-09-01
#


# TURINYS -------------------------------

#
#   1. Išraiškos ir išraiškų blokai:
#      * skliaustai {}
#
#   2. Naujų funkcijų užrašymas:
#      * komanda function
#      * komanda return
#      * funkcija source
#      * funkcija body 
#
#   3. Sąlygų funkcijose tikrinimas:
#      * komanda stop
#      * komanda stopifnot
#      * komanda message
#      * komanda warning
#


# PASTABOS ------------------------------

#
# Sugalvoti uždavinių apie atskirus duomenų analizės etapus.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuviška lokalė. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# Ištrinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# IŠRAIŠKOS IR IŠRAIŠKŲ BLOKAI            #
# --------------------------------------- #

# R programavimo kalboje objektui sukurti naudojami veiksmai vadinami išraiška.
# Išraiškos susideda iš aritmetinių (+, *, ^) arba loginių (!, &, |) operatorių
# ir kitų objektų: konstantų, kintamųjų, funkcijų ir jų rezultatų. Pateiksime 
# keletą išraiškų su standartinėmis R konstantomis ir funkcijomis:

!TRUE

56 + 67

sin(3*pi/2)

exp(pi * 1i)

cat("Skaičius pi:", pi, "\n")

# Sudėtingi skaičiavimai paprastai išskaidomi į keletą etapų -- vienos išraiškos 
# rezultatas priskiriamas kintamajam, kuris vėliau naudojamas kitoje išraiškoje.
# Pvz., sukursime sveikųjų skaičių vektorių ir apskaičiuosime jo elementų sumą.

v <- 1:10
s <- sum(v)
s

# Keletą iš eilės einančių išraiškų riestiniais skliaustais {} galima apjungti į 
# bloką. Tokį bloką galima interpretuoti kaip dar vieną išraišką, kurios reikšmė
# yra paskutinės bloko viduje esančios išraiškos rezultatas.

# Pavyzdžiui, užrašysime išraiškų bloką, kuriame sukuriamas sveikųjų skaičių nuo
# 1 iki 10 vektorius, o tada suskaičiuojama to vektoriaus elementų suma. Kadangi
# gauta reikšmė niekam nepriskiriama, ji kaip bloko reikšmė išvedama į konsolę.

{
  v <- 1:10
  sum(v)
}

# Kintamajam priskirta paskutinės išraiškos reikšmė tuo pačiu yra ir viso bloko
# reikšmė. Į konsolę ji neišvedama, tačiau ją galima naudoti kitose išraiškose. 

{
  v <- 1:10
  s <- sum(v)
}

# Kaip ir bet kurios išraiškos reikšmę, bloko grąžinamą reikšmę galima priskirti 
# kintamajam.

b <- {
  v <- 1:10
  s <- sum(v)
}

# Matome, kad bloko reikšmė sutampa su paskutinės išraiškos reikšme.
b

# Bloko viduje sukuriami tarpiniai kintamieji yra savarankiški objektai, kuriuos
# galima naudoti kituose skaičiavimuose. Pavyzdžiui, išvesime į konsolę tarpinį 
# bloko kintamąjį v.

v     # pirmos išraiškos rezultatas 
s     # antros išraiškos rezultatas


# NAUDINGA ------------------------------

# R programavimo kalboje naudojami dviejų rūšių skliaustai: ( ) ir { }. Griežtai
# kalbant, R skliaustai traktuojami kaip funkcijos. Išraiška (x) yra ekvivalenti 
# funkcijai f(x) = x. Kadangi funkcijos reikšmė automatiškai išvedama į konsolę,
# tai skliaustuose įrašytos išraiškos reikšmė taip pat išvedama į konsolę.

# Šią savybę galima išnaudoti. Pvz., priskyrimo operaciją įrašius į skliaustus, 
# gauta reikšmė išvedama į konsolę net nenurodžius kintamojo, kuriam ši reikšmė 
# priskiriama, vardo.

(a <- 2 + 2)

# Paprasti skliaustai naudojami aritmetinėms ar loginėms operacijoms apskliausti, 
# juose nurodomi visų funkcijų argumentai. Tačiau () skliaustuose galima įrašyti 
# tik vieną išraišką.

# Riestiniai {} skliaustai naudojami keletos išraiškų apjungimui. Paprastai tai 
# reikalinga konstrukcijoje if-else, ciklo funkcijose for, while arba repeat ir 
# užrašant funkcijas. Skliaustuose {} įrašytos išraiškos rezultatas išvedamas į
# konsolę tik tada, jei jis nepriskiriamas kintamajam. 

# Tušti riestiniai skliaustai prilygsta NULL objektui.

a <- {}
a

# Laužtiniai skliaustai [ ar [[ naudojami kaip operatoriai vektoriaus, matricos 
# arba sąrašo elementų indeksams užrašyti. Pvz., iš didžiųjų raidžių vektoriaus 
# išskirsime 18-tą jo elementą.

LETTERS[18]


# --------------------------------------- #
# FUNKCIJOS UŽRAŠYMAS                     #
# --------------------------------------- #

# R turi visas pagrindines matematines funkcijas bei daug standartinių funkcijų 
# skirtų statistinei duomenų analizei ir kitiems skaičiavimams. Dažnai duomenis
# tenka pertvarkyti, vieną po kito atlikti kelis veiksmus arba pritaikyti kelias
# skirtingas funkcijas. Tokiais atvejais kelias išraiškas galima užrašyti kaip  
# funkciją. Bendras funkcijos pavidalas yra toks:
#
#   funkcijos.vardas <- function(arg1, arg2, ...) {
#     
#   }

# Funkcijos vardas yra kintamasis, kuriam priskirta pati funkcija. Bet kuri R 
# funkcija yra "function" tipo objektas. Tai reiškia, kad kintamajam priskirta 
# reikšmė gali būti funkcija, o funkcijos reikšmė kaip argumentas gali būti 
# perduota kitai funkcijai. Taip galima išvengti tarpinių kintamųjų ir užrašyti 
# labai kompaktiškas komandas. R yra funkcinio programavimo kalba, ir todėl toks
# programavimo stilius yra labai natūralus.

# Funkcija gali turėti vieną ar daugiau argumentų, arba neturėti visai. Reikšmės 
# argumentams priskiriamos naudojant = ženklą. Pagrindinę funkcijos dalį sudaro 
# viena arba kelios riestiniuose skliaustuose į bloką apjungtos išraiškos.

# Pavyzdžiui, užrašysime paprastą funkciją, kuri apskaičiuotų sveikųjų skaičių 
# nuo m iki n suma. Skaičiai m ir n bus šios funkcijos argumentai. Funkcija turi 
# dvi išraiškas: pirmoji sukuria sveikųjų skaičių vektorių, antroji suranda šio 
# vektoriaus elementų sumą.

seq.suma <- function(m, n) {

    v <- m:n
    sum(v)
}

# Galima įsitikinti, kad nauja funkcija yra "function" tipo objektas. 
class(seq.suma)

# Jei nurodomi funkcijos argumentų pavadinimai, reikšmes jiems priskirti galima 
# bet kokia tvarka.
seq.suma(m = 1, n = 10)
seq.suma(n = 10, m = 1)

# Jei argumentai surašomi nustatyta tvarka, jų pavadinimus galima praleisti.
seq.suma(1, 10)

# Funkcijos argumentai gali turėti numatytas reikšmes. Pvz., sumavimo funkciją 
# pakeisime taip, kad, nurodžius tik vieną argumentą, būtų sumuojami sveikieji 
# skaičiai nuo 1 iki n. Čia argumentas m turės numatytą reikšmę lygią 1.

seq.suma <- function(n, m = 1) {

    v <- m:n
    sum(v)
}

# Dabar užtenka nurodyti tik vieną argumentą n, kurio vardo galima ir nerašyti.
seq.suma(10)

# Jei reikia, numatytą argumento reikšmę galima pakeisti.
seq.suma(n = 10, m = 5) 

# Funkcija grąžina paskutinės jos išraiškos reikšmę. Jei ši reikšmė priskiriama
# kintamajam, papildomai reikia nurodyti, kurio kintamojo reikšmę grąžinti. Tam 
# naudojama komanda return. Pvz., vektoriaus elementų sumą priskyrus kintamajam 
# s, reikia nurodyti, kad funkcija grąžina tą kintamąjį.

seq.suma <- function(m, n) {

    v <- m:n
    s <- sum(v)

    return(s)
}

# Funkcija gali grąžinti bet kokį objektą. Pavyzdžiui, pakeisime funkciją taip,
# kad jos rezultatas būtų sąrašas iš trijų elementų: pirmas ir paskutinis sekos
# nariai ir sekos suma.

seq.suma <- function(m, n) {

    v <- m:n
    s <- sum(v)

    return(list(pirmas = m, paskutinis = n, suma = s))
}

seq.suma(1, 10)

# Atsisakius tarpinių kintamųjų, funkcijos viduje lieka tik viena išraiška, tad
# riestinių skliaustų galima ir neberašyti. Tokiu būdu funkciją užrašome labai 
# kompaktiškai.

seq.suma <- function(m, n) sum(m:n)

# Kaip ir kiti R objektai, funkcijos reikšmė gali būti priskirta kintamajam arba 
# kaip argumentas perduota dar kitai funkcijai. Pvz., sumavimo funkciją įdėsime 
# į procedūrą cat, kuri iš funkcijos argumentų ir jos rezultato suformuos sakinį 
# ir išves jį į konsolę.
m = 10
n = 99

cat("Skaičių nuo", m, "iki", n, "suma lygi", seq.suma(m, n), "\n")


# NAUDINGA ------------------------------

# Didelės apimties, įvairias pagalbines ar keliose skirtingose programose dažnai 
# naudojamas funkcijas galima įrašyti į atskirą tekstinį failą. Dėl to programos 
# tekstas pasidaro kompaktiškesnis, lengviau skaitomas. Labai svarbu ir tai, kad 
# pakoregavus funkciją, visose ją naudojančiose programose bus naudojama ta pati
# jos versija. Funkcijos ar visos programos kodo nuskaitymui iš tekstinio failo 
# naudojama procedūra source.

# Pavyzdžiui, iš internete patalpinto failo importuosime funkciją visi.dalikliai, 
# kuri suranda visus natūrinio skaičiaus daliklius.

adresas <- "http://fmf.vgtu.lt/~trekasius/Rkonspektas/funkcijos/divisors.R"
source(file = adresas)

# Funkcijos vardas be argumentų išveda visą funkcijos kodą į konsolę. Tokiu būdu 
# galima pamatyti nežinomos funkcijos argumentus ir viduje esančias išraiškas.
visi.dalikliai

# Nežinomos funkcijos viduje esančias išraiškas į konsolę išveda funkcija body.
body(visi.dalikliai)

# Vienintelis šios funkcijos argumentas yra natūrinis skaičius, o jos rezultatas 
# yra visų to skaičiaus daliklių vektorius.
visi.dalikliai(666)


# UŽDUOTIS ------------------------------ 

# 1. Užrašykite funkciją Fibonačio skaičių sekos sudarymui. Pirmas ir antras jos 
#    nariai lygūs 1, o kiekvienas sekantis narys lygus dviejų paskutinių sumai. 
#    Šios funkcijos argumentas yra sekos narių skaičius n, n > 0, o rezultatas
#    yra n elementų turintis vektorius.
# 2. Užrašykite funkciją sveikojo skaičiaus iš dvejetainės skaičiavimo sistemos 
#    pervedimui į dešimtainę. Funkcijos argumentas -- vektorius, kurio elementų
#    reikšmės 0 arba 1. Pavyzdžiui, jei argumentas yra vektorius c(1, 1, 0, 1),
#    rezultatas yra 13, jeigu argumentas c(1, 1, 1), tai rezultatas turi būti 7.
# 3. Tegu s yra n elementų turintis simbolių arba skaičių vektorius. Užrašykite 
#    funkciją, kuri surastų visas slenkančias k elementų dydžio sekas. Pvz., jei
#    s = c("A", "B", "C", "D"), o k = 3, tai funkcijos rezultatas yra vektoriai
#    c("A", "B", "C") ir c("B", "C", "D"). Gautas i-asis vektorius priskiriamas
#    i-ajam sąrašo elementui ir galutinis rezultatas yra tokių vektorių sąrašas.
 

# --------------------------------------- #
# KOREKTIŠKŲ FUNKCIJŲ RAŠYMAS             #
# --------------------------------------- #

# Funkcijos turi būti užrašytos taip, kad suveiktų korektiškai ir nekorektiškose
# situacijose. Tas labai svarbu dirbant su realiais duomenimis, kuriuose kartais
# būna praleistų reikšmių. Kadangi veiksmų su NA reikšmėmis rezultatas taip pat 
# yra NA reikšmė, negalima atlikti tam tikrų skaičiavimų. Kartais skaičiavimus
# tenka nutraukti nes duomenys netenkina tam tikrų specifinių sąlygų, pvz., per
# maža imtis, per daug išsiskiriančių stebinių ir t.t. 

# Nekorektiškos situacijos atveju išraiškos vykdymas nutraukiamas naudojant f-ją
# stop. Paprastai ši funkcija naudojama kartu su sąlygos konstrukcija if-else.

# Pavyzdžiui, užrašysime funkciją f(x) = 1/x. Prieš atliekant skaičiavimus, bus
# patikrinama, ar x nelygus 0. Jei taip, skaičiavimai nutraukiami.

fx.a <- function (x) {
  if (x == 0) stop("x negali būti lygus 0.")

  y <- 1/x
  return(y)
}

fx.a(5)
fx.a(0)


# Prieš atliekant skaičiavimus kartais tenka patikrinti, ar f-jos argumentai yra 
# tam tikro tipo. Pavyzdžiui, užrašysime funkciją, kurios argumentas gali būti 
# tik vektorius (bet kokio tipo), priešingu atveju skaičiavimai neatliekami.

fx.b <- function (x) {
  if (!is.vector(x)) stop("x nėra vektorius.")

  y <- length(x)
  names(y) <- "Elementų skaičius"
  return(y)
}

fx.b(100:150)
fx.b(letters)


# Kartais funkcijos darbas turi būti nutraukiamas jei netenkinama bent viena iš
# keletos loginių sąlygų. Šių sąlygų patikrinimui galima naudoti keletą funkcijų 
# if, tačiau paprasčiau naudoti tam skirtą funkciją stopifnot. Jos parametrai:
#
#    stopifnot(sąlyga1, sąlyga2, ...)

# Jei visų loginių sąlygų reikšmė yra TRUE, funkcija grąžina NULL reikšmę. Jeigu
# bent vienos sąlygos reikšmė nėra TRUE, suvykdoma funkcija stop, ir į konsolę 
# išvedamas pranešimas apie pirmą ne TRUE reikšmę turinčią sąlygą (jei tokių yra
# ne viena).

# Pavyzdžiui, užrašysime funkciją, kurios argumentas turi būti ne mažiau kaip 10
# reikšmių turintis skaitinis vektorius be praleistų reikšmių.

fx.s <- function(x) {

  stopifnot(is.vector(x), is.numeric(x), length(x) >= 10, all(!is.na(x)))

  y <- mean(x)
  names(y) <- "Vidurkis"
  return(y)
}

x <- c(10.5, 14.2, 3.1)
y <- c(10.7, 10.4, 9.9, NA, 7, 13.8, 9.6, 9.1, 7.9, 9.4)
z <- c(11.5, 13.3, 8.2, 10, 9, 12.8, 8.6, 8.1, 7.9, 9.2)

fx.s(x)
fx.s(y)
fx.s(z)

# Kartais reikia, kad funkcija tam tikrais skaičiavimo etapais išvestų pranešimą
# apie atliekamus veiksmus. Tam naudojama funkcija message. Jos parametrai:
#
#        ... -- vienas ar keli kintamieji, kurių reikšmė yra tekstas,
#   appendLF -- TRUE, nurodo, kad kitas pranešimas bus naujoje eilutėje.

# Pavyzdžiui, anksčiau užrašytą funkciją papildysime informaciniais pranešimais 
# apie sąlygų duomenims tikrinimą ir skaičiavimų etapo pradžią.

fx.m <- function(x) {

  message("Tikrinamos sąlygos ... ", appendLF = FALSE)
  stopifnot(is.vector(x), is.numeric(x), length(x) >= 10, all(!is.na(x)))
  message("atlikta.")

  message("Atliekami skaičiavimai.")
  y <- mean(x)
  names(y) <- "Vidurkis"

  return(y)
}

fx.m(x)
fx.m(y)
fx.m(z)

# Ne visi pranešimai turi vienodą svarbą. Įvairiems perspėjimams naudojama f-ją
# warning. Jos parametrai:
#
#        ... -- vienas ar keli kintamieji, kurių reikšmė yra tekstas,
#      call. -- TRUE, pranešime nurodoma išraiška, kurioje įvyko klaida,
# immediate. -- FALSE, nurodo, kad pranešimas būtų išvedamas iš karto.

# Pavyzdžiui, funkciją perrašysime taip, kad skaičiavimai dėl praleistų reikšmių 
# duomenyse nebus nutraukiami. Sąlyga dėl praleistų reikšmių tikrinama atskirai,
# ir, jei tokių reikšmių yra, skaičiavimai atliekami, bet išvedamas perspėjimas.

fx.w <- function(x) {

  stopifnot(is.vector(x), is.numeric(x), length(x) >= 10)
  if (any(is.na(x))) warning("Duomenyse yra praleistų reikšmių.", call. = FALSE)

  y <- mean(x, na.rm = TRUE)
  names(y) <- "Vidurkis"

  return(y)
}

fx.w(x)
fx.w(y)
fx.w(z)


# NAUDINGA ------------------------------

# Tarkime, kad kintamasis n turi būti sveikųjų skaičių 1, 2, 3, 4 ir 5 vektorius. 
# Tokį vektorių galima užrašyti keliais skirtingais būdais, tačiau ne visi iš jų
# yra tinkami.

n.1 <- c(1.0, 2.0, 3.0, 4.0, 5.0)
is.integer(n.1)

n.2 <- c(1, 2, 3, 4, 5)
is.integer(n.2)

n.3 <- c(1L, 2L, 3L, 4L, 5L)
is.integer(n.3)

n.4 <- seq(from = 1, to = 5, by = 1)
is.integer(n.4)

n.5 <- seq(from = 1, to = 5)
is.integer(n.5)

n.6 <- 1:5
is.integer(n.6)

# Galima parodyti, kad funkcijai, kurios argumentas turi būti sveikasis skaičius,
# tinka ne visi iš šių vektorių.

fx.n <- function(x) {
  stopifnot(is.integer(x))

  message("Duomenys tinkami!")
}

fx.n(n.2)
fx.n(n.6)

# Iš šių pavyzdžių aišku, kad iš esmės geri duomenys gali būti atmesti vien tik 
# dėl netinkamo kintamojo tipo. Norint užtikrinti, kad skaičiavimuose naudojami
# reikiamo tipo kintamieji, kartais funkcijos argumentai iš anksto konvertuojami.
# Tam naudojamos funkcijos as.numeric, as.character, as.vector, as.matrix ir t.t.

fx.k <- function(x) {
  x <- as.integer(x)

  message("Duomenys tinkami!")
}

fx.k(n.2)
fx.k(n.6)


# UŽDUOTIS ------------------------------ 

# 1. Užrašykite funkciją, kuri apskaičiuoja skaičių vektoriaus elementų sandaugą. 
#    Naudojant funkciją stop, nutraukite skaičiavimus, jei bent vienas elementas
#    lygus nuliui.
# 2. Naudodami f-ją stopifnot, užrašykite išraišką, kuri patikrina ar kintamasis 
#    x yra neneigiamų skaičių vektorius.
# 3. Naudodami funkciją stopifnot, patikrinkite, ar funkcijos argumentas yra 3x3
#    dydžio skaičių matrica be praleistų reikšmių.
