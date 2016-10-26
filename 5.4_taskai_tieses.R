
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Žemo lygio grafinės funkcijos: taškai, linijos ir tiesės.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2014-04-25 | 2014-06-08 | 2015-02-28
#


# TURINYS -------------------------------

#
#   1. Grafikus papildančios funkcijos:
#      * funkcija points
#      * funkcija lines
#      * funkcija abline
#
#   2. Kintamųjų iš matricos stulpelių braižymas:
#      * funkcija matplot
#      * funkcija matpoints
#      * funkcija matlines
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
# AUKŠTO IR ŽEMO LYGIO GRAFINĖS FUNKCIJOS #
# --------------------------------------- #

# Visas R grafines funkcijas sąlyginai galima padalinti į dvi dideles grupes:
#
#   1) aukšto lygio grafinės funkcijos,
#   2) žemo lygio grafinės funkcijos.
#
# Aukšto lygio grafinės funkcijos yra skirtos baziniam tam tikro tipo grafiko ar
# diagramos braižymui. Toks grafikas turi suformuotą koordinačių sistemą, ašis,
# antraštes ir visus kitus tokio tipo grafikui reikalingus elementus. Žemo lygio
# grafinės funkcijos yra skirtos jau suformuotų grafikų papildymu tam tikrais jo
# elementais: papildomais taškais, linijomis, kitokiomis nei standartinės ašimis,
# tekstu ir kitais elementais.

# Aukšto lygio grafinės funkcijos visada suformuoja ir nubraižo naują grafiką, o
# žemo lygio funkcijos taškus, linijas arba kitus grafinius elementus uždeda ant 
# jau sudaryto grafiko.

# Didelę dalį dažniausiai naudojamų grafikų galima nubraižyti naudojant funkciją
# plot, tačiau kai kuriuos grafikus ir diagramas patogiau braižyti naudojant tam
# skirtas specializuotas funkcijas. 


# --------------------------------------- #
# PAPILDOMI TAŠKAI                        #
# --------------------------------------- #

# Taškai su koordinatėmis (x, y) ant jau nubraižyto grafiko uždedami naudojant 
# funkciją points. Pagrindiniai jos parametrai:
#
#          x -- x reikšmių vektorius,
#          y -- y reikšmių vektorius,
#        pch -- taško simbolis,
#        cex -- taško simbolio dydis,
#        col -- taško spalva.
#
# Iš dalies galima sakyti, kad f-ja points(x, y) yra f-ja plot(x, y, type = "p"),
# tačiau ji dažniausiai naudojama tuo atveju, kai ant kitos funkcijos nubraižyto 
# grafiko tam tikrose vietose dar reikia uždėti vieną ar kelis papildomus taškus.

# Pavyzdžiui, ant taškų su koordinatėmis (x y) sklaidos diagramos uždėsime vieną
# raudoną tašką su koordinatėmis (2, 2).

x <- c(2.0, 1.6, 1.2, 1.0, 1.0, 1.3, 1.6, 2.0, 2.3, 2.8, 2.8, 3.0, 2.8, 2.4, 2.1)
y <- c(0.8, 1.1, 1.3, 1.6, 2.2, 2.5, 2.9, 3.1, 3.0, 2.8, 2.4, 1.8, 1.4, 1.0, 0.9)

plot(x, y, asp = 1)
points(2, 2, pch = 19, col = "red")

# Ant jau nubraižytos diagramos uždėsime vienetinio apskritimo su centru (2, 2)
# taškus. Jų koordinates (a, b) apskaičiuosime atskirai.

k <- 1:360
a <- cos(k) + 2
b <- sin(k) + 2

points(a, b, pch = ".")


# Vieną ar kelis taškus galima uždėti ant bet kokios kitos diagramos. Gana dažna
# situacija, kada reikia papildyti kokios nors kitos grafinės funkcijos sudarytą
# standartinę diagramą. Pvz., naudojant duomenų lentelę airquality, nubraižysime
# atskirų mėnesių oro temperatūros boxplot diagramas. Ant jų papildomai uždėsime
# vidutinę mėnesio temperatūrą žyminčius taškus.

