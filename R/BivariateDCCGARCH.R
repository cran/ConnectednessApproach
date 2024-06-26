
#' @title Bivariate DCC-GARCH
#' @description This function multiple Bivariate DCC-GARCH models that captures more accurately conditional covariances and correlations
#' @param x zoo dataset
#' @param spec A cGARCHspec A cGARCHspec object created by calling cgarchspec.
#' @param copula "mvnorm" or "mvt" (see, rmgarch package)
#' @param method "Kendall" or "ML" (see, rmgarch package)
#' @param transformation "parametric", "empirical" or "spd" (see, rmgarch package)
#' @param time.varying Boolean value to either choose DCC-GARCH or CCC-GARCH
#' @param asymmetric Whether to include an asymmetry term to the DCC model (thus estimating the aDCC).
#' @return Estimate Bivariate DCC-GARCH
#' @importFrom rmgarch cgarchspec
#' @importFrom rmgarch cgarchfit
#' @importFrom rmgarch rcor
#' @importFrom rmgarch rcov
#' @importFrom zoo zoo
#' @references
#' Cocca, T., Gabauer, D., & Pomberger, S. (2024). Clean energy market connectedness and investment strategies: New evidence from DCC-GARCH R2 decomposed connectedness measures. Energy Economics.
#' 
#' Engle, R. (2002). Dynamic conditional correlation: A simple class of multivariate generalized autoregressive conditional heteroskedasticity models. Journal of Business & Economic Statistics, 20(3), 339-350.
#' @author David Gabauer
#' @export
BivariateDCCGARCH = function (x, spec, copula = "mvt", method = "Kendall", transformation = "parametric", 
                              time.varying = TRUE, asymmetric = FALSE) {
  if (!is(x, "zoo")) {
    stop("Data needs to be of type 'zoo'")
  }
  t = nrow(x)
  k = ncol(x)
  NAMES = colnames(x)
  Z_t = NULL
  H_t = R_t = array(1, c(k, k, t), dimnames = list(NAMES, 
                                                   NAMES, as.character(index(x))))
  for (i in 1:k) {
    for (j in 1:k) {
      if (i < j) {
        print(paste("DCC-GARCH estimation based on", NAMES[i], "and", NAMES[j]))
        mgarch.spec = rmgarch::cgarchspec(uspec = multispec(c(spec[i], 
                                                              spec[j])), dccOrder = c(1, 1), asymmetric = asymmetric, 
                                          distribution.model = list(copula = copula, 
                                                                    method = method, time.varying = time.varying, 
                                                                    transformation = transformation))
        copula_fit = rmgarch::cgarchfit(mgarch.spec, 
                                        data = x[, c(i, j)], solver = c("hybrid", "solnp"), 
                                        fit.control = list(eval.se = FALSE))
        r = rcor(copula_fit)
        h = rcov(copula_fit)
        R_t[c(i, j), c(i, j), ] = r
        H_t[c(i, j), c(i, j), ] = h
      }
    }
    Z_t = cbind(Z_t, copula_fit@mfit$Z[, 1])
  }
  colnames(Z_t) = NAMES
  return = list(H_t=H_t, R_t=R_t, Z_t=zoo::zoo(Z_t, as.Date(index(x))))
}

