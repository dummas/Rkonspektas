
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Sąlygą tenkinančių elementų paieška ir duomenų filtravimas.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2013-07-27 | 2013-08-13
#


# TURINYS -------------------------------

#
#   1. Sąlygą tenkinančių elementų paieška:
#      * funkcija which
#      * funkcijo which.min
#      * funkcijo which.max
#      * funkcija match
#
#   2. Pasikartojantys vektoriaus elementai:
#      * funkcija duplicated
#      * funkcija anyDuplicated
#      * funkcija unique
#
#   3. Praleistos reikšmės duomenyse:
#      * procedūra summary 
#      * funkcija is.na
#      * funkcija complete.cases
#      * funkcija na.exclude
#      * funkcija na.omit
#
#   4. Duomenų filtravimas:
#      * funkcija subset 
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
# SĄLYGĄ TENKINANČIŲ ELEMENTŲ PAIEŠKA     #
# --------------------------------------- #

# Funkcija which nustato, kurių loginio vektoriaus elementų reikšmės lygios TRUE. 
# Jos parametrai:
#
#        x -- loginių reikšmių vektorius arba matrica,
#  arr.ind -- jei x yra matrica, nurodo ar grąžinti ieškomos reikšmės numerį.

# Jei x yra vektorius, tai rezultatas yra TRUE reikšmių indeksų vektorius. Jeigu
# x yra loginių reikšmių matrica, tai parametrui arr.ind nurodžius reikšmę TRUE,
# grąžinama matrica su reikšmės TRUE matricoje x eilučių ir stulpelių indeksais.


# Pavyzdžiui, surasime tuos loginio vektoriaus elementus, kurių reikšmė yra TRUE.
t <- c(FALSE, FALSE, TRUE, FALSE)

which(t)


# Šią funkciją galima pritaikyti ir kitokio tipo vektoriaus tam tikras sąlygas 
# tenkinančių elementų radimui. Pirmiausia sudarome loginį testą ir patikriname, 
# kurie vektoriaus elementai jį tenkina. Tada gautas loginių reikšmių vektorius 
# perduodamas funkcijai which, kuri nustato, kurie elementai yra TRUE.

x <- c(7, -2, 4, 24, 22, 26, 27, -2, 12, -9, -6, 0, 29, 16, -7, 6, 26, 1, 5, 12)
x

# Pavyzdžiui, surasime, kuris vektoriaus x elementas lygus 0. Sudarant loginį 
# testą apie lygybę, naudojamas == operatorius.
x == 0

# Loginę sąlygą galima įrašyti tiesiai į funkciją which. Gaunamas šią sąlygą 
# atitinkančių vektoriaus elementų numerių vektorius. Matome, kad vektorius x
# turi tik vieną nulinį elementą.
which(x == 0)

# Tokiu būdu galima surasti ir kelias sąlygas tenkinančius vektoriaus elementus.
# Surasime tuos vektoriaus x elementus, kurių reikšmės yra iš intervalo [0, 10].
which(x >= 0 & x <= 10)


# Ieškomo elemento vietą matricoje galima nurodyti dvejopai: nurodant jo eilės
# numerį vektoriuje, iš kurio elementų ir buvo sudaryta matrica, arba nurodant 
# eilutės ir stulpelio numerį. 

# Iš vektoriaus x elementų sudarysime 5x4 dydžio matricą.
m <- matrix(x, ncol = 4)
m

# Vektoriuje x nulinis elementas yra 12-tas, todėl ir matricoje jo indeksas 12.
which(x == 0)
which(m == 0)

# Elemento vietą matricoje patogiau nustatyti užrašant jo eilutės ir stulpelio
# numerį. Tam reikia pakeisti parametro arr.ind reikšmę į TRUE.
which(m == 0, arr.ind = TRUE)


# Kartais tenka surasti mažiausio ar didžiausio vektoriaus elemento numerį. Tam 
# naudojamos specialios funkcijos which.min ir which.max.
which.min(x)
which.max(x)


