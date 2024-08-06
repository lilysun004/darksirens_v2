lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 16.06726726726727 --fixed-mass2 30.186666666666667 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1014794462.726741 \
--gps-end-time 1014801662.726741 \
--d-distr volume \
--min-distance 1037.9364621483721e3 --max-distance 1037.956462148372e3 \
--l-distr fixed --longitude -4.990753173828125 --latitude -35.195709228515625 --i-distr uniform \
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
