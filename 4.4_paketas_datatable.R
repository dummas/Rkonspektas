
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Pagrindiniai veiksmai su data.table tipo lentelėmis.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2015-08-12 | 2015-08-20
#


# TURINYS -------------------------------

#
#   1. data.table lentelės sudarymas:
#      * funkcija data.table
#      * parametras keep.rownames
#      * parametras key 
#      * parametras with
#      * parametras mult
#      * parametras nomatch
#      * funkcija fread
#      * funkcija copy
#      * funkcija tables
#      * funkcija set
#      * funkcija setnames
#      * funkcija setcolorder
#
#   2. eilučių ir stulpelių išrinkimas:
#      * operatorius %between% 
#      * operatorius %like% 
#
#   3. veiksmai su stulpeliais:
#      * operatorius :=
#      * operatorius .()
#
#   4. eilučių grupavimas:
#      * parametras .N
#      * parametras .SD
#      * parametras .EACHI
#
#   5. data.table eilučių indeksavimas:
#      * funkcija setkey
#      * funkcija key
#


# PASTABOS ------------------------------

#
# Sugalvoti uždavinius.
#


# NUSTATYMAI ----------------------------

# Nustatoma lietuviška lokalė. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# Ištrinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# TRUMPAI APIE DATA.TABLE                 #
# --------------------------------------- #

# Tipiniai veiksmai su duomenų lentelėmis tai -- reikiamų eilučių arba stulpelių
# išrinkimas, vieno ar daugiau stulpelių sumos, vidurkio ar kitų charakteristikų 
# apskaičiavimas. Dažnai vienoje lentelėje yra kelių skirtingų grupių matavimai,
# todėl skaičiuojamos sąlyginės charakteristikos -- atskirai kiekvienoje grupėje.

# Standartiškai R naudojamos data.frame tipo duomenų lentelės. Veiksmams atlikti 
# naudojamos įvairios tam skirtos funkcijos. Štai keletas dažniausiai naudojamų:
# 
#     subset -- eilučių ir stulpelių išrinkimui iš duomenų lentelės,
#  transform -- naujų lentelės stulpelių sudarymui ar senų perskaičiavimui,
#      merge -- dviejų lentelių apjungimui,
#    colSums -- matricos ar lentelės stulpelių sumos, 
#    rowSums -- matricos ar lentelės eilučių sumos, 
#   colMeans -- matricos ar lentelės stulpelių vidurkiai, 
#   rowMeans -- matricos ar lentelės eilučių vidurkiai, 
#        ave -- vieno kintamojo vidurkinimui grupėse,
#      scale -- naudojama vektoriaus ar lentelės centravimui ir normavimui,
#      sweep -- galima naudoti vektoriaus reikšmių vidurkinimui,
#      apply -- veiksmai matricos eilutėse arba stulpeliuose,
#     tapply -- sąlyginių charakteristikų skaičiavimas grupėse.


# Pavyzdžiui, keliais standartiniais būdais apskaičiuosime duomenų lentelės iris 
# kintamojo Sepal.Length vidurkį grupėse pagal kintamojo Species reikšmes.

   tapply(iris[, "Sepal.Length"],      iris[, "Species"],  mean)
       by(iris[, "Sepal.Length"],      iris[, "Species"],  mean)
aggregate(iris[, "Sepal.Length"], list(iris[, "Species"]), mean)

# Tokiu atveju tipinė veiksmų seka: suskaidyti lentelę pagal grupavimo kintamąjį,
# apskaičiuot reikiamas charakteristikas ir (kartais) apjungti gautus rezultatus.

      sapply(split(iris, iris$Species), function(x) mean(x$Sepal.Length))
stack(lapply(split(iris, iris$Species), function(x) mean(x$Sepal.Length)))

# Kitas pavyzdys -- apskaičiuoti visų kintamųjų vidurkius atskirai grupėse pagal
# grupavimo kintamojo reikšmes.

aggregate(iris[, -5], list(Rūšis = iris[, 5]), mean)

lapply(split(iris, iris$Species), function(x) colMeans(x[, -5]))
lapply(split(iris, iris$Species), function(x)    apply(x[, -5], 2, mean))


