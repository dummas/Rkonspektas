
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Pagrindinės aukšto lygio grafinės funkcijos.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2014-03-29 | 2014-04-24
#


# TURINYS -------------------------------

#
#   1. Aukšto lygio grafinės funkcijos:
#      * funkcija curve
#      * funkcija barplot
#      * funkcija boxplot
#      * funkcija hist
#


# PASTABOS ------------------------------

#
# Parašyti apie curve parametrą xname.
# Sugalvoti uždavinių funkcijai boxplot.
# Parašyti apie barplot parametrą axis.lty.
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
# FUNKCIJA CURVE                          #
# --------------------------------------- #

# Funkcija curve naudojama vieno kintamojo funkcijos y = f(x) grafiko braižymui. 
# Pagrindiniai jos parametrai:
#
#       expr -- funkcijos f(x) pavadinimas,
#       from -- intervalo [a, b] reikšmė a,
#         to -- intervalo [a, b] reikšmė b,
#          n -- taškų skaičius intervale [a, b],
#        add -- FALSE, nurodo ar grafiką uždėti ant jau sudaryto grafiko.

# Sudarant funkcijos f(x) intervale [a, b] grafiką, šis intervalas padalinamas į 
# 100 lygių dalių, kurias viena nuo kitos atskiria n = 101 taškų. Tuose taškuose
# skaičiuojamos funkcijos y = f(x) reikšmės ir gaunamos taškų (x, y) koordinatės.

# Paprasčiausiu atveju funkcijai curve galima nurodyti bet kokios standartinės R 
# funkcijos pavadinimą ir intervalo, kuriame nubraižomas šios funkcijos grafikas, 
# ribas. Pvz., nubraižysime funkcijos y = sin(x) grafiką intervale [-pi, pi].

curve(sin, from = -pi, to = pi)

# Kaip visada, jei parametrai užrašomi nustatyta tvarka, jų pavadinimų galima ir
# nerašyti. Taip gaunama paprastesnės ir lengviau perskaitoma išraiška.

curve(sin, -pi, pi)

# Standartines R funkcijas galima panaudoti kitų funkcijų sudarymui. Pavyzdžiui,
# R turi funkciją y = sin(x), tačiau neturi funkcijos y = sin(2x). Jos išraišką 
# kaip argumentą galima įrašyti tiesiai į funkciją plot.

curve(sin(2*x), -pi, pi)

# Sudėtingų funkcijų išraišką geriau užrašyti kaip R funkcija ir duoti jai vardą.
# Pvz., nubraižysime racionalios trupmenos y = x/(x^2 + x + 1) intervale [-5, 5] 
# grafiką. Pirmiausia jos išraišką užrašysime kaip R funkciją.

fun.rt <- function(x) {
  y <- x/(x^2 + x + 1)
  return(y)
}

curve(fun.rt, -5, 5)


# Funkcija curve yra aukšto lygio grafinė funkcija, todėl kiekvieną kartą braižo 
# naują grafiką, tačiau jos parametrui add priskyrus reikšmę TRUE, naują grafiką 
# galima uždėti ant jau nubraižyto grafiko viršaus. Pvz., nubraižysime funkcijos 
# y = sin(kx)/k intervale [-pi, pi] grafikus, kai parametro k reikšmė kinta nuo 
# 1 iki 4. Iš pradžių užrašysime tokios funkcijos išraišką.

fun.si <- function(x, k) {
  y <- sin(k*x)/k
  return(y)
}

# Ši funkcija yra dviejų kintamųjų funkcija. Tam, kad funkcija curve ją parodytų
# teisingai, vieną parametrą fiksuosime -- priskirsime jam reikšmę. Tokiu būdu
# funkcija tampa vieno kintamojo funkcija, kurios grafiką curve gali nubraižyti.

curve(fun.si(x, k = 1), -pi, pi)

# Grafikus su kitomis parametro k reikšmėmis uždėsime ant jau nubraižyto grafiko
# viršaus.

curve(fun.si(x, k = 2), -pi, pi, add = TRUE)
curve(fun.si(x, k = 3), -pi, pi, add = TRUE)
curve(fun.si(x, k = 4), -pi, pi, add = TRUE)


# NAUDINGA ------------------------------

