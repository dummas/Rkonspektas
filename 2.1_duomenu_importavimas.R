
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Duomenų importavimo iš tekstinio ar binarinio failo būdai.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2013-07-08 | 2013-07-12
#


# TURINYS -------------------------------

#
#   1. Duomenų nuskaitymas iš tekstinio failo:
#      * procedūra scan
#      * procedūra readLines
#      * procedūra read.table
#      * procedūra read.csv
#      * procedūra read.delim
#
#   2. Duomenų nuskaitymas iš binarinio failo:
#      * procedūra save
#      * procedūra load
#


# PASTABOS ------------------------------

#
# Parašyti apie funkciją count.fields.
# Parašyti apie funkciją read.fwf.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuviška lokalė. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# Ištrinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# DUOMENŲ NUSKAITYMAS IŠ TEKSTINIO FAILO  #
# --------------------------------------- #

# Daug elementų turintys vektoriai, didelės matricos, duomenų lentelės arba kiti 
# dideli duomenų masyvai paprastai laikomos failuose, kurių nuskaitymui R turi 
# keletą procedūrų. Aptarsime dažniausiai pasitaikančias situacijas.

# Vieno vektoriaus elementų nuskaitymui iš failo naudojama procedūrą scan. Galima 
# išrašyti pagrindinius jos parametrus:
#
#    file -- kabutėse užrašomas duomenų failo vardas arba kelias iki failo,
#    what -- vektoriaus reikšmių tipas: numeric(), character() ir pan.,
#     sep -- vektoriaus elementus skiriantis simbolis, pagal nutylėjimą tarpas,
#     dec -- dešimtainio kablelio simbolis, pagal nutylėjimą tai taškas ".",
#    skip -- pirmųjų nenuskaitomų eilučių faile skaičius,
#  nlines -- nuskaitomų failo eilučių skaičius,
#       n -- maksimalus vektoriaus elementų skaičius.

# Jei parametro file reikšmė nenurodoma, pagal nutylėjimą laikoma, jog jo reikšmė
# yra "" ir vektoriaus reikšmės bus įvedamos iš klaviatūros.

# Vektoriaus elementai nuskaitomi eilutėmis. Elementai faile gali būti surašyti 
# viename stulpelyje arba keliose eilutėse po kelis elementus vienoje eilutėje. 
# Elementų skaičius eilutėse nebūtinai turi sutapti ir gali skirtis.


# Sukursime tekstinį failą su keliomis skaitinėmis reikšmėmis. Reikšmės viena nuo
# kitos atskiriamos naujos eilutės simboliu \n, todėl faile visos jos surašomos 
# po vieną kiekvienoje eilutėje.

v <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
cat(v, file = "test.dat", sep = "\n")

# Iš sukurto tekstinio failo nuskaitome reikšmes ir iš jų sudarome vektorių x.
x <- scan(file = "test.dat")
x

# Galima nesunkiai patikrinti, kad pradinis ir nuskaitytas vektoriai sutampa.
identical(v, x)


# Sukursime simbolinių reikšmių vektorių ir įrašysime į failą. Reikšmes atskirsime 
# tarpo ženklu, todėl visos raidės faile bus vienoje eilutėje.

v <- c("a", "b", "c", "x", "y", "z")
cat(v, file = "test.dat", sep = " ")

# Kadangi dabar vektoriaus elementai yra simboliai, tai reikia nurodyti jų tipą.
x <- scan(file = "test.dat", what = character())
x


# Lietuvių kalboje dešimtainės trupmenos sveikoji ir trupmeninė dalys skiriamos
# kableliu, todėl nuskaitant tokį vektorių reikia pakeisti parametro dec reikšmę
# į ",". Sukursime failą, kuriame realieji skaičiai užrašyti su kableliu.

v <- c("1,5", "2,1", "3,1", "4,9")
cat(v, file = "test.dat", sep = "\n")

