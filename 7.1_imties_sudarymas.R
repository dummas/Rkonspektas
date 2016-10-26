
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Atsitiktinės imties sudarymas naudojant procedūrą sample.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2013-03-25 | 2013-04-17 | 2015-09-20
#


# TURINYS -------------------------------

#
#   1. Atsitiktinės imties iš vektoriaus elementų išrinkimas:
#      * funkcija sample
#      * funkcija set.seed
#
#   2. Tikimybinių eksperimentų modeliavimas:
#      * Bernulio bandymų schema
#


# PASTABOS ------------------------------

#
# Kol kas pastabų nėra.
#


# NUSTATYMAI ----------------------------

# Nustatoma lietuviška lokalė. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# Ištrinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# ATSITIKTINĖS IMTIES IŠRINKIMAS          #
# --------------------------------------- #

# Atsitiktinės imties iš vektoriaus elementų sudarymui naudojama komanda sample.
# Jos parametrai:
#
#          x -- vektorius, iš kurio renkamos imties reikšmės,
#       size -- iš vektoriaus x išrenkamų elementų skaičius, 
#    replace -- loginis kintamasis, nurodo, ar išrinkimas su pasikartojimais,
#       prob -- išrenkamų elementų tikimybės, pagal nutylėjimą jos vienodos.


# Pvz., iš 5 elementus turinčios aibės x = {1, 2, 3, 4, 5} atsitiktine tvarka su 
# vienodomis tikimybėmis reikia išrinkti 3 elementus. Sudarysime tokį vektorių x, 
# kurio elementų reikšmes sutapatinsime su aibės elementų numeriais.

x <- 1:5
n <- 3
sample(x, size = n)

# Kaip visada, jei procedūros parametrai užrašomi numatyta tvarka, jų pavadinimų 
# galima nerašyti -- komanda bus šiek tiek trumpesnė ir kompaktiškesnė.

sample(x, n)


# Funkcijai sample nurodžius tik reikšmių vektorių x, imtis bus sudaryta iš visų
# atsitiktine tvarka išdėstytų vektoriaus elementų -- gaunamas jo perstatinys.

x <- 1:5
sample(x)

# Jei parametro x reikšmė yra ne vektorius, bet vienas natūrinis skaičius m, tai 
# imtis bus renkama iš vektoriaus (1, 2, ..., m) elementų.

m <- 5
n <- 3
sample(m, n)


# Naudojant R procedūrą sample, pagal nutylėjimą sudaroma paprastoji atsitiktinė 
# negrąžintinė imtis, todėl imties elementai nesikartoja. Jeigu imties elementai 
# gali kartotis arba išrenkamų elementų skaičius didesnis už vektoriaus elementų 
# skaičių, loginio parametro replace reikšmė pakeičiama į TRUE.

sample(x, n, replace = TRUE)


# Pagal nutylėjimą visų vektoriaus elementų išrinkimo tikimybės vienodos, tačiau 
# jas galima pakeisti; parametrui prob priskiriamas elementų išrinkimo tikimybių 
# vektorius. Tikimybių vektoriaus elementų skaičius turi sutapti su vektoriaus x 
# elementų skaičiumi, o tikimybių suma turi būti lygi vienetui. 

# Pvz., sudarysime imtį iš aibės x = {1, 2, 3, 4, 5} rinkdami k = 1000 elementų. 
# Kadangi visų aibės elementų išrinkimo į imtį tikimybės vienodos ir lygios 1/5, 
# tokiu būdu sudarytoje imtyje jų skaičius turėtų būti maždaug vienodas ir lygus
# apie 200.

n <- 1000

imtis <- sample(x, n, replace = TRUE)
table(imtis)
barplot(table(imtis))

# Pavyzdžiui, išrinkimo tikimybes pakeisime taip, kad pirmas ir paskutinis aibės
# elementai būtų išrenkami su tikimybe 0.1, antras ir ketvirtas su tikimybe 0.2, 
# o trečias --- su tikimybe 0.4. Tai reiškia, kad gautoje imtyje trečio elemento 
# turėtų būti apie 400, antro ir ketvirto apie 200, o pirmo ir paskutinio po 100.

n <- 1000
p <- c(0.1, 0.2, 0.4, 0.2, 0.1)

imtis <- sample(x, n, replace = TRUE, prob = p)
table(imtis)


# NAUDINGA ------------------------------

# Visiems atsitiktinių dydžių generatoriams galima nurodyti pradinę generuojamos
# sekos reikšmę, kuri vadinama seed. Su ta pačia seed reikšme gaunama tokia pati 
# skaičių seka. Suprantama, kad atsitiktinių dydžių seka, kurią galima atkartoti,
# nėra atsitiktinė, todėl tokiu būdu gauti dydžiai vadinami pseudoatsitiktiniais.
# Šią generatorių savybę galima naudoti tuo atveju, kai reikia visiškai tiksliai 
# atkartoti tikimybinio modeliavimo eksperimentą: generuoti identiškus duomenis,
# patikrinti, ar korektiškai veikia nuo atsitiktinumo priklausantis algoritmas.

# Generatoriui seed reikšmė nustatoma per funkciją set.seed, kuriai priskiriamas 
# sveikasis skaičius, kuris ir yra seed reikšmė.

