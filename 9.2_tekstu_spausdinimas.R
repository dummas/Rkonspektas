
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Simbolių sekų apjungimas ir jų atvaizdavimas.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2016-03-29 | 2016-04-09 | 2016-04-12 | 2016-04-19
#


# TURINYS -------------------------------

#
#   1. Simbolių sekų apjungimas:
#      * funkcija paste
#      * funkcija paste0
#
#   2. Objektų atvaizdavimas ekrane:
#      * funkcija print
#
#   3. Pagalbinės simbolių sekų atvaizdavimo funkcijos:
#      * funkcija noquote
#      * funkcija strtrim
#      * funkcija abbreviate
#      * funkcija toString
#      * funkcija encodeString
#


# PASTABOS ------------------------------

#
# Parašyti apie funkciją format ir format.info.
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
# SEKŲ APJUNGIMAS                         #
# --------------------------------------- #

# Atliekant įvairius skaičiavimus arba pateikiant tų skaičiavimų rezultatus, yra 
# kelios tipinės situacijos, kada simbolių seką reikia sujungti su kita simbolių
# seka. Simboliai čia gali būti tiek skaičiai, tiek raidės arba skyrybos ženklai. 
# R kalboje simbolių sekų apjungimui naudojama funkcija paste. Jos parametrai:
#
#        ... -- apjungiami vektoriai,
#        sep -- simbolių seka, kuri atskiria atskirų vektorių elementus.
#   collapse -- NULL arba simbolių seka, kuri atskiria vektorius.

# Parametras ... nurodo, kad apjungiamų sekų ar vektorių skaičius nėra iš anksto
# nustatytas, todėl vektorių gali būti du, trys ir daugiau. Apjungimas gali būti 
# atliekamas keliais būdais. Paprasčiausiu atveju vieno vektoriaus elementai bus
# apjungiami su atitinkamais kito vektoriaus elementais. 

# Pavyzdžiui, apjungsime didžiąsias ir mažąsias lotyniškos abėcėlės raides. Šiuo
# atveju gaunamos tarpu atskirtos atitinkamų raidžių poros. Tarpu, nes tokia yra
# parametro sep numatyta reikšmė.

paste(LETTERS, letters)

# Norint, kad vektorių elementai būtų sujungti be tarpo, parametrui sep nurodome
# tuščią seką "".

paste(LETTERS, letters, sep = "")

# Tokiu atveju kartais patogiau naudoti f-ją paste0(...) = paste(..., sep = "").

paste(LETTERS, letters)


# Apjungiant raides, kiekvienas vektorius turėjo daug elementų -- tiek, kiek yra
# raidžių. Lygiai taip pat galima apjungti dvi sekas ir gauti vieną bendrą seką.
# Pavyzdžiui, suformuluosime tekstą, kuris pasako šios dienos datą.

paste("Šios dienos data:", Sys.Date())


# Funkcija paste apjungiamus skaitinius arba kitokio tipo vektorius automatiškai 
# paverčia į character tipo reikšmių vektorius. Pavyzdžiui, taip galima sudaryti
# datas iš atskirų metų, mėnesių ir dienų vektorių.

metai <- c(1236, 1260, 1410, 1514, 1605)
mėnuo <- c(9, 7, 7, 9, 9)
diena <- c(22, 13, 15, 8, 27)

datos <- paste(metai, mėnuo, diena, sep = "-")
datos


# Jeigu apjungiami nevienodą elementų skaičių turintys vektoriai, tai trumpesnis
# vektorius cikliškai pratęsiamas. Pavyzdžiui, taip paprastai galima sugeneruoti
# įvairias numeruotas sekas:

paste("A", 0:9, sep = "")

paste(1, 1:10, sep = "/")

paste(seq(5, 25, 5), "%")


# Jeigu vektorių elementus reikia apjungti į vieną bendrą tekstą, tai parametrui
# collapse priskiriama simbolių seka, kuri tekste atskiria vektoriaus elementus.
# Standartinė parametro reikšmė NULL nurodo, kad elementai į vieną bendrą tekstą
# nebus apjungiami. Jeigu parametrui priskiriame tuščią seką "", tada apjungimas 
# bus be tarpų. Pavyzdžiui, taip galima apjungti abėcėlės raides ar skaičių seką.

paste(letters, collapse = "")

paste(0:9, collapse = "")

paste(1, 1:10, sep = "/", collapse = " + ")


# NAUDINGA ------------------------------

