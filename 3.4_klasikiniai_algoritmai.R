
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Keletas klasikinių algoritmų su ciklais.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2013-08-23 | 2013-08-25 | 2014-02-23
#


# TURINYS -------------------------------

#
#   1. Keletas klasikinių algoritmų su ciklais:
#      * Newton-Raphson metodas kvadratinei šakniai surasti
#      * vektoriaus elementų išrikiavimas "burbuliuko" metodu
#      * Euklido algoritmas didžiausiam bendram dalikliui
#      * pseudoatsitiktinių dydžių generavimo algoritmas
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
# NEWTON-RAPHSON METODAS                  #
# --------------------------------------- #

# Newton-Raphson metodas taikomas lygties f(x) = 0 šaknų radimui. Čia naudojama
# tokia iteracinė išraiška:
#
#   x := x - f(x)/f'(x)
#
# Pritaikysime šį metodą apytiksliam šaknies iš skaičiaus traukimui. Nagrinėkime
# funkciją f(x) = x^2 - a. Jos išvestinė f'(x) = 2x. Atlikę pertvarkymus gauname 
# tokią iteracinę išraišką:
#
#   x := (x + a/x)/2

# Čia dydis a yra skaičius, iš kurio traukiama šaknis, o kairėje lygties pusėje 
# esantis dydis x yra apytikslė tos šaknies reikšmė. Algoritmui reikia nurodyti
# pradinę x reikšmę ir iteracijų skaičių. 

# Tegu iteracijų skaičius fiksuotas ir lygus n, todėl naudosime konstrukciją for.
# Kadangi tarpinių reikšmių vektorius nesudaromas, ciklo kintamasis nenaudojamas. 

a <- 25   # skaičius, iš kurio traukiama kvadratinė šaknis

n <- 10   # iteracijų skaičius
x <- 1    # pradinė reikšmė

for (i in 1:n) {
  x <- (x + a/x)/2
  print(x)
}

# Galima pastebėti, kad kuo pradinė reikšmė arčiau tikrosios šaknies reikšmės, 
# tuo mažiau iteracijų reikia.
x

# Kvadratinės šaknies traukimui naudojama standartinė funkcija sqrt.
sqrt(a)


# --------------------------------------- #
# VEKTORIAUS ELEMENTŲ IŠRIKIAVIMAS        #
# --------------------------------------- #

# Aprašysime vieną paprastą vektoriaus elementų išrikiavimo algoritmą. Pirmasis
# vektoriaus elementas lyginamas su antruoju, tada su trečiuoju ir taip toliau 
# iki paskutinio. Jei jo reikšmė didesnė, elementų reikšmes sukeičiame vietomis. 
# Tą patį pakartojame pradedant antruoju, trečiuoju ir likusiais elementais iki 
# priešpaskutinio. Kadangi didelę reikšmę turintis elementas "kyla į viršų", šis 
# metodas vadinamas "burbuliuko" metodu.

# Šio algoritmo iteracijų skaičius žinomas, tačiau jis priklauso nuo vektoriaus 
# elementų skaičiaus, kuris iš anksto gali būti nežinomas, todėl jam nustatyti
# naudojame standartinę funkciją length.

v <- c(1, 6, 4, 3, 2, 8, 5, 10, 9, 0, 7)

for (i in 1:(length(v) - 1)) {
  for (j in (i + 1):length(v)) {
    if (v[i] > v[j]) {
      temp <- v[i]
      v[i] <- v[j]
      v[j] <- temp
    }
  }
}

v

# Vektoriaus elementų rikiavimui R turi standartinę funkciją sort.
sort(v)


# --------------------------------------- #
# BENDRAS DIDŽIAUSIAS DALIKLIS            #
# --------------------------------------- #

# Aprašysime Euklido algoritmą dviejų sveikų skaičių a ir b didžiausiam bendram
# dalikliui surasti. Tarkime, a > b > 0. Skaičių a išreiškiame tokiu pavidalu:
#
#   a = bq + r.
#
# Čia q yra sveikasis skaičius, dydis r vadinamas liekana, r < b. Tada dydžiams 
# a ir b priskiriamos naujos reikšmės:
#
#   a := b,
#   b := r.
# 
# Vėl surandama liekana, priskiriamos naujos reikšmės ir veiksmai kartojami tol, 
# kol liekana r nepasidarys lygi nuliui. Paskutinė nelygi nuliui liekana ir yra
# didžiausias bendras daliklis.

a <- 776
b <- 544

# Kadangi iteracijų skaičius iš anksto nežinomas ir priklauso nuo sąlygos, čia 
# naudojame ciklą while. Veiksmus kartojame tol, kol liekana didesnė už nulį.

# Pirmą iteraciją taip pat įkeliame į ciklą, todėl liekanai suteikiame pradinę
# reikšmę.

r <- b

while (r > 0) {
  r <- a %% b
  print(r)
  a <- b
  b <- r
}

# Pirmos iteracijos liekanos reikšmė antroje iteracijoje perduodama dydžiui b, o 
# trečioje -- dydžiui a. Tuo pačiu principu perduodamos visų iteracijų liekanos.
# Ciklo viduje liekanos reikšmė išvedama į konsolę. Kadangi reikšmių priskyrimas 
# atliekamas ciklo pabaigoje, paskutinės nelygios nuliui liekanos reikšmę įgyja 
# dydis a. 
a


# --------------------------------------- #
# ATSITIKTINIŲ DYDŽIŲ GENERAVIMAS         #
# --------------------------------------- #

# Čia aprašysime pseudoatsitiktinių dydžių generavimo algoritmą, kuris vadinamas
# tiesiniu kongruentiniu generatoriumi. Pagal šį algoritmą atsitiktiniai dydžiai
# generuojami iteraciniu būdu:
# 
#   X := a*X + c mod m, kur
#
#   daugiklis a >= 0,
#  prieauglis c >= 0,
#     modulis m > a, m > c.

# Parametras m dažniausiai yra didelis pirminis skaičius. Istoriškai pirmas buvo
# naudojamas toks parametrų rinkinys:

a <- 7^5
c <- 0
m <- 2^31 - 1


# Nustatome atsitiktinių dydžių sekos ilgį, kuris sutampa su iteracijų skaičiumi.
n <- 100

# Sukuriame tuščią vektorių, kurio elementams priskirsime atsitiktines reikšmes.
X <- vector(length = n)

# Visi pseudoatsitiktinių dydžių generatoriai turi pradinę sekos reikšmę, seed.
# Su ta pačia seed reikšme visada gaunama ta pati dydžių seka.

seed <- 1234
X[1] <- seed

for (i in 2:n) {
  X[i] <- (a*X[i-1] + c) %% m
}

# Vektoriaus elementus padalinus iš m, gaunamas dydis, kurio reikšmės tolygiai
# pasiskirsčiusios intervale (0, 1]. 
X <- round(X/m, 9)
X

# Tokio dydžio generavimui naudojama standartinė funkcija runif.
runif(100)


# UŽDUOTIS ------------------------------ 

# 1. Pataisykite Newton-Raphson algoritmo pavyzdį taip, kad skaičiavimai būtų 
#    nutraukiami, kai skirtumas tarp dviejų paskutinių šaknies aproksimacijų yra 
#    mažesnis už tam tikrą iš anksto nustatytą dydį epsilon. Vietoje ciklo for 
#    panaudokite ciklą while.
