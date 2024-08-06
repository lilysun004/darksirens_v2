lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 16.907707707707708 --fixed-mass2 26.404684684684685 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1006087734.950266 \
--gps-end-time 1006094934.950266 \
--d-distr volume \
--min-distance 1105.913877895711e3 --max-distance 1105.933877895711e3 \
--l-distr fixed --longitude 136.1478271484375 --latitude 42.906490325927734 --i-distr uniform \
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
