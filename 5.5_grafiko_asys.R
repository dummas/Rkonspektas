
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Grafiko ašių, rėmelio ir tinklelio formavimas.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2014-06-10 | 2014-06-27
#


# TURINYS -------------------------------

#
#   1. Grafiko ašių sudarymas:
#      * funkcija axis
#
#   2. Koordinačių ašių padalijimo taškų radimas:
#      * funkcija axTicks
#      * funkcija axisTicks
#
#   3. Rėmelio ir tinklelio braižymas:
#      * funkcija box
#      * funkcija grid
#


# PASTABOS ------------------------------

#
# Papildyti apie box() parametrus.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuviška lokalė. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# Ištrinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# GRAFIKO AŠIŲ FORMAVIMAS                 #
# --------------------------------------- #

# Aukšto lygio grafinės funkcijos diagramos ašis suformuoja automatiškai, tačiau
# jas galima pakeisti. Taip daroma tada, kada automatiškai sudaryta ašis netinka 
# ir sudaroma nauja. Tam naudojama speciali funkcija axis. Dažniausiai naudojami 
# šie funkcijos parametrai:
#
#       side -- ašies pozicija: 1 apačioje, 2 kairėje, 3 viršuje, 4 dešinėje,
#         at -- padalinimo taškų vektorius,
#     labels -- loginis arba padalinimo taškų pavadinimų vektorius.

# Naudojant grafinius parametrus xaxt ir yaxt galima uždrausti braižyti vieną ar 
# abi grafiko ašis. Iš karto abi ašis galima uždrausti per loginį parametrą axes.

curve(sin, -pi, pi, axes = FALSE)

# Standartines ašis grafikui galima atstatyti vien tik nurodžius parametrą side.
# Čia parametro reikšmė 1 nurodo, kad ašis bus apačioje, o 2 --- kairėje pusėje.
# Kadangi side yra pirmas f-jos axes parametras, jo vardo galima nerašyti.

axis(1)
axis(2)

# Sinusoidės grafike Ox ašį natūraliau sudalinti ne kas vienetą, tačiau kas pi/2. 
# Sudalinimo taškų vektorių sudarysime su funkcija seq ir priskirsime parametrui 
# at.

curve(sin, -pi, pi, frame = FALSE, xaxt = "n")
axis(1, at = seq(-pi, pi, by = pi/2))


# Matome, kad ašies padalinimo taškuose užrašytos teisingos reikšmės, tačiau jos
# dėl savo užrašymo pavidalo nelabai informatyvios. Šiuo atveju galima išnaudoti
# funkciją expression ir tas reikšmes užrašyti per skaičių pi. Taip bus gražiau.

curve(sin, -pi, pi, frame = FALSE, xaxt = "n")

Ox.tas <- seq(-pi, pi, by = pi/2)
Ox.pav <- expression(-pi, -pi/2, 0, pi/2, pi)

axis(1, at = Ox.tas, labels = Ox.pav)


# Reikšmės gali būti surašytos nebūtinai ties kiekvienu ašies padalinimo tašku.
# Tokiu atveju parametrui label priskiriame vektorių su praleistomis reikšmėmis.

curve(sin, -pi, pi, frame = FALSE, xaxt = "n")

Ox.tas <- seq(-pi, pi, by = pi/4)
Ox.pav <- expression(-pi, NA, -pi/2, NA, 0, NA, pi/2, NA, pi)

axis(1, at = Ox.tas, labels = Ox.pav)


# Toje pačioje pozicijoje galima pridėti kelias ašis. Kiekviena ašis gali turėti
# savo padalinimo taškus ir jų pavadinimus.

curve(sin, -pi, pi, frame = FALSE, xaxt = "n")

Ox.tas <- seq(-pi, -pi/4, by = pi/4)
Ox.pav <- expression(-pi, -3*pi/4, -pi/2, -pi/4)