# Laikas, per kurį atliekamos tokios operacijos, priklauso nuo eilučių ir grupių
# skaičiaus lentelėje -- kuo jų daugiau, tuo ilgiau užtrunka skaičiavimai, todėl
# net paprasčiausios duomenų pertvarkymo operacijos su itin didelėmis data.frame
# tipo lentelėmis gali užtrukti labai ilgai.

# Kita problema -- visi R objektai ir duomenys būtinai turi tilpti į kompiuterio 
# atmintį. Dėl tos priežasties sudėtingos struktūros ir didelės apimties duomenų 
# saugojimui naudojamos specializuotos duomenų bazės.

# Labai didelių duomenų lentelių apdorojimui naudojamas data.table tipo lentelės
# formatas. Nuo standartinės R data.frame tipo lentelės data.table skiriasi tuo, 
# kad leidžia indeksuoti eilutes, dėl ko žymiai pagreitėja eilučių išrinkimas ir 
# jų grupavimas. Pagrindiniai veiksmai su data.table tipo lentelėmis:
# 
#   -- eilučių išrinkimas, 
#   -- eilučių grupavimas,
#   -- naujų stulpelių sudarymas,
#   -- nereikalingų stulpelių panaikinimas,
#   -- stulpelių reikšmių perskaičiavimas,
#   -- stulpelių charakteristikų apskaičiavimas,
#   -- lentelių apjungimas.

# Pagal savo struktūrą data.table tipo lentelė, kaip ir data.frame, yra vektorių 
# sąrašas. data.frame lentelės turi unikalius eilučių pavadinimus, o jeigu tokių
# nėra -- eilutės numeruojamos. data.table eilučių pavadinimų neturi, vietoje jų
# visos eilutės turi unikalius raktus. Šiuo požiūriu data.table panašu į duomenų
# bazes. 

# Kaip ir data.frame, data.table lenteles galima apjungti naudojant rbind, cbind
# ar merge funkcijas. Unikalių eilučių išskyrimui naudojama standartinė funkcija 
# unique. 

# Atliekant veiksmus su data.frame tipo lentele, kiekvieną kartą sukuriama nauja 
# lentelė, o pradinė lentelė išlieka tokia pati. Pvz., naudojant funkciją subset 
# iš lentelės iris išmesime vieną stulpelį. 

subset(iris, select = -Species)

# Buvo sudaryta nauja lentelė, bet pradinė lentelė nepasikeitė. Ji nepasikeis ir
# tuo atveju, jei, pvz., naudojant funkciją transform, sudarysime naują stulpelį.

transform(iris, Sepal.Sum = Sepal.Length + Sepal.Width)

# Veiksmai su data.table lentelės stulpeliais atliekami nedarant lentelės kopijų.
# Tai iš esmės skiriasi nuo data.frame ir yra didelis privalumas dirbant didelės 
# apimties duomenimis.


# Tarkime, kad turime data.table lentelę DT. Jos argumentus galima suskirstyti į 
# tris dalis:
#                                 DT[i, j, by]
# 
#          i -- išrenkamų eilučių numeriai arba loginė sąlyga,
#          j -- išrenkamų stulpelių pavadinimai,
#         by -- grupavimo kintamojo pavadinimas arba loginė sąlyga.
#
# Priklausomai nuo atliekamų veiksmų šiuos argumentus galima naudoti ir visus iš 
# karto, ir atskirai po vieną arba du. Lentelės viduje visi stulpeliai yra tarsi
# kintamieji, todėl standartiškai vietoje stulpelių numerių naudojami jų vardai.


# --------------------------------------- #
# DATA.TABLE LENTELĖS SUDARYMAS           #
# --------------------------------------- #

# Norint naudoti data.table tipo lenteles, turi būti suinstaliuotas ir įtrauktas
# to paties pavadinimo R paketas.

library(data.table)


# data.table tipo lentelė sudaroma panašiai, kaip ir data.frame lentelė, tik čia
# vektorių apjungimui į lentelę naudojama funkcija data.table.

x <- c("Re_5", "Mi_5", "Do_5", "Do_4", "So_4")
y <- c(587.33, 659.25, 523.25, 261.63, 329.00)

xy <- data.table(X = x, Y = y)
xy


