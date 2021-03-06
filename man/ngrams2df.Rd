% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ngram_coding.R
\name{ngrams2df}
\alias{ngrams2df}
\title{n-grams to data frame}
\usage{
ngrams2df(ngrams)
}
\arguments{
\item{ngrams}{a \code{character} vector of n-grams.}
}
\value{
a \code{data.frame} with 2 (in case of n-grams without known position) or
three columns (n-grams with position information).
}
\description{
Tranforms a vector of n-grams into a data frame.
}
\examples{
ngrams2df(c("2_1.1.2_0.0", "3_1.1.2_0.0", "3_2.2.2_0.0", "2_1.1_0"))
}
\seealso{
Decode n-grams: \code{\link{decode_ngrams}}.
}