temp.vid <- with(airquality, tapply(Temp, Month, mean))
temp.vid

# Kadangi lentelėje yra penkių mėnesių duomenys, nubraižomos penkios diagramos,
# kurios ant Ox ašies atidedamos ties taškais x = 1, x = 2 ir t.t. 

boxplot(Temp ~ Month, data = airquality)
points(x = 1:5, y = temp.vid, col = "red", pch = 19, cex = 1.2)


# Funkcijai points taškų koordinates galima nurodyti ir per jų sąryšio formulę.
# Pvz., ant pagal mėnesius suskirstytos temperatūros boxplot diagramos uždėsime 
# visas atitinkamo mėnesio temperatūrų reikšmes. 

# Pagal nutylėjimą funkcija boxplot diagramas ant Ox ašies atideda ties taškais 
# x = 1, x = 2 ir t.t., tačiau kintamojo Month reikšmės kinta nuo 5 iki 9. Tam,
# kad vieno mėnesio temperatūros reikšmės būtų atidedamos ant atitinkamo mėnesio
# boxplot diagramos, jos taip pat turi būti atidedamos ties taškais x = 5, x = 6 
# ir t.t. Tokį diagramos postūmį ant ašies Ox galima atlikti naudojant funkcijos 
# boxplot parametrą at.

boxplot(Temp ~ Month, data = airquality, at = 5:9)
points(Temp ~ Month, data = airquality, pch = 20, col = 3)


# Iš praėjusio pavyzdžio aišku, kad, norint teisingai uždėti taškus ant sudaryto
# grafiko, reikia prisiderinti prie to grafiko koordinačių sistemos. Čia galima
# pasinaudoti tuo, kad aukšto lygio grafinės funkcijos ne tik nubraižo diagramą,
# bet ir leidžia išsaugoti jai nubraižyti reikalingas statistikas. 

# Pavyzdžiui, nubraižysime temperatūros histogramą ir uždėsime stulpelių vidurį 
# žyminčius taškus. Jų koordinates pasiimsime iš f-jos hist sukurto histogramos 
# objekto.

t <- as.numeric(nhtemp)

histat <- hist(t, xlim = c(46, 56), main = "Temperatūros pasiskirstymas")
histat

# Iš histogramos objekto pasiimame tik intervalų centrų vektorių.

x <- histat$mids
y <- rep(0, length(x))

points(x, y, pch = 19, col = "red")


# Keičiant parametro type reikšmę, galime keisti stilių, kuriuo funkcija points 
# vaizduoja taškus. Pavyzdžiui, nubraižysime f-jos y = sin(x) grafiką intervale
# [-pi, pi] ir kas pi/8 išdėstytus taškus sujungsime laiptuota linija: viena po
# funkcijos grafiku, kita -- virš jo.

curve(sin, -pi, pi)

x <- seq(-pi, pi, pi/8)
y <- sin(x)

points(x, y, pch = 19)
points(x, y, type = "s")
points(x, y, type = "S")


# Dar vienas pavyzdys. Nubraižysime standartinio normaliojo pasiskirstymo tankio 
# funkcijos grafiką, o plotą po tankio funkcija padalinsime į lygias dalis pagal 
# kvartilius. Kvartilius ir tankio funkcijos reikšmes juose pažymėsime taškais.
# Pasinaudosime tuo, kad keičiant parametro type reikšmę, galima nustatyti taškų
# atvaizdavimo stilių.

# Pirmiausia sudarome kvartilius atitinkančių tikimybių vektorių p, tada randame
# pačių kvantilių reikšmes ir apskaičiuojame tankio funkcijos reikšmes kvartilių
# taškuose. Kvantilius q atidedame ant Ox ašies ir ant tankio funkcijos grafiko.

curve(dnorm, -3, 3, ylab = "p(x)", las = 1, frame = FALSE)

p <- c(0.25, 0.5, 0.75)
q <- qnorm(p)
d <- dnorm(q)

