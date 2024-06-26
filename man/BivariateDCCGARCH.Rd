% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/BivariateDCCGARCH.R
\name{BivariateDCCGARCH}
\alias{BivariateDCCGARCH}
\title{Bivariate DCC-GARCH}
\usage{
BivariateDCCGARCH(
  x,
  spec,
  copula = "mvt",
  method = "Kendall",
  transformation = "parametric",
  time.varying = TRUE,
  asymmetric = FALSE
)
}
\arguments{
\item{x}{zoo dataset}

\item{spec}{A cGARCHspec A cGARCHspec object created by calling cgarchspec.}

\item{copula}{"mvnorm" or "mvt" (see, rmgarch package)}

\item{method}{"Kendall" or "ML" (see, rmgarch package)}

\item{transformation}{"parametric", "empirical" or "spd" (see, rmgarch package)}

\item{time.varying}{Boolean value to either choose DCC-GARCH or CCC-GARCH}

\item{asymmetric}{Whether to include an asymmetry term to the DCC model (thus estimating the aDCC).}
}
\value{
Estimate Bivariate DCC-GARCH
}
\description{
This function multiple Bivariate DCC-GARCH models that captures more accurately conditional covariances and correlations
}
\references{
Cocca, T., Gabauer, D., & Pomberger, S. (2024). Clean energy market connectedness and investment strategies: New evidence from DCC-GARCH R2 decomposed connectedness measures. Energy Economics.

Engle, R. (2002). Dynamic conditional correlation: A simple class of multivariate generalized autoregressive conditional heteroskedasticity models. Journal of Business & Economic Statistics, 20(3), 339-350.
}
\author{
David Gabauer
}
