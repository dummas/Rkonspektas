
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Veiksmai su duomenų lentelėmis naudojant paketą dplyr.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2015-08-22 | 2015-08-27
#


# TURINYS -------------------------------

#
#   1. Trumpai apie paketą dplyr:
#      * operatorius %>% 
#      * funkcija tbl_df
#      * funkcija glimpse
#
#   2. Stulpelių išrinkimas, pervadinimas ir perskaičiavimas:
#      * funkcija select
#      * funkcija rename
#      * funkcija mutate
#      * funkcija transmute
#
#   3. Eilučių išrinkimas ir išrikiavimas:
#      * funkcija slice
#      * funkcija top_n
#      * funkcija sample_n
#      * funkcija filter
#      * funkcija between
#      * funkcija distinct
#      * funkcija arrange 
#      * funkcija desc 
#
#   4. Sąlyginių charakteristikų skaičiavimas:
#      * funkcija count
#      * funkcija summarise
#      * funkcija summarise_each
#      * funkcija funs
#      * funkcija group_by
#      * funkcija groups 
#      * funkcija group_size 
#      * funkcija rowwise
#
#   5. Kai kurie tipiniai duomenų pertvarkymo atvejai:
#      * funkcija bind_rows 
#      * funkcija bind_cols 
#      * funkcija do 
#


# PASTABOS ------------------------------

#
# Jokių pastabų nėra.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuviška lokalė. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# Ištrinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# TRUMPAI APIE PAKETĄ DPLYR               #
# --------------------------------------- #

# Paketas dplyr naudojamas veiksmams su data.frame tipo duomenų lentelėmis ir jų
# pertvarkymui.

library(dplyr)

# Paprastai iš duomenų lentelės reikia išrinkti tam tikrus stulpelius ir eilutes,
# sugrupuoti jas bei apskaičiuoti įvairias statistines charakteristikas. Paketas
# dplyr kiekvienam iš šių veiksmų turi specializuotą funkciją. Pagrindinės iš jų:
#
#     select -- stulpelių išrinkimui,
#     mutate -- stulpelių reikšmių perskaičiavimui,
#     filter -- eilučių išrinkimui,
#    arrange -- eilučių išrikiavimui,
#  summarise -- stulpelių charakteristikų skaičiavimui.

# Visų šių funkcijų sintaksė praktiškai vienoda: pirmasis argumentas yra duomenų 
# lentelė, kiti argumentai -- nurodo eilutes ar stulpelius, su kuriais atliekami 
# atitinkami veiksmai. 

# Kadangi visų šių funkcijų rezultatas yra nauja duomenų lentelė, vieną po kitos 
# einančias duomenų pertvarkymo operacijas galima apjungti, nesukuriant tarpinių 
# lentelių - vienos funkcijos rezultatas yra kitos funkcijos argumentas. Veiksmų 
# apjungimas gali būti atliekamas dviem būdais: a) nesting, b) chaiting. 

# Pirmuoju atveju atliekama įprasta keletos funkcijų superpozicija, kai funkcija 
# įdedama viena į kitą, o antruoju -- argumentai nuo vienos funkcijos prie kitos
# perduodami konvejeriu. Galima pasakyti, kad konvejeris -- tai Unix ir Linux OS
# naudojama tam tikra funkcijos argumentų perdavimo forma, kada vienos funkcijos 
# reikšmė kaip argumentas perduodama kitai funkcijai. 

# R funkcijų konvejeriui užrašyti naudojamas operatorius %>% iš paketo magrittr, 
# kuris užkraunamas kartu su paketu dplyr. Reikia žinoti operatoriaus pritaikymo 
# taisykles. Tarkime, kad f yra tam tikra funkcija, x, y ir z yra jos argumentai. 
# Tada:
#                   x %>% f(y)       atitinka f(x, y)
#                   x %>% f(z, ., y) atitinka f(z, x, y)

# Pavyzdžiui, jeigu iš duomenų lentelės išrenkame eilutes, o iš gautos rezultatų
# lentelės vėliau išrenkame tam tikrus stulpelius, tai tokią veiksmų seką galima
# užrašyti taip:
#                      select(filter(duomenys, ...), ...)
#
# Naudojant konvejerį, ta pati veiksmų seka užrašoma tokiu pavidalu:
# 
#                   duomenys %>% filter(...) %>% selec(...)


# Daugelio paketo dplyr funkcijų argumentas yra data.frame tipo duomenų lentelė.
# Tačiau, analizuojant labai daug eilučių turinčias lenteles, geriau konvertuoti
# jas į tbl_df formatą. Galima sakyti, kad tai savotiškas data.frame apvalkalas,
# kuris apsaugo nuo didelio kiekio duomenų išvedimo į ekraną.

