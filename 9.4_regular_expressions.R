
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Reguliarios išraiškos.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2016-04-19 | 2016-04-23 | 2016-04-30
#


# TURINYS -------------------------------

#
#   1. Teorinis reguliarių išraiškų pagrindimas:
#      * įvadas į baigtinių automatų teoriją
#      * Kleene teorema apie baigtinius automatus
#      * reguliarių išraiškų ryšys su automatais
#      * formalios kalbos ir formalios gramatikos
#
#   2. Reguliarių išraiškų sudarymo taisyklės:
#      * trumpai apie reguliarias išraiškų istoriją
#      * reguliarių išraiškų ir reguliarių kalbų ryšys
#      * reguliarių išraiškų sudarymo taisyklės
#      * operacijos su reguliariomis išraiškomis
#      * operatorių prioritetai ir savybės
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
# BAIGTINIAI AUTOMATAI, FORMALIOS KALBOS  #
# --------------------------------------- #

# Automatų teorija -- diskrečiosios matematikos šaka, nagrinėjanti matematiniais
# modeliais užrašomas abstrakčias skaičiavimo mašinas (jos vadinamos automatais)
# ir uždavinius, kuriuos jos gali spręsti. Automatas diskrečiais laiko momentais
# konvertuoja diskrečią informaciją ir žingsnis po žingsnio vykdydamas iš anksto
# užduotą algoritmą formuoja rezultatą. Šiuo atžvilgiu automatų teorija susijusi
# su algoritmų teorija. Atskirai galima paminėti baigtinius automatus. Tai tokie
# automatai, kurių vidinių būsenų aibė yra baigtinė. Baigtinis automatas įsimena
# savo būseną ir, priklausomai nuo veiksmo ir dabartinės būsenos, pereina į kitą
# būseną. 

# Norint detaliau aprašyti baigtinio automato veikimo principą, paaiškinsime kai
# kuriuos toliau tekste naudojamus terminus. Simboliu vadiname bet kokį nedalomą
# duomenų bloką. Dažniausiai simboliais laikomi natūralios kalbos rašto ženklai:
# raidės, skaičiai, skyrybos ženklai. Tačiau simboliai gali būti ir abstraktesni
# objektai, pavyzdžiui, grafiniai diagramos elementai. Alfabetas -- tai baigtinė
# skirtingų simbolių aibė. Žodis --- simbolių seka, gaunama apjungiant simbolius
# iš vieno alfabeto. Kalba --- tam tikro alfabeto pagrindu sudarytų žodžių aibė.
# Jei kalbą sudaro riboto ilgio žodžiai, tai jų aibė bus baigtinė, bet priešingu
# atveju gaunama begalinė aibė. Kalbą sudaro nebūtinai visi žodžiai, kuriuos tik
# įmanoma sudaryti iš tam tikro alfabeto simbolių, todėl bendru atveju kalba yra
# poaibis visų įmanomų vieno alfabeto žodžių aibės.

# Laikoma, kad baigtinis automatas pradeda darbą tam tikroje pradinėje būsenoje.
# Toliau nuosekliai skaitoma simbolių seka s_1 s_2 ... s_n, kuri vadinama įėjimo
# žodžiu. Kiekvienas nuskaitytas simbolis perveda automatą į naują būseną. Kokia
# bus nauja būsena, priklauso nuo dabartinės būsenos ir nuskaityto simbolio. Šią
# perėjimo iš būsenos į būseną taisyklę aprašo perėjimo funkcija. Taip automatas
# skaitydamas seką bei keisdamas būsenas nuskaito paskutinį simbolį ir patenka į
# tam tikrą būseną. Jeigu ši būsena yra iš leistinų baigtinių būsenos aibės, tai
# sakoma, kad nuskaityta simbolių seka (žodis) yra priimtina. 

# Apibendrintai baigtinis automatas užrašomas rinkiniu M = {A, Q, q, F, d}, kur:
#
#          A -- įėjimo simbolių aibė (alfabetas),
#          Q -- baigtinė vidinių būsenų aibė,
#          q -- pradinė būsena, q priklauso aibei Q,
#          F -- galutinių būsenų aibė, F yra aibės Q poaibis,
#          d -- perėjimo funkcija, kuri aprašo perėjimo į kitą būseną taisyklę.

