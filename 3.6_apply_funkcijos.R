
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Matricų ir sąrašų ciklo funkcijos apply, lapply ir sapply.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2013-08-25 | 2013-08-29
#


# TURINYS -------------------------------

#
#   1. Kelios pastabos apie funkcinį programavimą:
#      * trumpai apie duomenis ir ciklus
#
#   2. Matricos ir sąrašo ciklo funkcijos:
#      * funkcija apply
#      * funkcija lapply
#      * funkcija sapply
#


# PASTABOS ------------------------------

#
# Sugalvoti daugiau uždavinių.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuviška lokalė. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# Ištrinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# TRUMPAI APIE DUOMENIS IR CIKLUS         #
# --------------------------------------- #

# Paprastai statistiniai duomenys yra vektoriaus, matricos arba duomenų lentelės
# pavidalo. Visi vektoriaus elementai būtinai yra to paties tipo: arba skaičiai, 
# arba simboliai ir t.t. Kadangi visi matricos elementai yra to paties tipo, tai 
# bet kuri matricos eilutė arba stulpelis taip pat yra vektorius.

v <- c(60, 9, 61, 62, 64, 4, 91, 6, 57, 2, 78, 76, 3, 41, 72, 95, 47, 11, 8, 96)

m <- matrix(v, ncol = 5)
m

class(m)           # m yra matricos tipo objektas
mode(m)            # matrica sudaryta iš skaičių

is.vector(m[1, ])  # pirma matricos eilutė yra vektorius
is.vector(m[, 1])  # pirmas matricos stulpelis taip pat vektorius


# Duomenų lentelės stulpeliai gali būti skirtingų tipų, todėl eilutės elementai
# taip pat bus skirtingų tipų. Dėl tos priežasties viena atskirai paimta duomenų
# lentelės eilutė nėra vektorius, tačiau yra specialaus list tipo sąrašas, kurio 
# elementai gali būti skirtingo tipo.

d <- data.frame(x = 1:5, y = letters[1:5], z = TRUE)
d

class(d)           # duomenų lentelė iš skirtingo tipo vektorių stulpeliuose
mode(d)            # duomenų lentelė sudaryta iš list tipo įrašų eilutėse

# Priklausomai nuo to, kaip interpretuojama duomenų lentelė, yra keli būdai kaip 
# iš lentelės kaip vektorių išskirti vieną jos stulpelį. Bet kokiu atveju reikia
# nurodyti arba kintamojo pavadinimą, arba stulpelio numerį duomenų lentelėje.

d$x                # į duomenų lentelę žiūrim kaip į duomenų lentelę

d[, 1]             # į duomenų lentelę žiūrim kaip į matricą
d[, "x"]           #

d[[1]]             # į duomenų lentelę žiūrim kaip į list tipo sąrašą
d[["x"]]           #


# R turi labai daug standartinių funkcijų skaitinėms vektorių charateristikoms 
# apskaičiuoti:

length(v)          # elementų skaičius
min(v)             # minimumas
max(v)             # maksimumas
sum(v)             # suma
median(v)          # mediana
mean(v)            # vidurkis

# Statistikoje šias ir daug kitų charakteristikų tenka apskaičiuoti matricoms ir
# duomenų lentelėms. Kadangi matrica turi daug stulpelių, o kiekvienas iš jų yra 
# vektorius, tam tikrai vektoriaus charakteristikai apskaičiuoti skirtą funkciją 
# galima įdėti į ciklą ir tokiu būdu ją apskaičiuoti visoms matricos eilutėms ar 
# stulpeliams iš karto.

# Pavyzdžiui, tokiu būdu apskaičiuosime matricos eilučių sumas. Sukursime tuščią
# vektorių, kurio i-ajam elementui priskirsime i-osios eilutės m[i, ] elementų
# sumą. Sumavimas atliekamas cikle, ten ciklo kintamasis i įgyja reikšmes nuo 1 
# iki nrow(m) ir taip "perbėga" per visas matricos eilutes.