airquality. <- tbl_df(airquality)
airquality.

# Į ekraną išvedamų eilučių skaičių galima koreguoti.

print(tbl_df(airquality.), n = 20)

# Jei duomenų lentelė turi labai daug stulpelių, jiems apžvelgti galima naudoti
# funkciją glimpse, kuri transponuoja lentelę, stulpeliai vaizduojami eilutėse.

glimpse(airquality.)

# tbl_df tipo lentelė tuo pačiu yra ir data.frame tipo lentelė.

class(airquality.)

# Funkcija tbl_df nedaro pradinės lentelės stulpelių kopijų. Taip pat elgiasi ir 
# funkcijos select bei mutate, todėl stulpelių išrinkimas bei jų perskaičiavimas
# atliekamas labai greitai -- tai svarbu dirbant su didelės apimties duomenimis.


# --------------------------------------- #
# STULPELIŲ IŠRINKIMAS IR PERVADINIMAS    #
# --------------------------------------- #

# Stulpelių išrinkimui naudojama funkcija select, o jos sintaksė labai paprasta:
# 
#                           select(duomenys, ...)
#
# Čia ... nurodo vieną arba kelis kableliu atskirtus stulpelių pavadinimus. Tam,
# kad stulpelius būtų galima išrinkti pagal tam tikrą taisyklę, naudojamos kitos
# papildomos funkcijos:
#
#       one_of -- kintamųjų iš sąrašo išrinkimui,
#  starts_with -- išrinkimui pagal pavadinimo pradžią,
#    ends_with -- išrinkimui pagal pavadinimo pabaigą,
#     contains -- išrinkimui pagal sutampantį žodį,
#      matches -- išrinkimui pagal reguliarią išraišką,
#    num_range -- išrinkimui pagal kintamųjų numerius,
#   everything -- visų kintamųjų išrinkimui.


# Pavyzdžiui, iš duomenų lentelės airquality išrinksime kintamuosius su vardais 
# "Temp", "Month", "Day". Funkcijos viduje stulpelių vardai interpetuojami kaip 
# lentelės aplinkos kintamieji, todėl rašomi be kabučių.

select(airquality, Temp, Month, Day)

# Tuo atveju, kada išrenkami stulpeliai eina iš eilės, jų vardus galima nurodyti
# per dvitaškį -- lyg generuojant skaičių seką.

select(airquality, Temp:Day)

# Tokį stulpelių vardų vektorių kaip parametrą galima perduoti funkcijai one_of.

kintamieji <- c("Temp", "Month", "Day")
select(airquality, one_of(kintamieji))


# Tuo atveju, kai yra žinoma, kokiu simboliu arba žodžiu prasideda arba baigiasi 
# stulpelių pavadinimai, patogu naudoti funkciją starts_with ir ends_with. Pvz.,
# išrinksime stulpelius su pradžia "Oz" ir pabaiga "th".

select(airquality, starts_with("Oz"))
select(airquality, ends_with("th"))

# Jei žinomas stulpelio pavadinimo fragmentas, galima naudoti funkciją contains.
# Pavyzdžiui, išrinksime stulpelius, kurių pavadinime yra raidžių junginys "on".

select(airquality, contains("on"))


# Stulpelius galima išrinkti ir pagal abstraktesnę taisyklę. Kartais tai būtina,
# kadangi stulpelių pavadinimų gali būti labai daug arba jie iš anksto nežinomi. 
# Tais atvejais, kai visiems vardams būdingas tam tikras šablonas, jų išrinkimui 
# galima naudoti reguliarias išraiškas. Pavyzdžiui, taip galima išrinkti vardus,
# kurie turi raidės ir trijų skaitmenų kodą, arba vardus iš dviejų dalių, kurios
# atskirtos brūkšneliu, arba vardus, kuriuose nėra tam tikros raidės ir panašiai.

# Pavyzdžiui, lentelėje airquality išrinksime tuos stulpelius, kurių pavadinime
# yra taškas. Čia problema tame, kad taško simbolis "." reguliariose išraiškose
# nurodo bet kokį simbolį, todėl šiuo atveju reikia rašyti "\\." -- bus randami
# visi vardai, kuriuose bet kurioje pavadinimo vietoje yra taškas.

select(airquality, matches("\\."))

# Jei taškas stulpelio pavadinime atskiria du bet kokio ilgio žodžius, reguliari 
# išraiška rašoma šiek tiek kitaip. Šiuo atveju rezultatas sutampa.

select(airquality, matches("^[a-z,A-Z]+\\.[a-z,A-Z]+$"))

# Pavyzdžiui, išrinksime stulpelius, kurių pavadinime yra raidžių junginys "on"
# arba "ol". Atskirai vienam ir kitam atvejui tinka f-ja contains, tačiau abiem
# kartu užrašyti naudojama nesudėtinga reguliari išraiška.