# Kitas būdas sudaryti data.table tipo lentelę -- konvertuoti data.frame lentelę.
# Tam naudojama ta pati funkcija data.table. Pvz., tokiu būdu iš lentelės mtcars 
# sudarysime data.table tipo lentelę.

mtcars

mt <- data.table(mtcars)
mt

# Paprastai data.frame lentelės eilutės turi unikalius numerius, bet joms galima 
# priskirti ir pavadinimus, kurie taip pat turi būti unikalūs. Tačiau data.table
# tipo lentelės eilutės turi tik numerius. Norint išlaikyti eilučių pavadinimus,
# naudojamas loginis argumentas keep.rownames. Tokiu atveju lentelėje sukuriamas
# papildomas kintamasis rn.

mt <- data.table(mtcars, keep.rownames = TRUE)
mt


# Jeigu duomenys įrašyti į tekstinį failą, juos galima nuskaityti naudojant f-ją
# fread. Rezultatas bus data.table tipo duomenų lentelė. Pavyzdžiui, įrašysime į
# tekstinį failą duomenų lentelę iris ir ją nuskaitysime kaip data.table lentelę.

write.table(iris, file = "df.txt", quote = FALSE, row.names = FALSE, sep = ";")

# Funkcijos fread parametrai beveik tokie pat kaip ir read.table parametrai, bet 
# yra ir kai kurių skirtumų. Pagrindiai parametrai tokie:
#
#      input -- failo vardas,
#     header -- loginis kintamasis, nurodo ar lentelė turi antraštę,
#        sep -- stulpelių atskyrimo simbolis,
#      nrows -- nuskaitomų eilučių skaičius,
#       skip -- praleidžiamų eilučių skaičius,
#     select -- nuskaitomų stulpelių pavadinimų vektorius,
#       drop -- praleidžiamų stulpelių pavadinimų vektorius.

df <- fread(input = "df.txt", header = TRUE, sep = ";")
df


# data.table tipo lentelė tuo pačiu yra ir data.frame lentelė, dėl to jas galima 
# naudoti su visomis funkcijomis, kurių argumentas yra data.frame lentelė. Pvz.,
# su data.table lentelėmis veikia tokios funkcijos kaip names, colnames, nrow su 
# ncol ir daugelis kitų.

class(df)

# Visi veiksmai su data.table tipo lentele atliekami by reference, t.y. nedarant 
# jos kopijų. Dėl tos priežasties, jei viena data.table lentelė priskiriam kitai, 
# tai naujas objektas nesukuriamas, o gauname tą pačią lentelę su dviem vardais.
# Dar daugiau -- visi pakeitimai padaryti pradinėje lentelėje, bus matomi ir jos
# "kopijoje". Šitą faktą patikrinsime kiek vėliau.

yx <- xy
yx

# Norint gauti nepriklausomą data.table lentelės kopiją, naudojama funkcija copy.

dt <- copy(xy)
dt

# Visų data.table lentelių bei jų charakteristikų sąrašą sudaro funkcija tables.

tables()


# Jei lentelėje reikia pakeisti kurią nors vieną reikšmę, galim naudoti funkciją
# set. Jos sintaksė set(x, iL, jL, value) atitinka konstrukciją x[i, j] <- value.
# Eilutės ir stulpelio numeriai i ir j turi būti sveikieji skaičiai. Pavyzdžiui,
# taip pakeisime pirmos eilutės ir pirmo stulpelio reikšmę iš "Re_5" į "re".

set(xy, 1L, 1L, "re")
xy

# Jeigu eilutės numeris nenurodomas, tada laikoma, kad keičiamos visos stulpelio 
# reikšmės, ir parametrui value priskiriamas naujų stulpelio reikšmių vektorius.

set(xy, j = 1L, value = c("re", "mi", "do", "do", "sol"))
xy

# Funkcija setnames naudojama data.table lentelės stulpelių pavadinimams keisti.

setnames(xy, c("X", "Y"), c("Nata", "Dažnis"))
xy

# Stulpelių tvarkos pakeitimui naudojama funkcija setcolorder. Pavyzdžiui, šitai
# lentelei sukeisime vietomis stulpelius.

