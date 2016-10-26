
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Grafiniai parametrai.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2014-06-24 | 0215-02-14 | 2015-02-26
#


# TURINYS -------------------------------

#
#   1. Grafinių parametrų reikšmės nustatymas:
#      * funkcija par
#      * parametras no.readonly
#      
#   2. Bendro pobūdžio grafiniai parametrai:
#      * new
#      * ask
#      * ann
#      * adj
#      * bty
#      * lty
#      * lwd
#      * lend
#      * ljoin
#      * lmitre
#      * pch
#
#   3. Grafiko spalvos, mastelis ir antraščių šriftas:
#      * bg
#      * fg
#      * col
#      * cex
#      * font
#      * family
#
#   4. Su ašių braižymu susiję grafiniai parametrai:
#      * xaxt ir yaxt
#      * xaxp ir yaxp
#      * xaxs ir yaxs
#      * xlog ir ylog
#      * lab
#      * mgp
#      * tck ir tcl
#      * las
#
#   5. Grafinio lango padalinimas, išmatavimai ir paraštės:
#      * mfrow ir mfcol
#      * mfg
#      * mar ir mai
#      * oma ir omi
#      * fin ir pin
#      * omd
#      * fig ir plt
#      * pty
#      * usr
#      * xpd
#
#   6. Teksto grafiniai parametrai:
#      * ylbias
#      * lheight
#      * mex
#      * srt ir crt
#      * ps
#
#   7. Parametrai, kurių reikšmės pakeisti negalima:
#      * csi, cin, cra, cxy
#      * din
#      * page
#      * err
#      * mkh
#      * smo
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
# GRAFINIŲ PARAMETRŲ REIKŠMĖS NUSTATYMAS  #
# --------------------------------------- #

# Bet kuri diagrama turi daug grafinių elementų: koordinačių ašys, jų padalinimo
# taškai, paraštės, grafiko antraštė ir atskirų ašių pavadinimai, šriftų, linijų 
# ir taškų tipas, dydis, spalva ir visa kita. Priklausomai nuo grafiko kai kurie 
# jo elementai gali būti ir nebraižomi. Pavyzdžiui, kartais nubraižoma tik viena 
# koordinačių ašis, nevisada reikalingas grafiko rėmelis, ašies ar viso grafiko 
# antraštė ir pan.

# Visų grafinių elementų išvaizda kontroliuojama vienu ar keliais parametrais. 
# Visų parametrų reikšmes galima pažiūrėti naudojant funkciją par().

par()

# Nurodžius grafinių parametrų vardų vektorių, funkcija par grąžina jų reikšmes.
# Pavyzdžiui, linijos tipą ir storį kontroliuoja parametrai lty ir lwd. Gausime
# jų reikšmes.

par(c("lty", "lwd"))


# Jei nenurodyta kitaip, visos grafinės funkcijos naudoja standartines parametrų
# reikšmes. Jas galima pakeisti naudojant tą pačią funkciją par(). 

# Pavyzdžiui, loginis parametras ann nustato, ar grafikas bus braižomas su ašies
# pavadinimu ir antrašte. Priskirdami reikšmę FALSE, uždrausime visas antraštes.

par(ann = FALSE)
curve(sin, -pi, pi, main = "Grafiko antraštė", xlab = "x", ylab = "sin(x)")

# Atstatome pradinę parametro reikšmę TRUE, todėl visi grafikai vėl bus braižomi 
# su antraštėmis ir ašių pavadinimais.

par(ann = TRUE)
curve(sin, -pi, pi, main = "Grafiko antraštė", xlab = "x", ylab = "sin(x)")


# Analogiškai galima nustatyti iš karto kelių grafinių parametrų reikšmes. Pvz.,
# nustatysime, kad visų grafikų fono spalvą būtų pilka, o linijų spalva raudona.

par(bg = "gray", fg = "red")
curve(sin, -pi, pi, main = "Grafiko antraštė", xlab = "x", ylab = "sin(x)")

par(bg = "transparent", fg = "black")
curve(sin, -pi, pi, main = "Grafiko antraštė", xlab = "x", ylab = "sin(x)")


# Grafinio parametro reikšmės nustatymui naudojant funkciją par, jo poveikis yra
# globalus - tą pačią parametro reikšmę naudoja visos grafinės funkcijos. Tačiau
# dalies parametrų reikšmes galima pakeisti per grafines funkcijas. Tokiu atveju
# parametro reikšmės pasikeitimas turi įtakos tik vienam grafikui.

# Pavyzdžiui, parametras font reguliuoja koordinačių ašių ir kitų grafiko dalių 
# šriftą. Pagal nutylėjimą jo reikšmė lygi 1, kurią atitinka plain text šriftas.

par("font")

# Tokį šriftą naudoja visi grafikai, tačiau konkrečiame grafike naudojamą šriftą 
# galima pakeisti nurodant jo reikšmę per kokią nors grafinę funkciją. Parametro 
# font reikšmę pakeisime į 2, kurią atitinka pastorintas šriftas.

curve(sin, -pi, pi, main = "Grafiko antraštė", xlab = "x", font = 2)

# Galima pastebėti, kad globali parametro reikšmė išliko nepakitusi, todėl visi
# kiti grafikai bus braižomi naudojant standartinį šriftą.

par("font")


# NAUDINGA ------------------------------

# Grafinio parametro reikšmės pakeitimui naudojant funkciją par, pradinė reikšmė
# prarandama, todėl pakeitus kelių parametrų reikšmes, vėliau atstatyti pradines 
# jų reikšmes ir grįžti prie įprasto grafikų vaizdo gali būti sudėtinga. Kadangi
# visų parametrų reikšmės saugomos viename sąraše, prieš atliekant pakeitimus jį 
# galima išsaugoti ir vėliau atstatyti.

# Pavyzdžiui, išsaugosime keletos grafinių parametrų reikšmes, kurias pakeisime,
# o nubraižius grafiką, atstatysime atgal.

original.par <- par(c("adj", "bg", "col", "lwd", "bty"))

par(adj = 0.3, bg = "gray", col = "red", lwd = 2, bty = "n")
curve(sin, -pi, pi, main = "Grafiko antraštė", xlab = "x", ylab = "sin(x)")

par(original.par)

# Atstačius pradines parametrų reikšmes, braižomas įprastas grafikas.
curve(sin, -pi, pi, main = "Grafiko antraštė", xlab = "x", ylab = "sin(x)")


# Galima išsaugoti iš karto visų grafinių parametrų reikšmes. Problema tame, kad
# ne visų parametrų reikšmes galima pakeisti, dalis iš jų yra "read only". Todėl
# parametrui no.readonly priskirdami reikšmę TRUE, išsaugome tik tuos parametrus, 
# kuriems vėliau bus galima grąžinti pradines jų reikšmes.

original.par <- par(no.readonly = TRUE)

par(adj = 0.3, bg = "gray", col = "red", lwd = 2, bty = "n")
curve(sin, -pi, pi, main = "Grafiko antraštė", xlab = "x", ylab = "sin(x)")

par(original.par)

# Atstačius pradines parametrų reikšmes, braižomas įprastas grafikas.
curve(sin, -pi, pi, main = "Grafiko antraštė", xlab = "x", ylab = "sin(x)")


# UŽDUOTIS ------------------------------ 