select(airquality, matches("o[n,l]"))


# Jeigu stulpeliai turi būti pašalinti, prieš jų vardų vektorių rašomas minusas.
# Gali būti naudojamos tos pačios pagalbinės f-jos one_of, starts_with ir kitos.
# Pvz., čia pateikti keli lygiaverčiai trijų stulpelių pašalinimo variantai.

select(airquality, -c(Ozone, Wind, Solar.R))
select(airquality, -Ozone, -Wind, -Solar.R)
select(airquality, -one_of(c("Ozone", "Wind", "Solar.R")))


# Jei išrinktam stulpeliui reikia pakeisti pavadinimą, tai rašoma lygybė, kurios
# kairėje pusėje yra naujas vardas, o dešinėje -- senasis. Pavyzdžiui, pakeisime
# vieno pasirinkto kintamojo vardą.

select(airquality, Solar = Solar.R)

# Kintamųjų vardus galima pervadinti pagal šabloną. Pavyzdžiui, išrinksime visus
# lentelės airquality stulpelius ir jų vardus pakeisime į "x1", "x2", ..., "x6".

select(airquality, x = everything())


# Funkcija rename naudojama atskirų duomenų lentelės stulpelių vardų pakeitimui.
# Visų kitų stulpelių vardai išlieka tokie patys. Pavyzdžiui, pakeisime lentelės
# airquality stulpelio "Solar.R" pavadinimą į paprastesnį.

rename(airquality, Solar = Solar.R)

# Stulpelių perskaičiavimui naudojama funkcija mutate. Pvz., lentelės airquality
# kintamojo Temp reikšmes perskaičiuosime iš Farenheito į Celcijaus skalę. 

mutate(airquality, Temp = 5*(Temp - 32)/9)

# Naudojant šią funkciją, lentelėje galima sukurti naujus stulpelius. Pavyzdžiui,
# lentelėje airquality sukursime naują stulpelį su eilučių numeriais.

mutate(airquality, Nr = 1:153)

# Bendras eilučių skaičius duomenų lentelėje yra fiksuotas, bet, išskaidžius jas
# į tam tikras grupes, eilučių skaičius grupėse iš anksto dažniausiai nežinomas. 
# Paketo dplyr funkcija n() grąžina eilučių skaičių duomenų lentelės grupėje. Šį 
# kartą eilutės negrupuojamos, todėl rezultatas yra bendras eilučių skaičius.

mutate(airquality, Nr = 1:n())

# Funkcija transmute skiriasi tuo, kad stulpeliai su perskaičiuotomis reikšmėmis
# išskiriami į atskirą lentelę.

transmute(airquality, Temp = 5*(Temp - 32)/9)


# UŽDUOTIS ------------------------------ 

# 1. Iš duomenų lentelės airquality išrinkite stulpelius su eilės numeriais 1, 5
#    ir 6. Užduočiai atlikti naudokite paketo dplyr funkciją select.
# 2. Užrašykite komandą, kuri iš duomenų lentelės iris išrenka stulpelius, kurių
#    pavadinimas prasideda žodžiu "Petal" ir juos pervadina pagal naują šabloną.


# --------------------------------------- #
# EILUČIŲ IŠRINKIMAS IR IŠRIKIAVIMAS      #
# --------------------------------------- #

# Lengviausias būdas išrinkti duomenų lentelės eilutes - pagal jų numerius. Šiuo 
# atveju galima naudoti paketo dplyr funkciją slice. Jos argumentas yra lentelės
# pavadinimas ir kitas argumentas - eilučių numerių vektorius. Pvz., iš lentelės 
# airquality išskirsime pirmą eilutę.

slice(airquality, 1)

# Galima nurodyti kelių eilučių numerių vektorių. Pavyzdžiui, išskirsime 5, 6 ir 
# 20-ą eilutes.

slice(airquality, c(5, 6, 20))

# Jeigu reikalingas bendras lentelės eilučių skaičius, galima panaudoti funkciją
# n(). Pavyzdžiui, išskirsime paskutines eilutes pradedant nuo šimtosios.

slice(airquality, 100:n())


# Norint iš kiekvienos lentelės grupės išskirti kelias pirmąsias eilutes, galima
# naudoti funkciją top_n. Pavyzdžiui, iš lentelės airquality išrinksime pirmas 3 
# eilutes.

top_n(airquality, 3)


# Paprastoji atsitiktinė imtis iš lentelės eilučių išrenkama naudojant funkcijas
# sample_n bei sample_frac. Pirmuoju atveju nurodomas konkretus eilučių skaičius,
# antruoju -- dalis nuo lentelės eilučių skaičiaus. Pvz., iš lentelės airquality
# atsitiktine tvarka be pasikartojimų išrinksime 10 eilučių.

