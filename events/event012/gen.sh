lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 38.08680680680681 --fixed-mass2 51.78598598598599 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1016515489.7035383 \
--gps-end-time 1016522689.7035383 \
--d-distr volume \
--min-distance 3447.281561516415e3 --max-distance 3447.3015615164154e3 \
--l-distr fixed --longitude -93.00601196289062 --latitude 58.79046630859375 --i-distr uniform \
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
