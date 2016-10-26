
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Duomenų lentelės sudarymas ir jos kintamieji.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2012-09-03 | 2013-05-06
#


# TURINYS -------------------------------

# 
#   1. Duomenų lentelės sudarymas:
#      * komanda data.frame
#      * komanda class
#      * komanda nrow ir ncol
#      * komanda names
#      * komanda row.names
#      * komanda attributes
#      * komanda str
#      * operatorius [
#      * operatorius [[
#      * operatorius &
#
#   2. Duomenų lentelių apjungimas:
#      * kintamųjų prijungimas
#      * kintamųjų panaikinimas
#      * komanda cbind
#      * komanda rbind 
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
# DUOMENŲ LENTELĖS SUDARYMAS              #
# --------------------------------------- #

# Pats bendriausias R duomenų tipas yra data.frame -- duomenų lentelė, kurios 
# stulpeliuose yra kintamieji, o eilutėse stebiniai. Esminis duomenų lentelės 
# skirtumas nuo matricos yra tas, kad duomenų lentelės stulpeliai gali būti ir 
# skirtingų tipų. 


# Sudarysime duomenų lentelę, kurios stulpeliuose bus trys skirtingo tipo 
# vektoriai: numeric, logical ir character.

x <- c(22, 37, 68, 47, 92, 87, 39, 19, 97, 32)
y <- c(FALSE, TRUE, TRUE, FALSE, FALSE, FALSE, TRUE, TRUE, FALSE, FALSE)
z <- c("P", "P",  "P",  "T",  "T",  "T",  "A",  "A",  "A",  "A")

# Kaip ir sudarant vektorius arba sąrašus, elementams galima suteikti vardus.
# Duomenų lentelės elementai yra stulpeliuose esantys kintamieji - vektoriai.
# Jei kintamųjų vardai nenurodomi, tai stulpeliai turės vektorių pavadinimus.

d <- data.frame(X = x, Y = y, Z = z)
d

# Galima pastebėti, kad character tipo vektoriaus z reikšmės duomenų lentelėje
# vaizduojamos be kabučių. Taip yra todėl, kad character tipo kategoriniai 
# kintamieji automatiškai pavirsta į specialaus tipo factor kintamuosius.

# Taip sudaryta lentelė yra data.frame klasės duomenų struktūra.
class(d)

# Lentelės eilučių ir stulpelių skaičiui rasti naudojamos funkcijos nrow ir ncol.
nrow(d)
ncol(d)

# Duomenų lentelės kintamųjų vardus parodo funkcija names. 
names(d)

# Funkcija names naudojama ir kintamųjų vardų pakeitimui.
names(d) <- c("X", "Testas", "Tipas")
names(d)
d

# Duomenų lentelės eilučių vardus parodo funkcija row.names. Pagal nutylėjimą 
# eilutės sunumeruojamos.
row.names(d)

# Lentelės eilučių vardus galima pakeisti, tačiau visi jie turi būti skirtingi.
row.names(d) <- letters[1:10]
d

# Pati paprasčiausia duomenų lentelė turi keletą pagrindinių atributų: tai yra 
# kintamųjų vardai, eilučių pavadinimai ir nurodyta pačios lentelės klasė.
attributes(d)

# Duomenų lentelės atributus galima pakeisti. Pvz., grąžinsime eilučių numerius.
attr(d, "row.names") <- 1:10
d

# Kaip ir bet kokio kito objekto, lentelės struktūrą galima pamatyti naudojant 
# funkciją str. Čia matome, kad kintamasis d yra data.frame tipo 10*3 dydžio
# lentelė, kurios kintamieji yra numeric, logical ir factor tipo vektoriai.
# Be to, faktorius turi tris kategorijas.
str(d)


# NAUDINGA ------------------------------