# Baigtinį automatą galima atvaizduoti orientuotu grafu. Grafo viršūnės atitinka
# automato būsenas, o briauna, su jai priskirtu simboliu, atitinka parėjimą tarp
# dviejų būsenų. 

# Baigtiniai automatai skirstomi į deterministinius ir nedeterministinius. Jeigu
# automatui leidžiama pereiti į kitą būseną nenuskaičius simbolio arba iš vienos
# būsenos (nuskaičius tą patį simbolį) galima patekti į daugiau nei vieną būseną,
# tada toks automatas vadinamas nedeterministiniu. 

# Automatų teorija --- šiuolaikinės skaičiavimo technikos ir programinės įrangos
# pagrindas. Baigtiniai deterministiniai automatai naudojami sprendžiant plataus
# spektro uždavinius, pavyzdžiui:
#
#   -- automatizuotame elektronikos projektavime,
#   -- neurologinių sistemų ir jų veiklos aprašymui,
#   -- informacijos perdavimo protokolų sudarymui,
#   -- natūralios kalbos tekstų analizėje,
#   -- natūralios kalbos signalų atpažinime,
#   -- atliekant programinės įrangos testavimą,
#   -- nustatant algoritmų korektiškumą kriptografijoje,
#   -- projektuojant programavimo kalbas ir jų kompiliatorius.
#
# Kai kurie visiškai paprasti, o kartais ir gana sudėtingi mechaniniai įrengimai
# bei elektronikos prietaisai suprojektuoti taip, kad jie veiktų kaip baigtiniai
# automatai. Pavyzdžiui, šviesoforas, kavos aparatas ar pardavimų automatas.

# Buvo pasakyta, kad nuskaitytas žodis yra leistinas, jeigu jis automatą perveda
# į leistiną baigtinę būseną. Iš čia išplaukia dar bendresnė išvada: sakoma, kad
# kalba L priimama automato M, jeigu ji susideda iš alfabeto A pagrindu sudarytų
# žodžių, kurie automatą perveda į būsenas iš baigtinių būsenų aibės F. Teisinga
# ir tokia išvada, kad baigtinį automatą galima suprasti, kaip kalbos atpažinimo
# prietaisą.

# Automatų teorija glaudžiai susijusi su formalių kalbų teorija. Paaiškinsime šį
# ryšį. Iš pradžių suformuluosime tekste naudojamos formalios kalbos apibrėžimą.
# Formali kalba --- tai baigtinio ilgio simbolių iš baigtinio alfabeto sekų aibė.
# Taisyklės, pagal kurias sudaromos tokios simbolių sekos, vadinamos formaliomis
# taisyklėmis arba formalia gramatika. Formalias kalbas nagrinėja formalių kalbų 
# teorija. Jos naudojamos automatų teorijoje, algoritmų ir skaičiavimo teorijoje.

# Formalių kalbų teorijoje reguliari kalba yra tokia, kuri išreiškiama naudojant
# reguliaras išraiškas. Šis teiginys susieja reguliarias kalbas su reguliariomis
# išraiškomis, bet neatsako į klausimą, kas tai yra reguliari išraiška. Galutinį
# atsakymą duoda Kleene teorema, kuri susieja reguliarias išraiškas, reguliarias
# kalbas ir baigtinius automatus.

# Teorema. Tegul A yra baigtinis alfabetas. Šio alfabeto pagrindu sudaryta kalba 
# L yra reguliari tada ir tik tada, jei ji priimama tam tikro baigtinio automato.
# Įrodymas remiasi tuo, kad kiekvienai reguliariai išraiškai gali būti sudarytas 
# baigtinis automatas, kartai nedeterminuotas, atpažįstantis reguliaria išraiška 
# R užduotą kalbą. Vadinas, kiekvieną reguliarią kalbą galima sutapatinti su tam 
# tikru baigtiniu automatu. Iš čia seka galutinė išvada, kad reguliarių kalbų ir 
# kalbų, kurias atpažįsta baigtiniai automatai, klasės sutampa. 

