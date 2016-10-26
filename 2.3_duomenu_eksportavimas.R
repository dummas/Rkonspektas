
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Duomenų eksportavimo į tekstinį ar binarinį failą būdai.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2013-07-22 | 2013-07-25
#


# TURINYS -------------------------------

#
#   1. Duomenų eksportavimas į tekstinį failą:
#      * procedūra write
#      * procedūra writeLines
#      * procedūra write.table
#      * procedūra write.csv
#
#   2. Duomenų įrašymas į binarinį failą:
#      * procedūra save
#      * procedūra load
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
# DUOMENŲ EKSPORTAVIMAS Į TEKSTINĮ FAILĄ  #
# --------------------------------------- #

# Vektoriaus ar matricos reikšmės į tekstinį failą įrašomos naudojant procedūrą 
# write. Pagrindiniai parametrai tokie:
#
#        x -- R kintamasis: vektorius arba matrica,
#     file -- kabutėse užrašomas duomenų failo vardas arba kelias iki failo,
#      sep -- simbolis, kuriuo faile atskiriamos vektoriaus reikšmės,
# ncolumns -- vektoriaus elementų skaičius vienoje failo eilutėje,
#   append -- jei TRUE, vektoriaus reikšmės įrašomos į jau esantį failą.

# Jei parametrui file nurodomas tik duomenų failo vardas, tai darbiniame kataloge 
# sukuriamas failas, į kurį įrašomos kintamojo reikšmės. Darbinį katalogą galima 
# sužinoti su komanda getwd(), o pakeisti su komanda setwd (kaip šiame skripte). 
# Nepriklausomai nuo darbinio katalogo, galima nurodyti ir pilną kelią iki failo,
# tačiau toks užrašymo būdas ilgesnis ir dažnai nepatogus. Paprasčiau programos 
# pradžioje nurodyti reikiamą darbinį katalogą ir duomenis į jį rašyti nurodant 
# tik failo vardą.

# Kintamojo reikšmės surašomos į tekstinį failą, bet failo išplėtimas nebūtinai 
# turi būti txt. Pagal nutylėjimą skaitinio vektoriaus reikšmės faile surašomos
# eilutėmis po 5 reikšmes vienoje eilutėje, o simbolinio -- po vieną elementą į 
# vieną eilutę.

# Sukursime paprastą vektorių iš skaitmenų ir jį įrašysime į tekstinį failą.
v <- c(0, 1, 2, 3, 4, 5, 6, 7, 8, 9)
v

write(x = v, file = "numb.vec")

# Galima pamatyti, kad kataloge "C:/Downloads" sukuriamas failas numb.vec, kurio
# viduje penkiuose stulpeliuose įrašytos vektoriaus reikšmės.

# Pagal nutylėjimą vektoriaus reikšmės faile atskiriamos tarpu. Tą patį vektorių
# įrašysime į failą, kuriame reikšmės bus atskirtos tabuliacijos ženklu \t.
write(x = v, file = "numb.vec", sep = "\t")

# Jei elementai atskiriami naujos eilutės ženklu \n, tai faile jie bus surašyti 
# į vieną stulpelį.
write(x = v, file = "numb.vec", sep = "\n")

# Jei dėl kokių nors priežasčių vektoriaus reikšmes faile reikia įrašyti į vieną
# ar kelis stulpelius, tai pakeičiama numatytoji parametro ncolumns reikšmė.
write(x = v, file = "numb.vec", ncolumns = 2)

# Kartais pasitaiko situacija, kai keletos vektorių reikšmes reikia surašyti į tą 
# patį failą. Tokiais atvejais parametro append reikšmę reikia pakeisti į TRUE.
# Pavyzdžiui, į jau sukurtą failą dar kartą įrašysime tą patį vektorių.

write(x = v, file = "numb.vec")
write(x = v, file = "numb.vec", append = TRUE)


# Kadangi R kalboje matrica suprantama kaip vektorius, kurio elementai išdėstyti
# stulpeliais ar eilutėmis, tai matricą taip pat galima įrašyti į failą. Kadangi
# matricos elementai nuskaitomi stulpeliais, o į failą įrašomi eilutėmis, tam kad
# faile matrica turėtų tokius pat išmatavimus, ją reikia transponuoti.