sample_n(airquality, 10)

# Jeigu išrenkamos eilutės gali kartotis, tai parametro replace reikšmę keičiame
# į TRUE.

sample_n(airquality, 10, replace = TRUE)


# Duomenų analizės praktikoje dažnai reikia išrinkti eilutes, kurios tenkina tam
# tikrą loginę sąlygą. Tokiu atveju galima naudoti paketo dplyr funkciją filter.
# Pavyzdžiui, iš lentelės airquality išskirsime tas eilutes, kur kintamojo Temp 
# reikšmė didesnė už 90.

filter(airquality, Temp > 90)


# Jei reikia išskirti duomenų lentelės eilutes, kuriose vieno stulpelio reikšmės 
# patenka į tam tikrą intervalą, galima panaudoti paketo dplyr funkciją between. 
# Jos sintaksė:
#                         between(x, left, right)
# 
# Čia x yra skaitinis vektorius, o left ir right reikšmių intervalo galai. Pvz.,
# išskirsime eilutes, kurių stulpelio Temp reikšmės patenka į intervalą [50, 60].

filter(airquality, between(Temp, 50, 60))

# Kitas pavyzdys, surasime tas eilutes, kurios stulpelyje Ozone turi NA reikšmę.

filter(airquality, is.na(Ozone))


# Gana dažnas uždavinys -- pašalinti iš lentelės pasikartojančias eilutes. Tokiu
# atveju galima naudoti naudoti standartinę R funkciją unique ar analogišką f-ją 
# distinct iš paketo dplyr. Pvz., lentelėje airquality paliksime tik tas eilutes, 
# kurios turi unikalias reikšmes stulpelyje Temp.

distinct(airquality, Temp)


# Kartais duomenų lentelės eilutes reikia išrikiuoti kintamojo reikšmių didėjimo 
# ar mažėjimo tvarka. Tokių kintamųjų gali būti vienas, bet gali būti ir daugiau.
# Eilučių išrikiavimui galima naudoti paketo dplyr funkciją arrange. Pavyzdžiui, 
# lentelės mtcars eilutes išrikiuosime kintamojo cyl (variklio cilindrų skaičius)
# reikšmių didėjimo tvarka.

arrange(mtcars, cyl)

# Standartiškai kintamojo reikšmės išrikiuojamos didėjimo tvarka. Naudojant f-ją
# desc, kintamojo reikšmės transformuojamos taip, kad funkcija arrange išrikiuos 
# eilutes to kintamojo reikšmių mažėjimo tvarka. Pavyzdžiui, pagal kintamąjį cyl
# jau išrikiuotą lentelę dar kartą išrikiuosime kintamojo disp reikšmių mažėjimo 
# tvarka.

arrange(mtcars, cyl, desc(disp))


# UŽDUOTIS ------------------------------ 

# 1. Iš duomenų lentelės iris išrinkite tik tas eilutes, kurios priklauso rūšiai
#    "versicolor".
# 2. Iš duomenų lentelės airquality išrinkite tik tas eilutes, kuriose stulpelio 
#    Temp reikšmė didesnė už 90, o stulpelio Wind reikšmė didesnė už 5. Komandas
#    užrašykite dviem variantais: naudojant paketo dplyr ir standartines R f-jas.
# 3. Iš duomenų lentelės airquality išrinkite eilutes, kurios atitinka mažiausią
#    temperatūrą turinčias tris birželio mėnesio dienas.
# 4. Nustatykite, kokias reikšmes įgijo lentelės airquality kintamasis "Solar.R"
#    eilutėse, kuriose kintamojo "Temp" reikšmės didesnės už 90.
# 5. Iš lentelės iris atsitiktine tvarka be pasikartojimų išrinkite 25 % eilučių.
#    Gautą lentelę išrikiuokite kintamojo Sepal.Length reikšmių mažėjimo tvarka.


# --------------------------------------- #
# SĄLYGINIŲ CHARAKTERISTIKŲ SKAIČIAVIMAS  #
# --------------------------------------- #

# Imties elementų dažnis gali būti nustatytas naudojant paketo dplyr f-ją count.
# Jos sintaksė:
#                               count(x, ...)
#
# Čia x yra duomenų lentelė, vietoje ... rašome vieną ar keli kableliu atskirtus
# stulpelių pavadinimus, kurių reikšmių dažniai ir bus apskaičiuoti. Pavyzdžiui,
# apskaičiuosime lentelės airquality stebinių skaičių atskirai kiekvieną mėnesį.

count(airquality, Month)