# Gana dažnai skaičiavimų rezultatus reikia įrašyti į atskirus failus. Paprastai
# tokie failai sudaromi automatiškai, o jų vardai dažniausiai skiriasi tik eilės 
# numeriu. Pavyzdžiui, sudarysime penkių tekstinių failų pavadinimų vektorių.

base <- "failas_"  # bendra visiems failams pavadinimo dalis
type <- ".txt"     # failo išplėtimas
numb <- 1:5        # failo numeris

failai <- paste(base, numb, type, sep = "")
failai


# NAUDINGA ------------------------------

# Funkciją paste galima panaudoti kodų generavimui. Pavyzdžiui, užrašysime f-ją,
# kuri sudaro kodą iš atsitiktinai su vienodomis tikimybėmis pasirinktų didžiųjų 
# lotyniškos abėcėlės raidžių. Tarkime, kad kodas bus iš k raidžių. Jų išrinkimą
# atliksime naudojant funkciją sample, o apjungimą į kodą --- su funkcija paste.

kodas <- function(k = 5) paste(sample(LETTERS, k, TRUE), collapse = "")

# Tokios f-jos rezultatas bus vienas kodas. Tarkime, mums reikalingas triženklis 
# kodas.

kodas(3)

# Įstačius kodo generavimo funkciją į funkciją replicate, galime sugeneruoti bet
# kokį kiekį nustatyto ilgio kodų. Pavyzdžiui, sugeneruosime 10 triženklių kodų.

kodai <- replicate(10, kodas(3))
kodai

# Paprastai reikalaujama, kad visi kodai (pvz., duomenų lentelės eilučių vardai)
# būtų unikalūs. Tai nesunku patikrinti.

anyDuplicated(kodai)


# UŽDUOTIS ------------------------------ 

# 1. Užrašykite tokią komandą, kuri bet kokios duomenų lentelės kintamųjų vardus 
#    automatiškai pakeistų į "X_1", "X_2" ir t. t.
# 2. Užrašykite komandą, kuri žodį arba bet kokią kitą simbolių seką užrašytų iš 
#    kito galo.
# 3. Sudarykite programą, kuri generuotų atsitiktinį skaičių žodžių, sudarytų iš
#    atsitiktinio skaičiaus mažųjų lotyniškos abėcėlės raidžių.


# --------------------------------------- #
# OBJEKTŲ ATVAIZDAVIMAS EKRANE            #
# --------------------------------------- #

# Tai, kaip ekrane bus vaizduojamas vektorius, matrica, duomenų lentelė ar kitas 
# R objektas, priklauso nuo to objekto tipo (klasės). Pavyzdžiui, character tipo
# reikšmės vaizduojamos kabutėse, o factor tipo reikšmės - be kabučių. Paprastai
# objektai vaizduojami taip, kaip numatyta, be papildomo apipavidalinimo, tačiau 
# standartines R objektų atvaizdavimo taisykles galima pakeisti.

# Įvairių R objektų išvedimui į ekraną naudojama funkcija print. Jos parametrai:
#
#          x -- vektorius ar kitokio tipo R objektas,
#     digits -- mažiausias realiojo skaičiaus reikšmingų skaitmenų skaičius,
#      quote -- TRUE nurodo, kad character tipo reikšmės rodomos su kabutėmis,
#   na.print -- simbolių seka, kuri vaizduojama vietoje NA reikšmės,
#  print.gap -- tarpo plotis tarp vektoriaus elementų arba matricos stulpelių,
#      right -- FALSE nurodo, kad simbolių sekos lygiuojamos pagal dešinę pusę,
#        max -- į ekraną išvedamų vektoriaus ar matricos elementų skaičius.


# Kiek realiojo skaičiaus skaitmenų rodoma ekrane, nustato sisteminis parametras
# digits. Standartinė jo reikšmė yra 7.

options("digits")

# Jeigu realiųjų skaičių atvaizdavimui ekrane naudojama funkcija print, keičiant
# jos parametro digits reikšmę, galima nustatyti ekrane rodomų skaitmenų skaičių. 
# Pademonstruosime, kaip, keičiant šio parametro reikšmę, kompiuterio ekrane bus 
# atvaizduojamas realiųjų skaičių vektorius.

x <- rnorm(20)
x

print(x)

print(x, digits = 1)
print(x, digits = 5)
print(x, digits = 20)


# Parametras print.gap nurodo tarpo tarp gretimų vektoriaus reikšmių ar matricos
# stulpelių plotį. Pavyzdžiui, padidinsime tarpą tarp vektoriaus elementų iki 5.

