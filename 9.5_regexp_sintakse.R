
#
#   Dalykas: STATISTINĖS DUOMENŲ ANALIZĖS SISTEMA IR PROGRAMAVIMO KALBA R
#            Reguliarios išraiškos, regexp ir jų sudarymas.
#
#  Autorius: Tomas Rekašius
#
#   Sukurta: 2016-05-01 | 2016-05-10
#


# TURINYS -------------------------------

#
#   1. Reguliarios išraiškos ir regexp:
#      * regexp ir jų panaudojimo galimybės
#      * reguliarių išraiškų standartai
#
#   2. BRE standarto reguliarios išraiškos:
#      * bazinio regexp standarto metasimboliai
#
#   3. ERE standarto reguliarios išraiškos:
#      * išplėstinio regexp standarto metasimboliai
#      * žodžio ribos nustatymas
#
#   4. POSIX simbolių klasės:
#      * valdymo simboliai
#      * sutrumpinti simbolių klasių pažymėjimai
#      * POSIX klasės ir jų hierarchija
#


# PASTABOS ------------------------------

#
# Paminėti apie lazy matching.
# Parašyti apie ekranavimą su \Q ir \E.
# 


# NUSTATYMAI ----------------------------

# Nustatoma lietuviška lokalė. 
Sys.setlocale(locale = "Lithuanian")

# Nustatomas darbinis katalogas.
setwd("C:/Downloads")

# Ištrinami visi seni kintamieji.
rm(list = ls())


# --------------------------------------- #
# REGULIARIOS IŠRAIŠKOS IR REGEXP         #
# --------------------------------------- #

# Vienoje iš teorinės informatikos sričių, formalių kalbų teorijoje, sakoma, kad 
# kalba yra reguliari, jeigu ji aprašoma reguliariomis išraiškomis. Tokiu atveju 
# kalba suprantama, kaip tam tikrų žodžių aibė. Iš kitos pusės, norint nustatyti, 
# ar žodis priklauso tam tikrai kalbai, gali būti naudojami baigtiniai automatai. 
# Tokiu būdu susiejamos reguliarios išraiškos, reguliarios kalbos bei baigtiniai 
# automatai.

# Praktikoje reguliarios išraiškos apibrėžiamos žymiai paprasčiau. Galima sakyti,
# kad reguliari išraiška - tai pagal tam tikras taisykles užrašyta simbolių seka, 
# kuri aprašo tam tikros simbolių sekų aibės šabloną (pattern).

# Bet kurios kalbos tekstas yra simbolių seka. Kokie simboliai naudojami tekste,
# priklauso nuo kalbos. Natūralios kalbos tekstas sudarytas iš raidžių, skyrybos
# ženklų ir skaitmenų. Programavimo kalbų tekstai užrašomi naudojant tuos pačius
# simbolius. Kai kurių kalbų rašto simboliai mums labai neįprasti, pvz., graikų,
# armėnų, gruzinų, arabų, japonų, korėjiečių. Apie kai kurias dabar jau mirusias 
# kalbas žinome tik todėl, kad išliko tomis kalbomis užrašyti tekstai. Tuo pačiu
# tokios senovės civilizacijų kalbos, kaip šumerų ar egiptiečių, išsaugojo savo, 
# dažnai egzotišką, rašto sistemą. Pavyzdžiui, gerai žinomas dantiraštis, runos,
# egiptietiški hieroglifai. Rašto sistema reikalinga ne tik žodinei informacijai
# užrašyti ir perduoti. Pvz., natos -- tai muzikiniam tekstui užrašyti naudojama 
# ženklų sistema. Taigi, bet kurios kalbos tekstas yra simbolių seka.

# Įprasta sakyti, kad natūralios kalbos tekstą sudaro tarpais ir kitais skyrybos 
# ženklais atskirti žodžiai, bet, kaip teksto dalis, žodis taip pat yra simbolių 
# seka. Atsižvelgiant į tai, galima suformuluoti paprastesnį reguliarių išraiškų 
# apibrėžimą. Taigi, reguliari išraiška --- tai tekstinis šablonas, kuris aprašo 
# tam tikrų žodžių aibę. Tokį šabloną galima panaudoti žodžių paieškai ar teksto
# redagavimui. Pavyzdžiui, tekste reikia surasti žodžius, kurie:
#
#   -- prasideda raide "a";
#   -- prasideda raide "a" arba "A";
#   -- prasideda raide "A", o baigiasi galūne "as";
#   -- prasideda iš didžiosios raidės (bet kurios);
#   -- sudaryti vien iš didžiųjų raidžių;
#   -- sudaryti iš penkių raidžių;
#   -- turi dvibalsį "uo";
#   -- turi bet kokį dvibalsį.

