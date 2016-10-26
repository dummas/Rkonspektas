
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Loginių sąlygų užrašymas ir specialios loginės funkcijos.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2013-07-27 | 2013-08-20
#


# TURINYS -------------------------------

#
#   1. Loginių sąlygų užrašymas:
#      * palyginimo operatoriai
#      * funkcija all
#      * funkcija any
#
#   2. Specialios loginės funkcijos:
#      * funkcija exists
#      * funkcija is.vector
#      * funkcija is.numeric
#      * funkcija is.infinite
#      * funkcija is.na
#      * funkcija is.null
#


# PASTABOS ------------------------------

#
# Konspektas papildytas funkcija exists.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuviška lokalė. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# Ištrinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# LOGINIŲ SĄLYGŲ UŽRAŠYMAS                #
# --------------------------------------- #

# Skaičių arba simbolių vektoriaus elementams tikrinant kokį nors loginį testą, 
# gaunamas to paties ilgio loginių reikšmių vektorius. Jo elementas lygus TRUE, 
# jei sąlyga buvo tenkinama, ir lygus FALSE, jei sąlyga netenkinama.

# Palyginimo operatoriai:
#
#    == -- lygu
#    != -- nelygu
#     > -- daugiau
#     < -- mažiau
#    >= -- daugiau arba lygu
#    <= -- mažiau arba lygu


x <- c(4, 8, 6, 2, 3, 7, 0, 4, 2, 8)
y <- c(3, 9, 0, 1, 4, 5, 2, 7, 6, 8)

# Pavyzdžiui, patikrinsime, ar vektoriaus x reikšmės yra teigiamos. Tam sudarome
# loginį testą. Gauname tokio pat ilgio loginių reikšmių vektorių.
x > 0

# Patikrinsime, ar vektoriaus x elementas didesnis už atitinkamą  vektoriaus y 
# elementą.
x > y

# Turint tokį loginį vektorių, galima išrinkti tam tikrus vektoriaus elementus,
# nustatyti reikiamų elementų eilės numerius, patikrinti kitas logines sąlygas.

# Pagrindiniai loginiai operatoriai yra šie:
#
#     | -- loginis ARBA
#     & -- loginis IR
#     ! -- loginis NE


# Veiksmus galima atlikti ir su atskiromis loginėmis konstantomis TRUE ir FALSE.
TRUE | FALSE

!TRUE

# Konstantas TRUE ir FALSE galima rašyti sutrumpinta forma, atitinkamai T ir F.
a <- c(T, T, F, F)
b <- c(T, F, T, F)

# Kai operandai yra loginių reikšmių vektoriai, tai loginės operacijos atliekamos 
# su atitinkamais tų vektorių elementais.

a | b   # loginis ARBA
a & b   # loginis IR
!a      # loginis NE

# Operatoriai ARBA ir IR turi ilgąją formą, || ir &&. Nuo trumposios ji skiriasi
# tuo, kad loginė operacija atliekama tik su pirmąją loginio vektoriaus reikšme.
# Šiuos operatorius galima naudoti tokiose situacijose, kur reikia, kad loginės 
# operacijos rezultatas būtų viena reikšmė: arba TRUE, arba FALSE.

a || b
a && b


# Naudojant loginius operatorius atskiros loginės sąlygos gali būti apjungiamos
# ir taip užrašomos sudėtingesnės sąlygos. Pavyzdžiui, patikrinsime ar vektoriaus 
# x elementų reikšmės patenka į intervalą [2, 7].

x >= 2 & x <= 7 


# Norint patikrinti, ar bent viena loginio vektoriaus elemento reikšmė yra TRUE, 
# naudojama funkcija any.

any(a)

# Norint patikrinti, ar visi loginio vektoriaus elementai lygūs TRUE, naudojama
# funkcija all.

all(a)


# NAUDINGA ------------------------------

# Atliekant statistinę duomenų analizę, kartais reikia patikrinti, ar vektoriaus 
# elementai tenkina tam tikras sąlygas. Naudojant palyginimo operatorius >=, <=,
# >, < ir == sudaromas loginis testas ir gaunamas loginių reikšmių vektorius. Jo
# reikšmių patikrinimui galima panaudoti funkcijas any ir all.

# Pavyzdžiui, patikrinsime, ar visos vektoriaus x reikšmės yra teigiamos. 
# Kadangi loginė sąlyga nesudėtinga, ją galima įkelti tiesiai į funkciją all.
all(x > 0)

# Pavyzdžiui, patikrinsime, ar bent vienas vektoriaus x elementas lygus 0.
any(x == 0)

# Patikrinsime, ar bent vienas vektoriaus x elementas didesnis už atitinkamą 
# vektoriaus y elementą.
any(x > y)

# Konstantos FALSE ir TRUE atitinka skaičius 0 ir 1, ir todėl loginius vektorius 
# galima sumuoti. Tokiu būdu surandame TRUE reikšmę turinčių elementų skaičių.
# Pavyzdžiui, apskaičiuosime, kiek vektoriaus x elementų didesni už atitinkamus
# vektoriaus y elementus.