# Pasikartojančią išraišką galima įdėti į ciklą ir tokiu būdu keisti parametro k 
# reikšmę. Funkcinio programavimo apologetai gali naudoti konstrukciją su sapply 
# ir viską užrašyti viena eilute. Pastaba, parametro add reikšmę nustatome pagal
# loginę sąlygą -- tikrinama ar parametro k reikšmė didesnė už vienetą. Jei taip, 
# tai add įgyja reikšmę TRUE, priešingu atveju priskiriama reikšmė FALSE.

sapply(1:16, function(k) curve(fun.si(x, k), -pi, pi, add = k > 1))


# UŽDUOTIS ------------------------------ 

# 1. Naudojant funkciją curve nubraižykite funkcijos y = ln(x) grafiką intervale 
#    (0, 1]. Pakeiskite komandą taip, kad grafike ašies Oy ribos būtų [-5, 5].
# 2. Nubraižykite standartinio normaliojo skirstinio tankio funkcijos grafiką
#    intervale [-4, 4]. 
# 3. Nubraižykite atsiktinio dydžio, pasiskirsčiusio tolygiai intervale [2, 5],
#    tankio funkcijos grafiką. Ašies Ox ribos tegul bus [0, 7].
# 4. Ant vieno grafiko nubraižykite funkcijų y = sin(x) ir y = cos(x) grafikus
#    intervale [-pi, pi]. Tegul vienos funkcijos grafikas bus raudonos spalvos.
# 5. Ant vieno grafiko nubraižykite tris normaliojo skirstinio tankio funkcijos 
#    variantus: su vidurkiu 0, su vidurkiu 1 ir su vidurkiu 3. Visais atvejais
#    standartinis nuokrypis tegul būna vienodas ir lygus 1.


# --------------------------------------- #
# FUNKCIJA BARPLOT                        #
# --------------------------------------- #

# Funkcija barplot naudojama stulpelinių diagramų braižymui. Paprastai naudojami
# šie parametrai:
#
#     height -- stulpelių aukščių vektorius arba matrica,
#      width -- stulpelių pločių vektorius,
#      space -- tarpo tarp stulpelių reikšmė,
#      horiz -- FALSE, nurodo ar stulpeliai bus braižomi horizontaliai,
#     beside -- FALSE, nurodo ar tos pačios grupės stulpelius braižyti greta,
#        add -- FALSE, nurodo ar diagramą uždėti ant jau sudaryto grafiko.

# Pačiu paprasčiausiu atveju funkcijai barplot galima nurodyti sveikųjų skaičių
# vektorių. Kiekvienas vektoriaus elementas atitinka vieną diagramos stulpelį, o 
# jo aukštis lygus atitinkamo vektoriaus elemento reikšmei.

h <- c(3, 2, 5, 3, 1)

barplot(height = h)

# Jei parametrai surašomi nustatyta tvarka, tai jų pavadinimų galima ir nerašyti. 

barplot(h)

# Pačiu bendriausiu atveju, vektoriaus, pagal kurį braižoma diagrama, elementai 
# gali būti bet kokie realūs skaičiai. Neigiamus vektoriaus elementus diagramoje 
# atitinka "neigiamo" aukščio stulpeliai.

h <- c(-2, 2.5, 5, 3, -0.5)

barplot(h)

# Stulpelių plotis nustatomas keičiant parametro width reikšmę. Stulpeliai gali
# būti ir nevienodo pločio. Tokiu atveju parametrui width perduodamas stulpelių 
# pločių reikšmių vektorius.

barplot(h, width = 1:5)

# Stulpeliai vienas nuo kito atskirti tarpu, kurio plotis proporcingas stulpelio
# pločiui. Pagal nutylėjimą proporcingumo koef. lygus 0.2 ir gali būti pakeistas 
# nustatant kitą parametro space reikšmę. Jeigu parametras space = 1, tai tarpai 
# tarp stulpelių bus tokio paties pločio kaip ir stulpeliai.

barplot(h, space = 0)
barplot(h, space = 1)

# Tam, kad stulpeliai diagramoje būtų braižomi horizontaliai, naudojamas loginis 
# parametras horiz. Pagal nutylėjimą jo reikšmė yra FALSE.

barplot(h, horiz = TRUE)

# Suprantama, galima keisti standartinius grafinius parametrus. Pvz., papildomai 
# nustatysime ašies Oy ribas, stulpelių spalvą ir pagrindinę diagramos antraštę.

barplot(h, ylim = c(-5, 8), col = "red", main = "Stulpelinė diagrama")