# Galima paminėti, kad automatai paprastai klasifikuojami pagal formalios kalbos,
# kurią jie gali atpažinti, klasę. Visa automatų įvairovė gali būti aprašyta per
# taip vadinamą Chomskio hierarchiją, kuri aprašo ryšius tarp formalių gramatikų.
# Formalių kalbų teorijoje formali gramatika yra formalios kalbos aprašymo būdas.
# Jei tiksliau, gramatika nusako būdą, kaip iš visų alfabeto A pagrindu sudarytų 
# žodžių aibės išskirti tam tikrą poaibį, kurio elementai (žodžiai) ir sudaro ją 
# atitinkančią formalią kalbą L. Išskiriamos dviejų rūšių gramatikos: 
#
#   -- generuojančios,
#   -- atpažįstančios.

# Generuojanti gramatika yra toks taisyklių rinkinys, pagal kurį galima sudaryti 
# bet kokį kalbos žodį. Atpažįstanti arba analitinė gramatika leidžia nustatyti, 
# ar žodis priklauso tam tikrai kalbai, ar nepriklauso.


# --------------------------------------- #
# TRUMPAI APIE REGULIARIAS IŠRAIŠKAS      #
# --------------------------------------- #

# Reguliari išraiška --- pagal specialias taisykles sudaryta simbolių seka, kuri
# aprašo paieškos kitoje simbolių sekoje šabloną. Reguliarių išraiškų koncepcija
# atsirado apie 1950 m., kai matematikas Stephen'as Kleene formalizavo teorinėje
# informatikoje nagrinėjamų reguliarių kalbų apibrėžimą. Vienas iš UNIX sistemos
# kūrėjų Kenneth Thompson realizavo reguliarias išraiškas pirmame standartiniame
# UNIX tekstiniame redaktoriuje ed. Nuo to laiko reguliarios išraiškos tapo UNIX
# operacinės sistemos dalimi, kartu su tokiomis programomis kaip grep ar filter.
# Reg. išraiškos naudojamos specializuotose programavimo kalbose, kurios skirtos
# teksto skanavimui ir apdorojimui, pavyzdžiui, sed, awk ir perl. Jos palaikomos
# ir daugelyje bendro pobūdžio programavimo kalbų. Reguliarios išraiškos plačiai
# naudojamos teksto redaktoriuose tokiuose, kaip Emacs, vim. Kita svarbi taikymų
# sritis -- leksiniai analizatoriai programavimo kalbų kompiliatoriuose. 


# Formalių kalbų teorijoje reguliarios išraiškos aprašo reguliarias kalbas. Reg.
# išraiškos susideda iš konstantų ir operatorių. Iš konstantų sudaromos simbolių
# sekų aibės, o operatoriai aprašo operacijas, kurias galima atlikti su tų aibių
# elementais -- sekomis. Įsivesime kai kuriuos reguliarioms išraiškoms apibrėžti
# reikalingus terminus. 

# Tarkime, kad L ir K yra dvi kalbos. Jų sąjunga vadinsime aibę žodžių, kuri yra
# tas kalbas atitinkančių žodžių aibių sąjunga. Pavyzdžiui, kalba L = {001, 10},
# o K = {1, 001}. Tada šių kalbų sąjunga bus aibė {1, 001, 10}.

# Kalbų L ir K konkatenacija vadinsime aibę žodžių, kurie yra gauti prie aibės L
# žodžių prijungus aibės K žodžius. Pavyzdžiui, jei L = {001, 10}, K = {1, 001},
# tada jų konkatenacija yra aibė {0011, 101, 001001, 10001}.

# Kalbos L uždariniu L* vadinsime aibę tokių žodžių, kurie gauti visais galimais 
# būdais sujungus kalbos L žodžius. Žodžiai konkatenacijose gali kartotis norima 
# kiekį kartų, t.y. galima visų L laipsnių konkatenacija. Pvz., jeigu L = {0, 1}, 
# tai L* bus visų galimų iš nulių ir vienetų sudarytų žodžių aibė. Uždariniui L* 
# priklauso ir tuščias žodis "", kurį žymime e. Tuščios aibės uždarinys yra aibė,
# turinti tik vieną elementą -- tuščią žodį e.

