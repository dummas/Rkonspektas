
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Ciklai ir jų nutraukimo komandos.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2013-08-22 | 2013-08-25
#


# TURINYS -------------------------------

#
#   1. Ciklų for ir while konstrukcijos:
#      * komanda for
#      * komanda while
#
#   2. Ciklo nutraukimo komandos:  
#      * komanda repeat
#      * komanda next
#      * komanda break
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
# CIKLAS FOR                              #
# --------------------------------------- #

# Programavimo kalbose ciklai naudojami tokiuose algoritmuose, kur atliekami tam 
# tikri pasikartojantys veiksmai. Jų skaičius gali būti iš anksto žinomas arba 
# keistis priklausomai nuo ciklo metu tikrinamų sąlygų.

# Ciklas for naudojamas tais atvejais, kai iteracijų skaičius iš anksto žinomas.
# Duomenų analizėje tai gali būti vektoriaus elementų kiekis, matricos stulpelių
# arba eilučių skaičius, sąrašo įrašų skaičius, nuskaitomų duomenų failų kiekis, 
# modeliuojamų procesų skaičius ir t.t. 

# Bendra ciklo for konstrukcija atrodo taip:
# 
#    for (var in set) {
#       išraiškos
#    }
# 
# Kintamasis var įgyja reikšmes iš indeksų aibės set. Ši aibė gali būti sudaryta
# iš bet kokia tvarka surašytų vektoriaus elementų numerių, matricos eilučių ar 
# stulpelių numerių, taip pat vardų, kodų ar kitų kintamųjų, kurių reikšmes turi
# įgyti ciklo kintamasis var.

# Iš eilės einančių indeksų aibę paprasčiausia nurodyti naudojant : operatorių. 
# Kai vektoriaus ar sąrašo elementų skaičius iš anksto nežinomas, jam nustatyti 
# galima naudoti funkciją length.

# Pavyzdžiui, naudodami ciklą for, apskaičiuosime visų vektoriaus elementų sumą.

v <- c(19, 5, 2, 19, 29, 42, 32, 35, 25, 18, 6, 22, 7, 28, 11, 8, 9, 37, 45, 23)

suma <- 0

for (i in 1:length(v)) {
  suma <- suma + v[i]
}

suma

# Kadangi ciklo kintamasis turi perbėgti per visų vektoriaus elementų indeksus, 
# o ciklo viduje naudojamos vektoriaus elementų reikšmės, vietoje indeksų aibės 
# galima nurodyti patį vektorių. Tada sumavimo algoritmas užrašomas paprasčiau.

suma <- 0

for (i in v) {
  suma <- suma + i
}

suma

# Paprastai vektoriaus elementų sumavimui naudojama standartinė funkcija sum.
sum(v)


# Iš eilės einančių vektoriaus arba sąrašo elementų indeksų aibę galima sudaryti 
# ir naudojant funkciją seq_along.

# Pavyzdžiui, apskaičiuosime tam tikrą ribą viršijančių vektoriaus elementų sumą
# ir tokių elementų skaičių.

riba <- 30
suma <- 0
kiek <- 0

for (i in seq_along(v)) {
  if (v[i] > riba) {
    suma <- suma + v[i] 
    kiek <- kiek + 1
  }
}

suma
kiek

# Taip ši užduotis turėtų būti atlikta pagal R programavimo ideologiją.
sum(v[v > riba])
sum(v > riba)


# Indeksų aibė nebūtinai turi apimti visus vektoriaus elementus, be to, indeksai
# gali būti surašyti bet kokia tvarka, jie gali kartotis ir t.t.

# Pavyzdžiui, sudarysime nelyginių vektoriaus elementų indeksų aibę ir išvesime
# juos į konsolę.

nelyginiai <- seq(1, length(v), by = 2)

for (i in nelyginiai) {
  cat("Elemento", i, "reikšmė:\n")
  print(v[i])
}

# Taip ši užduotis turėtų būti atlikta pagal R programavimo ideologiją.
v[nelyginiai]


# Indeksų aibė gali būti sudaryta ir ne iš skaičių. Ją gali sudaryti bet kokie
# kiti objektai. Pavyzdžiui, sudarysime aibę iš raidžių ir patikrinsime, koks jų
# numeris lotyniškoje abėcėlėje.

žodis <- c("L", "I", "E", "T", "U", "V", "A")

for (raidė in žodis) {
  numeris <- which(raidė == LETTERS)
  cat(raidė, numeris, "\n")
}


# Ciklus galima įdėti vieną į kitą. Paprastai taip daroma atliekant veiksmus su 
# matricomis. Pavyzdžiui, sukursime 4x5 dydžio nulinę matricą ir jos elementams 
# priskirsime tų elementų eilutės ir stulpelio numerių sumą.

