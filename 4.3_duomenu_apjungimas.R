
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Vektorių, matricų ir duomenų lentelių apjungimas.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2013-09-09 | 2013-09-23
#


# TURINYS -------------------------------

#
#   1. Vektorių, matricų ir lentelių sujungimas:
#      * funkcija cbind
#      * funkcija rbind
#      * funkcija data.frame
#
#   2. Duomenų lentelių apjungimas:
#      * funkcija merge
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
# DUOMENŲ APJUNGIMAS                      #
# --------------------------------------- #

# Atliekant duomenų analizę ar analizuojant gautus rezultatus labai dažnai tenka 
# juos apjungti į vieną vektorių, matricą arba duomenų lentelę. Tam naudojamos 
# kelios standartinės funkcijos. 

# Vektorių apjungimui į matricą naudojamos funkcijos cbind ir rbind. Šiuo atveju
# apjungiamų vektorių elementai turi būti vienodo tipo.

a <- c(1, 5, 8, 4, 6, 10, 9, 7, 2, 3)
b <- c(2.97, 6.93, 4.06, 6.83, 4.21, 6.28, 6.2, 3.7, 7.32, 6.21)

# Pavyzdžiui, sudarysime matricą, kurios vienas stulpelis yra skaičių vektorius 
# a, o kitas stulpelis -- taip pat skaičių vektorius b.

cbind(a, b)

# Tuos pačius vektorius galima apjungti eilutėmis.

rbind(a, b)

# Matricos stulpeliams ar duomenų lentelės kintamiesiems galima suteikti vardus.

cbind(pirmas = a, antras = b)

# Jei apjungiami nevienodą elementų skaičių turintys vektoriai, tai trumpesnio 
# vektoriaus elementai cikliškai pakartojami. Pvz., sukursime kintamąjį, kurio 
# visi elementai vienodi ir lygus 1.

cbind(pirmas = a, antras = b, trečias = 1)


# Jei į vieną lentelę reikia apjungti skirtingo tipo vektorius, naudojama f-ja
# data.frame. Jos parametrai:
#
#              ... -- vienas arba keli vektoriai, lentelės kintamieji,
#        row.names -- eilučių pavadinimų vektorius, pagal nutylėjimą NULL, 
#       check.rows -- pagal nutylėjimą FALSE, patikrinami eilučių vardai,
#      check.names -- TRUE, patikrinama ar nesikartoja kintamųjų vardai,
# stringsAsFactors -- TRUE, kategoriniai kintamieji paverčiami faktoriais,

# Pavyzdžiui, į duomenų lentelę apjungsime skaičių vektorius a ir b.

data.frame(a, b)

# Kintamiesiems galima nurodyti naujus vardus.

data.frame(X = a, Y = b)

# Kadangi parametro check.names reikšmė pagal nutylėjimą TRUE, netyčia nurodžius 
# du vienodus kintamųjų vardus, vienas iš jų automatiškai bus pakeistas.

data.frame(X = a, X = b)

# Pagal nutylėjimą duomenų lentelės eilutės sunumeruojamos, bet jų vardus galima 
# ir pakeisti. Tam reikia parametrui row.names nurodyti nesikartojančių reikšmių
# vektorių. Pavyzdžiui, sukursime lentelę, kurios eilučių pavadinimai yra raidės.

data.frame(X = a, Y = b, row.names = letters[1:10])

# Kategoriniai kintamieji duomenų lentelėje tampa faktoriais. Pvz., prijungsime 
# vektorių, kurio elementai yra didžiosios raidės.

c <- c("A", "A", "B", "B", "A", "A", "B", "B", "B", "B")

d <- data.frame(X = a, Y = b, Z = c)
d

# Galima nesunkiai parodyti, kad character tipo vektorius pavirto į factor tipo
# lentelės kintamąjį.

sapply(d, class)

# Tam, kad character tipo vektorius ir lentelėje liktų character tipo kintamuoju, 
# parametro stringsAsFactors reikšmę reikia pakeisti į FALSE.

d <- data.frame(X = a, Y = b, Z = c, stringsAsFactors = FALSE)
d

sapply(d, class)

# Kintamojo tipo išlaikymui naudojama funkcija I, todėl ji irgi tinka character
# tipo vektoriaus įtraukimui į lentelę.

d <- data.frame(X = a, Y = b, Z = I(c))
d

# Vektorių prie jau sukurtos lentelės galima prijungti ir naudojant f-ją cbind. 
# Pvz., prie lentelės d prijungsime loginį vektorių, kurio visų elementų reikšmė
# yra TRUE. Nurodysime tik vieną reikšmę, likusios bus pakartotos.

cbind(d, L = TRUE)


