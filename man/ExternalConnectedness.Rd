% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ExternalConnectedness.R
\name{ExternalConnectedness}
\alias{ExternalConnectedness}
\title{External Connectedness Measures}
\usage{
ExternalConnectedness(
  dca,
  groups = list(c(1), c(2:ncol(dca$NET))),
  start = NULL,
  end = NULL
)
}
\arguments{
\item{dca}{Dynamic connectedness object}

\item{groups}{List of at least two group vectors}

\item{start}{Start index}

\item{end}{End index}
}
\value{
Get connectedness measures
}
\description{
This function provides external connectedness measures
}
\examples{
\donttest{
data("gg2018")
dca = ConnectednessApproach(gg2018, model="VAR",
                            connectedness="Time",
                            nlag=1, nfore=10, window.size=200)
ext = ExternalConnectedness(dca, groups=list("US"=c(1,2,3,4), "JP"=c(5,6,7,8)))
}
}
\references{
Gabauer, D., & Gupta, R. (2018). On the transmission mechanism of country-specific and international economic uncertainty spillovers: Evidence from a TVP-VAR connectedness decomposition approach. Economics Letters, 171, 63-71.
}
\author{
David Gabauer
}
