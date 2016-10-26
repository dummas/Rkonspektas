
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Sąrašų sudarymas ir pagrindiniai veiksmai su jais.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2012-09-03 | 2013-05-06
#


# TURINYS -------------------------------

# 
#   1. Sąrašų sudarymas ir jų sąvybės:
#      * komanda list
#      * komanda class
#      * komanda length 
#      * komanda names
#      * komanda attributes
#      * komanda str
#      * operatorius [
#      * operatorius [[
#      * operatorius $
#
#   2. Sąrašų apjungimas:
#      * komanda c
#      * komanda unlist 
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
# SĄRAŠŲ SUDARYMAS                        #
# --------------------------------------- #

# Sąrašas -- tokia duomenų struktūra, kuri nuo vektoriaus skiriasi tuo, kad sąrašo 
# elementai gali būti skirtingo tipo.

s <- list(0, NA, "a", TRUE, NULL)
s

# Be to, sąrašo elementai gali būti net ir skirtingos duomenų struktūros. Pvz., 
# vienas elementas gali būti skaičius, kitas -- loginių reikšmių vektorius, trečias 
# elementas iš skaičių sudaryta matrica, ketvirtas -- kažkoks kitas sąrašas, kurio 
# elementai yra kiti sąrašai. Tokiu būdu galima sukurti sudėtingas, hierarchines 
# duomenų struktūras.

s <- list(1:9, c(FALSE, FALSE, TRUE), matrix(1:4, 2, 2))
s


# Tokia duomenų struktūra yra specialaus list tipo.
class(s)

# Kaip ir vektoriaus, sąrašo elementų skaičius randamas su funkcija length.
length(s)

# Kaip ir vektoriaus, sąrašo elementams galima suteikti vardus. Tam naudojama
# komanda names.

names(s) <- c("skaitmenys", "logika", "matrica")
s

# Vardus elementams galima suteikti sąrašo sudarymo metu.
s <- list(skaitmenys = 1:9, logika = c(F, F, T), matrica = matrix(1:4, 2, 2))
s

# Kaip ir kitų R objektų, sąrašo atributus galima pažiūrėti su komanda attributes.
attributes(s)

# Sudėtingo objekto struktūrą galima pamatyti naudojant funkciją str. Pvz., matome,
# kad sąrašas s yra sudarytas iš trijų elementų, kurio pirmasis vadinasi „skaitmenys“ 
# ir yra sveikųjų skaičių vektorius, antras yra pavadintas „logika“ ir yra vektorius
# iš trijų loginių reikšmių, o trečias elementas vadinasi „matrica“, kurio elementai 
# yra skaičiai 1, 2, 3, 4 ir sudaro 2*2 matricą.

str(s)


# UŽDUOTIS ------------------------------ 

# 1. Sukurkite sąrašą, kuris turi du elementus: pirmas elementas yra vektorius iš
#    mažųjų lotyniškų raidžių, o antras -- iš to vektoriaus padaryta matrica su 
#    dviem stulpeliais. Sąrašo elementams suteikite vardus „vektorius“ ir „matrica“.


# Sąrašo elementus pagal jų eilės numerį galima išskirti dviem būdais: naudojant 
# operatorių [ ir naudojant operatorių [[. Pvz., išskirsime pirmą elementą.
a <- s[1]
a

b <- s[[1]]
b

# Kadangi operatorių [ naudojant išskirtas vektoriaus elementas taip pat yra 
# vektorius, tai analogiškai išskirtas sąrašo elementas taip pat bus sąrašas. 
# Operatorių [[ naudojant išskirtas sąrašo elementas turės savo pradinį tipą 
# ir struktūrą.

# Palyginus dviem būdais išskirtų sąrašo elementų klasę -- objekto tipą matome,
# kad pirmasis yra sąrašas iš vieno elemento -- vektoriaus, o antrasis ir yra
# tas sveikųjų skaičių vektorius.

class(a)
class(b)

names(a)
names(b)

length(a)
length(b)

str(a)
str(b)

# Jei sąrašo elementai turi vardus, juos galima panaudoti elementų išskyrimui.
# Šiuo atveju operatorių [ ir [[ naudojimas nesiskiria nuo jų naudojimo nurodant 
# elementų numerius.

x <- s["skaitmenys"]
x

y <- s[["skaitmenys"]]
y

# Operatorius $ naudojamas vieno sąrašo elemento išskyrimui nurodant jo vardą.
# Elemento vardas dažniausiai rašomas be kabučių.

s$skaitmenys


# Kaip ir vektoriams, naudojant operatorių [ galima išskirti keletą elementų iš 
# karto. Naudojant operatorių [[ galima išskirti tik vieną sąrašo elementą.

i <- c(1, 3)
s[i]

i <- c("skaitmenys", "matrica")
s[i]


# NAUDINGA ------------------------------

# Vienoje išraiškoje galima naudoti skirtingus operatorius [, [[ ar $. Kartais tas
# yra būtina, ypač tais atvejais, kai sąrašas yra sudėtingos struktūros ir reikia
# pasiekti giliai esantį elementą. Statistinių procedūrų rezultatai dažniausiai
# yra sąrašai, kurie gali būti sudaryti iš kitų sąrašų, kurių elementai dažnai yra 
# vektoriai, matricos ir t.t. Pvz., iš sąrašo s išskirsime pirmojo elemento, kuris 
# yra vektorius, ketvirtą narį.

