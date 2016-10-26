
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Skaičių ir teksto formatavimo funkcijos.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2016-03-29 | 2016-04-19
#


# TURINYS -------------------------------

#
#   1. Skaičių ir teksto formatavimas:
#      * funkcija formatC
#      * funkcija prettyNum
#      * funkcija sprintf
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
# TRUMPAI APIE TEKSTO FORMATAVIMĄ         #
# --------------------------------------- #

# Labai dažnai skaičiavimų rezultatus reikia įterpti į tekstą, kuris išvedamas į
# ekraną ar tekstinį failą. Įvairaus tipo reikšmių, suformatuotų pagal tam tikrą
# iš anksto nustatytą šabloną, išvedimas į ekraną ar kitus įrenginius, vadinamas 
# formatuotu spausdinimu. Daugelis programavimo kalbų šiam tikslui turi funkciją
# printf (print formatted), kurios standartas susiformavo C kalboje, o R kalboje
# šiam tikslui naudojama funkcijos printf atmaina sprintf. Ši f-ja skaičių įdeda 
# į teksto šabloną ir tokį formatuotą tekstą grąžina kaip simbolių seką.

# Skaičių atvaizdavimui R dar turi funkcijas formatC, prettyNum, kurios taip pat
# naudoja šią iš C kalbos atėjusią formatavimo tradiciją.


# --------------------------------------- #
# SKAIČIŲ FORMATAVIMAS                    #
# --------------------------------------- #

# Atskirai skaičių formatavimui, naudojant C kalboje priimtą sintaksę, naudojama 
# funkcija formatC. Jos parametrai:
#
#                x -- realių skaičių vektorius,
#           digits -- reikšmingų skaitmenų skaičius,
#            width -- skaičiui užrašyti skirtų simbolių skaičius,
#           format -- skaičiaus užrašymo formatas,
#             flag -- papildomos skaičiaus formatavimo priemonės, 
#         big.mark -- sveikosios dalies skaitmenų grupavimo simbolis,
#       small.mark -- trupmeninės dalies skaitmenų grupavimo simbolis, 
#     big.interval -- skaitmenų grupės sveikojoje dalyje dydis,
#   small.interval -- skaitmenų grupės trupmeninėje dalyje dydis,
#     decimal.mark -- sveikosios ir trupmeninės dalies atskyrimo simbolis,
#   preserve.width -- skaičių su grupuotais skaitmenimis formatavimo taisyklė,
#       zero.print -- loginis, nurodo, ar rodyti nulines vektoriaus reikšmes, 
#    drop0trailing -- loginis, nurodo, ar rodyti nulius už reikšminių skaitmenų.


c <- 299792458L       # šviesos greitis
e <- 2.718281828      # Oilerio konstanta
m <- 9.109383561e-31  # elektrono masė
L <- 6.022140857e+23  # Avogadro skaičius

# Bet kurį skaičių galima užrašyti keliais skirtingais formatais. Pvz., sveikąjį
# skaičių 1000 galima užrašyti kaip realųjį skaičių 1000.0 ar eksponentine forma
# (scientific format) kaip 1.0000e+03. Skaičiaus užrašymo formatą nustato format
# parametras. Pagrindinės jo reikšmės tokios:
#
#          "d" -- sveikiesiems skaičiams,
#          "f" -- realiesiems skaičiams, xx.xxxx,
#          "e" -- scientific format, x.xxxe+nn,
#          "E" -- scientific format, x.xxxE+nn,
#          "s" -- simbolių sekai.

# Be šių reikšmių, dar yra "g" ir "G", kurios nurodo, kad skaičius bus užrašomas
# atitinkamai "e" arba "E" formatu, jei šiuo formatu jis užrašomas trumpiau. Dar
# yra reikšmė "fg", kuri nurodo, kad skaičius bus užrašytas "f" formatu --- kaip
# realus skaičius, tačiau reikšmingų skaitmenų skaičius bus toks, koks nurodytas
# parametru digits, todėl sveikieji skaičiai, kuriems parametras digits = 0, bus
# rašomi be trupmeninės dalies. Pagal nutylėjimą sveikiesiems skaičiams formatas
# yra "d", o realiesiems skaičiams -- "g".

# Parametras digits nurodo arba norimą skaitmenų skaičių po kablelio, kai format
# parametro reikšmė yra "f", arba reikšmingų skaitmenų skaičių, kai formatas yra 
# "e", "g" arba "fg". Pagal nutylėjimą realiesiems skaičiams digits = 4.

# Parametras width nustato skaičiui užrašyti skirtos simbolių sekos ilgį. Jei jo
# reikšmė nenurodoma, tada automatiškai width = digits + 1. Jeigu width = 0, tai 
# simbolių skaičius lygus parametro digits reikšmei.