# 1. Užrašykite dvi komandas, kurios a) apskaičiuotų grafinių parametrų skaičių,
#    b) sudarytų visų grafinių parametrų pavadinimų vektorių.
# 2. Užrašykite komandą, kuri sudarytų vektorių tų grafinių parametrų, kurie yra
#    "read only".


# --------------------------------------- #
# BENDRO POBŪDŽIO GRAFINIAI PARAMETRAI    #
# --------------------------------------- #

# Grafiko braižymui naudojant aukšto lygio grafinę funkciją, anksčiau atidarytas 
# grafinis langas yra išvalomas. Tai atlieka funkcija plot.new(), kuri suvykdoma
# automatiškai dar prieš aukšto lygio grafinę funkciją. Taip grafinis langas yra
# paruošiamas naujo grafiko braižymui. Tačiau šią taisyklę galima anuliuoti. Tam
# naudojami šie grafiniai parametrai: 
# 
#        new -- loginis, nustato, ar naujas grafikas braižomas ant senojo,
#        ask -- loginis, nustato, ar prieš braižant grafiką reikia patvirtinimo.

# Pvz., naudojant funkciją curve, nubraižysime funkcijų y = sin(x) ir y = cos(x) 
# grafikus. F-ja curve yra aukšto lygio grafinė funkcija, todėl kiekvieną naują
# grafiką ji braižo iš naujo.

curve(sin, -pi, pi)
curve(cos, -pi, pi)

# Matome, kad kiekvienas naujas grafikas panaikina prieš tai nubraižytą grafiką.
# Parametrui new priskiriant reikšmę TRUE, grafinis langas interpretuojamas kaip
# naujas, todėl, prieš suvykdant aukšto lygio grafinę funkciją, jis neišvalomas.
# Tokiu naujas grafikas braižomas ant senojo viršaus.

curve(sin, -pi, pi)
par(new = TRUE)
curve(cos, -pi, pi, ann = FALSE, axes = FALSE, col = "red")


# Paprastai naujas grafikas nubraižomas iš karto, kai tik įvykdoma grafinė f-ja.
# Šią taisyklę nustato parametras ask, kurio standartinė reikšmė yra FALSE.

par("ask")

# Jeigu parametrui priskiriame reikšmę TRUE, tai, įvykdžius aukšto lygio grafinę
# funkciją, grafikas nubraižomas ne iš karto, o laukiama patvirtinimo -- klavišo
# Enter paspaudimo arba pelės klavišo paspaudimo ant grafiko.

curve(sin, -pi, pi)
par(ask = TRUE)
plot(cars)
hist(Nile)


# Yra keletas grafinių parametrų, kurie nustato bendro pobūdžio grafikų savybes:
#
#        ann -- loginis, leidžia arba uždraudžia grafiko ir ašių antraštes,
#        adj -- nustato horizontalų antraštės ir ašių pavadinimų išlygiavimą,
#        bty -- nustato grafiko rėmelio tipą,
#        lty -- nustato linijos tipą,
#        lwd -- nustato linijos storį,
#        pch -- nustato taško simbolį.


# Pavyzdžiui, loginis parametras ann nustato, ar grafike vaizduojama antraštė ir 
# koordinačių ašių pavadinimai. Pagal nutylėjimą šio parametro reikšmė lygi TRUE,
# tačiau pakeitus į FALSE, visi grafikai bus braižomi be antraščių ir pavadinimų.

par(ann = FALSE)
curve(sin, -pi, pi, main = "Grafiko antraštė", xlab = "x", ylab = "sin(x)")
curve(cos, -pi, pi, main = "Grafiko antraštė", xlab = "x", ylab = "cos(x)")

par(ann = TRUE)
curve(sin, -pi, pi, main = "Grafiko antraštė", xlab = "x", ylab = "sin(x)")

# Kartais reikia uždrausti konkretaus grafiko antraštes. Tokiu atveju paprasčiau
# parametro ann reikšmę keisti per grafinę funkciją. Pvz., funkcija curve uždeda
# ašių pavadinimus automatiškai. Jeigu jie nereikalingi, tai naudojant parametrą 
# ann juos galima uždrausti.

curve(sin, -pi, pi)
curve(sin, -pi, pi, ann = FALSE)


# Naudojant parametrą adj, nustatomas antraštės ir ašių pavadinimų išlygiavimas.
# Parametro reikšmė 0.5 atitinka centravimą, 0 arba 1 atitinka išlygiavimą pagal
# kairįjį arba dešinįjį eilutės kraštą.

# Pavyzdžiui, nustatysime tokią parametro adj reikšmę, kad antraštė būtų kairėje
# eilutės pusėje, bet ne prie pat krašto.

par(adj = 0.3)
curve(sin, -pi, pi, main = "Grafiko antraštė", xlab = "x", ylab = "sin(x)")

# Vieno grafiko antraštės išlygiaviams keičiamas per grafinę funkciją. Pvz., čia
# nurodysime, kad antraštė būtų išlygiuota pagal dešinįjį eilutės kraštą.

curve(sin, -pi, pi, main = "Grafiko antraštė", adj = 1)


# Parametras bty kontroliuoja grafiko rėmelio braižymą. Jei parametrui priskirta
# reikšmė "o", rėmelis braižomas, jeigu reikšmė "n" -- nebraižomas.

par(bty = "n")
curve(sin, -pi, pi)

# Kai kurios aukšto lygio grafinės funkcijos rėmelio nebraižo, net ir tuo atveju,
# jei parametrui bty priskiriama reikšmė "o". Pavyzdžiui, histograma, nubraižyta
# naudojant funkciją hist, visada yra be rėmelio.

par(bty = "o")
hist(Nile, main = "Histograma be rėmelio, nors jis turėtų būti")

# Parametrui bty galima priskirti reikšmes "l", "7", "c", "u", "]". Tokiu atveju
# rėmelis bus braižomas ne iš visų keturių pusių. Pavyzdžiui, reikšmė "l" nurodo,
# kad rėmelis bus braižomas tik iš kairės ir apačios.

par(bty = "l")
curve(sin, -pi, pi)

# Jei rėmelio braižymo taisyklę reikia pakeisti konkrečiam grafikui, tai reikšmę 
# parametrui bty galima priskirti per grafinę funkciją. Pvz., uždrausime rėmelio
# braižymą vienam funkcijos grafikui.

curve(sin, -pi, pi, main = "Grafiko antraštė", bty = "n")

# Jei grafikas braižomas su funkcijomis plot, curve ir pan., leisti ar uždrausti 
# rėmelį galima naudojant loginį parametrą frame.plot.

curve(sin, -pi, pi, main = "Grafiko antraštė", frame.plot = FALSE)


# Parametras lty nustato linijos tipą. Jam galima priskirti tokias simbolines ar
# jas atitinkančias skaitines reikšmes:
# 
#          0 -- blank,
#          1 -- solid,
#          2 -- dashed,
#          3 -- dotted,
#          4 -- dotdash,
#          5 -- longdash,
#          6 -- twodash.

# Paprastai diagramos braižomos ištisine (solid) linija. Jei viename grafike yra
# linijos, kurios turi išsiskirti, jų tipą galima pakeisti per grafinę funkciją.
# Pavyzdžiui, ištisine linija nubraižysime funkcijos y = sin(x) grafiką, o tiesę
# y = 0 tame pačiame grafike nubraižysime punktyrine linija.

curve(sin, -pi, pi)
abline(h = 0, lty = 3)


