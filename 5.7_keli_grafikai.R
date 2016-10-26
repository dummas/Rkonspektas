
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Kelių grafikų viename grafiniame lange braižymas.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2015-02-26 | 2016-03-19
#


# TURINYS -------------------------------

#
#   1. Grafinio lango padalinimas į kelias dalis:
#      * funkcija par su parametrais mfcol ir mfrow
#      * funkcija layout
#      * funkcija layout.show
#
#   2. Braižymo srities apribojimas:
#      * funkcija clip
#      * parametras add
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
# GRAFINIAI PARAMETRAI mfrow IR mfcol     #
# --------------------------------------- #

# Naudojant aukšto lygio grafinę funkciją, pavyzdžiui, plot, hist, barplot, arba 
# atidaromas naujas grafinis langas, arba išvalomas jau atidarytas langas ir tik
# tada braižomas naujas grafikas. Už tai atsakinga pagalbinė funkcija plot.new().
# Naują grafinį langą galima atidaryti naudojant funkciją windows(). 

windows()
plot.new()

# Tokiu būdu galima atidaryti daug grafinių langų, tačiau vis tiek viename lange 
# galima nubraižyti tik vieną grafiką. 

# Tuo atveju, kai grafiniame lange reikia braižyti keletą grafikų, grafinį langą 
# reikia padalinti į keletą dalių. Tam yra keletas būdų. Vienas iš jų -- naudoti
# grafinius parametrus mfrow arba mfcol. Parametras mfrow parodo, į kiek eilučių 
# ir kiek stulpelių padalintas grafinis langas.

par("mfrow")
par("mfcol")

# Jeigu nenurodyta kitaip, grafiniame lange yra viena eilutė ir vienas stulpelis.
# Parametro reikšmė yra du elementus turintis sveikųjų skaičių vektorius. Pirmas
# skaičius nurodo eilučių, antras - stulpelių skaičių. Jeigu grafinis langas yra
# padalinamas į dalis keičiant parametro mfrow reikšmę, tai tos dalys užpildomos 
# grafikais pagal eilutes iš kairės į dešinę. Jeigu keičiama mfcol reikšmė, tada
# grafikai braižomi stulpeliais iš viršaus į apačią. 

# Pavyzdžiui, grafinį langą padalinsime vertikaliai į dvi dalis, nubraižysime du
# skirtingus grafikus.

par(mfrow = c(1, 2))

plot(Temp ~ 1, data = airquality, pch = 20, frame = FALSE)
boxplot(Temp ~ Month, data = airquality, frame = FALSE)


# NAUDINGA ------------------------------

# Dažnai tenka nagrinėti ir tarpusavyje palyginti daug tokio paties tipo grafikų. 
# Tam, kad visi grafikai būtų matomi vienu metu, juos galima nubraižyti į keletą
# dalių sudalintame grafiniame lange. Tarkime, kad eksperimentas pakartojamas 25 
# kartus. Reikia nubraižyti kiekvieno bandymo matavimų histogramas. Čia duomenys 
# duoti matricos pavidalu.

duomenys <- replicate(25, rnorm(200, sample(20, 1)))


# Naują grafinį langą padaliname į 25 mažesnius langus. Papildomai nurodome visų
# langų paraščių pločius.

windows(10, 8)
par(mfrow = c(5, 5), mar = c(2, 2, 1, 1))

# Apskaičiuojame grafikų ašių ribas.

xx <- round(range(duomenys) + c(-0.5, 0.5))
yy <- c(0, 60)


# Funkciją hist įstatome į ciklą. Ant kiekvienos histogramos papildomai uždedame
# duomenų matricos stulpelio numerį.

for (i in 1:ncol(duomenys)) {

  nr <- sprintf("%02d", i)

  hist(duomenys[, i], breaks = 10, xlim = xx, ylim = yy, ann = FALSE)
  mtext(nr, 3, -2, font = 2, adj = 0.9)
}


# NAUDINGA ------------------------------