eilutės.suma <- vector()

for (i in 1:nrow(m)) {
  eilutė <- m[i, ]
  eilutės.suma[i] <- sum(eilutė)
}

eilutės.suma

# Tokia programa, kurioje detaliai aprašomos visos skaičiavimo instrukcijos, yra 
# tipiškas imperatyvinio programavimo, kurio pagrindas yra kintamasis, pavyzdys. 

# R yra funkcinio programavimo kalba, ir pagal funkcinio programavimo paradigmą
# bet kokie skaičiavimai traktuojami kaip funkcijos (matematine prasme) reikšmės 
# apskaičiavimas, kuri priklauso nuo pradinių duomenų ir kitų funkcijų rezultato.

# Funkcinis programavimas daugeliu dalykų iš esmės skiriasi nuo imperatyvinio 
# programavimo. Pavyzdžiui, grynai funkciniame programavime nėra ciklo sąvokos. 
# Vietoje ciklo iteracijos realizuojamos per rekursiją, kada funkcija iššaukia
# pati save. Dėl tos priežasties, programuojant su R reikia prisiminti taisyklę: 

# JEI KYLA NORAS RAŠYTI FOR CIKLĄ, TAI GREIČIAUSIAI JIS ČIA VISAI NEREIKALINGAS.

# Šiam tikslui R naudojamos apply šeimos funkcijos, kurių aprašymui skirtas šis
# konspektas.


# --------------------------------------- #
# FUNKCIJA APPLY                          #
# --------------------------------------- #

# Daug statistinių skaičiavimų atliekama su matricomis. Jei tam tikrus veiksmus 
# reikia atlikti su visomis matricos eilutėmis ar stulpeliais, ir tuos veiksmus
# galima užrašyti kaip funkciją, tai tokiais atvejais naudojama funkcija apply.
# Jos parametrai:
# 
#        X -- matricos pavadinimas,
#   MARGIN -- indekso reikšmė: eilutėms 1, stulpeliams 2,
#      FUN -- funkcija,
#      ... -- papildomi funkcijos parametrai (jei tokie yra).

# Parametras FUN gali būti bet kokia standartinė R funkcija, kurios argumentas
# yra vektorius. 

# Pavyzdžiui, naudodami funkciją apply apskaičiuosime matricos m eilučių sumas.
apply(m, 1, sum)

# Analogiškai gaunamos matricos stulpelių sumos.
apply(m, 2, sum)

# Funkcijos reikšmė nebūtinai turi būti vienas skaičius. Pavyzdžiui, nurodžius
# funkciją summary, kiekvienai matricos eilutei arba stulpeliui apskaičiuojamos 
# iš karto kelios skaitinės charakteristikos.
apply(m, 2, summary)


# Atliekant specifinius skaičiavimus, nevisada galima rasti tinkamą standartinę 
# R funkciją. Tokiais atvejais tenka sukurti savo funkciją. Tarkime, kad reikia 
# apskaičiuoti mažiausios ir didžiausios vektoriaus reikšmės vidurkį. Konkrečiai 
# tokios funkcijos R neturi, todėl ją užrašysime. 

minmax.vidurkis <- function (x) {
  min <- min(x)
  max <- max(x)
  vid <- (min + max)/2
  return(vid)
}

# Tokią funkciją jau galima įrašyti į funkciją apply.
apply(m, 2, minmax.vidurkis)


# Tą pačią funkciją užrašysime vadovaudamiesi funkcinio programavimo paradigma, 
# pagal kurią vienos funkcijos rezultatas tiesiogiai perduodamas kitai funkcijai.
# Standartinė funkcija range grąžina vektorių su mažiausia ir didžiausia reikšme, 
# kurį be tarpinių kintamųjų perduodame vidurkio skaičiavimo funkcijai mean. 

minmax.vidurkis <- function (x) mean(range(x))

