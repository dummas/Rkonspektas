
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Įvairūs kintamųjų išvedimo į ekraną būdai.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2013-07-25 | 2013-07-26 | 2014-02-22
#


# TURINYS -------------------------------

#
#   1. Kintamųjų išvedimas:
#      * procedūra cat
#      * procedūra print
#
#   2. Kintamųjų struktūros užrašymas:
#      * funkcija dput
#      * funkcija dget
#      * funkcija dump
#      * funkcija source
#


# PASTABOS ------------------------------

#
# Parašyti apie funkcijas sink ir capture.output.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuviška lokalė. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# Ištrinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# KINTAMŲJŲ IŠVEDIMAS Į EKRANĄ            #
# --------------------------------------- #

# Pats paprasčiausias būdas pamatyti vektoriaus, matricos arba bet kokio kito R 
# kintamojo reikšmę -- išvesti į ekraną. Tam konsolėje reikia parašyti kintamojo
# vardą ir paspausti klavišą Enter. Rašant programą į failą (skriptą), kintamojo
# reikšmė į ekraną išvedama paspaudus ant jo klavišą F5. Pavyzdžiui, taip galima 
# pamatyti standartinio R kintamojo konstantos pi reikšmę.
pi

# Rašant programą ir atliekant skaičiavimus, rezultatus tenka išvesti tam tikru
# pavidalu. Pvz., "Kintamojo pi reikšmė yra 3.141593". Šiuo atveju tekstą reikia
# apjungti su kintamojo pi reikšme. Tokiu atveju rezultato išvedimui į ekraną
# naudojama procedūra cat. Jos parametrai:
#
#     ... -- R kintamasis: vektorius arba matrica,
#    file -- kabutėse užrašomas duomenų failo vardas arba kelias iki failo,
#     sep -- simbolis, kuriuo atskiriami objektai,
#    fill -- pagal nutylėjimą FALSE, nurodo kaip užpildomos eilutės,
#  labels -- character tipo vektorius su eilučių vardais,
#  append -- jei TRUE, vektoriaus reikšmės įrašomos į jau esantį failą.

# Pagal nutylėjimą parametro file reikšmė yra tuščios kabutės, todėl rezultatas
# išvedamas į konsolę. Nurodžius failo vardą, rezultatas bus išvedamas į failą
# darbiniame kataloge. 

# Vietoje parametro ... rašomi kintamųjų vardai, kurie vienas nuo kito atskiriami 
# kableliu. Taip pat kabutėse galima rašyti tekstą, kuris bus prijungtas prie kitų
# kintamųjų.

# Pačiu paprasčiausiu atveju procedūra cat kintamojo reikšmę išveda į konsolę.
cat(pi)

# Kad kursorius po rezultato išvedimo konsolėje būtų perkeliamas į kitą eilutę, 
# procedūrai papildomai perduodame eilutės galo simbolį \n.
cat(pi, "\n")


# Užrašysime komandą, kuri išveda tekstą "Kintamojo pi reikšmė yra 3.141593". Jį 
# galima suskaidyti į tris sudėtines dalis: tekstą, kintamąjį pi ir kursoriaus 
# perkėlimo į kitą eilutę simbolį \n. Juos reikia apjungti. Sudarome atitinkamus 
# kintamuosius ir perduodame juos procedūrai.

txt <- "Apytikslė skaičiaus pi reikšmė yra"
var <- pi
new <- "\n"

cat(txt, var, new)

# Kad būtų paprasčiau, tokias nesudėtingas komandas galima apjungti į vieną.
cat("Apytikslė skaičiaus pi reikšmė yra", pi, "\n")


# NAUDINGA ------------------------------

# Procedūrą cat galima panaudoti nesudėtingų duomenų rinkinių išvedimui į failą.
# Tam reikia nurodyti failo vardą arba pilną kelią iki failo.
cat(pi, file = "test.dat")

# Pagal nutylėjimą kintamojo reikšmės atskiriamos tarpu, todėl faile surašomos į
# vieną eilutę.
v <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
cat(v, file = "test.dat")

# Nurodžius, kad kintamojo reikšmės bus atskirtos eilutės galo simboliu \n, jos 
# faile bus surašomos po vieną į vieną eilutę.
cat(v, file = "test.dat", sep = "\n")


# UŽDUOTIS ------------------------------ 