sum(x > y)


# UŽDUOTIS ------------------------------ 

# 1. Užrašykite komandą, kuri patikrintų, ar visų loginio vektoriaus a elementų 
#    reikšmės yra FALSE.
# 2. Užrašykite komandą, kuri patikrintų, ar bent vienas vektoriaus x elementas
#    nelygus nuliui.
# 3. Patikrinkite, ar visi vektoriaus x elementai yra iš vektoriaus y elementų
#    aibės. Komandą galima užrašyti dviem būdais: su f-ja is.element ir su %in%.


# --------------------------------------- #
# SPECIALIOS LOGINĖS FUNKCIJOS            #
# --------------------------------------- #

# R turi keletą specialių funkcijų, kurios skirtos tam tikroms įvairių objektų 
# sąvybėms patikrinti. Tokio tipo funkcijų rezultatas yra reikšmė TRUE ar FALSE.

# Kartais reikia patikrinti, ar egzistuoja konkretus kintamasis arba funkcija.
# Tam naudojama funkcija exists. Jos parametrai:
#
#              x -- ieškomo objekto vardas,
#           mode -- kintamojo tipas: "numeric", "function" ir pan.

# Ieškomo objekto vardas rašomas kabutėse. Pagal nutylėjimą parametro mode 
# reikšmė yra "any", todėl ieškomi bet kokie tokį vardą turintys objektai.

exists("x")
exists("x", mode = "function")


# Viena grupė funkcijų patikrina, kokio tipo yra pats objektas:
#
#      is.vector -- ar vektorius,
#      is.matrix -- ar matrica,
#        is.list -- ar sąrašas,
#  is.data.frame -- ar duomenų lentelė.

is.vector(x)
is.matrix(x)


# Vektoriaus arba matricos elementai paprastai yra sveikieji, realieji skaičiai, 
# simboliai ar loginės reikšmės. Konkrečiam vektoriaus elementų tipui nustatyti 
# naudojamos šios funkcijos:
#
#     is.numeric -- ar elementai yra skaičiai,
#      is.double -- ar realieji skaičiai,
#     is.integer -- ar sveikieji skaičiai,
#   is.character -- ar simboliai,
#     is.logical -- ar loginės reikšmės.

# Vektoriaus x elementai yra skaičiai, o vektoriaus a - loginės reikšmės, todėl 
# atitinkamos funkcijos grąžina reikšmę TRUE.

is.numeric(x)
is.logical(a)

is.character(T)
is.character("T")

is.integer(1)
is.integer(1L)


# Atliekant skaičiavimus, rezultatas ne visada yra apibrėžtas. Tipinė situacija 
# - skaičiaus dalyba iš nulio. Tokiems atvejams pažymėti naudojamos specialios 
# konstantos: Inf - begalybė (Infinity) ir NaN - ne skaičius (Not a Number).

1/0           # neapibrėžtumas, skaičiaus dalyba iš nulio
Inf - Inf     # neapibrėžtumas, begalybė minus begalybė

# Neapibrėžtumams nustatyti naudojamos šios funkcijos:
#
#      is.finite -- ar reikšmė baigtinė,
#    is.infinite -- ar reikšmė begalybė,
#         is.nan -- ar reikšmė yra NaN.

# Jei funkcijos argumentas yra vektorius arba matrica, tai patikrinami visi tą 
# objektą sudarantys elementai. Kadangi vektoriaus x elementai yra baigtiniai, 
# funkcijos is.finite rezultatas vektorius, kurio visos reikšmės yra TRUE.

is.finite(x)

# Sudarysime naują vektorių d, kurio elementai gaunami skaičių 1 padalinus iš 
# vektoriaus x elementų reikšmių.

d <- 1/x

# Patikrinsime, ar gauto vektoriaus d elementai turi apibrėžtas reikšmes.

is.infinite(d)
is.nan(d)

# Naudojant anksčiau paminėtą loginę funkciją all, galima nesunkiai patikrinti, 
# ar visi vektoriaus elementai yra apibrėžti.

all(is.finite(d))


# Dėl įvairių priežasčių realiuose duomenyse kartais būna praleistų reikšmių. 
# Joms žymėti naudojama speciali konstanta NA. 

z <- c(19, 16, NA, 14, 16, 11, 17, NA, 13, 15)
z

# Atitinkamai yra funkcija, kuri patikrina, kurie vektoriaus arba kito objekto 
# elementai yra praleistos reikšmės:
# 
#          is.na -- ar praleista reikšmė.

# Funkcijos reikšmė lygi TRUE, kai vektoriaus ar kito objekto elemento reikšmė 
# lygi NA. Praleista reikšme laikoma ir konstanta NaN, tačiau begalybė - ne.

is.na(NA)
is.na(NaN)
is.na(Inf)

