context("regr_gausspr")

test_that("regr_gausspr", {
  
  requirePackages("kernlab", default.method = "load")
  
  parset.list = list(
    list(),
    list(kernel = vanilladot),
    list(var = 2)
  )
  
  old.predicts.list = list()
  old.probs.list = list()
  
  for (i in 1:length(parset.list)) {
    parset = parset.list[[i]]
    pars = list(x = regr.formula, data = regr.train)
    pars = c(pars, parset)
    set.seed(getOption("mlr.debug.seed"))
    m = do.call(kernlab::gausspr, pars)
    set.seed(getOption("mlr.debug.seed"))
    old.predicts.list[[i]] = predict(m, newdata = regr.test)
  }
  
  testSimpleParsets("regr.gausspr", regr.df, regr.target, regr.train.inds, old.predicts.list, parset.list)
  
})

