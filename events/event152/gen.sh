lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 6.57029029029029 --fixed-mass2 45.06246246246246 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1022190305.6907884 \
--gps-end-time 1022197505.6907884 \
--d-distr volume \
--min-distance 723.4974221892472e3 --max-distance 723.5174221892472e3 \
--l-distr fixed --longitude 15.362642288208008 --latitude -78.81224822998047 --i-distr uniform \
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
