lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 21.277997997997996 --fixed-mass2 49.85297297297298 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1009234508.930161 \
--gps-end-time 1009241708.930161 \
--d-distr volume \
--min-distance 1450.2421187347154e3 --max-distance 1450.2621187347154e3 \
--l-distr fixed --longitude 97.80653381347656 --latitude -36.55820083618164 --i-distr uniform \
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