# Panagrinėsime, kaip galima atvaizduoti didelį sveikąjį skaičių. Tegul tai būna
# c raide žymimas šviesos greitis vakuume. PASTABA! Sveikieji skaičiai R kalboje 
# rašomi su simboliu L gale. Priešingu atveju laikoma, kad skaičius yra realusis.

class(299792458L)
class(299792458)

# Nuo skaičiaus klasės priklauso tai, kokiu formatu tas skaičius atvaizduojamas. 
# Pvz., jei nenurodome formato, vienu atveju tas pats skaičius vaizduojamas kaip
# sveikasis, kitu atveju --- standartine skaičiaus išraiška (scientific format).

#       123456789
#       ||||||||| 
formatC(299792458L)
formatC(299792458)

# Jeigu parametrui priskiriame reikšmę "f", tai sveikasis skaičius bus užrašytas
# kaip realusis. Jei parametro reikšmė "e", skaičius užrašomas standartine forma
# su 4 reikšminiais skaitmenimis. Parametro format reikšmė "fg" nurodo, kad toks
# sveikasis skaičius turėtų būti užrašomas kaip realusis, bet kadangi reikšminių 
# skaitmenų skaičius digits sveikiesiems lygus nuliui, trupmeninė dalis nerodoma.

formatC(299792458L, format = "f")
formatC(299792458L, format = "e")
formatC(299792458L, format = "fg")

# Šiam skaičiui užrašyti reikia 9 skaitmenų. Jei parametro width reikšmė mažesnė 
# už 9, skaičius vis tiek bus užrašomas naudojant 9 simbolius. Tačiau jam galima
# skirti ir daugiau simbolių. Tada skaičius bus lygiuojamas pagal dešiniąją pusę.

formatC(299792458L, width = 2)
formatC(299792458L, width = 12)

# Jeigu sveikasis skaičius užrašomas kaip realusis, bet parametro digits reikšmė
# nenurodoma, tada jis užrašomas su 4 reikšminiais skaitmenimis po kablelio. Tai
# galima pakeisti priskiriant parametrui digits kitą reikšmę.

formatC(299792458L, format = "f")
formatC(299792458L, format = "f", digits = 1)
formatC(299792458L, format = "e", digits = 1)

# Kombinuojant šių trijų pagrindinių parametrų reikšmes, skaičių galima užrašyti
# labai įvairiai. Pavyzdžiui, skaičiui užrašyti skirsime 20 simbolių. Užrašysime 
# jį vienu atveju, kaip sveikąjį skaičių, o kitu - kaip realųjį skaičių su dviem 
# reikšminiais skaičiais po kablelio.

formatC(299792458L, format = "d", width = 20)
formatC(299792458L, format = "f", width = 20, digits = 2)


# Panagrinėsime, kaip galima atvaizduoti labai mažą realųjį skaičių. Pavyzdžiui,
# tegul tai būna elektrono masė m. Kadangi m realusis skaičius, pagal nutylėjimą
# parametro format reikšmė yra "g", vadinas, jis vaizduojamas standartine forma.
# Jeigu toks realusis skaičius užrašomas kaip sveikasis, jis bus rodomas kaip 0.
# Jei parametro format reikšmė "f", tada pagal nutylėjimą rodomi pirmieji keturi 
# reikšminiai skaitmenys, kurie šiuo atveju visi lygūs nuliui. Nurodžius formatą
# "fg", skaičius užrašomas taip, kad būtų matomi keturi reikšminiai skaitmenys.

formatC(m)
formatC(m, format = "g")
formatC(m, format = "e")
formatC(m, format = "d")
formatC(m, format = "f")
formatC(m, format = "fg")

# Norint pamatyti visą skaičių, papildomai reikėtų nurodyti reikšminių skaitmenų
# skaičių. Šiuo atveju jų yra 10.

formatC(m, format = "fg", digits = 10)

# PASTABA! Jeigu reikšminių skaitmenų skaičius nurodomas didesnis, nei jų yra iš
# tikro, skaičiuje atsiranda papildomi skaitmenys, kurių neturėtų būti. Taip yra
# dėl slankiojo kablelio skaičių aritmetikos paklaidų, nes kompiuterio atmintyje 
# skaičiui užrašyti skiriamas tam tikras fiksuotas bitų kiekis (32 ar 64), kurio 
# neužtenka skaičiui išreikšti. Tai galioja ir labai dideliems, ir labai mažiems
# skaičiams. Pavyzdžiui, skaičiui m nurodysime 20 reikšminių skaičių, kurie visi 
# bus rodomi, nors iš tikro reikšminių skaičių šiuo atveju yra tik 10.

formatC(m, format = "fg", digits = 20)

# Jeigu skaičius nėra labai didelis arba labai mažas, o parametro digits reikšmė
# viršija tikrąjį reikšminių skaitmenų skaičių, tai skaičiaus gale yra prirašomi 
# nuliai (trailing zeros). Pavyzdžiui, konstanta e čia užrašyta su 10 reikšminių 
# skaičių. Atvaizduokime jį su 15 reikšminių skaičių.