# Norint korektiškai nuskaityti tokį failą, reikia nurodyti, kad trupmeninę dalį
# skiria kablelis, o ne taškas, kaip nurodyta pagal nutylėjimą.
x <- scan(file = "test.dat", dec = ",")
x


# Failo pradžioje gali būti kelios tuščios eilutės arba eilutės, kuriose surašyta 
# papildoma informacija. Tada procedūrai reikia nurodyti ir praleidžiamų eilučių 
# skaičių.

v <- c("praleisti", "praleisti", " ", "a", "b", "c")
cat(v, file = "test.dat", sep = "\n")

# Gautame faile pirmos trys eilutės neturi jokios informacijos, todėl jas reikia
# praleisti. 

x <- scan(file = "test.dat", what = character(), skip = 3)
x


# NAUDINGA ------------------------------

# Dažnai duomenų failas yra internete. Tokiu atveju procedūros parametrui file 
# reikia nurodyti pilną jo adresą.
adresas <- "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/vekt_1a.dat"

x <- scan(file = adresas)
x


# Teksto eilutėms iš failo nuskaityti naudojama specialiai tam skirta procedūra 
# readLines. Pagrindiniai jos parametrai:
#
#     con -- duomenų failas arba simbolių eilutė,
#       n -- nuskaitomų eilučių skaičius.

# Procedūros rezultatas yra character tipo vektorius, kurio vienas elementas yra 
# viena teksto eilutė.

# Pavyzdžiui, nuskaitysime tekstinį failą, kuris turi penkias eilutes, po vieną
# sakinį kiekvienoje eilutėje.
adresas <- "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/vekt_3a.dat"

x <- readLines(adresas)
x


# UŽDUOTIS ------------------------------ 

# 1. Iš failo "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/vekt_1b.dat" 
#    nuskaitykite pirmus 20 vektoriaus elementų. 
# 2. Iš failo "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/vekt_2a.dat" 
#    nuskaitykite kabliataškiais atskirtus žodžius. Turite gauti character tipo
#    vektorių iš 10 elementų.
# 3. Iš failo "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/vekt_3a.dat" 
#    nuskaitykite tik pirmas 3 eilutes. 


# Duomenų lentelės iš failo nuskaitomos naudojant procedūrą read.table. Baziniai
# jos parametrai tokie:
#
#       file -- kabutėse užrašomas duomenų failo vardas arba kelias iki failo,
#     header -- TRUE nurodo, kad pirmoje eilutėje surašyti kintamųjų vardai,
#        sep -- stulpelius atskiriantis simbolis, pagal nutylėjimą tarpas,
#        dec -- dešimtainio kablelio simbolis, pagal nutylėjimą tai taškas ".",
#       skip -- skaičius pirmųjų eilučių, kurias reikia praleisti,
#      nrows -- skaičius eilučių, kurias reikia nuskaityti,
#  row.names -- eilučių vardų vektorius, jų stulpelio numeris arba pavadinimas,
#  col.names -- stulpelių pavadinimų vektorius,
# na.strings -- praleistos reikšmės simbolis, pagal nutylėjimą "NA",
#      as.is -- jei TRUE, tai kategoriniai kintamieji nuskaitomi kaip faktoriai.


# Kaip ir procedūrai scan, čia galima nurodyti, kad duomenų failas yra internete.
adresas <- "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/lent_1a.dat" 

# Pačiu paprasčiausiu atveju stulpeliai faile gali būti surašyti be pavadinimų.
# Tada procedūrai užtenka nurodyti tik duomenų failo adresą, o kintamųjų vardai
# sudaromi automatiškai.

d <- read.table(file = adresas)
d

# Jei duomenų faile stulpeliai pavadinimų neturi, kintamiesiems vardus suteikti 
# galima nuskaitymo metu. Tam reikia sukurti jų vardų vektorių. Vardų vektorius 
# turi turėti tiek elementų, kiek duomenų faile yra stulpelių.
k.vardas <- c("x", "y", "z")

d <- read.table(file = adresas, col.names = k.vardas)
d

