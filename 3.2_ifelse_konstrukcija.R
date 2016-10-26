
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Sąlygos konstrukcija if-else ir funkcija ifelse.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2013-08-16 | 2013-08-22
#


# TURINYS -------------------------------

#
#   1. Sąlygos tikrinimas:
#      * funkcija if
#      * funkcija ifelse
#


# PASTABOS ------------------------------

#
# Pastabų nėra.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuviška lokalė. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# Ištrinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# IF-ELSE KONSTRUKCIJA                    #
# --------------------------------------- #

# Skaičiavimai dažnai priklauso nuo kintamiesiems ar jų reikšmėms keliamų sąlygų:
# jei jos tenkinamos, tai atliekami vieni veiksmai, jei netenkinamos -- kiti. 
# Tokiais atvejais naudojama sąlygos tikrinimo konstrukcija if-else. Bendras jos
# pavidalas toks:
#
#   if (loginė sąlyga) {
#       išraiškos A
#   } else {
#       išraiškos B
#   }
#
# Loginės sąlygos rezultatas turi būti vieną elementą turintis loginis vektorius,
# kurio reikšmė arba TRUE, arba FALSE. Sąlygos rezultatas negali būti NA reikšmė.
# Jei sąlygos vektorius turi daugiau nei vieną elementą, tikrinama tik pirmojo 
# elemento reikšmė. Jei sąlygos reikšmė TRUE, įvykdomos išraiškos A, kitu atveju
# įvykdomos išraiškos B.

# Pastaba! Komanda else turi būti toje pačioje eilutėje kaip ir } skliaustelis.

# Pavyzdžiui, užrašysime komandą, kuri patikrina ar kintamojo d reikšmė viršija 
# nustatytą ribą. Jei ši nelygybė teisinga, reikšmė prisumuojama, o tokių dydžių
# skaičius padidinamas vienetu. Priešingu atveju į konsolę išvedamas pranešimas.

riba <- 20   # tam tikra kintamojo reikšmės riba
kiek <- 0    # ribą viršijančių dydžių skaičius
suma <- 0    # ribą viršijančių dydžių suma

d <- 13      # kintamojo d reikšmę galima keisti

if (d > riba) {
    kiek <- kiek + 1
    suma <- suma + d
} else {
    cat("Dydis neviršija nustatytos ribos\n.")
}

kiek
suma

# Jei išraišką riestiniuose skliaustuose galima užrašyti kaip vieną komandą, tai 
# skliaustų {} galima ir nenaudoti. Tokiu atveju visa if-else komanda užrašoma 
# viena eilute:
#
#   if (loginė sąlyga) išraiška A else išraiška B

# Pavyzdžiui, užrašysime komandą, kuri, priklausomai nuo testo reikšmės, reikšmę
# 1 priskiria arba kintamajam x, arba kintamajam y.

testas <- TRUE
x <- 0
y <- 0

if (testas) x <- 1 else y <- 1

x
y


# Dažnai naudojama supaprastinta if konstrukcija:
#
#   if (loginė sąlyga) {
#       išraiškos A
#   }

# Pvz., turime du skaitinius kintamuosius: a ir b. Kintamojo a reikšmė turi būti 
# mažesnė už kintamojo b reikšmę. Jei teisinga nelygybė a > b, tai šių kintamųjų 
# reikšmes sukeisime vietomis, jei ne -- kintamųjų reikšmės lieka tokios pačios.

a <- 6
b <- 2

if (a > b) {
  t <- a
  a <- b
  b <- t

  rm(t)  # tarpinis kintamasis t ištrinamas
}

a
b


# Loginės sąlygos rezultatas turi būti vieną elementą turintis loginis vektorius.
# Tai reiškia, kad galima patikrinti sąlygą apie visą vektorių, tačiau negalima 
# patikrinti sąlygos apie kiekvieną vektoriaus elementą atskirai.

# Pavyzdžiui, užrašysime komandą, kuri patikrina, ar vektorius z turi bent vieną
# elementą su praleista reikšme. Jei taip, į konsolę išvedami tokių elementų
# numeriai. Priešingu atveju užrašomas pranešimas, kad praleistų reikšmių nėra.

z <- c(1, 2, NA, 4, 5, NA, NA, 8)

praleistas <- is.na(z)
praleistas

# Funkcijos is.na rezultatas yra tokio pat ilgio loginis vektorius, bet komanda
# if tikrina tik pirmojo elemento reikšmę, todėl neatsižvelgus į kitus elementus,
# gaunamas nekorektiškas atsakymas. 

# Naudojant funkciją all, galima patikrinti, ar visų loginio vektoriaus elementų 
# reikšmė yra TRUE. Čia bus naudojama funkcija any, kurios reikšmė yra TRUE, jei 
# bent vienas loginio vektoriaus elementas turi reikšmę TRUE.

if (any(praleistas)) {
    i <- which(praleistas)
    cat("Elementų su praleistomis reikšmėmis numeriai:\n")
    print(i)
} else {
    cat("Elementų su praleistomis reikšmėmis nėra.\n")
}