# Tokius žodžių šablonus galima panaudoti klaidų žodžiuose paieškai ir taisymui,
# o taip pat ir kitokiems teksto redagavimams. Pavyzdžiui, reikia atlikti tokius
# veiksmus:
#
#   -- visame tekste žodį "irba" pakeisti į žodį "arba";
#   -- surasti tekste dvigubus tarpus "  " ir pakeisti juos į viengubus " ";
#   -- visame tekste simbolį "\" pakeisti į "/";
#   -- surasti tekste visas simbolių sekas, kurios yra el. pašto adresas;
#   -- patikrinti, ar įvesta simbolių seka yra data.

# Tokias teksto paieškos ir pakeitimo galimybes turi visos specializuotos teksto 
# redagavimo programos, pavyzdžiui, vim, emacs, gedit, Light Table, Sublime Text,
# Lime Text, Atom, Notepad++ ir daugelis kitų. Reguliarios išraiškos reikalingos
# ir darbui su failais. Pavyzdžiui, reikia:
#
#   -- surasti failus, kurių pavadinime yra data;
#   -- surasti failus, kurių išplėtimas "txt";
#   -- surasti failus su išplėtimu "txt" ir pakeisti į išplėtimą "dat";
#   -- surasti failus su išplėtimu "R", kurių viduje yra žodis "plot";
#   -- ištrinti visus failus, kurių pavadinimas prasideda raide "a".


# PASTABA. Šiuo metu priimta reguliariomis išraiškomis vadinti panašų, tačiau iš
# esmės visiškai skirtingą dalyką -- regex. Kaip ir reguliarios išraiškos, regex
# naudojamos simbolių sekų aprašymui, tačiau, skirtingai nuo reguliarių išraiškų, 
# jau neaprašo reguliarių kalbų. Dabar egzistuoja trys reg. išraiškų standartai:
# 
#        BRE -- Basic Regular Syntax,
#        ERE -- Extended Regular Expression,
#        SRE -- Simple Regular Expressions (nebenaudojamas),
#       PCRE -- Perl Compatible Regular Expressions.

# Toliau tekste laikysimės neteisingos tradicijos ir regex arba regexp išraiškas 
# taip pat vadinsime reguliariomis išraiškomis.


# --------------------------------------- #
# BRE STANDARTO REGULIARIOS IŠRAIŠKOS     #
# --------------------------------------- #

# Reguliariai išraiškai užrašyti naudojami simboliai skirstomi į dvi grupes: tai
# simboliai bei metasimboliai. Simboliai reguliarioje išraiškoje išreiškia patys 
# save, o skirtingų metasimbolių paskirtis skiriasi: vieni jų naudojami simbolių 
# grupavimui, kiti gali reikšti simbolių grupę ir t. t. Standartinę metasimbolių
# aibę sudaro šie simboliai:
#
#                        [ ] ( ) { } \ / ^ $ . * | ?  +
#
# Metasimbolių aibės skirtinguose reguliarių išraiškų standartuose skiriasi, bet 
# didžioji dalis jų yra tie patys.

# Jei metasimbolis išraiškoje turi būti panaudojamas kaip paprastas simbolis, jį 
# būtina ekranuoti (užmaskuoti). Šiam tikslui naudojamas simbolis "\", kuris yra
# rašomas prieš maskuojamą metasimbolį. 

# PASTABA. Tabuliacijos ženklas "\t", įvairūs valdymo simboliai, simbolių klasės
# užrašomos naudojant simbolį "\". Kadangi jis pats yra metasimbolis, išraiškose
# jį patį reikia ekranuoti, todėl rašome ne "\", bet "\\".

# PASTABA. Bazinis reguliarių išraiškų standartas BRE reikalauja, kad skliaustai
# () ir {}, kurie užrašant reg. išraišką naudojami kaip metasimboliai, turi būti 
# rašomi atitinkamai \(, \), \[ ir \], priešingu atveju jie interpretuojami kaip
# įprasti skliaustų simboliai. Išplėstiniame standarte ERE yra priešingai -- čia
# skliaustai () ir [] yra metasimboliai, o jų ekranuotos versijos \(, \), \[, \] 
# interpretuojamos kaip įprasti skliaustų simboliai. Šiame tekste reg. išraiškas 
# rašysime laikydamiesi ERE standarto.