# 1. Tegu kintamasis k lygus 3, o kintamasis n lygus 8. Naudodami procedūrą cat,
#    užrašykite komandą, kuri į konsolę išvestų tekstą "Atlikta: 3 iš 8".
# 2. Naudodami procedūrą cat, užrašykite komandą, kuri į ekraną išveda tekstą: 
#    "Data: 2013-07-26". Datą parodo standartinė R funkcija Sys.Date(). 
# 3. Naudodami procedūrą cat, sukurkite tekstinį failą, kurio pirma eilutė yra 
#    užkomentuota simboliu #, už jo įrašyta data ir laikas, antra eilutė tuščia, 
#    trečioje eilutėje skaičiai 1, 2 ir 3. Datą ir laiką parodo funkcija date().
#    Tokį failą galima sukurti su viena komanda, bet naudojant parametrą append 
#    visas tris eilutes į tą patį failą galima įrašyti atskirai vieną po kitos.


# Sudėtingesnių kintamųjų, pvz., dažnių lentelės, išvedimui naudojama procedūra 
# print. Jos parametrai priklauso nuo kintamojo klasės, pagrindiniai yra tokie:
#
#          x -- R kintamasis,
#      quote -- jei TRUE, tai tekstas išvedamas kabutėse,
#     digits -- reikšminių skaitmenų skaičius, pagal nutylėjimą 7,
#   na.print -- simbolis, kuris spausdinamas vietoje praleistos reikšmės,
# zero.print -- simbolis, kuris spausdinamas vietoj nulio dažnių lentelėje.

# Jei vektorius turi praleistų reikšmių, jos žymimos ir ekrane matomos kaip NA. 
v <- c(0, 1, 2, 3, NA, 5, NA, 7, 8, 9)
v

# Be papildomų nustatymų procedūra print vektorių su praleistomis reikšmėmis 
# išveda tokį, koks jis ir yra.
print(v)

# Kartais praleistas reikšmes NA galima pakeisti kitu simboliu, pvz., brūkšniu, 
# arba ir visai nespausdinti.
print(v, na.print = "-")


# Jei vektoriaus reikšmės yra simboliai, žodžiai arba jų junginiai, jie rašomi 
# kabutėse ir į ekraną taip pat išvedami kabutėse.
t <- c("A", "B", "C", "D")
t

print(t)

# Parametro quote reikšmę pakeitus į FALSE, character tipo vektoriaus reikšmės į
# ekraną bus išvedamos be kabučių.
print(t, quote = FALSE)


# Keičiant parametro digits reikšmę, galima keisti į ekraną išvedamų reikšminių
# skaitmenų skaičių.

print(pi)
print(pi, digits = 1)
print(pi, digits = 3)
print(pi, digits = 5)


# Parametras zero.print gali būti naudingas, kai į ekraną išvedama "reta" dažnių
# lentelė, kuri turi daug nulinių reikšmių ir kurios vizualiai trukdo įžvelgti
# kitas lentelės reikšmes. Tokiu atveju galima nurodyti, kad vietoje nulio būtų
# atspausdinamas koks nors kitas simbolis.

# Sukursime testinę dažnių lentelę iš automobilių greičio ir stabdymo atstumo
# duomenų rinkinio cars.
cars

# Gaunama gana didelė dažnių lentelė, tačiau didžioji dauguma jos reikšmių yra 
# nuliai ir pastebėti nenulines reikšmes sunku.
l <- table(cars)
l

# Vietoje nulio galima atspausdinti tašką, ir vaizdas pasidaro žymiai geresnis.
print(l, zero.print = ".")


# UŽDUOTIS ------------------------------ 

# 1. Naudodami procedūrą print, vektorių v išveskite į ekraną taip, kad vietoje
#    praleistų reikšmių būtų tuščias tarpas.
# 2. Duomenų lentelėje co2 yra 1959-1997 metų duomenys apie CO2 koncentraciją.
#    Naudodami procedūrą print, išveskite duomenis į ekraną taip, kad matavimų
#    reikšmės būtų sveiki skaičiai.


# --------------------------------------- #
# KINTAMŲJŲ STRUKTŪROS UŽRAŠYMAS          #
# --------------------------------------- #

# Dažnai vektoriai, matricos arba kitos duomenų struktūros sukuriamos užrašant
# tam tikrą komandą. Pvz., vieno tipo reikšmės į vektorių apjungiamos naudojant 
# komandą c.
v <- c(1, 2, 3, 4, 5, 6)
v

# Naudojant komandą matrix iš vektoriaus v sukursime 2x3 dydžio matricą.
m <- matrix(v, nrow = 2, ncol = 3)
m

# Duomenų lentelę galima sukurti naudojant komandą data.frame.
d <- data.frame(var = c("a", "b", "c"), ats = c("taip", "ne", "nežinau"))
d

# Kartais iškyla atvirkštinis uždavinys -- turint vektorių, matricą arba duomenų
# lentelę reikia užrašyti tą duomenų struktūrą sukuriančią komandą. Tam naudojama 
# funkcija dput. Pagrindiniai jos parametrai:
#
#       x -- R kintamasis,
#    file -- failo, į kurį išvedama kintamąjį sukurianti komanda, vardas,
# control -- kintamojo struktūros detalumo parametras, "all", NULL.