axis(1, at = Ox.tas, labels = Ox.pav)
axis(1, at = seq(0, 3, by = 0.5), labels = c(0, NA, 1, NA, 2, NA, 3))


# Dar vienas pavyzdys, kaip toje pačioje pozicijoje atidedamos 2 skirtingos ašys.
# Viena iš jų padalina ašį į intervalus, o kita --- tų intervalų viduryje uždeda
# jų pavadinimus. Todėl pirmoje ašyje nerašomi sudalinimo taškai, o antroje nėra
# ašies linijos.

curve(sin, -pi, pi, axes = FALSE, ann = FALSE)

Ox.ta1 <- seq(-pi, pi, pi/2)
Ox.ta2 <- seq(-3*pi/4, 3*pi/4, pi/2)

axis(1, at = Ox.ta1, labels = FALSE)
axis(1, at = Ox.ta2, labels = LETTERS[1:4], tick = FALSE)

abline(v = Ox.ta1, lty = 2, col = "gray")


# Funkcija axis turi ir daugiau parametrų, kuriais galima nustatyti bendrą ašies 
# arba atskirų jos dalių vaizdą:
# 
#       tick -- loginis, nurodo ar braižyti ašies liniją,
#       line -- eilutės, kurioje braižoma ašis, numeris,
#        pos -- koordinatė, ties kuria nubrėžiama ašis, 
#       hadj -- nustato ašies užrašų poslinkį horizontaliai,
#       padj -- nustato ašies užrašų poslinkį vertikaliai,
#        lty -- linijos tipas: 0 -- nebraižoma, 1 -- ištisinė ir taip iki 7,
#        lwd -- linijos storis,
#        col -- linijos spalva,
#  lwd.ticks -- padalijimo brūkšnelių storis,
#  col.ticks -- padalijimo brūkšnelių spalva.

# Kartais grafike užrašai ant ašies nereikalingi. Tokiu atveju parametrui labels 
# priskiriame reikšmę FALSE.

curve(sin, -pi, pi, frame = FALSE, xaxt = "n")
axis(1, labels = FALSE)

# Galima ir priešinga situacija, kai ašies linija nereikalinga, o reikalingi tik 
# ašies padalijimo taškų užrašai. Tada parametrui tick priskiriame reikšmę FALSE.

curve(sin, -pi, pi, frame = FALSE, xaxt = "n")
axis(1, tick = FALSE)

# Tokį patį efektą galima pasiekti ir naudojant linijos tipo parametrą lty. Šiam
# parametrui priskyrus nulinę reikšmę, ašis iš viso nebraižoma.

curve(sin, -pi, pi, frame = FALSE, xaxt = "n")
axis(1, lty = 0)


# Paprastai ašys braižomos už funkcijos grafiko ar kitokios diagramos ribų, t.y. 
# paraštėse. Paraštės eilutės, kurioje atidedama ašis, numerį nurodome naudojant 
# parametrą line. Pagal nutylėjimą ašis braižoma nulinėje eilutėje. 

curve(sin, -pi, pi, frame = FALSE, xaxt = "n")
axis(1, line = 0)
axis(1, line = 2)

# Ašies poziciją grafike galima nurodyti užrašant kitos ašies kirtimo koordinatę.
# Tam naudojamas parametras pos.

curve(sin, -pi, pi, frame = FALSE, xaxt = "n")
axis(1, pos = -0.5)
axis(1, pos =  0.5)


# Užrašus ties ašies padalinimo taškais galima pastumti į kairę arba dešinę. Tam
# naudojamas parametras hadj. Pagal nutylėjimą jam priskiriama reikšmė 0.5, kuri
# reiškia, kad užrašai ties padalinimo taškais centruojami. Didinant šią reikšmę,
# užrašai pastumiami į kairę. Jei užrašus ties padalinimo taškais reikia pakelti 
# virš ašies linijos arba nuleisti dar žemiau, naudojamas parametras padj.