points(q, d, type = "h", col = "red")
points(q, d, pch = 19)
points(q, d-d, pch = 19)


# NAUDINGA ------------------------------

# Jei sudėtingoje diagramoje yra kelios pasikartojančios grafinės konstrukcijos, 
# jas galima užrašyti kaip funkciją. Keičiant funkcijos parametrus galima keisti
# grafinės konstrukcijos diagramoje vietą, dydį ir kitas charakteristikas. 

# Pavyzdžiui, p lygio kvantilį atitinkančią atkarpą ant tankio funkcijos grafiko
# uždėsime naudojant specialią funkciją add.line. Jos parametras p yra kvantilio
# lygis, 0 < p < 1. 

curve(dnorm, -3, 3, ylab = "p(x)", las = 1, frame = FALSE)


add.line <- function(p) {

  q <- qnorm(p)
  d <- dnorm(q)

  points(q, d, type = "h", col = "red")
  points(q, d, pch = 19)
  points(q, 0, pch = 19)
}

add.line(0.1)
add.line(0.2)
add.line(0.3)

# Jei tokių kvantilius atitinkančių atkarpų ant grafiko reikia uždėti ir daugiau, 
# jas braižančią funkciją galima įdėti į ciklą.

p <- c(0.4, 0.5, 0.6, 0.7, 0.8, 0.9)

for (i in p) add.line(i)


# UŽDUOTIS ------------------------------ 

# 1. Duotas dažnių vektorius (3, 2, 5, 3, 1). Nubraižykite stulpelinę šių dažnių 
#    diagramą. Kiekvieno stulpelio centre (pagal plotį ir pagal aukštį) uždėkite
#    raudoną tašką.
# 2. Naudojant funkciją plot, grafike atidėkite tašką su koordinatėmis (10, 10). 
#    Keisdami tik to paties vieno taško simbolio dydį, gaukite grafiką, kuriame 
#    yra keletas koncentriškų apskritimų.


# --------------------------------------- #
# PAPILDOMOS KREIVĖS                      #
# --------------------------------------- #

# Tuo atveju, kai papildomai uždėtus taškus reikia sujungti, naudojama funkcija 
# lines. Galima sakyti, kad f-ja lines(x, y) yra f-ja plot(x, y, type = "l"). Iš 
# esmės skiriasi tik tuo, kad funkcija lines naudojama taškų ir linijų uždėjimui 
# ant jau nubraižyto grafiko. Pagrindiniai šios funkcijos parametrai:
# 
#          x -- x reikšmių vektorius,
#          y -- y reikšmių vektorius,
#        lty -- linijos tipas,
#        lwd -- linijos storis,
#        col -- linijos spalva.

# Pavyzdžiui, ant anksčiau sudarytos temperatūros histogramos uždėsime poligoną. 
# Tai tokia kreivė, kuri sudaryta iš atkarpomis sujungtų taškų (x, y). Čia x yra
# histogramos stulpelio vidurio taškas, o y -- to paties stulpelio aukštis. Šias
# koordinates pasiimsime iš to paties anksčiau sudaryto histogramos objekto.

histat

x <- histat$mids
y <- histat$counts

plot(histat, xlim = c(46, 56), main = "Temperatūros pasiskirstymas")
lines(x, y, type = "b", pch = 19, col = "red")


# Nubraižysime į mėnesius suskirstytos temperatūros sklaidos diagramą ir mėnesių
# temperatūros vidurkių taškus sujungsime atkarpomis.

plot(Temp ~ Month, data = airquality, pch = 20)

temp.vid <- with(airquality, tapply(Temp, Month, mean))
temp.vid

lines(x = 5:9, y = temp.vid, type = "b", pch = 19, col = "red")


# UŽDUOTIS ------------------------------ 

# 1. Duomenų lentelėje cars yra automobilio greičio ir stabdymo atstumo duomenys.
#    Nubraižykite šių kintamųjų sklaidos diagramą. Kiekvienai skirtingai greičio
#    reikšmei apskaičiuokite stabdymo atstumo vidurkį. Gautus taškus uždėkite ant
#    grafiko ir sujunkite juos tiesės atkarpomis.


