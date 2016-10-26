
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Funkcijos reikšmės skaičiavimas duomenų grupėse.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2013-09-07 | 2013-09-10
#


# TURINYS -------------------------------

#
#   1. Funkcijos skaičiavimas pagal vektoriaus elementų grupes:
#      * funkcija tapply
#      * funkcija split
#
#   2. Funkcijos skaičiavimas duomenų lentelės grupėse:
#      * funkcija by
#      * funkcija aggregate 
#


# PASTABOS ------------------------------

#
# Pastabų dar nėra.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuviška lokalė. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# Ištrinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# FUNKCIJA TAPPLY                         #
# --------------------------------------- #

# Atliekant duomenų analizę, tam tikras skaitines charakteristikas kartais tenka
# skaičiuoti ne visam duomenų rinkiniui, bet atskiroms duomenų grupėms. Tai gali
# būti atlyginimų vidurkis vyrams ir moterims arba pokalbių telefonu laiko sumos
# kiekvienam mėnesiui atskirai, kai žinomos kiekvienos dienos pokalbių trukmės.

# Tuo atveju, kai tą pačią funkciją reikia pritaikyti keliems vieno vektoriaus 
# pogrupiams, naudojama funkcija tapply. Jos parametrai:
# 
#        X -- duomenų vektorius,
#    INDEX -- duomenis grupuojantis vektorius,
#      FUN -- funkcijos pavadinimas arba jos išraiška,
# simplify -- jei TRUE, rezultatas grąžinamas kaip vektorius.

# Parametrui INDEX priskiriamas vektorius turi turėti tiek pat elementų, kiek ir
# duomenų vektorius X. Paprastai tai yra kelias diskrečias reikšmes turintis 
# kategorinis kintamasis, kuris kiekvieną duomenų vektoriaus elementą priskiria 
# tam tikrai grupei.

x <- c(962, 826, 798, 600, 834, 532, 407, 484, 856, 667, 417, 541, 103, 904, 523)
g <- c("B", "B", "A", "A", "B", "B", "B", "A", "B", "B", "B", "A", "A", "A", "B")

# Pvz., apskaičiuosime vektoriaus x vidurkį grupėse pagal vektoriaus g elementų 
# reikšmes. Rezultatas yra sąlyginis x vidurkis atskirai grupėje A ir grupėje B.

tapply(x, g, mean)

# Kintamojo grupavimas gali būti atliekamas iš karto pagal kelis požymius. Tokiu
# atveju parametrui INDEX nurodomas grupavimo kintamųjų list tipo sąrašas.

# Tarkime, kad pirmieji 8 kintamojo x stebinių yra iš grupės I, likę 7 iš gr. II.
# Sukursime tokias reikšmes turintį kintamajį. 

p <- rep(c("I", "II"), c(8, 7))

# Apskaičiuosime vidurkius pagal kintamuosius p ir g. Rezultatas yra sąlyginiai
# vidurkiai grupėse I-A, I-B, II-A ir II-B.

tapply(x, list(p, g), mean)

# Įstačius funkciją length, galima sužinoti, kiek vektoriaus x elementų patenka
# į kiekvieną iš grupių I-A, I-B, II-A ir II-B.

tapply(x, list(p, g), length)

# Į tapply įstatomos funkcijos gali turėti savo parametrus. Pavyzdžiui, vidurkio
# skaičiavimui naudojama funkcija mean ir daugelis kitų funkcijų turi parametrą 
# na.rm, kuriam priskyrus reikšmę TRUE, praleistos duomenų reikšmės ignoruojamos.

# Apskaičiuosime vektoriaus y, kuris turi praleistų reikšmių, elementų vidurkį 
# grupėse pagal kintamajį g.

y <- c(962, NA, 798, 600, 834, 532, 407, 484, NA, 667, 417, 541, NA, 904, 523)

tapply(y, g, mean, na.rm = TRUE)


# Į funkciją tapply galima įrašyti standartinės funkcijos vardą arba, jei tokios
# funkcijos nėra, užrašyti reikalingos funkcijos išraišką. Pvz., apskaičiuosime
# skirtumą tarp didžiausios ir mažiausios vektoriaus x reikšmės grupėse. Pirmąjį
# funkcijos variantą užrašysime naudojant tradicines funkcijas min ir max.

tapply(x, g, function(v) max(v) - min(v))