formatC(e, format = "f", digits = 15)

# Loginis parametras drop0trailing nustato, kad galima nerodyti nulių, kurie yra
# rašomi už reikšminių skaičių. Taigi, nors parametras digits viršija reikšminių
# skaitmenų skaičių, nuliai gale jau nebus rašomi.

formatC(e, format = "f", digits = 15, drop0trailing = TRUE)


# Kadangi, naudojant funkciją formatC, skaičius atvaizduojamas kaip tekstas, yra
# galimybė pritaikyti papildomas teksto formatavimo priemones: skaičių rašyti su 
# ženklu, pakeisti lygiavimą ir k.t. Tam skirtas parametras flag, kurio reikšmės
# gali būti tokios:
#
#          "0" -- skaičiaus pradžioje bus rašomi nuliai,
#          "+" -- skaičius rašomas su ženklu,
#          "-" -- išlygiavimas pagal kairę,
#          " " -- jei pirmas simbolis ne ženklas, tada dedamas tarpas,
#          "#" -- alternatyvus spausdinimas, priklauso nuo formato.

# Sudarant kodus ar eilės numerius, patogumo dėlei skaičiaus pradžioje gali būti 
# rašomi nuliai. Pavyzdžiui, iš sveikųjų skaičių sekos 1, 2, ..., 100 sudarysime 
# 3-jų simbolių ilgio kodus.

formatC(1:100, flag = "0", width = 3)

# Jei parametro width reikšmė didesnė už skaičiaus skaitmenų skaičių, tada pagal
# nutylėjimą skaičius bus lygiuojamas pagal dešinįjį kraštą. Tai galima pakeisti
# parametrui flag priskyrus reikšmę "-".

formatC(1:100, flag = "-", width = 3)

# Kai kada svarbu nurodyti skaičiaus ženklą. Pvz., tai gali būti temperatūros ar
# ekonominių rodiklių pokyčiai laike. Tokiu atveju parametrui flag nurodome "+".
# Pavyzdžiui, duotas Vilniaus miesto kiekvieno mėnesio žemiausių oro temperatūrų
# sąrašas (E. Rimkus, 2013). Pavaizduosime šias temperatūras su ženklu.

#        Sau.   Vas.  Kov.  Bal.  Geg.  Bir.  Lie.  Rug.  Rgs.  Spa.  Lap.   Grd.
#       -----  ----- ----- ----- ----- ----- ----- ----- ----- ----- -----  -----
t <- c(-20.5, -16.3, -9.4, -0.1,  5.9, 10.4, 12.9, 13.2,  8.1,  0.4, -7.7, -19.0)

formatC(t, flag = "+")
formatC(t, flag = "+", format = "f", digits = 1)

# Papildomai galima nurodyti, kad skaičiams pavaizduoti būtų naudojamas vienodas
# simbolių skaičius. Skaičių, kurie turi mažiau skaitmenų, pradžioje bus dedamas 
# tarpas.

formatC(t, flag = "+", format = "f", digits = 1, width = 5)

# Jeigu sekoje yra ir teigiamų, ir neigiamų skaičių, tačiau teigiamiems nurodyti
# ženklą nebūtina, vietoje jo galima palikti tarpą. Tai nurodoma parametrui flag 
# priskiriant reikšmę " ".

formatC(t, flag = " ")
formatC(t, flag = " ", format = "f", digits = 1)
formatC(t, flag = " ", format = "f", digits = 1, width = 5)


# Pagal lietuvių kalbos taisykles, sveikoji dešimtainės trupmenos dalis skiriama
# kableliu, tačiau kitose kalbose, o taip pat ir programavimo kalbose, paprastai 
# tam naudojamas taškas. Tai, koks simbolis naudojamas užrašant skaičių, nustato 
# parametras decimal.mark. Užrašysime temperatūrų reikšmes pagal lietuvių kalbos 
# taisykles.

formatC(t, decimal.mark = ",")
formatC(t, decimal.mark = ",", format = "f", digits = 1)


# Labai didelius arba labai mažus skaičius, jei jie neužrašyti standartine forma, 
# vizualiai nelengva suvokti. Patogumo dėlei, tokių skaičių skaitmenys gali būti 
# grupuojami, taip atskiriant šimtų, tūkstančių, milijonų ir t.t. eilę. Funkcija
# formatC šiam tikslui turi tokias dvi parametrų poras:
#
#                  sveikosios dalies           trupmeninės dalies
#                  ----------------            ----------------
#                  big.mark                    small.mark 
#                  big.interval                small.interval