# Kai kurios duomenų lentelėms ir matricoms naudojamos funkcijos yra specifinės:
# vienos iš jų tinka lentelėms, bet netaikomos matricoms ir atvirkščiai. Gali 
# būti, kad tam tikrais atvejais funkcijos rezultatas gali turėti kitokią prasmę.

# Funkcija length apskaičiuoja vektorių, matricų ir sąrašų elementų skaičių. Jei
# funkcijos length argumentas bus duomenų lentelė, rezultatas bus jos stulpelių
# skaičius. Tai galima paaiškinti tuo, kad duomenų lentelės elementai yra jos
# kintamieji, t.y. stulpeliai.

length(d)

# Funkcija dim naudojama matricos eilučių ir stulpelių skaičiui nustatyti. Jei 
# šios funkcijos argumentas yra duomenų lentelė, tai rezultatas taip pat yra 
# vektorius, kurio pirmas elementas reiškia eilučių, o antras -- stulpelių skaičių. 
# Tačiau duomenų lentelių atveju eilučių skaičius gaunamas kaip eilučių vardų 
# vektoriaus elementų skaičius, o stulpelių skaičius -- kaip duomenų lentelės 
# kintamųjų skaičius.

# Taip rašoma:
dim(d)

# O taip skaičiuojama :)
c(length(attributes(d)$row.names), length(d))


# Funkcijos rownames ir colnames naudojamos matricų eilučių ir stulpelių vardams.
# Funkcija names nenaudojama matricos stulpelių vardams.

#                   matrica     lentelė
# 
#   eilučių vardai  rownames    row.names
# stulpelių vardai  colnames    names
#       abu vardai  dimnames    dimnames


# UŽDUOTIS ------------------------------ 

# 1. Sukurkite duomenų lentelę h, kurioje pirmas stulpelis būtų vardas ir pavardė, 
#    antras -- lytis (galima koduoti vyras-moteris, 0-1, V-M ir pan.), o trečias
#    stulpelis koks nors kiekybinis kintamasis, pvz., amžius, atlyginimas, ūgis.
# 2. Naudodami funkciją names pakeiskite duomenų lentelės kintamųjų vardus.
# 3. Naudodami funkciją row.names pakeiskite sukurtos duomenų lentelės eilučių 
#    numerius į raides.


# Kintamųjų išskyrimo operatoriai [ ir [[ duomenų lentelėse naudojami dvejopai: 
# kaip matricose ir kaip sąrašuose.

# Operatorių [ naudojant kaip matricoje, bet kuris lentelės elementas pasiekiamas 
# nurodant eilutės ir stulpelio numerį.
d[1, 1]

# Nenurodžius eilutės indekso, bus išskiriamos visos duomenų lentelės eilutės.
# Pvz., išskirsime visas pirmo stulpelio eilutes.
d[, 1]

# Nenurodžius stulpelio indekso, bus išskiriami visi duomenų lentelės stulpeliai.
# Pvz., išskirsime visus pirmos eilutės stulpelius.
d[1, ]

# Indeksą nurodžius su minuso ženklu, atitinkama eilutė arba stulpelis išmetami.
# Pvz., čia lentelėje bus paliekami visi stulpeliai išskyrus pirmąjį.
d[, -1]

# Kaip ir matricoms, galima nurodyti lentelės eilučių ir stulpelių indeksų aibę.
# Pvz., iš lentelės d išskirsime pirmas dvi eilutes ir paskutinius du stulpelius.

i <- c(1, 2)
j <- c(2, 3)
d[i, j]

# Kartais tokią konstrukciją galima parašyti ir trumpiau.
d[1:2, 2:3]


# Dažnai duomenų lentelės kintamuosius patogiau išskirti nurodant jų vardus.
d[, "X"] 

# Duomenų lentelės eilutes taip pat galima identifikuoti pagal jų vardus. Reikia 
# turėti omeny, kad pagal nutylėjimą eilutės yra numeruojamos, tačiau jų numeriai
# yra character tipo, todėl juos reikia nurodyti kabutėse!
d["1", ]


