% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/PartialCorrelations.R
\name{PartialCorrelations}
\alias{PartialCorrelations}
\title{Partial Contemporaneous Correlations}
\usage{
PartialCorrelations(Q)
}
\arguments{
\item{Q}{variance-covariance matrix}
}
\value{
Get partial contemporaneous correlations
}
\description{
Get partial contemporaneous correlations
}
\examples{
\donttest{
data(dy2012)
fit = VAR(dy2012, configuration=list(nlag=1))
pcc = PartialCorrelations(fit$Q)
}
}
\references{
Dahlhaus, R., & Eichler, M. (2003). Causality and graphical models in time series analysis. Oxford Statistical Science Series, 115-137.
}
\author{
David Gabauer
}