# Tokį pat rezultatą galima gauti sudarant mažiausios ir didžiausios vektoriaus
# reikšmės radimo ir gretimų vektoriaus elementų skirtumo funkcijų superpoziciją.
# Toks funkcijos užrašymo būdas atitinka funkcinio programavimo su R stilių.

tapply(x, g, function(v) diff(range(v)))


# Naudojant funkciją tapply, galima ne tik skaičiuoti sąlygines charakteristikas,
# bet ir atlikti gana sudėtingus veiksmus skirtingose duomenų grupėse. Pvz., tai 
# gali būti tos pačios statistinės hipotezės tikrinimas grupėse, panašių grafikų 
# naudojant duomenis iš skirtingų grupių braižymas ir pan. Priklausomai nuo to, 
# kokie veiksmai grupėse atliekami, rezultatas kartais gali būti gana sudėtingas
# objektas: sąrašas, dažnių lentelė, grafikai ir t.t.

# Pavyzdžiui, sudarysime kintamojo p reikšmių dažnių lentelę A ir B grupėse.

tapply(p, g, table)


# Nors funkcijos tapply argumentai X ir INDEX yra vektoriai, tačiau ši funkcija
# dažnai pritaikoma duomenų lentelės vieno kintamojo charakteristikų skačiavimui
# grupėse pagal kito kintamojo reikšmes.