# Tuo atveju, kai vektoriaus elementui priskiriama arba viena, arba kita reikšmė,
# priklausomai nuo to, ar tam tikrą sąlygą tenkina atitinkamas kito vektoriaus
# elementas, naudojama funkcija ifelse. Jos parametrai:
#
#     test -- loginių reikšmių vektorius,
#      yes -- reikšmė, jei loginio testo reikšmė TRUE,
#       no -- reikšmė, jei loginio testo reikšmė FALSE.

# Šiuo atveju loginių reikšmių vektorius gali būti bet kokio ilgio ir paprastai 
# jis yra loginės sąlygos apie vektoriaus elementus rezultatas.

# Tokiu būdu, sąlyga apie kiekvieną vektoriaus elementą patikrinama, ir viena ar
# kita reikšmė kito vektoriaus elementui priskiriama nenaudojant ciklo.

# Pavyzdžiui, užrašysime komandą, kuri vektoriaus m elementui priskiria reikšmę
# 1, jei vektoriaus n elementas yra lyginis, ir reikšmę -1, jei -- nelyginis.

n <- c(2, 5, 1, 6, 8, 7, 3, 9, 4)

m <- ifelse(n %% 2 == 0, 1, -1)
m

# Pastaba! Kartais vektoriaus reikšmių perkodavimui funkcija ifelse nereikalinga.
# Pavyzdžiui, jei lyginį vieno vektoriaus elementą atitinka 0, o nelyginį 1, tai
# toks perkodavimas atliekamas paprasčiau -- surandant dalybos iš dviejų liekaną.

m <- n %% 2
m


# NAUDINGA ------------------------------

# Konstrukciją if-else galima naudoti kaip funkciją, kurios reikšmė priklauso
# nuo sąlygos ir apskaičiuojama pagal vieną iš dviejų išraiškų:
#
#   y <- if (loginė sąlyga) {
#       išraiškos A
#   } else {
#       išraiškos B
#   }

# Pavyzdžiui, užrašysime komandą, kuri pagal kintamojo x ženklą kitam kintamajam 
# f priskiria arba tą pačią reikšmę x, arba jai priešingą reikšmę -x.

x <- 3

y <- if (x > 0) {
    f <- x
} else {
    f <- -x
}

# Riestiniuose skliaustuose užrašyto išraiškų bloko reikšmė yra paskutinės bloko 
# viduje esančios išraiškos rezultatas, todėl kintamajam y priskiriama kintamojo
# f reikšmė.
y


# Kaip ir anksčiau, jei riestiniuose skliaustuose įrašyta tik viena išraiška, jų 
# galima atsisakyti ir visą komandą užrašyti vienoje eilutėje:
#
# y <- if (loginė sąlyga) reikšmė A else reikšmė B

# Pavyzdžiui, užrašysime funkciją-indikatorių, kuri įgyja reikšmę 1, jei x > 10,
# ir reikšmę 0 -- priešingu atveju.

x <- 3

y <- if (x > 10) 1 else 0
y

# Jei x būtų daugiau nei vieną elementą turintis vektorius, tokiam priskyrimui 
# geriausia naudoti anksčiau aprašytą funkciją ifelse.


# Kaip funkciją galima naudoti ir supaprastintą if konstrukciją be else dalies.
# Tokiu atveju, jei loginės sąlygos reikšmė yra FALSE, grąžinama NULL reikšmė!

y <- if (x > 10) 1
y


# UŽDUOTIS ------------------------------ 

# 1. Kintamojo egzistavimui nustatyti naudojama funkcija exists. Naudodami šią
#    funkciją, užrašykite komandą, kuri patikrina ar, egzistuoja kintamasis, ir, 
#    jei tokio kintamojo nėra, į konsolę išvedamas tekstinis pranešimas.
# 2. Naudojant funkciją ifelse, užrašykite komandą, kuri NA reikšmę turintiems
#    vektoriaus z elementams priskirtų reikšmę 0. Užrašykite analogišką komandą 
#    nenaudojant funkcijos ifelse.
# 3. Skaičiaus ženklo nustatymui naudojama funkcija sign. Naudojant funkciją if,
#    užrašykite skaičiaus x ženklo nustatymo funkciją, kuri įgyja reikšmę 1, kai
#    skaičius x > 0, reikšmę -1, kai x < 0 ir reikšmę 0, kai x = 0.
# 4. Užrašykite komandą, kuri patikrina, ar visų vektoriaus n elementų reikšmės 
#    neviršija 5. Jei ši sąlyga teisinga, tai kintamajam k priskiriama reikšmė 0.
#    Jei sąlyga netenkinama, kintamajam k priskiriamas didesnių už 5 vektoriaus
#    elementų skaičius, o kintamajam l priskiriamas bendras elementų skaičius.
# 5. Užrašykite komandą, kuri patikrintų, ar vektorius n yra sveikųjų skaičių
#    vektorius. Jei ne, vektoriaus klasę pakeiskite į sveikųjų ir į konsolę
#    išveskite pranešimą apie vektoriaus klasės pakeitimą.
