lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 26.992992992992992 --fixed-mass2 41.364524524524526 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1001104366.4411627 \
--gps-end-time 1001111566.4411627 \
--d-distr volume \
--min-distance 845.7459448096595e3 --max-distance 845.7659448096595e3 \
--l-distr fixed --longitude 111.33830261230469 --latitude 50.03347396850586 --i-distr uniform \
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
