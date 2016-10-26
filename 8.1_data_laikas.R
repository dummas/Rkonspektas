
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Datos ir laiko formatas POSIX.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2015-11-05 | 2015-12-12
#


# TURINYS -------------------------------

#
#   1. Sisteminio laiko ir datos funkcijos:
#      * funkcija date()
#      * funkcija Sys.Date()
#      * funkcija Sys.time()
#      * funkcija Sys.timezone()
#      * funkcija OlsonNames()
#      * funkcija format
#
#   2. POSIX datos ir laiko formatas:
#      * funkcija as.POSIXlt
#      * funkcija as.POSIXct
#
#   3. Datos ir laiko sudarymas iš teksto:
#      * funkcija strptime
#      * funkcija strftime
#
#   4. Datos ir laiko sudarymas iš skaičių:
#      * funkcija ISOdatetime
#      * funkcija ISOdate
#
#   5. Datos kintamojo sudarymas:
#      * funkcija as.Date
#


# PASTABOS ------------------------------

#
# Galima sugalvoti daugiau užduočių.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuviška lokalė. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# Ištrinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# STANDARTINĖS DATOS IR LAIKO FUNKCIJOS   #
# --------------------------------------- #

# R turi keletą standartinių datos ir laiko nustatymo funkcijų: kai kurios iš jų
# parodo tik datą, kitos parodo ir datą, ir laiką. Kadangi data arba laikas gali 
# būti užrašomi kaip paprastas tekstas arba užrašomi naudojant tam skirtus datos
# ir laiko formatus, šių funkcijų reikšmė yra vis kitokio tipo.

date()
Sys.Date()
Sys.time()
Sys.timezone()


# Datos ir laiko užrašymui naudojami tam tikri standartiniai pažymėjimai. Keletą
# iš jų galima paminėti:
#
#         %Y -- metai,
#         %y -- metai (be pirmųjų dviejų skaičių),
#         %m -- mėnesio numeris,
#         %d -- dienos numeris,
#         %e -- dienos numeris (be nulio priekyje),
#
#         %H -- valandos (00–23),
#         %M -- minutės (00–59),
#         %S -- sekundės (00–61),
#
#         %A -- savaitės dienos pavadinimas,
#         %a -- sutrumpintas savaitės dienos pavadinimas,
#         %B -- mėnesio pavadinimas,
#         %b -- sutrumpintas mėnesio pavadinimas,
#         %C -- amžius, šimtmetis,
#         %W -- metų savaitės numeris,
#         %w -- savaitės dienos numeris (sekmadienis 0),
#         %Z -- laiko zona,
#         %z -- laiko pokytis nuo GMT.

# Kai kurios šalys turi savo datos ir laiko užrašymo formatą. Laikantis ISO 8601
# standarto, metai, mėnuo ir dienos atskiriami brūkšneliu, tačiau Lietuvoje gali
# būti atskiriami ir tašku. Dėl tos priežasties data bei laikas gali būti rodomi
# prisitaikant prie lokalės:
#
#         %X -- laikas pagal vietinio laiko užrašymo taisykles,
#         %x -- data pagal vietinio laiko užrašymo taisykles.

# Dažniausiai pasitaikančios laiko elementų kombinacijos turi savus pažymėjimus:
#
#         %T == %H:%M:%S
#         %R == %H:%M
#         %F == %Y-%m-%d
#         %D == %m/%d/%y
#         %c == %a %b %e %H:%M:%S %Y


# Kiekviena sisteminio laiko ir datos funkcija datą rodo tam tikru savo formatu, 
# tačiau tą pačią datą galima užrašyti keliais skirtingais būdais. Tam naudojama 
# funkcija format. Jos parametrai:
#
#          x -- data,
#     format -- datos formatas,
#         tz -- laiko zona,
#      usetz -- loginis, ar rodyti laiko zoną.

# Pavyzdžiui, šios dienos datą galima užrašyti taip: mėnuo-diena, savaitės diena.
# Toks datos užrašymo pavidalas atitinka "%m-%d, %A" formatą.

