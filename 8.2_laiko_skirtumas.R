
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Veiksmai su datos ir laiko duomenimis.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2015-11-05 | 2015-12-12
#


# TURINYS -------------------------------

#
#   1. Veiksmai su datos ir laiko kintamaisiais:
#      * funkcija weekdays
#      * funkcija months
#      * funkcija quarters
#      * funkcija trunc
#      * funkcija round
#      * funkcija seq
#      * funkcija cut
#
#   2. Skirtumas tarp dviejų laiko momentų:
#      * funkcija as.difftime
#      * funkcija difftime
#      * funkcija diff
#      * funkcija units
#      * funkcija proc.time()
#      * funkcija system.time
#


# PASTABOS ------------------------------

#
# Galima sugalvoti daugiau užduočių.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuviška lokalė. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# Ištrinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# VEIKSMAI SU DATA IR LAIKU               #
# --------------------------------------- #

# Dirbant su datos ir laiko duomenimis, paprastai reikia atlikti tokius veiksmus:
# 
#  -- iš datos arba laiko išskirti tam tikrą jo elementą;
#  -- prie datos ar laiko pridėti tam tikrą laiko intervalą;
#  -- apskaičiuoti skirtumą tarp dviejų laiko momentų;
#  -- suskirstyti laiko momentus į tam tikrus intervalus;
#  -- generuoti laiko momentų seką.


# Jei laiko momentas užrašytas kaip POSIXlt klasės objektas, kai kurias datos ir 
# laiko komponentes galima gauti be jokių papildomų funkcijų, kadangi tokiu būdu
# užrašytas laiko momentas yra įvairių laiko ir datos komponenčių sąrašas. Pvz.,
# nustatysime, kelinta savaitės, mėnesio ir metų diena yra ši diena.

t <- as.POSIXlt(Sys.time())
t

t$wday
t$mday
t$yday


# Savaitės dienos, mėnesio pavadinimo ir metų ketvirčio nustatymui bendru atveju 
# gali būti naudojamos šios funkcijos: weekdays, months, quarters. Visų funkcijų 
# argumentai vienodi:
#
#          x -- data arba laikas,
# abbreviate -- loginis, nurodo, pavadinimas turi būti sutrumpintas.

# Pavyzdžiui, žinomos kelių artimiausių pilnų Saulės užtemimų datos. Nustatysime, 
# kurią savaitės dieną vyks šitie užtemimai.

data <- c("2016-03-08", "2017-08-21", "2019-07-02", "2020-12-14", "2021-12-04")

d <- as.Date(data)
d

weekdays(d)


# Kadangi datos ir laiko kintamieji, nepriklausomai nuo jų formato, saugomi kaip 
# skaičiai, keletas standartinių funkcijų turi metodus datos ir laiko objektams:
#
#                 datoms                         laikui
#              ------------                  --------------
#               trunc.Date                    trunc.POSIXt
#               round.Date                    round.POSIXt 
#                 seq.Date                      seq.POSIXt
#                 cut.Date                      cut.POSIXt
#                hist.Date                     hist.POSIXt
#                axis.Date                     axis.POSIXt
#
# Tai reiškia, kad su datomis ir laiku galima elgtis kaip su įprastais skaičiais: 
# juos apvalinti iki norimo tikslumo, generuoti laiko momentų sekas arba turimus 
# laiko momentus grupuoti į intervalus.


# Jeigu duotą laiko momentą reikia užrašyti dienų, valandų, minučių ar sekundžių 
# tikslumu, naudojama funkcija trunc. Jeigu laiko momentą reikia suapvalinti iki 
# artimiausio laiko momento dienų, valandų, minučių arba sekundžių tikslumu, tai 
# naudojama funkcija round. Abiejų funkcijų parametrai vienodi:
#
#          x -- laiko momentas,
#      units -- laiko apvalinimo vienetai, "secs", "mins", "hours" arba "days".


# Pavyzdžiui, duotas laiko momentas sekundės tūkstantųjų tikslumu. Užrašysime jį
# dienų, valandų, minučių ir sekundžių tikslumu. Vienu atveju naudosime funkciją 
# trunc, kitu -- funkciją round.