print(x)
print(x, print.gap = 5)
print(x, print.gap = 5, digits = 3)

# Taip pat galima padidinti tarpus tarp matricos arba duomenų lentelės stulpelių.

m <- matrix(x, 5, byrow = TRUE)
m

print(m, print.gap = 4)
print(m, print.gap = 4, digits = 3)


# Praleistos reikšmės standartiškai žymimos NA, lygiai taip pat jos vaizduojamos
# ir ekrane. Tačiau, naudojant parametrą na.print, vietoje NA galima pavaizduoti 
# kitokią simbolių seką arba net ir vieną simbolį. Pavyzdžiui, išvesime į ekraną
# skaitinį vektorių su praleistomis reikšmėmis, kurias žymi taško simbolis. 

y <- airquality$Ozone
y

print(y)
print(y, na.print = ".")


# Standartiškai character tipo reikšmė ekrane rodoma su kabutėmis. Jeigu tekstas
# turi būti rodomas be kabučių, parametro quote reikšmę reikia pakeisti į FALSE.

w <- c("lorem", "ipsum", "dolor", "sit", "amet", "aliquip", "docendi", "decore",
       "mnesarchum", "nullam", "perfecto", "an", "vix", "cu", "et", "molestiae",
       "consetetur", "assum", "libris", "pro", "in", "et", "mel", "nisl", "nam",
       "fugit", "est", "recusabo", "dissentias", "enim", "salutatus", "fabulas")

print(w)
print(w, quote = FALSE)

# Jeigu žodžiai ar kitos character tipo reikšmės yra nevienodo ilgio, jas galima
# išlygiuoti pagal ilgiausio žodžio kairę arba dešinę pusę. Tam naudojamas f-jos
# print parametras rigth.

print(w)
print(w, right = TRUE)
print(w, right = TRUE, quote = FALSE)
print(w, right = TRUE, quote = FALSE, print.gap = 7)


# NAUDINGA ------------------------------

# Tai, kaip R objektas vaizduojamas ekrane, priklauso nuo jo tipo (klasės). F-ja
# print turi keletą metodų, kurie pritaikomi įvairaus tipo objektų atvaizdavimui.

methods(print)

# Vienas iš dažnai pasitaikančių objektų -- dažnių lentelės. Joms funkcija print
# taip pat turi metodą bei keletą specifinių parametrų, nuo kurių priklauso, tai 
# kaip atrodo ekrane atspausdinta dažnių lentelė.

# Pavyzdžiui, sudarysime gretimų raidžių lietuviškuose žodžiuose dažnių lentelę.
# Iš pradžių užrašome dažnai pasitaikančių žodžių vektorių.

z <- c("prie", "tačiau", "didelis", "sistema", "gamyba", "įmonė", "koks", "nes",
      "vieta", "žemė", "pirmas", "norėti", "naujas", "dabar", "narys", "žinoti",
      "pagal", "įstatymas", "vaikas", "todėl", "net", "iki", "gyvenimas", "jei",
      "dažnai", "pirmininkas", "svarbus", "ant", "grupė", "kiekvienas", "dalis",
      "atlikti", "seimas", "diena", "tai", "sakyti", "du", "valstybė", "duomuo",
      "gerai", "prieš", "kur", "negalėti", "jeigu", "pasaulis", "niekas", "dėl",
      "šalis", "klausimas", "geras", "nei", "nustatyti", "be", "metas", "savęs",
      "viskas", "pradėti", "procesas", "pateikti", "kartas", "priimti", "gauti",
      "veikla", "ūkis", "vanduo", "įvairus", "dirbti", "ligonis", "pagrindinis",
      "kiek", "pavyzdys", "imti", "skirti", "informacija", "lietuvis", "padėti",
      "tarp", "ranka", "tapti", "bendras", "vyriausybė", "kalbėti", "projektas",
      "miestas", "žodis", "projektas", "respublika", "kalba", "daryti", "sąlyga")

# Žodžius išskaidome į atskiras raides, sudarome vienas po kito einančių raidžių
# poras, atskirų žodžių raidžių poras apjungiame į bendrą lentelę ir tada iš jos 
# sudarome raidžių porų dažnių lentelę.

s <- strsplit(z, "")
p <- sapply(s, embed, 2)
g <- do.call(rbind, p)

pirma <- g[, 2]
antra <- g[, 1]