# Jei kintamieji vardus turi, jie būna surašyti pirmoje duomenų failo eilutėje.
adresas <- "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/lent_1b.dat"

# Tokiu atveju parametro header reikšmę pakeičiame į TRUE.
d <- read.table(file = adresas, header = TRUE)
d


# Paprastai duomenų lentelės eilučių pavadinimai sutampa su jų eilės numeriais.
# Nuskaitymo iš failo metu eilutės sunumeruojamos automatiškai. Tačiau naudojant
# parametrą row.names galima eilutėms suteikti kitus vardus, tačiau jie būtinai 
# turi būti unikalūs.

# Jei pirmoje failo eilutėje kintamųjų vardų yra vienu mažiau nei stulpelių, tai 
# laikoma, kad pirmame stulpelyje yra eilučių vardai.
adresas <- "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/lent_2a.dat"

# Iš failo nuskaitome duomenų lentelę, kurios eilutės turi savo raidinius kodus.
d <- read.table(file = adresas, header = TRUE)
d

# Eilučių pavadinimai gali būti bet kuriame kitame duomenų lentelės stulpelyje.
adresas <- "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/lent_2b.dat" 

# Čia nurodome, kad eilučių kodai yra trečiame duomenų lentelės stulpelyje "E".
d <- read.table(file = adresas, header = TRUE, row.names = "E")
d


# Kartais duomenų failo pradžioje būna įrašoma tam tikra papildoma informacija. 
# Jei duomenų failo eilutė prasideda komentaro simboliu #, tai nuskaitymo metu
# tokia eilutė automatiškai praleidžiama. 
adresas <- "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/lent_3a.dat" 

# Šio failo pradžioje parašyta, kad trupmeninė skaičiaus dalis skiriama kableliu,
# todėl pakeičiame parametro dec reikšmę.
d <- read.table(file = adresas, header = TRUE, dec = ",")
d

# Jei failo pradžioje yra kelios neužkomentuotos eilutės, kurias reikia praleisti, 
# tokiu atveju per parametrą skip nurodome tokių eilučių skaičių.
adresas <- "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/lent_3b.dat" 

d <- read.table(file = adresas, header = TRUE, dec = ",", skip = 6)
d


# NAUDINGA ------------------------------

# Jei kelias iki failo yra ilgas, o duomenų nuskaitymas atliekamas vieną kartą,
# kartais paprasčiau ir greičiau duomenų failą pasirinkti interaktyviai naudojant 
# komandą file.choose().

# Pvz., sukursime paprastą duomenų failą "test.dat", kuriame į vieną stulpelį 
# surašytos visos didžiosios abėcėlės raidės. 
cat(LETTERS, file = "test.dat", sep = "\n")

# Nuskaitysime failą ne nurodydami jo pilną vardą, o pasirinkdami interaktyviai. 
# Visų kitų procedūros read.table parametrų reikšmės paliktos pagal nutylėjimą.

d <- read.table(file = file.choose())
d


# UŽDUOTIS ------------------------------ 

# 1. Iš failo "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/lent_1b.dat" 
#    duomenų lentelę nuskaitykite be kintamųjų vardų eilutės. 
# 2. Pakeiskite duomenų failo "lent_1b.dat" nuskaitymo komandą, kad duomenų
#    lentelės kintamieji gautų vardus "a", "b" ir "c".
# 3. Duomenų failo "test.dat" nuskaitymo komandą pakeiskite taip, kad kintamajam
#    būtų priskirtas vardas "Raidės".


# Kad duomenis būtų galima nesunkiai perkelti iš vienos programos į kitą, jie į 
# failus rašomi tam tikru standartiniu formatu. Vienas tekstinio duomenų failo 
# formatas yra taip vadinamas "comma separated value" arba sutrumpintai CSV. Jis
# skirtas lentelės pavidalo duomenims užrašyti, kur stulpeliuose yra kintamieji,
# o eilutėse yra stebiniai.