# Labai dažnai funkcija barplot naudojama įvairioms dažnių lentelėms atvaizduoti.
# Kaip pavyzdį panaudosime laivo "Titanic" įvairių kategorijų keleivių skaičiaus
# duomenų lentelę Titanic.

Titanic

dimnames(Titanic)

# Titanic yra keturių kintamųjų kryžminė dažnių lentelė. Sumuodami tokią lentelę 
# pagal vieną kurį nors kintamąjį, gauname to kintamojo reikšmių dažnių lentelę. 
# Pavyzdžiui, sudarysim skirtinga klase keliavusių keleivių skaičiaus lentelę ir
# nubraižysime ją atitinkančią stulpelinę diagramą.

d <- margin.table(Titanic, 1)
d

barplot(d)

# Analogiškai iš pradinės lentelės galima gauti dviejų kintamųjų kryžminę dažnių 
# lentelę. Pavyzdžiui, sudarysime keleivio klasės ir lyties dažnių lentelę ir ją
# atvaizduosime diagramos pavidalu.

d <- margin.table(Titanic, c(2, 1))
d

barplot(d)

# Matome, kad dažniai atskirai paimtoje kategorijoje vaizduojami vienu stulpeliu.
# Naudojant parametrą beside, juos galima išskaidyti į atskirus stulpelius.

barplot(d, beside = TRUE)

# Keičiant atstumą tarp stulpelių, parametrui space reikia perduoti vektorių su
# dviem reikšmėmis: antroji nurodo tarpą tarp skirtingų grupių, o pirmoji nurodo
# tarpą tarp stulpelių grupės viduje.

barplot(d, beside = TRUE, space = c(0.1, 0.8))


# NAUDINGA ------------------------------

# Funkcija barplot turi nemažai kitų parametrų, kuriais galima keisti diagramos
# išvaizdą: stulpelių ir atskirų jų dalių spalvą, leisti arba uždrausti braižyti 
# ašis ir rašyti jų pavadinimus. Keletas iš jų:
#
#        col -- stulpelių spalvų numerių ar pavadinimų vektorius,
#     border -- stulpelių rėmelio spalva,
#  names.arg -- stulpelių pavadinimų vektorius,
#  axisnames -- TRUE, nurodo ar rodyti ašių pavadinimus,
#       axes -- TRUE, nurodo ar rodyti ašis,
#       plot -- TRUE, nurodo ar braižyti diagramą.

# Naudojant parametrą col, galima keisti stulpelių spalvą. Kadangi kiekvienoje
# grupėje yra po du stulpelius, parametrui priskiriame vektorių su dviem spalvų
# pavadinimais.

barplot(d, beside = TRUE, col = c("lightblue", "cornsilk"))

# Vietoje konkrečių spalvų galima nurodyti kokią nors spalvų paletę. Pavyzdžiui,
# parametrui col nurodysime trijų pilkos spalvos atspalvių paletę.

barplot(d, col = gray.colors(3))

# Naudojant parametrą border, galima pakeisti stulpelio rėmelio spalvą.

barplot(d, border = 3)

# Parametrui border priskyrus reikšmę NA, rėmelis apie stulpelį nebraižomas.

barplot(d, border = NA)


# Jei dažnių lentelė turi vardus, funkcija barplot juos naudoja grupėms pažymėti. 
# Naudojant parametrą names.arg šiuos grupių užrašus galima pakeisti. Pavyzdžiui,
# pakeisime dažnių lentelės d keleivių klasės pavadinimus.

barplot(d, names.arg = c("Pirma", "Antra", "Trečia", "Įgula"))

# Užrašus ant ašių galima uždrausti naudojant parametrą axisnames.

barplot(d, axisnames = FALSE)

# Naudojant parametrą axes, galima uždrausti ašių rodymą.

barplot(d, axes = FALSE)

# Naudojant parametrą plot, galima uždrausti braižyti ir pačią diagramą. Tokiu
# atveju funkcijos rezultatas yra matrica su stulpelių aukščiais.

barplot(d, plot = FALSE)


# Funkcija barplot ne tik nubraižo stulpelinę diagramą, bet jos rezultatą galima
# priskirti kintamajam. Taip gauname diagramos stulpelių vidurio taškų vektorių. 
# Jei sudaroma grupuota stulpelinė diagrama, tai rezultatas yra gaunama matrica, 
# kurios stulpeliuose yra diagramos vienos grupės stulpelių vidurio taškai. 