apply(m, 2, minmax.vidurkis)

# Tais atvejais, kai funkciją pavyksta užrašyti labai kompaktiškai, ją galima 
# įrašyti tiesiai į funkciją apply. Toks apply naudojimas yra įprasta praktika
# programuojant su R.

apply(m, 2, function (x) mean(range(x)))

# Čia funkcijos argumentas x yra matricos eilutė, jei apply parametras MARGIN
# lygus 1, arba stulpelis, jei MARGIN reikšmė yra 2.


# Į apply įstatomos funkcijos dažnai pačios turi savo parametrus. Pvz., funkcija
# sum ir daugelis kitų R funkcijų turi parametrą na.rm, kuriam priskyrus reikšmę 
# TRUE, praleistos reikšmės duomenyse ignoruojamos. Tokie papildomi parametrai
# perduodami kaip ... parametras.

u <- c(60, 9, NA, 62, 64, 4, 91, 6, 57, 2, NA, 76, 3, 41, 72, 95, 47, 11, 8, 96)

n <- matrix(u, ncol = 5)
n

# Pavyzdžiui, apskaičiuosime matricos su praleistomis reikšmėmis stulpelių sumas.
# Kadangi pirmame ir trečiame stulpeliuose yra praleistų reikšmių, apskaičiuoto
# sumų vektoriaus pirmas ir trečias elementai taip pat turi praleistas reikšmes.

apply(n, 2, sum)

# Pakeitus funkcijos sum parametro na.rm reikšmę į TRUE, sumos apskaičiuojamos
# visiems matricos stulpeliams (reikia nepamiršti, kad sumos gautos atmetus NA
# reikšmes ir susumavus skirtingą elementų skaičių, todėl nelabai palyginamos).

apply(n, 2, sum, na.rm = TRUE)


# UŽDUOTIS ------------------------------ 

# 1. Naudojant funkciją apply, užrašykite komandą, kuri apskaičiuotų matricos m 
#    stulpelių vidurkį. Užrašykite tokią komandos versiją, kuri apskaičiuotų tik
#    pirmų dviejų stulpelių vidurkius.
# 2. Naudojant f-ją apply, užrašykite komandą, kuri matricos stulpelių elementus 
#    išrikiuotų didėjimo tvarka. Vektoriaus elementų išrikiavimui naudojama f-ja 
#    sort.
# 3. Naudojant f-ją apply, užrašykite komandą, kuri iš skaičių matricos eilučių 
#    išrinktų po du didžiausius elementus. Funkciją dviejų didžiausių vektoriaus 
#    elementų išrinkimui galima užsirašyti atskirai ir įstatyti ją į f-ją apply.
# 4. Naudodami funkciją apply, apskaičiuokite, kiek matricos m stulpeliuose yra
#    elementų, kurių reikšmės didesnės nei 50.


# --------------------------------------- #
# FUNKCIJOS LAPPLY IR SAPPLY              #
# --------------------------------------- #

# Ne visus duomenis galima pateikti matricos pavidalu. Pvz., nevienodą elementų
# skaičių turinčių vektorių negalima apjungti į matricą. Be to, nei vektorius,
# nei matrica negali turėti skirtingo tipo elementų. Tokios struktūros duomenims
# naudojamas list tipo sąrašas. Labai dažnai į sąrašą apjungiami to paties tipo, 
# tačiau gana sudėtingi objektai. Tai gali būti vektorių ar matricų sąrašas, net 
# duomenų lentelių ar dar sudėtingesnių objektų sąrašas.

# Funkcijos apply analogas sąrašams yra funkcijos lapply ir sapply. Pagrindiniai
# jų parametrai:
# 
#        X -- sąrašo pavadinimas,
#      FUN -- funkcija,
#      ... -- papildomi funkcijos parametrai (jei tokie yra).