# Vokiečių dailininko Albrechto Diurerio paveikslas Melencolia I garsus tuo, kad
# jame pavaizduotas magiškas kvadratas. Tai toks kvadratas, kuriame skaičių suma
# eilutėse, stulpeliuose ir įstrižainėse yra vienoda. Nubraižysime tokį kvadratą.
#
#    +----+----+----+----+
#    | 16 | 3  | 2  | 13 |
#    +----+----+----+----+
#    | 5  | 10 | 11 | 8  |
#    +----+----+----+----+
#    | 9  | 6  | 7  | 12 |
#    +----+----+----+----+
#    | 4  | 15 | 14 | 1  |
#    +----+----+----+----+

kvadratas <- c(16, 5, 9, 4, 3, 10, 6, 15, 2, 11, 7, 14, 13, 8, 12, 1)

# Grafinį langą padaliname į 4 stulpelius ir 4 eilutes. Tokiu būdu gauname 4 x 4 
# vienodų langelių, kurie visi yra savarankiški grafikai. Visi kartu jie sudarys
# magišką kvadratą. Kadangi kvadrato skaičiai surašyti pagal stulpelius, grafinį 
# langą sudalinsime naudojant parametrą mfcol.

par(mfcol = c(4, 4))

# Kiekvieno tokio grafiko centre užrašysime po vieną skaičių iš magiško kvadrato.
# Sudarome funkciją, kuri skaičių x užrašo grafiko centre. Nurodome, kad grafiko
# paraštės būtų nulinės, uždraudžiame braižyti koordinačių ašis ir nurodome, kad
# būtų rėmelis uždedamas ant viso grafinio langelio.

centras <- function(x) {

  # Nurodome grafinio lango paraščių plotį.
  par(mar = rep(0, 4))

  plot(0, 0, type = "n", axes = FALSE, ann = FALSE, frame = FALSE)
  text(0, 0, label = x, cex = 4)
  box(which = "figure")
}

# Šią funkciją įstatome į ciklą ir taip skaičiais užpildome visas grafinio lango
# dalis.

for (x in kvadratas) centras(x)


# UŽDUOTIS ------------------------------ 

# 1. 
#    
# 2. 
#    


# --------------------------------------- #
# FUNKCIJA LAYOUT                         #
# --------------------------------------- #

# Jeigu grafinis langas padalinamas į dalis naudojant grafinius parametrus mfrow
# arba mfcol, tada visos tos dalys yra vienodo dydžio. Be to, negalima nustatyti
# tų dalių užpildymo tvarkos. Tokie apribojimai kartais gali sukelti nepatogumų.
# Jų galima išvengti naudojant funkciją layout. Ši f-ja leidžia sukurti grafinio
# lango padalijimo į dalis plano matricą ir nustatyti stulpelių ir eilučių plotį.
# Pagrindiniai jos parametrai šie:
#
#        mat -- matrica, kurios elementai nurodo lango dalių užpildymo tvarką,
#     widths -- grafinio lango stulpelių pločių vektorius,
#    heights -- grafinio lango eilučių aukščių vektorius.

# Plano matricos elementų reikšmės gali būti 0 arba sveikieji teigiami skaičiai. 
# Matricoje gali būti pasikartojančių reikšmių. Tą pačią reikšmę turinčios lango
# dalys yra apjungiamos į vieną. Reikšmė 0 nurodo, kad atitinkama grafinio lango
# dalis nenaudojama.

# Pavyzdžiui, tarkime, kad grafinį langą reikia padalinti į dvi eilutes bei tris 
# stulpelius, o jų užpildymo tvarką nusako tokia matrica:
#
#    +----+----+----+
#    | 1  | 2  | 5  |
#    +----+----+----+
#    | 3  | 4  | 6  |
#    +----+----+----+

# Užrašome grafikų braižymo tvarkos vektorių.
i <- c(1, 2, 5, 3, 4, 6)

# Sudarome 2 x 3 dydžio grafikų išdėstymo plano matricą.
m <- matrix(i, nrow = 2, ncol = 3, byrow = TRUE)
m 

layout(m)

# Naudojant funkciją layout.show, grafiniame lange galima parodyti atskirų langų
# numerius. Šios funkcijos argumentas yra tokių langų skaičius. Nurodysime visus
# šešis langus.

layout.show(6)