format(Sys.Date(), format = "%m-%d, %A")

# Pavyzdžiui, laiko momentą galima nurodyti tūkstantųjų sekundžių tikslumu. Toks
# laiko užrašymas atitinka "%H:%M:%OS3" formatą.

format(Sys.time(), format = "%H:%M:%OS3")

# Turint laiko momentą, galima parodyti, koks vietinio laiko skirtumas nuo laiko 
# pagal Grinvičą. Papildomai nurodome, kad būtų parodomas ir laiko zonos kodas.

format(Sys.time(), format = "%z", usetz = TRUE)

# Naudojant funkciją format, tą patį laiką galima "pervesti" į kitą laiko juostą.
# R kalboje naudojama taip vadinama Olson laiko zonų duomenų bazė (TZ database). 

OlsonNames()

# Pavyzdžiui, užfiksuosime laiko momentą ir atvaizduosime jį Vilniaus, Tokijo ir 
# Londono laiku.

t <- Sys.time()
t

format(t, "%T", usetz = TRUE, tz = "Europe/Vilnius")
format(t, "%T", usetz = TRUE, tz = "Asia/Tokyo")
format(t, "%T", usetz = TRUE, tz = "Europe/London")


# UŽDUOTIS ------------------------------ 

# 1. Šios dienos datą užrašykite tokiais formatais: a) tik metai, b) tik mėnesio 
#    pavadinimas, c) tik diena, d) savaitės diena, mėnesio pavadinimas ir dienos 
#    numeris, d) metai, mėnuo ir diena atskirti tašku.
# 2. Sisteminį laiką užrašykite tokiu formatu: a) tik data, b) tik laikas c) tik
#    metai, d) valandos ir minutės, e) savaitės numeris, dienos numeris metuose,
#    f) valandos, minutės ir sekundės atskirtos simboliu |.
# 3. Didžioji dalis Lietuvos teritorijos yra UTC+2 laiko juostoje. Olson duomenų
#    bazėje tokios laiko zonos pavadinimo nėra, tačiau vietoje UTC yra naudojama 
#    Etc/GMT laiko zonų sistema, kur teigiamas laiko postūmis atitinka tokį patį 
#    postūmį į priešingą pusę UTC sistemoje. Sisteminį laiką užrašykite Etc/GMT
#    sistemoje.
# 4. JAV ir kai kurių kitų valstybių kariuomenės savo tikslams naudoja specifinę 
#    laiko sistemą, kur laiko zonų pavadinimai susieti su NATO fonetine abėcėle. 
#    Pvz., raidė A žymi "Alpha" laiko zoną, kuri atitinka UTC+1, raidė B "Bravo",
#    kuri atitinka UTC+2 ir t. t. Sisteminį laiką užrašykite "Zulu" laiko zonoje.
#    Nustatykite, kokį UTC laiką ji atitinka.


# --------------------------------------- #
# POSIX DATOS IR LAIKO FORMATAS           #
# --------------------------------------- #

# UNIX ir kai kuriose kitose operacinėse sistemose naudojama POSIX laiko sistema. 
# Šioje sistemoje laiko momentas nurodomas sekundžių skaičiumi nuo 1970 sausio 1 
# dienos 00:00:00 val. Tokiu būdu POSIX laikas yra sveikasis skaičius, kuris kas 
# sekundę padidėja vienu vienetu. Šia prasme POSIX suderinta su pasaulinio laiko 
# sistema UTC, kurioje laiko vienetas yra sekundė. Paprastai viena para sudaryta
# iš 86400 sekundžių. Dėl Žemės sukimosi lėtėjimo pasaulinis laikas nesutampa su 
# astronominiu laiku, todėl, atliekant sinchronizaciją, prie UTC laiko pridedama 
# papildoma sekundė. Tokios papildomos sekundės POSIX sistemoje neskaičiuojamos, 
# todėl POSIX laikas nėra nei tikrasis astronominis, nei tikrasis pasaulinis UTC 
# laikas. Galima sužinoti, kada buvo pridėtos papildomos sekundės:

.leap.seconds