# [ ]
#
# Laužtiniai skliaustai nurodo bet kurį vieną tuose skliaustuose įrašytą simbolį. 
# Pavyzdžiui, išraiška "[abc]" nurodo raidę "a", "b" arba "c". Iš eilės einančių
# raidžių seką galima užrašyti kompaktiškai -- įrašome brūkšneliu atskirtą pirmą 
# ir paskutinę sekos raidę. Tokiu atveju brūkšnelis tik nurodo iš eilės einančių
# simbolių intervalą ir kaip simbolis "-" netraktuojamas. Pvz., išraiška "[a-z]" 
# nurodo bet kurią mažąją lotyniškos abėcėlės raidę. Galima nurodyti keletą sekų 
# iš karto. Pvz., "[a-zA-Z]" nurodo bet kurią mažąją ar didžiąją abėcėlės raidę. 
# Jeigu tarp nurodytų simbolių turi būti "-", tada jis laužtiniuose skliaustuose 
# rašomas arba pirmas, arba paskutinis, pvz., "[-abc]" arba "[abc-]". Jeigu tarp
# išvardintų simbolių turi būti "]" ar "[", tai jis skliaustuose rašomas pirmas. 
# Pavyzdžiui, "[[abc]" nurodo raidę "a", "b", "c" ir simbolį "[". Pateiksime dar 
# keletą pavyzdžių:
#
#        [a-cx-z]" -- nurodo vieną iš raidžių "a", "b", "c", "x", "y", "z";
#     "[blr]ankas" -- atitinka žodžius "bankas", "lankas" ir "rankas";
#          "[0-9]" -- nurodo bet kurį vieną skaitmenį;
#            "[[]" -- nurodo tik simbolį "[";
#           "[][]" -- nurodo simbolį "]" arba "[";
#           "[[]]" -- jei reikia gauti "]" arba "[", tada užrašyta neteisingai.


# [^ ]
#
# Laužtiniai skliaustai, kuriuose prieš simbolius įrašytas simbolis "^", reiškia
# bet kokį simbolį, išskyrus tuos, kurie išvardinti skliaustuose. Pvz., "[^abc]"
# reiškia bet kokį simbolį, išskyrus "a", "b", "c". Jeigu simbolis "^" turi būti 
# interpretuojamas kaip simbolis, jis skliaustuose rašomas ne pirmas. Pateiksime
# šiuos pavyzdžius:
#
#           "[^x]" -- nurodo bet kokį simbolį, išskyrus raidę "x";
#         "[^a-z]" -- nurodo bet kokį simbolį, išskyrus mažąją raidę;
#         "[^0-9]" -- nurodo bet kokį simbolį, išskyrus skaitmenis;
#        "[^-0-9]" -- bet koks simbolis, išskyrus skaitmenį ir brūkšnelį;
#         "[0-9^]" -- nurodo bet kurį skaitmenį arba simbolį "^".


# ( )
#
# Skliaustai reguliariose išraiškose naudojami simbolių grupavimui ir operatorių 
# veiksmų tvarkai pakeisti. Simbolių seka, kuri atitinka apskliaustą reguliarios
# išraiškos dalį -- bloką, gali būti pakartotinai įrašoma naudojant konstrukciją
# \n. Tokiu būdu užrašomos simbolių sekos su pasikartojimais.


# \n
#
# Konstrukcija \n nurodo n-ąjį bloką. Čia n nurodo sveikąjį skaičių nuo 1 iki 9.
# Kiekvienas blokas reguliarioje išraiškoje gali būti panaudojamas keletą kartų.
# PASTABA. Šioje konstrukcijoje simbolį "\" reikia ekranuoti. Pavyzdžiui:
#
#      "(abc)-\\1" -- nurodo seką "abc-abc";
#    "(a)[0-9]\\1" -- nurodo sekas "a0a", "a1a", "a2a" ir t.t.;
#    "([a-z])-\\1" -- nurodo sekas "a-a", "b-b" ir t.t.


# {m,n}
#
# Ši konstrukcija naudojama simbolių pasikartojimų skaičiui nurodyti. Egzistuoja
# keli jos užrašymo variantai:
#
#              {n} -- simbolis pakartojamas n kartų;
#             {m,} -- simbolis pakartojamas ne mažiau, kaip m kartų;
#            {m,n} -- simbolis pakartojamas nuo m iki n kartų.
#
# Pateiksime keletą paprasčiausių pavyzdžių:
#
#           "a{3}" -- nurodo seką "aaa";
#         "a{1,3}" -- nurodo sekas "a", "aa" ir "aaa";
#         "0{1,}1" -- nurodo sekas "01", "001", "0001" ir t.t.
#
# Pakartojimų skaičių galima nurodyti ne tik atskiram simboliui, bet ir simbolių 
# grupei (blokui) arba visai simbolių klasei. Keletas sudėtingesnių pavyzdžių:
#
#       "(xy){1,}" -- sekos, kuriose pora "xy" pasirodo bent vieną kartą;
#      "[xy]{4,5}" -- sekos, kuriose "x" ar "y" pasirodo 4 ar 5 kartus iš eilės;
#  "([abc]{2})\\1" -- sekos, kuriose 2 kartus pasikartoja bet kuri raidžių pora.