setcolorder(xy, c("Dažnis", "Nata"))
xy

# Dabar galima patikrinti ar lentelėje yx matosi visi tie pakeitimai, kurie buvo
# atlikti su lentele xy, o lentelė dt liko nepakitusi.

identical(xy, yx)

xy
yx
dt


# UŽDUOTIS ------------------------------ 

# 1. 
#    
# 2. 
#    


# --------------------------------------- #
# EILUČIŲ IR STULPELIŲ IŠRINKIMAS         #
# --------------------------------------- #

dt <- data.table(iris)
dt

# Eilutės išrenkamos argumentui i priskiriant reikiamų eilučių numerių vektorių. 
# Pavyzdžiui, iš visos lentelės išrinksime trečią eilutę.

dt[3]

# Eilutes galima išrinkti pagal tam tikrą loginę sąlygą. Pavyzdžiui, išrinksime
# tas eilutes, kuriose kintamojo Sepal.Length reikšmė didesnė už 7.

dt[Sepal.Length > 7]

# Loginės sąlygos gali būti gana sudėtingos. Pavyzdžiui., išrinksime tas eilutes,
# kuriose kintamojo Sepal.Length reikšmės lygios 4.3, 5.4, 6.1, 7.2. Šiuo atveju 
# panaudosime standartinį R operatorių %in%.

dt[Sepal.Length %in% c(4.3, 5.4, 6.1, 7.2)]

# Tuo atveju, kada eilutes reikia išrinkti iš tam tikro vieno stulpelio reikšmių
# intervalo, galima naudoti specialų operatorių %between%.

dt[Sepal.Length %between% c(5.3, 5.5)]

# Jeigu ieškoma reikšmė nėra tiksliai žinoma, jos paieškai galima naudoti %like%
# operatorių. Pvz., rasime visas eilutes, kuriose stulpelio Sepal.Length reikšmė
# po kablelio turi skaičių 4: 3.4, 4.4, 5.4 ir t. t.

dt[Sepal.Length %like% ".4"]


# Stulpelio reikšmės išrenkamos argumentui j priskiriant to stulpelio pavadinimą.
# Jei eilučių numeriai nenurodomi, išrenkamos visos to stulpelio reikšmės. Pvz.,
# taip į atskirą vektorių išrinksime stulpelio Sepal.Length reikšmes.

dt[, Sepal.Length]

# Jei iš atrinktų stulpelių reikia gauti naują lentelę, tų stulpelių pavadinimus 
# reikia apjungti į sąrašą. Tam galima naudoti specialią data.table konstrukciją
# .() arba įprastą funkciją list -- rezultatas bus tas pats. Pavyzdžiui, gausime
# lentelę su dviem stulpeliais Sepal.Length ir Sepal.Width.

dt[, .(Sepal.Length, Sepal.Width)]

dt[, list(Sepal.Length, Sepal.Width)]

# SVARBI PASTABA! Kadangi data.table lentelės viduje stulpelių vardai suprantami
# kaip paprasti R kintamieji, tai visos konstrukcijos su jais yra išraiškos. Dėl 
# to, kintamųjų vardus apjungus su funkcija c, gausime vieną bendrą vektorių.

dt[, c(Sepal.Length, Sepal.Width)]


# Stulpelius galima išrinkti ir pagal jų numerį lentelėje, tačiau tam reikalinga
# pakeisti papildomo data.table parametro with reikšmę iš TRUE į FALSE.

dt[, c(1, 2), with = FALSE]

# Toks būdas naudojamas ir tuo atveju, kai reikia manipuliuoti kintamųjų vardais.
# Kintamųjų vardus į vektorių galima apjungti rankiniu būdu arba galima naudoti 
# kitus metodus, pavyzdžiui, reikiamų stulpelių ieškoti naudojant funkciją grep.
# Pvz., iš lentelės išrinksime tik tuos kintamuosius, kurių pavadinime yra žodis 
# "Sepal".

dt[, c("Sepal.Length", "Sepal.Width"), with = FALSE]

dt[, grep("Sepal", names(dt)), with = FALSE]


# UŽDUOTIS ------------------------------ 

# 1. 
#    
# 2. 
#    