# Čia sąrašo elementas išskiriamas su [[ ir jo numeriu, o vektoriaus su [ ir numeriu.
s[[1]][4]            

# Čia sąrašo elementas išskiriamas su [[ ir jo vardu, o vektoriaus su [ ir numeriu.
s[["skaitmenys"]][4] 

# Čia sąrašo elementas išskiriamas su $ nurodant vardą, o vektoriaus su [ ir numeriu.
s$skaitmenys[4]      


# UŽDUOTIS ------------------------------ 

# 1. Parašykite komandą, kuri, nepriklausomai nuo sąrašo elementų skaičiaus, 
#    išskirtų  pirmą ir paskutinį jo elementus.
# 2. Trimis aukščiau aprašytais būdais išskirkite iš sąrašo s paskutinio elemento 
#    (matricos) paskutinį elementą. Parašykite tokią komandą, kuri nepriklausytų 
#    nuo sąrašo ilgio.


# --------------------------------------- #
# SĄRAŠŲ APJUNGIMAS                       #
# --------------------------------------- #

# Praktikoje dažnai tenka analizuoti to paties tipo, bet skirtingo ilgio vektorius, 
# kurių negalima apjungti į matricą, nes eilutės ar stulpeliai negali būti skirtingo
# ilgio. Tokiais atvejais vektorius patogu apjungti į sąrašą.

# Sukurkime tuščią sąrašą, prie kurio prijungsime naujus elementus -- vektorius.
u <- list()
v <- list()

u[[1]] <- c(22, 83, 64, 23, 34, 93, 95, 36, 25, 49, 55, 13)
u[[2]] <- c(60, 95, 19, 9, 82, 26, 53, 84, 50, 74, 88, 62, 83, 42, 18, 77, 3)
u[[3]] <- c(67, 24, 63, 85, 65, 49, 37, 42, 72)
u[[4]] <- c(21, 35, 97, 88, 77, 62, 91, 58, 23, 56, 5, 2, 34, 82, 16)

v[[1]] <- c(3, 66, 43, 55, 97, 81, 96, 5, 98, 52, 15, 68, 11, 50, 87, 17)


# Viename sąraše yra keturi vektoriai, kitame -- vienas. Visi jie to paties tipo, 
# tačiau skirtingų ilgių.
u 
v

# Naudojant funkciją c, sąrašus, kaip ir vektorius, galima prijungti vieną prie 
# kito. Tokiu atveju gaunamas sąrašas, kurio ilgis lygus apjungiamų sąrašų elementų 
# skaičiui.
l <- c(u, v)
l

length(l)
class(l)
str(l)


# Naudojant funkciją list, sąrašus u ir v galima apjungti į vieną bendrą sąrašą. 
# Tokiu atveju gaunamas sąrašas iš dviejų elementų, kurių kiekvienas atskirai yra 
# sąrašas.
z <- list(Pirmas = u, Antras = v)
z

length(z)
class(z)
str(z)

# Tokio sąrašo pirmo elemento pirmo vektoriaus pirmas narys išskiriamas taip:
z$Pirmas[[1]][1]


# Sąrašo struktūrą galima supaprastinti apjungiant jį sudarančius elementus į 
# vektorių. Tam naudojama funkcija unlist. Jos parametrai:
#
#         x -- sąrašas, kurio struktūrą ketiname supaprastinti,
# recursive -- pagal nutylėjimą TRUE, nurodo sąrašo elementus apjungti rekursiškai,
# use.names -- pagal nutylėjimą TRUE, nurodo sąrašo elementams išlaikyti vardus.

# Pritaikius šią funkciją sąrašui l, kuris turėjo 5 elementus-vektorius, gaunamas 
# vienas ilgas vektorius.
unlist(l)

# Pritaikius šią funkciją dviejų lygių sąrašui z taip pat gauname vieną ilgą vektorių.
# Kadangi sąrašo elementai turėjo vardus, tai gauto vektoriaus elementai su vardais.
unlist(z)

# Galima nurodyti, kad naujai gautas vektorius neturėtų senojo sąrašo vardų.
unlist(z, use.names = FALSE)

# Pagal nutylėjimą sąrašo, kurį sudaro kiti sąrašai, elementai apjungiami rekursiškai.
# Pakeitus parametro recursive reikšmę į FALSE, gauname sąrašą, kurį sudaro giliau 
# esančių sąrašų elementai, šiuo atveju -- vektoriai.

unlist(z, recursive = FALSE)

unlist(z, recursive = FALSE, use.names = FALSE)

# Panaikinus tokio sąrašo elementų vardus, gauname tokį pat sąrašą, koks buvo 
# gautas su funkcija c apjungus sąrašus u ir v. Tokiu būdu galima supaprastinti 
# hierarchinę struktūrą turinčius sąrašus.


# UŽDUOTIS ------------------------------ 

# 1. Užrašykite kaip galima trumpesnę komandą, kuri sukurtų sąrašą, sudarytą iš 10
#    2*2 dydžio matricų, kurios pirmo stulpelio elementai lygūs 1, o antro -- 2. 
# 2. Duotas sąrašas w <- list(list(list(1:2), list(3:4)), list(list(5:6), list(7:8))).
#    Išnagrinėkite jo struktūrą. Kiek elementų sudaro taip užrašytą sąrašą? 
#    Funkcija unlist(w) iš šio sąrašo padaro vektorių (1, 2, 3, 4, 5, 6, 7, 8).
#    Gaukite tokį pat vektorių su funkcija unlist, tačiau su parametru recursive = F.