# .
#
# Taškas reguliariose išraiškose žymi bet kokį vieną simbolį -- bet kurią raidę,
# bet kurį skaitmenį, skyrybos ženklą ir t.t. Laužtiniuose skliaustuose įrašytas 
# taškas interpretuojamas kaip "." simbolis. Pavyzdžiui:
#
#         ".ankas" -- atitinka žodžius "bankas", "tankas", "lankas" ir t.t.;
#          "[a.c]" -- atitinka raides "a", "c" ir tašką ".";
#       ".*[.]txt" -- atitinka failų su išplėtimu ".txt" pavadinimus.


# *
#
# Simbolis "*" reguliariose išraiškose --- tai operatorius Klini žvaigždė. Prieš 
# jį stovinčio simbolio sekoje gali nebūti visai arba jis gali pasikartoti vieną, 
# du ar daugiau kartų. Klini žvaigždę galima pritaikyti ir simbolių blokui. Pvz.:
#
#             "a*" -- nurodo tuščią seką "" arba "a", "aa", "aaa", ...
#           "ab*c" -- nurodo sekas "ab", "abc", "abbc", ...
#          "(ab)*" -- nurodo tuščią seką "", "ab", "abab", "ababab", ...
#          "[ab]*" -- nurodo bet kokio ilgio sekas sudarytas iš "a" ir "b";
#             ".*" -- nurodo bet kokio ilgio sekas iš visų įmanomų simbolių.


# ^
#
# Simbolis "^" reguliarioje išraiškoje nurodo tai, kad seka yra simbolių eilutės
# pradžioje. Pavyzdžiui:
#
#           "^abc" -- atitinka seką "abc ...", bet neatitinka sekos "... abc";
#       "^[A-Z].*" -- bet kokio ilgio sekos iš didžiosios raidės sekos pradžioje;
#   "^[A-Z][a-z]*" -- iš didžiosios raidės prasidedantys žodžiai sekos pradžioje.


# $
#
# Simbolis "$" reguliarioje išraiškoje nurodo tai, kad seka yra simbolių eilutės
# gale. Pavyzdžiui:
#
#          ".*as$" -- bet kokio ilgio simbolių sekos su galūne "as" sekos gale;
#         ".*[.]$" -- bet kokio ilgio simbolių sekos su tašku sekos gale;
#     "^[0-9]{6}$" -- bet kokie šešiaženkliai kodai.


# UŽDUOTIS ------------------------------ 

# 1. Užrašykite reguliarią išraišką, kuri atitinka simbolį "\". Pakeiskite gautą
#    išraišką taip, kad ji atitiktų du greta stovinčius simbolius "\".
# 2. Užrašykite reguliarią išraišką, kuri simbolių sekoje surastų simbolį "/" ar 
#    "\". Pakeiskite išraišką taip, kad ji atitiktų bet kokią šių simbolių porą.
# 3. Užrašykite reguliarią išraišką, atitinkančią bet kokio ilgio žodžius, kurių 
#    pirmoji ir paskutinė raidės sutampa. Pavyzdžiui, "ąžuolą", "sausas" ir t.t. 
#    Atkreipkite dėmesį, kad simbolių sekoje yra tik tas žodis ir nieko daugiau.
# 4. Daugtaškis -- skyrybos ženklas (ellipsis), kuris nurodo nutylėtą mintį arba 
#    praleista tekstą. Gali būti žymimas trimis iš eilės einančiais taškais arba 
#    specialiu simboliu, kurio kodas Alt + 0133. Užrašykite reg. išraišką, kurią
#    atitinka daugtaškis "..." bet kurioje teksto vietoje.
# 5. Palindromas -- tai tokia simbolių seka, kuri skaitoma vienodai iš kairės ir
#    iš dešinės, pavyzdžiui, "savas". Užrašykite tokią reguliarią išraišką, kuri 
#    bet kur tekste atpažintų palindromus sudarytus iš 4 mažųjų raidžių.
# 6. Užrašykite reguliarią išraišką palindromui iš 5 skaitmenų atpažinti. Be to,
#    pirmas skaitmuo (vadinasi -- ir paskutinis) negali būti nulis.
# 7. Paprastai failo vardas susideda iš 2 dalių, kurios atskirtos tašku. Antroji 
#    dalis vadinama failo išplėtimu. Windows OS failo pavadinime negali būti šių 
#    simbolių: \ / : * ? " < > ir |. Užrašykite tokią reguliarią išraišką, kurią 
#    atitinka korektiški failų vardai su išplėtimu iš dviejų arba trijų raidžių.
#    Pastaba. Simbolių sekoje be failo vardo daugiau neturi būti jokių papildomų
#    simbolių.


