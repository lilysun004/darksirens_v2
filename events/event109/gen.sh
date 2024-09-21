lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 43.63371371371372 --fixed-mass2 75.57045045045045 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1005077427.1230654 \
--gps-end-time 1005084627.1230654 \
--d-distr volume \
--min-distance 4738.635376347451e3 --max-distance 4738.655376347451e3 \
--l-distr fixed --longitude 23.38473892211914 --latitude -72.26171875 --i-distr uniform \
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
