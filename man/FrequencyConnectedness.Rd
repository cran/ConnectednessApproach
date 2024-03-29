% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/FrequencyConnectedness.R
\name{FrequencyConnectedness}
\alias{FrequencyConnectedness}
\title{Baruník and Křehlík (2018) frequency connectedness approach}
\usage{
FrequencyConnectedness(
  Phi,
  Sigma,
  nfore = 100,
  partition = c(pi, pi/2, 0),
  generalized = TRUE,
  orth = FALSE,
  scenario = "ABS",
  corrected = FALSE
)
}
\arguments{
\item{Phi}{VAR coefficient matrix}

\item{Sigma}{Residual variance-covariance matrix}

\item{nfore}{H-step ahead forecast horizon}

\item{partition}{Frequency spectrum}

\item{generalized}{Orthorgonalized/generalized FEVD}

\item{orth}{Orthorgonalized shocks}

\item{scenario}{ABS or WTH}

\item{corrected}{Boolean value whether corrected or standard TCI should be computed}
}
\value{
Get connectedness measures
}
\description{
This function calculates the Baruník and Křehlík (2018) frequency connectedness measures.
}
\examples{
\donttest{
data("dy2012")
partition = c(pi+0.00001, pi/4, 0)
fit = VAR(dy2012, configuration=list(nlag=4))
dca = FrequencyConnectedness(Phi=fit$B, Sigma=fit$Q, nfore=100, partition=partition)
}
}
\references{
Baruník, J., & Křehlík, T. (2018). Measuring the frequency dynamics of financial connectedness and systemic risk. Journal of Financial Econometrics, 16(2), 271-296.
}
\author{
David Gabauer
}