# Pirmoji pora nustato sveikosios skaičiaus dalies skaitmenų grupavimo taisyklę, 
# antroji - trupmeninės dalies skaitmenų grupavimo taisyklę. Parametrai big.mark
# ir small.mark nurodo simbolį, kuriuo atskiriamos skaitmenų grupės, o parametro
# big.interval arba small.interval reikšmė yra sveikasis skaičius, kuris nurodo, 
# kas kiek skaitmenų skaičiuje dedamas skyriklis. Pvz., sugrupuosime skaičiaus c
# skaitmenis grupėmis po 3.

formatC(c, format = "fg", big.mark = "'")

# Pavyzdžiui, Avogadro skaičius labai didelis, todėl jo skaitmenis suskirstysime 
# į grupes po 10 skaitmenų. Taip iš karto matosi, kad skaičiaus eilė n > 20.

formatC(L, format = "fg", big.mark = "'", big.interval = 10)

# Analogiškai sugrupuojami labai mažo realiojo skaičiaus skaitmenys po kablelio.
# Pavyzdžiui, tokiu būdu užrašysime elektrono masę m. Iš karto matome, kad yra 6 
# tokios grupės, vadinasi masės m eilė ne mažiau kaip -30.

formatC(m, format = "fg", small.mark = " ")

# Grupuojant skaitmenis padidėja skaičiui užrašyti reikalingų simbolių skaičius.
# Jeigu reikia, kad tokiems skaičiams užrašyti reikalingų simbolių skaičius būtų 
# vienodas, parametro preserve.width reikšmė keičiama iš "individual" į "common".
# Pavyzdžiui, duotas tam tikrų Fibonacci sekos narių vektorius. Sugrupuosime šių
# skaičių skaitmenis po 3 išlaikant tą patį bendrą simbolių skaičių.

#      10    20      30         40           50             60               70
#      --  ----  ------  ---------  -----------  -------------  ---------------
F <- c(55, 6765, 832040, 102334155, 12586269025, 1548008755920, 190392490709135) 

F.format <- formatC(F, format = "fg", big.mark = "'", preserve.width = "common")
F.format

# Šitoks skaičių išlygiavimas pasimato, kai juos atspausdiname po vieną eilutėje.
# Tam galima panaudoti funkciją cat.

cat(F.format, sep = "\n")


# Jeigu nulinėms reikšmėms formatas neturi būti nustatomas, parametro zero.print 
# reikšmė pakeičiama į FALSE. Tada vietoje nulio bus rodoma tarpų seka. Tai gali
# būti naudinga tuo atveju, kai sekoje yra daug nulių, kuriuos galima ignoruoti.

z <- c(0, 1.1, -1.0, 0, -1.7, 1.2, 0, -1.3, 0, 1.5, 0, 1.2, 0, 0, 0, 0, 0, -1.2)

formatC(z, format = "f", zero.print = FALSE)
formatC(z, format = "f", zero.print = FALSE, digits = 1)


# NAUDINGA ------------------------------

# Skaičių formatavimui gali būti naudojama ir funkcija prettyNum. Ji turi mažiau 
# galimybių, bet labai panaši į funkciją formatC. Jos parametrai:
#
#                x -- skaičių vektorius,
#         big.mark -- sveikosios dalies skaitmenų grupavimo simbolis,
#       small.mark -- trupmeninės dalies skaitmenų grupavimo simbolis, 
#     big.interval -- skaitmenų grupės sveikojoje dalyje dydis,
#   small.interval -- skaitmenų grupės trupmeninėje dalyje dydis,
#     decimal.mark -- sveikosios ir trupmeninės dalies atskyrimo simbolis,
#   preserve.width -- skaičių su grupuotais skaitmenimis formatavimo taisyklė,
#       zero.print -- loginis, nurodo, ar rodyti nulines vektoriaus reikšmes, 
#    drop0trailing -- loginis, nurodo, ar rodyti nulius už reikšminių skaitmenų,
#         is.cmplx -- loginis, nurodo, ar skaičius x yra kompleksinis.

prettyNum(c, big.mark = "'")      # grupuojame skaitmenis
prettyNum(t, decimal.mark = ",")  # tašką pakeičiame į kablelį
prettyNum(z, zero.print = FALSE)  # nerodomi nuliai


# UŽDUOTIS ------------------------------ 

# 1. Šviesos greitį c = 299792458 m/s užrašykite standartine skaičiaus išraiška.
#    Skaičius turi būtų vaizduojamas su trimis skaitmenimis po kablelio.
# 2. Užrašykite komandą, kuri sukurtų sunumeruotų failų seką pagal tokį šabloną: 
#    failas_001.txt, failas_002.txt, ..., failas_100.txt.
# 3. Merseno pirminiai skaičiai išreiškiami formule M = 2^p - 1, kur p taip pat
#    pirminis. Didžiausias šiuo metu žinomas pirminis skaičius tuo pačiu yra ir
#    Merseno pirminis skaičius su parametru p = 74207281. Jis turi net 22338618 
#    skaitmenų ir sutrumpintai žymimas M74207281. Mažesni Merseno skaičiai taip
#    pat yra dideli, pavyzdžiui, M127 = 170141183460469231731687303715884105727, 
#    jo parametras p = 127. Naudojant funkciją formatC, skaičių M127 užrašykite 
#    suskirstydami skaitmenis į grupes, kad iš to būtų galima lengvai vizualiai
#    nustatyti jų skaičių.