t <- as.POSIXct("2015-11-22 18:39:12.683", format = "%Y-%m-%d %H:%M:%OS")
t

format(t, format = "%H:%M:%OS3")

trunc(t, "day")
round(t, "day")

trunc(t, "hours")
round(t, "hours")

trunc(t, "mins")
round(t, "mins")

trunc(t, "secs")
round(t, "secs")


# Datų ar laiko momentų sekos generavimui naudojama funkcija seq. Ši standartinė
# funkcija turi atskirus metodus "Date" ir "POSIXt" klasės objektams. Parametrai:
#
#       from -- pradinė data,
#         to -- galutinė data,
#         by -- datos kitimo žingsnis,
# length.out -- sekos elementų skaičius,
# along.with -- sekos elementų skaičius pagal kitą vektorių.
#
# Parametrui from priskiriame "Date" klasės reikšmę. Parametras to neprivalomas,
# jeigu per parametrus length.out arba along.with nurodome bendrą sekos elementų 
# skaičių. Parametrui by reikšmę galima priskirti net keliais skirtingais būdais,
# kadangi sekos kitimo žingsnis, intervalas tarp dviejų sekos elementų gali būti:
# 
#  -- skaičius, kuris nurodo dienų skaičių;
#  -- difftime klasės objektas;
#  -- žodinis laiko intervalas: "day", "week", "month", "quarter", "year";
#  -- kartotinis laiko intervalas: "7 days", "2 months", "-1 years" ir pan.

# Tarkime, kad sekos pradžia ir pabaiga yra pirma ir paskutinė 2015 metų dienos.
# Sudarysime keletą skirtingų sekų su įvairaus dydžio tarpais tarp gretimų datų.

pr <- as.Date("2015-01-01")
pb <- as.Date("2015-12-31")

# Sugeneruosime seką, kurią sudaro visos sausio mėnesio dienos.
seq(pr, by = "day", length.out = 31)      

# Sudarome seką, kurioje į praeitį atidedame penkias datas kas du metus.
seq(pr, by = "-2 years", length.out = 5)

# Vienerių metų intervalą suskirstome 4 savaičių ilgio laiko intervalais. 
seq(pr, pb, by = "4 weeks")


# Jeigu funkcija seq naudojama laiko sekoms generuoti, tada parametrams from, to
# nurodome "POSIXt" laiko momentą, o parametrui by galima nurodyti šias reikšmes:
# 
#  -- skaičių, kuris reiškia sekundžių skaičių;
#  -- difftime klasės objektą;
#  -- intervalą: "sec", "min", "hour", "day", "week", "month", "quarter", "year";
#  -- kartotinį laiko intervalą: "15 secs", "2 hour", "-1 years" ir pan.

# Pavyzdžiui, vienos valandos ilgio intervalą reikia padalinti į mažesnius laiko 
# intervalus po 90 sekundžių. Pradinis momentas 08:00:00, galutinis -- 09:00:00.

pr <- as.POSIXlt("2015-01-01 08:00:00")
pb <- as.POSIXlt("2015-01-01 09:00:00")

seq(pr, pb, by = "90 secs")

# Tarkime, kad reikalinga seka iš 10 laiko momentų kas 45 minutes. Sugeneruosime
# tokią seką.

seq(pr, by = "45 mins", length.out = 10)

# Jei laiko intervalai didesni, pradiniam ir galutiniam laiko momentams nurodyti 
# patogiau gali būti naudoti funkciją ISOdate arba ISOdatetime. Pvz., sudarysime
# kas vieną dieną išdėstytų 30 laiko momentų seką, pradedant nuo 2015-11-23.

seq(ISOdate(2015, 11, 23), by = "day", length.out = 30)


# Datų ir laiko momentų grupavimui naudojama funkcija cut; ji turi metodus "Date"
# ir "POSIXt" klasės objektams. Pagrindiniai šios funkcijos parametrai yra tokie:
#
#          x -- datų arba laiko momentų vektorius,
#     breaks -- padalijimo taškų vektorius arba norimas intervalų skaičius,
#     labels -- NULL, intervalų pavadinimų vektorius,
#      right -- FALSE, nurodo ar intervalo galas uždaras iš dešinės.