# Jei nurodomas daugiau nei vienas kintamasis, sudaroma kryžminė dažnių lentelė.
# Vietoje lentelės stulpelio vardo galima įrašyti tam tikrą loginę sąlygą. Pvz.,
# nustatysime, kiek buvo atvejų, kai kintamojo Temp reikšmė viršijo 70 laipsnių, 
# o Wind reikšmė didesnė už 10 m/s.

count(airquality, T = Temp > 70, W = Wind > 10)


# Vienas iš tipinių veiksmų -- vieno ar kelių lentelės stulpelių charakteristikų
# skaičiavimas. Tai gali būti kintamųjų vidurkiai, elementų skaičius ir panašios
# charakteristikos. Šiam tikslui galima naudoti paketo dplyr funkciją summarize.
# Jos sintaksė:
#                             summarise(x, ...)
#
# Čia x yra duomenų lentelė, o vietoj ... rašoma viena ar kelios lygybės, kurios 
# dešinėje pusėje rašoma tam tikrą stulpelio charakteristiką skaičiuojanti f-ja,
# o kairėje rašomas tos charakteristikos pavadinimas. Pavyzdžiui, apskaičiuosime
# lentelės airquality stulpelio Temp vidurkį ir dispersiją.

summarise(airquality, Temperatūra = mean(Temp), Dispersija = var(Temp))


# Labai dažnai reikia apskaičiuoti tam tikras stulpelių charakteristikas grupėse
# pagal kito kintamojo reikšmes. Lentelės eilučių grupavimui galima naudoti f-ją
# group_by. Jos argumentais yra duomenų lentelė ir grupavimo kintamojo vardas, o
# rezultatas yra į grupes suskaidyta lentelė, kurią ją galima perduoti funkcijai 
# summarize.

G <- group_by(airquality, Month)
G

# Funkcija groups parodo, pagal kokį kintamąjį yra sugrupuotos lentelės eilutės,
# o funkcija group_size parodo, kokio dydžio yra grupės.

groups(G)
group_size(G)

# Pavyzdžiui, apskaičiuosime stulpelio Temp vidurkį ir dispersiją atskirai pagal
# mėnesius.

summarise(G, Temperatūra = mean(Temp), Dispersija = var(Temp))

# Grupavimo kintamasis gali būti sudarytas dirbtinai. Pavyzdžiui, apskaičiuosime
# temperatūros vidurkį ir dispersiją grupėse pagal vėjo greitį. Čia jų sudarymui
# panaudosime standartines R funkcijas cut ir pretty.

G <- group_by(airquality, Wind = cut(Wind, pretty(Wind)))
summarise(G, Temperatūra = mean(Temp), Dispersija = var(Temp))

# Eilučių grupavimas gali būti atliekamas ir pagal tam tikrą loginę sąlygą. Pvz.,
# suformuosime dvi grupes pagal tai, ar vėjo greitis didesnis už savo vidurkį ar 
# ne. Šiose grupėse apskaičiuosime temperatūros vidurkį ir dispersiją.

G <- group_by(airquality, Wind = Wind > mean(Wind))
summarise(G, Temperatūra = mean(Temp), Dispersija = var(Temp))


# Kadangi paketo dplyr funkcija n() grąžina eilučių skaičių lentelėje, naudojant 
# ją kartu su funkcijomis group_by ir summarize, galima sudaryti dažnių lentelę. 
# Pavyzdžiui, apskaičiuosime, kiek praleistų reikšmių turi airquality kintamasis 
# Ozone.

summarise(group_by(airquality, is.na(Ozone)), Freq = n())


# Dažnai tą pačią skaitinę charakteristiką reikia apskaičiuoti iš karto keliems 
# stulpeliams. Tokiu atveju patogiau naudoti funkciją summarise_each. Sintaksė:
#
#                     summarise_each(x, funs(), ...)
#
# Čia x yra duomenų lentelė, kuri gali būti ir grupuota, funs yra speciali f-ja,
# kuri leidžia suformuoti funkcijų sąrašą, o vietoje ... rašomi stulpelių vardai.
# Jei kintamieji nenurodomi, tai charakteristikos skaičiuojamos visiems išskyrus
# grupavimo kintamąjį. Pavyzdžiui, apskaičiuosime kintamųjų Temp, Wind vidurkius 
# kiekvienam mėnesiui atskirai.

summarise_each(group_by(airquality, Month), funs(mean), Temp, Wind)

# Funkcijų, kurių reikšmes reikia apskaičiuoti, sąraše gali būti ne viena. Pvz., 
# apskaičiuosime tų pačių stulpelių reikšmių vidurkį ir dispersiją.

summarise_each(group_by(airquality, Month), funs(mean, var), Temp, Wind)

# Apskaičiuotoms stulpelių charakteristikoms galima suteikti vardus. Pavyzdžiui,
# rezultatų stulpeliai su vidurkio reikšmėmis turės priesagą E, o dispersijos D.