# Tais atvejais, kai funkcijos FUN reikšmė yra vektorius arba dar sudėtingesnis
# objektas, ir rezultatai turi būti sąrašo pavidalu, naudojama funkcija lapply. 
# Jeigu funkcijos FUN reikšmė yra vienas skaičius, simbolis arba loginė reikšmė, 
# patogiau, kai bendras rezultatas yra vektorius, todėl tokiu atveju naudojama 
# funkcija sapply. Rezultatų pateikimo forma vienintelis šių funkcijų skirtumas.

# Pvz., apskaičiuosime sąrašo, kurį sudaro nevienodą elementų skaičių turintys
# vektoriai, vidurkius.

v1 <- c(11, 21, 38, 32,  7, 41, 14, 10, 32, 19, 42, 28, 33, 38, 5, 17)
v2 <- c(30, 38, 22, 38, 45, 23, 23,  3, 18, 38)
v3 <- c(61, 71, 98, 81, 59, 76, 92, 31, 89, 32, 83, 43)
v4 <- c(81, 95, 74, 61, 27, 73, 60, 72, 50, 32, 79, 32, 10, 74)
v5 <- c(12, 14, 56, 45, 6, 85, 64, 8, 59, 59, 69, 5, 50, 34)


l <- list(Pirmas = v1, Antras = v2, Trečias = v3, Ketvirtas = v4, Penktas = v5)

# Naudojant lapply rezultatas bus sąrašas iš penkių elementų, kurių reikšmės yra
# atskirai kiekvieno vektoriaus vidurkis.
lapply(l, mean)

# Naudojant sapply rezultatas yra penkis elementus turintis vidurkių vektorius.
# Kadangi pradinio sąrašo elementai turi vardus, tai ir rezultatų vektorius taip 
# pat turi elementų vardus.
sapply(l, mean)


# Jei funkcijos FUN rezultatas yra vektorius, tai lapply rezultatas bus sąrašas,
# kurio elementai yra tie vektoriai, o sapply rezultatas bus matrica, kuri turės
# tiek stulpelių, kiek elementų turėjo pradinis sąrašas.

# Pavyzdžiui, naudojant funkciją summary, apskaičiuosime kiekvieno vektoriaus iš 
# sąrašo l pagrindines skaitines charakteristikas. Patogumo dėlei, šių funkcijų 
# rezultatus priskirsime kintamiesiems.

rez.l <- lapply(l, summary)
rez.l

rez.s <- sapply(l, summary)
rez.s

# Paprastai tokių skaičiavimų rezultatai naudojami tolimesnei duomenų analizei,
# kur, priklausomai nuo gautų rezultatų pavidalo (vektorius, matricą ar sąrašas) 
# vėl galima taikyti kurią nors apply šeimos ar kitą funkciją.

# Pavyzdžiui, galima nesunkiai atsakyti į klausimą, kurio vektoriaus minimumas
# didžiausias. Tam reikia surasti didžiausią pirmosios eilutės (Min) elementą.
# Tam panaudosime funkciją which.max.

which.max(rez.s[1, ])


# Funkcijos lapply ir sapply gali būti naudojamos ne tik skaičiavimams, bet ir 
# duomenų pertvarkymams. Pvz., užrašysime komandą, kuri iš kiekvieno vektoriaus 
# išskirs pirmuosius k elementų, k yra mažiausias vektoriaus elementų skaičius.
# Vektoriaus elementų skaičių apskaičiuosime naudojant funkciją length.

sapply(l, length)

# Matome, kad vektorių elementų skaičius nevienodas, vadinasi, pirmiausia reikia
# susirasti mažiausią vektoriaus elementų skaičių. 

k <- min(sapply(l, length))
k

# Vektoriaus elementų išskyrimui sudarysime specialią funkciją, kurią įrašysime
# tiesiai į funkciją lapply.

lapply(l, function(x) x[1:k])


# Funkcinio programavimo apologetai visas komandas apjungtų į vieną išraišką!

lapply(l, "[", 1:min(sapply(l, length)))