# --------------------------------------- #
# STULPELIŲ SUKŪRIMAS IR PANAIKINIMAS     #
# --------------------------------------- #

# Kintamasis data.table lentelėje sukuriamas naudojant := priskyrimo operatorių.
# Kairėje šio operatoriaus pusėje rašomas kintamojo vardas, o dešinėje tam tikra 
# išraiška. Pvz., sukursime kintamąjį Sepal.Sum, kuris bus dviejų kintamųjų suma.

dt[, Sepal.Sum := Sepal.Length + Sepal.Width]
dt

# SVARBI PASTABA! Kintamasis data.table lentelėje sukuriamas ar perskaičiuojamas 
# by reference, todėl čia įprasta R konstrukcija dt <- dt[...] nenaudotina! 

# Tuo atveju, kai dešinėje pusėje reikšmių neužtenka užpildyti visam stulpeliui,
# jos cikliškai pratęsiamos. Pavyzdžiui, taip paprastai galima sukurti kintamąjį 
# X su viena ir ta pačia reikšme.

dt[, X := 1]
dt

# Jeigu vienu metu sukuriami arba perskaičiuojami iš karto keli kintamieji, tada
# kairėje operatoriaus := pusėje rašomas kintamųjų vardų vektorius, dešinėje --
# sąrašas, kurio elementai yra tų kintamųjų reikšmės arba reikšmių apskaičiavimo
# išraiškos.

dt[, c("V", "G") := list(mean(Sepal.Length), as.numeric(Species))]
dt

# Kintamajam priskyrus reikšmę NULL, jis iš lentelės panaikinamas.

dt[, X := NULL]
dt

# Analogiškai panaikinami iš karto keli stulpeliai.

dt[, c("Sepal.Sum", "V", "G") := NULL]
dt


# Vienas iš tipinių veiksmų -- vieno ar kelių lentelės stulpelių charakteristikų
# skaičiavimas. Tai gali būti kintamųjų vidurkiai, elementų skaičius ir panašios
# charakteristikos. Tokiu atveju argumentui j priskiriama funkcija nuo kintamojo. 
# Pavyzdžiui, apskaičiuosime kintamojo Sepal.Length vidurkį.

dt[, mean(Sepal.Length)]

# Jeigu išraiška įtraukiama į .() skliaustus, rezultatas yra data.table lentelė.
# Beje, Kaip ir anksčiau, vietoje skliaustų galima naudoti funkciją list.

dt[, .(mean(Sepal.Length))]

# Žinoma, apskaičiuotai kintamojo charakteristikai galima priskirti naują vardą.

dt[, .(Vidurkis = mean(Sepal.Length))]

# Tokiu būdu galima užrašyti komandą iš karto kelių stulpelių statistikoms gauti.
# Pavyzdžiui, sudarysime lentelę su dviejų kintamųjų Sepal.Length ir Sepal.Width 
# vidurkiais ir reikšmių šiuose stulpeliuose skaičiumi.

dt[, .(N = length(Sepal.Length), L = mean(Sepal.Length), W = mean(Sepal.Width))]


# NAUDINGA ------------------------------

# Iš esmės data.table lentelės viduje su kintamaisiais galima daryti ką tik nori.
# Pavyzdžiui, kintamųjų vardus galima naudoti grafikų braižymui.

dt[, plot(Petal.Length, Petal.Width, col = Species, pch = 19)]

# Jei reikia, kelias kabliataškiu atskirtas komandas galima apjungti riestiniais 
# skliaustais. Pavyzdžiui, nubraižysime dviejų kintamųjų sklaidos diagramą ir ją
# papildysime paprastosios tiesinės regresijos tiese.

dt[, {plot(Petal.Length, Petal.Width); abline(lm(Petal.Width ~ Petal.Length))}]


# --------------------------------------- #
# EILUČIŲ GRUPAVIMAS                      #
# --------------------------------------- #

# Labai dažnai reikia apskaičiuoti tam tikras kintamųjų charakteristikas grupėse
# pagal kategorinio kintamojo reikšmes. Šiuo atveju data.table lentelę papildome
# argumentu by, kuriam nurodomas arba grupavimo kintamasis, arba loginės sąlygos.
# Pavyzdžiui, apskaičiuosime kintamojo Sepal.Length vidurkį atskirai kiekvienoje 
# kintamojo Species reikšmių grupėje -- gausime trijų sąlyginių vidurkių lentelę.

