
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Vektorių sudarymas ir pagrindinės jų savybės.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2012-09-03 | 2013-05-06
#


# TURINYS -------------------------------

# 
#   1. Vektorių sudarymas ir jų sąvybės:
#      * komanda vector
#      * standartiniai vektoriai
#      * komanda c
#      * komanda length 
#      * komanda mode 
#      * komanda names 
#      * komanda attributes 
#      * komanda attr 
#      * operatorius [
#
#   2. Aritmetinės progresijos ir pasikartojančios sekos:
#      * operatorius :
#      * komanda seq
#      * komanda seq_len
#      * komanda seq_along
#      * komanda rep
#


# PASTABOS ------------------------------

#
# Kol kas pastabų nėra.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuviška lokalė. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# Ištrinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# VEKTORIŲ SUDARYMAS                      #
# --------------------------------------- #

# Vektorius yra bazinis ir pats svarbiausias R duomenų formatas. Vektorius gali 
# būti sudarytas tik iš to paties tipo reikšmių. Pagrindiniai tipai yra tokie:
#
# character -- kabutėse rašomi raidės, žodžiai, sakiniai ir kiti simboliai;
#   numeric -- realieji skaičiai;
#    double -- taip pat realieji skaičiai, nuo numeric nesiskiria;
#   integer -- sveikieji skaičiai užrašomi prirašant L raidę, pvz., 1L;
#   complex -- a + bi  pavidalu užrašomi kompleksiniai skaičiai;
#   logical -- loginės reikšmės, TRUE, FALSE ir praleistom reikšmėm žymėti NA.

# Kiekvienas R objektas turi tam tikrus atributus. Pagrindiniai vektoriaus
# atributai tai yra jo elementų skaičius -- ilgis, ir vektorių sudarančių
# reikšmių tipas. Kitus galimus vektoriaus atributus aptarsime vėliau.

# Jei vektoriaus ilgis ir jo reikšmių tipas yra žinomi, tokį vektorių galima
# sukurti naudojant funkciją vector. Jos parametrai:
#
#   mode -- vektorius elementų tipas,
# length -- vektoriaus elementų skaičius.


# Priklausomai nuo pasirinkto tipo, vektorius užpildomas tam tikromis vienodomis
# reikšmėmis. Žinoma, vėliau šias reikšmes galima pakeisti.

vector(mode = "character", length = 10)
vector(mode = "numeric",   length = 10)
vector(mode = "logical",   length = 10)
vector(mode = "complex",   length = 10)

# Konkretaus tipo vektoriui sukurti naudojamos specialios komandos. Vienintelis 
# jų parametras yra vektoriaus ilgis. Pradinės tokiu būdu sukurto vektoriaus 
# reikšmės taip pat yra vienodos ir priklauso nuo pasirinkto vektoriaus tipo.

character(10)
numeric(10)
logical(10)


# NAUDINGA ------------------------------

# R turi keletą standartinių konstantų ir dažnai naudojamų vektorių.

letters       # lotyniška mažųjų raidžių abėcėlė
LETTERS       # lotyniška didžiųjų raidžių abėcėlė
month.abb     # sutrumpinti mėnesių pavadinimai
month.name    # pilni mėnesių pavadinimai

pi            # skaičius Pi

NA            # naudojama žymėti praleistoms reikšmėms
NaN           # naudojama žymėti neapibrėžtumams
Inf           # begalybei žymėti naudojama numeric tipo reikšmė 
NULL          # specialus tuščias objektas


# R kalboje skaliarinių dydžių nėra. Atskirai paimta viena bet kokio tipo reikšmė 
# suprantama kaip vektorius, kurio ilgis lygus vienetui. Labai dažnai vektoriai 
# sudaromi apjungiant kelias reikšmes ar kelis to paties tipo vektorius. Tokiam 
# apjungimui naudojama funkcija c.

a <- c(1, 4, 5, 2, 3)
a

b <- "Visas sakinys yra viena 'character' tipo reikšmė."
b

x <- c(1, 2, 3)
y <- c(4, 5, 6)
z <- c(7, 8, 9)
u <- c(x, y, z)
u

# Vektoriaus ilgiui (jo elementų skaičiui) surasti naudojama komanda length.
length(a)
length(b)