barstat <- barplot(d)
barstat


# UŽDUOTIS ------------------------------ 

# 1. Sukurkite vektorių n = (1, 3, 2, 5, 4). Nubraižykite tokią šio vektoriaus n 
#    stulpelinę diagramą, kurioje visų stulpelių spalva būtų skirtinga.
# 2. Nubraižykite vektoriaus n stulpelinę diagramą ir kiekvienam jos stulpeliui 
#    suteikite vardą.
# 3. Nubraižykite vektoriaus n stulpelinę diagramą, kurioje kiekvieno stulpelio 
#    plotas būtų lygus vienetui.
# 4. Naudodami duomenų lentelę HairEyeColor, sudarykite kryžminę akių ir plaukų 
#    spalvos dažnių lentelę. Parametrui legend priskirkite reikšmę TRUE ir taip
#    ant diagramos uždėkite legendą. Kokia akių spalva rečiausia tarp blondinų?


# --------------------------------------- #
# FUNKCIJA BOXPLOT                        #
# --------------------------------------- #

# Vieno arba kelių kintamųjų stačiakampei diagramai braižyti naudojama funkcija 
# boxplot. Pagrindiniai jos parametrai:
#
#          x -- kiekybinio kintamojo reikšmių vektorius,
#       data -- duomenų lentelės pavadinimas,
#     subset -- loginė sąlyga, kuri išskiria dalį duomenų lentelės stebinių,
#         at -- vektorius su reikšmėmis, kuriose atidedama stačiakampė diagrama,
# horizontal -- FALSE, nurodo ar diagrama bus braižoma horizontaliai,
#        add -- FALSE, nurodo ar diagramą uždėti ant jau sudaryto grafiko.

# Pavyzdžiui, nubraižysime kiekybinio kintamojo s stačiakampę diagramą.

s <- c(0.6, 3.4, 6.1, 0.7, 5.2, 1.4, 2.3, 3.4, 2.5, 9.4, 2.7, 4.1, 2.9, 0.1, 7.5)
k <- c("T", "N", "N", "T", "T", "T", "N", "T", "T", "N", "T", "N", "T", "T", "N")

boxplot(s)

# Diagramoje matome, kokiose ribose kinta kintamojo reikšmės, kam lygi kintamojo
# mediana, atskirai pažymimos labai mažos arba labai didelės kintamojo reikšmės.
# Jei kiekybinio kintamojo s reikšmės yra iš skirtingų grupių, galima nubraižyti
# stačiakampes diagramas kiekvienoje grupėje atskirai.

boxplot(s ~ k)

# Jei vienas ar keli stačiakampei diagramai nubraižyti reikalingi kintamieji yra 
# data.frame tipo duomenų lentelėje, funkcijai boxplot galima nurodyti jos vardą. 
# Pavyzdžiui, nubraižysime lentelės airquality temperatūros kiekvienam stebėjimų
# mėnesiui diagramas.

boxplot(Temp ~ Month, data = airquality)

# Jei diagrama braižoma ne iš visų duomenų lentelėje esančių duomenų, parametrui
# subset galima nurodyti loginę sąlygą ir taip išrinkti tik tam tikrus stebinius.
# Pavyzdžiui, naudojant tą pačią duomenų lentelę, nubraižysime temperatūros iki
# rugpjūčio mėnesio stačiakampes diagramas.

boxplot(Temp ~ Month, data = airquality, subset = Month < 8)


# NAUDINGA ------------------------------

# Yra keletas kitų parametrų, kuriais galima keisti boxplot diagramos išvaizdą:
# 
#        col -- diagramos dėžutės spalva,
#      names -- kintamojo x grupių vardų vektorius,
#    outline -- TRUE, nurodo ar diagramoje bus pažymimos išskirtys,
#   varwidth -- FALSE, nurodo ar stulpelio plotis proporcingas imties tūriui,
#      width -- vektorius su santykinių diagramos stulpelių pločių reikšmėmis.

# Pavyzdžiui, sudarysime grupuoto kintamojo s diagramą ir ant to paties grafiko
# palyginimui uždėsime bendrą kintamojo s diagramą.