# Operatorių [ galima naudoti į duomenų lentelę žiūrint kaip į vektorių ar sąrašą.
# Tokiu atveju lentelės elementai yra jos kintamieji, t.y. stulpeliai. Nurodžius 
# vieno lentelės elemento numerį, gausime taip pat lentelę tik su vienu stulpeliu.
d[1]

# Nurodžius neigiamą indeksą, atitinkamą numerį turintis kintamasis-stulpelis 
# nebus pasirenkamas.
d[-1]

# Nurodžius kintamųjų indeksų aibę, galima išskirti ir keletą kintamųjų.
d[1:2]

# Operatorių [[ naudojant išskirtas lentelės elementas -- kintamasis turės savo 
# pradinį tipą ir struktūrą, t.y. gausime paprastą vektorių.
d[[1]]

# Vietoje duomenų lentelės kintamojo numerio galima naudoti jo vardą.

d["X"]       # pirmu būdu gauname duomenų lentelę su vienu stulpeliu 
d[["X"]]     # antru būdu gaunamas vektorius su lentelės kintamojo reikšmėmis

# Galima patikrinti dviem skirtingais būdais gautų duomenų lentelės elementų tipą.
a <- d["X"]
b <- d[["X"]]

class(a)   
class(b)   


# Vieną duomenų lentelės kintamąjį galima išskirti naudojant operatorių $. Čia
# kintamojo vardas dažniausiai rašomas be kabučių. Matricoms toks būdas netinka!

d$X
d$Testas


# UŽDUOTIS ------------------------------ 

# 1. Keliais skirtingais būdais išskirkite iš lentelės d antrąjį stulpelį. Reikia 
#    panaudoti stulpelio numerį, jo vardą, operatorius [, [[ ir $.
# 2. Iš lentelės d sukurkite naują lentelę, kurioje neliktų dviejų paskutinių 
#    eilučių. Kaip tai padaryti naudojant ne eilučių numerius, o jų vardus?
# 3. Naudojant kintamųjų numerius sukeiskite vietomis pirmus du lentelės d 
#    stulpelius. Tą patį veiksmą atlikite naudojant kintamųjų vardus.
# 4. Sukurkite tokį indeksą, kurį naudojant iš lentelės d būtų išskiriamos eilutės 
#    su nelyginiais numeriais.
# 5. Sukurkite tokį indeksą, kurį naudojant iš lentelės d būtų galima išskirti 
#    eilutes, kuriose kintamasis Testas įgyją reikšmę TRUE.


# --------------------------------------- #
# DUOMENŲ LENTELIŲ APJUNGIMAS             #
# --------------------------------------- #

# Gana dažnai pasitaiko situacija, kai prie jau sukurtos duomenų lentelės reikia 
# prijungti naują kintamąjį. Tam yra keletas būdų. Naudojant operatorių [ galima 
# nurodyti stulpelio, kuriame bus naujas kintamasis, numerį arba nurodyti jo vardą.

# Duomenų lentelėje d sukursime naują stulpelį, jam priskirsime reikšmių vektorių 
# ir taip gausime naują lentelės kintamąjį. Jo vardas parenkamas pagal nutylėjimą.

d[4] <- rep(1:2, each = 5)
d

# Dažnu atveju paprasčiau iš karto nurodyti naujo kintamojo vardą. Stulpelis su 
# naujo kintamojo reikšmėmis prie lentelės bus prijungtas iš dešinės. Pvz., 
# lentelėje sukursime naują kintamąjį "N" ir jam priskirsime tam tikrą reikšmių 
# vektorių.
 
d["N"] <- 1:10
d

# Į lentelę žiūrint kaip į matricą, naują kintamąjį, kaip ir anksčiau, sukuriame 
# nurodydami atitinkamo stulpelio numerį arba stulpelio vardą, o eilučių indeksą 
# praleidžiame.

