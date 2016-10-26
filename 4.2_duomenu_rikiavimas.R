
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Vektoriaus elementų išrikiavimas ir duomenų lentelių pertvarkymai.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2013-09-09 | 2013-09-22
#


# TURINYS -------------------------------

#
#   1. Vektorių ir duomenų lentelių išrikiavimas:
#      * funkcija rev
#      * funkcija sort
#      * funkcija order
#
#   2. Duomenų lentelių pertvarkymas:
#      * funkcija stack
#      * funkcija unstack
#      * funkcija reshape
#


# PASTABOS ------------------------------

#
# Įtraukti funkcijas rank ir xtfrm.
# Sugalvoti uždavinių su funkcija reshape.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuviška lokalė. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# Ištrinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# VEKTORIAUS REIKŠMIŲ RIKIAVIMAS          #
# --------------------------------------- #

# Prieš atliekant statistinę duomenų analizę, turimus duomenis dažniausiai tenka 
# sutvarkyti ir suteikti jiems tam tikrą standartinę formą, kuri leidžia taikyti
# standartines statistines procedūras. Analizuojant gautus rezultatus, juos taip
# pat dažniausiai reikia pertvarkyti, išrikiuoti, agreguoti ir t.t.

# Vektoriaus elementų išrikiavimui priešinga tvarka naudojama funkcija rev.
x <- c(7.7, 3.8, -0.5, 5.3, 8.9, 1.5, -3.2, 4.1, -1.4, -4.7)

rev(x)


# Vektoriaus reikšmių išrikiavimui nemažėjimo arba nedidėjimo tvarka naudojama 
# funkcija sort. Jos parametrai:
# 
#          x -- vektorius,
# decreasing -- pagal nutylėjimą FALSE, nurodo rikiavimo tvarka,
#    na.last -- pagal nutylėjimą NA, gali būti TRUE arba FALSE arba.

# Pagal nutylėjimą skaitinio vektoriaus elementai išrikiuojami nemažėjimo tvarka.

sort(x)

# Statistikoje taip gaunama imties variacinė eilutė, kurios i-asis elementas yra
# vadinamas i-ąją pozicine statistika. Pavyzdžiui, 1-oji pozicinė statistika yra
# imties minimumas. Užrašysime pirmosios pozicinės statistikos nustatymo komandą 
# funkcinio programavimo stiliumi.

sort(x)[1]


# Rikiuojant nedidėjimo tvarka, parametro decreasing reikšmė pakeičiama į TRUE.
sort(x, decreasing = TRUE)

# Rikiuojant vektorių su praleistomis reikšmėmis, jos pagal nutylėjimą išmetamos.
y <- c(7.7, 3.8, NA, 5.3, 8.9, 1.5, NA, 4.1, NA, NA)

sort(y)

# Kad išrikiuoto vektoriaus su praleistomis reikšmėmis elementų skaičius išliktų 
# toks pat, praleistas reikšmes galima nukelti į vektoriaus pradžią arba galą.

sort(y, na.last = TRUE)
sort(y, na.last = FALSE)


# Pagal nutylėjimą raidės išrikiuojamos abėcėlės tvarka.
r <- c("Y", "M", "S", "F", "I", "Q", "Z", "E", "O", "H", "A", "W", "J", "R", "T")

sort(r)

# Ilgesnės simbolių sekos (nebūtinai vienodo ilgio) išrikiuojamos leksikografine 
# tvarka: iš pradžių pagal pirmą žodžio simbolį, tada pagal antrą ir t.t.
s <- c("ZSZ", "LFB", "IY", "OWJV", "WL", "LNXCO", "ZS", "ARIHB", "TUCYS", "KRHU")

sort(s)


# Vektoriaus elementų numerius išrikiuotame vektoriuje nustato f-ja order. Jos
# parametrai:
#
#        ... -- vienas arba keli vektoriai,
#    na.last -- pagal nutylėjimą NA, gali būti TRUE arba FALSE arba,
# decreasing -- pagal nutylėjimą FALSE, nurodo rikiavimo tvarka.