# Grupuojant laiko intervalus parametrui breaks galima nurodyti tokias reikšmes:
# "sec", "min", "hour", "day", "DSTday", "week", "month", "quarter" arba "year".

# Pavyzdžiui, vienos paros bėgyje atidėsime 100 atsitiktinių laiko momentų, tada
# juos suskirstysime į intervalus po 6 valandas bei apskaičiuosime laiko momentų
# dažnius kiekviename tokiame intervale.

t <- ISOdatetime(2015, 11, 23, 0, 0, 0) + 24*3600*runif(100)
t

windows(9, 4)
plot(t, rep(0, 100), type = "n", xlab = "laikas", ylab = "", yaxt = "n")
rug(t)

intervalai <- cut(t, breaks = "6 hour")
intervalai

table(intervalai)


# Pavyzdžiui, visą parą suskirstysime į du nevienodo ilgio intervalus: nuo 00:00
# iki 05:59 ir nuo 06:00 iki 23:59. Tokiu atveju parametrui breaks nurodome tris
# laiko momentus POSIX formatu.

p <- c("2015-11-23 00:00:00", "2015-11-23 06:00:00", "2015-11-23 23:59:59")
p <- strptime(p, format = "%Y-%m-%d %H:%M:%S")
p

intervalai <- cut(t, breaks = p, labels = c("naktis", "diena"))
intervalai

table(intervalai)


# Analogiškai į intervalus suskirstomos ir datos. Pvz., dviejų mėnesių intervale
# (pradedant nuo 2015-11-23) sugeneruosime 20 atsitiktinių datų ir suskirstysime
# jas į dviejų savaičių ilgio intervalus.

d <- as.Date("2015-11-23") + 2*30*runif(20)
d

intervalai <- cut(d, breaks = "2 weeks")
intervalai

table(intervalai)


# NAUDINGA ------------------------------

# Funkcija axis turi metodą POSIX klasės objektams, todėl laiko momentus galima
# pavaizduoti grafike. Pavyzdžiui, paros bėgyje atvaizduosime 100 laiko momentų.
# Paprasčiausiu atveju tam galima naudoti funkciją plot.

t <- ISOdatetime(2015, 12, 12, 0, 0, 0) + 24*3600*runif(100)

y <- rep(0, length(t))
plot(t, y, type = "n", ylab = "", yaxt = "n")
rug(t)

# Laiko ašį galima suformuoti tokią, kokia reikalinga. Pavyzdžiui, laiko momentų
# atidėjimui galima panaudosime funkciją stripchart, kuri taškus atvaizduoja ant
# tiesės. Tačiau ji netinkama POSIX klasės objektui, todėl laiką konvertuojame į 
# skaičių vektorių. Ox ašį suformuojame iš naujo.

s <- as.numeric(t)

stripchart(s, pch = 19, axes = FALSE)
rug(s)

i <- pretty(extendrange(t), 6)
axis(1, at = i, labels = format(i, "%H:%M"))


# Tai, kad funkcija plot gali atvaizduoti POSIX klasės objektą, galima išnaudoti 
# laiko eilučių braižymui. Pavyzdžiui, pavaizduosime kaip per pastarąjį šimtmetį 
# keitėsi Lietuvos gyventojų skaičius.

g <- c(2.75, 2.146, 2.711, 3.1, 3.398, 3.69, 3.46, 3.054)
d <- ISOdate(c(1897, 1923, 1959, 1970, 1979, 1989, 2001, 2011), 12, 31)

plot(d, g, type = "b", xlab = "",  ylab = "gyventojų skaičius", ylim = c(0, 4))


# UŽDUOTIS ------------------------------ 

# 1. Apskaičiuokite, kiek iš viso penktadienių per 2015 metus buvo 13-ta mėnesio 
#    diena.
# 2. Žinoma, kad Mėnulio fazė kartojasi vidutiniškai kas 29 paras 12 val. 44 min.
#    ir 2,9 sekundes (sinodinis mėnuo). Paskutinė 2015-ųjų pilnatis prasidės nuo
#    gruodžio 25 d. 13:11 val. Nustatykite visų pilnačių datas 2016 metais.
# 3. Nubraižykite grafiką, kuriame ant laiko ašies būtų pažymėti Saulės užtemimų 
#    momentai 2016--2021 metų laikotarpyje.