# Parametras lwd nustato linijos storį. Laikoma, kad standartinės linijos storis
# lygus 1. Didesnės parametro reikšmės nurodo grafinėms funkcijoms, jog diagrama 
# turi būti braižoma naudojant storesnę liniją.

par("lwd" = 2)
curve(sin, -pi, pi)
abline(h = 0)

# Galima pastebėti, kad pastorinta linija braižomas ir grafiko rėmelis. Taip pat
# pastorinta linija braižoma histograma, stačiakampė diagrama ir kitos diagramos.

hist(Nile)
boxplot(Nile)

graphics.off()


# Yra keli grafiniai parametrai, kurie reguliuoja linijų sujungimą ir galų formą.
# Plonoms linijoms jų poveikis yra praktiškai nepastebimas, bet storoms - matosi. 
# Parametrai tokie:
#
#       lend -- nustato linijos galų suapvalinimo būdą,
#      ljoin -- nustato linijų sujungimo būdą,
#     lmitre -- nustato linijų sujungimo smaigalio nukirtimą.

# Parametrui lend galima priskirti reikšmę 0 (standartinė), 1 arba 2. Pavyzdžiui,
# nubraižysime grafiką, kuriame vienas ant kito pavaizduoti 3 tos pačios linijos
# galai. Raudona spalva nubraižytas standartinis variantas.

y <- c(10, 1, 10)

par(lend = 2)
plot(y, type = "l", lwd = 40, xlim = c(0.5, 3.5), ylim = c(0, 11))

par(lend = 0)
points(y, type = "l", lwd = 40, col = "red")

par(lend = 1)
points(y, type = "l", lwd = 40, col = "blue")

graphics.off()


# Parametras ljoint nustato, kaip linija atvaizduojama lūžio ar sujungimo taške. 
# Standartinė parametro reikšmė 0, kitos reikšmės - 1 arba 2. Pvz., nubraižysime
# tris tos pačios laužtės variantus, iš kurių matosi, kaip gali būti sujungiamos
# tiesės: sujungimas gali būti suapvalintas, smailas arba nukirstas.

y <- c(10, 1, 10)

par(ljoin = 0)
plot(y, lwd = 40, type = "l", ylim = c(0, 18))

par(ljoin = 1)
lines(y + 3, lwd = 40, type = "l")

par(ljoin = 2)
lines(y + 6, lwd = 40, type = "l")

graphics.off()


# Parametras lmitre nustato, kaip atvaizduoti linijų sujungimo taške susidarantį
# smaigalį -- trumpesnį ar ilgesnį. Parametrui galima priskirti skaičių didesnį 
# už 1, standartinė jo reikšmė lygi 10. Pvz., nubraižysime du tos pačios laužtės
# fragmento variantus, iš kur matyti, kad, didinant parametro reikšmę, smaigalys
# paliekamas ilgesnis.

y <- c(0, 50, 0)
x <- c(-1, 0, 1)

par(ljoin = 1)
plot(x - 4, y, lwd = 10, type = "l", ylim = c(0, 70), xlim = c(-20, 20))

par(ljoin = 1, lmitre = 30)
lines(x + 4, y, lwd = 10, type = "l")

graphics.off()


# Parametras pch nustato, kokiu simboliu grafike vaizduojamas taškas. Jo reikšmė
# gali būti skaičius nuo 0 iki 25, kuris atitinka specialų simbolį. Standartinis
# taško simbolis yra nedidelis apskritimas, kurį atitinka parametro reikšmė 1.

# Pavyzdžiui, parametrui priskirsime reikšmę 20. Tada sklaidos diagramoje taškas
# bus vaizduojamas pilnu tašku.

par("pch" = 20)
plot(dist ~ speed, data = cars)

# Parametrui galima priskirti ir bet kokį tekstinį simbolį iš klaviatūros. Pvz.,
# jei grafike yra labai daug taškų, jų vaizdavimui galima parinkti įprasto taško
# iš klaviatūros simbolį. Parametro reikšmę pakeisime per grafinę funkciją.

plot(rnorm(100000), rnorm(100000), pch = ".")


# UŽDUOTIS ------------------------------ 

# 1. Naudojant parametrą lty, nubraižykite funkcijos y = sin(x) grafiką, kuriame
#    pati sinusoidė būtų nematoma! Sugalvokite dar kitų būdų nubraižyti nematomą
#    kreivę.
# 2. Viename grafike nubraižykite funkcijų sin(x) ir cos(x) grafikus. Kurią nors
#    vieną kreivę pavaizduokite ištisine, o kitą -- punktyrine linija.
# 3. Pakeiskite grafinius parametrus taip, kad visos diagramos būtų braižomos be
#    rėmelio, taško simbolis pakeistas į užpildytą tašką, o linijos plonesnės.


# --------------------------------------- #
# GRAFIKO SPALVOS, MASTELIS IR ŠRIFTAS    #
# --------------------------------------- #

# Dalis grafinių parametrų reguliuoja grafiko fono, taškų, linijų, ašių, rėmelio
# spalvas, antraščių šriftą ir simbolių dydį:
# 
#         bg -- grafiko fono spalva,
#         fg -- linijų, taškų, rėmelio ir koordinačių ašių spalva,
#        col -- linijų, taškų, rėmelio spalva,
#        cex -- grafiko taškų ir antraščių dydis,
#       font -- šrifo tipas,
#     family -- šrifto šeima.

# Parametras bg nustato grafiko fono spalvą, o parametras fg -- bendrą diagramos
# taškų ir linijų, koordinačių ašių ir rėmelio spalvą. Fono spalva priklauso nuo
# įrenginio tipo, bet paprastai fonas būna baltas, o kitos linijos juodos.

par(c("bg", "fg"))

# Pavyzdžiui, pakeisime fono spalvą į pilką, o linijų ir taškų spalvą į raudoną.

par(bg = "gray", fg = "red")
plot(dist ~ speed, data = cars, pch = 20)


# Parametras col taip pat nustato linijų, taškų ir rėmelio spalvą, tačiau negali
# pakeisti koordinačių ašių spalvos!

par(col = "red")
plot(dist ~ speed, data = cars, pch = 20, frame = FALSE)


# Diagramos taško simbolio, antraščių teksto, ašies padalų ir jų pavadinimų dydį 
# nustato mastelio parametras cex. Didinant parametro reikšmę, taškai ir tekstas 
# didėja, mažinant -- mažėja. Standartinė parametro reikšmė lygi 1.

# Pavyzdžiui, jeigu antraštės tekstas ir diagramos taškai turi būti 20 % didesni, 
# tai parametrui cex priskiriame reikšmę 1.2.

par(cex = 1.2)
plot(dist ~ speed, data = cars, pch = 20)


# Parametras font nustato, koks šriftas naudojamas tekstui ant grafiko užrašyti.
# Galimos reikšmės:
#
#          1 -- plain text,
#          2 -- bold face,
#          3 -- italic,
#          4 -- bold italic.

# Pvz., nustatysime, kad tekstas ant grafiko būtų rašomas pastorintu šriftu. Tam
# parametrui font priskiriame reikšmę 2. Tekstą ant grafiko užrašome su funkcija
# text.

par(font = 2)
plot(1, 1, type = "n", main = "Grafiko antraštė")
text(1, 1, "Tekstas pastorintu šriftu.")


