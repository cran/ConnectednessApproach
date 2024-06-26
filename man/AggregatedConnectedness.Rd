% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AggregatedConnectedness.R
\name{AggregatedConnectedness}
\alias{AggregatedConnectedness}
\title{Aggregated Connectedness Measures}
\usage{
AggregatedConnectedness(dca, groups, start = NULL, end = NULL)
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
This function results in aggregated connectedness measures.
}
\examples{
\donttest{
#Replication of Gabauer and Gupta (2018)
data("gg2018")
dca = ConnectednessApproach(gg2018, 
                            nlag=1, 
                            nfore=10, 
                            model="VAR",
                            connectedness="Time")
ac = AggregatedConnectedness(dca, groups=list("US"=c(1,2,3,4), "JP"=c(5,6,7,8)))
}
}
\references{
Chatziantoniou, I., Gabauer, D., & Stenfor, A. (2021). Independent Policy, Dependent Outcomes: A Game of Cross-Country Dominoes across European Yield Curves (No. 2021-06). University of Portsmouth, Portsmouth Business School, Economics and Finance Subject Group.
}
\author{
David Gabauer
}