# --------------------------------------- #
# SKIRTUMAS TARP DVIEJŲ LAIKO MOMENTŲ     #
# --------------------------------------- #

# Turint datą ar laiko momentą, prie jo galima pridėti tam tikrą laiko intervalą. 
# Prie datos pridedamas skaičius nurodo dienų skaičių, prie POSIX laiko - nurodo 
# sekundžių skaičių. Pavyzdžiui, prie šios dienos datos pridėsime šimtą dienų ir
# gausime naują datą.

Sys.Date() + 100

# Pavyzdžiui, prie laiko momento pridėsime 120 sekundžių ir tokiu būdu gausime 2
# minutėmis vėlesnį laiko momentą. 

ISOdatetime(2015, 11, 25, 21, 14, 00) + 120

as.POSIXlt("2015-11-25 21:14:00")     + 120


# Turint dvi datas arba du laiko momentus, galima apskaičiuoti skirtumą tarp jų.
# Pvz., nustatysime koks laiko skirtumas tarp atominės bombos sprogimų Japonijos
# miestuose Hiroshima ir Nagasaki.

Hiroshima <- as.POSIXlt("1945-08-06 08:15:00", tz = "Japan")
Nagasakis <- as.POSIXlt("1945-08-09 11:02:00", tz = "Japan")

Nagasakis - Hiroshima

# Pvz., apskaičiuosime, kiek laiko praėjo nuo Hiroshima atominės bombos sprogimo. 

Sys.time() - Hiroshima


# Gautas laiko skirtumas yra "difftime" klasės objektas. Skirtumą galima pridėti 
# arba atimti iš datos arba laiko momento.

d <- Nagasakis - Hiroshima
d

Hiroshima + d
Hiroshima + d == Nagasakis


# Jeigu reikia apskaičiuoti skirtumą tarp dviejų datų arba dviejų laiko momentų, 
# galima naudoti funkciją difftime. Tada galima nurodyti, kokiais vienetais turi 
# būti išreikštas gautas laiko skirtumas. Funkcijos parametrai:
#
#      time1 -- pradinis laiko momentas,
#      time2 -- galutinis laiko momentas,
#         tz -- laiko zona,
#      units -- laiko vienetai: "auto", "secs", "mins", "hours", "days", "weeks".

# Jeigu parametrui units priskiriama reikšmė "auto", tai laiko skirtumas rodomas
# didžiausiais laiko vienetais. Galima pastebėti, kad tarp laiko vienetų mėnesių
# nėra. Taip yra todėl, kad skirtingus mėnesius sudaro skirtingas dienų skaičius.

difftime(Nagasakis, Hiroshima, units = "days")
difftime(Nagasakis, Hiroshima, units = "hours")


# Jeigu turime datų arba laiko momentų vektorių, skirtumus tarp gretimų reikšmių
# galime nustatyti naudojant standartinę funkciją diff. Pavyzdžiui, taip gausime 
# dienomis išreikštus laiko skirtumus tarp didžiausių LDK mūšių datų.

#          Saulės        Durbės        Žalgirio      Oršos         "Salaspilio"
#         ------------  ------------  ------------  ------------  ------------ 
data <- c("1236-09-22", "1260-07-13", "1410-07-15", "1514-09-08", "1605-09-27")
data

t <- as.Date(data, format = "%Y-%m-%d")
t

diff(t)


# Jei duotas laiko skirtumų vektorius, tada į "difftime" formatą jis paverčiamas 
# naudojant funkciją as.difftime. Jos parametrai tokie:
#
#        tim -- laiko skirtumų vektorius, "character" arba "numeric",
#     format -- formatas, kuriuo užrašytas laiko skirtumas,
#      units -- laiko matavimo vienetai, standartiškai "auto".

# Pavyzdžiui, žinomas tam tikrų įvykių laiko trukmės vektorius. Sudarysime laiko
# skirtumų vektorių.

s <- c("01:54:02", "02:11:32", "02:26:45", "02:44:49", "02:57:09", "03:11:08")