# Pavyzdžiui, nubraižysime sinusoidės grafiką, kuriame Ox ašis Oy ašį kertą ties
# nuliu. Galime pastebėti, kad funkcijos grafikas kerta kairįjį padalinimo taškų
# užrašą. Šį grafiko defektą galima ištaisyti dviem būdais: arba nerodyti užrašo 
# "-3", arba jį pakelti virš ašies. Antruoju atveju naudojamas parametras padj.
# Jam priskiriame visų užrašų ties padalinimo taškais postūmio reikšmių vektorių.

curve(sin, -pi, pi, frame = FALSE, xaxt = "n")
axis(1, pos = 0, at = -3:3, labels = c(NA, -2:3))

curve(sin, -pi, pi, frame = FALSE, xaxt = "n")
axis(1, pos = 0, padj = c(-4, rep(0, 6)))


# NAUDINGA ------------------------------

# Ne visi grafikai turi įprastas koordinačių ašis. Pvz., stulpelinėje diagramoje 
# svarbiausia yra stulpelių aukštis, o stulpeliai ant tiesės gali būti išdėstyti 
# bet kokia tvarka - nuo to iš esmės niekas nesikeičia. Pavyzdžiui, nubraižysime
# Titaniko keleivių pasiskirstymo pagal lytį skirtingose keleivių klasėse dažnių
# diagramą.

d <- margin.table(Titanic, c(2, 1))
d

barplot(d)

# Užrašus po kategorijų stulpeliais galima keisti parametrui names.arg priskyrus 
# kitą reikšmių vektorių. 

barplot(d, names.arg = c("Pirma", "Antra", "Trečia", "Įgula"))

# Parametrui axes priskyrus reikšmę FALSE, dingsta tik Oy ašis, o užrašai ant Ox 
# ašies išlieka. Galima sakyti, kad stulpelinė diagrama formaliai turi tik vieną 
# Oy ašį, kadangi Ox ašis pagal nutylėjimą iš viso nebraižoma.

barplot(d, axes = FALSE)

# Stulpelinės diagramos Ox ašies linijos tipą reguliuoja parametras axis.lty. Jo
# reikšmė pagal nutylėjimą lygi nuliui. Priskyrus vienetą, ašis jau bus braižoma.

barplot(d, axis.lty = 1)

# Užrašų ant Ox ašies rodymas priklauso nuo loginio parametro axisnames reikšmės.
# Jei ji lygi FALSE, nepriklausomai nuo to, kam lygi parametro axis.lty reikšmė,
# Ox ašis nebraižoma visai.

barplot(d, axisnames = FALSE)

# Žinoma, ašis galima uždrausti ir naudojant standartinius grafinius parametrus 
# xaxt ir yaxt.

barplot(d, xaxt = "n")
barplot(d, yaxt = "n")


# Naudojant standartinius funkcijos axis nustatymus, nubraižyti tokią pat Ox ašį
# nepavyksta. Tuo galima nesunkiai įsitikinti.

barplot(d, axisnames = FALSE)
axis(1)

# Problema tame, kad stulpelių centrai nesutampa su ašies Ox padalinimo taškais. 
# Šioje situacijoje galima pasinaudoti tuo, kad f-ja barplot gali išsaugoti visų
# stulpelių centrų koordinates, kurias vėliau galima panaudoti ašies sudalinimui.

barstat <- barplot(d, axisnames = FALSE)
barstat

axis(1, at = barstat)


# Kadangi stulpelinėje diagramoje skaičiai ant kategorinio kintamojo ašies nieko 
# nereiškia, juos pakeisime į kategorijų pavadinimus, o ašies liniją uždrausime.

barstat <- barplot(d, axisnames = FALSE)
axis(1, at = barstat, labels = c("Pirma", "Antra", "Trečia", "Įgula"), tick = F)


# UŽDUOTIS ------------------------------ 