L <- table(pirma, antra)
L

# Matome, kad dažnių lentelėje yra gana daug nulinių dažnių. Taip yra todėl, kad 
# nagrinėjamų žodžių palyginus nedaug ir retos raidžių poros tarp jų nepasitaiko.
# Didelis nulinių dažnių kiekis lentelėje trukdo įžvelgti kitus skaičius. Tačiau,
# naudojant funkcijos print parametrą zero.print, galima nustatyti, kokį simbolį 
# rodyti vietoje nulio. Pavyzdžiui, nustatysime, kad būtų rodomas taškas.

print(L)
print(L, zero.print = ".")


# Dažnių lentelė iš esmės yra skaičių matrica, tačiau jos klasė ne "matrix", bet 
# "table", ir pagal šį požymį dažnių lentelės atskiriamos nuo visų kitų matricų. 
# Tačiau R objekto klasę galima nesunkiai pakeisti. Pavyzdžiui, skaičių matricai 
# priskirsime "table" klasę ir taip apgausime funkciją print.

m <- matrix(sample(0:1, 100, TRUE), 10)
m

# Paprasta matrica nėra dažnių lentelė ir parametras zero.print nieko nepakeičia.

class(m)
print(m, zero.print = ".")

# Pakeitus objekto klasę, ta pati matrica atpažįstama kaip dažnių lentelė, todėl
# jau galima nustatyti, kaip ji turi būti atvaizduojama ekrane.

class(m)
class(m) <- "table"

print(m, zero.print = ".")


# UŽDUOTIS ------------------------------ 

# 1. Sugalvokite tokią koreliacijų matricos atvaizdavimo funkciją, kad reikšmės, 
#    absoliutiniu dydžiu mažesnės už tam tikrą pasirenkamą ribą, būtų nerodomos.
# 2. 
#    


# --------------------------------------- #
# SIMBOLIŲ SEKŲ ATVAIZDAVIMO FUNKCIJOS    #
# --------------------------------------- #

# Dėl įvairių priežasčių skaičių vektorių, duomenų lentelę, simbolių seką ar bet
# kokį kitą R objektą nevisada galima pavaizduoti tokį, koks jis yra. Pavyzdžiui,
# gali būti taip, kad teksto ilgį riboja simbolių skaičius eilutėje. Tada tekstą
# reikia nukirpti, kad jis tilptų į eilutę. Panašių situacijų yra ir daugiau.

# R turi keletą pagalbinių funkcijų, kurios padeda suformuoti tekstą: paversti į
# simbolių seką skaičių vektorius, nukirpti simbolių seką iki tam tikro simbolių 
# skaičiaus, sulygiuoti atskiras simbolių sekas ir pan.

# Pati paprasčiausia iš tokių funkcijų -- noquote. Ši funkcija pakeičia simbolių
# sekos klasę į "noquote", ir tokia simbolių seka ekrane vaizduojama be kabučių.
# Kabutės parodo simbolių sekos ribas ir tuo pačiu parodo, kad simbolių seka yra
# simbolių seka, o ne kintamojo pavadinimas, tačiau kartais tai nebūtina žinoti. 
# Pavyzdžiui, pakeisime lietuviškų žodžių vektoriaus klasę ir juos atvaizduosime
# ekrane be kabučių.

z <- noquote(z)
z

# Žinoma, naudojant funkciją unclass, galima sugrąžinti pradinę vektoriaus klasę.

z <- unclass(z)
z


# Funkcija strtrim nukerpa ilgos simbolių sekos galą ir tokiu būdu sutrumpina ją
# iki nustatyto simbolių skaičiaus. Ši funkcija turi tik du parametrus:
#
#          x -- simbolių seka,
#      width -- simbolių sekos ilgis.

# Pavyzdžiui, visų savaitės dienų pavadinimus sutrumpinsime iki trijų raidžių.

dienos <- c("Pirmadienis", "Antradienis", "Trečiadienis", "Ketvirtadienis", 
            "Penktadienis", "Šeštadienis", "Sekmadienis") 

strtrim(dienos, 3)