m <- matrix(0, nrow = 4, ncol = 5)

# Matricos eilučių ir stulpelių skaičius nustatomas naudojant funkcijas nrow ir 
# ncol.

for (i in 1:nrow(m)) {
  for (j in 1:ncol(m)) {
    m[i, j] <- i + j
  }
}

m


# NAUDINGA ------------------------------

# Atliekant ilgai trunkančius skaičiavimus, į konsolę naudinga išvesti papildomą 
# informaciją apie skaičiavimų progresą: tarpinių kintamųjų reikšmes, iteracijos 
# numerį ar laiką.

# Pavyzdžiui, į ciklą for įdėsime informaciją apie iteracijos numerį ir suminį
# algoritmo veikimo laiką. Šis laikas gaunamas kaip skirtumas tarp dviejų laiko 
# momentų: vienas užfiksuojamas prieš ciklą, kitas - kiekvienos iteracijos metu. 
# Tam naudojama funkcija proc.time.

# Informacija į konsolę išvedama kiekvienos iteracijos metu, tačiau pati konsolė
# atnaujinama tik išėjus iš ciklo. Konsolės atnaujinimui naudojama funkcija
# flush.console.

# Vietoje ilgai trunkančių skaičiavimų čia cikle įdėta funkcija Sys.sleep, kuri 
# nustatytam laiko intervalui sustabdo bet kokius skaičiavimus. Šiuo atveju tai
# vienos sekundės pauzė.

start.time <- proc.time()
n <- 10

for (i in 1:n) {

  # Išvedame informaciją apie iteracijos numerį ir bendrą laiką.
  info.index <- formatC(i, digits = 0, width = 2, format = "f", flag = "0")
  info.time  <- proc.time()[3] - start.time[3]
  cat("Iteracija", info.index, "iš", n, " .†. ", info.time, "\n")
  flush.console()

  Sys.sleep(1)
}


# UŽDUOTIS ------------------------------ 

# 1. Tarkim, kad vektoriaus elementų reikšmės gautos vienodais laiko intervalais
#    matuojant tam tikrą kintantį dydį. Toks vektorius vadinamas laiko eilute. 
#    Statistikoje dažnai taikomas laiko eilutės glodinimas slenkančiu vidurkiu.
#    Sudarykite vektorių, kurio pirmojo elemento reikšmė būtų lygi vektoriaus v
#    1, 2 ir 3 elementų vidurkiui, antro elemento reikšmė -- 2, 3, ir 4 elementų 
#    vidurkiui ir taip toliau iki galo. 
# 2. Užrašykite algoritmą, kuris surastų didžiausia reikšmę turintį vektoriaus v
#    elementą ir nustatytų jo eilės numerį.
# 3. Naudodami ciklą for, sudarykite vektorių, kurio elementai lygūs matricos m
#    eilučių sumoms.
# 4. Naudodami ciklą for, užrašykite algoritmą natūrinio skaičiaus n faktorialui
#    apskaičiuoti.


# --------------------------------------- #
# CIKLAS WHILE                            #
# --------------------------------------- #

# Ciklas while naudojamas tada, kai tam tikrus pasikartojančius veiksmus reikia
# kartoti tol, kol tenkinama tam tikra sąlyga. Bendra ciklo while konstrukcija 
# atrodo taip:
# 
#    while (loginė sąlyga) {
#       išraiškos
#    }

# Sąlyga turi būti tokia, kad ciklas netaptų amžinas. Tai reiškia, kad tam tikru 
# momentu loginės sąlygos reikšmė būtinai turi tapti FALSE.

# Pavyzdžiui, užrašysime algoritmą skaičiaus n faktorialui apskaičiuoti.

n <- 5
faktorialas <- 1
 
while (n > 0) {
  faktorialas <- faktorialas * n
  n <- n - 1
}
 
faktorialas

# Paprastai faktorialų skaičiavimui naudojama standartinė funkcija factorial.
factorial(5)


# Ciklą while kartais galima naudoti ir tokiose situacijoje, kur tinka ir ciklas
# for. Pavyzdžiui, patikrinsime, ar simbolių seka vienodai skaitoma iš abiejų 
# pusių. Tokia skaičių arba simbolių seka vadinama palindromu.

s <- c("S", "Ė", "D", "Ė", "K", "U", "Ž", "U", "K", "Ė", "D", "Ė", "S")

# Loginiam kintamajam palindromas iš karto priskiriama reikšmė TRUE. Tada pirmą
# elementą lyginame su paskutiniu, antrą su priešpaskutiniu iš taip toliau iki 
# vektoriaus vidurio. Jei nors viena pora nesutampa, tai kintamajam palindromas
# priskiriama reikšmė FALSE.

i <- 0
k <- length(s)

palindromas <- TRUE