# Nubraižome keturis statistinius grafikus. Jie grafiniame lange išdėstomi pagal 
# duodą plano matricą.

plot(Nile)
boxplot(Nile)
hist(Nile)
qqnorm(Nile)


# Sudarysime tokią grafinio lango padalijimo plano matricą, kad tie patys keturi 
# grafikai būtų išdėstyti taip:
#
#    +----+----+----+
#    |      1       |
#    +----+----+----+
#    | 2  | 3  | 4  |
#    +----+----+----+

# Nors plano matrica yra tokio paties dydžio 2 x 3, tačiau šiuo atveju ji aprašo 
# keturias grafinio lango dalis.

i <- c(1, 1, 1, 2, 3, 4)
m <- matrix(i, nrow = 2, ncol = 3, byrow = TRUE)

layout(m)
layout.show(4)

plot(Nile)
boxplot(Nile)
hist(Nile)
qqnorm(Nile)


# Jeigu parametrų widths ir heights reikšmės nenurodomos, tai santykinis eilučių 
# ir stulpelių plotis pagal nutylėjimą yra vienodas ir lygus 1. Keičiant santykį,
# galima reguliuoti eilučių ir stulpelių plotį. Pvz., jei viena eilutė turi būti 
# du kartus platesnė už kitą, tada jos pločio koeficientas taip pat turi būti du 
# kartus didesnis už kitos eilutės pločio koeficientą. 

# Pavyzdžiui, grafinį langą padalinsime į dvi eilutes ir tris stulpelius, tačiau
# šį kartą antros eilutės plotį padarysime dvigubai mažesnį, o stulpelių pločiai 
# tegul lieka vienodi.

layout(m, heights = c(2, 1))
layout.show(4)

plot(Nile)
boxplot(Nile)
hist(Nile)
qqnorm(Nile)


# NAUDINGA ------------------------------

# Grafinį langą suskirstant į keletą įvairaus dydžio dalių, galima sudaryti gana
# sudėtingą diagramą. Pavyzdžiui, nubraižysime dviejų kintamųjų sklaidos grafiką
# ir šalia nubraižysime atskirai vieno ir kito kintamojo stačiakampes diagramas.

# Grafinį langą suskirstysime į 4 dalis: pagrindinėje dalyje braižomas kintamųjų 
# x ir y sklaidos grafikas, antroje ir trečioje stačiakampės diagramos, ketvirta
# dalis nenaudojama. Kadangi stačiakampės diagramos siauros, tai antra eilutė ir
# antras stulpelis bus 4 kartus siauresni nei pirma eilutė ir pirmas stulpelis.

layout(matrix(c(1, 2, 3, 0), 2, 2), widths = c(4, 1), heights = c(4, 1))
layout.show(3)

x <- airquality$Temp
y <- airquality$Ozone

# Pirmiausia nubraižome pagrindinę sklaidos diagramą. Nustatome paraščių pločius.

par(mar = c(2, 3, 1, 1))
plot(x, y, pch = 19, frame = FALSE, las = 1)

# PASTABA. Atskiros grafinio lango dalys yra nesusijusios. Kad iš keleto grafikų 
# sudaryta diagrama būtų teisinga, turi sutapti atskirų grafikų koordinačių ašys.
# Pvz., apačioje braižomos diagramos Ox ašis turi sutapti su pagrindinio grafiko
# Ox ašimi. Šiuo atveju užtenka nustatyti vienodas paraštes iš kairės ir dešinės.
# Kadangi ašys sutapatintos, nurodome, kad naujame grafike ašys nebūtų braižomos.

par(mar = c(0, 3, 0, 1))
boxplot(x, frame = FALSE, axes = FALSE, horizontal = TRUE)

# Kad sutaptų pagrindinio ir šoninio grafiko Oy ašys, nustatome vienodą paraščių
# plotį iš apačios ir viršaus. Kaip ir ankstesniu atveju, ašių nebraižome.

par(mar = c(2, 0, 1, 0))
boxplot(y, frame = FALSE, axes = FALSE)


# UŽDUOTIS ------------------------------ 

# 1. Naudojant funkciją layout, nubraižykite 8 x 8 dydžio šachmatiškai išdėstytų 
#    juodų ir baltų kvadratų diagramą.
# 2. 
#    