# R kalboje naudojami du datos ir laiko formatai: POSIXct ir POSIXlt. Abi klasės
# atitinka POSIX laiko apibrėžimą - tai teigiamas arba neigiamas skaičius, kuris 
# lygus sekundžių skaičiui nuo 1970-01-01 00:00:00. Viena nuo kitos jos skiriasi 
# tuo, kad POSIXct objektas iš tikro yra skaičius, o POSIXlt objektas - tai toks 
# sąrašas, kurio elementai nurodo atskiras datos ir laiko komponentes:
# 
#        sec -- 0–61: sekundės;
#        min -- 0–59: minutės;
#       hour -- 0–23: valandos;
#       mday -- 1–31: mėnesio diena;
#        mon -- 0–11: mėnesio numeris metuose;
#       year -- metų nuo 1900 skaičius;
#       wday -- 0–6: savaitės dienos numeris pradedant sekmadieniu;
#       yday -- 0–365: metų dienos numeris;
#      isdst -- vasaros laiko indikatorius;
#       zone -- laiko zonos identifikatorius (nebūtinas);
#     gmtoff -- laiko postūmis sekundėmis nuo GTM (nebūtinas).
#
# Kadangi POSIXct formatu užrašytas laikas yra vienas skaičius, jis užima mažiau 
# vietos ir todėl labiau tinka įvairiems veiksmams su datomis arba jų saugojimui
# duomenų lentelėse. POSIXlt formatas naudojamas tada, kai iš datos reikia gauti
# kokią nors vieną atskirą dalį, pvz., savaitės dieną arba dienos numerį metuose.


# POSIX objekto klasė keičiama naudojant funkcijas as.POSIXct ir as.POSIXlt. Tos
# funkcijos naudojamos ir POSIX objekto sudarymui iš tekstiniu formatu užrašytos
# datos. Pagrindiniai argumentai:
#
#          x -- datos objektas, POSIXct arba POSIXlt tipo objektas,
#         tz -- laiko zona.
#
# Funkcija as.POSIXlt, priklausomai nuo to, koks yra datos objektas, gali turėti
# dar du parametrus:
#
#     format -- datos formatas, kai x yra "character" tipo,
#     origin -- datos atskaitos taškas, kai x yra "numeric" tipo.


# Pvz., sudarysime POSIXct klasės vektorių iš %Y-%m-%d %H:%M:%S formatu užrašyto
# laiko momento. Tarkime, kad laiko zona bus Lietuvos.

laikas <- "2015-11-08 14:31:17"
laikas

t <- as.POSIXct(laikas, tz = "Europe/Vilnius")
t

# Matome, kad POSIXct klasės objektas yra double tipo skaičius, kuris ir reiškia 
# sekundžių skaičių nuo 1970-01-01 00:00:00. Galima pastebėti, kad toks objektas
# turi atributą tzone, kuriam priskirtas laiko zonos pavadinimas.

class(t)
mode(t)
typeof(t)
attributes(t)


# Sudarysime to paties laiko momento POSIXlt klasės objektą.

t <- as.POSIXlt(laikas, tz = "Europe/Vilnius")
t

# Nesunkiai galima patikrinti, kad POSIXlt klasės objektas yra laiko komponenčių
# sąrašas. 

class(t)
mode(t)
typeof(t)
attributes(t)

# Iš tokio sąrašo galima gauti atskiras datos arba laiko komponentes. Pavyzdžiui,
# valandas, minutes ir sekundes, savaitės dienos ar metų dienos numerį.

t[["sec"]]      # sekundžių skaičius
t[["year"]]     # metų skaičius nuo 1900 metų
t[["yday"]]     # dienos metuose numeris (skaičiuojant nuo 0)
t[["zone"]]     # laiko zonos kodas

# Panaikinant objekto klasę, galima pamatyti iš karto visus šio sąrašo elementus.

unlist(t)
unclass(t)


# Jei laikas užrašytas nestandartiniu pavidalu, sukuriant POSIXlt klasės objektą,
# reikia nurodyti jo užrašymo formatą.