# Vektoriaus elementų tipui nustatyti naudojama komanda mode. 
mode(a)
mode(b)

# Taip galima patikrinti ir vienos atskirai paimtos reikšmės tipą.
mode(NA)
mode(NaN)
mode(TRUE)
mode("T")
mode(T)
mode("pi")
mode(pi)
mode(0+0i)

# NULL yra specifinis -- tuščias objektas, todėl jis turi specialų tipą.
length(NULL)
mode(NULL)


# Vektoriaus elementai gali turėti vardus. Juos galima nurodyti vektoriaus
# sudarymo metu arba vardų vektorių galima priskirti jau turimam vektoriui.

d <- c(sausis = 31, vasaris = 28, kovas = 31, balandis = 30)
d

# Vektoriaus elementų vardai taip pat sudaro vektorių, o jų ilgiai sutampa.
names(d)
mode(names(d))

length(d)
length(names(d))

# Ta pati komanda names naudojama pakeisti arba sudaryti naują vardų vektorių.
# Tarkime, kad turime vektorių, kurio elementai neturi vardų, t.y. jo vardų 
# vektorius yra tuščias, todėl komanda names grąžina reikšmę NULL.

a
names(a)

# Vardų vektoriui suteikiame reikšmę -- vektorių su elementų pavadinimais.
names(a) <- c("pirmas", "antras", "trečias", "ketvirtas", "penktas")

# Vektoriaus elementų reikšmės nepasikeitė, tačiau dabar jis be ilgio ir
# reikšmių tipo turi dar vieną atributą -- vardus.
a
names(a)


# UŽDUOTIS ------------------------------ 

# 1. Patikrinkite teiginį, kad vektoriaus d ir jo vardų vektoriaus ilgiai sutampa.
# 2. Apskaičiuokite, kokio ilgio yra vektorius LETTERS.
# 3. Apskaičiuokite vektoriaus u ilgį ir nustatykite jo tipą.


# Vektoriaus ar kito R objekto atributams parodyti naudojama komanda attributes. 

# Anksčiau sudarytas vektorius a turi vienintelį pakeičiamą atributą -- vardus.
attributes(a)

# Vektorius b tokio atributo neturi, todėl funkcija grąžina tuščią objektą NULL.
attributes(b)


# Vektoriaus ar kito objekto atributams sukurti ir pakeisti yra keletas būdų. 
# Vieno kurio nors atributo reikšmės priskyrimui naudojama komanda attr.

# Vektoriaus vardai yra jo atributas, todėl jį taip pat galima pakeisti su attr.
attr(a, "names") <- c("I", "II", "III", "IV", "V")

# Vektoriaus atributas gali būti ir bet kokia papildoma informacija apie vektorių.
attr(a, "versija") <- "0.9"
attr(a, "data")    <- "2013-05-06"

attributes(a)
a

# Kartais reikia panaikinti tik vektoriaus elementų vardus. Pats paprasčiausias 
# būdas tai padaryti -- vardų vektoriui priskirti NULL reikšmę.

names(a) <- NULL
names(a)
a

# Analogišku būdu galima panaikinti ir visus vektoriaus atributus ir karto.
attributes(a) <- NULL
attributes(a)
a


# UŽDUOTIS ------------------------------ 

# 1. Sugalvokite būdą, kaip vektoriaus vardus panaikinti naudojant komandą attr?


# Bet kurį vektoriaus elementą galima pasiekti laužtiniuose skliaustuose nurodžius 
# jo eilės numerį. Pvz., išrenkame trečią vektoriaus d elementą.
d[3]

# Galima išskirti kelis vektoriaus elementus iš karto. Tokiu atveju reikia sudaryti 
# išrenkamų elementų indeksų aibę -- sukurti jų numerių vektorių.
i <- c(3, 4)
d[i]

# Išrenkamų elementų tvarka nebūtinai turi sutapti su jų tvarka tame vektoriuje.
i <- c(4, 1)
d[i]


# UŽDUOTIS ------------------------------ 

# 1. Naudodami indeksų vektorių, vektoriaus d elementus išrikiuokite  priešinga tvarka.
# 2. Sudarykite tokį indeksų vektorių, kurį naudojant pirmasis vektoriaus d elementas 
#    būtų išrenkamas tris kartus.