# Dabar galime apibrėžti konstantas ir operatorius, kurie naudojami reguliariųjų
# išraiškų sudarymui. Tarkime, kad A yra baigtinis alfabetas. Tada reg. išraiškų 
# konstantos yra tokie objektai:
#
#          0 -- tuščia aibė,
#          e -- tuščias žodis,
#          a -- simboliai iš alfabeto A.
#
# Tegul R ir S yra reguliarios išraiškos. Tada joms apibrėžtos šitos operacijos:
#
#         RS -- sekų iš R ir S sujungimas (concatenation);
#        R|S -- sekų iš R ir S sąjunga (alternation);
#         R* -- sekų iš R uždarinys (Kleene star).


# Galima priminti, kad reguliari išraiška aprašo kalbą, o kalba yra žodžių aibė.
# Tarkime, kad L(R) nurodo kalbą, kurią aprašo reguliari išraiška R. Pagrindinės
# taisyklės nurodančios, kokias kalbas aprašo reguliarios išraiškos, yra tokios: 
#
#   -- L(a) = {a}, kiekvienam simboliui a iš alfabeto A;
#   -- L(e) = e;
#   -- L(0) = 0;
#   -- L(R|S) = L(R) U L(S);
#   -- L(RS) = L(R)L(S) = {ab | a iš R, b iš S};
#   -- L(R*) = {e} U {s_1 ... s_k | s_1, ..., s_k iš R}.

# Taigi, konkatenacija RS nurodo aibę tokių žodžių (sekų), kurie gaunami žodžius 
# iš kalbos, kurią aprašo reguliari išraiška R, prijungus prie žodžių iš kalbos, 
# kurią aprašo reguliari išraiška S. 

# Pvz., tarkime, kad išraiška R aprašo kalbą, kurios žodžių aibė yra {"ab", "c"}, 
# o reguliari išraiška S atitinka kalbą, kurios žodžių aibė {"d", "ef"}. Vadinas,
# konkatenacija RS = {"ab", "c"}{"d", "ef"} = {"abd", "abef", "cd", "cef"}.

# Taip R|S aprašo aibę, kuri yra reguliarias išraiškas R ir S atitinkančių kalbų
# sąjunga. Pavyzdžiui, jeigu R = {"ab", "c"}, o S = {"c", "bd"}, tai sąjunga R|S
# aprašo kalbą {"ab", "c", "bd"}.

# Liko dar viena operacija -- Klini žvaigždė. Išraiška R* aprašo aibę visų tokių
# žodžių, kuriuos galima gauti apjungiant bet kokį baigtinį skaičių kalbos, kuri
# aprašoma išraiška R, žodžių. Arba kitaip - R* aprašo kalbą, kurios žodžių aibė
# yra kalbos, kuria aprašo R, uždarinys. Pvz., jeigu R aprašo kalbą {"ab", "c"},
# tai R* aprašo kalbą {e, "ab", "c", "abab", "abc", "cab", "cc", "ababab", ...}.
# Galima dar kartą atkreipti dėmesį, kad tokiu būdu gautoje žodžių aibėje yra ir
# tuščias žodis e.

# Iš šių operacijų didžiausią prioritetą turi Klini žvaigždė, tada konkatenacija,
# o žemiausią prioritetą turi sąjunga. Kaip įprasta matematikoje, skliausteliais
# gali pakeisti veiksmų tvarką. Pvz., vietoje (ab)c galima rašyti abc, o vietoje  
# a|(b(c*)) galima rašyti a|bc*. Norint išraiškoje išvengti skliaustelių, galima 
# išnaudoti operatorių savybes. Konkatenacija ir sąjunga yra asociatyvios, todėl
# (ab)c = a(bc) = abc. Be to, sąjunga yra komutatyvi: a|b = b|a. O konkatenacija
# nekomutatyvi, kadangi žodžio prijungimas iš kairės ir iš dešinės bendru atveju 
# duoda skirtingus rezultatus, todėl ab != ba. Klini žvaigždė --- idempotentinis 
# operatorius, todėl R** = R*. Konkatenacijai ir sąjungai galioja distributyvumo
# dėsnis: (a|b)c = ac|bc.