# NAUDINGA ------------------------------

# Duomenų analizėje pasitaiko situacija, kai į vieną lentelę reikia sujungti ne
# dvi, o daug mažų duomenų lentelių.

d.1 <- data.frame(x = 1:2, y = 11:12)
d.2 <- data.frame(x = 4:5, y = 14:15)
d.3 <- data.frame(x = 7:8, y = 17:18)

# Tokias lenteles paprastai galima apjungti naudojant funkciją rbind.
rbind(d.1, d.2, d.3)

# Galima sukurti tokių duomenų lentelių sąrašą ir kaip parametrą jį perduoti tai
# pačiai funkcijai rbind. Tam naudojama speciali funkcija do.call. 

d.list <- list(d.1, d.2, d.3)
d.list

do.call(rbind, d.list)


# Toks lentelių sujungimo būdas labai efektyvus tais atvejais, kai, analizuojant 
# duomenis, kaip rezultatas gaunamas list tipo sąrašas, kurio elementai yra tuos 
# pačius kintamuosius (kitaip nebūtų galima sujungti) turinčios duomenų lentelės. 

# Tokiu atveju pradiniai duomenys dažniausiai taip pat yra sąrašo pavidalo. Pvz.,
# tai gali būti sąrašas, kurio elementai yra nevienodą elementų skaičių turintys
# to paties tipo vektoriai, arba sąrašas, kurio elementai yra kokio nors teksto 
# sakiniai arba kokio nors organizmo DNR sekos. Pradinius duomenis gali sudaryti
# duomenų lentelės apie tą patį objektą skirtingais laiko momentais ir t.t.

# Sąrašo pavidalo duomenis labai patogu analizuoti naudojant funkcijas lapply ir
# sapply, kurių rezultatas taip pat yra sąrašas. Jei šių funkcijų rezultatas yra
# duomenų lentelės, tai jas galima nesunkiai apjungti naudojant do.call funkciją.

# Tarkime, kad atliekama DNR sekų analizė. Seką sudaro nukleotidai A, C, G ir T. 
# Tarkime, kad turime 50 skirtingo ilgio DNR sekų, kurios apjungtos į list tipo 
# sąrašą. Vienas sąrašo elementas yra vienas nukleotidų vektorius. Sugeneruosime
# tokius duomenis.

dnr <- replicate(50, sample(factor(c("A", "C", "G", "T")), sample(20:50, 1), T))
dnr

# Pirma užduotis -- apskaičiuoti kiekvienos sekos nukleoditų dažnių lentelę. Tam
# panaudojame funkciją table, kurią pritaikome kiekvienai sąrašo sekai. Gauname
# sąrašą, kurio elementai yra dažnių lentelės.

freq.list <- lapply(dnr, table)
freq.list

# Kadangi visos dažnių lentelės yra tokio paties pavidalo, jas galima nesunkiai
# apjungti į vieną didelę lentelę, kurios eilutėse bus sekų nukleotidų dažniai.

do.call(rbind, freq.list)


# Antra užduotis -- kiekvienai DNR sekai sudaryti lentelę, kurioje būtų įrašytas
# sekos ilgis, pirmas ir paskutinis jos nukleotidai.

# Kadangi tokios standartinės funkcijos nėra, ją tenka pasirašyti. 

dnr.info <- function(s) {

  ilgis   <- length(s)
  pradžia <- s[1]
  pabaiga <- s[ilgis]
  
  info <- data.frame(pradžia, pabaiga, ilgis)
  return(info)
}

# Funkciją dnr.info, kuri suformuoja vienos sekos analizės lentelę, įdedame į 
# ciklo funkciją lapply ir perbėgame per sekų sąrašą.

stat.list <- lapply(dnr, dnr.info)
stat.list

# Gauname lentelių sąrašą, kuri apjungiame naudojant do.call funkciją.

do.call(rbind, stat.list)


# UŽDUOTIS ------------------------------ 

# 1. Sudarykite data.frame tipo lentelę, kurios vienas stulpelis yra didžiųjų, o
#    kitas -- mažųjų raidžių vektorius, atitinkamai LETTERS ir letters. Lentelės
#    kintamieji turi išlikti character tipo.
# 2. Atlikite duomenų rinkinio dnr analizę. Kiekvienai sekai sudarykite lentelę,
#    kuri turi du kintamuosius. Vieno kintamojo reikšmė yra pirmi trys dnr sekos
#    nukleotidai, kito kintamojo reikšmė -- nukleotidų C ir G dalis DNR sekoje.
#    Naudojant funkciją do.call gautą lentelių sąrašą apjunkite į vieną lentelę.


# --------------------------------------- #
# DUOMENŲ APJUNGIMAS                      #
# --------------------------------------- #