# --------------------------------------- #
# ERE STANDARTO REGULIARIOS IŠRAIŠKOS     #
# --------------------------------------- #

# BRE standartas numato tik šiuos metasimbolius. ERE reg. išraiškų standarte yra
# naudojami dar trys metasimboliai. Tačiau ERE standarte nėra konstrukcijos "\n",
# kuri teoriškai nereguliari, bet dėl standartų suderinamumo ją vis dėlto galima 
# naudoti.


# |
#
# Simbolis "|" yra aibių sąjungos operatorius (alternation). Jis nurodo simbolį, 
# kuris stovi prieš jį arba už jo. Aišku, šį operatorių galima pritaikyti ne tik 
# atskiriems simboliams, bet ir simbolių grupei (blokui) arba net visai simbolių 
# klasei. Pavyzdžiui:
#
#            "a|e" -- atitinka raidę "a" arba "e";
#      "gray|grey" -- atitinka žodį "gray" arba "grey";
#      "R(i|o)mas" -- atitinka vardą "Rimas" arba "Romas";
#    "(xx|yy)-\\1" -- atitinka seką "xx-xx" arba "yy-yy", bet ne "xx-yy".
#
# PASTABA. Jei alternatyva yra tik tarp dviejų simbolių, tada geriau yra naudoti 
# konstrukciją su laužtiniais skliaustais. Perrašysime ankstesnius pavyzdžius:
#
#           "[ae]" -- atitinka raidę "a" arba "e";
#        "gr[ae]y" -- atitinka žodį "gray" arba "grey";
#       "R[io]mas" -- atitinka vardą "Rimas" arba "Romas".


# ?
#
# Metasimbolis "?" nurodo, kad prieš jį stovintis simbolis pasikartoja nulį arba
# vieną kartą, t. y. simbolis arba yra, arba jo nėra. Operatorių taip pat galima
# pritaikyti simbolių grupei (blokui) arba simbolių klasei. Pavyzdžiui:
#
#           "ab?c" -- atitinka sekas "ac" ir "abc";
#       "p?laukai" -- atitinka žodžius "laukai" ir "plaukai";
# "(nu|į|iš)?eiti" -- atitinka žodžius "eiti", "nueiti", "įeiti", "išeiti".
#
# PASTABA. Formalių kalbų teorijos požiūriu šis operatorius yra perteklinis, nes 
# jį galima išreikšti standartinėmis priemonėmis: "a?" = "(a|e)", kur simbolis e 
# žymi tuščią seką "".


# +
#
# Reguliariose išraiškose metasimbolis "+" nurodo, kad prieš jį esantis simbolis 
# arba simbolių grupė sekoje pasirodo bent vieną kartą. Pavyzdžiui:
#
#             "-+" -- nurodo sekas "-", "--", "---", ... 
#            "0+1" -- nurodo sekas "01", "001", "0001", ...
#          "x\\+y" -- metasimbolis "+" ekranuotas, todėl gauname seką "x+y";
#         "(cha)+" -- nurodo sekas "cha", "chacha", "chachacha", ...
#       "k_[0-9]+" -- nurodo sekas "k_0", "k_5", "k_42", "k_1579" ir pan;
#   "[0-9]+[a-z]+" -- sekos, kuriose pirma pusė iš skaitmenų, o kita iš raidžių;
# "([a-z]{2})\\1+" -- nurodo sekas su bet kokios raidžių poros pasikartojimu.
#
# PASTABA. Šį operatorių galima išreikšti per Klini operatorių. Pavyzdžiui, "a+"
# aprašo tokias pačia sekas kaip ir reguliari išraiška "aa*".


# NAUDINGA ------------------------------

# Metasimbolius "^" ir "$" įrašome tais atvejais, kai reguliarią išraišką reikia 
# patikslinti, kad iš visų ją atitinkančių simbolių sekų būtų atrenkamos tik tos, 
# kurios yra eilutės pradžioje arba jos gale.

# ERE standartas numato dar vieną reg. išraiškos lokalizacijos metodą --- žodžio 
# riba. Žodžio riba tai tokia simbolių sekos vieta, kurią iš kairės arba dešinės 
# pusės riboja tarpo simbolis. Analogiškai galima nurodyti simbolių sekos vietą,
# kuri nėra žodžio riba. Tam naudojamos \b ir \B konstrukcijos. Panašiai taikoma
# konstrukcija \< arba \>, kuri nurodo tuščią seką žodžio pradžioje arba jo gale.


