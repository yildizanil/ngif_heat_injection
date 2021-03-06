# Ground heat exchange potential of Green Infrastructure
# Yildiz,  A. and Stirling,  R.A.
# Submitted to Geothermics
# importing self-written functions
source("functions/import_data.r")
source("functions/interpolate_soil_temperature.r")
source("functions/utc.r")
# importing heat flux
heat_flux <- import_data("heat_flux")
# time frame presented in the manuscript
startdate <- utc("2019-07-18 00:00:00")
enddate <- utc("2019-09-12 00:00:00")
# calculating heat flux at the lower boundary, q850
t875 <- rowMeans(soil_temp[, c(13, 14)], na.rm = T)
t900 <- soil_temp$Z900
q850 <- data.frame(Time = vwc[seq_len(nrow(vwc) - 1), 1],
                  Value = rep(NA, nrow(vwc) - 1))
for (i in seq_len(nrow(q850))) {
  q850[i, 2] <- heat_flux$HF.Bottom[i] +
    (c_sand(vwc$Z750[i])) * ((t875[i + 1] - t875[i]) / 0.25) * 0.09 +
    t875[i] * ((c_sand(vwc$Z750[i + 1]) - c_sand(vwc$Z750[i])) / 0.25) * 0.09
}