# Funkcijos order reikšmė yra vektoriaus elementų perstatinys. Tai reiškia, kad
# ši funkcija grąžina ne išrikiuotus vektoriaus elementus, o jų numerius. 

z <- c("c", "a", "b")

i <- order(z)
i

# Pirmojo gauto vektoriaus elemento reikšmė 2 nurodo, kad pirmas tarp išrikiuotų 
# vektoriaus elementų būtų antrasis vektoriaus elementas z[2], kurio reikšmė "a".
# Antrasis elementas lygus 3 ir tai reiškia, kad antras tarp išrikiuotų elementų
# būtų z[3], kurio reikšmė "b". Trečiasis elementas lygus 1, vadinasi trečiasis
# tarp išrikiuotų elementų būtų z[1], kurio reikšmė lygi "c".

# Parodysime, kad vektoriaus elementus išdėsčius pagal funkcijos order grąžinamą 
# numerių vektorių, gaunamas išrikuotas vektorius, kokį gautume su funkcija sort.

z[i]


# Funkcijos order grąžinamas vektorius naudojamas matricos arba duomenų lentelių 
# eilučių išrikiavimui pagal kurio nors stulpelio reikšmes. Pavyzdžiui, lentelės 
# tyrimas eilutes išrikiuosime pagal kintamąjį "X".