# Pagal nutylėjimą parametro file reikšmė yra "", todėl nenurodžius failo vardo, 
# funkcijos dput rezultatas automatiškai išvedamas į konsolę (ekraną). Kintamojo
# struktūros detalumą nusako parametras control. Pagal nutylėjimą jo reikšmė yra 
# "all", todėl kintamojo struktūra atstatoma kiek įmanoma tiksliau. Norint gauti
# minimalią kintamojo struktūrą, parametrui control galima nurodyti reikšmę NULL.

# Tekstinio pavidalo kintamojo struktūrą galima nukopijuoti, pataisyti, perkelti 
# į kitą programą ir taip atkartoti kintamąjį.


# Kadangi vektorius -- labai paprasta duomenų struktūra, ją sukurianti komanda 
# taip pat yra nesudėtinga.
dput(v)

# Matrica m nuo vektoriaus v skiriasi tuo, kad turi eilučių ir stulpelių skaičių
# nusakantį atributą (dimensiją).
dput(m)

# Į konsolę išvedama komanda, kurią suvykdžius gaunama tokia pati matrica.
n <- structure(c(1, 2, 3, 4, 5, 6), .Dim = 2:3)
n

# Duomenų lentelės struktūra žymiai sudėtingesnė. Kiekviena data.frame kintamojo
# eilutė yra sąrašas, o stulpeliai yra vektoriai, kurie gali būti skirtingo tipo.
# Taip pat lentelė turi eilučių numerius ir stulpelių pavadinimus.
dput(d)

# Į konsolę išvedamas toks data.frame tipo kintamojo struktūrą aprašantis kodas.

structure(list(var = structure(1:3, .Label = c("a", "b", "c"), class = "factor"), 
    ats = structure(c(3L, 1L, 2L), .Label = c("ne", "nežinau", 
    "taip"), class = "factor")), .Names = c("var", "ats"), row.names = c(NA, 
-3L), class = "data.frame")

# Esminė šios lentelės dalis yra du kategoriniai kintamieji var ir ats, kurių
# reikšmes galima sutapatinti su sveikais skaičiais. Tokią minimalią kintamojo
# struktūrą galima gauti parametrui control nurodę reikšmę NULL.
dput(d, control = NULL)


# Kintamojo struktūros kodą galima išsaugoti tekstiniame faile.
dput(d, file = "duom.dmp")

# Kintamasis atkuriamas naudojant funkciją dget, kuriai nurodomas failo vardas.
# Iš failo nuskaityta struktūra paverčiama į kintamąjį ir išvedama į konsolę.
dget(file = "duom.dmp")

# Funkcijos dget rezultatą galima priskirti kitam kintamajam. Pvz., nuskaitysime
# failą "duom.dmp" ir sukursime naują duomenų lentelę b.
b <- dget(file = "duom.dmp")
b


# Panašiu būdu tekstinį kintamojo pavidalą galima gauti naudojant fukciją dump. 
# Pagrindiniai jos parametrai:
#
#    list -- character tipo kintamųjų vardų vektorius,
#    file -- failo, į kurį išvedama kintamąjį sukurianti komanda, vardas,
# control -- kintamojo struktūros detalumo parametras, "all", NULL,
#  append -- jei TRUE, vektoriaus reikšmės įrašomos į jau esantį failą.

# Parametrui file nurodžius failo vardą, darbiniame kataloge sukuriamas R script 
# failas, kurį suvykdžius gaunami list vektoriuje nurodyti kintamieji.


# Pavyzdžiui, į konsolę išvesime kintamojo v kodą.
dump(list = "v", file = "")

# Tokiu būdu galima gauti iš karto kelių kintamųjų kodą.
dump(list = c("v", "m"), file = "")


# Sukursime keletos kintamųjų script failą. 
dump(list = c("v", "m"), file = "dump.R")

# Naudojant funkciją source tokį failą galima suvykdyti ir atkurti jame įrašytus 
# kintamuosius.
source(file = "dump.R")


# UŽDUOTIS ------------------------------ 

# 1. Naudodami funkciją dput, sukurkite duomenų lentelės cars struktūros kodą.
#    Nukopijuokite iš jo tą dalį, kuri atitinka kintamąjį speed ir naudodami ją 
#    sukurkite naują vektorių s.
# 2. Darbiniame kataloge sukurkite tekstinį failą "vector.R", jo viduje įrašykite
#    komandą, kuri sukuria bet kokį skaičių vektorių. Naudodami funkciją source
#    nuskaitykite šį failą.