# --------------------------------------- #
# TIESĖS BRAIŽYMAS                        #
# --------------------------------------- #

# Tiesės atkarpą galima nubraižyti naudojant bendro pobūdžio funkcijas plot arba
# lines -- užtenka nurodyti dviejų taškų koordinates. Dėl tos pačios priežasties
# šis būdas nėra patogus. 

# Tiesės plokštumoje lygtis y = a + bx. Ją vienareikšmiškai nusako du parametrai:
# a ir b. Norint nubraižyti vertikalią ar horizontalią tiesę, užtenka žinoti tik
# tašką, kuriame ši tiesė kerta Ox arba Oy ašį. Tokių tiesių braižymui naudojama
# funkcija abline. Pagrindiniai jos parametrai:
#
#          a -- tiesės y = a + bx parametras a,
#          b -- tiesės y = a + bx parametras b,
#          h -- taškas, kuriame ašį Oy kerta horizontali tiesė,
#          v -- taškas, kuriame ašį Ox kerta vertikali tiesė,
#        col -- tiesės spalvos pavadinimas arba numeris,
#       type -- tiesės tipas, 1 ištisinė, 2 punktyrinė ir t.t.


# Pavyzdžiui, nubraižysime temperatūros kitimo laike grafiką ir uždėsime ant jo
# horizontalią liniją ties 80 laipsnių riba.

plot(Temp ~ 1, data = airquality, pch = 20)
abline(h = 80)

# Tiesę galima uždėti ant bet kokio grafiko. Pavyzdžiui, nubraižysime stulpelinę
# diagramą, kurioje pavaizduotas Titaniko keleivių skaičius atskirose klasėse ir
# ant jos uždėsime vidutinį keleivių skaičių žyminčią horizontalią liniją.

d <- margin.table(Titanic, 1)
barplot(d)
abline(h = mean(d))


# Norint nubraižyti pasvirą tiesę y = a + bx, funcijai abline nurodome parametrų 
# a ir b reikšmes. Pavyzdžiui, taip uždėsime funkcijos f(x) = x + 1/x vertikalią
# ir pasvirąją asimptotes.

fx <- function(x) x + 1/x
curve(fx, -5, 5, col = "red", main = "Funkcijos y = x + 1/x asimptotės")
abline(a = 0, b = 1, v = 0, lty = 5)


# Parametrams v ir h galima nurodyti iš karto kelias reikšmes. Tokiu būdu galima
# nubraižyti iš karto daug horizontalių ar vertikalių linijų. 

plot(Temp ~ Month, data = airquality, type = "n")
abline(v = 5:9, h = 60:90, col = "gray")
points(Temp ~ Month, data = airquality, pch = 19)


# NAUDINGA ------------------------------

# Vienas iš tipinių duomenų analizės uždavinių -- nustatyti kintamųjų tarpusavio
# ryšį. Paprastai prieš sudarant statistinį modeli braižomos kintamųjų diagramos.

x <- c(9.5, 4.0, 4.9, 8.1, 9.9, 2.6, 8.7, 4.4, 4.3, 3.2, 2.2, 9.2, 5.0, 3.2, 7.4)
y <- c(8.7, 6.1, 6.0, 7.7, 9.9, 5.1, 9.5, 5.3, 5.6, 5.8, 4.5, 8.8, 6.6, 5.9, 8.2)

plot(x, y, pch = 19)

# Iš sklaidos diagramos matome, kad taškai išsibarstę apie tiesę. Kad kintamieji
# tiesiškai susiję, rodo ir artimas vienetui koreliacijos koeficientas.

cor(x, y)

# Paprastai kintamųjų y ir x regresijos tiesės y = a + bx parametrai nežinomi ir 
# vertinami iš duomenų. Tiesinės regresijos modelio parametrams a ir b įvertinti 
# naudojama standartinė funkcija lm.

lm(y ~ x)

# Turint parametrų a ir b įverčius, juos galima surašyti į funkciją abline. Taip
# gauname regresijos tiesės grafiką.