tyrimas <- read.table(header = TRUE, text = "
X     Y     Z
b   1.3  TRUE
a   5.2  TRUE
b   2.5  TRUE
c   1.2  FALSE
a   3.8  FALSE
c   2.4  FALSE
")

i <- order(tyrimas$X)

tyrimas[i, ]

# Laikantis funkcinio programavimo stiliaus viską galima užrašyti viena išraiška.

tyrimas[order(tyrimas$X), ]

# Kad funkcijos order viduje būtų galima tiesiogiai naudoti lentelės kintamųjų
# pavadinimus, ją galima įkelti į funkciją with. Tai ypač patogu tuo atveju, kai
# reikia užrašyti iš karto kelis vienos lentelės kintamuosius.

with(tyrimas, tyrimas[order(X), ])

# Eilutes galima išrikiuoti iš karto pagal kelis stulpelius. Pvz., išrikiuosime 
# eilutes kintamojo "X" didėjimo (abėcėlės) tvarka, bet tuo atveju kai kintamojo 
# "X" reikšmės sutampa, eilutes išrikiuosime pagal kintamąjį "Y".

with(tyrimas, tyrimas[order(X, Y), ])


# NAUDINGA ------------------------------

# Funkcija order sukuria tokį perstatinį, kuris vektoriaus elementus išrikiuoja 
# nemažėjimo tvarka. Jei lentelės eilutes reikia išrikiuoti vektoriaus mažėjimo 
# tvarka, nurodomas parametras decreasing = TRUE. Jei vektorius arba kintamasis, 
# pagal kurį atliekamas rikiavimas, yra skaitinis, paprasčiau pakeisti jo ženklą.

# Pvz., išrikiuosime lentelės tyrimas eilutes kintamojo "X" didėjimo tvarka, bet 
# kintamojo "Y" mažėjimo tvarka.

with(tyrimas, tyrimas[order(X, -Y), ])

# Kategoriniams kintamiesiems ženklo pakeisti negalima, todėl tokiais atvejais
# gali būti naudojama speciali funkcija xtfrm. Pavyzdžiui, išrikiuosime lentelę 
# kintamojo "X" mažėjimo tvarka ir kintamojo "Y" didėjimo tvarka.

with(tyrimas, tyrimas[order(-xtfrm(X), Y), ])


# UŽDUOTIS ------------------------------ 

# 1. Vektorių x išrikiuokite mažėjimo tvarka nenaudojant f-jos sort parametro
#    decreasing = TRUE. Sugalvokite kelis būdus tokiam išrikiavimui atlikti.
# 2. Lentelės tyrimas eilutes išrikiuokite pagal visus tris jos kintamuosius iš 
#    karto: pagal "Z", tada pagal "X", o esant vienodoms jų reikšmėms pagal "Y".


# --------------------------------------- #
# DUOMENŲ LENTELIŲ PERTVARKYMAS           #
# --------------------------------------- #

# Į tekstinius failus ar Excel lenteles surašomi duomenys dažniausiai būna taip
# vadinamo "wide" formato: viename stulpelyje surašytos vieno kintamojo reikšmės, 
# kintamųjų paprastai būna ne vienas, o vieną objektą aprašo viena eilutė. Tai 
# natūralus duomenų surašymo būdas, bet jis ne visada patogus duomenų analizei.

# Vienos duomenų lentelės kelių kintamųjų apjungimui į vieną kintamąjį naudojama 
# funkcija stack. Jos parametrai:
#
#        x -- "wide" formato duomenų lentelė,
#   select -- duomenų lentelės kintamasis arba kelių kintamųjų vardų vektorius,

# Funkcijos rezultatas yra lentelė, kur stulpelyje "values" surašomos kintamųjų 
# reikšmės, o stulpelyje "ind" -- tų kintamųjų pavadinimai.

# Tarkime, kad yra lentelė, kurioje kiekvienas matavimas pakartotas tris kartus,
# reikšmės surašytos į kintamuosius X, Y ir Z. Sudarysime lentelę, kurioje visi 
# trys kintamieji apjungti į vieną bendrą kintamąjį.

kintamieji <- read.table(header = TRUE, text = "
  X    Y    Z
1.5  3.2  0.2
1.2  3.9  0.7
1.9  3.5  0.5
1.7  3.4  0.1
")

kintamieji

# Apjungimo rezultatas yra taip vadinamo "long" formato lentelė, kurioje į vieną 
# kintamąjį apjungtos visų trijų lentelės kintamųjų reikšmės.

matavimai <- stack(kintamieji)
matavimai

# Naudojant parametrą select, galima nurodyti, kuriuos kintamuosius apjungti. Su 
# minuso ženklu nurodyti kintamieji neapjungiami. Pvz., apjungsime kintamuosius
# "X" ir "Y". Toks pats rezultatas gaunamas išmetus kintamąjį "Z".

stack(kintamieji, select = c(X, Y))
stack(kintamieji, select = -Z)


# Galima ir atvirkštinė duomenų lentelės transformacija, kai apjungti stulpeliai 
# išskaidomi į atskirus kintamuosius. Tam naudojama funkcija unstack. Parametrai:
#
#        x -- "long" formato duomenų lentelė,
#     form -- formulė, kuri nurodo, kaip į stulpelius išskaidyti kintamąjį.

# Formulė rašoma taip: X ~ G. Čia X yra kintamasis, kurį reikia suskaidyti, o G 
# yra grupavimo kintamasis.

# Jeigu "long" formato lentelė buvo gauta naudojant funkciją stack, atvirkštinė 
# transformacija atliekama nenurodant jokių parametrų (jie įrašyti atributuose).

unstack(matavimai)

# Jei kintamojo reikšmes grupuojančių kintamųjų lentelėje yra ne vienas, galima
# nurodyti, pagal kurį iš jų atliekamas išskaidymas į stulpelius. Tam nurodomas
# parametras form. 

matavimai <- read.table(header = TRUE, text = "
reikšmė  tipas  grupė
1.5      X      Pirmas
1.2      X      Pirmas
1.9      X      Pirmas
1.7      X      Pirmas
3.2      Y      Pirmas
3.9      Y      Pirmas
3.5      Y      Antras
3.4      Y      Antras
0.2      Z      Antras
0.7      Z      Antras
0.5      Z      Antras
0.1      Z      Antras
")

unstack(matavimai, form = reikšmė ~ tipas)
unstack(matavimai, form = reikšmė ~ grupė)


# Sudėtingesnės struktūros duomenų lentelės pertvarkymams naudojama f-ja reshape. 
# Pagrindiniai jos parametrai:
# 
#      data -- "wide" arba "long" formato duomenų lentelė,
#   varying -- pasikartojančius matavimus atitinkantys lentelės kintamieji,
#   v.names -- kintamojo, į kurį apjungiami pasikartojantys matavimai, vardas,
#     idvar -- vienas ar keli grupavimo kintamieji, 
#   timevar -- kintamasis, kuris "long" lentelėje nurodo vieną matavimų seriją,
# direction -- "long" arba "wide", nurodo į kokio formato lentelę transformuoti.

# Pertvarkant lentelę iš "wide" formato į "long", lentelėje atsiranda kintamasis
# "time". Jį atitinkantis kintamasis nurodomas parametrui timevar, kai lentelė 
# pertvarkoma iš "long" formato į "wide".

# Pavyzdžiui, turime lentelę, kurioje yra trys to paties kintamojo matavimai ir
# grupavimo kintamasis. Sudarysime lentelę, kurioje kintamieji "X.1", "X.2" ir 
# "X.3" apjungiami į vieną kintamąjį.

d.ww <- read.table(header = TRUE, text = "
nr  grupė   X.1   X.2   X.3
 1      A  2.84  2.08  1.06
 2      B  2.95  2.08  0.96
 3      A  2.85  2.03  1.10
 4      B  3.07  1.90  0.96
 5      A  3.21  1.99  1.11
 6      B  2.87  1.97  0.90
")

# Paprasčiausiu atveju funkcijai užtenka nurodyti tik pasikartojančius matavimus
# atitinkančių kintamųjų vardus, kiti automatiškai priskiriami parametrui idvar.
d.wl <- reshape(d.ww, varying = c("X.1", "X.2", "X.3"), direction = "long")
d.wl

# Kintamuosius parametrams galima išvardinti nurodant jų stulpelių numerius. 
d.wl <- reshape(d.ww, varying = 3:5, v.names = "X", idvar = 1:2, direc = "long")
d.wl

# Tokią pertvarkytą lentelę galima atversti atgal panaudojant tą pačią funkciją 
# reshape be jokių parametrų (visų jų reikšmės įrašytos lentelės atributuose).

reshape(d.wl)


# Jei pradiniai duomenys yra "long" formato, naudojant f-ją reshape, juos galima 
# pertvarkyti į "wide" formato duomenų lentelę.

d.ll <- read.table(header = TRUE, text = "
nr grupė bandymas    X
1      A        1 2.84
2      B        1 2.95
3      A        1 2.85
4      B        1 3.07
5      A        1 3.21
6      B        1 2.87
1      A        2 2.08
2      B        2 2.08
3      A        2 2.03
4      B        2 1.90
5      A        2 1.99
6      B        2 1.97
1      A        3 1.06
2      B        3 0.96
3      A        3 1.10
4      B        3 0.96
5      A        3 1.11
6      B        3 0.90
")

# Kintamąjį "time", kuris "long" formato lentelėje atskiria kintamojo matavimų 
# serijas, šioje lentelėje atitinka kintamasis "bandymas". 

t <- "bandymas"
g <- c("nr", "grupė")

d.lw <- reshape(d.ll, v.names = "X", idvar = g, timevar = t, direction = "wide")
d.lw

# Taip pertvarkytos lentelės atvirkštinė transformacija į "long" formato lentelę 
# atliekama naudojant f-ją reshape be jokių papildomų parametrų.

reshape(d.lw)


# UŽDUOTIS ------------------------------ 

# 1. Naudojant funkciją unstack, lentelę tyrimas pertvarkykite iš "long" formato 
#    į "wide". Suskaidyti reikia kintamąjį "Y", o jo grupavimas atliekamas pagal 
#    kintamąjį "X". Kodėl tokios lentelės pervarkymui netinka funkcija reshape?
# 2. Sugalvokite būdą, kaip lentelės duomenys kintamuosius "X.1", "X.2" ir "X.3" 
#    apjungti naudojant funkciją stack.
# 3. Pertvarkykite lentelę chickwts: kintamąjį weight padalinkite į grupes pagal 
#    kintamojo feed reikšmes.