summarise_each(group_by(airquality, Month), funs(E = mean, D = var), Temp, Wind)

# Tuo atveju, kai stulpelio charakteristiką skaičiuojanti funkcija pati dar turi
# kokių nors parametrų, stulpelį atitinkantis parametrus joje žymimas tašku. Šią
# situaciją galima pailiustruoti tokiu pavyzdžiu: reikia apskaičiuoti airquality
# lentelės stulpelio Ozone vidurkį. Šiame stulpelyje yra NA reikšmių, todėl tam, 
# kad būtų galima apskaičiuoti vidurkį, reikia pakeisti funkcijos mean parametro 
# na.rm reikšmę iš FALSE į TRUE.

summarise_each(group_by(airquality, Month), funs(mean(., na.rm=T)), Ozone, Wind)


# NAUDINGA ------------------------------

# Galima pastebėti, kad visi veiksmai duomenų lentelėje atliekami su stulpeliais. 
# Funkcijų mutate ir summarise argumentas yra visos lentelės stulpelis arba, jei 
# lentelė yra grupuota, - tam tikrai eilučių grupei priklausanti stulpelio dalis.

# Kartais tuos pačius veiksmus reikia atlikti su visomis lentelės eilutėmis. Tai
# gali būti, pavyzdžiui, maksimalios reikšmės suradimas eilutėje. Pvz., surasime
# maksimumą iš kintamųjų Sepal.Length, Petal.Length reikšmių kiekvienai lentelės
# iris eilutei.

# Vienas galimas būdas -- kiekvieną lentelės eilutę sutapatinti su atskira grupe.
# Grupavimas atliekamas naudojant funkciją group_by, o grupės sutampa su eilučių
# numeriais.

summarise(group_by(iris, Nr. = 1:n()), max = max(Sepal.Length, Petal.Length))

# Kitas būdas -- naudoti specialiai tokiam atvejui skirtą dplyr funkciją rowwise.

summarise(rowwise(iris), max = max(Sepal.Length, Petal.Length))

# Tą pačią komandą užrašysime naudojant operatorių %>%.

iris %>% rowwise() %>% summarise(max = max(Sepal.Length, Petal.Length))


# UŽDUOTIS ------------------------------ 

# 1. Apskaičiuoti lentelės airquality kintamojo Ozone praleistų reikšmių skaičių 
#    atskirai kiekvienam mėnesiui. Užrašykite komandą naudojant šią paketo dplyr
#    funkciją: a) count, b) n().
# 2. Naudodami lentelę airquality, nustatykite kiekvieno mėnesio kintamojo Ozone 
#    vidurkį, kai temperatūra svyruoja intervale [70, 80].
# 3. Lentelėje airquality iš kiekvieno mėnesio išskirkite po pirmas dvi eilutes.
#    Užrašykite 2 komandos versijas: a) su funkcija top_n, b) su funkcija slice.
# 4. Iš lentelės airquality išskirkite po dvi kiekvieno mėnesio eilutes, kuriose
#    didžiausios to mėnesio stulpelio Temp reikšmės išrikiuotos mažėjimo tvarka.


# --------------------------------------- #
# KELI TIPINIAI DUOMENŲ ANALIZĖS ATVEJAI  #
# --------------------------------------- #

# Paprastai duomenų lentelės pertvarkymas susideda iš kelių žingsnių: eilučių ir
# stulpelių išrinkimo, grupių atskyrimo, tam tikrų charakteristikų šiose grupėse
# skaičiavimo ir rezultatų apjungimo. Labai dažnai šiuos etapus tenka pakartoti,
# priklausomai nuo situacijos atsisakyti kai kurių etapų, keisti jų eiliškumą ir
# panašiai. Užrašysime keletą tipinių duomenų pertvarkymo pavyzdžių. 

# Lentelėje airquality surašyti kelių mėnesių meteorologinių stebėjimų duomenys.
# Apskaičiuosime kiekvieno mėnesio temperatūros vidurkį.

summarise(group_by(airquality, Month), vidurkis = mean(Temp))

# Naudojant operatorių %>%, tą pati komanda užrašoma tokiu būdu:

airquality %>% group_by(Month) %>% summarise(vidurkis = mean(Temp))

# Iš esmės tokį pat rezultatą galime gauti ir naudojant standartines R funkcijas
# tapply, by ir aggregate -- skiriasi tik rezultatų išvedimo forma.

with(airquality, tapply(Temp, Month, mean))
with(airquality, by(Temp, Month, mean))
with(airquality, aggregate(Temp, list(rūšis = Month), mean))