# Jei funkcijos is.na argumentas yra vektorius, matrica ar duomenų lentelė, tai
# patikrinamas kiekvienas elementas. Rezultatas yra tokio pat dydžio objektas,
# kurio elementų reikšmės yra TRUE, jei tikrinamo elemento reikšmė NA arba NaN, 
# ir FALSE - kitais atvejais.

# Kadangi vektorius x praleistų reikšmių neturi, funkcijos is.na rezultatas yra 
# tokio pat ilgio vektorius, kurio visos reikšmės yra FALSE.
is.na(x)

# Vektorius z turi dvi praleistas reikšmes, tą rodo gautos f-jos reikšmės TRUE.
is.na(z)

# Kadangi konstantos FALSE ir TRUE atitinka skaičius 0 ir 1, loginius vektorius 
# galima sumuoti. Tokiu būdu surandame TRUE reikšmę turinčių elementų skaičių.
# Pavyzdžiui, apskaičiuosime, kiek praleistų reikšmių turi vektorius z.
sum(is.na(z))

# Naudojant anksčiau paminėtas logines funkcijas any arba all, galima nesunkiai 
# patikrinti, ar vektorius turi bent vieną praleistą reikšmę. Pvz., vektorius x 
# praleistų reikšmių neturi, todėl funkcijos any reikšmė yra FALSE.

any(is.na(x))
any(is.na(z))


# Jei funkcijos is.na argumentas yra sąrašas, tai reikšmė TRUE grąžinama tiems
# sąrašo elementams, kurių reikšmė yra NA. Jei sąrašo elementas yra vien iš NA
# reikšmių sudarytas vektorius, funkcija is.na grąžins reikšmę TRUE.

l <- list(a = c(1, 2), b = c(1, NA), c = c(NA, NA), d = NA)
l

is.na(l)


# R turi tuščią objektą žyminčią konstantą NULL. Ją kaip reikšmę priskyrus bet
# kokiam vektoriui, matricai ar kitam objektui, tas objektas tampa NULL objektu.

# Pavyzdžiui, vektoriaus elementai gali turėti praleistą reikšmę NA, bet negali 
# įgyti NULL reikšmės.

c(1, 2, NULL, 4)

# Pavyzdžiui, priskirdami reikšmę NULL, panaikinsime paskutinį sąrašo l elementą.
l[4] <- NULL
l

# NULL objektui nustatyti naudojama speciali loginė funkcija:
#
#        is.null -- ar objektas yra NULL.


# Nė vieno elemento neturintis vektorius nėra NULL objektas! Pvz., tokį vektorių 
# pagal nutylėjimą sukuria funkcija vector arba f-jos numeric, character ir t.t.
v <- vector()
v

# Galima įsitikinti, kad gauto vektoriaus ilgis lygus nuliui.
length(v)

# Toks vektorius neturi jokių atributų (pavyzdžiui, elementų vardų, eilučių ar 
# stulpelių pavadinimų, dimensijos ir t.t.), todėl funkcija attributes grąžina 
# tuščią objektą NULL.
attributes(v)

# Tačiau pats vektorius nėra NULL objektas.
is.null(v)


# NAUDINGA ------------------------------

# Loginių operacijų su praleistomis reikšmėmis rezultatas taip pat yra praleista
# reikšmė. Pavyzdžiui, palyginsime ar vektoriaus z elementų reikšmės didesnės už 
# atitinkamų vektoriaus x elementų reikšmes.

z > x

# Matome, kad visi z elementai didesni už x elementus, bet dėl keletos praleistų 
# reikšmių funkcijos all rezultatas taip pat yra praleista reikšmė.

all(z > x)

# Dėl praleistų reikšmių neveikia ir kitos dažnai naudojamos funkcijos! Pvz., 
# negalima rasti vektoriaus elementų sumos, mažiausios ar didžiausios reikšmės.

sum(z)
min(z)
max(z)

# Tokios funkcijos turi papildomus parametrus, kurie nustato, kaip interpretuoti 
# praleistas reikšmes ir ką su jomis daryti atliekant veiksmus. Pavyzdžiui, f-ja 
# sum turi parametrą na.rm, kuriam priskyrus reikšmę TRUE, sumuojant praleistos 
# reikšmės bus ignoruojamos.

sum(z, na.rm = TRUE)


# UŽDUOTIS ------------------------------ 

# 1. Užrašykite loginę sąlygą, kuri patikrintų, kurie vektoriaus x elementai
#    nepatenka į intervalą [2, 7].
# 2. Užrašykite komandą, kuri iš vektoriaus z išrinktų tik tuos elementus, kurie
#    nėra praleistos reikšmės.
# 3. Užrašykite komandą, kuri vektoriaus z elementams su praleistomis reikšmėmis
#    priskirtų reikšmę 0.
# 4. Užrašykite komandą, kuri patikrintų, ar vektorius d turi bent vieną begalinį
#    elementą.
# 5. Sugalvokite būdą kaip vektoriui v priskirti elementų vardus, kad jo atributų
#    vektorius jau nebūtų NULL objektas.