# Pavyzdžiui, sukursime 3x4 dydžio skaičių matricą ir įrašysime ją į failą.
x <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
m <- matrix(x, ncol = 4)
m

# Transponavimui naudojama funkcija t. Stulpelių skaičius nurodomas toks pat.
write(x = t(m), file = "numb.mat", ncolumns = 4)


# Tekstinio vektoriaus elementai pagal nutylėjimą į failą įrašomi stulpeliu. 
t <- c("P", "R", "O", "G", "R", "A", "M", "A", "V", "I", "M", "A", "S")
t

write(x = t, file = "text.vec")


# Jei vektoriaus elementai yra simbolių sekos, žodžių junginiai ar sakiniai, tai
# patogumo dėlei faile tie sakiniai rašomi po vieną į vieną eilutę -- stulpeliu. 
# Tokiu atveju galima naudoti specialią procedūrą writeLines. Jos parametrai:
#
#    text -- tekstinis vektorius,
#     con -- tekstinio failo ar kito išvedimo įrenginio pavadinimas,
#     sep -- simbolis, kuriuo faile atskiriamos vektoriaus reikšmės.

t <- c("Pirmas sakinys.", "Antras sakinys.", "Trečias sakinys.", "Jau pabaiga.")

writeLines(text = t, con = "text.txt")

# Vektoriaus elementus faile galima atskirti ne tik naujos eilutės, bet ir kokiu
# nors kitu simboliu. Pavyzdžiui, elementus faile atskirsime tarpo ženklu.

writeLines(text = t, con = "text.txt", sep = " ")


# NAUDINGA ------------------------------

# Procedūrai write nenurodžius failo vardo, pagal nutylėjimą darbiniame kataloge 
# automatiškai sukuriamas tekstinis failas "data" be išplėtimo.
write(x = v)

# Jei parametrui file vietoj failo vardo nurodomos tuščios kabutės, tai vektorius
# "įrašomas" į konsolę. 
write(x = v, file = "")

# Tokiu būdu galima pakeisti į konsolę išvedamo vektoriaus formatą. Pavyzdžiui, 
# vektorių į konsolę išvesime dviem stulpeliais.
write(x = v, file = "", ncolumns = 2)


# UŽDUOTIS ------------------------------ 

# 1. Naudodami procedūrą write, užrašykite komandą, kuri matricos m elementus į
#    failą surašytų viename stulpelyje.
# 2. Naudodami procedūrą write, užrašykite komandą, kuri tekstinio vektoriaus t 
#    elementus į failą įrašytų dviem stulpeliais.
# 3. Naudodami procedūrą write, užrašykite komandą, kuri vektoriaus t elementus
#    į failą surašytų vienoje eilutėje. Papildykite komandą taip, kad elementai 
#    būtų įrašomi be tarpų.
# 4. Naudodami procedūrą writeLines, užrašykite tokią komandą, kuri vektoriaus t
#    elementus įrašytų vienoje eilutėje be tarpų.


# Duomenų lentelės į tekstinį failą įrašomos naudojant procedūrą write.table. 
# Dažniausiai naudojami parametrai:
#
#         x -- duomenų lentelė, data.frame tipo kintamasis,
#      file -- kabutėse užrašomas duomenų failo vardas arba kelias iki failo,
#       sep -- simbolis, kuriuo faile atskiriamos vektoriaus reikšmės,
#       dec -- dešimtainio kablelio simbolis, pagal nutylėjimą tai taškas ".",
# row.names -- jei TRUE, tai lentelė įrašoma su eilučių pavadinimais,
# col.names -- jei TRUE, tai lentelė įrašoma su stulpelių pavadinimais,
#    append -- jei TRUE, vektoriaus reikšmės įrašomos į jau esantį failą,
#     quote -- jei TRUE, tekstiniai kintamieji ir faktoriai įrašomi į kabutes.

# Vietoje loginių reikšmių TRUE arba FALSE, parametrams row.names ir col.names
# galima priskirti atitinkamai eilučių arba stulpelių vardų vektorių. 