dt[, mean(Sepal.Length), by = Species]

# Žinoma, vienu metu galima apskaičiuoti kelias sąlygines charakteristikas. Pvz.,
# apskaičiuosime kintamojo Sepal.Length vidurkį ir sumą atskirai pagal kintamojo
# Species reikšmes.

dt[, .(Vidurkis = mean(Sepal.Length), Suma = sum(Sepal.Length)), by = Species]

# Grupavimas gali būti atliekamas pagal loginę sąlygą. Pvz., sudarysime 2 grupes
# pagal tai, ar kintamojo Sepal.Width reikšmė didesnė už 3, ar ne.

dt[, .(Vidurkis = mean(Sepal.Length)), by = Sepal.Width > 3]

# Jeigu grupavimas atliekamas pagal kelis kintamuosius arba logines sąlygas, tai
# juos apjungiame su .() skliaustais (kaip ir anksčiau, vietoje .() tinka list). 

dt[, .(Vidurkis = mean(Sepal.Length)), by = .(Species, Sepal.Width > 3)]


# NAUDINGA ------------------------------

# Grupavimo kintamiesiems ir loginėms sąlygoms galima suteikti pavadinimą. Pvz.,
# papildysime anksčiau užrašytą komandą taip, kad loginės sąlygos sudaryta grupė 
# taip pat turėtų pavadinimą. 

# Patogumo dėlei loginio kintamojo reikšmes TRUE ir FALSE būtų geriau pakeisti į 
# labiau suprantamus pavadinimus. Vienas iš būdų -- naudoti funkciją ifelse. Bet 
# tokia komanda bus labai ilga, todėl ją geriau išskaidyti į dvi dalis. Problema
# tame, kad data.table tipo lentelėje stulpelių pavadinimai interpretuojami kaip 
# kintamieji, todėl rašomi be kabučių ir už lentelės ribų jokios prasmės neturi.
# Skliaustai .() taip pat naudojami tik data.table lentelės viduje. 

# Šiuo atveju, naudojant funkciją quote, reikiamą komandą paverčiame į call tipo 
# išraišką. Ji suvykdoma lentelės viduje, kur kintamųjų pavadinimai turi prasmę.

grupė <- quote(.(Rūšis = Species, 
                 Lapas = ifelse(Sepal.Width > 3, "Platus", "Siauras")))
grupė

dt[, .(Vidurkis = mean(Sepal.Length)), by = grupė]


# NAUDINGA ------------------------------

# Kartu su grupavimo argumentu by naudojamos kelios specialios funkcijos, kurios 
# leidžia supaprastintai užrašyti dažnai pasitaikančias konstrukcijas:
#
#        .SD -- ta pati lentelė, tačiau be grupavimo kintamojo,
#        .BY -- grupavimo kintamojo reikšmių sąrašas,
#         .N -- eilučių skaičius grupėje,
#         .I -- eilučių numeriai grupėje,
#       .GRP -- grupės numeris.


# Priklausomai nuo to, kuriam argumentui priskiriama reikšmė .N, rezultatas gali 
# būti arba paskutini lentelė eilutė, arba bendras eilučių skaičius.

dt[.N]
dt[, .N]

# Kadangi .N nurodo eilučių skaičių grupėje, naudojant .N galima sudaryti dažnių 
# lentelę.

dt[, .N, by = .(Species, Lapas = ifelse(Sepal.Width > 3, "Platus", "Siauras"))]

# Naudojant .I, galima sužinoti į konkrečias grupes patenkančių eilučių numerius.

dt[, .I, by = .(Species, Lapas = ifelse(Sepal.Width > 3, "Platus", "Siauras"))]


# Atlikus eilučių grupavimą, tolimesniems skaičiavimams tas grupavimo kintamasis 
# dažniausiai nereikalingas ir tam, kad netrukdytų, iš lentelės yra pašalinamas.
# Kaip tik tokiais atvejais ir naudojama .SD konstrukcija. 