# \b ir \B
#
# ERE standarto reg. išraiškose konstrukcija \b nurodo žodžio ribą. Priklausomai
# nuo to, kurioje išraiškos pusėje ji bus rašoma, galima nurodyti žodžio pradžią 
# arba jo pabaigą. Pavyzdžiui:
#
#          "as\\b" -- atitinka žodžio galūnę "as";
#          "\\bas" -- atitinka žodžio pradžią "as";
#       "\\bir\\b" -- atitinka žodį "ir", bet neatitinka "asiras" ar "Airija".
#
# Konstrukcija \B priešingai -- nurodo, kad reguliarią išraišką atitinkanti seka
# yra ne žodžio riboje. Galima nurodyti, kad ieškoma simbolių seka būtų griežtai 
# žodžio viduje. Pateiksime šiuos pavyzdžius:
#
#          "\\Buo" -- "uo" kairėje turi būti ne žodžio riba: "vanduo", "duona";
#          "uo\\B" -- "uo" dešinėje turi būti ne žodžio riba: "uoga", "duona";
#       "\\Buo\\B" -- raidžių junginys "uo" žodžio viduje, pvz., "duona".


# NAUDINGA ------------------------------

# Istoriškai tekstiniuose failuose buvo įrašomi įvairūs valdymo simboliai, kurie
# neturi grafinės išraiškos ir naudojami įvedimo ir išvedimo įrenginių valdymui. 
# Pavyzdžiui, komanda CR grąžina kursorių į eilutės pradžią, komanda LF kursorių
# perkelia į kitą eilutę, komanda BS grąžina kursorių per vieną simbolį atgal, o
# komanda BEL reiškia garso signalą. Šiuo metu tokiems tikslams naudojamos kitos
# priemonės, todėl didžioji dalis valdymo simbolių nenaudojami. POSIX standartas
# numato aštuonis privalomus valdymo simbolius: \0, \a, \b, \t, \n, \v, \f ir \r.

# Reguliariose išraiškose kartu su simboliais, metasimboliais galima nurodyti ir
# valdymo simbolius. Jų sąrašas toks:
#
#           \t -- HT, horizontal tabulation;
#           \v -- VT, vertical tabulation (R nepalaiko);
#           \r -- CR, carriage return;
#           \n -- LF, line feed;
#           \f -- FF, form feed;
#           \a -- BEL, bell character;
#           \e -- ESC, escape character;
#           \b -- BS, backspace (R nepalaiko).


# Praktikoje dažnai naudojamas tabuliacijos ženklas "\t". Pavyzdžiui, tokiu būdu
# tekstiniame faile galima atskirti duomenų stulpelius. Nuskaitant duomenų failą
# būtina nurodyti, kad stulpeliai atskirti tabuliacija. Funkcija read.table turi
# specialų parametrą sep, kuriam tokiu atveju priskiriamas valdymo simbolis "\t".
# Pavyzdžiui, sukursime virtualų tekstinį failą, kur reikšmės eilutėse atskirtos 
# tabuliacijos ženklu. Prie tokio failo jungiamės naudojant f-ją textConnection.

f <- "X1\tX2\tX3
      11\t12\t13
      21\t22\t23
      31\t32\t33
      41\t42\t43"

d <- read.table(file = textConnection(f), header = TRUE, sep = "\t")
d

# Perkėlimo į kitą eilutę simbolis "\n" reikalingas išvedant pranešimus į ekraną
# ar tekstinį failą. Pavyzdžiui, jei pranešimas išvedamas į konsolę, bet jo gale
# nėra perkėlimo į kitą eilutę simbolio, tai kursorius lieka eilutės gale. Tokiu
# atveju sekantis pranešimas bus išvedamas toje pačioje eilutėje. Palyginsime du
# atvejus. Pirmuoju atveju kursorius neperkeliamas, kitu atveju --- perkeliamas.

for (i in 0:9) cat(i)
for (i in 0:9) cat(i, "\n")


# UŽDUOTIS ------------------------------ 