laikas <- "14:31:17 08/11/2015"
laikas

t <- as.POSIXlt(laikas, format = "%H:%M:%S %d/%m/%Y")
t

# Laiko momentą galima nurodyti sekundžiu skaičiumi nuo tam tikro momento. Pvz.,
# 12 valandų yra 43200 sekundžių. Tegul atskaitos taškas yra 2015-01-01 00:00:00 
# pagal UTC. Sukursime atitinkamą laiko momentą.

laikas <- 43200
laikas

t <- as.POSIXlt(laikas, origin = "2015-01-01 00:00:00", tz = "GMT")
t


# NAUDINGA ------------------------------

# Laiko momentas paprastai susietas su laiko zona, bet kartais laiko zoną reikia 
# pakeisti. Keičiant laiko zoną galimi du laiko momento perskaičiavimo variantai:
#
#  a) palikti tą patį laiką,
#  b) perskaičiuoti laiką.

# Pavyzdžiui, turime POSIXlt objektą su laiko momentu pagal pasaulinį UTC laiką.
# Galima pastebėti, kad laiko zoną nurodantis kodas yra laiko objekto atributas.

t <- as.POSIXlt("2015-11-07 00:00:25", format = "%F %T", tz = "UTC")
t

attributes(t)

# Tam, kad laiką būtų galima perskaičiuoti, jis turi būti saugomas kaip skaičius
# ir todėl turi būti užrašytas POSIXct formatu. Jei, konvertuojant POSIX objektą 
# nurodoma nauja laiko zona, tai keičiasi tik laiko zona, bet ne laiko momentas. 
# Pavyzdžiui, konvertuojant datą į POSIXct klasę, nurodysime kitą laiko zoną --
# "Europe/Vilnius".

a <- as.POSIXct(t, tz = "Europe/Vilnius")
a

attributes(a)

# Galima pastebėti, kad laiko zona pasikeitė, tačiau laiko momentas nepasikeitė.
# Tuo atveju, kai keičiant laiko zoną laiko momentas turi būti perskaičiuojamas, 
# laikas iš pradžių konvertuojamas į POSIXct klasę, o tada pakeičiamas atributas.

b <- as.POSIXct(t)
b

attributes(b)
attr(b, "tzone") <- "Europe/Vilnius"
attributes(b)

b

# Jeigu laikas yra POSIXct klasės objektas, pakeisti laiko zoną ir perskaičiuoti
# laiką galima naudojant funkciją format -- taip gauname tekstinę laiko išraišką.
# Pavyzdžiui, užrašysime tą patį laiką Tokijo laiku.

format(b, "%T", usetz = TRUE, tz = "Asia/Tokyo")


# UŽDUOTIS ------------------------------ 

# 1. Tarkime, kad laiko momentas pagal UTC užrašytas taip: "2015.12.12 07|54|25".
#    Sudarykite POSIXct ir POSIXlt formato laiko objektus.
# 2. Sudarykite POSIXct laiko objektą, kuris reiškia laiko momentą praėjus 1 mln. 
#    sekundžių nuo dabar. Kokia tai bus mėnesio ir savaitės diena?
# 3. Perskaičiuokite ir nustatykite, kokį laiko momentą pagal UTC atitinka laiko
#    momentas "2015-12-12 10:07:26" EET laiko zonoje, kurioje yra ir Lietuva.


# --------------------------------------- #
# POSIXlt OBJEKTO SUDARYMAS IŠ TEKSTO     #
# --------------------------------------- #

# Įvairiuose duomenų failuose data ir laikas paprastai užrašyti kaip tekstas. Jo
# konvertavimui į POSIXlt formatą naudojama funkcija strptime. F-jos parametrai:
#
#          x -- character tipo laiko reikšmių vektorius,
#     format -- formatas, kuriuo užrašytas laikas,
#         tz -- laiko zonos kodas.


# Laikantis ISO 8601 standarto, metai, mėnuo ir diena vienas nuo kito atskiriami 
# brūkšneliu, todėl data nurodoma YYYY-MM-DD formatu, kuris užrašomas "%Y-%m-%d"
# arba sutrumpintai "%F". Pavyzdžiui, nuskaitysime tokiu formatu užrašytas datas.