# --------------------------------------- #
# BRAIŽYMO SRITIES APRIBOJIMAS            #
# --------------------------------------- #

# Kaip žinoma, visos aukšto lygio grafinės funkcijos atidaro naują grafinį langą
# arba prieš braižant grafiką išvalo jau atidarytą langą. Papildomus taškus arba
# linijas ant grafiko galima nubraižyti naudojant žemo lygio grafines funkcijas. 
# Kai kurios aukšto lygio grafinės funkcijos turi parametrą add. Jeigu priskirta
# reikšmė TRUE, tai naujas grafikas uždedamas ant jau nubraižyto grafiko viršaus.

# Pavyzdžiui, nubraižysime vandens lygio reikšmių histogramą ir ant jos uždėsime
# normaliojo atsitiktinio dydžio teorinės tankio funkcijos grafiką. Tokį grafiką
# grafiką nubraižysime naudojant funkciją curve su parametru add.

hist(Nile, freq = FALSE)

vid <- mean(Nile)
std <- sd(Nile)

curve(dnorm(x, vid, std), add = TRUE)


# Šiuo atveju funkcijos grafikas uždedamas ant visos histogramos. Tačiau grafiko
# sritį, kurioje bus matomas ant viršaus uždedamas kitas grafikas, galima keisti.
# Tam naudojama funkcija clip, kuri sukuria savotišką stačiakampį trafaretą. Jos
# parametrai nurodo to stačiakampio ribas:
#
#         x1 -- kairysis kraštas,
#         x2 -- dešinysis kraštas,
#         y1 -- apatinis kraštas,
#         y2 -- viršutinis kraštas.

# Tarkim, kad reikia nubraižyti funkcijos y = sin(x) grafiką intervale [-pi, pi], 
# tačiau intervale [-2, 1] grafiko linija turi būti raudonos spalvos. Iš pradžių
# nubraižysime paprastą grafiką intervale [-pi, pi], o tada ant viršaus uždėsime 
# antrą kreivę -- trafaretu apribotą raudonos spalvos sinusoidę.

curve(sin, -pi, pi, xlab = "x", ylab = "y", las = 1, frame = FALSE)

# Trafareto ribos iš kairės ir dešinės žinomos, o apatinė ir viršutinė riba gali 
# sutapti su pradinio grafiko apatine ir viršutine riba. Bet kokio grafiko ribas 
# nurodo grafinis parametras usr. Pirmosios dvi reikšmės nurodo grafiko ribas iš 
# kairės ir dešinės, o kitos kitos dvi -- ribas iš apačios ir viršaus. 

usr <- par("usr")
usr

# Nurodome trafareto ribas. Apatinę ir viršutinę ribas paimame iš parametro usr.

clip(-2, 1, usr[3], usr[4])

# Ant viršaus raudona linija braižome antrą sinusoidę. Funkcija curve yra aukšto 
# lygio grafinė funkcija, todėl tam, kad antra kreivė būtų braižoma ant viršaus, 
# parametrui add priskiriame reikšmę TRUE. Atkreipkite dėmesį į tai, kad grafiko
# ribos nurodytos [-pi, pi], bet raudona linija bus matoma tik intervale [-2, 1].

curve(sin, -pi, pi, add = TRUE, col = "red", lwd = 2)

# Kartą nustatytos trafareto ribos tokios ir išlieka. Pvz., ant grafiko uždėsime 
# tinklelį, tačiau jis vis tiek bus matomas tik intervale [-2, 1].

grid()

# Norint sugrąžinti pradinę braižymo sritį, trafareto ribas reikėtų išplėsti iki
# pradinio grafiko ribų. Tam galima panaudoti prieš tai išsaugotas parametro usr
# reikšmes ir perduoti jas funkcijai clip per tokią konstrukciją:

do.call(clip, as.list(usr))


# UŽDUOTIS ------------------------------ 

# 1. Nubraižykite kintamojo Nile reikšmių histogramą, kurioje stulpeliai į kairę 
#    nuo pirmojo ir į dešinę nuo trečiojo kvartilio būtų nuspalvinti raudonai.
# 2. 
#    