set.seed(666)
sample(5)

# Norint gauti tą pačią ats. dydžių seką, seed reikšmę reikia nurodyti iš naujo.

sample(5)
sample(5)
sample(5)

set.seed(666)
sample(5)
set.seed(666)
sample(5)
set.seed(666)
sample(5)


# NAUDINGA ------------------------------

# Funkciją sample galima naudoti ne tik imties iš vektoriaus reikšmių išrinkimui, 
# bet ir imties sudarymui iš kitų duomenų struktūrų. Gana dažnai pasitaiko tokia
# situacija, kada iš didelės duomenų lentelės atsitiktine tvarka reikia išrinkti 
# tik dalį jos eilučių. Pvz., iš duomenų lentelės iris išrinksime 10 jos eilučių. 

m <- nrow(iris)  # duomenų lentelės eilučių skaičius
n <- 10          # išrenkamų eilučių skaičius

# Sudarome atsitiktinai su vienodomis tikimybėmis išrenkamų eilučių numerių seką.
i <- sample(m, n)
i

# Iš duomenų lentelės pasirenkame tik tas eilutes, kurių numeriai pateko į imtį.
d <- iris[i, ]
d


# UŽDUOTIS ------------------------------ 

# 1. Naudodami procedūrą sample, parašykite loterijos skaičių generavimo komandą,
#    kuri iš 30 sunumeruotų kamuoliukų be pasikartojimų ištrauktų 6.
# 2. Parašykite antrą loterijos programos pusę, kuri tokiu pačiu būdu parinktų 6
#    žaidėjo skaičius ir apskaičiuotų, kiek iš jų sutampa su loterijos skaičiais.
# 3. Užrašykite komandą, kuri vektoriaus LETTERS elementus išdėliotų atsitiktine 
#    tvarka.
# 4. Užrašykite komandą, kuri atsitiktine tvarka sudėliotų duomenų lentelės iris
#    eilutes.


# --------------------------------------- #
# BERNULIO BANDYMŲ MODELIAVIMAS           #
# --------------------------------------- #

# Kadangi procedūra sample gali generuoti nepriklausomų atsitiktinių dydžių seką,
# ją galima panaudoti nesudėtingų tikimybinių eksperimentų modeliavimui. Plačiai 
# taikoma nepriklausomų bandymų schema ir atskiras jos atvejis Bernulio bandymai.

# Tarkime, kad vykdome n nepriklausomų bandymų, kurių metu atsitiktinis įvykis A
# pasirodo su tam tikra pastovia tikimybe p. Jei įvykis A pasirodo, tokį bandymą 
# pažymime vienetu, jei įvykis nepasirodo --- bandymą pažymime nuliu. Tokiu būdu 
# gautas atsitiktinis dydis vadinamas Bernulio dydžiu su parametru p. Sudarysime 
# komandą, kuri generuoja n Bernulio dydžių seką.

x <- 0:1          # sudarome eksperimento baigčių vektorių
p <- c(0.4, 0.6)  # nurodome eksperimento baigčių tikimybes
n <- 10           # nurodome bandymų skaičių

b <- sample(x, n, replace = TRUE, prob = p)
b

# Sėkmingų bandymų skaičius, atlikus n Bernulio bandymų seriją, yra atsitiktinis
# dydis. Tokį dydį vadiname binominiu atsitiktiniu dydžiu su parametrais n ir p. 

sum(b)


# Klasikinis Bernulio bandymų schemos pavyzdys --- monetos mėtymo eksperimentas. 
# Pvz., sumodeliuosime eksperimentą, kuriame 100 kartų metama simetriška moneta.
# Kad būtų paprasčiau, monetos puses pažymėsime raidėmis H ir S, iš jų sudarome
# vieno metimo baigčių vektorių, iš kurio renkane n reikšmių su pasikartojimais.

moneta <- c("H", "S")
n <- 100

b <- sample(moneta, n, replace = TRUE)
b

# Modeliavimo rezultatus galima atvaizduoti dažnių lentele arba dažnių diagrama.
# Kadangi abi monetos pusės išrenkamos su vienodomis tikimybėmis, jų pasirodymų 
# dažnis turi būti apytiksliai lygus. Tą ir parodo dažnių lentelė.

l <- table(b)
l

barplot(l)


# UŽDUOTIS ------------------------------ 

# 1. Sumodeliuokite simetriško lošimo kauliuko mėtymą. Sugalvokite komandą, kuri
#    modeliuotų iš karto 100 lošimo kauliukų metimą.
# 2. Kaip mėtant lošimo kauliuką galima imituoti monetos mėtymą? Užrašykite tokį 
#    procesą modeliuojantį algoritmą.
# 3. Sumodeliuokite dviejų simetriškų monetų n = 100 metimų seriją ir sudarykite 
#    visų kombinacijų atsivertimų dažnių lentelę. Ar visos kombinacijos pasirodo 
#    vienodai dažnai?
# 4. Tarkime, kad X yra bendra taškų suma metant du simetriškus lošimo kauliukus. 
#    Modeliavimo būdu nustatykite, kokia suma pasitaiko dažniau, X = 9 ar X = 10.
#    Kaip keičiasi situacija, kai metami iš karto trys lošimo kauliukai?