# Jei reikia patikrinti, ar tam tikra reikšmė yra vektoriuje (aibėje), naudojama 
# funkcija match. Jos parametrai:
#
#        x -- ieškoma reikšmė arba jų vektorius,
#    table -- vektorius, kuriame ieškoma reikšmė x.

# Funkcijos match rezultatas yra pirmojo reikšmę x atitinkančio elemento numeris.
# Jei ieškomos reikšmės vektoriuje nėra, grąžinama reikšmė NA.

# Pavyzdžiui, patikrinsime, ar vektoriuje x yra elementas, kurio reikšmė lygi 1.
match(x = 1, x)

# Jei vektorius turi kelis tuos pačius elementus, f-ja match grąžina tik pirmojo
# iš jų eilės numerį.
match(x = -2, x)


# NAUDINGA ------------------------------

# Funkcijos which rezultatas yra tam tikrą sąlygą tenkinančių vektoriaus elementų 
# numeriai. Juos galima panaudoti ieškomų elementų išskyrimui į atskirą vektorių.

# Pavyzdžiui, surasime visus teigiamus vektoriaus x elementus.
i <- which(x > 0)
i 

# Vienas iš būdų išskirti reikiamus vektoriaus elementus -- nurodyti jų numerius.
x[i]

# Tai atvejais, kai iš vektoriaus reikia išskirti tam tikrą sąlygą tenkinančius
# elementus, jų numerių nustatymą naudojant funkciją which galima praleisti, ir 
# loginę sąlygą įrašyti tiesiogiai. Taip yra ir paprasčiau, ir greičiau.

x[x > 0]


# UŽDUOTIS ------------------------------ 

# 1. Naudojant funkciją which, suraskite numerius tų vektoriaus x elementų, kurie 
#    lygūs 6 arba -6.
# 2. Užrašykite komandą, kuri surastų nelyginių vienženklių vektoriaus x elementų
#    numerius.
# 3. Sugalvokite būdą, kaip, nenaudojant funkcijos which.min, surasti mažiausio
#    vektoriaus elemento numerį.
# 4. Sugalvokite būdą, kaip, naudojant funkciją which.min, surasti didžiausią
#    vektoriaus elementą.


# --------------------------------------- #
# PASIKARTOJANTYS VEKTORIAUS ELEMENTAI    #
# --------------------------------------- #

# Pasikartojančių vektoriaus elementų nustatymui naudojama funkcija duplicated.
# Jos rezultatas yra tokio pat ilgio loginis vektorius, kur reikšmė TRUE rašoma
# tada, kai elementas pasikartoja. Visų kitų elementų reikšmės lygios FALSE.

s <- c("s", "u", "s", "i", "s", "u", "k", "o")

# Pavyzdžiui, nustatysime, kurios raidės žodyje kartojasi.
duplicated(s)

# Funkcija anyDuplicated patikrina, ar bent vienas elementas pasikartoja. Jos
# rezultatas yra pirmojo pasikartojimo vektoriuje numeris.
anyDuplicated(s)

# Vektoriaus elementų aibei gauti naudojama funkcija unique. Jos rezultatas
# yra pradinis vektorius, iš kurio pašalinami besidubliuojantys elementai.
unique(s)


# UŽDUOTIS ------------------------------ 

# 1. Sugalvokite komandą, kuri į atskirą vektorių išrinktų bent vieną kartą 
#    pasikartojančius vektoriaus s elementus.
# 2. Užrašykite komandą, kuri išrinktų tuos vektoriaus s elementus, kurie
#    neturi pasikartojimų, t.y reikia gauti vektorių c("i", "k", "o").


# --------------------------------------- #
# PRALEISTOS REIKŠMĖS DUOMENYSE           #
# --------------------------------------- #

# Dėl įvairių priežasčių realiuose duomenyse kartais būna praleistų reikšmių. 
# Standartiškai joms žymėti naudojama speciali konstanta NA. 

y <- c(7, -2, 4, NA, 22, 26, 27, -2, 12, -9, NA, 0, 29, 16, -7, 6, 26, 1, 5, 12)


