lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 40.52408408408409 --fixed-mass2 69.43523523523524 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1012879946.1326683 \
--gps-end-time 1012887146.1326683 \
--d-distr volume \
--min-distance 2200.5921542742717e3 --max-distance 2200.612154274272e3 \
--l-distr fixed --longitude 141.66653442382812 --latitude -4.952010154724121 --i-distr uniform \
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