# 1. Nubraižykite funkcijos y = sin(x) grafiką intervale [-pi, pi]. Grafike turi
#    būti dvi Ox ašys: apačioje sugraduota kas pi/2, o viršuje kas vienetą.
# 2. Nubraižykite lentelės airquality kintamojo Temp kitimo laike grafiką, kuris
#    turėtų dvi Oy ašis. Vienoje iš jų temperatūra matuojama Farenheito skalėje, 
#    kitoje -- pagal Celsijų.
# 3. Nubraižykite dažnių lentelės d stulpelinę diagramą be Oy ašies ir be užrašų
#    ant Ox ašies. Tam naudokite tik standartinius funkcijos barplot parametrus.
# 4. Nubraižykite dažnių lentelės d stulpelinę diagramą su parametru beside = T.
#    Gaunamos keturios grupės po 2 stulpelius, kurie rodo vyrų ir moterų skaičių. 
#    Grafiką pakeiskite taip, kad po kiekvienu stulpeliu būtų parašyta lytis, o
#    dar žemiau būtų užrašytas kategorijos, kuriai priklauso kiekviena stulpelių 
#    pora, pavadinimas.
# 5. Nubraižykite kintamojo Nile histogramą. Ant Ox ašies turi būti pažymėti tik
#    stulpelių vidurio taškai, kurie korektiškai atidedami nepriklausomai nuo to,
#    kiek stulpelių yra histogramoje.
# 6. Nubraižykite lentelės airquality kintamojo Temp kitimo laike grafiką. Ašies
#    Ox sudalinimo taškai turi sutapti su vieno mėnesio pradžia ir kito pabaiga.
#    Ties sudalinimo taškais ant grafiko nubraižykite vertikalias pilkas linijas, 
#    o tarpuose tarp padalinimo taškų užrašykite atitinkamo mėnesio pavadinimą.


# --------------------------------------- #
# AŠIES PADALIJIMO TAŠKŲ RADIMAS          #
# --------------------------------------- #

# Nubraižyto grafiko ašių padalinimo taškus galima gauti naudojant f-ją axTicks. 
# Jos rezultatas yra padalinimo taškų koordinačių vektorius. Paprastai naudojami 
# šie funkcijos parametrai:
#
#       side -- ašies pozicija: 1 apačioje, 2 kairėje, 3 viršuje, 4 dešinėje,
#        axp -- ašies ribų ir intervalų skaičiaus vektorius c(min, max, k),
#        usr -- grafiko ribų vektorius c(xmin, xmax, ymin, ymax),
#        log -- jei TRUE, tai nurodo, kad ašis logaritminėje skalėje.

# Pavyzdžui, nubraižysime funkcijos y = sin(x) grafiką be ašių. Nustatysime, kam 
# lygios ašies Ox sudalijimo taškų koordinatės, kurios būtų naudojamos, jei ašis 
# būtų braižoma.

curve(sin, -pi, pi, axes = FALSE)
axTicks(1)

# Ašies padalijimo taškų vektorius priklauso nuo grafiko. Norint, kad rezultatas
# nepriklausytų nuo konkretaus grafiko, reikia nurodyti visų parametrų reikšmes.
# Pavyzdžiui, apskaičiuosime intervalo nuo 5 iki 20, padalijimo į 6 lygias dalis 
# taškų koordinates, kai viso grafiko ribos pagal Ox ašį nustatytos nuo 0 iki 25.

axTicks(side = 1, axp = c(5, 20, 6), usr = c(0, 25, -10, 10), log = FALSE)

# Tokių koordinačių vektorių galima panaudoti automatiniam grafiko padalinimui į 
# sektorius pagal ašies sudalinimo taškus. Pavyzdžiui, nubraižysim laiko eilutės 
# grafiką ir jį padalinsime į keletą laiko intervalų.

plot(Nile)
abline(v = axTicks(1), col = "red")