while (i < k/2) {
  i <- i + 1
  cat("Raidžių pora:", s[i], s[k-i+1], "\n")
  if (s[i] != s[k-i+1]) palindromas <- FALSE
}

palindromas


# UŽDUOTIS ------------------------------ 

# 1. Naudodami ciklą while, apskaičiuokite, kiek iš eilės einančių vektoriaus v 
#    elementų reikia susumuoti, norint gauti didžiausią sumą neviršijančią 100.
#    Loginę sąlygą reikia užrašyti taip, kad susumavus visus elementus, bet sumai 
#    neviršijus 100, ciklas būtų nutraukiamas.
# 2. Naudodami ciklą while, užrašykite vektoriaus elementų išrikiavimo priešinga
#    tvarka algoritmą.


# --------------------------------------- #
# CIKLAS REPEAT IR JO NUTRAUKIMAS         #
# --------------------------------------- #

# Ciklas repeat labai panašus į ciklą while, tačiau ciklo nutraukimo sąlyga 
# tikrinama ciklo viduje: 
# 
#    repeat {
#       išraiškos
#       if (loginė sąlyga) break
#    }

# Pavyzdžiui, užrašysime algoritmą, kuris skaičiavimus nutraukia po tam tikro 
# laiko tarpo. Šiuo atveju tai bus 1 sekundė. Į konsolę bus išvedamas iteracijos 
# numeris.

start.time <- proc.time()
i <- 0

repeat {
  i <- i + 1
  cat(i, "\n")
  flush.console()

  laikas <- proc.time()[3] - start.time[3]
  if (laikas > 1) break
}


# Kartais ciklą reikia nutraukti dėl skaičiavimų metu susidariusių sąlygų. Tai
# gali būti praleista ar neapibrėžta reikšmė duomenyse, mažas stebinių skaičius
# ar kitokia nekorektiška situacija. Bet kokio tipo ciklui nutraukti naudojamos 
# dvi komandos: 
#
#     next -- nutraukia iteraciją ir pereina prie sekančios,
#    break -- nutraukia ciklą ir išeina iš jo.

# Pavyzdžiui, naudojant ciklą for, susumuosime tik nelygines reikšmes turinčius 
# vektoriaus v elementus. Jei elemento reikšmė lyginė, tai sumavimo veiksmas
# praleidžiamas ir pereinama prie sekančio elemento.

suma <- 0

for (i in v) {
  if (i %% 2 == 0) next
  suma <- suma + i
  cat("Elemento reikšmė:", i, "\n")
}

suma

# Sumavimo išraišką galima įdėti į if-else konstrukciją ir užrašyti kiek kitaip.
suma <- 0

for (i in v) {
  if (i %% 2 == 1) suma <- suma + i else next
}

suma

# Taip ši užduotis turėtų būti atlikta pagal R programavimo ideologiją.
sum(v[v %% 2 == 1])


# Nors ciklui for nurodomas fiksuotas iteracijų skaičius, bet esant tam tikroms
# sąlygoms ciklą galima nutraukti anksčiau. Pavyzdžiui, nutrauksime ciklą, jei
# trijų iš eilės vektoriaus v elementų reikšmės viršija 30.

# Ciklo viduje į atskirą vektorių išskiriame tris iš eilės einančius elementus,
# pažymėkime jų indeksus atitinkamai j - 2, j - 1 ir j. Kadangi pilnas trejetas 
# susidaro tik nuo trečiojo elemento, tai pirmasis indeksas j - 2 iki tol įgyją 
# reikšmę -1 arba 0, ir vektoriaus elementų su tokiais indeksais nėra. Dėl to 
# įvedamas tarpinis kintamasis i = j - 2, kurio reikšmė lygi 1, jei j - 2 < 1.

riba <- 30

for (j in seq_along(v)) {
  i <- max(1, j - 2)
  t <- v[i:j]
  cat("Numeris:", j, "\n")
  cat(t, "\n")

  if (all(t > riba)) {
    cat("Trys iš eilės reikšmės didesnės už ", riba, "! ", sep = "")
    cat("Skaičiavimai nutraukiami.\n", sep = "")
    break  
  }
}


# UŽDUOTIS ------------------------------ 

# 1. Užrašykite vektoriaus elementų sumavimo ciklą for, kuris nutraukiamas, jei 
#    vektoriaus elemento reikšmė yra NA. Išeinant iš ciklo, į konsolę išvedamas
#    pranešimas, kad ciklas nutraukiamas dėl praleistos reikšmės duomenyse.
# 2. Naudodami ciklą for, apskaičiuokite didesnių nei 30 vektoriaus v elementų
#    sumą ir šių elementų skaičių. Netenkinančių šios sąlygos elementų sumavimą
#    praleiskite naudojant komandą next.