# Ši split-apply-combine schema nesunkiai realizuojama naudojant standartines R
# funkcijas:
#                                      split 
#                                      |   |
#                                 sapply   lappy
#                                              |
#                                              stack

      sapply(with(airquality, split(Temp, Month)), mean) 
stack(lapply(with(airquality, split(Temp, Month)), mean))

# Tos pačios komandos užrašytos naudojant %>% operatorių:

airquality %>% with(split(Temp, Month)) %>% sapply(mean)
airquality %>% with(split(Temp, Month)) %>% lapply(mean) %>% stack


# --------------------------------------- #

# Pavyzdžiui, naudojant lentelės airquality duomenis, nustatysime kiekvieno mėn.
# dieną su mažiausia to mėnesio temperatūra.

select(filter(group_by(airquality, Month), Temp == min(Temp)), Month, Day, Temp)

# Vietoje funkcijos filter galima naudoti f-jas slice ir which.min. Tokiu atveju
# vietoje loginės sąlygos f-jai slice nurodomas konkretus eilutės numeris, todėl
# gaunama trumpesnė ir aiškesnė komanda.

select(slice(group_by(airquality, Month), which.min(Temp)), Month, Day, Temp)

# Naudojant operatorių %>%, šios dvi komandos užrašomos taip:

airquality %>% 
           group_by(Month) %>% 
                           filter(Temp == min(Temp)) %>% 
                                                     select(Month, Day, Temp)
airquality %>% 
           group_by(Month) %>% 
                           slice(which.min(Temp)) %>% 
                                                  select(Month, Day, Temp)

# Naudojant standartines R funkcijas split ir lapply, duomenų lentelė iš pradžių
# padalinama į grupes, vėliau iš kiekvienos grupės išrenkami reikiami stulpeliai
# ir reikiamos eilutės. Kadangi galutinėje lentelėje lieka datos ir temperatūros
# kintamieji, nereikalingų stulpelių galima atsisakyti lentelės grupavimo etape.
# Šiuo atveju funkcijos lapply rezultatas yra data.table tipo duomenų lentelė su 
# viena eilute. Į galutinę lentelę jas apjungiame naudojant do.call konstrukciją
#
#                              do.call(f, x)
#
# Čia x yra list tipo sąrašas, o f yra funkcija, kurios argumentai ir yra sąraše.
# Atskiros eilutės į vieną data.frame lentelę apjungiamos naudojant R f-ją rbind.

G <- with(airquality, split(airquality[, c("Month", "Day", "Temp")], Month))
do.call(rbind, lapply(G, subset, subset = Temp == min(Temp)))

# Vietoje konstrukcijos do.call(rbind, ... ) eilučių iš sąrašo apjungimui galima
# naudoti paketo dplyr funkciją bind_rows.

bind_rows(lapply(G, subset, subset = Temp == min(Temp)))


# NAUDINGA ------------------------------

# Tarkim, kad reikia apskaičiuoti kiekvieno mėnesio santykinį praleistų reikšmių
# dažnį lentelės airquality stulpelyje Ozone. Tokiu atveju paprasčiausia naudoti 
# standartinę R funkciją tapply ir skaičiuoti reikšmių NA indikatoriaus vidurkį.  

with(airquality, tapply(Ozone, Month, function(x) mean(is.na(x), na.rm = TRUE)))

# Kitas būdas -- naudojant f-ją split, išskaidyti kintamąjį Ozone į grupes, tada,
# turint grupių sąrašą, naudojant f-ją sapply, apskaičiuoti jose santykinį dažnį.

G <- with(airquality, split(Ozone, Month))
sapply(G, function(x) mean(is.na(x), na.rm = TRUE))

# Abiem atvejais santykinio dažnio apskaičiavimui reikia užrašyti anoniminę f-ją.
# Naudojant operatorių %>% galima sutrumpinti jos užrašymą, kadangi taškas prieš
# operatorių %>% sukuria tokią funkciją. Užrašysim naują komandos su f-ja tapply 
# variantą:

with(airquality, tapply(Ozone, Month, . %>% is.na %>% mean(na.rm = TRUE)))


# PASTABA! Šią komandą galima užrašyti visai be anoniminės funkcijos. Tam reikia
# į grupes skaidyti ne pradinį kintamąjį Ozone, o iš karto funkciją is.na(Ozone), 
# kurios reikšmės perduodamos standartinei funkcijai mean su parametru na.rm.

with(airquality, tapply(is.na(Ozone), Month, mean, na.rm = TRUE))


# NAUDINGA ------------------------------

# Pagrindines duomenų pertvarkymo funkcijas papildo bendro pobūdžio funkcija do, 
# kuri leidžia pritaikyti bet kokią funkciją atskiroms duomenų lentelės grupėms.