d <- as.difftime(s, format = "%H:%M:%S", units = "hours")
d

# "difftime" klasės laiko skirtumus galima apvalinti, sumuoti ir vidurkinti arba 
# skaičiuoti įvairias kitas statistines charakteristikas.

min(d)
max(d)
range(d)
quantile(d)

mean(d)
sum(d)

# Laiko skirtumai gali būti duoti kaip skaitinių reikšmių vektorius. Pavyzdžiui, 
# tie patys laiko skirtumai galėjo būti išreikšti sekundėmis.

s <- c(6842, 7892, 8805, 9889, 10629, 11468)

d <- as.difftime(s, units = "secs")
d


# Laiko skirtumas išmatuotas tam tikrais vienetais, tačiau juos galima pakeisti.
# Tam yra keli skirtingi būdai. Vienas iš jų - naudoti specialią funkciją units.
# Pavyzdžiui, laiko skirtumą tarp šitų dviejų įvykių perskaičiuosime į valandas.

units(d) <- "hours"
d

# Kitas būdas -- laiko skirtumą galima konvertuoti į "numeric" klasės skaičių ir 
# nurodyti, kokiais laiko matavimo vienetais jis turi būti išreikštas.

as.numeric(d, units = "days")
as.numeric(d, units = "secs")


# NAUDINGA ------------------------------

# Funkcija sum turi metodą "difftime" klasės objektui. Tai leidžia sumuoti laiko 
# skirtumus. Tačiau funkcija cumsum tokio metodo (kažkodėl) neturi. Tad sukauptą 
# laiko skirtumų sumą tenka skaičiuoti naudojant standartinę funkciją sum. Pvz.,
# užrašysime tokią funkciją naudojant sapply konstrukciją.

sapply(seq_along(d), function(n) sum(d[1:n]))


# NAUDINGA ------------------------------

# Kartais reikia žinoti, kiek laiko užtrunka tam tikri skaičiavimai. Pavyzdžiui,
# gali dominti, kiek laiko užtrunka viena ciklo iteracija arba reikia nustatyti,
# kuri iš dviejų alternatyvių komandų įvykdoma greičiau.

# Norint sužinoti skaičiavimų trukmę, reikia užfiksuoti laiką, kada prasideda ir
# kada baigiasi skaičiavimai. Tam galima naudoti standartinę funkciją Sys.time(). 
# Pavyzdžiui, apskaičiuosime, kiek laiko užtrunka 100 vektorių su normaliosiomis
# atsitiktinėmis reikšmėmis generavimas ir vidurkinimas.

start <- Sys.time()

  for (i in 1:100) {
    x <- rnorm(1000)
    v <- mean(x)   
  }

stop <- Sys.time()

difftime(stop, start, units = "secs")


# Tam pačiam tikslui galima panaudoti ir funkciją proc.time(), kuri parodo, kiek 
# laiko veikia R.

start <- proc.time()
 
  for (i in 1:100) {
    x <- rnorm(1000)
    v <- mean(x)   
  }

stop <- proc.time()

stop - start


# Jeigu išraiška užrašoma kompaktiškai, tada jos vykdymo trukmę galima nustatyti
# įdėjus ją į funkciją system.time(). Pvz., nustatysime, kuri iš dviejų funkcijų 
# greičiau apskaičiuoja matricos stulpelių vidurkius.

n <- 1000
m <- matrix(rnorm(n*n), ncol = n, nrow = n)

system.time(apply(m, 2, mean))
system.time(colMeans(m))


# UŽDUOTIS ------------------------------ 

# 1. Nustatykite laiko tarpus tarp gretimų pilnų Saulės užtemimų 2016--2021 metų 
#    laikotarpyje.
# 2. Garsioji Halio kometa paskutinį kartą buvo matoma 1986 metais, o perihelyje
#    buvo tų pačių metų vasario 9 d. Jos periodas kintantis, vidutiniškai sudaro 
#    75,3 metus. Nustatykite, sekančio perihelio datą. Kokia gauta paklaida, jei
#    tiksliai žinoma, kad sekantis perihelis bus 2061 liepos 28 dieną?