# Šriftų, kuriuo rašomos grafiko ir ašių antraštės bei padalų pavadinimai, šeimą 
# nusako parametras family. Standartinė parametro reikšmė yra "", kiti variantai 
# tokie:
# 
#      serif -- lotyniškas šriftas, pvz., Times,
#       sans -- groteskinis šriftas, pvz., Aria, Helvetica,
#       mono -- pastovaus pločio šriftas, pvz., Courier.

# Pavyzdžiui, pakeisime parametro reikšmę taip, kad visos grafiko antraštės būtų
# rašomos pastovaus pločio šriftu.

par(family = "mono")
plot(dist ~ speed, data = cars, main = "Grafiko antraštė")


# Keičiant parametrų col, cex ir font reikšmes, nustatoma bendra įvairių grafiko 
# dalių spalva, vienodas mastelis arba tas pats šrifto tipas. Spalvą, mastelį ir
# šriftą galima pakeisti atskirai ašims, ašių antraštėms, bendrai bei papildomai 
# grafiko antraštėms. Tam naudojami šie grafiniai parametrai:
# 
#     col.axis    cex.axis    font.axis
#     col.lab     cex.lab     font.lab
#     col.main    cex.main    font.main
#     col.sub     cex.sub     font.sub

# Pavyzdžiui, nubraižysime grafiką, kuriame skaičiai ties padalomis 20 % didesni,
# o ašies antraštės užrašytos pasvirusiu pastorintu šriftu.

par(cex.axis = 1.2, font.lab = 4)
plot(dist ~ speed, data = cars, main = "Grafiko antraštė", frame = F)


# NAUDINGA ------------------------------

# Spalvos, mastelio ir šrifto parametrams reikšmę priskiriant per grafines f-jas,
# jų poveikis yra lokalus, t.y. galioja tik vienam konkrečiam grafikui. Svarbiau
# yra tai, kad šie parametrai skirtingai veikia reikšmę priskiriant per f-ją par
# ir per grafinę funkciją!

# Pavyzdžiui, parametrui bg reikšmę priskiriant per grafinę funkciją, jis keičia
# taško simbolio foną, bet ne grafiko foną. Tai galima pastebėti, jei parametrui
# pch priskiriama reikšmė 21, 22 ir t.t. iki 25.

plot(dist ~ speed, data = cars, bg = "red", pch = 21)

# Pavyzdžiui, parametrui fg reikšmę priskiriant per grafinę funkciją, jis keičia 
# tik ašių ir rėmelio spalvą, bet nekeičia kitų grafiko linijų ir taškų spalvos.

plot(dist ~ speed, data = cars, fg = "red")


# Analogiškai, parametro col reikšmę priskiriant per grafinę funkciją, nustatome
# tik taško simbolio spalvą.

plot(dist ~ speed, data = cars, pch = 20)
plot(dist ~ speed, data = cars, pch = 20, col = "red")


# Pavyzdžiui, parametro cex reikšmę priskiriant per grafinę funkciją, pakeičiame
# tik taško simbolio dydį.

plot(dist ~ speed, data = cars)
plot(dist ~ speed, data = cars, cex = 2)


# Parametras font, jeigu jo reikšmė priskiriama per grafinę funkciją, keičia tik 
# padalų skaičių šriftą.

plot(dist ~ speed, data = cars, pch = 20)
plot(dist ~ speed, data = cars, pch = 20, font = 2)


# UŽDUOTIS ------------------------------ 

# 1. Grafinius parametrus pakeiskite taip, kad grafiko fonas būtų juodas, taškai
#    ir linijos -- balti.
# 2. Nubraižykite sklaidos diagramą plot(dist ~ speed, data = cars). Nustatykite
#    grafinius parametrus taip, kad taškai būtų raudoni, o ašys mėlynos spalvos.
#    Sugalvokite kelis skirtingus būdus.
# 3. Sugalvokite, kaip nubraižyti apskritimą, jei grafike galima pavaizduoti tik
#    vieną tašką.
# 4. Tarkime, kad mastelio parametro cex reikšmė priskiriama taip: par(cex = 2).
#    Sugalvokite būdą, kaip nubraižyti diagramą, kad antraštės joje būtų įprasto
#    dydžio, lyg parametro cex reikšmė būtų lygi 1.


# --------------------------------------- #
# KOORDINAČIŲ AŠIŲ PARAMETRAI             #
# --------------------------------------- #

# Daug grafinių parametrų kontroliuoja koordinačių ašių sudarymą bei atskiras jų
# dalis. Tarp jų yra grupė parametrų, kurie nustato atskirų ašių braižymą:
#
#       xaxt -- uždraudžia arba leidžia braižyti Ox ašį,
#       yaxt
#       xaxp -- nustato Ox ašies ribas ir padalinimų skaičių,
#       yaxp
#       xaxs -- nustato Ox ašies ilgio apskaičiavimo būdą,
#       yaxs
#       xlog -- loginis, nurodo ar Ox ašis bus logaritminėje skalėje.
#       ylog

# Braižant grafiką, funkcija plot, hist ar kitos aukšto lygio grafinės funkcijos 
# automatiškai nubraižo ir koordinačių ašis. Parametrui xaxt arba yaxt nurodžius 
# reikšmę "n", uždraudžiama uždėti atitinkamai Ox arba Oy ašį. Reikšmę priskirti
# galima naudojant funkciją par. Pavyzdžiui, nustatysime, kad visi grafikai būtų
# braižomi be Ox ašies.

par(xaxt = "n")

curve(sin, -pi, pi, frame = FALSE)
plot(Nile)

# Pagal nutylėjimą šių parametrų reikšmės yra "s". Atstatysime pradinę parametro
# reikšmę, priešingu atveju visi kiti grafikai toliau būtų braižomi be Ox ašies.

par(xaxt = "s")

curve(sin, -pi, pi, frame = FALSE)
plot(Nile)


# Šių grafinių parametrų reikšmes galima pakeisti naudojant aukšto lygio grafinę 
# funkciją. Tokiu atveju kuri nors ašis nebraižoma tik šiame konkrečiame grafike.
# Pavyzdžiui, nubraižysime funkcijos grafiką ir, keisdami šių parametrų reikšmes,
# nurodysime, kurių ašių nerodyti.

curve(sin, -pi, pi)
curve(sin, -pi, pi, frame = FALSE)
curve(sin, -pi, pi, frame = FALSE, xaxt = "n")
curve(sin, -pi, pi, frame = FALSE, yaxt = "n")
curve(sin, -pi, pi, frame = FALSE, xaxt = "n", yaxt = "n")


# Ašių Ox ir Oy ribas ir padalijimo intervalų skaičių kontroliuoja du parametrai 
# xaxp ir yaxp. Tokio parametro reikšmė yra vektorius c(min, max, k), kur min ir 
# max yra mažiausia ir didžiausia ašies ribos, o k yra intervalų, į kuriuos ašis
# padalijama, skaičius. Braižant grafiką reikšmės šiems parametrams priskiriamos 
# automatiškai. Jas galima gauti naudojant funkciją par.

curve(sin, -pi, pi, frame = FALSE)
par("xaxp")
par("yaxp")


# Galima pastebėti, kad funkcijos grafikas braižomas intervale [-pi, pi], tačiau
# Ox ašies ribos nesutampa ir yra šiek tiek siauresnės. Nubraižius kitą grafiką, 
# parametrams priskiriamos jį atitinkančios naujos reikšmės.

curve(sin, -2*pi, pi, frame = FALSE)
par("xaxp")
par("yaxp")