# --------------------------------------- #
# TEKSTO FORMATAVIMAS SU FUNKCIJA SPRINTF #
# --------------------------------------- #

# Kalbant griežtai, funkcija sprintf tam tikrą duomenų srautą pertvarko pagal iš
# anksto užduotą formatą ir grąžina simbolių seką. Jos parametrai:
#
#          fmt -- formatuoto teksto šablonas,
#          ... -- į šabloną įstatomos reikšmės.

# Parametras fmt --- tai pagal specialias taisykles užrašytas teksto šablonas, į
# kurį įstatomos nustatyta tvarka išvardytų kintamųjų reikšmės. Iš esmės fmt yra
# simbolių seka, kurioje yra dviejų rūšių objektai: tai įprasti simboliai, kurie
# į išvedamą simbolių seką nukopijuojami taip, kaip užrašyti, ir formatai, kurie
# nurodo, kaip turi būti pertvarkytos išvardintų kintamųjų reikšmės.

# Kad būtų lengviau įsivaizduoti, iš pradžių užrašysime šabloną be jokių formatų:
#
#                       "Atstumas nuo {} iki {} yra {} km."
#
# Šiuo atveju riestiniai skliaustai nurodo vietą tekste, kur galima įstatyti tam
# tikrą reikšmę. Pavyzdžiui, jei kalbama apie atstumus tarp miestų, tai pirmieji
# skliaustai nurodo vieno miesto pavadinimą, antrieji --- kito miesto pavadinimą, 
# o vietoje trečiųjų skliaustų rašomas tam tikras skaičius, kuris nurodo atstumą 
# tarp šių miestų kilometrais.

# Visi formatai prasideda simboliu "%", o užsibaigia viena raide, kuri ir nurodo 
# konkretų kintamojo atvaizdavimo reikšmės formatą:
#
#         i, d -- sveikasis skaičius arba loginė reikšmė,
#            o -- aštuntainis skaičius,
#         x, X -- šešioliktainis skaičius,
#            f -- realus skaičius, "[-]mmm.ddd",
#         e, E -- standartinė skaičiaus forma, "[-]m.ddde[+-]xx",
#         g, G -- atitinka %e ir %E, jei eksponentė < -4, kitu atveju %f,
#            s -- simbolių seka,
#            % -- išvedamas simbolis "%".


# Pavyzdžiui, suformuosime šabloną atstumui tarp dviejų miestų užrašyti. Tarkime, 
# kad miestus žymi raidės A ir B, o atstumas tarp jų lygus d. Tada šablonas toks:
#
#                       "Atstumas nuo A iki B yra d km."
#
# Šiuo atveju A ir B yra miestų pavadinimai, vadinasi jų formatas %s, o atstumas
# h sveikas skaičius, todėl šios reikšmės formatas %i. Gauname štai tokį šabloną:
#
#                      "Atstumas nuo %s iki %s yra %i km."                      
#
# Tarkime, kad vienas miestas yra Skuodas, o kitas - Druskininkai. Atstumas tarp
# jų 349 kilometrų. Į f-ją sprintf įrašome šabloną, tada reikšmes surašome tokia 
# tvarka, kokia jos turi būti įstatytos į šabloną.

#                     šablonas                          reikšmės         
#       |---------------------------------|  |---------------------------|
#                     1      2      3            1           2         3
sprintf("Atstumas nuo %s iki %s yra %i km.", "Skuodo", "Druskininkų", 349)


# Jeigu į šabloną įstatomos reikšmės gali keistis, tai į funkciją sprintf geriau
# surašyti kintamuosius, kuriems tos reikšmės bus priskiriamos.

šablonas <- "Atstumas nuo %s iki %s yra %i km."

A <- "Skuodo"
B <- "Druskininkų"
d <- 349

sprintf(šablonas, A, B, d)

# Tą patį šabloną galima naudoti ir kitiems atstumams, pavyzdžiui, tarp Žemės ir
# Mėnulio, užrašyti. Šiuo atveju funkcijos sprintf išraiška nesikeičia, keičiasi
# tik kintamųjų reikšmės.

A <- "Žemės"
B <- "Mėnulio"
d <- 384400

sprintf(šablonas, A, B, d)


