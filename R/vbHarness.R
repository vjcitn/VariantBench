#' @importFrom GenomicRanges GRanges
#' @importFrom VariantAnnotation scanVcf
#' @importFrom VariantAnnotation ScanVcfParam
#' @importFrom microbenchmark microbenchmark
NULL
#'
#' harness for variant access
#' @param gr a \code{\link[GenomicRanges]{GRanges-class}} instance
#' @param times times a numeric passed to \code{\link[microbenchmark]{microbenchmark}} to control number of times run for averaging
#' @export
#'
vbHarness = function(gr, methods, times=5) {
 lapply(methods, function(h) h(gr, times=times))
}
#'
#' illustrative closure for a variant retrieval method based on scanVcf
#' @param vcffile character
#' @return a function with parameters \code{gr} and \code{times} for use with \code{\link{vbHarness}}
#' @export
useScanVcfClo = function(vcffile) function(gr, times) {
  parm = ScanVcfParam( which=gr, fixed=NA, info=NA, geno="GT" )
  timing = microbenchmark( dat <- scanVcf(vcffile, param=parm), times=times )
  list(timing=timing, request=gr, obj.size=object.size(dat))
}