x <- c("1961-04-12", "1965-03-18", "1969-07-24")
x

t <- strptime(x, format = "%Y-%m-%d")
t

# Tos pačios datos gali būti užrašytos kitokiu formatu. Pavyzdžiui, labai dažnai
# metai, mėnuo ir diena atskiriami pasviru brūkšneliu.

x <- c("1961/04/12", "1965/03/18", "1969/07/24")
x

t <- strptime(x, format = "%Y/%m/%d")
t

# Kai kurie laiko momentai nėra susieti su jokia konkrečia vietove ar laiko zona. 
# Pvz., toks universalus laikas reikalingas orų prognozei, lėktuvų, traukinių ir
# kitų transporto priemonių tvarkaraščiams sudaryti, jis naudojamas internete ir
# astronomijoje, tarptautinėje kosminėje stotyje. Iki 1972 metų pasaulyje laikas 
# buvo matuojamas pagal astronominį Grinvičo laiką. Nuo 1972 naudojama pasaulinė 
# UTC laiko sistema ir laikas sinchronizuojamas pagal atominį laikrodį.
#
#        UTC -- Coordinated Universal Time,
#        GMT -- Greenwich Mean Time.

# Pavyzdžiui, sudarysime tris laiko momentus pagal UTC laiką. Formatą nurodysime
# naudodami pilną ir sutrumpintą datos ir laiko kodą.

#       Skrydis į kosmosą      Išėjimas į kosmosą     Nusileidimas Mėnulyje
#      ---------------------  ---------------------  ---------------------
x <- c("1961-04-12 06:07:00", "1965-03-18 08:34:51", "1969-07-24 16:50:35")
x

t <- strptime(x, format = "%Y-%m-%d %H:%M:%S", tz = "UTC")
t <- strptime(x, format = "%F %T", tz = "UTC")
t

# Jeigu laiko momentas susietas su konkrečia vietove, reikia nurodyti laiko zoną.
# Laiko zonos turi vardus, kurie paprastai susideda iš dviejų dalių. Pavyzdžiui,
# "Europe/Vilnius", "Europe/London", "America/Toronto", "Asia/Hong_Kong" ir pan.
# Pavyzdžiui, užrašant Japonijos miestų Hiroshima ir Nagasaki bombardavimo laiką, 
# reikia nurodyti Japonijos laiko zoną.

#       Hiroshima              Nagasaki
#      ---------------------  ---------------------
x <- c("1945-08-06 08:15:00", "1945-08-09 11:02:00")
x

t <- strptime(x, format = "%Y-%m-%d %H:%M:%S", tz = "Asia/Tokyo")
t <- strptime(x, format = "%Y-%m-%d %H:%M:%S", tz = "Japan")
t

# Į tą pačią laiko juostą patenkančios šalys gali būti apjungiamos į vieną laiko 
# zoną. Pvz., Suomija, Estija, Latvija, Lietuva, Ukraina ir dar kelios UTC +2:00
# juostoje esančios šalys sudaro Rytų Europos laiko zoną. Beveik viso šios laiko
# zonos šalys pereina į vasaros laiką, kuris turi atskirą pavadinimą:
#
#        EET -- Eastern European Time (EET),
#        EST -- Eastern European Summer Time (EEST).

# Vietinis laikas pagal ISO 8601 standartą nustatomas per skirtumą nuo UTC laiko. 
# Pavyzdžiui, EET laiko zona atitinka UTC +2:00 laiką, "Europe/Vilnius" taip pat 
# atitinka UTC +2:00 laiką. 

# Etc yra speciali sritis, kuri naudojama nekonkrečioms laiko zonoms. Pavyzdžiui, 
# Etc/UTC atitinka universalų pasaulinį laiką. Pridedant laiko skirtumą, gauname
# tą skirtumą atitinkančios laiko juostos laiką. POSIX sistemoje vietoje Etc/UTC 
# naudojamos Etc/GMT laiko juostos, tačiau -- su priešingu laiko skirtumo ženklu!
# O tai reiškia, kad, pvz., EET laiko zona atitinka Etc/GMT -2:00, bet ne +2:00, 
# kaip įprasta.