# Užrašant reikšmės formatą, standartinę formatavimo taisyklę galima pakoreguoti 
# tarp "%" ir formatą nurodančios raidės įrašant papildomą simbolį. Galimi tokie
# variantai:
#
#          m.n -- m nurodo bendrą simbolių skaičių, o n nurodo tikslumą
#            0 -- skaičiaus pradžioje bus rašomi nuliai,
#            + -- skaičius rašomas su ženklu,
#            - -- išlygiavimas pagal kairę,
#          " " -- jei pirmas simbolis ne ženklas, tada dedamas tarpas,
#            # -- alternatyvus spausdinimas, priklauso nuo formato.

# Naudojant kombinaciją m.n galima nurodyti iš karto kelis dalykus: tai reikšmės 
# atvaizdavimui skirtų simbolių skaičių bei skaitmenų po kablelio skaičių, jeigu
# ta reikšmė yra realusis skaičius. Čia m ir n gali įgyti reikšmes 0, 1, 2, ...
# Pavyzdžiui, tarkime, kad realųjį skaičių e reikia užrašyti dviejų skaitmenų po 
# kablelio tikslumu, vadinasi, tam reikia 4 simbolių, todėl formatas bus "%4.2f".

sprintf("%4.2f", e)

# Jei parametras m mažesnis, nei reikšmei užrašyti reikalingų simbolių skaičius,
# tada jis bus ignoruojamas. Pavyzdžiui, šiuo atveju m = 3, m = 2 ar m = 0 nieko
# nekeičia.

sprintf("%3.2f", e)
sprintf("%2.2f", e)
sprintf("%1.2f", e)
sprintf("%0.2f", e)

# Jei parametras m didesnis, nei skaičiui užrašyti reikalingų simbolių skaičius,
# tada rezultatas bus m simbolių ilgio seka su tarpais. Pavyzdžiui, šiuo atveju,
# nustačius m = 5, prie skaičiaus bus pridedamas vienas tarpas, nustačius m = 6,
# bus pridedami du papildomi tarpai ir pan.

sprintf("%5.2f", e)
sprintf("%6.2f", e)

# Jei reikia nustatyti tik skaitmenų po kablelio skaičių, tai parametrą m galima
# ir visai praleisti. Dviejų skaitmenų po kablelio formatas užrašomas "%.2f".

sprintf("%.2f", e)

# Jei reikia nustatyti tik bendrą reikšmei užrašyti reikalingų simbolių skaičių,
# tada galima praleisti parametrą n. Pavyzdžiui, galime nurodyti, kad skaičiui e 
# užrašyti būtų skirta 15 simbolių.

sprintf("%15f", e)

# Analogiškai gali būti nustatomas simbolių skaičius sveikajam skaičiui užrašyti.
# Jeigu sveikajam skaičiui užrašyti reikia skirti m simbolių, tai formatas "%md".

sprintf("%3d", 2)

# Jeigu vietoje tarpų turi būti rašomi nuliai, tai į formatą įterpiamas simbolis 
# "0". Pavyzdžiui, skaičių 2 užrašysime kaip kodą 002.

sprintf("%03d", 2)

# Jei skaičius ar kita reikšmė užima mažiau vietos, nei jam skirta, tada jis bus
# lygiuojamas pagal dešinįjį kraštą. Norint pakeisti lygiavimą į formatą įrašome
# simbolį "-".

sprintf("%-3d", 2)


# Jei skaičius turi būti rašomas su ženklu, užrašant formatą tarp "%" ir formato 
# raidės dedamas "+" simbolis. Pavyzdžiui, sudarysime šabloną tempratūros kitimo
# intervalui nurodyti. Tarkime, kad temperatūros reišmės --- sveikieji skaičiai,
# tada formatas bus "%+d".

t.min <- -3
t.max <-  2

sprintf("Oro temperatūra kinta nuo %+d iki %+d.", t.min, t.max)

# Jei temperatūros reikšmės realieji skaičiai, galima nurodyti skaitmenų skaičių
# po kablelio. Pvz., skaičiaus su ženklu ir vienu skaitmeniu po kablelio formatą 
# užrašome taip: "%+.1f".

t.min <- -3.5
t.max <-  2.5

sprintf("Oro temperatūra kinta nuo %+.1f iki %+.1f.", t.min, t.max)


# UŽDUOTIS ------------------------------ 

# 1. Tarkime, kad duoti trys sveikieji skaičiai, kurie nurodo: valandas, minutes
#    ir sekundes. Užrašykite komandą, kuri iš šių skaičių užrašytų laiką įprastu
#    HH:MM:SS formatu.
# 2. Panaudojant funkciją Sys.time(), užrašykite komandą, kuri į konsolę išvestų 
#    pranešimą apie laiką, pavyzdžiui: "Šiuo metu yra XX valandų ir YY minučių".
# 3. Iš statistikos kurso žinoma, kad statistinė hipotezė priimama arba atmetama
#    pagal p-reikšmę: jeigu p-reikšmė mažesnė už pasirinktą reikšmingumo lygmenį
#    alpha, tada hipotezė atmetama, o priešingu atveju -- priimama. Tarkime, kad
#    p-reikšmė žinoma, o alpha = 0.05. Užrašykite komandą, kuri į ekraną išvestų 
#    p-reikšmę, alpha ir išvadą apie tai, ar hipotezė priimama, ar atmetama.