# Parametrui xaxp arba yaxp reikšmę galima priskirti tiesiogiai per aukšto lygio 
# grafinę funkciją. Tokiu būdu galima kontroliuoti ašies padalinimą į intervalus.
# Pvz., nubraižysime grafiką, kuriame Ox ašis bus nuo -3 iki 1 ir padalinta į dvi 
# lygias dalis.

curve(sin, -pi, pi, frame = FALSE, xaxp = c(-3, 1, 2))


# Parametrai xaxs ir yaxs nustato taisyklę, pagal kurią nustatomos ašių Ox ir Oy
# ribos. Parametrui priskyrus reikšmę "r", parenkamos tokios ašies ribos, kurios 
# yra 4 % didesnės nei duomenų kitimo intervalas ir pagal tai randami padalijimo 
# taškai. Jei priskiriama reikšmė "i", tai ašies ribos sutampa su duomenų kitimo 
# riba.

# Pvz., nubraižysime funkcijos y = sin(x) grafiką intervale [-pi, pi]. Priskyrus
# parametrams reikšmę "i", funkcijos grafikas liečia ir ašį Ox, ir ašį Oy. 

par(xaxs = "i", yaxs = "i")
curve(sin, -pi, pi)
abline(v = -pi, col = "red")

# Pagal nutylėjimą abiems parametrams priskiriama reikšmė "r", todėl abiejų ašių 
# ribos yra platesnės.

par(xaxs = "r", yaxs = "r")
curve(sin, -pi, pi)
abline(v = -pi, col = "red")


# Parametro xlog reikšmė TRUE nurodo, kad Ox ašis yra logaritminėje skalėje. Kai
# nubraižomas naujas grafikas, parametrui automatiškai priskiriama reikšmę FALSE.
# Ji pasikeičia, kai aukšto lygio grafinė funkcija sudaro grafiką su logaritmine
# ašimi. Lygiai tas pats galioja ir parametrui ylog.

# Pavyzdžiui, nubraižysime dvi stulpelines diagramas, vieną su įprasta Oy ašimi,
# kitą - su logaritmine. Galima pastebėti, kad pirmuoju atveju parametro reikšmė
# yra FALSE, o tuos pačius duomenis atvaizdavus logaritminėje skalėje, parametro 
# reikšmė pasikeičia į TRUE.

barplot(c(1, 10, 100))
par("ylog")

barplot(c(1, 10, 100), log = "y")
par("ylog")


# Yra dar keletas grafinių parametrų, kurie kontroliuoja abiejų koordinačių ašių 
# ir atskirų jų dalių braižymą:
# 
#        lab -- apytikslis Ox ir Oy ašių padalų skaičius,
#        mgp -- ašies antraštės, padalų teksto ir ašies linijos pozicija,
#        tck -- padalų ilgis santykiniais vienetais,
#        tcl -- padalų ilgis eilutės aukščio vienetais,
#        las -- nustatomas ašies padalos teksto pasukimas.

# Parametrui lab priskiriamas vektorius c(x, y, len), kur skaičiai x ir y nurodo
# apytikslį ašies Ox ir Oy padalų skaičių. Paskutinis elementas nurodo antraštės
# ilgį, tačiau R jis nenaudojamas. Standartinė parametro lab reikšmė c(5, 5, 7).

# Pvz., naudojant parametrą lab nurodysime, kad Ox ašis turėtų 3 padalas, o ašis 
# Oy -- 10 padalų.

par(lab = c(3, 10, 7))
curve(sin, -pi, pi, frame = FALSE)

# Kadangi parametro lab reikšmė yra tik rekomendacija ašių sudarymui, konkrečios 
# ašies galų reikšmės ir jos padalų skaičius kiekvienam grafikui apskaičiuojamas 
# vis kitaip. Tai parodo parametrų xaxp ir yaxp reikšmės.

par(c("xaxp", "yaxp"))

# Grafiką su tokiomis pat ašimis galima gauti parametrams xaxp ir yaxp priskyrus
# konkrečias reikšmes per aukšto lygio grafinę funkciją.

curve(sin, -pi, pi, frame = FALSE, xaxp = c(-2, 2, 2), yaxp = c(-1, 1, 10))


# Parametras mgp nustato ašies antraštės, teksto ties padalomis ir ašies linijos
# postūmį (eilutėmis) tikrosios ašies atžvilgiu. 

par("mgp")

# Parametro reikšmė c(3, 1, 0) nurodo, kad ašies antraštė yra trečioje eilutėje,
# padalų pavadinimai pirmoje, o grafike braižoma ašies linija sutampa su tikrąja 
# ašimi. Žinoma, šias reikšmes galima pakeisti. Pvz., padalų reikšmes perkelsime
# į kitą ašies pusę, o ašies liniją atitrauksime nuo tikrosios ašies linijos.

par(mgp = c(3, -0.3, 1.8))
curve(sin, -pi, pi, frame = FALSE)


# Brūkšnelių ties ašies sudalinimo taškais ilgį reguliuoja parametrai tck ir tcl.
# Naudojant tck, brūkšnelio ilgis yra santykinis ir priklauso nuo grafiko pločio
# arba ilgio. Naudojant tcl, brūkšnelio ilgis išreiškiamas per eilutės aukštį ir 
# pagal nutylėjimą jo reikšmė lygi -0.5. Pakeitus ženklą, brūkšneliai perkeliami
# į kitą ašies pusę.

# Pavyzdžiui, nubraižysime grafiką, kuriame padalos trumpesnės nei standartinės.
# Vienu atveju padalos bus nukreiptos į grafiko vidų, kitu -- į grafiko išorę.

par(tcl = -0.3)
curve(sin, -pi, pi, frame = FALSE)

par(tcl = 0.3)
curve(sin, -pi, pi, frame = FALSE)


# Naudojant parametrą tck, padalos ilgį galima susieti su grafiko dydžiu. Pvz.,
# nustatysime, kad padalos ilgis būtų 1 % nuo grafiko dydžio.

par(tck = -0.01)
curve(sin, -pi, pi, frame = FALSE)

# Jei padalos ilgis keičiamas tik vienam konkrečiam grafikui, reikšmę parametrui 
# galima priskirti per aukšto lygio grafinę funkciją. 

curve(sin, -pi, pi, frame = FALSE, tcl = -0.3)
curve(sin, -pi, pi, frame = FALSE, tck = 0.01)


# Parametras las nustato skaičių ties padalomis orientaciją ašies atžvilgiu. Jam 
# galima priskirti tokias reikšmes:
# 
#          0 -- padalų pavadinimai rašomi lygiagrečiai ašiai,
#          1 -- padalų pavadinimai rašomi horizontaliai,
#          2 -- padalų pavadinimai rašomi statmenai ašiai,
#          3 -- padalų pavadinimai rašomi vertikaliai.

# Standartiškai visuose grafikuose padalų pavadinimai rašomi lygiagrečiai ašiai, 
# todėl ašies Oy padalų pavadinimai skaitomi iš apačios į viršų, o tai nepatogu.
# Šią taisyklę galima pakeisti parametrui las priskiriant reikšmę 1.

par("las" = 1)
curve(sin, -pi, pi)

# Parametro reikšmę galima pakeisti ir per grafinę funkciją. Tai padalų užrašymo
# taisyklę pakeičiam tik tam vienam grafikui.

curve(sin, -pi, pi, las = 1)


