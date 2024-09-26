lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 36.40592592592593 --fixed-mass2 28.16960960960961 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1009552367.1360371 \
--gps-end-time 1009559567.1360371 \
--d-distr volume \
--min-distance 1171.5674601124626e3 --max-distance 1171.5874601124626e3 \
--l-distr fixed --longitude -175.16799926757812 --latitude 55.94713592529297 --i-distr uniform \
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