# Kartais tenka apjungti duomenų lenteles, kurios turi bendrų kintamųjų. Tokiais
# atvejais rezultatas yra dviejų lentelių sankirta, kuri gaunama naudojant f-ją
# merge. Pagrindiniai jos parametrai:
#
#        x -- pirmos lentelės vardas,
#        y -- antros lentelės vardas,
#       by -- bendras abiejų lentelių kintamasis arba jų vektorius,
#      all -- FALSE, nurodo, kad į lentelę įtraukiamos tik bendros eilutės.

# Turime dvi lenteles: pirmoje surašyti didžiausi Lietuvos miestai ir gyventojų
# skaičius juose 2001 ir 2011 metais, kitoje lentelėje yra miestai ir atstumas
# iki Vilniaus.

miestai <- read.table(header = TRUE, text = "
miestas       m2011  m2001
Alytus        63642  71491
Jonava        33172  34954
Kaunas       336912 378650
Klaipėda     177812 192954
Marijampolė   44885  48675
Mažeikiai     38819  42675
Panevėžys    109028 119749
Šiauliai     120969 133883
Utena         31139  33860
Vilnius      542932 542287
")

atstumas <- read.table(header = TRUE, text = "
miestas   atstumas
Vilnius         0
Utena          96
Alytus        101
Jonava        102
Kaunas        102
Panevėžys     136
Marijampolė   138
Šiauliai      213
Mažeikiai     291
Klaipėda      311
")

# Apjungsime šias lenteles. Jos turi bendrą kintamąjį miestas, kurį nurodysime 
# parametrui by.

merge(miestai, atstumas, by = "miestas")

# Pagal nutylėjimą parametrui by priskiriamas abiejų lentelių bendrų kintamųjų
# vardų vektorius. Kadangi šiuo atveju toks kintamasis tik vienas, parametro by
# buvo galima ir nenurodyti -- jam reikšmė priskiriama vienareikšmiškai.

merge(miestai, atstumas)


# Gali būti, kad bendras abiejų lentelių kintamasis, pagal kurį jos apjungiamos, 
# vienoje lentelėje turi vienas reikšmes, o kitoje -- kitas. Tokiu atveju galimi
# keli lentelių apjungimo variantai.

# Tarkime, kad miestų ir atstumų lentelės turi vienodą įrašų (eilučių) skaičių,
# bet miestų sąrašas vienoje lentelėje skiriasi nuo miestų sąrašo kitoje. Pvz.,
# miestų lentelėje įrašytas Vilnius, bet jo nėra atstumų iki sostinės lentelėje.

miestai <- read.table(header = TRUE, text = "
miestas       m2011  m2001
Jonava        33172  34954
Kaunas       336912 378650
Klaipėda     177812 192954
Marijampolė   44885  48675
Mažeikiai     38819  42675
Panevėžys    109028 119749
Utena         31139  33860
Vilnius      542932 542287
")

atstumas <- read.table(header = TRUE, text = "
miestas   atstumas
Utena          96
Alytus        101
Kaunas        102
Panevėžys     136
Marijampolė   138
Šiauliai      213
Mažeikiai     291
Klaipėda      311
")

# Apjungiant lenteles pagal bendrą, tačiau nevienodas reikšmes turintį kintamąjį, 
# rezultatas yra lentelė, kurioje yra tik bendros abiem lentelėms eilutės. Šiuo
# atveju kiekvienoje lentelėje yra po 8 miestus, tačiau bendri abiem lentelėms 
# yra tik 6 miestai.

merge(miestai, atstumas)

# Tam, kad būtų įtraukiamos visos abiejų lentelių eilutės, pakeičiama parametro
# all reikšmė. Tada gaunama lentelė, kurioje kai kurie kintamieji turi praleistų
# reikšmių.

merge(miestai, atstumas, all = TRUE)

# Pagal nutylėjimą į bendrą lentelę įtraukiamos bendros abiem lentelėms eilutės.
# Jei nurodomas parametras all = TRUE, tada įtraukiamos visos abiejų lentelių
# eilutės. Galima įtraukti tik pirmos ar tik antros lentelės eilutes, kurių nėra 
# kitoje lentelėje. Tam nurodomi parametrai atitinkamai all.x arba all.y.

merge(miestai, atstumas, all.x = TRUE)
merge(miestai, atstumas, all.y = TRUE)


# UŽDUOTIS ------------------------------ 

# 1. Sugalvokite būdą, kaip pradines miestų ir atstumų lenteles, kurios abi turi
#    po 10 eilučių, apjungti nenaudojant funkcijos merge. Kada tokį būdą galima
#    taikyti lentelių apjungimui?