# Negriežtam intervalo sudalijimui lygiomis dalimis naudojama funkcija axisTicks. 
# Funkcijos rezultatas yra intervalo sudalijimo lygiomis dalimis taškų vektorius.
# Tam, kad taškų koordinatės būtų tam tikra prasme "gražios", pradinio intervalo 
# galai ir padalijimo taškų skaičius gali būti automatiškai šiek tiek pataisyti. 
# Funkcijos parametrai:
#
#        usr -- grafiko ribų pagal vieną ašį vektorius c(min, max),
#        log -- jei TRUE, tai nurodo, kad ašis logaritminėje skalėje,
#        axp -- ašies ribų ir intervalų skaičiaus vektorius c(min, max, k),
#       nint -- pageidaujamas intervalų dalių skaičius.

# Pavyzdžiui, lygiomis dalimis sudalinsime intervalą [-5, 15]. Jei intervalų sk.
# nenurodome, jis parenkamas automatiškai. Matome, kad nedaug pakeitus intervalo 
# galus, funkcijos rezultatas nepasikeičia - gaunami tie patys sudalinimo taškai.

axisTicks(usr = c(-5.0, 15.0), log = FALSE)
axisTicks(usr = c(-5.3, 15.9), log = FALSE)

# Nurodžius intervalo dalių skaičių, į pageidavimus atsižvelgiama tik iš dalies.

axisTicks(usr = c(-5, 15), log = FALSE, nint = 4)
axisTicks(usr = c(-5, 15), log = FALSE, nint = 5)
axisTicks(usr = c(-5, 15), log = FALSE, nint = 6)
axisTicks(usr = c(-5, 15), log = FALSE, nint = 7)


# --------------------------------------- #
# RĖMELIO IR TINKLELIO BRAIŽYMAS          #
# --------------------------------------- #

# Kai kurios aukšto lygio grafinės funkcijos grafiką apriboja rėmeliu. Paprastai 
# toks rėmelis visiškai nereikalingas. Parametrui frame priskyrus reikšmę FALSE, 
# rėmelis nebus braižomas. Palyginsime keletą tipinių grafikų su rėmeliu ir be. 

curve(sin, -pi, pi)
curve(sin, -pi, pi, frame = FALSE)

plot(Nile)
plot(Nile, frame = FALSE)

boxplot(Temp ~ Month, data = airquality)
boxplot(Temp ~ Month, data = airquality, frame = FALSE)


# Globaliai rėmelio braižymą arba nebraižymą reguliuoja grafinis parametras bty.
# Pagal nutylėjimą jo reikšmė lygi "o". Jei reikia, kad rėmelis būtų nebraižomas
# visuose grafikuose, parametrui bty priskiriame reikšmę "n".

par("bty" = "n")

curve(sin, -pi, pi)
plot(Nile)
boxplot(Temp ~ Month, data = airquality)

par("bty" = "o")


# Jei parametrui bty reikšmė priskiriama kaip grafinės funkcijos argumentui, tai
# jo poveikis pasireiškia tik tos funkcijos sudarytam grafikui. Pavyzdžiui, taip
# galima vienai konkrečiai funkcijai uždrausti braižyti rėmelį.

curve(sin, -pi, pi)
curve(sin, -pi, pi, bty = "n")


# Rėmeliui ant jau nubraižyto grafiko uždėti naudojama funkcija box. Pavyzdžiui, 
# histograma braižoma be rėmelio, bet jį galima uždėti papildomai.

hist(Nile)
box()

# Kaip ir kitoms funkcijoms, funkcijai box kaip argumentą galima perduoti bendro 
# pobūdžio grafinių parametrų reikšmes. Pvz., galima pakeisti rėmelio spalvą.

hist(Nile)
box(col = "red")