# --------------------------------------- #
# PAPILDOMOS FUNKCIJOS SPRINTF GALIMYBĖS  #
# --------------------------------------- #

# Aprašant funkciją sprintf buvo pasakyta, kad kintamųjų reikšmės joje surašomos 
# tokia tvarka, kokia jos įrašomos į teksto šabloną. Tai tiesa, tačiau formatams
# galima suteikti eilės numerius, kurie nurodo, kokia tvarka į šabloną turi būti 
# įstatomos toliau išvardintos reikšmės, vadinasi --- nebūtinai ta pačia tvarka, 
# kokia jos surašytos funkcijoje.

# Norint nurodyti, kelinta iš išvardintų reikšmių turi būti įstatyta konkrečioje
# šablono vietoje, formate po % ženklo rašomas reikšmės numeris. Reikšmės numerį
# sudaro skaičius, po kurio rašomas "$" simbolis. Pavyzdžiui, užrašysime šabloną
# binarinei operacijai: tam reikia nurodyti operatorių ir du operandus.

sprintf("%2$d %1$s %3$d", operatorius = "+", kairė = 15, dešinė = 79)


# Reikšmių numeravimas leidžia tą pačią reikšmę į šabloną įstatyti kelis kartus.
# Pavyzdžiui, viename sakinyje įrašysime skaičių ir tą patį skaičių suapvalintą.

x <- 1/3
sprintf("Skaičius %1$f suapvalintas iki dviejų skaičių po kablelio: %1$.2f.", x)


# Jeigu toje pačioje šablono vietoje vieną kartą reikia įrašyti vieną reikšmę, o
# kitą kartą --- kitą, tai funkcijoje sprintf vietoje vienos konkrečios reikšmės
# galima įrašyti reikšmių vektorių. Tokiu būdu gauname analogiškų tekstų rinkinį 
# su skirtingomis reikšmėmis toje pačioje teksto vietoje. Pavyzdžiui, išrašysime
# Lietuvos kunigaikščių valdymo metus.

K <- c("Mindaugas", "Treniota", "Vaišelga", "Švarnas", "Traidenis", "Daumantas")

nuo <- c(1239, 1263, 1264, 1267, 1269, 1282)
iki <- c(1263, 1264, 1267, 1268, 1281, 1285)

sprintf("Lietuvos didysis kunigaikštis %s.", K)
sprintf("Lietuvos didysis kunigaikštis %s valdė nuo %d iki %d.", K, nuo, iki)


# Jei į šabloną įstatomų reikšmių vektoriai turi skirtingą elementų skaičių, tai
# trumpesnis vektorius cikliškai pratęsiamas. Pvz., sudarysime šabloną tekstinių
# failų pavadinimams sudaryti. Pirma pavadinimo dalis visiems failams vienoda, o 
# kita dalis yra eilės numeris.

prefix <- "failas"
number <- 1:10

sprintf("%s_%02d.txt", prefix, number)


# Užrašant į šabloną įdedamos reikšmės formatą galima nurodyti reikšmei užrašyti
# skiriamų simbolių skaičių arba realaus skaičiaus skaitmenų po kablelio skaičių.
# Pavyzdžiui, iki dviejų skaitmenų suapvalinto realaus skaičiaus formatas "%.2f".
# Šiuo atveju konstrukcijoje m.n parametras m praleistas ir rašoma tik parametro
# n reikšmė. Naudojant šį formatą atvaizduosime skaičių e.

sprintf("Skaičius e apytiksliai lygus %.2f", e)

# Įdedamos reikšmės formatas yra šablono dalis, todėl, norint pakeisti skaičiaus 
# atvaizdavimo formatą, reikia pakeisti patį šabloną. Tarkim, kad vietoje "%.2f"
# turi būti formatas "%.3f", vadinasi, užtenka pakeisti tik parametro n reikšmę.
# Užrašant formatą konstrukcijoje m.n vietoje parametro n galima įrašyti simbolį 
# "*", o paties parametro reikšmę iškelti prie kitų į šabloną įstatomų reikšmių.
# Taigi, formate "%.*f" parametras m praleistas, simbolis "*" nurodo parametrą n, 
# o raidė "f" nurodo, kad įdedamas realusis skaičius.

# Tokiu pavidalu užrašyto formato parametro n reikšmė taip pat įdedama į šabloną.
# Kadangi reikšmių eiliškumas nenurodytas, jos į šabloną bus įstatomos ta tvarka, 
# kuria jos surašytos. Vadinasi, šiuo atveju pirma turi būti parametro n reikšmė.