# Vektoriaus elementus galima išrinkti sudarius to paties ilgio loginių reikšmių 
# vektorių, kur TRUE reiškia, jog reikšmę reikia išrinkti, o FALSE -- neišrinkti.
# Pvz., iš vektoriaus d išrinksime pirmą ir trečią narius.

i <- c(TRUE, FALSE, TRUE, FALSE)
i
d[i]

# Toks indeksų vektorius labai dažnai gaunamas tikrinant kokią nors sąlygą.
# Pvz., iš vektoriaus d išskirsim tuos elementus, kurių reikšmė didesnė už 30.

i <- d > 30
i
d[i]

# Jei vektoriaus elementai turi vardus, tai konkretų vektoriaus elementą galima
# išrinkti nurodžius jo vardą.

i <- "vasaris"
d[i]

i <- c("kovas", "balandis")
d[i]


# UŽDUOTIS ------------------------------ 

# 1. Iš vektoriaus d išskirkite tuos elementus, kurių reikšmė tiksliai lygi 30.
# 2. Sudarykite tokį vardų vektorių, kad vektoriaus d elementus išvestų jų vardų 
#    abėcėlės tvarka.


# NAUDINGA ------------------------------

# Programuojant su R, kai kurios tipinės konstrukcijos užrašomos labai kompaktiškai. 
# Pvz., jei vektoriaus elementų išrinkimas yra vienkartinis ir niekur nepasikartoja, 
# tai tokį indeksą, jų vektorių ar loginę sąlygą galima įkelti tiesiai į laužtinius 
# skliaustus -- bus trumpiau.

d[c(4, 1)]
d[d > 30]
d["vasaris"]

# Jei veiksmų su vektoriais rezultatas yra vektorius, iš kurio reikia dar kartą 
# išrinkti tam tikrą elementą, tokį veiksmą galima padaryti dar kartą naudojant 
# išrinkimo operatorių [ ir nesukuriant tarpinio vektoriaus. Pvz., iš vektoriaus 
# d išrinksime antrąjį mėnesį, kurio dienų skaičius didesnis už 30.

d[d > 30][2]

# Komandos names rezultatas yra vektoriaus elementų vardų vektorius (žinoma, jei  
# jis egzistuoja). Tokio vektoriaus elementą galima išrinkti kaip iš bet kurio 
# kito vektoriaus. Pvz., išrinksime pirmojo vektoriaus d elemento vardą.

names(d)[1]


# UŽDUOTIS ------------------------------ 

# 1. Užrašykite komandą, kuri bet kokio ilgio vektoriui išrinktų paskutinį to 
#    vektoriaus vardų vektoriaus elementą.


# --------------------------------------- #
# ARITMETINĖS IR PASIKARTOJANČIOS SEKOS   #
# --------------------------------------- #

# Tarkime, kad mums reikalingas visų natūrinių skaičių nuo 1 iki 10 vektorius.
s <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
s

# Sveikųjų skaičių aritmetinę progresiją su žingsniu 1 arba -1 galima užrašyti
# labai kompaktiškai. Tam reikia per dvitaškį nurodyti pirmą ir paskutinį sekos 
# narius.

1:10  # sekoje dešimt sveikųjų skaičių nuo 1 iki 10

-5:5  # skaičiai sekoje gali būti neigiami

10:1  # skaičių seka gali būti ir mažėjanti


# Sudėtingesnėms aritmetinėms progresijoms sudaryti skirta procedūra seq. 
# Jos parametrai:
#
#       from -- pirmojo generuojamos sekos nario reikšmė,
#         to -- paskutinio generuojamos sekos nario reikšmė,
#         by -- generuojamos sekos žingsnis,
# length.out -- visos sekos elementų skaičius,
# along.with -- vektorius, kurio elementų skaičius bus sekos ilgis.


# Pvz., tą pačią skaičių seką nuo 1 iki 10 galima užrašyti taip:
s <- seq(from = 1, to = 10, by = 1)
s

# Jei parametrai nurodomi nustatyta tvarka, jų vardų galima visai nerašyti. 
s <- seq(1, 10, 1)
s

# Pagal nutylėjimą sekos žingsnis lygus 1, todėl ir parametro by galima nerašyti.
s <- seq(1, 10)
s