# Pavyzdžiui, iš kiekvienos lentelės iris kintamojo Species grupės išskirsime po
# tris pirmas eilutes. Pirmuosius n vektoriaus elementų ar lentelės eilučių rodo
# standartinė R funkcija head. Užrašysime tokią komandą naudojant operatorių %>%.

iris %>% group_by(Species) %>% do(head(., 3))

# Viena iš f-jos do pritaikymo sričių -- statistinių modelių sudarymas atskiroms 
# duomenų grupėms. Pvz., įvertinsime paprastosios tiesinės regresijos modelio
#
#                               y = a + b*x + e
#
# parametrus a ir b, atskirai kiekvienai lentelės iris kintamojo Species grupei.
# Tarkime, kad čia y yra kintamasis Sepal.Length, o x --- kintamais Sepal.Width.
# Užrašysime tokią komandą naudojant operatorių %>%. Trumpas komentaras - taškas 
# išraiškoje data = . nurodo, kad modelio duomenys bus viena lentelės iris grupė.
# Kadangi kintamasis Species turi tris skirtingas reikšmes, grupių irgi bus trys 
# ir todėl gausime tris to paties modelio parametrų rinkinius.

M <- iris %>% 
          group_by(Species) %>% 
                            do(reg = lm(Sepal.Length ~ Sepal.Width, data = .))

# Gautos duomenų lentelės M elementai yra tiesinės regresijos modeliai. Tai gana
# neįprasta, kadangi įprasta, jog duomenų lentelės stulpeliai yra to paties tipo 
# reikšmes turintys vektoriai. Tačiau čia prieštaravimo nėra, kadangi stulpeliai
# duomenų lentelėje yra list tipo sąrašai, o sąrašai tuo pačiu yra ir vektoriai.

M

# Norint iš gautos lentelės ištraukti modelių parametrus, naudosime standartines
# funkcijas. Pavyzdžiui, modelio koeficientus grąžina funkcija coef. Šiuo atveju
# pirmas koeficientas atitinka parametrą a, antras - parametrą b. Šios funkcijos
# argumentas bus statistinis modelis, kuris yra lentelės M stulpelio reg reikšmė.

summarise(M, grupė = Species, a = coef(reg)[1], b = coef(reg)[2])

# Gautų modelių parametrus galima apjungti į vieną data.frame lentelės stulpelį. 
# Šiuo atveju funkciją data.frame įdėsime į funkciją do. Čia galima pakomentuoti:
# taškas išraiškoje coef(.$reg) nurodo lentelės M eilutę, o .$reg nurodo eilutės
# elementą stulpelyje reg, o tai jau yra tiesinės regresijos modelis. Jį įdedame
# į funkciją coef ir gauname modelio parametrų vektorių, šiuo atveju tai a ir b.
# Kadangi tokių eilučių lentelėje M yra trys, tai galutinėje lentelėje jų bus 6.

do(M, data.frame(rūšis = .$Species, param = c("a", "b"), reikšmė = coef(.$reg)))


# Turint statistinį modelį, įvairios jo charakteristikos gaunamos naudojant f-ją
# summary. Pvz., nustatysime visų 3 modelių determinacijos koeficiento reikšmes.

summarise(M, R = summary(reg)$r.squared)

# Funkcija summary suformuoja lentelę su modelio parametrais, jų std. nuokrypiu,
# hipotezės apie jų lygybės nuliui statistika ir tos hipotezės p-reikšme. Tokias
# lenteles apjungsime į vieną bendrą data.frame tipo lentelę.

do(M, data.frame(rūšis = .$Species, param = c("a", "b"), coef(summary(.$reg))))


# UŽDUOTIS ------------------------------ 

# 1. Iš lentelės airquality išskirkite po pirmas tris kiekvieno mėnesio eilutes.
#    Užrašykite šią komandą naudojant paketo dplyr funkcijas bei operatorių %>%.
#    Sugalvokite, kaip išspręsti šią užduoti naudojant standartines R funkcijas.
# 2. Naudojant lentelės airquality duomenis, nustatykite, kurio mėnesio pirmų 15
#    dienų temperatūros vidurkis didžiausias. Užrašykite komandą naudojant dplyr
#    funkcijas ir perrašykite ją naudojant %>% operatorių.
# 3. Užrašykite funkciją, kuri nustatytų, kokios trys dažniausiai pasitaikančios
#    kintamojo Petal.Length reikšmės būdingos kiekvienai lentelės iris kintamojo
#    Species reikšmei.
# 4. Naudojant duomenų lentelę iris, nustatykite, kuriai augalų rūšiai vidutinis
#    kintamųjų Sepal.Length ir Sepal.Width santykis yra didžiausias. Sudarykite
#    šio santykio didėjimo tvarka išrikiuotą rezultatų lentelę, kurioje dar būtų
#    ir kintamasis Species.