# Toks failas pirmoje eilutėje turi stulpelių pavadinimus. Jei stulpeliai vienas
# nuo kito atskiriami kableliu, tai trupmeninė skaičiaus dalis skiriama tašku.
# Tokio formato duomenų failui nuskaityti naudojama read.csv procedūra.

# Jei stulpeliai vienas nuo kito atskiriami kabliataškiu, tai trupmeninė skaičiaus 
# dalis skiriama mums įprastu kableliu. Tokio formato duomenų failui nuskaityti 
# naudojama procedūra read.csv2.

adresas <- "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/lent_1c.csv" 

d <- read.csv2(file = adresas)
d

# Žinoma, CSV formato failą galima nuskaityti ir naudojant procedūrą read.table,
# tačiau šiuo atveju nuskaitymo komanda yra paprastesnė. Jei stulpeliai duomenų
# faile atskiriami tabuliacijos ženklu "\t", tada tokiems duomenims nuskaityti 
# gali būti taikoma procedūra read.delim arba read.delim2.


# NAUDINGA ------------------------------

# Kartais pasitaiko situacija, kai iš duomenų failo reikia nuskaityti tik dalį
# kintamųjų, pvz., pirmus penkis kintamuosius arba kas antrą. Vienas sprendimas 
# akivaizdus: iš pradžių nuskaityti visus stulpelius, o tada įvairiais būdais iš 
# lentelės galima išmesti nereikalingus kintamuosius. 

# Kitas būdas nuskaityti tam tikrus stulpelius -- panaudoti procedūros parametrą 
# colClasses, kuriam nurodomas visų nuskaitomų stulpelių tipų vektorius. Vietoje
# įprasto reikšmės tipo numeric, character ar pan., galima nurodyti NULL tipą.
# Tada kintamasis, kuriam priskirtas NULL tipas į duomenų lentelę neįtraukiamas.

# Pavyzdžiui, iš failo "lent_1b.dat" nuskaitysime tik pirmus du kintamuosius. 
adresas <- "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/lent_1b.dat"

# Tam iš pradžių sukursime pagalbinį duomenų lentelės kintamųjų tipų vektorių.
k.tipas <- c("numeric", "numeric", "NULL")

d <- read.table(file = adresas, header = TRUE, colClasses = k.tipas)
d


# UŽDUOTIS ------------------------------ 

# 1. Iš failo "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/lent_4a.dat" 
#    nuskaitykite kas antrą stulpelį. 
# 2. Iš failo "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/lent_4b.dat" 
#    nuskaitykite tik paskutinius 2 iš 20 duomenyse esančių stulpelių. Nuskaitymo 
#    metu jiems priskirkite vardus "X" ir "Y".


# --------------------------------------- #
# DUOMENŲ NUSKAITYMAS IŠ BINARINIO FAILO  #
# --------------------------------------- #

# Jei duomenys sudėtingos struktūros, juos ne visada patogu laikyti tekstiniame 
# faile. Pavyzdžiui, tokie gali būti sudėtingi sąrašai, R statistinių procedūrų 
# rezultatų lentelės ir t.t. Tokiais atvejais kintamuosius ar duomenų rinkinius 
# patogiau užsaugoti kaip binarinį R duomenų failą su standartiniu tokio tipo
# failui išplėtimu .RData (išplėtimas gali būti ir kitoks). Vieną ar kelis R 
# kintamuosius tokiu formatu eksportuojame naudojant funkciją save.

# Pavyzdžiui, binariniu formatu išsaugosime standartinį didžiųjų raidžių vektorių.
save(LETTERS, file = "test.RData")

# Tokio tipo failas importuojamas naudojant procedūrą load. Žinoma, kaip ir kitus 
# duomenis, binarinį failą taip pat galima nuskaityti ir iš interneto.
load(file = "test.RData")


# UŽDUOTIS ------------------------------ 

# 1. Faile "http://fmf.vgtu.lt/~trekasius/Rkonspektas/duomenys/rdat_1a.RData"
#    išsaugotas kintamasis m su duomenų lentele. Importuokite šį failą.
