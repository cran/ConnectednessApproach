
#' @title Aggregated Connectedness Measures
#' @description This function results in aggregated connectedness measures.
#' @param dca Dynamic connectedness object
#' @param groups List of at least two group vectors
#' @param corrected Boolean value whether corrected or standard TCI should be computed
#' @param start Start index
#' @param end End index
#' @return Get connectedness measures
#' @examples
#' \donttest{
#' #Replication of Gabauer and Gupta (2018)
#' data("gg2018")
#' dca = ConnectednessApproach(gg2018, 
#'                             nlag=1, 
#'                             nfore=10, 
#'                             window.size=200,
#'                             model="TVP-VAR",
#'                             connectedness="Time",
#'                             VAR_config=list(TVPVAR=list(kappa1=0.99, kappa2=0.99, 
#'                             prior="BayesPrior")))
#' ac = AggregatedConnectedness(dca, groups=list("US"=c(1,2,3,4), "JP"=c(5,6,7,8)))
#' }
#' @references Gabauer, D., & Gupta, R. (2018). On the transmission mechanism of country-specific and international economic uncertainty spillovers: Evidence from a TVP-VAR connectedness decomposition approach. Economics Letters, 171, 63-71.
#' @author David Gabauer
#' @export
AggregatedConnectedness = function(dca, groups, start=NULL, end=NULL, corrected=FALSE) {
  if (length(groups) <= 1) {
    stop("groups need to consist of at least 2 vectors")
  }
  if (dca$approach == "Frequency" | dca$approach == "Joint") {
    stop(paste("Aggregated connectedness measures are not implemented for", 
               dca$approach, "connectedness"))
  } else {
    if (dca$approach == "Extended Joint") {
      corrected = FALSE
    }
    if (is.null(start)) {
      start = 1
    }
    if (is.null(end)) {
      end = dim(dca$CT)[3]
    }
    NAMES = colnames(dca$NET)
    k = length(NAMES)
    m = length(groups)
    CT = dca$CT
    t = dim(CT)[3]
    weights = NULL
    for (i in 1:m) {
      weights[i] = length(groups[i][[1]])
    }
    
    if (is.null(names(groups))) {
      NAMES_group = paste0("GROUP", 1:m)
    } else {
      NAMES_group = names(groups)
    }
    
    date = as.character(as.Date(names(CT[1,1,])))
    TCI_ = TCI = array(NA, c(t,1), dimnames=list(date, "TCI"))
    NPT = FROM = TO = NET = array(NA, c(t,m), dimnames=list(date, NAMES_group))
    CT_ = INFLUENCE = NPDC = PCI = INFLUENCE = array(NA, c(m,m,t), dimnames=list(NAMES_group, NAMES_group, date))
    for (il in 1:t) {
      ct0 = ct = CT[,,il]
      for (i in 1:m) {
        for (j in 1:m) {
          if (i==j) {
            ct0[groups[i][[1]], groups[j][[1]]] = 0
          }
        }
      }
      ct1 = array(0, c(m, m), dimnames=list(NAMES_group, NAMES_group))
      for (i in 1:m) {
        for (j in 1:m) {
          ct1[i,j] = sum(ct0[groups[i][[1]], groups[j][[1]]]) / length(groups[j][[1]])
        }
      }
      for (i in 1:m) {
        ct1[i,i] = 1-sum(ct1[i,])
      }
      #mean(rowSums(ct0))
      CT_[,,il] = ct1
      dca_ = ConnectednessTable(ct1)
      if (corrected) {
        TCI[il, ] = dca_$cTCI
        TCI_[il,] = sum(dca_$TO * (k-weights)/(k-1))
      } else {
        TCI[il, ] = dca_$TCI
        TCI_[il,] = sum(dca_$TO * (k-weights)/k)
      }
      TO[il,] = dca_$TO
      FROM[il,] = dca_$FROM
      NET[il,] = dca_$NET
      NPT[il,] = dca_$NPT
      NPDC[,,il] = dca_$NPDC
      PCI[,,il] = dca_$PCI
      INFLUENCE[,,il] = dca_$INFLUENCE
    }
  }
  TABLE = ConnectednessTable(CT_)$TABLE
  return = list(TABLE=TABLE, TCI_ext=TCI_, TCI=TCI, 
                TO=TO, FROM=FROM, NPT=NPT, NET=NET, 
                NPDC=NPDC, INFLUENCE=INFLUENCE, PCI=PCI, approach="Aggregated")
}