# UŽDUOTIS ------------------------------ 

# 1. Nubraižykite sklaidos diagramą plot(dist ~ speed, data = cars). Nustatykite
#    tokias grafinių parametrų reikšmes, kad Ox ašies ribos būtų 10 ir 20, o jos
#    padalų skaičius (įskaitant ir galus) lygus 6.
# 2. Naudojant parametrą tck, nubraižykite bet kokios funkcijos y = f(x) grafiką 
#    su tinkleliu (paprastai tam naudojama funkcija grid).
# 3. Nubraižykite bet kokios funkcijos y = f(x) grafiką su koordinačių ašimis be
#    padalų brūkšnelių, bet su skaičiais ties padalomis.


# --------------------------------------- #
# GRAFIKO DALYS, IŠMATAVIMAI IR PARAŠTĖS  #
# --------------------------------------- #

# Grafinio lango suskaidymui į kelias vienodas dalis ir grafikų išdėstymo tvarką
# šiose grafinio lango dalyse nustato šie grafiniai parametrai:
# 
#      mfcol -- grafinį langą padalina į m x n dalis, užpildo stulpeliais,
#      mfrow -- grafinį langą padalina į m x n dalis, užpildo eilutėmis, 
#        mfg -- grafinio lango eilutė ir stulpelis, kuriame braižomas grafikas.

# Paprastai viename grafiniame lange braižomas vienas grafikas. Kartais susidaro
# situacija, kai grafiniame lange reikia nubraižyti iš karto kelis grafikus. Tai
# įprastas dalykas, kai reikia palyginti kelis analogiškus grafikus. Šiuo atveju 
# grafinis langas išskaidomas į kelias dalis. Tam naudojamas parametras mfrow ar
# mfcol. Parametrams priskiriamas du elementus turintis vektorius c(m, n), kur m 
# yra eilučių, o n stulpelių skaičius. Taip sudaroma m x n dydžio matrica, kurią
# užpildome grafikais. Grafikų išdėliojimo tvarka priklauso nuo parametro. Jeigu
# naudojamas parametras mfcol, tai grafikai išdėstomi stulpeliais, jei naudojame
# parametrą mfrow -- tada eilutėmis.

# Pavyzdžiui, naudojant parametrą mfrow, grafinį langą padalinsime į 2 x 2 dalis
# ir nubraižysime keturis skirtingus grafikus. Grafikai bus išdėstomi eilutėmis.

par(mfrow = c(2, 2))
curve(sin, -pi, pi)
plot(cars)
hist(Nile)
plot(Nile)


# Naudojant parametrą mfg, galima pakeisti standartinę grafikų išdėstymo tvarką.
# Pvz., 3 x 3 grafiniame lange pirmas grafikas braižomas pirmos eilutės pirmame
# stulpelyje. Sekančio grafiko vietą nurodome per parametrą mfg, šiuo atveju tai
# bus antros eilutės antrame stulpelyje, trečias iš eilės grafikas bus braižomas 
# trečios eilutės antrame stulpelyje.

par(mfrow = c(2, 2))
curve(sin, -pi, pi)
par(mfg = c(2, 2))
plot(cars)
par(mfg = c(3, 2))
hist(Nile)


# Grafiniame lange yra kelios viena į kitą įdėtos grafiko sritys. Pati mažiausia
# sritis (plot) apribota ašimis arba rėmeliu ir joje braižoma diagrama. Diagrama 
# paprastai turi paraštes, kuriose yra viso grafiko ir ašių antraštės. Kartu su 
# paraštėmis diagrama sudaro paveikslėlio sritį (figure). Paveikslėlis turi savo
# paraštes, su kuriomis ir užima visą grafinį langą (device). Paraštės priklauso 
# nuo šių grafinių parametrų:
#
#        mar -- diagramos paraščių plotis eilučių skaičiumi,
#        mai -- diagramos paraščių plotis coliais,
#        oma -- viso grafiko paraščių plotis eilučių skaičiumi,
#        omi -- viso grafiko paraščių plotis coliais.
#
# Paraštės turi savo numerius: 1 -- apačia, 2 -- kairė, 3 -- viršus, 4 -- dešinė.
# Paraštės pločio parametrui priskiriamas vektorius su keturių paraščių dydžiais.

# Kadangi diagramos paraštėse rašomi koordinačių ašių pavadinimai, padalų vardai
# ir viso grafiko antraštė, tai kiekvienos pusės paraštės plotis skiriasi. Pvz.,
# standartinės diagramos paraštės eilutėmis yra c(5.1, 4.1, 4.1, 2.1).

par("mar")

# Pavyzdžiui, nustatysime, kad paraštės iš visų pusių būtų dviejų eilučių pločio.

par(mar = c(2, 2, 2, 2))
curve(sin, -pi, pi)

graphics.off()

# Galima pastebėti, kad diagramoje nesimato ašių pavadinimų. Taip atsitiko todėl,
# kad koordinačių ašių pavadinimai rašomi ketvirtoje eilutėje, o paraščių plotis
# tik dvi eilutės.


# Jei nenurodyta kitaip, paveikslėlio paraštės lygios nuliui, todėl paveikslėlis
# užima visą grafinį langą. Pavyzdžiui, nustatysime, kad paveikslo paraštės būtų
# po dvi eilutes iš visų pusių. Papildomai nubraižysime vidinį išorinių paraščių 
# rėmelį.

par(oma = c(2, 2, 2, 2))
curve(sin, -pi, pi)
box("inner")

graphics.off()


# Paprastai vienas grafikas užima visą grafinį langą, tačiau šią taisyklę galima
# pakeisti. Kokią dalį grafinio lango užims įvairios grafiko sritys nustato keli
# grafiniai parametrai:
#
#        fin -- nurodo viso grafiko dydį grafiniame lange,
#        pin -- nurodo diagramos srities dydį,
#        omd -- nurodo išorinių grafiko paraščių koordinates grafiniame lange,
#        fig -- nurodo, kokią dalį grafiko sritis užims išorinių paraščių viduje,
#        plt -- nurodo, kokią dalį diagramos sritis užims grafiko srityje,
#        pty -- nurodo, ar grafikas bus kvadratinis, ar stačiakampis,
#        usr -- koordinačių ašių ribos,
#        xpd -- nurodo kokiose ribose galima braižyti taškus ir linijas.


# Standartiškai grafinis langas yra 7 x 7 colių dydžio. Tam tikrą šio lango dalį 
# užima diagrama, kuri kartu su ašimis, antraštėmis ir paraštėmis sudaro grafiką.
# Grafikas taip pat turi (išorines) paraštes, su kuriomis užpildo grafinį langą.
# Grafiko bei diagramos srities išmatavimai nustatomi per parametrus fin ir pin.

# Pvz., nustatysime, kad grafiko dalis grafiniame lange butų 5 x 5 colių dydžio,
# o nuo išorinių paraščių ją atskirsime raudonos spalvos rėmeliu.

par(fin = c(5, 5))
hist(Nile)
box("figure", col = "red")

graphics.off()

# Analogiškai, naudojant parametrą pin, nustatomi diagramos srities išmatavimai.
# Pvz., nustatysime 3 x 3 colių dydžio diagramos sritį, kurią apribosime mėlynos
# spalvos rėmeliu. Raudonas rėmelis, kaip ir anksčiau, žymi grafiko dalies ribas.