# Jei laiko reikšmes reikia įrašyti į tekstinį failą, tai POSIX formatu užrašytą 
# laiką pirmiausia reikia konvertuoti į tekstą. Tam galima naudoti f-ją strftime. 
# Šios funkcijos parametrai tokie:
#
#          x -- data, kuri gali būti užrašoma POSIXlt formatu,
#     format -- datos išvedimo formatas,
#         tz -- laiko zona,
#      usetz -- loginis, nustato ar rodyti laiko zoną.


# Pavyzdžiui, tekstiniu formatu užrašysime Japonijos miestų bombardavimo datas.

datos <- strftime(t, format = "%F %T", usetz = TRUE)
datos

# Įrašysime gautą datų vektorių į tekstinį failą. Tam panaudosime dvi skirtingas
# funkcijas: writeLines ir write. Norint įsitikinti, kad datos įrašytos į failą,
# jį galima atidaryti. Kadangi gautas failas šiaip nereikalingas, jį ištrinsime.

writeLines(datos, con = "datos.txt")
file.show("datos.txt")

write(datos, file = "datos.txt")
file.show("datos.txt")

file.remove("datos.txt")


# Laiko ir datos užrašymui tekstiniu formatu galima panaudoti ir funkciją format. 

format(t, format = "%F %T", usetz = TRUE)


# UŽDUOTIS ------------------------------ 

# 1. Tarkime, kad laiko momentas užrašytas tokiu pavidalu: "2015 12 12 10 40 15".
#    Matome, kad metai, mėnuo, diena ir t. t. vienas nuo kito atskirti tik tarpo
#    simboliu. Funkcijai strptime nurodykite datos ir laiko užrašymą atitinkantį 
#    formatą ir sudarykite POSIX laiko objektą.
# 2. Duotas toks datų vektorius: c("1918 2 mėn. 16 d.", "1990 3 mėn. 11 d."). Šį
#    datų vektorių paverskite į POSIX laiko objektą.
# 3. Prieš tai gautą POSIX datų vektorių įrašykite į tekstinį failą: a) be laiko
#    zonos, b) tik metus, c) savaitės dieną, mėnuo ir diena.


# --------------------------------------- #
# POSIXlt OBJEKTO SUDARYMAS IŠ SKAIČIŲ    #
# --------------------------------------- #

# Jeigu data arba laikas užrašyti kaip tekstas, naudojant pilnus ar sutrumpintus 
# mėnesių pavadinimus, tada konvertavimui į POSIXlt laiko formatą naudojama f-ja 
# strptime. Jei visos laiko komponentės -- metai, mėnuo diena, valandos, minutės 
# ir sekundės -- užrašomos skaičiais, tada POSIXlt klasės laiko momentą sudaryti 
# patogu naudojant funkciją ISOdatetime arba analogišką jai funkciją ISOdate. Jų
# parametrai visi vienodi:
#
#       year -- metai,
#      month -- mėnuo,
#        day -- diena,
#       hour -- valanda,
#        min -- minutės,
#        sec -- sekundės,
#         tz -- laiko zona.

# Iš esmės šios funkcijos yra vienodos ir skiriasi tik pradinėmis savo parametrų 
# reikšmėmis:
#
#   ISOdatetime(year, month, day, hour, min, sec, tz = "")
#   ISOdate    (year, month, day, hour = 12, min = 0, sec = 0, tz = "GMT")
#
# Matosi, kad pagal nutylėjimą f-jos ISOdatetime parametrui tz priskirta reikšmė 
# "", o f-jos ISOdate -- "GMT". Pirmuoju atveju laiko momentui nustatoma vietinė 
# laiko zona, o antruoju gaunamas laiko momentas pagal pasaulinį UTC laiką.