# Jeigu sutrumpinta seka turi būti unikali, naudojama funkcija abbreviate. Sekos 
# sutrumpinimo algoritmas toks: iš pradžių iš sekos pašalinami visi tarpai, tada 
# panaikinamos mažąją raide užrašytos balsės, kurios eina po priebalsių, ir, jei
# tokia seka turi daugiau simbolių, negu nurodyta, pašalinamos didžiosios raidės.
# Funkcijos parametrai:
# 
#    names.arg -- simbolių sekų vektorius,
#    minlength -- minimalus sutrumpintos sekos ilgis,
#          dot -- loginis, nurodo ar trumpinio gale turi būti dedamas taškas,
#       strict -- loginis, nurodo ar būtinai išlaikyti minimalų trumpinio ilgį,
#       method -- c("left.kept", "both.sides")

# Pavyzdžiui, iki trijų raidžių sutrumpinsime lietuviškus mėnesių pavadinimus.

mėnesiai <- c("Sausis", "Vasaris", "Kovas", "Balandis", 
              "Gegužė", "Birželis", "Liepa", "Rugpjūtis", 
              "Rugsėjis", "Spalis", "Lapkritis", "Gruodis")

abbreviate(mėnesiai, minlength = 3)

# Naudojant funkciją strtrim, mėnesių pavadinimai gaunami labiau įprasti, tačiau 
# dėl to, kad sutampa pirmosios trys raidės, rugpjūtis ir rugsėjis neatskiriami.
# Kartais, pavyzdžiui, sudarant dažnių lentelę, tai gali sukelti problemų.

strtrim(mėnesiai, 3)

# Jei simbolių seka susideda iš kelių žodžių, sutrumpinimas sudaromas iš pirmųjų
# tų žodžių raidžių. Pavyzdžiui, sudarysime trumpinius iš vardų ir pavardžių.

vardai <- c("Pierre de Fermat", "Carl Friedrich Gauss", "Alan Mathison Turing")

abbreviate(vardai, minlength = 3)


# F-ja toString apjungia vektoriaus elementus į vieną simbolių seką. Jeigu sekos
# simbolių skaičius viršija nustatytą ribą, sekos galas nukerpamas, o vietoje jo
# įrašomas daugtaškis. Taip parodoma, kad seką turi tęsinį. Funkcijos parametrai:
#
#          x -- vektorius,
#      width -- apjungtos sekos ilgis,

# Šis vektoriaus elementų apjungimo būdas natūraliai gerai tinka tuo atveju, kai
# vektoriaus elementai patys sudaro lengvai atspėjamą seką. Pavyzdžiui, tai gali
# būti skaičių arba žodžių seka, datos, kažkokie žinomi posakiai ir pan.

toString(getwd(), 20)
toString(letters, 20)
toString(dienos, 30)
toString(1:100, 20)


# Funkcija encodeString vektoriaus elementus paverčia į tam tikro ilgio simbolių 
# sekas. Jei seka trumpesnė, prie jos kairės arba dešinės pusės pridedami tarpai.
# Iš kurios pusės bus pridedami tarpai, priklauso nuo to, pagal kurią pusę sekos
# lygiuojamos. Funkcijos parametrai:
#
#          x -- vektorius,
#      width -- sekos ilgis, NA arba NULL nurodo ilgiausios sekos ilgį,
#      quote -- kabučių simbolis,
#  na.encode -- jeigu FALSE, tai seka nebus sudaroma,
#    justify -- lygiavimo taisyklė: "left", "right", "centre" arba "none".

# Pavyzdžiui, duotas skirtingų ilgių žodžių vektorius. Iš jo elementų sudarysime
# vienodo ilgio simbolių sekas.

žodžiai <- c("į", "aš", "šuo", "imti", "žodis", "sodyba", "pradėti", "susisuko")
žodžiai

# Jei parametro width reikšmė NA ar NULL, tai gaunamos sekos, kurių ilgiai lygūs
# daugiausia simbolių turinčio vektoriaus elemento ilgiui. Šiuo atveju visos jos
# suvienodinamos pagal ilgiausią žodį.

encodeString(žodžiai, width = NA)

# Nustačius didesnį simbolių sekų ilgį, papildomais tarpais bus praplečiamos jau
# visos sekos.

encodeString(žodžiai, width = 50)

# Standartiškai visos sekos lygiuojamos pagal kairįjį kraštą. Lygiavimo taisyklę 
# nusako parametro justify reikšmė. Pavyzdžiui, priskyrus reikšmę "right", sekas 
# išlygiuosime pagal dešinįjį kraštą, priskyrus reikšmę "centre" -- centruosime.

encodeString(žodžiai, width = 50, justify = "right")
encodeString(žodžiai, width = 50, justify = "centre")


# UŽDUOTIS ------------------------------ 

# 1. 
#    
# 2. 
#    