par(pin = c(3, 3))
hist(Nile)
box("plot", col = "blue")
box("figure", col = "red")

graphics.off()

# Kaip histograma įdėta į grafiką, o grafikas su išorinėmis paraštėmis į grafinį 
# langą, galima pademonstruoti pakeitus iš karto abiejų parametrų reikšmes.

par(fin = c(5, 5), pin = c(3, 3))
hist(Nile)
box("plot", col = "blue")
box("figure", col = "red")

graphics.off()


# Parametras omd nustato, kokiose grafinio lango ribose bus formuojamas grafikas.
# Jam priskiriamas 4 elementus turintis vektorius c(xmin, xmax, ymin, ymax), kur 
# elementų reikšmės yra iš intervalo [0, 1]. Tos reikšmės nurodo grafikui skirto 
# stačiakampio ribas grafiniame lange.

# Jei grafikas neturi išorinių paraščių, tada jis užima visą grafinį langą. Tada
# parametras omd = c(0, 1, 0, 1).

par("omd")

# Nustatysime, kad grafikas užimtų apatinę grafinio lango pusę. Kad būtų matyti,
# kur yra grafiko ribos, nubraižysime vidinį grafiko rėmelį.

par(omd = c(0, 1, 0, 0.5))
curve(sin, -pi, pi)
box("inner")

graphics.off()


# Nuo grafinio parametro fig priklauso, kokią dalį grafiko sritis (figure) užims 
# išorinėmis paraštėmis apribotame stačiakampyje. Jei išorinės paraštės nulinės,
# tada parametras fig nurodo, kokią dalį grafikas užims visame grafiniame lange.
# Paprastai grafiko sritis užima visą išorinėmis paraštėmis apribotą stačiakampį,
# kuris tiesiog sutampa su grafiniu langu. Tai rodo pradinės parametrų reikšmės:

par(c("omd", "fig"))

# Pvz., nustatysime, kad grafikas užimtų apatinę išorinėmis paraštėmis apribotos
# srities dalį.

par(fig = c(0, 1, 0, 0.5))
curve(sin, -pi, pi)
box("figure")

graphics.off()

# Vizualiai šis pavyzdys tarsi niekuo nesiskiria nuo ankstesnio, tačiau atidžiau
# pažvelgus, galima pastebėti, kad tą pačią grafinio lango dalį užima skirtingos
# grafiko sritys. Pirmuoju atveju tuščias plotas iš viršaus yra išorinė paraštė,
# antruoju atveju išorinės paraštės nulinės, o grafikas užima tik pusę paveikslo.

# Pvz., parametrų reikšmes nustatysime taip, kad grafikas užimtų dalį paveikslui 
# skirtos srities, o paveikslas užimtų tik dalį viso grafinio lango. Taip galima
# pastebėti, kad skirtingos grafiko sritys įdėtos viena į kitą.

par(omd = c(0.1, 0.9, 0.1, 0.9), fig = c(0.1, 0.9, 0.1, 0.9))
curve(sin, -pi, pi)
box("figure", col = "red")
box("inner", col = "blue")

graphics.off()


# Parametras plt kontroliuoja, kokią dalį grafike (figure) užima diagrama (plot).
# Kadangi diagramą riboja ašys, ašių padalos, skaičiai ties padalomis, antraštės
# yra už diagramos ribų. Dėl tos priežasties diagrama neužima viso grafiko ploto.

par("plt")

# Pavyzdžiui, parametro plt reikšmę pakeisime taip, kad grafike būtų matytis tik 
# ašių padalos ir jų pavadinimai, bet ašių antraštės jau nesimatytų.

par(plt = c(0.06, 0.99, 0.06, 0.99))
curve(sin, -pi, pi, xlab = "Ox ašies antraštės nesimato")

graphics.off()


# Parametro pty reikšmės "s" arba "m" nustato diagramos srities formą, kuri gali 
# būti kvadratinė ar stačiakampė. Pirmuoju atveju kvadrato kraštinė lygi grafiko
# srities kraštinių minimumui, todėl diagrama neužpildys visos grafiko srities.
# Pavyzdžiui, nustatysime, kad grafiko sritis užimtų pusę grafinio lango ir joje
# nubraižysime histogramą. Galima pastebėti, kad, priklausomai nuo parametro pty 
# reikšmės, histograma arba yra kvadratinė, arba užima visą grafiko sritį.

par(pty = "s", fig = c(0, 1, 0, 0.5))
hist(Nile)

par(pty = "m", fig = c(0, 1, 0, 0.5))
hist(Nile)

graphics.off()


# Parametro usr reikšmė -- vektorius su 4 elementais: c(xmin, xmax, ymin, ymax).
# Šio vektoriaus elementai nurodo diagramos braižymo ribas, kurios paprastai yra
# šiek tiek platesnės nei ašių ribos.

curve(sin, -pi, pi, frame.plot = FALSE)
par("usr")

# Jeigu parametrų xaxs ir yaxs reikšmė "i", tada diagramos ribos sutampa su ašių
# ribomis.

par(xaxs = "i", yaxs = "i")
curve(sin, -pi, pi, frame.plot = FALSE)
par("usr")


# Loginis parametras xpd nurodo, kurios srities ribose galima nubraižyti linijas
# ar taškus. Standartiškai linijos ir taškai braižomi tik diagramos ribose.

par(omd = c(0.1, 0.9, 0.1, 0.9), xpd = FALSE)
curve(sin, -pi, pi, main = "Raudona linija tik diagramos ribose")
abline(v = pi/2, col = "red")
box("figure")

par(omd = c(0.1, 0.9, 0.1, 0.9), xpd = TRUE)
curve(sin, -pi, pi, main = "Raudona linija grafiko ribose")
abline(v = pi/2, col = "red")
box("figure")

par(omd = c(0.1, 0.9, 0.1, 0.9), xpd = NA)
curve(sin, -pi, pi, main = "Raudona linija viso grafinio lango ribose")
abline(v = pi/2, col = "red")
box("figure")

graphics.off()


# NAUDINGA ------------------------------

# Tradicinis būdas nubraižyti kelis grafikus viename lange -- naudoti parametrus
# mfrow arba mfcol. Tą patį galima padaryti ir naudojant parametrą fig, nurodant
# kažkurią grafinio lango dalį ir nubraižant joje grafiką. Tokiu būdu grafiniame
# lange galima išskirti kelias dalis, kuriose braižomas vis kitas grafikas.

# Reikia žinoti, kad parametrui fig priskiriant naują reikšmę, sukuriamas naujas
# grafikas. Norint, kad anksčiau nubraižytas grafikas išliktų, reikia nustatyti,
# kad aukšto lygio grafinės funkcijos grafiką braižytų ant viršaus. Šiam tikslui
# naudojamas grafinis parametras new.

# Pvz., kairės pusės apatiniame ir dešinės pusės viršutiniame kampe nubraižysime
# po vieną grafiką.

par(fig = c(0, 0.5, 0, 0.5))
curve(sin, -pi, pi)
box("figure")
par(fig = c(0.5, 1, 0.5, 1), new = TRUE)
hist(Nile)
box("figure")


# Analogiškai galima išnaudoti ir parametrą omd. Pavyzdžiui, naudojant parametrą
# omd, iš pradžių išskirsime apatinę grafinio lango dalį, o vėliau ir viršutinę.
# Abiejose dalyse nubraižysime po funkcijos grafiką.

