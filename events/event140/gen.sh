lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 19.092852852852854 --fixed-mass2 70.35971971971972 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1027224185.8986115 \
--gps-end-time 1027231385.8986115 \
--d-distr volume \
--min-distance 1730.0055722339437e3 --max-distance 1730.0255722339436e3 \
--l-distr fixed --longitude -52.62408447265625 --latitude 32.91340637207031 --i-distr uniform \
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