# 1. Užrašykite tokią reguliarią išraišką, kurią atitinka teigiami arba neigiami 
#    sveikieji skaičiai. Pirmas skaitmuo negali būti nulis, išskyrus atvejį, kai
#    pats skaičius yra nulis.
# 2. Sudarykite tokią reguliarią išraišką, kuri atpažintų 2 brūkšneliu atskirtas 
#    skaitmenų grupes, kuriose yra nuo 1 iki 3 skaitmenų, tačiau pirmas skaitmuo
#    negali būti nulis. Be to, antrosios grupės gale gali būti arba nebūti viena 
#    mažoji raidė. Pavyzdžiui, "15-2", "11-424a".
# 3. Interneto puslapio adresas prasideda "http://" arba "https://". Atkreipkite 
#    dėmesį, kad simbolių seka skiriasi tik raide "s", kuri arba yra, arba nėra.
#    Užrašykite šias sekas atitinkančią reguliarią išraišką.
# 4. Tarkime, kad sakinio pabaigą tekste nurodo taškas, daugtaškis, šauktukas ir 
#    klaustukas. Jei sakinys ne paskutinis, tada už skyrybos ženklo dedamas bent 
#    vienas tarpo simbolis " ", po kurio seka žodis iš didžiosios raidės. Reikia
#    užrašyti reguliarią išraišką sekos iš skyrybos ženklų sakinio gale radimui.
# 5. Pakeiskite ankstesnėje užduotyje sudarytą reg. išraišką atsižvelgdami į tai,
#    kad sakinys gali ir pasibaigti, ir prasidėti ne tik raide, bet ir skaičiumi.
# 6. Užrašykite reguliarią išraišką, kuri atitinka pagal šias taisykles sudarytą
#    simbolių seką --- kodas iš 3 mažųjų raidžių sekos pradžioje, tada dvitaškiu 
#    atskirti vienas ar daugiau kableliu atskirtų (sveikųjų) skaičių. Pavyzdžiui,
#    "fvt:4", "drm:1,5", "uvr:3,8,10,11,12" ir panašiai.
# 7. Užrašykite reguliarią išraišką, kurią atitinka kodas iš trijų raidžių sekos 
#    pradžioje, už kurio yra dar vienas ar keli kableliu atskirti trijų raidžių 
#    kodai. Pavyzdžiui, "rts-neu", "kit-oft,ort" ir panašiai.


# --------------------------------------- #
# POSIX IR KITOS SIMBOLIŲ KLASĖS          #
# --------------------------------------- #

# Iki šiol reguliarios išraiškos buvo užrašomos naudojant atskirus simbolius bei
# metasimbolius. Simbolius galima apjungti į grupę ir taip kompaktiškai užrašyti
# tam tikrą simbolių aibę. Pavyzdžiui, išraiška "[a-z]" reiškia bet kurią mažąją 
# abėcėlės raidę, "[A-Z]" -- bet kurią didžiąją raidę ir t.t. Dažnai naudojamoms 
# simbolių klasėms egzistuoja sutrumpinti pažymėjimai:
#
#           \d -- skaitmenys, [0-9];
#           \D -- bet koks simbolis, išskyrus skaitmenis, [^\d];
#           \w -- raidės, skaitmenys ir simbolis "_", [A-Za-z0-9_];
#           \W -- bet koks simbolis, išskyrus raides, skaitmenis ir "_";
#           \s -- tarpas, tabuliacija, kiti atskyrimo simboliai, [ \t\v\r\n\f];
#           \S -- bet koks ne tarpo, tabuliacijos ar atskyrimo simbolis, [^\s].


# Neretai simbolių intervalas priklauso nuo lokalizacijos. Pavyzdžiui, lotyniška
# abėcėlė turi 26 raides, o lietuviškoje abėcėlėje yra 32 raidės. Taigi, raidžių
# aibė nusakoma nevienareikšmiškai, nes priklauso nuo naudojamos abėcėlės. POSIX 
# standartas suvienodino kai kurių simbolių klasių pažymėjimus:
#
#    [:lower:] -- mažosios abėcėlės raidės;
#    [:upper:] -- didžiosios abėcėlės raidės;
#    [:alpha:] -- didžiosios ir mažosios raidės: [:lower:] ir [:upper:];
#    [:digit:] -- skaitmenys: 0 1 2 3 4 5 6 7 8 9;
#    [:alnum:] -- visos abėcėlės raidės ir skaitmenys: [:alpha:] ir [:digit:];
#    [:punct:] -- įvairūs skyrybos ženklai;
#    [:graph:] -- visi rašto ženklai: [:alnum:] ir [:punct:];
#    [:blank:] -- tarpo ir tabuliacijos simboliai: [ \t];
#    [:space:] -- tarpas, tabuliacija, kiti atskyrimo simboliai, (whitespace);
#    [:print:] -- spausdinami simboliai: [:alnum:], [:punct:] ir [:space:];
#    [:cntrl:] -- valdymo simboliai, tarp jų yra ir šie: [\v\r\n\f];
#   [:xdigit:] -- šešioliktainiai skaitmenys.