d <- read.table(header = TRUE, text = "
   lytis  ūgis svoris grupė
  vyras   175     76     B
  vyras   180     NA     B
moteris   170     67     A
moteris   167     64     B
  vyras   178     80     A
moteris    NA     59    NA
  vyras   184     NA     A
moteris   171     68     B
moteris   177     70     A
  vyras   185     84     B
")


# Procedūra summary parodo pagrindines duomenų charakteristikas ir suskaičiuoja 
# praleistas reikšmes. Vektoriui surandamas bendras praleistų reikšmių skaičius, 
# o duomenų lentelei - jų skaičius kiekvienam kintamajam atskirai.

y
d

summary(y)
summary(d)


# Praleistų reikšmių vektoriuje nustatymui naudojama funkcija is.na. Rezultatas 
# yra loginis vektorius, kurio elementų reikšmė yra TRUE, jei tikrinamo elemento 
# reikšmė NA arba NaN, ir FALSE - kitais atvejais.
is.na(y)

# Jei praleistų reikšmių ieškoma matricoje arba duomenų lentelėje, tai funkcijos 
# rezultatas yra tokio pat dydžio loginių reikšmių matrica.
is.na(d)


# Atliekant duomenų analizę, reikia žinoti, kurie duomenų lentelės įrašai neturi
# praleistų reikšmių. Tam naudojama funkcija complete.cases. Jos rezultatas yra 
# loginis vektorius, kurio reikšmė lygi TRUE, jei duomenų lentelės eilutėje nėra
# praleistų reikšmių, ir FALSE - jei eilutėje yra bent viena praleista reikšmė.

complete.cases(d)


# Funkcijos all ir any patikrina, ar visų loginio vektoriaus elementų reikšmės 
# yra TRUE, ir ar bent vieno elemento reikšmė yra TRUE. Naudojant šias funkcijas, 
# galima patikrinti, ar vektorius turi praleistų reikšmių.

all(is.na(y))   # ar visų vektoriaus elementų reikšmės praleistos
any(is.na(y))   # ar bent vieno vektoriaus elemento reikšmė praleista

# Analogiškai galima patikrinti, ar visos duomenų lentelės eilutės užpildytos, 
# ar yra bent viena eilutė, kuri neturi praleistų reikšmių.

all(complete.cases(d))
any(complete.cases(d))


# Naudojant anksčiau aprašytą funkciją which, galima nustatyti, kurie vektoriaus 
# elementai yra praleistos reikšmės.

which(is.na(y))

# Lygiai taip pat, galima nustatyti, kurios duomenų lentelės eilutės turi bent 
# vieną praleistą reikšmę.

which(!complete.cases(d))


# Atliekant statistinę duomenų analizę, praleistos reikšmės iš duomenų turi būti
# pašalintos. Sukuriame loginį indeksą, kur TRUE reikšmė nurodo, kad tą elementą
# reikia pasirinkti.

i <- !is.na(y)
y[i]

# Iš duomenų lentelės, paprastai, reikia pašalinti tas eilutes, kuriose yra bent
# viena praleista reikšmė. Sudarome loginį indeksą, kur TRUE reikšmė nurodo, kad
# tą eilutę reikia pasirinkti.

i <- complete.cases(d)
d[i, ]


# Nepilnų stebinių pašalinimui galima naudoti funkcijas na.exclude arba na.omit.

na.omit(d)


# UŽDUOTIS ------------------------------ 

# 1. Užrašykite komandą, kuri apskaičiuotų elementų su praleistomis reikšmėmis
#    skaičių vektoriuje y. 
# 2. Užrašykite komandą, kuri apskaičiuotų eilučių su praleistomis reikšmėmis
#    skaičių duomenų lentelėje d. Kiek iš viso yra praleistų reikšmių lentelėje?
# 3. Sukurkite duomenų lentelę, kurioje būtų tik tie stebiniai (eilutės), kurios
#    turi bent vieną praleistą reikšmę.


# --------------------------------------- #
# DUOMENŲ FILTRAVIMAS                     #
# --------------------------------------- #

# Duomenų filtravimu vadinamas tam tikras sąlygas atitinkančių vektoriaus arba
# duomenų lentelės elementų išrinkimas. Pavyzdžiui, duomenų lentelės eilučių, 
# kurios neturi praleistų reikšmių išrinkimas, taip pat yra duomenų filtravimas.

# Dažnai duomenų analizei reikalinga tik tam tikra dalis visų turimų duomenų.
# Pvz., iš duomenų lentelės išrinksime tik vyrų stebinius. Paprasčiausiu atveju 
# reikiamų eilučių numerius galima surašyti rankiniu būdu, ir tokiu būdu gautą 
# indeksų vektorių naudojame konkrečių eilučių išrinkimui.

d

i <- c(1, 2, 5, 7, 10)
i

d[i, ]

# Tais atvejais, kai vektorius ar duomenų lentelė yra didelė, reikiamų elementų 
# išrinkimą reikia atlikti automatiškai. Užrašysime sąlygą, kuri tikrina, kurių 
# kintamojo "lytis" elementų reikšmė yra "vyras". Gauname loginį vektorių, kur 
# TRUE reiškia, kad sąlyga tenkinama, o FALSE - kad netenkinama.

i <- d$lytis == "vyras"
i 

d[i, ]

# Dažnai tenka išrinkti stebinius, kurie tenkina ne vieną sąlygą. Pavyzdžiui, iš
# lentelės d išrinksime aukštesnius nei 180 cm vyrus.

i <- d$lytis == "vyras" & d$ūgis > 180

d[i, ]


# Svarbu atsiminti, kad bet koks loginis testas su NA reikšme, duoda NA, todėl 
# duomenyse, kuriuose yra praleistų reikšmių, papildomai reikia tikrinti ar 
# reikšmė yra nepraleista. Pavyzdžiui, iš duomenų lentelės išrinksime B grupės
# stebinius.

i <- d$grupė == "B" & !is.na(d$grupė)     # 1 būdas, sąlyga kartu su NA testu
i                                         #
d.1 <- d[i, ]                             #
d.1

i <- which(d$grupė == "B")                # 2 būdas, trumpesnė komanda
i                                         #
d.2 <- d[i, ]                             #
d.2

# Galima įsitikinti, kad abiem būdais gauti duomenų rinkiniai sutampa.
identical(d.1, d.2)


# Duomenų filtravimui naudojama procedūra subset. Jos parametrai:
#
#        x -- vektorius, matrica ar duomenų lentelė,
#   subset -- loginė sąlyga,
#   select -- paliekamų kintamųjų (stulpelių) sąrašas.

# Naudojant šią procedūrą, loginiai veiksmai su konstanta NA duoda reikšmę FALSE. 
# Pavyzdžiui, iš lentelės d išrinksime tik B grupės stebinius.
subset(d, grupė == "B")

# Kadangi naujai sudarytame duomenų rinkinyje kintamasis "grupė" turi vienintelę
# reikšmę "B", jis nebereikalingas, todėl jį galima išmesti.
subset(d, grupė == "B", selec = -grupė)

# Galima nurodyti ir kelis kintamuosius, kuriuos reikia palikti arba išmesti.
subset(d, grupė == "B", selec = c(lytis, ūgis))

# Iš eilės einančių kintamųjų aibę galima nurodyti per dvitaškį užrašant pirmojo 
# ir paskutinio kintamojo vardus.
subset(d, grupė == "B", selec = lytis:ūgis)


# UŽDUOTIS ------------------------------ 

# 1. Užrašykite komandą, kuri surastų, kuriose duomenų lentelės d eilutėse yra
#    daugiau nei 80 kg sveriantys vyrai. Turite gauti eilučių numerių vektorių.
#    Naudojant šį indeksų vektorių sudarykite naują duomenų lentelę.
# 2. Užrašykite komandą, kuri apskaičiuotų, kiek grupėje B yra moterų. Turite
#    gauti vieną skaičių.
# 3. Iš duomenų lentelės d išrinkite B grupės moterų stebinius. Užrašykite dvi
#    tokios komandos versijas: naudojant procedūrą subset ir nenaudojant jos.
# 4. Iš duomenų lentelės mtcars išrinkite tas mašinas, kurių variklis turi 4 
#    cilindrus (kintamasis "cyl").
