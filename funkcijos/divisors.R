
# Funkcija suranda visus nat�rinio skai�iaus x daliklius.
#
# Parametrai: x -- tikrinamas nat�rinis skai�ius.
# Rezultatas: d -- skai�iaus x dalikli� vektorius.


visi.dalikliai <- function(x) {

  x <- as.integer(x)
  s <- seq_len(abs(x))
  d <- s[x %% s == 0L]

  return(d)
}