# Skyrybos ženklų klasė [:punct:] turi visus simbolius, kurie nėra skaitmenys ar
# didžiosios ir mažosios raidės. Į ją patenka ir metasimboliai. Visa aibė atrodo
# taip:
#        ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ ] \ ^ _ ` { } | ~         
#
# Atskirai galima paminėti klasę [:space:]. Ją sudaro simboliai, kurie naudojami
# kitų simbolių atskyrimui. Įprastas tarpo simbolis " " naudojamas žodžių tekste 
# atskyrimui. Čia žodis suprantamas apibendrintai, juo gali būti ir viena raidė, 
# skaičius ir bet kokia kita simbolių seka. Kitas tarpo simbolis -- tabuliacija.
# Tabuliacijos ženklas simbolių sekoje nurodo, kad kursorius turi būti perkeltas
# į dešinę pusę iki artimiausios tabuliacijos pozicijos, kurios išdėstytos kas 8, 
# 4 ar 2 simbolius. Tokiu būdu tabuliacijos ženklas panaudojamas teksto eilutėje 
# išlyginimui. Tarpo ir tabuliacijos simboliai apjungti į vieną klasę [:blank:]. 
# Tačiau simboliams atskirti naudojami ir kiti simboliai: vertikali tabuliacija,
# kursoriaus grąžinimo į eilutės pradžią, perkėlimo į naują eilutę bei perkėlimo
# į naują puslapį simboliai. Visi jie yra valdymo simboliai ir žymimi \v, \r, \n 
# ir \f. Šie simboliai kartu su tarpu bei horizontalia tabuliacija sudaro bendrą
# atskyrimo simbolių (whitespace) klasę [:space:]. Šie simboliai tekste nematomi,
# tačiau užima tam tikrą vietą.


# Galima pastebėti, kad vienos simbolių klasės gaunamos apjungiant kitas klases.
# Tokiu būdu gauname tam tikrą klasių hierarchiją, kurią galima atvaizduoti štai
# tokia dendrograma:
#
#    [:lower:] --+
#                +-- [:alpha:] --+
#    [:upper:] --+               |
#                                +-- [:alnum:] --+
#    [:digit:] ------------------+               |
#                                                +-- [:graph:] --+
#    [:punct:] ----------------------------------+               |
#                                                                +-- [:print:]
#    [:blank:] --+                                               |
#                +-- [:space:] ----------------------------------+
#   [\v\r\n\f] --+


# Laužtiniai skliaustai yra POSIX simbolių klasės pavadinimo dalis. Jeigu reikia
# apjungti kelias klases arba vieną POSIX klasę papildyti kitais simboliais, tam
# naudojame laužtinius skliaustus [ ], kuriuose įrašome pilną klasės pavadinimą.
# Pavyzdžiui, klasę [:alpha:] gauname kaip [[:lower:][:upper:]], klasė [:space:] 
# gali būti užrašoma kaip [[:blank:]\v\r\n\f].


# Užrašysime keletą reguliarių išraiškų naudojant sutrumpintus arba POSIX klasių 
# pavadinimus. Pavyzdžiui:
#
#             "\\s+" -- atitinka bet kokio ilgio tarpo simbolių seką;
#           "k_\\d+" -- nurodo sekas "k_0", "k_5", "k_42", "k_1579" ir pan;
#     "[:alpha:]{4}" -- atitinka žodžius iš bet kokių keturių raidžių;
#         "-?0,\\d+" -- atitinka realiuosius skaičius nuo -0,999... iki 0,999...


# UŽDUOTIS ------------------------------ 

# 1. Reguliarią išraišką "^[0-9]+$" perrašykite panaudojant POSIX simbolių klasę
#    ir sutrumpintą skaitmenų aibės pavadinimą.    
# 2. Užrašykite tokią reguliarią išraišką, kuri surastų vieną arba daugiau tarpo 
#    ar tabuliacijos simbolį simbolių sekos pradžioje ar pabaigoje. Tą pačią reg.
#    išraišką užrašykite panaudojant tinkamą POSIX simbolių klasę.
# 3. Užrašykite reguliarią išraišką, kurią atitinka gif, jpg, jpeg, png grafinių
#    failų pavadinimai. Tarkime, kad vardą sudaro tik raidės, skaitmenys ir "_".
#    Pavyzdžiui, "DSC_46290.jpg", "DHUfv0w.png" ir panašiai. Atkreipkite dėmesį, 
#    kad simbolių sekoje yra tik failo vardas ir nieko daugiau nei priekyje, nei
#    gale. Išraiškai užrašyti panaudokite POSIX ar sutrumpintą tinkamos simbolių 
#    aibės pavadinimą.