par(omd = c(0, 1, 0, 0.5))
curve(sin, -pi, pi)
par(omd = c(0, 1, 0.5, 1), new = TRUE)
curve(cos, -pi, pi)


# UŽDUOTIS ------------------------------ 

# 1. Naudojant parametrą mfcol, grafiniame lange nubraižykite 3 duomenų rinkinio
#    Nile grafikus: laiko eilutę, dažnių histogramą ir boxplot diagramą.
# 2. Nubraižykite funkcijos y = sin(x) grafiką, kur būtų tik funkcijos kreivė be
#    koordinačių ašių, ašių padalų ir antraščių.
# 3. Kiekvienas grafikas turi paraštes, todėl, viename grafiniame lange braižant
#    kelis grafikus, tarp jų susidaro pernelyg dideli tarpai. Pirmoje užduotyje
#    grafikus nubraižykite taip, kad tarp jų nebūtų nereikalingų paraščių.
# 4. Užrašykite tokią komandą, kuri bet kokio tipo diagramos centre uždėtų žalią 
#    tašką.


# --------------------------------------- #
# TEKSTO GRAFINIAI PARAMETRAI             #
# --------------------------------------- #

# Tekstas diagramoje arba jos paraštėse taip pat yra grafiko dalis. Yra keletas
# grafinių parametrų, kurie nustato papildomo teksto rašymo taisykles:
#
#     ylbias -- teksto paraštėse postūmio koeficientas,
#    lheight -- diagramos eilutės aukščio daugiklis,
#        mex -- paraštės eilutės aukštis,
#        srt -- teksto pasukimo kampas,
#        crt -- simbolio pasukimo kampas,
#         ps -- šrifto dydis taškais.


# Parametras ylbias nustato teksto eilučių paraštėse poziciją ašių atžvilgiu. Jo
# reikšmė priklauso nuo įrenginio, tačiau standartinė R reikšmė lygi 0.2. Keisti
# šio parametro reikšmę prasmės nėra.


# Parametras lheight yra ant diagramos rašomo teksto eilutės aukščio daugiklis.
# Pvz., parametrui priskirsime reikšmę 2, kuri atitinka dvigubą eilutės aukštį.

par(lheight = 2)
curve(sin, -pi, pi)
text(pi/2, 0, "Čia tarpas tarp\n dviejų eilučių dvigubas.")


# Parametras mex nustato eilutės aukštį diagramos paraštėse. Standartinė reikšmė
# lygi 1. Skaičiai ties ašies padalomis rašomi pirmoje eilutėje, ašies antraštės
# rašomos trečioje eilutėje. Pakeitus parametro mex reikšmę, keičiasi ir eilučių
# aukštis, todėl pasikeičia ir paraščių plotis, nors eilučių skaičius jose lieka
# nepakitęs (jei nesikeičia kitų parametrų reikšmės).

# Pavyzdžiui, nubraižysime grafiką su dvigubo aukščio paraštės eilutėmis. Teksto
# ant diagramos eilučių aukštis lieka nepakitęs.

par(mex = 2)
curve(sin, -pi, pi)
mtext("Nulinė eilutė", side = 1, line = 0, at = 2)
mtext("Pirma eilutė",  side = 1, line = 1, at = 2)
mtext("Antra eilutė",  side = 1, line = 2, at = 2)
mtext("Trečia eilutė", side = 1, line = 3, at = 2)

text(pi/2, 0, "Čia tarpas tarp\n dviejų eilučių viengubas.")

graphics.off()


# Parametras srt nustato, kokiu kampu pasukama teksto eilutė. Parametras crt yra
# skirtas tam pačiam tikslui, tačiau jis veikia ne su visais įrenginiais.

# Pvz., nubraižysime funkcijos y = sin(x) grafiką ir ant jo uždėsime 70 laipsnių 
# kampu pasuktą tekstą.

par(srt = 70)
curve(sin, -pi, pi)
text(0, 0.3, "Pasukta eilutė.")


# Parametras ps nustato šrifto dydį pikseliais. Standartinė jo reikšmė priklauso
# nuo įrenginio, tačiau paprastai laikoma, kad pikselis lygus 1/72 colio. 

par("ps")

# Pavyzdžiui, pakeisime parametro reikšmę ir sumažinsime šrifto dydį.

par(ps = 9)
curve(sin, -pi, pi)
text(pi/2, 0, "Tekstas ant grafiko.")


# UŽDUOTIS ------------------------------ 

# 1. Nubraižykite paprastą stulpelinę diagramą barplot(1:3). Kiekvieno stulpelio
#    viduje šalia dešiniojo krašto vertikaliu tekstu užrašykite stulpelio numerį.


# --------------------------------------- #
# READ ONLY GRAFINIAI PARAMETRAI          #
# --------------------------------------- #

# Kai kurių grafinių parametrų reikšmės negali būti pakeistos, nes priklauso nuo 
# įrenginio, kuriame vaizduojamas grafikas. Tai gali būti monitorius, pdf failas
# ir pan. Tokių parametrų nėra daug, beveik visi jie nustato simbolio dydį:
# 
#        csi -- simbolio aukštis coliais,
#        cin -- simbolio plotis ir aukštis coliais,
#        cra -- simbolio plotis ir aukštis pikseliais,
#        cxy -- simbolio plotis ir aukštis standartizuotais vienetais,
#        din -- grafinio lango plotis ir aukštis coliais,
#       page -- loginis, nurodo ar sekantis grafikas bus sudaromas iš naujo.

# Nors visi šie parametrai yra "read only" ir jų reikšmės negali būti pakeistos, 
# jas galima sužinoti ir tam tikrose situacijose panaudoti.

# Parametrai cin, cra ir cxy parodo grafiko simbolių plotį ir aukštį skirtingais
# matavimo vienetais. Parametras csi parodo tik simbolio aukštį coliais.

par(c("csi", "cin", "cra", "cxy"))


# Parametras cxy parodo simbolių dydį sąlyginiais vienetais, todėl šio parametro
# reikšmė priklauso nuo grafinio lango dydžio. Kuo didesnis grafinis langas, tuo
# simbolis yra sąlyginai mažesnis, todėl ir parametro reikšmės mažesnės. 

windows(width = 7, height = 7)
par("cxy")

windows(width = 8, height = 4)
par("cxy")

graphics.off()


# Parametras din parodo grafinio lango išmatavimus coliais.

windows(width = 7, height = 7)
par("din")

windows(width = 8, height = 4)
par("din")

graphics.off()


# Parametro page reikšmė TRUE nurodo, kad aukšto lygio grafinė funkcija sudarytų
# naują grafiką vietoje seno. Tiksliau, tai yra nurodymas, kad funkcija plot.new,
# kuri įvykdoma prieš grafinę f-ją, nutrauktų braižymą ant dabartinio grafiko ir
# sukurtų pagrindą naujam grafikui.

par("page")


# Yra keli grafiniai parametrai, kurių reikšmę galima pakeisti, tačiau jie patys
# nieko nekeičia. Taip yra todėl, kad funkcija ar grafiko savybė, kurią jie turi
# reguliuoti, R kalboje nerealizuota. Tai yra:
#
#        err -- nurodo, ar įspėti apie taškus už diagramos ribų ir kitas klaidas,
#        mkh -- nustato specialaus taško simbolio dydį,
#        smo -- reguliuoja braižomų kreivių glodumą.

par(c("err", "mkh", "smo"))