# Iš pradžių nubraižysime grupuotą kintamojo s diagramą. Kad vėliau ant jos būtų
# galima uždėti bendrą diagramą, išplėsime ašies Ox ribas ir nurodysime, kad tos
# dėžutės būtų atidedamos ties x = 3 ir x = 4. Tada ant jau sudarytos diagramos 
# uždėsime bendrą kintamojo s stačiakampę diagramą. 

boxplot(s ~ k, xlim = c(0, 5), at = 3:4, names = c("Taip", "Ne"))
boxplot(s, add = TRUE, width = 1, col = "red")


# Nubraižysime dar vieną tokią kombinuotą diagramą. Ant kintamųjų Temp ir Month 
# sklaidos diagramos uždėsime grupuotą stačiakampę diagramą.

plot(Temp ~ Month, data = airquality, pch = 20, xlim = c(4, 10), col = 3)
boxplot(Temp ~ Month, data = airquality, add = TRUE, at = 5:9)


# Tam, kad stačiakampės dėžutės ant diagramos būtų nubraižytos tam tikra tvarka,
# reikia, kad tokia pačia tvarka būtų išrikiuotos kategorinio kintamojo reikšmės. 
# Tam naudojama funkcija reorder. Pvz., nubraižysime vidurkio didėjimo tvarka
# išdėstytas atskirų mėnesių temperatūros stačiakampes diagramas.

M <- with(airquality, reorder(Month, Temp, mean))
boxplot(Temp ~ M, data = airquality)


# Funkcija boxplot ne tik nubraižo stačiakampę diagramą, bet ir gali sukurti jai 
# nubraižyti reikalingą duomenų rinkinį - boxplot objektą. Jame surašytos grupės,
# ir jų vardai, reikšmių ir išsiskiriančių elementų kiekvienoje grupėje skaičius, 
# dėžutei nubraižyti reikalingos statistikos: mediana, kvartiliai ir "ūsų" galai.

boxstat <- boxplot(Temp ~ Month, data = airquality)
boxstat

names(boxstat)

boxstat$stats     # visų grupių dėžučių statistikos: galai, kvartiliai, mediana
boxstat$n         # reikšmių grupėse skaičius
boxstat$conf      # medianos pasikliautinasis intervalas
boxstat$out       # išsiskiriančių stebinių reikšmės
boxstat$group     # išsiskiriančių stebinių grupės numeriai
boxstat$names     # grupių vardai


# UŽDUOTIS ------------------------------ 

# 1. Nubraižykite duomenų lentelės iris kintamojo Sepal.Length boxplot diagramą
#    grupėse pagal kintamojo Species reikšmes. Kurioje grupėje mediana didesnė?
# 2. Užrašykite komandą, kuri, naudojant diagramos objektą boxstat, automatiškai
#    nustatytų, kurioje duomenų grupėje yra išsiskiriančių reikšmių.


# --------------------------------------- #
# FUNKCIJA HIST                           #
# --------------------------------------- #

# Histogramos sudarymui ir jos braižymui naudojama standartinė R funkcija hist. 
# Pagrindiniai jos parametrai:
# 
#          x -- kiekybinio kintamojo reikšmių vektorius,
#     breaks -- kintamojo x padalinimo į intervalus taškų vektorius,
#       freq -- TRUE, nurodo ar bus braižoma dažnių histograma,
#      right -- TRUE, nurodo, kad histogramos intervalai yra (a, b] pavidalo,
#     labels -- FALSE, dažniai arba užrašų ant histogramos stulpelių vektorius,
#       plot -- TRUE, nurodo ar braižyti histogramą,
#        add -- FALSE, nurodo ar histogramą uždėti ant jau sudaryto grafiko.


# Kaip pavyzdį panaudosime Nilo vandens lygio stebėjimo duomenis. Patogumo dėlei 
# sukursime atskirą kintamąjį x ir nubraižysime jo histogramą.

x <- as.numeric(Nile)
x
  
hist(x)

# Be papildomų nustatymų histogramos stulpelių skaičius parenkamas automatiškai. 
# Naudojant parametrą breaks, kintamojo reikšmių sritį galima padalinti į kelis 
# intervalus, pagal kuriuos ir sudaroma histograma. Pats paprasčiausias būdas --
# nurodyti intervalų padalijimo taškų vektorių. Reikia priminti, kad histogramos
# stulpelių bus vienu mažiau nei taškų skaičius.

hist(x, breaks = c(400, 600, 800, 1000, 1200, 1400))

