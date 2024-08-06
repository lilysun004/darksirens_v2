lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 5.393673673673674 --fixed-mass2 77.08324324324325 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1028909673.0912476 \
--gps-end-time 1028916873.0912476 \
--d-distr volume \
--min-distance 187.43044735424422e3 --max-distance 187.4504473542442e3 \
--l-distr fixed --longitude 153.60574340820312 --latitude 15.01930046081543 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
