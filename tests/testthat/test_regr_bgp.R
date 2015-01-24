context("regr_bgp")

test_that("regr_bgp", {
  requirePackages("tgp", default.method = "load")
  parset.list = list(
    list(meanfn = "linear", bprior = "bflat", corr = "expsep")
  )
  y = regr.train[, regr.target]
  old.predicts.list = list()
  for (i in 1:length(parset.list)) {
    parset = parset.list[[i]]
    pars = list(X = regr.train[, 1:3], Z = y, verb = 0, pred.n = FALSE)
    pars = c(pars, parset)
    set.seed(getOption("mlr.debug.seed"))
    m <- do.call(tgp::bgp, pars)
    
    old.predicts.list[[i]] = predict(m, XX = regr.test[, 1:3], pred.n = FALSE)$ZZ.km
  }
  testSimpleParsets("regr.bgp", regr.df[, c(1:3, 14)], regr.target, regr.train.inds, old.predicts.list, parset.list)
})