# Tokį pat padalinimo taškų vektorių galima sudaryti naudojant aritmetinės sekos 
# generavimo funkciją seq. Tarkime, kad intervalo plotis bus lygus 200.

hist(x, breaks = seq(400, 1400, by = 200))

# Intervalų sudarymo komandą galima visiškai automatizuoti. Paprastai histograma 
# braižoma intervale nuo minimalios iki maksimalios kintamojo reikšmės. Tada jas
# galima apskaičiuoti naudojant funkcijas min ir max. Intervalų skaičių nurodome
# per funkcijos seq parametrą length.out. PASTABA! Intervalai yra (a, b] formos,
# ir formaliai minimalią reikšmę turintis imties elementas į pirmąjį intervalą
# turėtų nepatekti, tačiau parametras include.lowest nurodo, kad reikia įtraukti.

hist(x, breaks = seq(min(x), max(x), length = 6))

# Kintamojo reikšmes padalinti į intervalus galima ir naudojant funkciją pretty.
# Ši funkcija padalinimo taškus parenka taip, kad visi intervalai būtų "gražūs".

hist(x, breaks = pretty(x))


# Ant histogramos stulpelių galima užrašyti atitinkamų intervalų dažnius. Tam
# naudojama funkcija labels. Vietoj loginės parametro reikšmės galima nurodyti 
# reikšmių, kurias reikia užrašyti ant stulpelių, vektorių.

hist(x, breaks = pretty(x), labels = TRUE)


# NAUDINGA ------------------------------

# Kaip ir kitos grafinės funkcijos, funkcija hist priima standartinius grafinius
# parametrus, kuriais galima keisti histogramos išvaizdą.

# Kartais ant histogramos reikia uždėti kokio nors skirstinio tankio funkcijos
# grafiką. Nubraižysime temperatūros histogramą ir ant jos uždėsime normaliojo
# skirstinio tankio funkcijos grafiką, o kadangi skirstinio parametrai nežinomi,
# juos įvertinsime iš imties.

t <- as.numeric(nhtemp)

vid <- mean(t)
std <- sd(t)

# Pirma nubraižome histogramą. Kadangi ant jos viršaus braižysime tankio f-jos
# grafiką, čia reikalinga ne dažnių, o santykinių dažnių histograma. Ją gauname
# parametrui freq priskirdami reikšmę FALSE.

hist(t, freq = FALSE, xlim = c(46, 56), main = "Temperatūros pasiskirstymas")
curve(dnorm(x, mean = vid, sd = std), col = "red", add = TRUE)


# Funkcija hist ne tik nubraižo histogramą, bet ir gali sukurti šiai histogramai 
# nubraižyti reikalingą duomenų rinkinį - histogramos objektą. Jei pats grafikas 
# nereikalingas, jo braižymą galima uždrausti naudojant parametrą plot.

histat <- hist(x, breaks = pretty(x), plot = FALSE)
histat

# Iš jo galima sužinoti, kokie yra kintamojo dažniai intervaluose, šių intervalų
# padalinimo taškus, intervalų vidurio taškus ir pan.

names(histat)

histat$breaks  # intervalų padalinimo taškai
histat$mids    # intervalų vidurio taškai
histat$counts  # dažniai intervaluose

# Funkcija plot turi metodą histogramos objektui atvaizduoti.

plot(histat)


# UŽDUOTIS ------------------------------ 

# 1. Nubraižykite duomenų lentelės airquality birželio mėn. temperatūros dažnių 
#    histogramą. Nurodykite ašių pavadinimus ir visos histogramos pavadinimą.
# 2. Nubraižykite tokią kintamojo y histogramą, kad ant stulpelių būtų užrašyti
#    ne dažniai, bet didžiosios abėcėlės raidės. Tokie vardai stulpeliams turi 
#    būti priskiriami automatiškai ir nepriklausomai nuo stulpelių skaičiaus.
# 3. Užrašykite komandą, kuri naudodama histogramos objektą, surastų aukščiausią 
#    histogramos stulpelį atitinkančio intervalo vidurį.
# 4. Sugalvokite būdą, kaip nubraižyti Nilo vandens lygio histogramą panaudojant 
#    dažnius intervaluose iš anksčiau jau sukurto histogramos objekto -- histo.
# 5. Sugalvokite būdą, kaip nubraižyti bet kokio kintamojo x histogramą visiškai 
#    nenaudojant funkcijos hist.