d[, "M"] <- 1
d

# Nurodant kintamųjų vardų vektorių, galima sukurti iš karto keletą naujų lentelės 
# kintamųjų. Pvz., čia jiems visiems priskiriamas praleistų reikšmių vektorius.

d[c("A", "B", "C")] <- NA
d

# Naudojant operatorių $ naujas kintamasis sukuriamas nurodant jo vardą ir 
# priskiriant jam reikšmių vektorių.

d$Kodas <- letters[1:10]
d

# Panaikinti duomenų lentelės kintamąjį taip pat yra keletas būdų. Galima sukurti 
# naują lentelę, kurioje nebūtų nereikalingo kintamojo, tačiau dauguma atvejų 
# paprasčiau kintamajam priskirti tuščią objektą NULL. Kintamąjį nurodyti galima 
# keliais skirtingais būdais.

d[4]     <- NULL     # naudojame operatorių [, nurodome kintamojo numerį
d["N"]   <- NULL     # naudojame operatorių [, nurodome kintamojo vardą
d[, "M"] <- NULL     # naudojame operatorių [, nurodome stulpelio vardą
d$Kodas  <- NULL     # naudojame operatorių $, nurodome kintamojo vardą

d

# Tuo atveju, kai reikia panaikinti keletą kintamųjų iš karto, jiems reikia 
# priskirti sąraša iš NULL objektų.

d[c("A", "B", "C")] <- list(NULL)
d


# UŽDUOTIS ------------------------------ 

# 1. Naudodami operatorių [ anksčiau sudarytoje lentelėje h sukurkite naują 
#    kintamąjį N, kurio visos reikšmės būtų lygios nuliui.
# 2. Naudodami operatorių $ lentelėje h sukurkite kintamąjį X, kurio visos 
#    reikšmės praleistos. Nekuriant iš naujo kintamojo X, paskutinę jo reikšmę 
#    pakeiskite iš NA į 100.
# 3. Lentelėje h panaikinkite tokius du kintamuosius, kurie vardų sąraše yra 
#    paskutiniai.


# Panašiai kaip ir matricas, naudojant funkciją cbind, vieną lentelę galima 
# prijungti prie kitos lentelės šono. Tokiu atveju abiejų lentelių eilučių 
# skaičius turi būti vienodas!

a <- data.frame(A = 10:15, B = TRUE)
b <- data.frame(A = 6:1, B = FALSE)
a
b

m <- cbind(a, b)
m

# Kintamųjų vardai gali būti nebūtinai skirtingi, tačiau tokiu atveju kintamąjį 
# pasirenkant pagal vardą, bus išrenkamas pirmasis iš pasikartojantį vardą 
# turinčių kintamųjų -- nepageidaujama situacija!

names(m)

m$A
m$A <- NULL
m

# Naudojant funkciją cbind, prie lentelės kaip naują kintamąjį galima prijungti 
# ir vektorių. Pvz., taip sukursime naują lentelės d kintamąjį I, kurio visos 
# reikšmės bus lygios 1. Kadangi prijungiamas vektorius yra trumpesnis, jo 
# reikšmės pakartojamos.

d <- cbind(d, I = 1)
d

# Naudojant funkciją rbind, duomenų lentelės apjungiamos sudedant jas vieną ant 
# kitos. Šiuo atveju būtina, kad kintamųjų vardai abiejose lentelėse sutaptų, 
# tačiau eilučių skaičius gali būti bet koks.

m <- rbind(a, b)
m


# UŽDUOTIS ------------------------------ 

# 1. Naudodami funkciją cbind anksčiau sudarytoje lentelėje h sukurkite naują 
#    kintamąjį N, kurio visos reikšmės būtų lygios nuliui.
# 2. Sukurkite tokius pačius kintamuosius turinčią lentelę k, kuri turėtų tik 
#    vieną eilutę, ir prijunkite ją prie lentelės h apačios.