# Kategorinių kintamųjų reikšmės gali būti ne tik atskiri simboliai arba žodžiai,
# bet ir keletos simbolių ar žodžių junginiai su tarpu, pvz., vardas ir pavardė.
# Kadangi pagal nutylėjimą duomenų lentelė į failą įrašoma stulpelius atskiriant
# tarpu, iš kelių žodžių sudaryta kintamojo reikšmė užrašoma per keletą stulpelių. 
# Gali susidaryti situacija, kai stulpelių faile yra daugiau nei kintamųjų. Tokį 
# duomenų failą sunku korektiškai nuskaityti, todėl pagal nutylėjimą kategorinių
# kintamųjų reikšmės į failą įrašomos kabutėse. Stulpelius faile atskiriant ne
# tarpu, bet tabuliacijos ženklu \t, kabliataškiu arba kokiu nors kitu specifiniu 
# simboliu, kabučių galima atsisakyti.


# Sudarysime duomenų lentelę d, kurios stulpeliuose yra trys skirtingo tipo 
# vektoriai: numeric, logical ir character.

x <- c(22.1, 37.5, 68.3, 47.7, 92.9, 87.2, 39.4, 19.6, 97.2, 32.4)
y <- c(FALSE, TRUE, TRUE, FALSE, FALSE, FALSE, TRUE, TRUE, FALSE, FALSE)
z <- c("P", "P",  "P",  "T",  "T",  "T",  "A",  "A",  "A",  "A")

# Duomenų lentelės stulpeliai turės pavadinimus X, Y ir Z.
d <- data.frame(X = x, Y = y, Z = z)
d

# Įrašysime gautą duomenų lentelę į failą. Užtenka nurodyti lentelės pavadinimą
# ir failo vardą. Jis bus įrašytas į darbinį katalogą.
write.table(x = d, file = "duom.dat")


# Be papildomų nustatymų į failą atskiru stulpeliu įrašomi eilučių pavadinimai.
# Tais atvejais, kai eilučių pavadinimai sutampa su numeriais, kurie nuskaitymo 
# metu priskiriami automatiškai, į failą jų galima ir nerašyti.
write.table(x = d, file = "duom.dat", row.names = FALSE)

# Pagal nutylėjimą kategorinių kintamųjų reikšmės įrašomos kabutėse. Tuo atveju,
# kai kintamojo reikšmės yra vienas simbolis arba vienas žodis, kabučių nereikia.
write.table(x = d, file = "duom.dat", row.names = FALSE, quote = FALSE)

# Pagal nutylėjimą stulpeliai faile atskiriami tarpu, tačiau dažnu atveju geriau
# atskirti tabuliacijos ženklu arba kabliataškiu. Tai nurodoma per parametrą sep.
write.table(x = d, file = "duom.dat", row.names = FALSE, sep = ";")

# Pagal lietuvių kalbos taisykles trupmeninė skaičiaus dalis skiriama kableliu,
# tai nurodoma per parametrą dec. Čia duomenų lentelė į failą įrašoma stulpelius 
# atskiriant tabuliacijos ženklu.
write.table(d, file = "duom.dat", row.names = F, quote = F, sep = "\t", dec = ",")


# Kad duomenis būtų galima nesunkiai perkelti iš vienos programos į kitą, jie į 
# failus rašomi tam tikru standartiniu formatu. Vienas tekstinio duomenų failo 
# formatas yra taip vadinamas "comma separated value" arba sutrumpintai CSV. Jis
# skirtas lentelės pavidalo duomenims užrašyti, kur stulpeliuose yra kintamieji,
# o eilutėse yra stebiniai.

# Toks failas pirmoje eilutėje turi stulpelių pavadinimus. Jei stulpeliai vienas
# nuo kito atskiriami kableliu, tai trupmeninė skaičiaus dalis skiriama tašku.
# Duomenų tokiu formatu įrašymui naudojama write.csv procedūra. Jei stulpeliai 
# vienas nuo kito skiriami kabliataškiu, tai trupmeninė skaičiaus dalis skiriama 
# mums įprastu kableliu. Duomenys tokiu formatu įrašomi su procedūra write.csv2.
# Šių procedūrų parametrai tokie patys kaip ir procedūros write.table, skirtumas
# toks, kad nereikia nurodyti parametrų sep ir dec reikšmių.