#                                       n    n
#                                       |    |
sprintf("Skaičius e apytiksliai lygus %.*f", 2, e)
sprintf("Skaičius e apytiksliai lygus %.*f", 3, e)

# Kadangi į šabloną įstatomos reikšmės turi savo eilės numerius, galima nurodyti,
# kuri iš išvardintų reikšmių yra formato parametras. Pavyzdžiui, jeigu skaičius
# e įrašytas pirmas, o formato parametras n -- antras, tada formatas "%1$.*2$f".

sprintf("Skaičius e apytiksliai lygus %1$.*2$f", e, 3)

# Tokiu pavidalu užrašytas formatas jau gana sunkiai skaitomas, bet, išnaudojant 
# reikšmių numeravimą, galima parametrizuoti ir kompaktiškai užrašyti sudėtingus 
# šablonus. Pavyzdžiui, užrašysime tokį šabloną, kuriame galima keisti sveikajam 
# skaičiui atvaizduoti skiriamų simbolių skaičių, t. y. m.n formato parametrą m,
# o skaičiaus priekyje būtų rašomi nuliai.

y <- 7

sprintf("Agentas %0*2$d", skaičius = y, m = 3)
sprintf("Agentas %1$0*2$d", skaičius = y, m = 2:4)

# Pavyzdžiui, sudarysime tokį šabloną, kad realų skaičių būtų galima atvaizduoti 
# su vis didėjančiu skaitmenų po kablelio skaičiumi.

phi <- 1.6180339887498948

sprintf("Skaičius %1$2d skaitmenų po kablelio tikslumu: %2$.*1$f", 1:15, phi)


# NAUDINGA ------------------------------

# F-ja sprintf paprastai naudojama įvairių informacinių pranešimų, kurių turinys
# skaičiavimų metu keičiasi, formavimui. Pavyzdžiui, atliekant ilgai trunkančius
# skaičiavimus, pravartu žinoti, kiek ciklo iteracijų atlikta.

N <- 10

for (i in 1:N) {

  # Įsivaizduojamas skaičiavimų blokas.
  Sys.sleep(runif(1))

  # Išvedame informaciją apie iteracijos numerį.
  info <- sprintf("%02d iteracija iš %d.", i, N)
  cat(info, "\n")
  flush.console()
}


# Užrašysime funkciją, kuri sekundėmis išmatuotą laiko intervalą užrašytų labiau
# įprastu HH:MM:SS formatu. Apskaičiuosime valandų, minučių ir sekundžių skaičių
# ir, naudojant funkciją sprintf, įstatysime gautas reikšmes į šabloną.

sec2time <- function(x) {

    x <- as.numeric(x)
  val <- x %/% 3600
    x <- x %% 3600
  min <- x %/% 60
  sek <- x %% 60

  sprintf("%02.f:%02.f:%02.f", val, min, sek)
}

sec2time(21.6)
sec2time(4017)


# Tokią funkciją galima įstatyti į ciklą ir išvesti informaciją apie skaičiavimų
# trukmę. Iš pradžių, naudojant funkciją difftime, apskaičiuojame laiko skirtumą 
# sekundėmis. Tada, naudojant f-ją sec2time, tą skirtumą perrašome kitu pavidalu
# ir įstatome į šabloną.

N <- 10
start <- Sys.time()

for (i in 1:N) {

  # Įsivaizduojamas skaičiavimų blokas.
  Sys.sleep(runif(1, 0, i))

  # Išvedame informaciją apie skaičiavimų laiką.
  stop <- Sys.time()
  secs <- difftime(stop, start, units = "secs")
  time <- sec2time(secs)
  info <- sprintf("%04d | t = %s", i, time)
  cat(info, "\n")
  flush.console()
}


# UŽDUOTIS ------------------------------ 

# 1. Duota realiųjų skaičių seka x. Užrašysime programą, kuri nubraižo pirmųjų n 
#    sekos narių kitimą laike, kur n įgyja reikšmes 1, 2, ..., 1000. Papildykite
#    programą taip, kad animuoto grafiko antraštėje būtų įrašoma besikeičianti n
#    reikšmė, kuriai pavaizduoti skirti keturi simboliai, priekyje rašomi nuliai.
#    
#    n <- 1000
#    x <- cumsum(rnorm(n))
#    for (i in 1:n) plot(x[1:i], type = "l", ylim = range(x), xlim = c(1, n))
#
# 2. Sudarykite tokią f-ją, kurios argumentas yra 1 x 2 dydžio dažnių lentelė, o
#    rezultatas yra tekstinis pranešimas, koks yra vienos iš reikšmių procentas.
#    Tarkime, duota dažnių lentelė: dd <- as.table(c(`FALSE` = 26, `TRUE` = 9)).
#    Tada pranešimas galėtų būti toks: "TRUE reikšmių yra 25.7 %".