# Vektoriaus elementų išskyrimui naudojamas operatorius [, kurį galima panaudoti 
# ir kaip funkciją, kurios parametras yra išskiriamų elementų indeksų vektorius.
# Šiuo atveju tai būtų sveikieji skaičiai nuo 1 iki k.

lapply(l, "[", 1:k)
sapply(l, "[", 1:k)

# Pirmuoju atveju gaunamas sąrašas, kuriame visi vektoriai turi vienodą elementų
# skaičių, antruoju atveju gaunama matrica, kurios stulpeliuose yra vektoriai.


# NAUDINGA ------------------------------

# Nors funkcijos lapply ir sapply skirtos sąrašams, jas lygiai taip pat galima 
# panaudoti pasikartojantiems veiksmams su vektoriais ir duomenų lentelėmis. 

# Pavyzdžiui, sugeneruosime n skirtingų vektorių, kurių elementai yra sveikieji 
# skaičiai nuo 1 iki n. Tam naudosime kaip funkciją užrašytą išraišką 1:n, kur n 
# įgyja reikšmes 1, 2 ir t.t. iki 5. Kadangi visų vektorių elementų skaičius yra
# skirtingas ir į matricą jų apjungti negalima, todėl galutinis rezultatas bus 
# tokių vektorių sąrašas.

lapply(1:5, function(n) 1:n)


# Į funkciją lapply arba sapply įstačius duomenų lentelę, funkcija "perbėga" per
# stulpelius. Pavyzdžiui, naudodami funkciją class, nustatysime duomenų lentelės
# kintamųjų tipą.

sapply(d, class)

# Elementų išskyrimo operatorių [ naudojant kaip funkciją, galima užrašyti tokią
# komandą, kuri į atskirus vektorius išskirtų duomenų lentelės stulpelius.

lapply(d, "[")

# Funkcija complete.cases nustato, ar duomenų lentelės eilutė turi bent vieną
# praleistą reikšmę. Naudojant funkciją sapply, galima užrašyti komandą, kuri
# patikrina, ar lentelės stulpelyje yra bent viena praleista reikšmė.

sapply(d, function(x) any(is.na(x)))


# UŽDUOTIS ------------------------------ 

# 1. Naudojant f-ją sapply, užrašykite išraišką, kuri surastų atskirai kiekvieno
#    vektoriaus iš sąrašo l didžiausią reikšmę. Užrašykite išraišką, kuri rastų 
#    pačią didžiausią visų vektorių reikšmę (bendrą maksimumą iš visų maksimumų).
# 2. Naudojant funkciją sapply, užrašykite išraišką, kuri apskaičiuotų kiekvieno
#    vektoriaus iš sąrašo l elementų kvadratų sumą.
# 3. Užrašykite tokią išraišką, kuri apskaičiuotų, kuris sąrašo l vektorius turi
#    didžiausią skirtumą tarp savo didžiausios ir mažiausios reikšmės. Atsakymas
#    turi būti sąrašo elemento, t.y. vektoriaus numeris.
# 4. Naudojant funkciją sapply, apskaičiuokite, kiek kiekvienas sąrašo vektorius 
#    turi elementų, kurių reikšmės didesnės už 50.
# 5. Naudojant funkciją lapply, užrašykite komandą, kuri iš kiekvieno sąrašo l
#    vektoriaus suformuotų matricą su dviem stulpeliais.
# 6. F-ją lapply pritaikant vektoriui, užrašykite komandą, kuri intervalą [0, 1] 
#    lygiomis dalimis padalina į 10, 20 ir 30 dalių. Intervalą dalinančių taškų
#    sekos generavimui naudokite funkciją seq su parametru length.out.
# 7. Naudojant f-ją sapply patikrinkite, kurie duomenų lentelės d stulpeliai yra
#    numeric tipo. Užrašykite išraišką, kuri suskaičiuotų, kiek tokių stulpelių
#    lentelėje yra iš viso.