# Naudojant tą pačią funkciją galima keisti sekos žingsnį ar narių skaičių.
seq(1, 10, by = 0.5)                 # nurodome reikiamą sekos žingsnį 
seq(1, 10, length.out = 19)          # nurodome bendrą sekos narių skaičių

# Jei reikia sukurti seką, kurios ilgis lygus kito vektoriaus elementų skaičiui,
# tada naudojamas parametras along.with, kuriam priskiriamas tas vektorius.

d
seq(along.with = d)

# Kitų parametrų reikšmes taip pat galima keisti, pvz., nurodyti sekos pradžią 
# ar pabaigą, taip pat galima nurodyti sekos žingsnį.

seq(from = 1, to = 10, along.with = d)
seq(from = 10, by = 2, along.with = d)
seq(to   = 10, by = 2, along.with = d)


# NAUDINGA ------------------------------

# Jei sekos generavimui naudojamas vien tik parametras length.out, vietoje komandos
# seq(length.out = x) galima naudoti komandą seq_len(x).

seq(length.out = 10)
seq_len(10)

# Jei sekos generavimui naudojamas vien tik parametras along.with, vietoje komandos
# seq(along.with = x) galima naudoti komandą seq_along(x).

seq(along.with = d)
seq_along(d)

# Parametro from interpretacija priklauso nuo to, kokia reikšmė jam suteikiama: jei 
# vienas skaičius x, tai funkcijos seq(x) rezultatas bus kaip funkcijos seq_len(x), 
# jei vektorius x -- kaip funkcijos seq_along(x).

x <- 10
seq(x)

x <- c(F, F, T)
seq(x)


# UŽDUOTIS ------------------------------ 

# 1. Su komandą seq sudarykite seką iš mažesnių nei 100 nelyginių natūrinių skaičių.
# 2. Su komandą seq sudarykite seką, kuri atkarpą [0, 1] padalina į 10 lygių dalių.
# 3. Antro uždavinio rezultatą gaukite funkcijoje seq nenaudojant parametro by.
# 4. Antro uždavinio rezultatą gaukite iš vis nenaudodami funkcijos seq.


# Pasikartojančių elementų turinčios sekos generavimui naudojama funkcija rep. 
# Jos parametrai:
#
#          x -- vektorius, kurį reikia pakartoti,
#      times -- viso vektoriaus pakartojimų skaičius,
# length.out -- bendras sekos elementų skaičius,
#       each -- vektoriaus elementų pakartojimų skaičius.


# Sudarome vektorių (1, 2, 3), kurio elementus pakartosime įvairiais būdais.
v <- 1:3
v

# Viso vektoriaus pakartojimų skaičių nurodo parametras times. Tokiu atveju prie 
# vektoriaus galo prijungiamas toks pat vektorius ir tai pakartojama keletą kartų.
rep(v, times = 3)

# Vektoriaus elementų pakartojimų skaičius gali būti individualus. Tokiu atveju 
# parametro times reikšmė bus tokio pat ilgio vektorius su pakartojimų reikšmėmis.
rep(v, times = c(1, 5, 1))

# Tuo atveju, jei visi vektoriaus elementai turi būti pakartoti vienodą skaičių
# kartų, paprasčiau tą skaičių nurodyti parametrui each -- komanda bus aiškesnė.
rep(v, times = c(2, 2, 2))
rep(v, each = 2)

# Sugeneruotos sekos ilgis nebūtinai turi būti vektoriaus x ilgio kartotinis, jos 
# ilgį galima apriboti per parametrą length.out. Pvz, vektorių v kartojame, kol 
# visos sekos ilgis bus lygus 10.
rep(v, length.out = 10)

# Gali būti nurodomi iš karto keli argumentai, tačiau svarbu žinoti, kad parametras 
# each turi didesnį prioritetą prieš parametrą times.
rep(v, each = 2, times = 2)

# Pakartojamas vektorius gali būti bet kokio tipo. Jis gali turėti ir vieną reikšmę.
rep(1, times = 5)

# Jei parametrai užrašomi ta pačia tvarka, jų pavadinimų galima nerašyti.
rep(1, 5)


# UŽDUOTIS ------------------------------ 

# 1. Komandos rep(1, 5) rezultatą gaukite panaudodami funkciją seq.
# 2. Užrašykite rep komandą, kuri iš vektoriaus v sudarytų seką 1, 2, 2, 3, 3, 3.