# Pavyzdžiui, CSV formatu įrašysime tą pačią duomenų lentelę d.
write.csv2(x = d, file = "duom.csv")

# Kaip ir anksčiau, čia nereikalingi eilučių numeriai ir kintamieji kabutėse.
write.csv2(d, "duom.csv", row.names = F, quote = F)


# UŽDUOTIS ------------------------------ 

# 1. Duomenų lentelėje iris yra duomenys apie kelių rūšių augalų žiedų matavimus.
#    Naudodami procedūrą write.table, įrašykite šiuos matavimus į tekstinį failą 
#    "irisas.txt": stulpeliai faile atskiriami tabuliacijos ženklu, kategoriniai 
#    kintamieji įrašomi be kabučių, eilučių numeriai nereikalingi.
# 2. Kintamasis Titanic yra laivo katastrofą išgyvenusių keleivių kryžminė dažnių 
#    lentelė, sudaryta pagal lytį, amžių ir klasę. Konsolėje galima pamatyti, kad
#    ją sudaro keturios atskiros dalys. Naudodami procedūrą write.table, įrašykite 
#    šią lentelę į tekstinį failą: eilučių numerių nereikia, stulpeliai atskirti
#    tabuliacijos ženklu, kategorinių kintamųjų reikšmės rašomos be kabučių.
# 3. Naudodami procedūrą write.table, duomenų lentelę cars įrašykite į tekstinį 
#    failą su lietuviškais stulpelių pavadinimais.
# 4. CSV formatu įrašykite duomenų lentelę iris. Trupmeninė skaičiaus dalis turi
#    būti skiriama kableliu.


# --------------------------------------- #
# DUOMENŲ ĮRAŠYMAS Į BINARINĮ FAILĄ       #
# --------------------------------------- #

# Jei duomenys sudėtingos struktūros, juos ne visada patogu laikyti tekstiniame 
# faile. Pavyzdžiui, tokie gali būti sudėtingi sąrašai, R statistinių procedūrų 
# rezultatų lentelės ir t.t. Tokiais atvejais kintamuosius ar duomenų rinkinius 
# patogiau užsaugoti kaip binarinį R duomenų failą su standartiniu tokio tipo
# failui išplėtimu .RData (išplėtimas gali būti ir kitoks). Taip daroma ir tada, 
# kai reikia išsaugoti sudėtingų ar ilgai trunkančių skaičiavimų rezultus, o jų 
# pakartojimas užtrunka ilgiau nei importavimas iš failo. Duomenis binariniu 
# formatu įrašome naudojant procedūrą save.

# Pavyzdžiui, binariniu formatu išsaugosime duomenų lentelę. Failas bus įrašytas
# į darbinį katalogą. Taip pat galima nurodyti ir pilną kelią iki failo.
save(d, file = "duom.RData")

# Tokiu būdu galima išsaugoti iš karto keletą vektorių, duomenų lentelių ar kitų
# R kintamųjų. Jų vardai atskiriami kableliu.
save(x, y, z, file = "duom.RData")

# Jei kintamųjų, kuriuos reikia išsaugoti, yra daug, jų vardus galima surašyti į
# character tipo vektorių. Tada procedūros parametrui list reikia nurodyti tų 
# kintamųjų vardų vektorių. Pavyzdžiui, užsaugosime keletą tokių kintamųjų.
save(list = c("x", "y", "z", "d"), file = "duom.RData")


# Binarinio tipo failas importuojamas naudojant procedūrą load. Pademonstruosime
# jos veikimą importuodami failą "duom.RData".

# Ištrinami visi kintamieji.
rm(list = ls())

# Įsitikiname, kad prieš importavimą nėra jokių kintamųjų.
ls()

# Importuojame failą "duom.RData", kuriame įrašyti kintamieji, x, y, z ir d.
load(file = "duom.RData")

# Matome, kad atsirado anksčiau į failą įrašyti kintamieji.
ls()


# UŽDUOTIS ------------------------------ 

# 1. Vektorių v ir matricą m įrašykite į vieną binarinį failą "vecmat.RData".
#    Užrašykite ir komandos variantą, kuriame naudojamas parametras list.