d <- read.table(header = TRUE, text = "
   lytis  ūgis svoris grupė
  vyras   175     76     B
  vyras   180     NA     B
moteris   170     67     A
moteris   167     64     B
  vyras   178     80     A
moteris   172     59    NA
  vyras   184     NA     A
moteris   171     68     B
moteris   177     70     A
  vyras   185     84     B
")

# Pavyzdžiui, apskaičiuosime duomenų lentelėje d užrašyto ūgio vidurkį atskirai 
# vyrams ir moterims. Funkcijai perduodame į atskirus vektorius išskirtus lyties 
# ir ūgio kintamuosius. Tai galima atlikti keliais skirtingais būdais.

tapply(d[, 2], d[, 1], mean)

tapply(d[, "ūgis"], d[, "lytis"], mean)

tapply(d$ūgis, d$lytis, mean)


# Jei funkcijai perduodamas lentelės kintamojo vardas labai ilgas, kartais visa
# funkcija įkeliama į with konstrukciją, kur nurodome, iš kokios aplinkos imami
# kintamųjų vardai. Šiuo atveju kaip aplinką nurodome duomenų lentelės vardą, o 
# funkcijai perduodame tos lentelės kintamųjų vardus. Kai lentelės vardas labai
# ilgas, toks užrašymo būdas gaunasi gerokai aiškesnis ir trumpesnis.

with(data = d, tapply(ūgis, lytis, mean))


# NAUDINGA ------------------------------

# Funkcija tapply duomenų vektorių suskaido į kelias grupes ir kiekvienai iš jų 
# pritaiko tą pačią funkciją. Tuo pačiu ją galima panaudoti duomenų sudalijimui 
# į atskiras dalis pagal kažkokį grupuojantį kintamąjį.

# Nenurodžius parametro FUN, tapply rezultatas yra duomenų vektoriaus X elementų
# pogrupių, į kuriuos jie patenka, numerių vektorius.

tapply(x, g)

# Parametrui FUN nurodžius išskyrimo operatorių [, duomenų vektorius suskaidomas
# ir sudaromas tokių atskirtų grupių sąrašas.

tapply(x, g, "[")

# Paprastai tokiam duomenų išskyrimui į atskiras dalis pagal kažkokį grupuojantį
# kintamąjį naudojama speciali funkcija split.

split(x, g)

# Kadangi funkcijos split rezultatas yra sąrašas, veiksmams su sąrašo elementais
# atlikti naudojamos funkcijos sapply ir lapply. Pvz., apskaičiuosime vektoriaus
# x vidurkius grupėse pagal kintamąjį g.

sapply(split(x, g), mean)


# Toks vektoriaus suskaidymas į grupes gali būti atliekamas ne tik skaičiuojant 
# sąlygines charakteristikas, bet ir pertvarkant duomenis. Pavyzdžiu, naudojant
# išskyrimo operatorių, iš kiekvienos vektoriaus x grupės išskirsime pirmąjį jo
# elementą.

tapply(x, g, "[", 1)


# Kartais grupavimo kintamasis gali būti gaunamas iš pradinio duomenų vektoriaus 
# užrašant jam kokią nors loginę sąlygą. Pvz., į dvi atskiras grupes atskirsime 
# lyginius ir nelyginius vektoriaus x elementus.

tapply(x, x %% 2 == 0, "[")

# Tokią pat sąlygą galima perkelti ir į funkciją split.

split(x, x %% 2 == 0)


# UŽDUOTIS ------------------------------ 

# 1. Naudojant f-ją tapply, apskaičiuokite vektoriaus x elementų sumą suskaidant
#    x į pogrupius pagal vektoriaus p elementų reikšmes.
# 2. Naudojant f-ją tapply, raskite mažiausią ir didžiausią vektoriaus x reikšmę
#    grupėse pagal kintamajį p.
# 3. Apskaičiuokite duomenų lentelės kintamojo "svoris" vidurkį atskirai vyrų ir
#    moterų grupėse. Atsižvelkite į tai, kad kintamasis turi praleistų reikšmių.
# 4. Naudojant f-ją tapply, iš vektoriaus x elementų suskirstytus grupėmis pagal 
#    kintamąjį g, sudarykite matricas, kurios turėtų po vieną stulpelį.
# 5. Naudojant tapply, iš kiekvienos, pagal vektorių g suskirstytų, vektoriaus x
#    elementų grupės išskirkite po pirmuosius du elementus.
# 6. Naudojant tapply, užrašykite funkciją, kuri apskaičiuotų, kiek vektoriaus y
#    elementų turi praleistas reikšmes ir kiek neturi. Kaip tokį patį rezultatą
#    gauti nenaudojant funkcijos tapply?


# --------------------------------------- #
# FUNKCIJA BY                             #
# --------------------------------------- #

# Funkcija tapply naudojama kitų funkcijų skaičiavimui kaip duomenis naudojant į
# grupes išskaidytus vektoriaus elementus. Analogiška funkcija duomenų lentelėms
# arba matricoms yra by. Jos parametrai:
# 
#          data -- duomenų lentelė arba matrica,
#       INDICES -- duomenis grupuojantis faktorius arba jų sąrašas,
#           FUN -- funkcijos pavadinimas arba išraiška,
#      simplify -- jei TRUE, rezultatas grąžinamas kaip vektorius.

# Duomenų lentelės eilutės pagal vieno ar keletos kategorinių kintamųjų reikšmes
# suskirstomos į grupes. Taip gaunamos kelios mažesnės duomenų lentelės, ir tada 
# kiekviena iš jų perduodama argumento FUN funkcijai. Jei grupavimas atliekamas
# pagal kelis kintamuosius, jie parametrui INDICES perduodami apjungti į sąrašą.

# Pačiu paprasčiausiu atveju funkcija by naudojama lygiai taip pat kaip ir f-ja
# tapply, skiriasi tik rezultatų išvedimo forma. Pvz., apskaičiuosime vektoriaus 
# x vidurkį grupėse pagal vektoriaus g elementų reikšmes. 

by(x, g, mean)

# Skaičiavimus grupėse galima atlikti su vienu duomenų lentelės kintamuoju. Pvz., 
# apskaičiuosime lentelės d kintamojo ūgis vidurkį atskirai vyrams ir moterims.
# Čia kintamasis ūgis vidurkio skaičiavimo funkcijai perduodamas kaip vektorius. 

by(d[, 2], d[, 1],  mean)    # nurodome stulpelių numerius
by(d$ūgis, d$lytis, mean)    # nurodome kintamųjų vardus

# Visą išraišką įdėjus į funkciją with, lentelės kintamųjų vardus galima naudoti 
# tiesiogiai. Tokiu būdu užrašyta išraiška lengviau skaitoma ir suprantama.

with(d, by(ūgis, lytis, mean))


# Naudojant by, funkcijai galima perduoti daugiau nei vieną kintamąjį turinčią 
# duomenų lentelę. Pvz., apskaičiuosime kintamųjų ūgis ir svoris koreliacijos 
# koeficientą atskirai vyrų ir moterų grupėse.

# Kaip ir anksčiau, visą by išraišką įdėsime į with konstrukciją. Funkcijai cor
# perduodamus kintamuosius ūgis ir svoris apjungiame į duomenų lentelę naudodami 
# komandą cbind. Kadangi ši lentelė turi praleistų reikšmių, papildomai nurodome 
# funkcijos cor parametrą use = "complete.obs", todėl stebiniai su praleistomis 
# reikšmėmis nebus naudojami.

with(d, by(cbind(ūgis, svoris), lytis, cor, use = "complete.obs"))

# Jei eilutės su praleistomis reikšmėmis būtų panaikinamos iš anksto, funkcijai
# nereikėtų nurodyti parametro apie praleistas reikšmes. Tam galima naudoti f-ją
# na.omit, kurios rezultatas yra duomenų lentelė be NA reikšmių turinčių eilučių.

with(na.omit(d), by(cbind(ūgis, svoris), lytis, cor))

# Tačiau tokiu būdu visai be reikalo išmetama ir 6-ta eilutė, kurioje NA reikšmę 
# turi koreliacijos skaičiavime nenaudojamas kintamasis grupė. Dėl to, eilutes
# su NA reikšmėmis reikia išmesti neatsižvelgiant į ketvirtame stulpelyje esantį
# kintamąjį grupė.

with(na.omit(d[, -4]), by(cbind(ūgis, svoris), lytis, cor))

# Vietoj kintamųjų vardų nurodant stulpelių numerius, ta pati išraiška užrašoma 
# šiek tiek trumpiau.

by(d[, 2:3], d[, 1], cor, use = "complete.obs")


# Dažnai paprasčiau funkcijai kaip duomenis perduoti visus lentelės kintamuosius.
# Užrašysime funkciją, kuri apskaičiuoja ne koreliacijų matricą, bet tik dviejų
# konkrečių lentelės kintamųjų koreliacijos koeficientus grupėse pagal lytį. Čia
# reikiami kintamieji iš f-jai perduotos lentelės išrenkami jau funkcijos viduje.

by(d, d$lytis, function(x) cor(x$ūgis, x$svoris, use = "complete.obs"))


# UŽDUOTIS ------------------------------ 

# 1. Nagrinėkime duomenų lentelę d. Naudodami funkciją by ir t.test, padalinkite
#    duomenis pagal kintamąjį grupė į dvi dalis bei patikrinkite hipotezes, kad 
#    ūgio vidurkis grupėje lygus 180 cm.
# 2. Duomenų lentelėje airquality yra įvairių oro parametrų Niujorke matavimai.
#    Apskaičiuokite, kiek praleistų ozono matavimų yra kiekvieną mėnesį. Tą patį
#    rezultatą gaukite naudodami funkcijas by arba tapply.
# 3. Nagrinėkime duomenų lentelę airquality. Sudarykite ozono priklausomybės nuo
#    temperatūros paprastosios tiesinės regresijos modelį ir, naudojant funkciją 
#    by, įvertinkite šių modelio parametrus kiekvienam mėnesiui atskirai.


# --------------------------------------- #
# FUNKCIJA AGGREGATE                      #
# --------------------------------------- #

# Kaip ir funkcija by, funkcija aggregate duomenų lentelę pagal vieno ar keletos
# kategorinių kintamųjų reikšmes suskirsto į grupes. Pagrindinis skirtumas toks,
# kad skaičiavimams perduodama ne duomenų lentelė, tačiau ją sudarančių kitamųjų
# rinkinys. Dėl to funkcija aggregate dažniausiai naudojama atskirų kintamųjų tų 
# pačių skaitinių charakteristikų skaičiavimui ir šiuo požiūriu labiau panaši į 
# funkciją tapply. Jos parametrai:
# 
#             x -- duomenų lentelė, matrica arba vektorius,
#            by -- sąrašas su duomenis grupuojančių faktorių vardais,
#           FUN -- funkcijos pavadinimas arba išraiška.

# Reikia atkreipti dėmesį, kad šios funkcijos parametrui by visada nurodomas tik
# grupuojančių kintamųjų list tipo sąrašas (net jei toks kintamasis yra vienas).

# Pavyzdžiui, apskaičiuosime vektoriaus x vidurkius grupėse pagal kintamąjį g.

aggregate(x, list(g), mean)


# Grupavimo kintamasis gali būti nebūtinai vienas. Pvz., apskaičiuosime ūgio ir 
# svorio iš lentelės d vidurkius pagal lytį ir stebinių grupę. Kadangi lentelė 
# turi praleistų reikšmių, papildomai nurodome funkcijos mean parametrą na.rm.
# Rezultatas yra atskirai kiekvieno kintamojo vidurkių grupėse lentelė.

aggregate(d[, 2:3], list(d[, 1], d[, 4]), mean, na.rm = TRUE)

# Tą pačią išraišką įkelsime į funkciją with ir perrašysime tiesiogiai naudodami 
# lentelės kintamųjų vardus.

with(d, aggregate(cbind(ūgis, svoris), list(lytis, grupė), mean, na.rm = TRUE))


# Funkcija aggregate leidžia duomenų suskaidymą užrašyti formule. Šiuo atveju
# skiriasi jos parametrai:
#
#   formula -- duomenų suskaidymo formulė,
#      data -- duomenų lentelės vardas,
#       FUN -- funkcijos vardas arba jos išraiška,
#    subset -- išraiška, kuri iš duomenų lentelės išrenka tam tikras eilutes,
# na.action -- pagal nutylėjimą na.omit - nurodo, kad NA reikšmes pašalinti.


# Galimi tokie formulės užrašymo variantai:
#
#           y ~ A -- y suskaidomas į grupes pagal kintamojo A reikšmes,
#       y ~ A + B -- y suskaidomas pagal kintamųjų A ir B reikšmes,
# cbind(y, x) ~ A -- y ir x suskaidomi pagal kintamojo A reikšmes,
#           . ~ A -- visi lentelės kintamieji suskaidomi pagal A reikšmes,
#           y ~ . -- y suskaidomas pagal visus likusius lentelės kintamuosius.


# Dar kartą apskaičiuosime vektoriaus x vidurkius grupėse pagal vektorių g. Šį
# kartą suskirstymą užrašysime formule. Kadangi vektoriai ne iš duomenų lentelės,
# parametro data nurodyti nereikia.

aggregate(x ~ g, FUN = mean)

# Apskaičiuosime kintamojo ūgis iš duomenų lentelės d vidurkį atskirai vyrams ir 
# moterims. Nurodžius duomenų lentelės vardą, formulėje galima tiesiogiai rašyti 
# kintamųjų vardus.

aggregate(ūgis ~ lytis, data = d, FUN = mean)

# Apskaičiuosime ūgio ir svorio iš lentelės d vidurkį grupėse pagal kategorinius 
# kintamuosius lytį ir grupę. Kairėje formulės pusėje esančius kintamuosius 
# reikia apjungti į vieną lentelę. Tam naudojama komanda cbind.

aggregate(cbind(ūgis, svoris) ~ lytis + grupė, data = d, FUN = mean)

# Kadangi abu kintamieji lytis ir grupė yra kategoriniai, o kitų kintamųjų nėra,
# juos galima pakeisti tašku. Čia reikia suprasti, kad ūgis ir svoris grupuojami
# pagal visus likusius lentelės d kintamuosius.

aggregate(cbind(ūgis, svoris) ~ ., data = d, FUN = mean)

# Tą patį galima padaryti ir su kitų dviejų kintamųjų pora. Toks užrašymo būdas 
# patogus, jei suskaidymą reikia atlikti daugeliui kintamųjų iš karto, nes šiuo 
# atveju nereikia rašyti jų visų vardų.

aggregate(. ~ lytis + grupė, data = d, FUN = mean)


# Jei reikia, funkcija aggregate leidžia grupuoti tik tam tikras logines sąlygas 
# tenkinančias eilutes. Tokiu atveju parametrui subset nurodome loginę išraišką.
# Pavyzdžiui, apskaičiuosime ūgio vidurkius mažiau nei 80 kg sveriantiems vyrams 
# ir moterims. Šiuo atveju parametrui subset nurodome sąlygą svoris < 80.

aggregate(ūgis ~ lytis, data = d, subset = svoris < 80, FUN = mean)


# UŽDUOTIS ------------------------------ 

# 1. Lentelėje chickwts yra eksperimento, kurio metu viščiukams buvo duodami tam
#    tikri maisto priedai ir matuojamas jų svoris, rezultatai: kintamasis weight
#    ir feed. Apskaičiuokite viščiukų svorio vidurkius grupėse pagal tai, kokius 
#    maisto priedus jie gavo. Užrašykite funkcijos aggregate versiją grupavimui 
#    naudojant formulę. Kaip tokį patį rezultatą gauti naudojant tapply arba by?
# 2. Duomenų lentelėje airquality yra įvairių oro parametrų Niujorke matavimai.
#    Apskaičiuokite vidutinę kiekvieno mėnesio oro temperatūrą naudojant f-jas
#    aggregate ir tapply.