# Dar kartą kitais žodžiais užrašysime taisykles, kurios nusako, kas tai yra reg. 
# išraiškos. Bet kuris atskirai paimtas alfabeto A elementas a yra reg. išraiška 
# a, apibrėžianti kalbą {a} --- aibę, kuri turi vienintelį elementą a. Konstanta 
# e (tuščias žodis "") yra reguliarioji išraiška, apibrėžianti kalbą {e}. Tuščią 
# aibę {} apibrėšime reguliaria išraiška 0. Jei R ir S yra reguliarios išraiškos, 
# tada RS taip pat yra reguliari išraiška, žyminti R ir S apibrėžiamų kalbų L(R) 
# ir L(S) sąjungą: L(R|S) = L(E) U L(F). Jeigu R ir S yra reguliarios išraiškos, 
# tada RS taip pat yra reguliari išraiška, žyminti R ir S apibrėžiamų kalbų L(E) 
# ir L(F) konkatenaciją: L(EF) = L(E)L(F). Jei R yra reguliarioji išraiška, tada 
# R* taip pat yra reg. išraiška, kuri žymi kalbos L(R) uždarinį: L(R*) = (L(E))*. 
# Jeigu R yra reguliarioji išraiška, tada (R) taip pat yra reguliarioji išraiška, 
# žyminti tą pačią kalbą, kurią apibrėžia ir E: L((E)) = L(E).


# Pavyzdžiui, išnagrinėsime, kokią žodžių aibę aprašo reguliari išraiška (a|b)c.
# Pagal apibrėžimą ši reguliari išraiška aprašo simbolių seką rs, kur r yra arba 
# raidė "a", arba raidė "b", o simbolis s yra raidė "c". Šią aibę užrašome taip:
#
#                    {rs | r iš ({"a"} U {"b"}), s iš {"c"}}
#
# Taigi, reguliari išraiška (a|b)c aprašo kalbą, kurios žodžių aibė {"ac", "bc"}.
# Užrašysime keletą paprasčiausių reguliarių išraiškų bei jas atitinkančių kalbų 
# žodžių aibes:
#
#          a -- {"a"}
#         ab -- {"ab"}
#      ac|bc -- {"ac", "bc"}
#      a|b|c -- {"a", "b", "c"}

# Užrašysime keletą reguliarių išraiškų su Klini žvaigžde bei atitinkančių kalbų 
# žodžių aibes:
#
#       a|b* -- {e, "a", "b", "bb", "bbb", ... }
#       ab*c -- {"ac", "abc", "abbc", "abbbc", ... }
#      (ab)* -- {e, "ab", "abab", "ababab", ...}
#     (a|b)* -- {e, "a", "aa", "aaa", ..., "b", "bb", "bbb", ... }
#       a*b* -- {e, "a", "b", "aa", "ab", "ba", "bb", "aaa", "aab", "abb", ...}
#     a*|ab* -- {e, "a", "aa", "aaa", ..., "ab", "abb", "abbb", ...}
#   (a|b)*aa -- {"aa", "aaa", "baa","abaa", ...}
#     (a*b)* -- {e, "b", "bb", ..., "ab", "abab", ..., "aab", "aabaab", ...}


# UŽDUOTIS ------------------------------ 

# 1. Užrašykite tokią reguliarią išraišką, kuri aprašo sekas, sudarytas iš nulių 
#    ir vienetų, kuriose iš pradžių yra bet kokio ilgio nulių serija, o užbaigia
#    tokią seką vienas vienetas. Pvz., 1, 01, 0000001 ir t.t.
# 2. Užrašykite reguliarią išraišką, kuri aprašo bet kokio ilgio sekas sudarytas
#    vien tik iš nulių arba vien tik iš vienetų.
# 3. Nustatykite, kokių žodžių aibę aprašo reguliari išraiška a) ab*c, b) a*|b*,
#    c) ab*|ac*, d) (a|b|c)*.
# 4. Pasakykite, kuo reguliaria išraiška ab*c aprašomi žodžiai skiriasi nuo reg.
#    išraiška abb*cd aprašomų žodžių?
# 5. Nustatykite, ar galima kitu būdu užrašyti reg. išraišką ab*|ac*. Jei galima,
#    tada kaip?
# 6. Sudarykite reguliarią išraišką, kuri aprašo kalbą, kurioje žodžiai baigiasi
#    galūne "as".
# 7. Sudarykite tokią reguliarią išraišką, kuri aprašo kalbą su tokiais žodžiais, 
#    kurie prasideda raide "n", o baigiasi galūne "as".