# Koordinačių tinklelis ant jau nubraižyto grafiko uždedamas naudojant f-ją grid. 
# Jos parametrai:
#
#         nx -- tinklelio langelių skaičius ant Ox ašies, 
#         ny -- tinklelio langelių skaičius ant Oy ašies,
#        col -- tinklelio linijų spalva, 
#        lty -- tinklelio linijų tipas: 1 -- ištisinė, 2 -- punktyras ir t.t.,
#        lwd -- tinklelio linijų storis.

# Pagal nutylėjimą parametrų nx ir ny reikšmės yra NULL, todėl tinklelio linijos 
# sutampa su ašių padalijimo taškais, kurie būtų gauti su f-ja axTicks. 

curve(sin, -pi, pi)
grid()

curve(sin, -pi, pi)
grid(nx = 2, ny = 2)

# Jei parametrui nx arba ny priskiriama reikšmė NA, tinklelio linijos atitinkama
# kryptimi nebraižomos.

curve(sin, -pi, pi)
grid(nx = NA, ny = NULL)

# Jei kitaip nenurodyta, braižomos šviesiai pilkos "lightgray" taškinės "dotted"
# linijos. Žinoma, šių parametrų reikšmes galima pakeisti.

curve(sin, -pi, pi)
grid(col = "red", lty = 2)


# NAUDINGA ------------------------------

# Rėmelio ribos priskiriamos grafiniam parametrui usr. Jo reikšmė -- koordinačių 
# c(xmin, xmax, ymin, ymax) vektorius. Turint jau nubraižytą grafiką, jas galima 
# gauti naudojant funkciją par.

hist(Nile)

ribos <- par("usr")
ribos

# Turint tokias koordinates, rėmelį ant grafiko galima uždėti naudojant funkciją
# abline. Tam reikia nubraižyti dvi vertikalias ir dvi horizontalias linijas.

abline(v = ribos[1:2], h = ribos[3:4])


# Funkcijos grid galimybės gan ribotos, todėl tinklelio braižymui galima naudoti 
# funkciją abline. Pavyzdžiui, nubraižysime sinusoidės grafiką, kuriame Ox ašies 
# sudalinimo taškai kas pi/2, o tinklelio linijos dvigubai tankesnės -- kas pi/4.

curve(sin, -pi, pi, xaxt = "n")

axis(1, at = seq(-pi, pi, pi/2), labels = expression(-pi, -pi/2, 0, pi/2, pi))

abline(v = seq(-pi, pi, pi/4), col = "lightgray", lty = "dotted")
abline(h = seq(-1., 1., 0.25), col = "lightgray", lty = "dotted")


# Tinklelis nebūtinai turi būti tolygus. Pvz., nubraižysime eksponentės grafiką,
# kuriame tarpai tarp vertikalių tinklelio linijų taip pat eksponentiškai didėja.

curve(exp, 0, 4)
abline(v = exp(0:30/10) - 1, col = "gray")


# Tinklelį galima nubraižyti ir gana egzotišku būdu. Galima pasinaudoti tuo, kad
# ašies padalijimo brūkšnelių ilgį galima išreikšti per grafiko ilgį arba plotį. 
# Jeigu parametrui tck priskiriame reikšmę 1, tai brūkšnelio ilgis, priklausomai 
# ašies, sutampa su viso grafiko aukščiu arba pločiu.

curve(sin, -pi, pi)
axis(1, tck = 1, col.ticks = "lightgray", lty = "dotted")
axis(2, tck = 1, col.ticks = "lightgray", lty = "dotted")


# UŽDUOTIS ------------------------------ 

# 1. Nubraižykite dažnių lentelės d stulpelinę diagramą. Papildomai uždėkite jai
#    rėmelį, tačiau taip, kad aukščiausias stulpelis su rėmeliu nesiliestų.
# 2. Nubraižykite funkcijos y = x*sin(x) grafiką intervale [0, 5pi]. Suformuokit
#    tokį tinklelį, kur vertikalios ir horizontalios linijos eitų per funkcijos
#    lokalių minimumų ir maksimumų taškus.