abline(a = 3.3900, b = 0.6103)

# Tam, kad tiesės parametrų nereikėtų kopijuoti ar perrašinėti, funkcijai abline
# kaip parametrą galima perduoti funkcijos lm grąžinamą rezultatų objektą.

modelis <- lm(y ~ x)
modelis

abline(modelis)


# Tokiu būdu, apjungiant kai kurias komandas, dviejų kintamųjų sklaidos diagramą
# ir jų regresijos tiesės grafiką galima gauti labai paprastai ir greitai.

plot(x, y)
abline(lm(y ~ x))


# UŽDUOTIS ------------------------------ 

# 1. Kintamasis Nile yra vandens lygio Nilo upėje laiko eilutė. Nubraižykite jos
#    grafiką ir uždėkite vidutinį vandens lygį žyminčią raudonos spalvos liniją.
# 2. Nubraižykite temperatūros iš duomenų lentelės airquality kitimo laike taškų
#    sklaidos diagramą. Tada vertikaliomis tiesėmis atskirkite kiekvieno mėnesio 
#    stebinius.


# --------------------------------------- #
# MATRICOS STULPELIŲ BRAIŽYMAS            #
# --------------------------------------- #

# Gana dažnai pasitaiko situacija, kada reikia nubraižyti iš karto daug kreivių,
# kurių koordinatės surašytos matricos stulpeliuose. Šiuo atveju įprasta naudoti
# specialias funkcijas:
#
#    matplot -- nubraižo kreives arba taškų sklaidos diagramą,
#  matpoints -- uždeda ant grafiko taškus,
#   matlines -- uždeda ant grafiko linijas.


# Šios f-jos yra standartinių funkcijų plot, points ir lines matricinės versijos.
# Pagrindiniai parametrai yra šie:
#
#          x -- vektorius arba matrica su x koordinatėmis,
#          y -- vektorius arba matrica su y koordinatėmis.

# Matricų x ir y eilučių skaičius turi būti vienodas. Tada taškus (x, y) gauname
# iš matricų x ir y imdami stulpelius su vienodais numeriais. Stulpelių skaičius
# gali būti nevienodas. Pavyzdžiui, jei kelios y reikšmės gautos prie tos pačios
# x reikšmės, tai užtenka, kad matrica x turėtų tik vieną stulpelį.

# Pavyzdžiui, nubraižysime 1000 atsitiktinio klaidžiojimo su dreifu trajektorijų.
# Vieną trajektoriją sudaro 100 taškų, kurių x koordinatė sutampa, todėl matrica
# X turi tik vieną stulpelį.

X <- matrix(1:100)
X

Y <- replicate(1000, cumsum(rnorm(100)))
Y

# Jei nenurodyta kitaip, f-ja matplot kiekvienos kreivės taškus žymi skirtingais 
# simboliais. Be to, kiekviena kreivė turi savo spalvą. Tai kontroliuoja įprasti
# grafiniai parametrai: type, lty, lwd, col ir t.t. Čia nustatysime, kad kreivės
# būtų permatomos ištisinės linijos.

matplot(X, Y, type = "l", lty = 1, col = rgb(0, 0, 0, 0.1))

# Tokiu atveju, kai x koordinatė nurodo tik taško eilės numerį, užtenka nurodyti 
# tik Y koordinačių matricą.

matplot(Y, type = "l", lty = 1, col = rgb(0, 0, 0, 0.1))


# Naudojant funkciją matlines, ant jau nubraižyto grafiko uždėsime dvi kraštines
# trajektorijas: žemiausią ir aukščiausią. Jų koordinates atrinksime iš pradinių 
# duomenų matricos Y ir sudarysime matricą su dviem stulpeliais Z.

Z <- t(apply(Y, 1, range))
Z

matlines(X, Z, lty = 1, col = "red")


# UŽDUOTIS ------------------------------ 

# 1. Ant 1000 kreivių grafiko uždėkite suvidurkintos trajektorijos taškus. Taško
#    simbolį pakeiskite, nustatykite taško spalvą ir dydį.