# Kurią funkciją naudoti, priklauso nuo situacijos. Jei reikia užrašyti tikslaus 
# laiko momentą, tada labiau tinka ISOdatetime. 

ISOdatetime(year = 2015, month = 11, day = 15, hour = 17, min = 48, sec = 18)

# Kaip visada - jeigu reikšmės parametrams priskiriamos eilės tvarka, pavadinimų 
# galima ir nerašyti.

ISOdatetime(2015, 11, 15, 17, 48, 18)

# Jeigu nurodome ne tik datą, bet ir laiką, tada galima naudoti ir f-ją ISOdate.
# Papildomai nurodysime laiko zoną, nes šiai funkcijai pagal nutylėjimą yra UTC.

ISOdate(2015, 11, 15, 17, 48, 18, tz = "Europe/Vilnius")

# Jei reikalinga tik data be tikslaus laiko, tada labiau tinka funkcija ISOdate.
# Pavyzdžiui, nurodžius tik metus, mėnesį ir dieną, sudaromas tos dienos 12 val.
# atitinkantis laiko momentas pagal UTC laiką.

ISOdate(2015, 11, 15)

# Jeigu kuriam nors parametrui priskiriame skaičių seką, galime sugeneruoti datų
# seką. Pavyzdžiui, sudarysime 2015 metų visų 12-os mėnesių pirmųjų dienų seką.

ISOdate(2015, 1:12, 1)


# UŽDUOTIS ------------------------------ 

# 1. Naudodami f-ją ISOdatetime, sudarykite 24 laiko momentų vektorių, išdėstytų
#    tolygiai kas valandą ir pradedant nuo 00:00.


# --------------------------------------- #
# DATOS FORMATAS                          #
# --------------------------------------- #

# Vien datą nurodančio objekto sudarymui naudojama f-ja as.Date. Gaunamas "Date"
# klasės vektorius, kurio elementas yra data. Prie tokiu formatu užrašytos datos
# galima pridėti ar atimti tam tikrą dienų skaičių, galima apskaičiuoti skirtumą 
# tarp dviejų datų. Jei data užrašyta kaip tekstas, tada f-jos parametrai tokie:
#
#          x -- data kaip "character",
#     format -- datos formatas.
#
# Data, kaip ir POSIX laikas, gali būti užrašyta kaip skaičius, kuris čia nurodo
# dienų skaičių nuo tam tikros datos. Tokiu atveju funkcijos parametrai tokie:
#
#          x -- data kaip "numeric",
#     origin -- atskaitos taškas.
#
# Tą pačią funkciją galima naudoti "POSIXct" formato laiko konvertavimui į datą.
# Tada parametrai tokie:
#
#          x -- "POSIXct" formato laikas,
#         tz -- laiko zonos kodas.

# Pvz., tekstinį datų vektorių konvertuosime į "Date" klasės vektorių. Čia visos
# datos užrašytos standartiniu "%Y-%m-%d" formatu, kuris ir nurodomas funkcijai.

#          Saulės        Durbės        Žalgirio      Oršos         Salaspilio
#         ------------  ------------  ------------  ------------  ------------ 
data <- c("1236-09-22", "1260-07-13", "1410-07-15", "1514-09-08", "1605-09-27")
data

d <- as.Date(data, format = "%Y-%m-%d")
d

class(d)


# Naudojant funkciją format, tą pačią datą galima pavaizduoti daugeliu skirtingų 
# būdų, pavyzdžiui:

format(d, format = "%Y")
format(d, format = "%m")
format(d, format = "%d")
format(d, format = "%B")
format(d, format = "%b")

format(d, format = "%Y-%m")
format(d, format = "%m-%d")
format(d, format = "%Y %B")


# UŽDUOTIS ------------------------------ 

# 1. Tarkime, kad 1965 metų gegužės 14 diena užrašyta sutrumpintai -- "65-05-14". 
#    Komanda as.Date("65-05-14", "%y-%m-%d") šią datą supranta kaip "2065-05-14". 
#    Sugalvokite, kaip korektiškai konvertuoti taip sutrumpintai užrašytas datas.