# .SD lentelės viduje galima taikyti įprastas funkcijas nuo kintamųjų-stulpelių.
# Pavyzdžiui, naudojant funkciją lapply, apskaičiuosime visų lentelės stulpelių 
# vidurkius grupėse pagal kintamojo Species reikšmes.

dt[, lapply(.SD, mean), by = Species]

# Iš esmės tokį pat rezultatą galima gauti ir naudojant kitas standartines f-jas.

dt[, .(Vidurkis = apply(.SD, 2, mean)), by = Species]
dt[, .(Vidurkis = colMeans(.SD)), by = Species]


# UŽDUOTIS ------------------------------ 

# 1. 
#    
# 2. 
#    


# --------------------------------------- #
# DATA.TABLE EILUČIŲ INDEKSAVIMAS         #
# --------------------------------------- #

# data.table lentelei galima priskirti raktus - tokias stulpelių reikšmes, pagal 
# kurias vienareikšmiškai nustatoma, iš kurios eilutės ta reikšmė paimta. Raktas
# gali būti sudaromas pagal vieną ar kelis lentelės stulpelius. Dėl šios savybės
# data.table lentelės primena duomenų bazes. 

# Raktą turinčios lentelės eilutės išrikiuojamos pagal to rakto reikšmes, dėl to
# eilučių išrinkimas pagal raktą yra labai greitas. 

# Raktas data.table lentelei priskiriamas naudojant funkciją setkey. Pavyzdžiui, 
# lentelei dt priskirsime raktą pagal stulpelio Species reikšmes.

setkey(dt, Species)

# Kokius raktus turi lentelė, nustatoma naudojant funkciją key.

key(dt)

# Raktas gali būti nustatomas ir sudarant lentelę. Tam naudojamas parametras key,
# kuriam priskiriamas kintamųjų vardų vektorius.

dt <- data.table(iris, key = "Species")
dt

key(dt)


# Išrenkant eilutes pagal rakto reikšmę, rakto reikšmė priskiriama argumentui i.
# Pavyzdžiui, išrinksime tas lentelės eilutes, kurios priklauso "setosa" grupei.

dt["setosa"]

# Standartiškai išvedamos visos eilutės, kurios turi nurodytą rakto reikšmę, bet
# iš viso galimi keli variantai: rodyti visas eilutes, rodyti pirmą ar paskutinę
# eilutę. Tam naudojamas parametras mult.

dt["setosa", mult = "all"]
dt["setosa", mult = "first"]
dt["setosa", mult = "last"]

# Gali būti, kad lentelėje nėra eilučių, kurios turėtų nustatytas rakto reikšmes.
# Tokios nerastos eilutės pažymimos NA reikšme, bet, naudojant parametrą nomatch, 
# galima nustatyti, kad jos nebūtų rodomos. Pvz., išrinksime tas eilutes, kurios
# priklauso "setosa" arba "mimosa" grupei.

dt[c("setosa", "mimosa")]

# Matome, kad "mimosa" grupėje nėra nė vienos eilutės, todėl ta grupė žymima NA.
# Kad tokia eilutė nebūtų rodoma, parametrui nomatch priskiriame reikšmę 0.

dt[c("setosa", "mimosa"), nomatch = 0]


# Raktas gali būti naudojamas skaičiuojant sąlygines stulpelių charakteristikas. 
# Tai atliekama argumentui by priskiriant .EACHI reikšmę. Pavyzdžiui, užrašysime
# komandą, kuri apskaičiuotų kintamojo Sepal.Length vidurkį grupėse pagal rakto 
# reikšmes "setosa" ir "virginica".

dt[c("setosa", "virginica"), mean(Sepal.Length), by = .EACHI]


# UŽDUOTIS ------------------------------ 

# 1. 
#    
# 2. 
#    


# --------------------------------------- #
# NEDIDELIS GREIČIO BANDYMAS: DF vs DT    #
# --------------------------------------- #

n = 1e7

x <- sample(LETTERS, n, TRUE)
y <- sample(letters, n, TRUE)
z <- runif(n)

DF <- data.frame(x, y, z)
DT <- data.table(DF)

head(DF)
head(DT)


system.time(DF[DF$x == "R" & DF$y == "f", ])
system.time({setkey(DT, x, y); DT[J("R", "f")]})
